Return-Path: <netdev+bounces-138149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7E9AC6A6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6731284298
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4147F158D96;
	Wed, 23 Oct 2024 09:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B817482;
	Wed, 23 Oct 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675971; cv=none; b=vGOc8O0KiKSXiJynNtSD/79nQbb3IUaUkMXKEqEXrlevzDPre+3eIXDBFPWUAIPuKVSO43crqnEB0cAcVQayvbFzMcE3hDIrEWQIoBPCTfJQOadTrPP5NNqo/ghGsBIB/9U4roCbErW6gDOByogk+MKaB2NBl/A7dp8D8iJbB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675971; c=relaxed/simple;
	bh=RDKp+cC6f0vBPc9Rs4zB1BXnjm0QsbXQpdHi78lhOeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXLzZselvziEjqIl4iO88j97yzdQIpCPY/laEyz3E92asLKhF0ICUycKpvDhk8UADa052YjRXZmjyWUGfK09A7TMgrGe1okGJUYyiRt9tbzenJii883d4+3fUzCewxuWKEuNy5RyG4xxtlqgK721FSSX4tIRvejtbNgrx8HHZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso1028637766b.1;
        Wed, 23 Oct 2024 02:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675968; x=1730280768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA1aNRKIv9LKRf5h3iTBzQVuBp6KyD5eyeAtjUFN4yk=;
        b=s+TIsprNZ+HO49moQtojbwjpd/Kw7DhJBWE12mdvhA94xiGon23Okv0pkwGlpA/t1q
         dH2KaoC7rdR6vgZQHT9LvIu4AlbGuv3/Ug/FmITvVxnkBGZCeoj/OMnMCWrKLEb04K2V
         Ikcegf0dawjcvhkaxpTu8OhH6950gXhmm0QKqFd+/lCFmOS7tSak+YKT4qTCn66OjHVg
         TBN4zsFXJ7xGcEnL2iuDE/XG8rI+xhKd3fu2IRc/zdCE5u/G5zgCiKUhUsrAdoZILOa7
         JOgwx7aaeIWifmuLUB0vXc7Dn5n02VTBM0eLqoVorjNUNzrqPw0s0sNt5Xd0ymgrxSyU
         hTOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsb9QhrytKXFH0XyfxspNNMWqsra5szjqvcT7xybVP+NYie0Cgq+csB1S/v1ay44mPgau8hVn5r50=@vger.kernel.org, AJvYcCWfO10creutSoyZwbcKyT/4pNflr+66+HLcZbQlwUH/1LBqhS7o4I4KCneAyB03CBS7i2TBvc/D@vger.kernel.org, AJvYcCXEonkWRqwBG/qdAL/4hGdb8UYT5rKh2JIrCf7nRcXKFZL6B2lpS4DWy3nU+FHofxER0zSLkTw4dvKamL/B@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlNN/7dQ8ITl3jyQZQfTzgIt0aIgBANCWe++uK3Xv2w0iw/Kf
	pcooBSORWKnTW+tggbvH6VKQgwtp3OSITz2i772NxRuJjyQvBApY
X-Google-Smtp-Source: AGHT+IE89Zd5uGE+DTW0CJ/Bm77xvlUsGAIrwG9wSA/yHi3JOelxCxGWF4hcaNLRvpcdXmWWlcpC+Q==
X-Received: by 2002:a17:907:ea0:b0:a99:4162:4e42 with SMTP id a640c23a62f3a-a9abf8ac2acmr145284466b.37.1729675967704;
        Wed, 23 Oct 2024 02:32:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d893csm454660066b.16.2024.10.23.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:32:47 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:32:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241023-refined-precious-seahorse-52e0d9@leitao>
References: <20241014135015.3506392-1-leitao@debian.org>
 <ZxZKkY8U4jndx8no@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZKkY8U4jndx8no@archie.me>

Hello Bagas,

On Mon, Oct 21, 2024 at 07:35:29PM +0700, Bagas Sanjaya wrote:
> On Mon, Oct 14, 2024 at 06:50:00AM -0700, Breno Leitao wrote:
> > +  To select the interface to act on, write the network name to the following file:
> > +  `/sys/kernel/debug/fail_net_force_skb_realloc/devname`
> "... write the network name to /sys/kernel/debug/fail_net_force_skb_realloc/devname."
> > +  If this field is left empty (which is the default value), skb reallocation
> > +  will be forced on all network interfaces.
> > +
> > <snipped>...
> > +- /sys/kernel/debug/fail_net_force_skb_realloc/devname:
> > +
> > +        Specifies the network interface on which to force SKB reallocation.  If
> > +        left empty, SKB reallocation will be applied to all network interfaces.
> > +
> > +        Example usage:
> > +        # Force skb reallocation on eth0
> > +        echo "eth0" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
> > +
> > +        # Clear the selection and force skb reallocation on all interfaces
> > +        echo "" > /sys/kernel/debug/fail_net_force_skb_realloc/devname
> 
> The examples rendered as normal paragraph instead (and look like long-running
> sentences) so I wrap them in literal code blocks:

Thanks. I will update it, and send a new version.

