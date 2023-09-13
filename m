Return-Path: <netdev+bounces-33478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E4879E1B6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44FC281EC4
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB41DA44;
	Wed, 13 Sep 2023 08:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592B28F0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:12:49 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43419AC
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:12:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703a0453fso111905871fa.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694592767; x=1695197567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Effk+lusPCVNss8+6kVJxDXnN+qLIdDsbSXn+BntKPU=;
        b=tFoVEplYjdzJPrTa0YpQemI5Rw0rqjZd1YSleYrYBcF8W85FZX5IELhiShYjT4fzo6
         6NYsB/L/07mEDke+thYUAWB592enHizW6Ox46I0YtO4awD0QzQG4frBS6CxE2Roqifw1
         bYMdrveXF1CvRGeZYPVNSOncTkPVl3xlGQe8r4+kJNeY0jI73Zx2po4DTrLN30m2awYC
         lObnal8zZDK/YGaT9qkHKnx9ra9rog8/YeqAtAsRhuw7sSdNAm69qvWDzuvZoLYECR+w
         Q0A7f064IQX/fUf/ws4p4uN+Y5kXD5CxPBlctQxPzphHzL8MNcjva4/xtORaRuozxVAZ
         fWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592767; x=1695197567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Effk+lusPCVNss8+6kVJxDXnN+qLIdDsbSXn+BntKPU=;
        b=AmQD865rDhQwS/BJOYCMaFF1aOLLBEQ7GdQvttV56Wc361iWcCFKnxYULBEN0XLW2f
         Lt7Aqs3tF4tm5xAc4yRgygUa0F9fONULdp4wi6FKBLG/eBhYSn0W4G9qDxHrLqBdxd6S
         wWiC7fW6z0uUVqj6xJojRGsdisBlSm13VVlrdDGcxjRbda99qpzt62nHJoz4jZRM2WLG
         B5EogCl0smV0zICwPfYrh/L+PkKgpaNbryh+p4BtpTZ1f73lZ5CR3Hg+jrTCyqACn7bo
         0B4IgUdJys5+69xSTw8UgiUuvBqSYcxSBi6YJTCB+Tacd/e6xn7CZZT3f73GuPWgbpRv
         Ub3g==
X-Gm-Message-State: AOJu0Yw2S+nmPdq0J2Eqcm6lEN8t6D9Jk8rs1367ISBybqCa4mKnwGQr
	RUk4bfB48SpxCBeOLhZDDo5hSq3SwHBZG+cZDcc=
X-Google-Smtp-Source: AGHT+IGHLnROkY9Nc5lTGJ7J0WsSQ5aWhMGlHVC10cdy4ovpgG40cg4mutcD9l+EYUheHFxu5ila7Q==
X-Received: by 2002:a2e:7a01:0:b0:2b6:9ed0:46f4 with SMTP id v1-20020a2e7a01000000b002b69ed046f4mr1648810ljc.23.1694592767099;
        Wed, 13 Sep 2023 01:12:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b003fee9cdf55esm1278080wmi.14.2023.09.13.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:12:46 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:12:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jen Linkova <furry@google.com>
Subject: Re: [PATCH net-next v2] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
Message-ID: <ZQFu/SXXAhN10jNY@nanopsycho>
References: <20230912134425.4083337-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912134425.4083337-1-prohr@google.com>

Tue, Sep 12, 2023 at 03:44:25PM CEST, prohr@google.com wrote:
>This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
>lifetime derivation mechanism.
>
>RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
>Advertisement PIO shall be ignored if it less than 2 hours and to reset
>the lifetime of the corresponding address to 2 hours. An in-progress
>6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
>looking to remove this mechanism. While this draft has not been moving
>particularly quickly for other reasons, there is widespread consensus on
>section 4.2 which updates RFC4862 section 5.5.3e.
>
>Cc: Maciej Żenczykowski <maze@google.com>
>Cc: Lorenzo Colitti <lorenzo@google.com>
>Cc: Jen Linkova <furry@google.com>
>Signed-off-by: Patrick Rohr <prohr@google.com>
>---
> Documentation/networking/ip-sysctl.rst | 11 ++++++++
> include/linux/ipv6.h                   |  1 +
> net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
> 3 files changed, 37 insertions(+), 13 deletions(-)
>
>diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>index a66054d0763a..7f21877e3f78 100644
>--- a/Documentation/networking/ip-sysctl.rst
>+++ b/Documentation/networking/ip-sysctl.rst
>@@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
> 		- enabled if accept_ra is enabled.
> 		- disabled if accept_ra is disabled.
> 
>+ra_pinfo_rfc4862_5_5_3e - BOOLEAN

This is very odd sysctl name.


>+	Use RFC4862 Section 5.5.3e to determine the valid lifetime of
>+	an address matching a prefix sent in a Router Advertisement
>+	Prefix Information Option.
>+
>+	- If enabled, RFC4862 section 5.5.3e is used to determine
>+	  the valid lifetime of the address.
>+	- If disabled, the PIO valid lifetime will always be honored.

Can't you reverse the logic and call it something like:
ra_honor_pio_lifetime
?


