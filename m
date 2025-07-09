Return-Path: <netdev+bounces-205208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C34AFDC8F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BD31C22D60
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE382130A54;
	Wed,  9 Jul 2025 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCAUoneN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BD1BC41;
	Wed,  9 Jul 2025 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022384; cv=none; b=lL2sJ6X2YBFBqo50xgTnZzGAaeHMnMOgKi5XJvrHGaZq9nRd3fgPg1/nqYz+0kR9QDA2zDHE93JpY7Wh+f2d/x+LQy80tum4z7KUfFVmMDJ7Bj2D1+QqUqUHxVmzPZTxAcvjwOe6G8HB3HG58ifNlpLRI3sWVjg2S2z5izEDtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022384; c=relaxed/simple;
	bh=hPz+8vn5trBDH79QuCKDMawOQmLVVBkPPcvkIwXcSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKD86zGAiuwjSCBgKBhbugt6mk8FocYmEVAymWLlrtmETemJbvzD0vBL1g+DDQGbPZhMKid54K14qZWG8+vGGe0woCCQMe0fmbrL3gnLi9/SMSWALeUrUtr4QWzSG0r53osmnePyZ0ViEC0wljJWeKPdQhKizbEU3MMTeK7qlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCAUoneN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63786C4CEED;
	Wed,  9 Jul 2025 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752022384;
	bh=hPz+8vn5trBDH79QuCKDMawOQmLVVBkPPcvkIwXcSN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCAUoneNx+tGEXZ4FP7Y+2H9vCEBq3Fedx3TswkqfUWKU9gcRg/LajCdLwcvO+z5G
	 5qs4hnqdhM8YmEJH0vXuZmm+hshQd1zqlNmhWdh2TknzIOzewNkuzHci5w5NqfJORN
	 C8gnLfScdD1UOlqlalpk1+FbXpbori4X4kP07uDII4fgxv2K/XtGyJtkPirkufY+N4
	 60T5F4QYYgBAlYZNsdc4IcdvjFBammd6+UWgTUTRkufo1urDhhq9e4+9obk1ghYrvf
	 fw1mKEvbyo3NPG4BLYnajSFW19+ydnJrztgeCPmvdwjoCwZ76V3cL+1a6HzdxS2AB6
	 2i+DS4XzhPcng==
Date: Tue, 8 Jul 2025 17:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
 m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
 saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com, horms@kernel.org,
 s-anna@ti.com, basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v10 03/11] net: ti: prueth: Adds PRUETH HW and
 SW configuration
Message-ID: <20250708175301.599c82b8@kernel.org>
In-Reply-To: <20250702140633.1612269-4-parvathi@couthit.com>
References: <20250702140633.1612269-1-parvathi@couthit.com>
	<20250702140633.1612269-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 19:36:25 +0530 Parvathi Pudi wrote:
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index aed5cdc402b5..f52858da89d4 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
> +		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
> +		PRUSS_MII_RT_TXCFG_TX_32_MODE_EN |
> +		(TX_START_DELAY << PRUSS_MII_RT_TXCFG_TX_START_DELAY_SHIFT) |
> +		(TX_CLK_DELAY_100M << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT);

> +	/* Min frame length should be set to 64 to allow receive of standard
> +	 * Ethernet frames such as PTP, LLDP that will not have the tag/rct.
> +	 * Actual size written to register is size - 1 per TRM. This also
> +	 * includes CRC/FCS.
> +	 */
> +	txcfg = (((PRUSS_MII_RT_RX_FRMS_MIN_FRM - 1) <<
> +			PRUSS_MII_RT_RX_FRMS_MIN_FRM_SHIFT) &
> +			PRUSS_MII_RT_RX_FRMS_MIN_FRM_MASK);

Please use FIELD_PREP() instead of defining separate _MASK and _SHIFT
values.

> +	/* For EMAC, set Max frame size to 1528 i.e size with VLAN.
> +	 * Actual size written to register is size - 1 as per TRM.
> +	 * Since driver support run time change of protocol, driver
> +	 * must overwrite the values based on Ethernet type.
> +	 */
> +	txcfg |= (((PRUSS_MII_RT_RX_FRMS_MAX_SUPPORT_EMAC - 1) <<
> +			   PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT)	&
> +			   PRUSS_MII_RT_RX_FRMS_MAX_FRM_MASK);

> +struct prueth_queue_desc {
> +	u16 rd_ptr;
> +	u16 wr_ptr;
> +	u8 busy_s;
> +	u8 status;
> +	u8 max_fill_level;
> +	u8 overflow_cnt;
> +} __packed;

Please don't use __packed if the struct will be packed anyway based on
C packing rules.

