Return-Path: <netdev+bounces-118122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755D95099A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D911F21D9F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF71A08B8;
	Tue, 13 Aug 2024 15:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE91A08AB;
	Tue, 13 Aug 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564684; cv=none; b=hGxPuoKhBYhBMSJY03uijf/Zf/2c7lY5oL+sTQ3VrR0b65ZaTFR1oD3RT5BZOySUgXS5MpJWPAbASGCpXh4nLcg6gNcYKYcxiNZQo9sXvXfdgLBgyU54WEcZlnYw2duB+bEOSVv8sWXJjxAMXVC4STrlNczcJXlbBWoeiJ//8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564684; c=relaxed/simple;
	bh=NwNbrf8vyk0cQ+c5B2X8sNmPAnM/D0iMY1BoA8Eb9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg6QUxTX92Xmua2hM3GkJQUh+5C7W8RroyeQMLojPd7dqV5EvRKZJJMx+DLxAJDHAOzgljyopqRmxWpenf8xCMZUX1FpNSpqvUp4mRv9SWKMMxenWJ8YD0m/SqNHS1VoUQEZ8gHbu8nqWB8BIQhEYtjRkfGQ056j7J1qJtS+U18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so62352191fa.1;
        Tue, 13 Aug 2024 08:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564681; x=1724169481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSf70t9XpCK5iIbrD4iy0fziurLgLo486TifTDvrv8c=;
        b=GKxRZZbRzoRRKCu2eGgJS1YW0uYUeSZ6bo7cAgjCP/IRLd9R0nu+PQLO9CWLHj0cGd
         vDcos1DnL4ISqJg071OsrNUpXsaJH/zPNES8S5/Sij+ajsmKFoDNTQLhpM9nszQZazy1
         StT+NbmkJ4yqr48IJ6vDRd95yJmzushHTV7HoW+lxzV5nhmMXCOsqw8GhCgqM3+4gM0N
         qJRjSXpNHXN9mNvWbQA0px+PSSNE/i1sim3jWd8jEDcfziixhZb1U4StLwu/dyqkeE9l
         3xlFQ+5dYo39yo3FjCIv9jq0ZJ9CUA2VeWwtQZ2RbBYbrVmcvvwMUSM5dwjK+vl9ZWXU
         rTAA==
X-Forwarded-Encrypted: i=1; AJvYcCXysj12xMU7UfyHlj2N1+K4A1YnC/jwk2s1DgvrVWxeJrWnEvaIYLKl+Cw4L/uk/N/5HriPNDGvQ178a0d3ppK5J+VJdAywUK6N9ovlUqSWHSsaHvBNMYIvmlVzye4GjNz576uQ
X-Gm-Message-State: AOJu0Yy1Uki61260l6PSnv87isGbWV7cOPi49+u4jv5m5NztCJIOoL7K
	1/1+IxE03x63R7AWz6o6eWfzlG3xr0nxz9Ee4O9X4enCXQNp33xZ
