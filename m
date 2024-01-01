Return-Path: <netdev+bounces-60760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D00821591
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 23:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAACD1F214D6
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442AE559;
	Mon,  1 Jan 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwTng7mZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3CE560
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27e824d65aso182250966b.1
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704149079; x=1704753879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9U82Ne+vwInBsLElITs45+mU5z1SZsq6Gvi+HuddaWU=;
        b=XwTng7mZR2shNc+APKMLUuvf/dJ+Miy+9faiM1iqGDOZKomgfdY8Igq3mrIdZDsOJI
         kg4m5JA0/micRNOP8TXY//W7RqAv3vyf5831jRJQZsb0CkzsxSURGfv5bKLblTfKsW+U
         Jplbgf/HLVnu2zlBcL9eedEdUilYOt+1okO3dTULdwJVeypM5/A46elvgVNOxJdyrA1m
         8LBgWiRsNPQMhgThBBXDwssOe8kt5H3KU4qSNWCbAqkKfdZBef8eFDHYa60zKzeu6X8Z
         7wfgiQu2/RwiyIKpdqPLCQi5jY+Jv6kZw5yK8O3dx5f4lhcOrVjQV+e2MsghbiaSEsgM
         eekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704149079; x=1704753879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U82Ne+vwInBsLElITs45+mU5z1SZsq6Gvi+HuddaWU=;
        b=aQu19q+jpXPBWDO+ZIL/IH0kauTktdbGDAXPbyB4Aj56KFda4lPZWm5J4CTvBsQNr+
         oExsT2KFbicdLmQwT1nGW69q5jTSMKlMN60sa6yVxvhKaVC6vhHbm533QUDC8RnmK6Y/
         4ipKB5xES2tVmYpCKEHX2Wd8OYDw8lD/MonkTy58DUtI8AQlb7Jxfr0Ovba2rnz4c/JQ
         3vgltucA75dO28g460b1wmlCTKNUvE84nnRPSc1Eid8H7ovVsC83b82uyQZf9yBmlWki
         j1YUn5ve6IDfn8cKg3wFFr+8+Ez1t4Ac7EUC8kzJaak5n0pju8vtl6DAITytsrR9yySr
         FiAg==
X-Gm-Message-State: AOJu0YzTylYxk9i8njRN3HAm1TentZlBxmP+ZnMFtNAiM/9QmqIEfTJX
	i/T+9v/SUVuIBiGaKQAeJM+9WfiDEt8=
X-Google-Smtp-Source: AGHT+IHg/PN33UCX6rpfa8ziCU+BKsn1uQNz6hcQR7h03Fs+SG1ESh3+fd9+bWBIzob3EGyelmXiUA==
X-Received: by 2002:a17:906:115b:b0:a1b:7700:2c0b with SMTP id i27-20020a170906115b00b00a1b77002c0bmr14897260eja.19.1704149078872;
        Mon, 01 Jan 2024 14:44:38 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1? (dynamic-2a01-0c22-6e6b-b000-65c3-c8c0-cae3-f9e1.c22.pool.telefonica.de. [2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1])
        by smtp.googlemail.com with ESMTPSA id fg8-20020a1709069c4800b00a26aaad6618sm7988278ejc.35.2024.01.01.14.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 14:44:38 -0800 (PST)
Message-ID: <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com>
Date: Mon, 1 Jan 2024 23:44:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: ezra@synergy-village.org, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: Michael Walle <michael@walle.cc>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.01.2024 22:31, Ezra Buehler wrote:
> Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
> capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
> Gateway will no longer boot.
> 
> Prior to the mentioned change, probe_capabilities would be set to
> MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
> Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> least with our setup) considerably slow down kernel startup and
> ultimately result in a board reset.
> 
> AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
> "Clause 45 protection" feature (e.g. LAN8830) and others like the
> LAN8804 will explicitly state the following in the datasheet:
> 
>     This device may respond to Clause 45 accesses and so must not be
>     mixed with Clause 45 devices on the same MDIO bus.
> 

I'm not convinced that some heuristic based on vendors is a
sustainable approach. Also I'd like to avoid (as far as possible)
that core code includes vendor driver headers. Maybe we could use
a new PHY driver flag. Approaches I could think of:

Approach 1:
Add a PHY driver flag to state: PHY is not c45-access-safe
Then c45 scanning would be omitted if at least one c22 PHY
with this flag was found.

Approach 2:
Add a PHY driver flag to state: PHY is c45-access-safe
Then c45 scanning would only be done if all found c22 devices

Not sure which options have been discussed before. Any feedback
welcome.

Related: How common are setups where c22 and c45 devices are attached
to a single MDIO bus?


> Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
> 
> This change is modeled after commit 348659337485 ("net: mdio: Add
> workaround for Micrel PHYs which are not C45 compatible"). However,
> I find the name SMSC_OUI somewhat misleading as the value is not the
> full OUI (0x00800f) but, just the OUI part of phy_id, which is quite
> different.
> 
>  drivers/net/phy/mdio_bus.c | 3 ++-
>  include/linux/smscphy.h    | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 25dcaa49ab8b..63f1c42fbc8d 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -31,6 +31,7 @@
>  #include <linux/reset.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/smscphy.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> @@ -632,7 +633,7 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
>  			continue;
>  		oui = phydev->phy_id >> 10;
>  
> -		if (oui == MICREL_OUI)
> +		if (oui == MICREL_OUI || oui == SMSC_OUI)
>  			return true;
>  	}
>  	return false;
> diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
> index 1a6a851d2cf8..069d6d226abd 100644
> --- a/include/linux/smscphy.h
> +++ b/include/linux/smscphy.h
> @@ -2,6 +2,8 @@
>  #ifndef __LINUX_SMSCPHY_H__
>  #define __LINUX_SMSCPHY_H__
>  
> +#define SMSC_OUI 0x01f0
> +
>  #define MII_LAN83C185_ISF 29 /* Interrupt Source Flags */
>  #define MII_LAN83C185_IM  30 /* Interrupt Mask */
>  #define MII_LAN83C185_CTRL_STATUS 17 /* Mode/Status Register */


