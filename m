Return-Path: <netdev+bounces-61544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23C824363
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE18F28725C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD122304;
	Thu,  4 Jan 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="arX5yBxG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BA224E4
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1hmv09fkQlunUxiYTmzjBZkRDdfYLiaTw4M4eMRVYig=; b=arX5yBxG1+BeyLpmeCv2WnC/lC
	Ut5/zBRryLzoFYazEYqXetxSyUD6wfIL/OcYL5xQDVbymm/ecGbnmx4sw3PQYKZ8dOpAEB6V5/Eqh
	ZTbI/2wP5XnF3RaQyWf9JvFoZkQGBq55AlNUYfEca8Xq8HfdscpMR50iQdcNcnRvbWLg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLOVB-004M7a-LY; Thu, 04 Jan 2024 15:15:17 +0100
Date: Thu, 4 Jan 2024 15:15:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: sfp module DFP-34X-2C2 at 2500
Message-ID: <d253b578-8fc4-4e85-9c8f-23bdf15dfa77@lunn.ch>
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

Hi Sergio

Please read:

https://docs.kernel.org/process/submitting-patches.html

and

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

There is a formal process you need to go thought when submitting
patches, which these two documents describe.


    Andrew

---
pw-bot: cr

