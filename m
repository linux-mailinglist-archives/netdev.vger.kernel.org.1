Return-Path: <netdev+bounces-137595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAA9A7197
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F141F2352D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F571F9402;
	Mon, 21 Oct 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjizZSy0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CC1F80D2;
	Mon, 21 Oct 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533512; cv=none; b=ang9yNziRDJtVUonAzltXmGQExsVM5ibndgBRYlGw4bk8ylCn7S91K46xPH1GZQMupRFfdfAZDW822qeHs6buKGsOqX7IhuvVPQKTyeWNXaYRlM5mrsQJQf3pz55FE68eTzTmibqVsZwa/k47blDDoI/+qOBjvBWu/zKpHjG9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533512; c=relaxed/simple;
	bh=UcEBlP+K6AUWwNnV6WDbqbJ07FizzoR5surBemBIhmg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=L9+iS03aa5hQ0RDCNQAXRYIVqO+mCHWF5DFeBZDthmbYKBdFBrG6eTAfM0hyPNg2fkOhA6L7VL+3FVwCBWAGe32LnTn1eDuvHlwsAtTe7yyjmJTlCAunu3TkyCOd/WrHqHXrcjLnjRAOfmPIVZobu8/2DUpeXqvy53+ZVYqdEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjizZSy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB30EC4CEC7;
	Mon, 21 Oct 2024 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533512;
	bh=UcEBlP+K6AUWwNnV6WDbqbJ07FizzoR5surBemBIhmg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PjizZSy0tkgmPS1cTRFQR1hXg9/PXD8NY2DSjXaC0e/yg0INAN9eRw4l0IvuPL+VJ
	 YAJW1vyAEJLAcNWCGtTA7ShNOBlDcgTEoYweOC/Sc5NA1dEON21F2f7YIB8dvk6JzV
	 lyy97KW5fBmfJ+a/lOOQMyUHANbiOkNQEklHZtPXHQlDBRP8PYw2jEK7HFwDQRIldi
	 9TFEUX/njgnb0XuI72M+xJpr8n43BcZOjoSakWKBYx5A+7IQFYBhF+BN5XDEvl25w1
	 FMbLvo6OWz1OHTXEGUn74tc6MSRB9K1xsIFwzF820UDRpIi4Us6cginksJPl+VsLJd
	 n8ew2ScmTG7rQ==
Date: Mon, 21 Oct 2024 12:58:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Pablo Sun <pablo.sun@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
Message-Id: <172953337183.748181.12748276548047622670.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Enable Ethernet on the Genio 700 EVK board


On Fri, 18 Oct 2024 11:19:01 -0400, Nícolas F. R. A. Prado wrote:
> The patches in this series add the ethernet node on mt8188 and enable it
> on the Genio 700 EVK board.
> 
> The changes were picked up from the downstream branch at
> https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-mtk/+git/jammy,
> cleaned up and split into two commits.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Moved mdio bus to mt8188.dtsi
> - Changed phy-mode: rgmii-rxid -> rgmii-id
> - Removed mediatek,tx-delay-ps
> - style: Reordered vendor properties alphabetically
> - style: Used fewer lines for clock-names
> - Fixed typo in commit message: 1000 Gbps -> 1000 Mbps
> - Link to v1: https://lore.kernel.org/r/20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com
> 
> ---
> Nícolas F. R. A. Prado (2):
>       arm64: dts: mediatek: mt8188: Add ethernet node
>       arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet
> 
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 97 ++++++++++++++++++++++
>  .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 20 +++++
>  2 files changed, 117 insertions(+)
> ---
> base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c
> change-id: 20241015-genio700-eth-252304da766c
> 
> Best regards,
> --
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8390-genio-700-evk.dtb' for 20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: jpeg-decoder@1a040000: iommus: [[118, 685], [118, 686], [118, 690], [118, 691], [118, 692], [118, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#






