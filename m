Return-Path: <netdev+bounces-215994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C6B314AA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F063B5FC7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9ED291C3F;
	Fri, 22 Aug 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ItRoWf+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204E27990D
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856845; cv=none; b=iHqQBblK80qEl0+qsRgn30c738LBKjrDFKYaO0h8JBN8X3Qt6g6Vtydi83xtQos3xkbl92dElEL5AWs6ymkwbyTuy8Uh5FnEHa0+S2gObO2KRpxreXxSrvsVdU8nZnsmzZcWfJ4X10syc8zSS7gEyjtGtADpiLFgMOQodMgHhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856845; c=relaxed/simple;
	bh=KX1whVnGIXfAaXHzOtQ9m6c964Ll60XPU3DshLpZbNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuNcpVN8rtLVPzbkO9Ja60bjUuNgkUkRCkb1WMswjT8msxNDx6Fd/8Ftu3OLHXRE7Hy2pdoik5VEaemgd0RyHHtO8Dz0NXGmtYW8Zi2huGCA40K5xJVRuTh19dOtlpXK5QlzKos9tGLPiIedzQ2C/dEwAe5/MSFO7xKE7H/Jyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ItRoWf+n; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8A5264E408EA;
	Fri, 22 Aug 2025 10:00:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D6EC604AD;
	Fri, 22 Aug 2025 10:00:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5F881C228674;
	Fri, 22 Aug 2025 12:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755856837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Cwcx/LLJrt6Uufc15KwGlNwi/lfz0dnv+k38+ZDJcSY=;
	b=ItRoWf+nQG+M1Lwn65p6sSiFvXticGD8sE6THoM6h5mfmlo7E4wkegkFFkjxRCAwAkUCfN
	CQa8DEr0JLLoRNie6KJNmW9nX6t2FXMO7cWRWiu7TmZWDWavLcFL99MzRh5mVdLp26oxws
	C9vjARs1PMfQLc6AmBRwRkYJ4YTgskKbs3sbcaYVN06Mh/N9p8I9yxpwIFJfHi9mqNsWP4
	18bAYde0DtCt+xGLSjy5vDV+JEj2lrOGb1w7yV5ulK7qARF24SNN36deyBEyb30HsmSpTI
	kMOFKyjteZTcNTPx4CN4LktKK88tP+2UqH31hIPWUahG+5E3gXtULCLf/hUtKQ==
Message-ID: <fb499f87-141b-4098-9011-37ec273a07dd@bootlin.com>
Date: Fri, 22 Aug 2025 11:59:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/16] net: phy: Introduce generic SFP
 handling for PHY drivers
To: kernel test robot <lkp@intel.com>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20250814135832.174911-9-maxime.chevallier@bootlin.com>
 <202508151058.jqJsn9VB-lkp@intel.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <202508151058.jqJsn9VB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 15/08/2025 05:25, kernel test robot wrote:
> Hi Maxime,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/dt-bindings-net-Introduce-the-ethernet-connector-description/20250814-221559
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250814135832.174911-9-maxime.chevallier%40bootlin.com
> patch subject: [PATCH net-next v11 08/16] net: phy: Introduce generic SFP handling for PHY drivers
> config: i386-randconfig-013-20250815 (https://download.01.org/0day-ci/archive/20250815/202508151058.jqJsn9VB-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151058.jqJsn9VB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508151058.jqJsn9VB-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/phy/phy_device.c:1625:47: warning: variable 'iface' is uninitialized when used here [-Wuninitialized]
>      1625 |                 return port->ops->configure_mii(port, true, iface);
>           |                                                             ^~~~~
>     drivers/net/phy/phy_device.c:1597:2: note: variable 'iface' is declared here
>      1597 |         phy_interface_t iface;
>           |         ^
>     1 warning generated.
>
That's completly wrong indeed... I had an extra question to ask to Russell
wrt. that feature, then forgot about it and sent the series...

I'll address that then

Maxime