X-Google-Smtp-Source: AGHT+IGKNz3GNvIY1G8qdlnpx5J4zf4Cy1AdZab+IoibU9hrggopiEst8Rc9BIBgxV5GIuiBOgx5SA==
X-Received: by 2002:a05:651c:544:b0:2ef:2332:5e63 with SMTP id 38308e7fff4ca-2f2b71569a3mr31462821fa.23.1723564680387;
        Tue, 13 Aug 2024 08:58:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-014.fbsv.net. [2a03:2880:30ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f5d3asm3040424a12.12.2024.08.13.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:57:59 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:57:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
Message-ID: <ZruChcqv1kdTdFtE@gmail.com>
References: <20240809161935.3129104-1-leitao@debian.org>
 <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>

Hello Paolo,

On Tue, Aug 13, 2024 at 01:55:27PM +0200, Paolo Abeni wrote:
> On 8/9/24 18:19, Breno Leitao wrote:> @@ -1304,8 +1308,6 @@ static int
> __init init_netconsole(void)
> >   		while ((target_config = strsep(&input, ";"))) {
> >   			nt = alloc_param_target(target_config, count);
> >   			if (IS_ERR(nt)) {
> > -				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> > -					continue;
> >   				err = PTR_ERR(nt);
> >   				goto fail;
> >   			}

First of all, thanks for the in-depth review and suggestion.


> AFAICS the above introduces a behavior change: if CONFIG_NETCONSOLE_DYNAMIC
> is enabled, and the options parsing fails for any targets in the command
> line, all the targets will be removed.
> 
> I think the old behavior is preferable - just skip the targets with wrong
> options.

Thinking about it again, and I think I agree with you here. I will
update.

> Side note: I think the error paths in __netpoll_setup() assume the struct
> netpoll will be freed in case of error, e.g. the device refcount is released
> but np->dev is not cleared, I fear we could hit a reference underflow on
> <setup error>, <disable>

That is a good catch, and I was even able to simulate it, by forcing two
errors:

Something as:

--- a/net/core/netpoll.c
	+++ b/net/core/netpoll.c
	@@ -637,7 +637,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
		}

		if (!ndev->npinfo) {
	-               npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
	+               npinfo = NULL;

	diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
	index 41a61fa88c32..2c6190808e75 100644
	--- a/drivers/net/netconsole.c
	+++ b/drivers/net/netconsole.c
	@@ -1327,12 +1330,17 @@ static int __init init_netconsole(void)
		}

		err = dynamic_netconsole_init();
	+       err = 1;
		if (err)
			goto undonotifier;

	
This caused the following issue:
	
	[   19.530831] netconsole: network logging stopped on interface eth0 as it unregistered
	[   19.531205] ref_tracker: reference already released.
	[   19.531426] ref_tracker: allocated in:
	[   19.531505]  netpoll_setup+0xfd/0x7f0
	[   19.531505]  init_netconsole+0x300/0x960
	....
	[   19.534532] ------------[ cut here ]------------
	[   19.534784] WARNING: CPU: 5 PID: 1 at lib/ref_tracker.c:255 ref_tracker_free+0x4e5/0x740
	[   19.535103] Modules linked in:
	....
	[   19.542116]  ? ref_tracker_free+0x4e5/0x740
	[   19.542286]  ? refcount_inc+0x40/0x40
	[   19.542571]  ? do_netpoll_cleanup+0x4e/0xb0
	[   19.542752]  ? netconsole_process_cleanups_core+0xcd/0x260
	[   19.542961]  ? netconsole_netdev_event+0x3ab/0x3e0
	[   19.543199]  ? unregister_netdevice_notifier+0x27c/0x2f0
	[   19.543456]  ? init_netconsole+0xe4/0x960
	[   19.543615]  ? do_one_initcall+0x1a8/0x5d0
	[   19.543764]  ? do_initcall_level+0x133/0x1e0
	[   19.543963]  ? do_initcalls+0x43/0x80
	....

That said, now, the list contains enabled and disabled targets. All the
disable targets have netpoll disabled, thus, we don't handle network
operations in the disabled targets.

This is my new proposal, based on your feedback, how does it look like?

Thanks for the in-depth review,
--breno

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 30b6aac08411..60325383ab6d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1008,6 +1008,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry_safe(nt, tmp, &target_list, list) {
+		if (!nt->enabled)
+			continue;
 		netconsole_target_get(nt);
 		if (nt->np.dev == dev) {
 			switch (event) {
@@ -1258,11 +1260,15 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 		goto fail;
 
 	err = netpoll_setup(&nt->np);
-	if (err)
+	if (!err)
+		nt->enabled = true;
+	else if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
+		/* only fail if dynamic reconfiguration is set,
+		 * otherwise, keep the target in the list, but disabled.
+		 */
 		goto fail;
 
 	populate_configfs_item(nt, cmdline_count);
-	nt->enabled = true;
 
 	return nt;
 
@@ -1274,7 +1280,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
-	netpoll_cleanup(&nt->np);
+	if (nt->enabled)
+		netpoll_cleanup(&nt->np);
 	kfree(nt);
 }
 

