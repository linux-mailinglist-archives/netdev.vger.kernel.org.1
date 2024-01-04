Return-Path: <netdev+bounces-61562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2D82443A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C711C20E83
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8B219F1;
	Thu,  4 Jan 2024 14:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67823758
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rLP8R-0002Hv-0F;
	Thu, 04 Jan 2024 14:55:52 +0000
Date: Thu, 4 Jan 2024 15:53:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: netdev@vger.kernel.org
Subject: Re: sfp module DFP-34X-2C2 at 2500
Message-ID: <ZZbEMbNb7LHXiWKN@pidgin.makrotopia.org>
References: <AS1PR03MB8189F6C1F7DF7907E38198D382672@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189F6C1F7DF7907E38198D382672@AS1PR03MB8189.eurprd03.prod.outlook.com>

On Thu, Jan 04, 2024 at 02:10:43PM +0100, Sergio Palumbo wrote:
>

Please use `git format-patch` and send your patch to all receipients
listed by `scripts/get_maintainer.pl`. Please also write a meaningful
patch description and patch title prefixed similar to other commits
adding similar changes to the kernel.


> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 2abc155dc5cf8..a14f61bab256f 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -495,6 +495,9 @@ static const struct sfp_quirk sfp_quirks[] = {
>         // 2500MBd NRZ in their EEPROM
>         SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
>  
> +       // DFP-34X-2C2 GPON ONU supports 2500base-X
> +       SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
> +
>         SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
>  
>         // Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
> 

