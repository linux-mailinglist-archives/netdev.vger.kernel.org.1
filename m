Return-Path: <netdev+bounces-136191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9159A0E8E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313B2288947
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033020E03E;
	Wed, 16 Oct 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ZyP12h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837120E02F;
	Wed, 16 Oct 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093114; cv=none; b=uREmHzAULnOmFXRj+URJ3W801nfVwpD/a8IZQxbQHaOECdJycfpwCS6d1E17eZN2Pd2Zo5fBsvnqPNMEZt8yeCzgpg5p7EApuq7xdx/ZWpRSKgHUKd+kH0HhDonSSIx0tnvZ/d86RPwRjdIoVJyeg3GM7v3yWq4LaFt0fvSaxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093114; c=relaxed/simple;
	bh=dFW8u8wREC5V/rE4CPEL3TXXHyVXddI7PBsgSDXHwTM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rbrZqPBmccPTKFWzodDHOPvtuswVbS5iXXM4ww4Z5k6DcuJNLqmDYBvg0E4lEu9ck/ZjIBkNv4ZdyVHCJJUhzGZfRZMUE27TrQIhN4x3ywcvWVQEbQJElUdvmVX0LNb3SPGXNofl/W9AzTjc+yoTbtO+Cf13ClVV6d4FSuiZ4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ZyP12h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4502EC4CEC7;
	Wed, 16 Oct 2024 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729093113;
	bh=dFW8u8wREC5V/rE4CPEL3TXXHyVXddI7PBsgSDXHwTM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I6ZyP12hU9L6hiBtylHFmizE+cd2yG3IZLUQTA3nmpFMGeAdr02jM6p0dMcfaklMs
	 Vf9+YyPNTy2j1ZkKaIKGnCG/wD7TzTD7meVPIU5kT5tO0tM5s3kcmqRP+BQRADvwGP
	 UpC5ncTZ1BKst5FUFa2lkvY8h+TM1F1S6U1yMRAFinzR/GjUEBUteaqwJxr4XNi4kx
	 TqFv6KMho9uPIPS0+W21HQesrR3TaB3JqQjXqfT6GasoXsIbmyMxSg+BU6bZu26UAi
	 dke3/kEzJNQ62V8oJFGkfWI5udhRBN+frLhNIgrZpcqM/7/al+RDl4W+o3/dbKFx75
	 m/l1Lmi7OQojA==
Date: Wed, 16 Oct 2024 10:38:32 -0500
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
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Jianguo Zhang <jianguo.zhang@mediatek.com>, 
 Hsuan-Yu Lin <shane.lin@canonical.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, netdev@vger.kernel.org, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
References: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
Message-Id: <172909289110.1676363.14494745221795348933.robh@kernel.org>
Subject: Re: [PATCH 0/2] Enable Ethernet on the Genio 700 EVK board


On Tue, 15 Oct 2024 14:15:00 -0400, Nícolas F. R. A. Prado wrote:
> The patches in this series add the ethernet node on mt8188 and enable it
> on the Genio 700 EVK board.
> 
> The changes were picked up from the downstream branch at
> https://git.launchpad.net/~canonical-kernel/ubuntu/+source/linux-mtk/+git/jammy,
> cleaned up and split into two commits.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Nícolas F. R. A. Prado (2):
>       arm64: dts: mediatek: mt8188: Add ethernet node
>       arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet
> 
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 95 ++++++++++++++++++++++
>  .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 25 ++++++
>  2 files changed, 120 insertions(+)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8390-genio-700-evk.dtb' for 20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: jpeg-decoder@1a040000: iommus: [[118, 685], [118, 686], [118, 690], [118, 691], [118, 692], [118, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#






