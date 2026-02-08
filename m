Return-Path: <netdev+bounces-257865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NlHCjILiWmw1gQAu9opvQ
	(envelope-from <netdev+bounces-257865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A671D10A6A2
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F7CE3005664
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4A2F8BD3;
	Sun,  8 Feb 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="j05BJzY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306122F01
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770588972; cv=pass; b=mI5XIGn1oHgEMyZYZiIkI240ohr/PEowNf0SBuoRTloJgE3IiceYJzQY5wfhJJiX6UWhzjggGQ7IIcORbyo34mLlWo515ERqzVu1t9RyxOJrL0D0tugKwJdUFFifF1bAn8+1VwrVqWpFVp0rGUpMEygWmPt0DhRf7GhMf+nebvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770588972; c=relaxed/simple;
	bh=udmuaWKW4YuN6eJwRqcDvTLjhyUWCxgC1YwduV1EnYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBc/GSmfPumhdVDCKIcDipwRM8RaB10J6lm38QTRl20MNjhxDX3ZfnDX0XBPkQMBdEeG4neRxkeD+Gsn2fcMpqlvSKVTLau95c9fb8fqjaPenxm5NX4nstIfg4BGg4dHk1FHdZZCaq7AbhDJqnOs/5imlWY11XaZnS+JVaHK5rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=j05BJzY4; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d18cf89e72so2980222a34.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 14:16:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770588971; cv=none;
        d=google.com; s=arc-20240605;
        b=j2A5lfEYItsLJo49O21D61xXje9E8s26fEtZTnnYZGXQq6mHTWwiTuMhJExCJFs3GI
         eAiXBON4gCbQ1weJwM/2g6/BEWpcc7gJWLxL+FqeHv51pXoeNUnTno+I7l0Qb/8ftIKs
         cdsq7nsq5lXqGa/zuOHEpz7GFy8xR97puynOICluT/qYwfkzACVfu65Yb6kYIePpPFuT
         +KTKQDGPBwFlmv2RQX0T7YUV2GDZick2DwWa07YGOj7WavQBxFS986hxp2m+5M0IWH76
         EtgQMSC2uXRcmgL1pQuUkhG56LIhxhd2yqLyLbQ6zF3yM5t7pckI7SsUN7g/g//NNEFL
         y9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aunIiNex6Rcyk8ghbDCdtKKYw6izLmYawktzWY900O0=;
        fh=wNub1itgJQfDWt2rlqBJ/zGhg1eyX30ZplZ0i6Ml594=;
        b=krL2Do82PwN57aDzyqqHR1OdHvMhWMH49OJkmKgI6qt6Z+hn8/mqDS/S88UZlMHcxX
         rxvvrKMvqqN+BwhAMSi2a6LGw6Mx0ZK5hFZdK76qhg3MhqPoRFRb2gRVObegt7y+T0sL
         9PgVWE16wX+GjNMAPtXby1FckXxI9EIRgsb4CwZ2J+E8qekqUgB2rLr5a5E/owuQcTMo
         Tqvrnlyks7QLjHk1ERxedWIy1PSD+Uth7x6ZMuTG+MLP2C+vBZOP6jfi1fatchmh5BAx
         ImlAjh0TkerCuQc4zDuW790liC+/+z9ubvJugj6l3t0vUm9Ygq/9yAigxuElgKPAZCQE
         0kYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770588971; x=1771193771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aunIiNex6Rcyk8ghbDCdtKKYw6izLmYawktzWY900O0=;
        b=j05BJzY40KmgdJFCN1LKIXBksKa8eYque2C/+12PqaJhd8YoiWf8k3a6uSoIfwuYWN
         UQGSUsNH3hL24pjGaqPqUnqvcmKdel9FTI/DHWlmkRa4HpbSonJ9gO4lnT0YaqfHsk0u
         HVjCidV4xQ5TCYRHhkQsKV90SMlSVJMULyx41hS4XFDOcdMTMxRf1mt8zBAuHU0nzUYJ
         pYNsd+KK4bAgcqQPi9RjrtadLqJIsCJIzA66IXOnLQWksAO0789SCS0G6lFS+CVDfIKN
         dbigNOQeseWNvNruWiYu4naUEzOHp7L8VRScmFiT9PMK51A2x87i4EnCG/yPo5kuSaUf
         T3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770588971; x=1771193771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aunIiNex6Rcyk8ghbDCdtKKYw6izLmYawktzWY900O0=;
        b=Fo+ZicU2MgB15DbTpTiISf/DlqDbQv3aHdxNFoMlPlV1T25Z4Gqw8wvKRLZ8rGscjl
         xU7b+Q5n+XPd7lPwgvdU1cayIGJdD9NHkPJcdGjWnZSOljln7DJZ0vm8jNJl7RILO0yg
         9+uRUpmSq5IokbKN83wkXYiPZ4+oDfvY+ope5SHRn2b+dMaOeW37C8noz5E4P8zthPx8
         xwtzBeppJnbKzRSwSzFPWQA0iFO/UZJ0/56Q+Bqax/bFL4kCa3EXymG2ceiY+rH9icun
         E5vsCVPZq1vcsSw708OAi27HUS2SNi2QtAn11Z/C1FeX3Fh7T/0YsZX+DhGJteorDMMW
         fWqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/SZO+ZX7+vuZ8WCMCJbPx+t1mWRDV9VyivPbIlhgy9eM0QQJDZzc6Ks7ZZ6eSahh9bEInnsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblhlnP70N9wto/92VbGiag8q+hHqvFRK6eOnq/ECC8POqTedz
	UfLdiAIOBL8vJxiz5gpqNgJbxX+R66geKW501poU3uGn2SA652iBHHKtPVNHmJEOwB0RYnXqCvD
	SHSRWUiy8xpKIPv703zz5ulpyVAwqyr9t7i1lAq8D2w==
X-Gm-Gg: AZuq6aLIBRrw6wnbE8tlWELpfL7E0xE1attMhoEX6S2nz3iGXz4fnibOEzFoHeICFQ9
	yaIjBK7DQG3frSFtQ4/LDwziPtZVjWQLuJK2lIQ+b+WnitAMz9LwB4MtgIX919HD930Z+Fw9FsR
	GEyoQENSzOZVhnzehyzSfaQp6iTp2g3rVOblni7yO5I/wRebwqNQB4oAR+BcydIluwZoxrCJyV7
	mq2Wl3dKD2kzjsuVaB3cEIjVFg8utYjU4GBwU9BaBTegdX+C1ceuNt92b6bGEyyM3WOpg9fous5
	ttRd2sfr05wEgifwylOALHrbzNbg+YbXEf8oO6IhWIwodu9Jd1rCac/5TASG
X-Received: by 2002:a05:6830:6d19:b0:7cf:d0b4:bab7 with SMTP id
 46e09a7af769-7d4646a0607mr5820634a34.34.1770588971399; Sun, 08 Feb 2026
 14:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu>
 <cc23a37e-3b12-4dd5-89a9-ed8977601379@redhat.com> <CAMFT1=Y=FbjyqC6vr6fV74t8AmGVcecKw+YjX6V_iA7XgZtotA@mail.gmail.com>
 <20260208133526.3ed3qzyyj567ylah@skbuf>
In-Reply-To: <20260208133526.3ed3qzyyj567ylah@skbuf>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Sun, 8 Feb 2026 16:16:00 -0600
X-Gm-Features: AZwV_QgRKdMQ3E1L7EfEetBVuUtp6vGBqItDhisi8UwevXW9nTvUPgWH-EFKSL8
Message-ID: <CAMFT1=Z042nT4A76W1T-dywrMZUgmvrzmEvyMfWm2K+Ew0_VDA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A671D10A6A2
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 7:35=E2=80=AFAM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> The idea is not bad, but I would move one step further.
>
> Refactor the rew_op handling into an ocelot_xmit_timestamp() function as
> a first preparatory patch. The logic will need to be called from two
> places and it's good not to duplicate it.
>
> Then create two separate ocelot_port_xmit_fdma() and ocelot_port_xmit_inj=
(),
> as a second preparatory patch.
>
> static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_devic=
e *dev)
> {
>         if (static_branch_unlikely(&ocelot_fdma_enabled))
>                 return ocelot_port_xmit_fdma(skb, dev);
>
>         return ocelot_port_xmit_inj(skb, dev);
> }
>
> Now, as the third patch, add the required locking in ocelot_port_xmit_inj=
().
>
> It's best for the FDMA vs register injection code paths to be as
> separate as possible.


Thanks Vladimir and folks for your time. I'll split it into three
patches as series, and send a v3 version.

Best,
Ziyi

