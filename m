Return-Path: <netdev+bounces-118851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A19530D3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9961C231AE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052B19EED7;
	Thu, 15 Aug 2024 13:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423619E7FA;
	Thu, 15 Aug 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729612; cv=none; b=ulPQtro8oND+dqGswYwwY3yaRv62nR8OoNU5UiMOP9hsBCLQOyNjmuQIUy7JzNWNENtJJ1Y5Vr1pR76hezKF8oE19z5xRshS4WP79bFl3EoGVu0s7N6X6tQbRtM74OfvC+J2sPk+4s70uMnGj7Uc0O8U4q6inKqtlqn7CkhJ0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729612; c=relaxed/simple;
	bh=S86TgXyt5SfcDqrSJI2qE91Svt7zJWH3v7zRODuOzF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npYcuOYSBEv+HRELsffWcn1yS0mMAXi9MTQqcHnBEpT8cwm7RTiKpS/W8ucrftO0eqW2OAzfE1OpHVMAj78+i0gEBg30iWQrGhIgjMZQ4bjRZrPbkWAHzx2y1JfEqRfoRWQ4miciR3WFN5kXiQY4fYvjXwvVL7J8QvQhF50Ppo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aada2358fso310030266b.0;
        Thu, 15 Aug 2024 06:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729609; x=1724334409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5eFHzHa6GoclssIdYfS63Y7EsY0Uan6FkAjR5XLXkM=;
        b=OHPXu1/V+QMvPsX1pubiYwkWkNIuXSgT7VHXihWTYKp221wtzdsjAn359daHs+SoBq
         XQv7LzPQOwXE99jVO18zL5zl+GtIEu1YCId9gdrFTP1ZVV+Ok8Lji6w6NdCQ/u3iiRE3
         dPTav2zki/Ed0GzksOrcPJaKtPcoEIHxoGWE5y6vT1qSwFRxWDBXQ/srm52FxlrDignM
         zSZA7eTeONYkmyoTyfS8oDkUeKdNBf4Az4QSzuESJpVtIUm15iKNzgH2wk8eB8DT5sxe
         kN75eoVcdy45/tVP3B6wWxFJC7KU871hXKhK5CF+eE/66B0XXm/i6/1TL5lEv6cFG4CO
         UMIg==
X-Forwarded-Encrypted: i=1; AJvYcCXVBS16tBsasoQ6rCQ32f8lBQWnxouKKd1zZPMXUgO8CNPpMmU8gbUM+bEosAiWPlKxxPr3/ZjVaiB8svs35xMy95AzuT1Q0wRu2KHMrRvX8BZI9weWOweXoihQvTdnSa5QZl0g
X-Gm-Message-State: AOJu0Ywh5UcPqbCFtJcM2o/PhsEBBvQE1V8QLVtoOqcM4pTilQb1uouv
	RY+TDUFnfGlEdREy1MLp7y9SYziZniz+f0WGHZSbtOXaupJ0lhY2
X-Google-Smtp-Source: AGHT+IGQQLU4qIMup/R6jYXsXlIwkCuUdOSRZrm71eJiTvZccpyGmRtC+a9plsbVobrTZKFCWFM/Vg==
X-Received: by 2002:a17:907:d3c4:b0:a7a:b561:358e with SMTP id a640c23a62f3a-a837cd6af9amr322903566b.33.1723729608878;
        Thu, 15 Aug 2024 06:46:48 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396cfa5sm103593566b.207.2024.08.15.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:46:48 -0700 (PDT)
Date: Thu, 15 Aug 2024 06:46:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
Message-ID: <Zr4GxjRf5la7wBXM@gmail.com>
References: <20240809161935.3129104-1-leitao@debian.org>
 <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
 <ZruChcqv1kdTdFtE@gmail.com>
 <2e63b0aa-5394-4a4b-ab7f-0550a5faa342@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e63b0aa-5394-4a4b-ab7f-0550a5faa342@redhat.com>

On Wed, Aug 14, 2024 at 12:06:48PM +0200, Paolo Abeni wrote:
> I fear the late cleanup could still be dangerous - what if multiple,
> consecutive, enabled_store() on the same target fails?
> 
> I *think* it would be safer always zeroing np->dev in the error path of
> netpoll_setup().
> 
> It could be a separate patch for bisectability.
> 
> Side note: I additionally think that in the same error path we should
> conditionally clear np->local_ip.ip, if the previous code initialized such
> field, or we could get weird results if e.g.
> - a target uses eth0 with local_ip == 0
> - enabled_store() of such target fails e.g. due ndo_netpoll_setup() failure
> - address on eth0 changes for some reason
> - anoter enabled_store() is issued on the same target.
> 
> At this point the netpoll target should be wrongly using the old address.

Agree with you. I think we always want to keep struct netpoll objects
either initialized or unitialized, not keeping them half-baked.

How about the following patch:

    netpoll: Ensure clean state on setup failures
    
    Modify netpoll_setup() and __netpoll_setup() to ensure that the netpoll
    structure (np) is left in a clean state if setup fails for any reason.
    This prevents carrying over misconfigured fields in case of partial
    setup success.
    
    Key changes:
    - np->dev is now set only after successful setup, ensuring it's always
      NULL if netpoll is not configured or if netpoll_setup() fails.
    - np->local_ip is zeroed if netpoll setup doesn't complete successfully.
    - Added DEBUG_NET_WARN_ON_ONCE() checks to catch unexpected states.
    
    These changes improve the reliability of netpoll configuration, since it
    assures that the structure is fully initialized or totally unset.
    
    Suggested-by: Paolo Abeni <pabeni@redhat.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a58ea724790c..348d76a51c20 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,12 +626,10 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	np->dev = ndev;
-	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
-		       np->dev_name);
+		       ndev->name);
 		err = -ENOTSUPP;
 		goto out;
 	}
@@ -649,7 +647,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -660,6 +658,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -681,6 +681,7 @@ int netpoll_setup(struct netpoll *np)
 	int err;
 
 	rtnl_lock();
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
 		ndev = __dev_get_by_name(net, np->dev_name);
@@ -782,11 +783,14 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto put;
+		goto clear_ip;
 	rtnl_unlock();
 	return 0;
 
+clear_ip:
+	memset(&np->local_ip, 0, sizeof(np->local_ip));
 put:
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	netdev_put(ndev, &np->dev_tracker);
 unlock:
 	rtnl_unlock();

