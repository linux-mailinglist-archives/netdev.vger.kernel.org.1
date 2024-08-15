Return-Path: <netdev+bounces-118934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C89538DC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E60B24420
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A61B3F2F;
	Thu, 15 Aug 2024 17:16:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634844C8F;
	Thu, 15 Aug 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742205; cv=none; b=AKvG+mLLvFo5QltIdfi1RHCjER49JBXd3Bi8Db0NA+dxMS6nr2IE659FbO7BvI/+B3e33m4cUkRw8JXyHVQxBFpionTPHJBEwUjpr02H5Ym1/9IqMQdXR72CoRBEKcpVIqaU5MaeMQad9UibbbuVsmbmay0DP7Y5VJwl2Bk6L/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742205; c=relaxed/simple;
	bh=erUpeLz82r4Ph66DJ0DdwbbnltaVlig3KPhb9Nr43ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idcyukp8j37sOPKHcbpVAo5Mng4JT8nGMX/hes76c3Wl7oljDw3RS6ki3zJjlq3w+ArPIcCeSYMhzE/JbLOKSSTqKUp/wYAQYbmP9KvJ9QAOakBLlKkAPswZF+Kegy5gueT6xHiJw57C9/BYudCW+bXdLw6XGaXxdeVihWLjK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so11349941fa.0;
        Thu, 15 Aug 2024 10:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742202; x=1724347002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1acgwdzuQavaTkudkaNqVLoYXuPY+97hrZpHfS25JRc=;
        b=Kel+9qjUSfdd8tHEhw63SCgE1fea1K05d0pe5eHq8qWTl7yH/MJA1SaE6VRsM0O/Hp
         A2c0N4rEkd2fMS3AqC+1B6NpaHHN7bM5/+Xp1GlEAI5l/mIppgR2XGbt7YNbgkwv46BF
         r7FzTdkUpVD+VdSRjdynvw1f+ykRNhVxBeg0QfbKnpi5S4qZ3W2GZtmrVTE4pMG7barR
         FP2tBkR1rPOmeNOg6aVo8/V0GN7iOeVfoAuoocKtmVvDuGs1xo6twoi4U39CxfnVCHZS
         G/tWUyKuR4eJKNlaC2sc5WmKw/z995ipTopK+S7O7o6to6n6c7+Ec034EoGX+Ik+J4dW
         hP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaExUFUNfaheRDn2Fa3jo7uf5vJmBfyR3/ulO5S/vD+7VA0VfM6yOo6E9HTwRDWSonf8r3b0/SXuA6ZTkuWAR2y9LME04OstmcQXrE6xvpr7u6QRSA27hEoteISIOX+QpU7OWk
X-Gm-Message-State: AOJu0Yx9O1sCCRnytwlg601bxwqU5VzETm0vea/w30xUHK4DxQYCpfJW
	xBuYCYp7adAs3/u2TyAh0Qz/w1r+jDikey7J0wo5GDyOWY8hVomOHlOSHQ==
X-Google-Smtp-Source: AGHT+IGdIeIC7OuARY3ceJeAlSY607DekmkrGmQ3dh99rOYbCKLJ+XEVpUMGaONTwMfs/fKFf5jK+g==
X-Received: by 2002:a05:6512:1111:b0:530:db85:e02a with SMTP id 2adb3069b0e04-5331c6aeebamr76046e87.22.1723742201157;
        Thu, 15 Aug 2024 10:16:41 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839693ccsm128699466b.190.2024.08.15.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:16:40 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:16:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
Message-ID: <Zr439qrX/fQufPY2@gmail.com>
References: <20240809161935.3129104-1-leitao@debian.org>
 <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
 <ZruChcqv1kdTdFtE@gmail.com>
 <2e63b0aa-5394-4a4b-ab7f-0550a5faa342@redhat.com>
 <Zr4GxjRf5la7wBXM@gmail.com>
 <2cf128ed-cd74-4025-8ae8-28934abbf25a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf128ed-cd74-4025-8ae8-28934abbf25a@redhat.com>

