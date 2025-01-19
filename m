Return-Path: <netdev+bounces-159586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F6A15FCC
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F039A165979
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C8EAD7;
	Sun, 19 Jan 2025 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq+4NRqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8B1FB4;
	Sun, 19 Jan 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737250587; cv=none; b=H7Z6NpDofTxvgs09DiYNP5Wuyn7rizbfw+ziZZFpRp82Y6FQQWIZwXwp1tuVruDm861aJbEeLAdgoYFirUUKDk6UEkzMgr3peYwBaWAvsVnh4j1Q6FEVXe6y2XKSPf7qDS+knucBHCtWXcpFLD3paT56Dp219sySV/YG0QCDPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737250587; c=relaxed/simple;
	bh=7dPA2JyohzqGwNqe2MaAcpWML5RGCuFC0E0OQTFSPZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpSn54cugEYu5RHmn9tiS4bAvLVBB/GUFntJpCLeyQvFytkYaL7H4WHj4hLP1IAP41NZFz1XWkvDRJvaE2de09roJzEnBvMVnmvDLh0u6mdUBIMRkIuEGxjSrn6Y5CdQkuT8NjFpUtSjHgvGFym9zBkVrHfxCe/MY83E5ezrrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq+4NRqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D8BC4CED1;
	Sun, 19 Jan 2025 01:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737250586;
	bh=7dPA2JyohzqGwNqe2MaAcpWML5RGCuFC0E0OQTFSPZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tq+4NRqLZhfAH5TX2RJPslZrcPv8Gtgn1xQ82nK2p5WuwTmDEsHqJ9unvq/C6cpSh
	 uszVu9hqicle8/GQIFo1ZaSNaELIIdRiQE73PP8p43eetd4iS16WQi8Pzc/WYE/Wqx
	 vDinO1QD0kiCxL5aPAxJ+QNLi1XDcfzz4/wsGqypl4ts07z+akUGzc8rlwp4bOnhab
	 Ou7TqeoGNxADG8AQXZ0/aA0cg214uzKhfkwGbCxTGxCrW72hSSVQh1aXySWELAN/Gn
	 yUjVhefPRWxaTMvMplI9cfSPXqrEpx/dzPogr4pDTEQJYlqRN2eo12IfOc2yKwj33/
	 ZmLmH0fO6gxJA==
Date: Sat, 18 Jan 2025 17:36:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [net PATCH] net: airoha: Fix wrong GDM4 register definition
Message-ID: <20250118173625.03d48516@kernel.org>
In-Reply-To: <20250117155257.19263-1-ansuelsmth@gmail.com>
References: <20250117155257.19263-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 16:52:39 +0100 Christian Marangi wrote:
> diff --git a/drivers/net/ethernet/mediatek/airoha_regs.h b/drivers/net/ethernet/mediatek/airoha_regs.h
> index e448b66b5334..30c96f679735 100644
> --- a/drivers/net/ethernet/mediatek/airoha_regs.h
> +++ b/drivers/net/ethernet/mediatek/airoha_regs.h
> @@ -249,11 +249,11 @@
>  #define REG_GDM3_FWD_CFG		GDM3_BASE
>  #define GDM3_PAD_EN_MASK		BIT(28)
>  
> -#define REG_GDM4_FWD_CFG		(GDM4_BASE + 0x100)
> +#define REG_GDM4_FWD_CFG		GDM4_BASE
>  #define GDM4_PAD_EN_MASK		BIT(28)
>  #define GDM4_SPORT_OFFSET0_MASK		GENMASK(11, 8)
>  
> -#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x33c)
> +#define REG_GDM4_SRC_PORT_SET		(GDM4_BASE + 0x23c)
>  #define GDM4_SPORT_OFF2_MASK		GENMASK(19, 16)
>  #define GDM4_SPORT_OFF1_MASK		GENMASK(15, 12)
>  #define GDM4_SPORT_OFF0_MASK		GENMASK(11, 8)

These are defined in drivers/net/ethernet/mediatek/airoha_eth.c
in the networking trees.
-- 
pw-bot: cr

