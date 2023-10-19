Return-Path: <netdev+bounces-42727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B947CFFA7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812201C20AD9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D7132C6D;
	Thu, 19 Oct 2023 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVnrVvlU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643932C77
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:32:18 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08C114;
	Thu, 19 Oct 2023 09:32:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2101063a12.1;
        Thu, 19 Oct 2023 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733135; x=1698337935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snMnwniYmlxP3Y9Ip2eEixKebfiIM8G3x6wXC6QAwiQ=;
        b=GVnrVvlUfWwRP8Bwx2PI/Hf68EABzxG8SWq289UvyeOqgKOphlDEfEUDil9gjrxb/n
         gk1K4s9O9mzBXJrkHZ9QP2wIn5q+MdfR7+hDjXrMVCrO4Nh8A3LJoIWp5zhTUutvAPbP
         M7oO0cYkQwQFnScyHVr/c6LNwacMfjpX6MSC9mDZZwXDS4G8Fj/+/I0QYcbqV/8ZMHOU
         bKAG9CvciSC1tYA/EI91U3PITKE9kWa+SVb1rFrEm0I1Vg+nfcX1E1A9jZ7vrMmmo2k4
         vJN4hPoxwDgYigsBr307Lew/cDmuSPf05Jn1RjxJolwvry7mphvELIPSZppzISVzHIcd
         jPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733135; x=1698337935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snMnwniYmlxP3Y9Ip2eEixKebfiIM8G3x6wXC6QAwiQ=;
        b=nbShNq8DptN2VGE0CDkHflsbeGnTgF/cUZ2t+v5uKRpVfWiAog/v6gsNSh7Xi3M2QG
         UL8PfvvBM4s+ZQ2tfM5jVaDDZPvDA8EAXifN+/GSRd56+hrWLmBNJDxikyKYaQNwRHkk
         u0cjTqszNHhwj2ncK1uy2aIsjp7UqL/TVOX5uQk2v54vJiuosSsfI30aUSMhaeLQRTwi
         x29uMi9uIXokfkr9DjjhcQVchsfH/iziwzZ1oACgAdIg3v74EIF5qaccEppm1c1WZ6YH
         +3htLsnO+23CIiJge6LJDV2hHtWq4NOR6KfJT1jSq4iCum/Vqf4dDuLeye+Jt8QuPQl3
         /HaA==
X-Gm-Message-State: AOJu0Yz5/nSewviklNjHI2e8P8WlZkHtbPQV8ZWy7ZiVRlC79rf6+ipf
	CnQ5Dc8JRYu81xq0uY0Sigo=
X-Google-Smtp-Source: AGHT+IFRPQBF+44d+7wTgk70DIRXBX48803zb2e1xDRdRexbtkq5wks1WXyeIpVHpAER00U+eoqkyg==
X-Received: by 2002:a17:907:2d0f:b0:9ba:8ed:ea58 with SMTP id gs15-20020a1709072d0f00b009ba08edea58mr2246411ejc.30.1697733134928;
        Thu, 19 Oct 2023 09:32:14 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id ck3-20020a170906c44300b009bf7a4d591dsm3888016ejb.32.2023.10.19.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:32:14 -0700 (PDT)
Date: Thu, 19 Oct 2023 19:32:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Message-ID: <20231019163212.yzt6erzptuifs5yn@skbuf>
References: <20231019111459.1000218-1-o.rempel@pengutronix.de>
 <20231019111459.1000218-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019111459.1000218-3-o.rempel@pengutronix.de>

On Thu, Oct 19, 2023 at 01:14:59PM +0200, Oleksij Rempel wrote:
> Address a link speed detection issue in KSZ886X PHY driver when in
> forced link mode. Previously, link partners like "ASIX AX88772B"
> with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
> 
> The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> even with autonegotiation off, misleading link partners in autoneg mode,
> leading to incorrect link speed detection.
> 
> Now, when autonegotiation is disabled, the driver sets the link state
> forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
> disabling autonegotiation, makes the PHY state more reliably detected by
> link partners using parallel detection, thus fixing the link speed
> misconfiguration.
> 
> With autonegotiation enabled, link state is not forced, allowing proper
> autonegotiation process participation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

