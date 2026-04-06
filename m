Return-Path: <netdev+bounces-275766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKclNPsz1GnMsAcAu9opvQ
	(envelope-from <netdev+bounces-275766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645523A7DF6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B49D730451EB
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434239FCC1;
	Mon,  6 Apr 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8jAkx5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164039F179
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514567; cv=none; b=k4tL55/qnWCqPj72Gl+MYZwk1ZUGF/O8Ja+mskJB8aZigVepfHms35L/a8QuKJ4uM2+jKpoBccRV//ZsbSu2rg4xMt1UffR90fqI9vf5TRuThMSUi40Dr89NMQfCXW5dvHjRk8A5j36o3SPAIrC6WJ5RatvnwiDm/uia1ayxxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514567; c=relaxed/simple;
	bh=LVxqEMqhWdq76kcJM1NeOGxHfgbldjWfrr7AdKo9egA=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:Subject:Content-Type; b=mCqZKqOAesXEgIid6MbsyRfUSYGd3V1r22rjni8eWIixb1SYwS6o07VQszM1AaoW4SlkbHGqT8fwR7APrY8PiEARIJhUFmXojQtNQtReJp1ObPWt8kWlHqhfivlaII1h/Dh0wJwKd1W9dYf+eKII2qi8ORBKZFWMrqz6OqohpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8jAkx5W; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-67c22b05346so2501615eaf.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775514565; x=1776119365; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:message-id:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXKQI7WgyKqGZBWGRa2uXVzTyFEOr8G0e8YRMrKRXCc=;
        b=c8jAkx5W/A+Ng0YIK0+zdiW60hcFhIAxYEX6J5DY9lwMTYX7KmkS+70V9Mb+oXjxj3
         BwYoqQOiHeQNv5xo0aJkivSnjez8GPn85yD1rKlV8lHT6FTLEU9j9FovmzzDJZiLbHjn
         cRowQ+oPDaZp+Ha1bJJBYVf2tI29kOC8txDXkXvUBDg/FkEf0X9dQ61g9F2PH7r3xfT5
         SyHT6bqANnLwOZ+MrLly0c0niitrlBO/gzt1NTZeBijD18xcoBwG99KhHC8J9kyKd1HV
         9+XZMMKfh093l3cnYZwZm7swevyRV0ybvqIKyiKcEIfkZziUSji+9VmrD+ZjQupYbIyw
         3NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514565; x=1776119365;
        h=subject:in-reply-to:cc:to:message-id:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXKQI7WgyKqGZBWGRa2uXVzTyFEOr8G0e8YRMrKRXCc=;
        b=K+A7zoeIux3Yji/hOSSx2upRhFqlioHS516w25u7MzxkirGHafmiz5xzBUsLg/+Dqd
         t4q9IjgjGz/SwLSvlnmcd0PK2NXZpmS8gepyhs4kh7dgXzkCFXr9oyVEN1K3OsvV/OAZ
         G6d51Eg/mpW2xzMcDp50ZmN5YWBUtkjdWyQMf93RM8L2jKb1KKqUN0qjqgZbFrnnoRIU
         p99ugEXIq32pTC2SH1iCk7z116e2RXoIXzyVOqgD8FiReaul29+SIoLYob9dZvXJxc/0
         M2F29duOWQlBomzqAdvu4UoYWqSVI8dJq7xExOdwZ5KPUgOzlzSSPgH5F9DfmcbkSpLa
         uiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcHDWdXrr1VvU4iBSi0L8mMCwUgY/tUc6ldDMkUtPWxGMAXsT6dnSrCElXk32Ud7BxItwFX3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeHCnjNS8CUBprjrG7ynjN2HCW5lz6DoZ61Fa1W/eoVXMa1Fx
	ljx9L8WctMs7X2e/C1XJ3H31KHVOaqBanYzeEKrfaOaV3yOlFOqRAGTH
X-Gm-Gg: AeBDievssLVzM0Q0dWHryQvPM6/qPW7QQztOeeo24mF7uVBjPvCGpJU7hGOh3+VCA7G
	uoghUUoxybAShEnSWGjCv+ZBAON1T4/Dav9t34p3OP0dS6WE11hQjUOL9Kp5EtviwuZjeyqo0jK
	iUUokEti+ypAoCApAYSdeCqIaCP4hc55ZhKvdJq+Bi5dCBQ7JJDSw39Ig6AkIIUtc3rLixWEAjp
	g46C5q07//po5U0dUs9xYE+6uiaGe4yuxKJmwVh5Zyi4/0qncZO1v/yKtHwyieFJppYUdSrMKia
	Dd7tGDuOXdMH5eRMERM1b+j0tc7TN5EMMVeEpTZWovhI2SGBlxipGy02xIXJr8ix2qHB53XYaio
	ho9AxjRwQp0P/T97VP61niimtzCTaRu0s6Sy2wsHnX5v2T9y/c/I/S2MeMkP7BWMOuPRQ/JFb6L
	UV0IZPhflN3IDnQbT45Q==
X-Received: by 2002:a05:6820:1c83:b0:67e:1b8b:862c with SMTP id 006d021491bc7-6821a14057cmr7653072eaf.0.1775514564994;
        Mon, 06 Apr 2026 15:29:24 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6823d419d09sm6837710eaf.15.2026.04.06.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:29:24 -0700 (PDT)
From: sdf.kernel@gmail.com
Date: Mon, 06 Apr 2026 15:29:24 -0700
Message-ID: <1762d78b034628249764138bee950a87.sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jv@jvosburgh.net
In-Reply-To: <20260404000606.2413916-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v5 03/14] net: move promiscuity handling into
 netdev_rx_mode_work (ddeab417d841)
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275766-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 645523A7DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: move promiscuity handling into netdev_rx_mode_work
> 
> This commit moves unicast promiscuity tracking into netdev_rx_mode_work so
> it runs under netdev_ops_lock instead of the addr_lock spinlock. It also
> changes ASSERT_RTNL() to netdev_ops_assert_locked() in several functions
> called from the work queue.
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0efac0c730077..08dac9c759996 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -9586,7 +9586,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
> >  	kuid_t uid;
> >  	kgid_t gid;
> >  
> > -	ASSERT_RTNL();
> > +	netdev_ops_assert_locked(dev);
> 
> Can this cause a lockdep assertion failure for unconverted ops-locked devices
> using the legacy RX mode path?

