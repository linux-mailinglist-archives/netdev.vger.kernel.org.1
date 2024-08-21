Return-Path: <netdev+bounces-120464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E39597B7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F43B20DBF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2111531D3;
	Wed, 21 Aug 2024 08:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C011531CD;
	Wed, 21 Aug 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229722; cv=none; b=W1A4IjXdDh39Kg0DfCBvbJF8Hvc8GuCmCyEzKlFJWHDKw9g4oF7rse9UJE+elBYwiZQ/EHSyR6fJAfL81IiNu/kxlHC/yk2U244m9hHjWn6OgH4FtwjiSUU5Qno/du3q7PAY+KBNWktjINEXUOeKf3qua5X0Q2zcroWaFiGIFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229722; c=relaxed/simple;
	bh=Td18FLmR7HFncxG+g6kGM2FF1lR0vn3fIVd/hsuWYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuRA8gUYsApgA5cVy1fOZfJxG3hAew8gqu6BTlhYgmoqrqeXTsFdhtOG8j7e9JlOIrAt2cwK+pmwuW0vXXi6pYg6MVF2cSRs8O0szoAb6xQAYV9pN7BOZCTu6VpO/Q1rwRvu0/qMpKXGcu/rVLqG1UOBqZ/FfAk+SIpsw23tpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso951135a12.1;
        Wed, 21 Aug 2024 01:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229719; x=1724834519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQghddWb20ERYZlxq4b38vXwXY5jZT1Kf3LesosRVW0=;
        b=Kqp9bMngYpxwK/FVCqiEC1vVcfRA68EK54H92M1lOks6e/LiShHIGcbYD3R7QZ18hA
         xBMijnhKdMvak31zZWfRXOZVOhaiL8aoVRowYYzAtC6JvevgF9IpDvpU6QXnJs2d88mu
         abmnL4rCENPU9rUtXUdIn9biPZQlykkIfwT3NBIDEizjzEw33xmalMnuFmP8wv6zLZDU
         wXGTPz4lq+gtEgfs7t9lLzVuwGIA5/sVs+SQekBB3pPVNyt6gq7iTtcB9sEfj+VAeZeZ
         bZR9kQXmXC3wQC84UNuLvgPSfK40ahgzs51bzyw+qMgdIoczQWrZRpifOyzZKUj6DHmU
         FcnA==
X-Forwarded-Encrypted: i=1; AJvYcCWwl5r9CL6LZ2jVAymUmXnMmO9XPYf1p/MycoKBjH+q1WXzvzG889qSOavj8tQFKpimlm8e3+DBdxpot3E=@vger.kernel.org, AJvYcCXclM3Axtuxk+hfgz+cmFv14hrkEAlVknE88UttdxxzHCY2PWJnYgqmdM1+OPkUWieW5+Tjin1b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3hI0+lhDgCA0DCwRwDu8yq4i6XrecbFnpQE3yQjYwMYLrhpb
	vKxoZ9xtZPkCTWNdFXgP8fDeKaAEAvD1iNwvmcrwZXXudca1sS+N
X-Google-Smtp-Source: AGHT+IFhFATFhupplBDZFSeR/8oSDfM8ss+KGbYJbWTKlETD4aeOmd0DVTyKJ9fv0vRVMkS0Up4ZDQ==
X-Received: by 2002:a05:6402:2709:b0:5be:ddd8:e3ea with SMTP id 4fb4d7f45d1cf-5bf1e6e7d98mr1585119a12.9.1724229718147;
        Wed, 21 Aug 2024 01:41:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa494sm7788603a12.46.2024.08.21.01.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:41:57 -0700 (PDT)
Date: Wed, 21 Aug 2024 01:41:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] netconsole: pr_err() when netpoll_setup
 fails
Message-ID: <ZsWoUzyK5du9Ffl+@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
 <20240819103616.2260006-3-leitao@debian.org>
 <20240820162409.62a222a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820162409.62a222a8@kernel.org>

On Tue, Aug 20, 2024 at 04:24:09PM -0700, Jakub Kicinski wrote:
> On Mon, 19 Aug 2024 03:36:12 -0700 Breno Leitao wrote:
> > netpoll_setup() can fail in several ways, some of which print an error
> > message, while others simply return without any message. For example,
> > __netpoll_setup() returns in a few places without printing anything.
> > 
> > To address this issue, modify the code to print an error message on
> > netconsole if the target is not enabled. This will help us identify and
> > troubleshoot netcnsole issues related to netpoll setup failures
> > more easily.
> 
> Only if memory allocation fails, it seems, and memory allocation
> failures with GFP_KERNEL will be quite noisy.

Or anything that fails in ->ndo_netpoll_setup() and doesn't print
anything else.

Do you think this is useless?

> BTW I looked thru 4 random implementations of ndo_netpoll_setup
> and they look almost identical :S Perhaps they can be refactored?

correct.  This should be refactored.

In fact, since you opened this topic, there are a few things that also
come to my mind

1) Possible reduce refill_skb() work in the critical path (UDP send
path), moving it to a workqueue?

When sending a message, netpoll tries fill the whole skb poll, and then try to
allocate a new skb before sending the packet. 

netconsole needs to write a message, which calls netpoll_send_udp()

	send_ext_msg_udp() {
		netpoll_send_udp() {
			refill_skbs() {
				while (skb_pool.qlen < MAX_SKBS) {
					skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
				}
			}
			skb = alloc_skb(len, GFP_ATOMIC);
				if (!skb)
					skb = skb_dequeue(&skb_pool);
			}
		}
	}
		
Would it be better if the hot path just get one of the skbs from the
pool, and refill it in a workqueue? If the skb_poll() is empty, then
alloc_skb(len, GFP_ATOMIC) !?


2) Report statistic back from netpoll_send_udp(). netpoll_send_skb()
return values are being discarded, so, it is hard to know if the packet
was transmitted or got something as NET_XMIT_DROP, NETDEV_TX_BUSY,
NETDEV_TX_OK.

It is unclear where this should be reported two. Maybe a configfs entry?




