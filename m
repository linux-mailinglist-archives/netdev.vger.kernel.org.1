Return-Path: <netdev+bounces-237972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009CFC5255E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D14E3A7112
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FD335BAD;
	Wed, 12 Nov 2025 12:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A463358C6;
	Wed, 12 Nov 2025 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951635; cv=none; b=sdeiDo38XHi4H/XQ/1x2EhrRyaBlfEy5qjkX8Pbu0PS0jvWQiC7p1TCRXW0xFonxtZ1MAO9bBZabU1us22+k+rIey6GRyTiLowX/m2ejmPXAgTDf7Tq/hPqmcVnmz191b1cOKvLukmI/ggbBy1elCc992iDIe2HN7fMetpovgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951635; c=relaxed/simple;
	bh=0XNBKtOrDw6MU8NuqSar+21PUlMRwNObw2ckpFgYcPA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0ORxxtK3FFJHvr1KncOAEBZ/xw0ABKgnebLMONmfU89k7jhE7OmFvOK+x4Dwdb4BdNYfMaTPzoVEsN+BKwJ9BGu/R93ONo9uIsmWo+PyTmeFfkpc33f1F5v46zAa2JsjJKdIDRyIh8UMQ0gqwto7clH3FwHHHKaf0ROp91omOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EDF6203D9F;
	Wed, 12 Nov 2025 13:47:06 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 518F52015AE;
	Wed, 12 Nov 2025 13:47:06 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F511202C9;
	Wed, 12 Nov 2025 13:47:06 +0100 (CET)
Date: Wed, 12 Nov 2025 13:47:06 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Enric Balletbo i Serra <eballetb@redhat.com>
Subject: Re: [PATCH v3] arm64: dts: freescale: Add GMAC Ethernet for S32G2
 EVB and RDB2 and S32G3 RDB3
Message-ID: <aRSBypL8JpsSPRtX@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251103-nxp-s32g-boards-v3-1-b51db0b8b3ff@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-nxp-s32g-boards-v3-1-b51db0b8b3ff@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Nov 03, 2025 at 10:24:01AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Add support for the Ethernet connection over GMAC controller connected to
> the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
> 
> The mentioned GMAC controller is one of two network controllers
> embedded on the NXP Automotive SoCs S32G2 and S32G3.
> 
> The supported boards:
>  * EVB:  S32G-VNP-EVB with S32G2 SoC
>  * RDB2: S32G-VNP-RDB2
>  * RDB3: S32G-VNP-RDB3
> 
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
> Changes in v3:
>  - moved compatible to the head of mdio node
>  - removed redundant cell size declaration
>  - Link to v2: https://lore.kernel.org/r/20251031-nxp-s32g-boards-v2-1-6e214f247f4e@oss.nxp.com
> 
> Changes in v2:
>  - fixed correct instance orders, include blank lines
>  - Link to v1: https://lore.kernel.org/r/20251006-nxp-s32g-boards-v1-1-f70a57b8087f@oss.nxp.com
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 58 ++++++++++++++++++++++++-
>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 18 +++++++-
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 16 +++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi        | 58 ++++++++++++++++++++++++-
>  arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 18 +++++++-
>  5 files changed, 164 insertions(+), 4 deletions(-)
> 
[..]

Hi,

may I ask for review or merge?

I have another patches prepared, but there is a direct
dependacy of having gmac node included in dts.

Thanks.
/Jan

