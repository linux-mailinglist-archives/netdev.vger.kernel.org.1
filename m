Return-Path: <netdev+bounces-219170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527BB402B5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA7B3AD057
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3530BB8E;
	Tue,  2 Sep 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIG2fMUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03D30ACEB;
	Tue,  2 Sep 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819106; cv=none; b=ITIS8QfkRJq/nepoZKFRCMldN9RGJ/PF84TnJOMf0AAx2mKUBJt12shFLI+TqtqahbBI2bxrXgg1KVlg/fcQaObVdRC1wAuakgQexWexf7iCmy2QHl5KGNl0iyK16Dis5hH5Ed3VjIAnHdsdEKhcvuvi3du0zCfbmx0br57rARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819106; c=relaxed/simple;
	bh=FGa7ZgDMj8ZzjbgcMztCURZjWDqJpJhpglo5MQK07Tc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=i+ykeIPTcrJWVo3XatnzYFBIrqWJzTN4PmDQ4UFCIQ88IlfMJ8JoAByfdGtwNKJckDOJwlaQhAkqRz6q7Rnq7Rrb7XfDetvLizaGOU8mBp9SAI9MuDHRW05wJUsra5gfFZ4JJsLIcek4tiQeepy1AkouItZtnEHCsntilOzs16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIG2fMUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD50BC4CEED;
	Tue,  2 Sep 2025 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819106;
	bh=FGa7ZgDMj8ZzjbgcMztCURZjWDqJpJhpglo5MQK07Tc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vIG2fMUYOJGTB+1YSHvjxGf5Q3T8tqmuUCNeaKMpRfHsHGBWnBDv2cUL5UIrEPUcc
	 BwfgQ5m7FwJ4Iz7GfpdQEsdGZmUrzW0oDbMJZNSCtzIcw4gSCv8ep2sCNCwORgj18L
	 /6dZN6PIRi0gYetVeUI66IXga2yu1KfMV/Zq1HHkmAaXJgjFHqsXU5upbxm4ZM/e9O
	 /qXAGi1F9/PEYL1uuFbG9ylCRtdtU0oGDxfjydI9f0NGlLGAP1w2g/DnAVwrXCcgJw
	 XYCTiJJ3bvliyZ2NoizvFArBO/XaKPdXVeAlOW4uvVONWck3Mazzp4lCsJ+1s/taXZ
	 rE6Gvn5rdaokg==
Date: Tue, 02 Sep 2025 08:18:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andrew@lunn.ch, davem@davemloft.net, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 kuba@kernel.org, mripard@kernel.org, wens@csie.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
To: Conley Lee <conleylee@foxmail.com>
In-Reply-To: <tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com>
References: <tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com>
Message-Id: <175678731473.878204.3446095909067556324.robh@kernel.org>
Subject: Re: [PATCH] arm: dts: add nand device in
 sun7i-a20-haoyu-marsboard.dts


On Mon, 01 Sep 2025 17:05:21 +0800, Conley Lee wrote:
> The Haoyu MarsBoard-A20 comes with an 8G Hynix NAND flash,
> and this commit adds this NAND device in the device tree.
> 
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  .../allwinner/sun7i-a20-haoyu-marsboard.dts   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250829 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/allwinner/' for tencent_57056C4B1E98EF5C0517A5685B2E4D060508@qq.com:

arch/arm/boot/dts/allwinner/sun7i-a20-haoyu-marsboard.dtb: pinctrl@1c20800 (allwinner,sun7i-a20-pinctrl): 'nand_base0@0', 'nand_cs@0', 'nand_cs@1', 'nand_cs@2', 'nand_cs@3', 'nand_rb@0', 'nand_rb@1' do not match any of the regexes: '^([rs]-)?(([a-z0-9]{3,}|[a-oq-z][a-z0-9]*?)?-)+?(p[a-ilm][0-9]*?-)??pins?$', '^pinctrl-[0-9]+$', '^vcc-p[a-ilm]-supply$'
	from schema $id: http://devicetree.org/schemas/pinctrl/allwinner,sun4i-a10-pinctrl.yaml#






