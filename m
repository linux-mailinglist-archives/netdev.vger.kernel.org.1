Return-Path: <netdev+bounces-174781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E3A60500
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 00:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179E917B7C1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7711F30C3;
	Thu, 13 Mar 2025 23:02:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784E18DB0B;
	Thu, 13 Mar 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906936; cv=none; b=WSsP46EQOVlqbG2C7hNxsJpeih2u9DOQB+wrKy7YKQ7XJwzXNJ5GpzxalNL1ilqYYR9Dps6hJwaAE9j1PAy2oPGrLwjwO48ay2yHgAjmrAc0c+s5uHSNB84x51fiLRstjbu/5R92rOHP4VOfTKdUinb4gMyx6slrwu/inwQEoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906936; c=relaxed/simple;
	bh=FvWhX3hOtt44gKakSeJitzPaf1braPvr1GZPWAgKvOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATeKkv1tPimiSPmiDlnrDYru644ZwW8ZE93Ri+YYUhaMg44KGZS9OEc21ZeDQlzvlKhNPdtbxPKSFHSA5nfW0e+qTjKcOCF/71A0eryymC48wP1+AKE8O3KMUZIfF/lTXsuWmzPnZY+UlD2uk25PyCNfbFA/AIcdvbtXWh16AoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tsrYj-000000005c9-1YGc;
	Thu, 13 Mar 2025 23:01:49 +0000
Date: Thu, 13 Mar 2025 23:01:45 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Message-ID: <Z9Nj2ZRnh8ZABklp@makrotopia.org>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
 <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
 <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
 <6ae8b7c6-8e75-4bfc-9ea3-302269a26951@alliedtelesis.co.nz>
 <f6165df5-eedb-4a11-add0-2ae4d4052d6a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6165df5-eedb-4a11-add0-2ae4d4052d6a@lunn.ch>

On Thu, Mar 13, 2025 at 11:07:55PM +0100, Andrew Lunn wrote:
> > I'm pretty sure it would upset the hardware polling mechanism which 
> > unfortunately we can't disable (earlier I thought we could but there are 
> > various switch features that rely on it).
> 
> So we need to get a better understanding of that polling. How are you
> telling it about the aquantia PHY features? How does it know it needs
> to get the current link rate from MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1
> which is a vendor register, not a standard C45 register? How do you
> teach it to decode bits in that register?

There are several registers of the MDIO controller to control which
non-standard registers are polled as well as information about the
register layout [1].

There are lots of constraints which is why not all PHYs can even be
used at all with those switch SoCs -- PHYs which are more or less
standard C45 are easy to support, all one got to do is define MMD
device and registers as well as register layouts for things which
aren't covered by the C45 standard (1G Master/Slave status and control,
as well as a way to access the equivalent of C22 register 0).

But C22 PHYs which aren't RealTek's won't ever work.
Anything which doesn't use register 0x1f for paging is disqualified and
can't be used. I've also just never seen any of those SoCs being used with
anything else than RealTek's 1000Base-T or 2500Base-T PHYs.

Only for 10GBase-T you will find variation, Marvell, Aquantia and some
with Broadcom.

Obviously that's all largely incompatible with Linux' approach to PHY
drivers. Luckily *most* (but not all) switches based on those RealTek
SoC's initialize the PHY polling registers in U-Boot, so usually Linux
doesn't have to touch that (that's why usually we have to make sure
that 'rtk network on' is called in RealTek's U-Boot before launching
Linux).


[1]: There is a very useful reverse-engineered register documentation for
those RealTek SoCs which also covers those registers of the RTL9300:

https://svanheule.net/realtek/longan/feature/mac_control

See SMI_REG_CHK_* and everything with 'POLL' in the register name to get
an idea...

For illustation see the default value of SMI_10GPHY_POLLING_SEL_0 which
is 0x001f_a434. So that's what is called 'RTL_VND2_PHYSR' in the Linux
driver for RealTek PHYs...

