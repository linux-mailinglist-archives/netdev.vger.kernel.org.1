Return-Path: <netdev+bounces-140669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C855F9B77BC
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EA91F21BBD
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47061957E7;
	Thu, 31 Oct 2024 09:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237E1BD9D7;
	Thu, 31 Oct 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367686; cv=none; b=Y8Qo4uPEV6chLwdnBQqiKuCU1V1biLvdrgLF7bwnk3kqyuRkYXz4ocJaygvaDquckRrFcw3zorIy002nuvpB38w+8OkjYn+miYmeRTtja5BQLu454mIDwfVU2lW96907D2t4GmypZudUAh/4b8sHzFIiX26YT2z0sKPSVFnW9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367686; c=relaxed/simple;
	bh=txG8v2OtMMx1Fo0i5XM+jltjYAWWH+6tWU45ggqtooo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8lI/W3crm3ZuvRsaUrLFctkWOxCtE0eLe/H4JZzd4tAxhen1JQUm3xWkIC7jKlxVaYJGJs8Ffuqtl0AygU6lb7EcvD+b9LCZHesOpw3oZRkxREDsr9mfCtriMvYG2tZUT4A3XG/NnGMtqu4+sFKOw1FXTXMonUAajrvPZ8FUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a4031f69fso101699566b.0;
        Thu, 31 Oct 2024 02:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367683; x=1730972483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8YMe+HVyTJX0cz4Ucfp6CZUcxhiMf5Ln2/Nt+kpjOY=;
        b=sPujmo7I4Y04QhCp3Zuyyvh2o4NFhODNwGAvTLGgtSMUj7B/3DqRdtpUImaUZt15tM
         ll4rAlWOQwd8UkWyOUjAPcvIyxKyK5I381h1YTlZLHyOt9jIawvvAX6qeGAaYx04gvE1
         tMRbjvhS3FDJrmsCxDDygmXEjNi73xnOkU+hBiWsCDeqeV1MTygyplFKnVe31IR4FEoJ
         O3n0GsNKxpCfXZ0gF7v/J9Alhr2d5fqFZKf4yn9N1I2WNhfTXG0QBwLv9tGn4XddOmO5
         601BfdiEcGUIw5aJKvwdCuYQkiDhGV3EIJV1/P0HAx0ERCzejqmpko7V3+myDIUxnqZ8
         kasA==
X-Forwarded-Encrypted: i=1; AJvYcCVMb79/rLBpRxqZhrS2MymODnP0UPzzkqDBCWTDPDTZ23iZlE1XrZ/5BBX3NEH6IWn53iDAOpwFLiyGJ0YQ@vger.kernel.org, AJvYcCWd2oDxu3PWCqD/bd+AimZGgafOFIpbK2C7IIPF080xiLyDWnUmkjut3hhA+4y48kuHmx1ps0Xr@vger.kernel.org, AJvYcCXpkSsRgZja0vKcR8S/3aPZeOSHVhW17iTaoRbbL+qxfKnAr+/eZAYpw8JzS6BVEtvgF6g4j+FY5PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcCQEVbl60Po+z0J4VtRehJhf4uEtwHxrieEa7Alu45gYT6ro
	IfZh+HZIukhTSOmnKuL5jlIKxWVplzbGOPetImjw0maZjynh7YaL
X-Google-Smtp-Source: AGHT+IFxi7l2UNspW21BnqrIkXzWdf8TMP0a8bF0HOME3IbPCK1Ie4/exTacUAQr+3FbeB3nPl2SEg==
X-Received: by 2002:a17:906:c14d:b0:a99:fe71:bd76 with SMTP id a640c23a62f3a-a9de5ee3295mr1724290666b.34.1730367681921;
        Thu, 31 Oct 2024 02:41:21 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564942c8sm46481066b.28.2024.10.31.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:41:21 -0700 (PDT)
Date: Thu, 31 Oct 2024 02:41:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	Thomas Huth <thuth@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241031-hallowed-bizarre-curassow-ea16cc@leitao>
References: <20241023113819.3395078-1-leitao@debian.org>
 <20241030173152.0349b466@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030173152.0349b466@kernel.org>

Hello Jakub,

On Wed, Oct 30, 2024 at 05:31:52PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Oct 2024 04:38:01 -0700 Breno Leitao wrote:

> > +  no longer reference valid memory locations. This deliberate invalidation
> > +  helps expose code paths where proper pointer updating is neglected after a
> > +  reallocation event.
> > +
> > +  By creating these controlled fault scenarios, the system can catch instances
> > +  where stale pointers are used, potentially leading to memory corruption or
> > +  system instability.
> > +
> > +  To select the interface to act on, write the network name to the following file:
> > +  `/sys/kernel/debug/fail_skb_realloc/devname`
> > +  If this field is left empty (which is the default value), skb reallocation
> > +  will be forced on all network interfaces.
> 
> Should we mention here that KASAN or some such is needed to catch 
> the bugs? Chances are the resulting UAF will not crash and go unnoticed
> without KASAN.

What about adding something like this in the fail_skb_realloc section in
the fault-injection.rst file:


	The effectiveness of this fault detection is enhanced when KASAN is
	enabled, as it helps identify invalid memory references and
	use-after-free (UAF) issues.


> > --- /dev/null
> > +++ b/net/core/skb_fault_injection.c
> > @@ -0,0 +1,103 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/fault-inject.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/skbuff.h>
> 
> alphabetic sort, please?

I thought I should use the reverse xmas tree structure. I will re-order
them alphabetically.

> > +static void reset_settings(void)
> > +{
> > +	skb_realloc.filtered = false;
> > +	memzero_explicit(&skb_realloc.devname, IFNAMSIZ);
> 
> why _explicit ?

I thought the extra barrier would be helpful, but, it might not. I will
change it to a regular memset() if you think it is better.

> > +static ssize_t devname_write(struct file *file, const char __user *buffer,
> > +			     size_t count, loff_t *ppos)
> > +{
> > +	ssize_t ret;
> > +
> > +	reset_settings();
> > +	ret = simple_write_to_buffer(&skb_realloc.devname, IFNAMSIZ,
> > +				     ppos, buffer, count);
> > +	if (ret < 0)
> > +		return ret;
> 
> the buffer needs to be null terminated, like:
> 
> skb_realloc.devname[IFNAMSIZ - 1] = '\0';
> 
> no?

Yes, but isn't it what the next line do, with strim()?

> > +	strim(skb_realloc.devname);
> > +
> > +	if (strnlen(skb_realloc.devname, IFNAMSIZ))
> > +		skb_realloc.filtered = true;
> > +
> > +	return count;
> > +}

Thanks for the review!
--breno

