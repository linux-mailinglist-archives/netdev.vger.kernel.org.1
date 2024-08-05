Return-Path: <netdev+bounces-115649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54007947584
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29B31F21AB9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1314A618;
	Mon,  5 Aug 2024 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ3VSoO8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762E14A606;
	Mon,  5 Aug 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840157; cv=none; b=MgHlp2jZDY3hM5ZyBuHuDDxG16PnY+VbosuNFSQrTz85MCH5fzfmM5a75cm5R0bpFtIixque/0ZJ5eqVjiWHY2bwtk1i16FCYXMsEViiBuNM+17RR/gtBSfU//OQmU23pY50WGXXVR4qfapBMKMHsru88WeoBHtpUOrh0WEQI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840157; c=relaxed/simple;
	bh=/x+BC882axidh+jiBZz2JrkoPRpTk9KLc9FmsPQGlaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivzL6t66hhs7LnNr6/8Pgx0bK/qU9vJxP1jpf8dWfa1OtQA/msi5SN83ccUT3Vx4l+ex/z++BbmcVwxPPUeTvJ9+BD01TS/80EkKlOQh/dx9w8lE3rMWMA2Hid58Eyi0fUwgcfGBMss3zyVYZRuGyzcMRhNJ/EVjeBCRIk8acw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ3VSoO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E03CC32782;
	Mon,  5 Aug 2024 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722840156;
	bh=/x+BC882axidh+jiBZz2JrkoPRpTk9KLc9FmsPQGlaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZ3VSoO8C5j7vvbEaj1zRHMCWruptt4vrVEfW/iC14cotzHFxcv1nBuxH3nDVbiOJ
	 YueY15BpPY+mNspkkoPw23HYWIsO3q6dm6z3wc+N3w1Al8liu+kYcrcKV03u+hnNBM
	 XeNFDSXpTJYQCq3pX/9o9zZXdff1NzxxWH/eLK+/Tmsck4TKq383ddAad43V4f4rsx
	 nlFwy9yEISEawTRpFuB5Dtm+t4XrzqOSIEspY23yyXCCmNhvjtDsB5VNHJ3n6ktZcZ
	 Q5ofzwWzuweVRCE3CSyiU5yKtyu2csTqGgemgpnG/lnZ6JsQeEwnPWOCuEzsJ/loVa
	 aU9FYGuF3IjAg==
Message-ID: <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
Date: Mon, 5 Aug 2024 09:42:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
To: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
 Sai Krishna <saikrishnag@marvell.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Tero Kristo <kristo@kernel.org>, srk@ti.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240729113226.2905928-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/07/2024 14:32, MD Danish Anwar wrote:
> Add documentation for pa-stats node which is syscon regmap for
> PA_STATS registers. This will be used to dump statistics maintained by
> ICSSG firmware.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: tags should come after Author's Signed-off-by:

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