Correct and addressed later in the series in "net: warn ops-locked drivers
still using ndo_set_rx_mode". Don't think there is a better way to split
the patches...

> Replacing ASSERT_RTNL() with netdev_ops_assert_locked(dev) asserts that
> dev->lock is held for devices where netdev_need_ops_lock(dev) is true.
> 
> [ ... ]
> 
> > diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> > index a05db3ac43ea9..61589537b2d3d 100644
> > --- a/net/core/dev_addr_lists.c
> > +++ b/net/core/dev_addr_lists.c
> [ ... ]
> > @@ -1295,20 +1337,16 @@ void __dev_set_rx_mode(struct net_device *dev)
> >  	if (!netif_device_present(dev))
> >  		return;
> >  
> > -	if (ops->ndo_set_rx_mode_async) {
> > +	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
> >  		netif_rx_mode_queue(dev);
> >  		return;
> >  	}
> >  
> > -	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
> > -		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
> > -			__dev_set_promiscuity(dev, 1, false);
> > -			dev->uc_promisc = true;
> > -		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
> > -			__dev_set_promiscuity(dev, -1, false);
> > -			dev->uc_promisc = false;
> > -		}
> > -	}
> > +	/* Legacy path for non-ops-locked HW devices. */
> > +
> > +	promisc_inc = netif_uc_promisc_update(dev);
> > +	if (promisc_inc)
> > +		__dev_set_promiscuity(dev, promisc_inc, false);
> 
> If an ops-locked device has not yet been converted to implement the new
> ndo_set_rx_mode_async or ndo_change_rx_flags callbacks, this legacy path
> will be executed.

Same here, addressed later in the series in "net: warn ops-locked drivers
still using ndo_set_rx_mode".

> 
> When a secondary unicast address is added to such a device (e.g., by
> bringing up a macvlan interface over it) and the device lacks
> IFF_UNICAST_FLT, netif_uc_promisc_update() returns 1. This triggers a
> synchronous inline call to __dev_set_promiscuity(dev, 1, false).
> 
> Since __dev_set_rx_mode() is invoked from address list helpers like
> dev_uc_add() which only hold rtnl_lock() and netif_addr_lock_bh(dev),
> dev->lock is not held, which would trigger the new assertion in
> __dev_set_promiscuity().

Same.

