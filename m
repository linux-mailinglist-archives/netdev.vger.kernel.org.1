Return-Path: <netdev+bounces-140989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B989B8FBE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61F9B20981
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70369168488;
	Fri,  1 Nov 2024 10:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196131D555;
	Fri,  1 Nov 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458326; cv=none; b=mdiR9vjN//c0HX1o8SPotglqUXuXKO0DI8g5vX1FLibQvqUu0voKPm3nP91J/hgqmMiSVaas8FMgVL6N2yL44kMpeA8LV4qRwSvIkoWb5KBeVGCvbQR5MKr6u8O/Pdhju/j6rSWO3NZy5p6r96dqbtGJuRLq1EeM4dvRwzpKrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458326; c=relaxed/simple;
	bh=TU8dGZ1eNu3Hk2l7gdb8rvSsxYs/ZIyWZjXgy6rwpOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeZvFws/UJ8Nr8a06N0kOq8ORrqthjoDGBx+cUs/1ednZmifTlyxEAf5Mp4dZ3kx+WqfOhMF5XCENFVrVBxq3d6LisExxR2ex6pXFk5CnfdtviJ5at3y6najuDtE1AEvQhU38X02L0OdO23p8PMdbz+dtfUE5WZ5eLWWoGa3Brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so2504043a12.2;
        Fri, 01 Nov 2024 03:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730458322; x=1731063122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKSTmHmFuYCAOmRQkPVmNmsckzHyWUaKkCyqHZXPrGs=;
        b=ddL6+9z5Al3UGD43DbudjthX8UqHq8eS9hQ3KnIhmdfAgxxMyGVBI1RatYQSD2XRdY
         Z836NuRZMZBxMiB20nXHFGPOk+TYjdu1G5NyYU3oLVxtX2hBDIBhhgKpMd9c7Up7MUYp
         8T8bbo2S/5eyss3woUBo1AJYq6iqp8cRYBMajIRafNKmSgG27VdAlr8nYsvAtF83trsH
         +A1Wl/TzGByMTk/icghlKtQKJ7xfXzAykRsFfTi984PV76ODdZudOGQkIGeXSFO8h54m
         EGctRucCPUBhRMnlQ+zOhsrGwbsVspNC3GmytHVs31gGPmy5RTAfQB9RbfkYBqhBC99V
         +bqA==
X-Forwarded-Encrypted: i=1; AJvYcCU/nLH1dRsGYI9Yl7Hsc8BKeuwRnb13P38dOViapKr2qlWjh2sQSQDMFFnMBI5qOVE7Zoo9xUtx@vger.kernel.org, AJvYcCVWUbB2jwg6HS9XwQ0J5RD35+OB4gpGF2C3Fw8kQXRVzhc61mlnT9r5nlLqfA1bF/sFdXcnlf45AjTLeUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvG+Ud8PrKrt2KoN13bMPIme8JLApIuBvHuKfS+z0FZV9JM/ja
	mDYBqwloaui8ZELNG3zj6x0AWX1L4Y+o/0IelPKyICiAaXlyRT1E
X-Google-Smtp-Source: AGHT+IFubAKraTfHDTY8/bsTKvjr2pLAaf81VaTF4emfdFHq5lkd6fNtjX4Nf6nK6nHQNB7C3rtr0Q==
X-Received: by 2002:a17:907:7dac:b0:a9a:81a3:59bf with SMTP id a640c23a62f3a-a9e5093f631mr543618266b.35.1730458322095;
        Fri, 01 Nov 2024 03:52:02 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56643823sm167683066b.167.2024.11.01.03.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:52:01 -0700 (PDT)
Date: Fri, 1 Nov 2024 03:51:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241101-cheerful-pretty-wapiti-d5f69e@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-2-leitao@debian.org>
 <20241031182647.3fbb2ac4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031182647.3fbb2ac4@kernel.org>

Hello Jakub,

On Thu, Oct 31, 2024 at 06:26:47PM -0700, Jakub Kicinski wrote:
> On Fri, 25 Oct 2024 07:20:18 -0700 Breno Leitao wrote:
> > The current implementation has a flaw where it populates the skb_pool
> > with 32 SKBs before calling __netpoll_setup(). If the setup fails, the
> > skb_pool buffer will persist indefinitely and never be cleaned up.
> > 
> > This change moves the skb_pool population to after the successful
> > completion of __netpoll_setup(), ensuring that the buffers are not
> > unnecessarily retained. Additionally, this modification alleviates rtnl
> > lock pressure by allowing the buffer filling to occur outside of the
> > lock.
> 
> arguably if the setup succeeds there would now be a window of time
> where np is active but pool is empty.

I am not convinced this is a problem. Given that netpoll_setup() is only
called from netconsole.

In netconsole, a target is not enabled (as in sending packets) until the
netconsole target is, in fact, enabled. (nt->enabled = true). Enabling
the target(nt) only happen after netpoll_setup() returns successfully.

Example:

	static void write_ext_msg(struct console *con, const char *msg,
				  unsigned int len)
	{
		...
		list_for_each_entry(nt, &target_list, list)
			if (nt->extended && nt->enabled && netif_running(nt->np.dev))
				send_ext_msg_udp(nt, msg, len);

So, back to your point, the netpoll interface will be up, but, not used
at all.

On top of that, two other considerations:

 * If the netpoll target is used without the buffer, it is not a big
deal, since refill_skbs() is called, independently if the pool is full
or not. (Which is not ideal and I eventually want to improve it).

Anyway, this is how the code works today:


	void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
	{
		...
		skb = find_skb(np, total_len + np->dev->needed_tailroom,...
		// transmit the skb
		

	static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
	{
		...
		refill_skbs(np);
		skb = alloc_skb(len, GFP_ATOMIC);
		if (!skb)
			skb = skb_dequeue(&np->skb_pool);
		...
		// return the skb

So, even in there is a transmission in-between enabling the netpoll
target and not populating the pool (which is NOT the case in the code
today), it would not be a problem, given that netpoll_send_udp() will
call refill_skbs() anyway.

I have an in-development patch to improve it, by deferring this to a
workthread, mainly because this whole allocation dance is done with a
bunch of locks held, including printk/console lock.

I think that a best mechanism might be something like:

 * If find_skb() needs to consume from the pool (which is rare, only
when alloc_skb() fails), raise workthread that tries to repopulate the
pool in the background. 

 * Eventually avoid alloc_skb() first, and getting directly from the
   pool first, if the pool is depleted, try to alloc_skb(GPF_ATOMIC).
   This might make the code faster, but, I don't have data yet.

   This might also required a netpool reconfigurable of pool size. Today
   it is hardcoded (#define MAX_SKBS 32). This current patchset is the
   first step to individualize the pool, then, we can have a field in
   struct netpoll that specify what is the pool size (32 by default),
   but user configuration.

   On netconsole, we can do it using the configfs fields.

Anyway, are these ideas too crazy?

