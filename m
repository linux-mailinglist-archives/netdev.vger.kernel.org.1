Return-Path: <netdev+bounces-122706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB0962458
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119F91C23BE1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95691684A0;
	Wed, 28 Aug 2024 10:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66315D5CE;
	Wed, 28 Aug 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839817; cv=none; b=EzcVMXXi2nHz5ZVBrvIJCptEYZTeffp0bKgXNQJWoPbozVLKImXqvFoz8HjfWvaskHwClsDVxZpZedKRhQzvnhbrRJWoGk9L92bUaeM0XeEb1IE+IY0j/hd1Zlk2T6kPcnjKuDHPdaA+LOL2SOniqDajrXzOR0CHKlY5YrwT3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839817; c=relaxed/simple;
	bh=7LpN8vpF9vmt6DZxZxN9r7LD/KyKU5txaPnCHu4Cw7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StPivQrz/0JtjuFg5KrlzxF5BrXdUavZmRXUWUUagPH+gwlEBqAH+G5iLOGPjXxdNjzqUUnuyIPTpjcv6zVMRvWPkvt6E339BIDEx3XP1Ejz2Lis/TLoRl7GbX8eHXIgmkYzAY36a4j5TwXm04MwatUuFQrH5cer+Jrkzze9KvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv0XJ0Rw7z9sRy;
	Wed, 28 Aug 2024 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXxXD9Qfz31u; Wed, 28 Aug 2024 12:10:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv0XH6L39z9sRs;
	Wed, 28 Aug 2024 12:10:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C94CF8B78F;
	Wed, 28 Aug 2024 12:10:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aeC0cGDuV2bP; Wed, 28 Aug 2024 12:10:07 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 855978B764;
	Wed, 28 Aug 2024 12:10:07 +0200 (CEST)
Message-ID: <b8f628b9-91af-45fa-87f0-55abce9ba947@csgroup.eu>
Date: Wed, 28 Aug 2024 12:10:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: ethernet: fs_enet: Cleanup and phylink
 conversion
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 11:50, Maxime Chevallier a écrit :
> This series aims at improving the fs_enet code and port it's PHY
> handling from direct phylib access to using phylink instead.
> 
> Although this driver is quite old, there are still some users out there,
> running an upstream kernel. The development I'm doing is on an MPC885
> device, which uses fs_enet, as well as a MPC866-based device.
> 
> The main motivation for that work is to eventually support ethernet interfaces
> that have more than one PHY attached to the MAC upstream, for which
> phylink might be a pre-requisite. That work isn't submitted yet, and the
> final solution might not even require phylink.
> 
> Regardless, I do believe that this series is relevant, as it does some
> cleanup to the driver, and having it use phylink brings some nice
> improvements as it simplifies the DT parsing, fixed-link handling and
> removes code in that driver that predates even phylib itself.
> 
> The series is structured in the following way :
> 
> - Patches 1 and 2 are cosmetic changes. The former converts the source
>    to SPDX, while the latter has fs_enet-main.c pass checkpatch. Patch 2 is
>    really not mandatory in this series, and I understand that this isn't
>    the easiest or most pleasant patch to review. OTOH, this allows
>    getting a clean checkpatch output for the main part of the driver.
> 
> - Patches 3, 4 and 5 drop some leftovers from back when the driver didn't
>    use phylib, and brings the use of phylib macros.
> 
> - Patch 6 is the actual phylink port, which also cleans the bits of code
>    that become irrelevant when using phylink.
> 
> Testing was done on an MPC866 and MPC885, any test on other platforms
> that use fs_enet are more than welcome.
> 
> Thanks,
> 
> Maxime
> 
> Maxime Chevallier (6):
>    net: ethernet: fs_enet: convert to SPDX
>    net: ethernet: fs_enet: cosmetic cleanups
>    net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
>    net: ethernet: fs_enet: drop unused phy_info and mii_if_info
>    net: ethernet: fs_enet: fcc: use macros for speed and duplex values
>    net: ethernet: fs_enet: phylink conversion

For the series,

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu> # LINUX FOR 
POWERPC EMBEDDED PPC8XX AND PPC83XX

> 
>   .../net/ethernet/freescale/fs_enet/Kconfig    |   2 +-
>   .../ethernet/freescale/fs_enet/fs_enet-main.c | 421 ++++++++----------
>   .../net/ethernet/freescale/fs_enet/fs_enet.h  |  24 +-
>   .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  16 +-
>   .../net/ethernet/freescale/fs_enet/mac-fec.c  |  14 +-
>   .../net/ethernet/freescale/fs_enet/mac-scc.c  |  10 +-
>   .../ethernet/freescale/fs_enet/mii-bitbang.c  |   5 +-
>   .../net/ethernet/freescale/fs_enet/mii-fec.c  |   5 +-
>   8 files changed, 209 insertions(+), 288 deletions(-)
> 