On Thu, Aug 15, 2024 at 06:07:20PM +0200, Paolo Abeni wrote:
> On 8/15/24 15:46, Breno Leitao wrote:
> > On Wed, Aug 14, 2024 at 12:06:48PM +0200, Paolo Abeni wrote:
> > > I fear the late cleanup could still be dangerous - what if multiple,
> > > consecutive, enabled_store() on the same target fails?
> > > 
> > > I *think* it would be safer always zeroing np->dev in the error path of
> > > netpoll_setup().
> > > 
> > > It could be a separate patch for bisectability.
> > > 
> > > Side note: I additionally think that in the same error path we should
> > > conditionally clear np->local_ip.ip, if the previous code initialized such
> > > field, or we could get weird results if e.g.
> > > - a target uses eth0 with local_ip == 0
> > > - enabled_store() of such target fails e.g. due ndo_netpoll_setup() failure
> > > - address on eth0 changes for some reason
> > > - anoter enabled_store() is issued on the same target.
> > > 
> > > At this point the netpoll target should be wrongly using the old address.
> > 
> > Agree with you. I think we always want to keep struct netpoll objects
> > either initialized or unitialized, not keeping them half-baked.
> > 
> > How about the following patch:
> 
> Overall LGTM, a couple of minor comments below.
> 
> >      netpoll: Ensure clean state on setup failures
> >      Modify netpoll_setup() and __netpoll_setup() to ensure that the netpoll
> >      structure (np) is left in a clean state if setup fails for any reason.
> >      This prevents carrying over misconfigured fields in case of partial
> >      setup success.
> >      Key changes:
> >      - np->dev is now set only after successful setup, ensuring it's always
> >        NULL if netpoll is not configured or if netpoll_setup() fails.
> >      - np->local_ip is zeroed if netpoll setup doesn't complete successfully.
> >      - Added DEBUG_NET_WARN_ON_ONCE() checks to catch unexpected states.
> >      These changes improve the reliability of netpoll configuration, since it
> >      assures that the structure is fully initialized or totally unset.
> >      Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >      Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> > index a58ea724790c..348d76a51c20 100644
> > --- a/net/core/netpoll.c
> > +++ b/net/core/netpoll.c
> > @@ -626,12 +626,10 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
> >   	const struct net_device_ops *ops;
> >   	int err;
> > -	np->dev = ndev;
> > -	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
> > -
> > +	DEBUG_NET_WARN_ON_ONCE(np->dev);
> >   	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
> >   		np_err(np, "%s doesn't support polling, aborting\n",
> > -		       np->dev_name);
> > +		       ndev->name);
> >   		err = -ENOTSUPP;
> >   		goto out;
> >   	}
> > @@ -649,7 +647,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
> >   		refcount_set(&npinfo->refcnt, 1);
> > -		ops = np->dev->netdev_ops;
> > +		ops = ndev->netdev_ops;
> >   		if (ops->ndo_netpoll_setup) {
> >   			err = ops->ndo_netpoll_setup(ndev, npinfo);
> >   			if (err)
> > @@ -660,6 +658,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
> >   		refcount_inc(&npinfo->refcnt);
> >   	}
> > +	np->dev = ndev;
> > +	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
> >   	npinfo->netpoll = np;
> >   	/* last thing to do is link it to the net device structure */
> > @@ -681,6 +681,7 @@ int netpoll_setup(struct netpoll *np)
> >   	int err;
> >   	rtnl_lock();
> > +	DEBUG_NET_WARN_ON_ONCE(np->dev);
> 
> This looks redundant
> 
> >   	if (np->dev_name[0]) {
> >   		struct net *net = current->nsproxy->net_ns;
> >   		ndev = __dev_get_by_name(net, np->dev_name);
> > @@ -782,11 +783,14 @@ int netpoll_setup(struct netpoll *np)
> >   	err = __netpoll_setup(np, ndev);
> >   	if (err)
> > -		goto put;
> > +		goto clear_ip;
> >   	rtnl_unlock();
> >   	return 0;
> > +clear_ip:
> > +	memset(&np->local_ip, 0, sizeof(np->local_ip));
> 
> I think it would be better to clear the local_ip only if np->local_ip was
> set/initialized/filled by netpoll_setup() otherwise the sysfs contents could
> suddenly/unexpetedly change on failure.

Makes sense. I was not able to come up with any other solution other than
tracking the overwrite and checking it later, which is admittedly not
beautiful, but might do the job. Let me know if you think about
something more elegant.

	 int netpoll_setup(struct netpoll *np)
	 {
		struct net_device *ndev = NULL;
	+       bool ip_overwritten = false;
		struct in_device *in_dev;
		int err;

	@@ -740,6 +741,7 @@ int netpoll_setup(struct netpoll *np)
					goto put;
				}

	+                       ip_overwritten = true;
				np->local_ip.ip = ifa->ifa_local;
				np_info(np, "local IP %pI4\n", &np->local_ip.ip);
			} else {
	@@ -757,6 +759,7 @@ int netpoll_setup(struct netpoll *np)
						    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
							continue;
						np->local_ip.in6 = ifp->addr;
	+                                       ip_overwritten = true;
						err = 0;
						break;
					}
	@@ -787,6 +790,9 @@ int netpoll_setup(struct netpoll *np)
		return 0;

	 put:
	+       DEBUG_NET_WARN_ON_ONCE(np->dev);
	+       if (ip_overwritten)
	+               memset(&np->local_ip, 0, sizeof(np->local_ip));
		netdev_put(ndev, &np->dev_tracker);


I really appreciate your time helping me here!
--breno

