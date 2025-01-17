Return-Path: <netdev+bounces-159194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19EA14BAE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A866418821DD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13E1F9A80;
	Fri, 17 Jan 2025 08:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0B1F9A9C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104252; cv=none; b=MH9Vg0ypmShl6w4VkwY4IHOHKEchXplo4uiz+vu1L4RyE5jZYdm9E+UTaIWW5tZV6fFhkIU/LODUxwRuWt2SEqob/ev0emf9wbcN2FxnZk3pHBx03uRIUqX8qryPfnNkh05qpBoNKVMFbEvmSImK0qjQ9GjCZ85xl1Tp3hRB5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104252; c=relaxed/simple;
	bh=vXITqcaO71wcfi7Zt+zUrFW5/yV6v4Y8t5L633JXoKI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhkC1H2mrl7SErHyWKLEONy730Q0I+LuGSBJdqGaJQSZzBeO2eW4eY17QgmgbaXllATsFMF6dbJ+luCWPCG0zCJR1IikdVt04FDzy9hAS7HtQ9H5Csyv6XShgMpsIk84Py3djLS+RIpryH2MjAsDsOh5OOT8d3+h4eFVxzVuXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1737104195t105t50410
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.187.167])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13642672395322382177
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>,
	"'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	<mengyuanlou@net-swift.com>
Cc: "'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'Bryan Whitehead'" <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	"'Marcin Wojtas'" <marcin.s.wojtas@gmail.com>,
	"'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 0/9] net: add phylink managed EEE support
Date: Fri, 17 Jan 2025 16:56:34 +0800
Message-ID: <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJuuL6961zeRYLpn6fcQniPsxo8VLH0BglA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NfPsrf/HTJYA0FB+FKFb+twO+nReN9JwUckHktUCQiiqU8jhsDc10wky
	XT22GKLtNkX1+oGYVbKqm/GtNzNKMQhsR6BE1DEGtmIvHVp2kw+5KFzzq1ch9VFT/xDcZxM
	MDoPayJKQRfMQBts7Shr8bFBTl6mXgLEIgQcd4ZrrofFLnbJD+xRjqKXHfrtBF757+QBRbc
	SLLfhMGyvlHNL8YdDxyGRf3aCZkaN6BwZTi11pk3cC6n+HqND/nOCeiXO8AYoZlIUA2WgmL
	xBWPhpJNb8Wj38o+7APUvlx5iX9qKi5G4dQZNaWA8fKmxuJOFma3L2yTbq+IdHEW5F9Ft49
	tP6M+ICnSqRdRhMlVZyvJTIFHJ6g9xun5WDT+xvkJMCs9GG2UiAQuErGNI+78B8X4/hepEl
	vPeYOlcQUOcXM5bhRpXTahXyfmDu9OgyiD1Y8ynPJxeCE+tm/oxurjeORusHO5t+vRWliUD
	3pRyxrtfVzt0ORvDfS6SOH8FJb0k8x0oO1XoMsdPIn1NH02x4gZVsU03QwCoSHlbYEkoOPf
	tjiD5QvoWCD1NfJAi1XW0NBFVKssLEkb6Y/rjmoRoNifFipFOfZy5P8ecTXVbR8yLw6iErN
	mO+dQktVBtxSdspY7nSfehSafxTghd4FICZ/oShxC+pQPfQ41jAjOHhQ2loQ/wlGkblPdMd
	EWZTKWtd45gkM9qTFbRWOOiQ9Gxy4qCHq7pgFAM6xIK01fb6QTBZKDSr8VT9hIG8Q38ZXef
	JPw7a9siCy4bPrarGgorATuqmoDHkHQGP3GqRpUaDQvp2GJAAkZccBr33civBy9kJQvqLaT
	1DHC4rY61pwa4lsthufv5B0GgX3PgNNzZaiahcxzT+4z4Z5r8R5tRLjQoSwGGBANWgZUz4X
	LTfSx6NgiXbeIxpJZ96QBc/hbSO50jT2LKtYZWUDnU1aUmwhpDh8v6of3XTf1a8kz2lvD4C
	ibm61ao7eaRLeweSGx28KvoS5q+lyXCkRLDFT+SeKntEZZBfz3Kj0ANPW2GfmOaRqzSM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

> Hi,
> 
> Adding managed EEE support to phylink has been on the cards ever since
> the idea in phylib was mooted. This overly large series attempts to do
> so. I've included all the patches as it's important to get the driver
> patches out there.
> 
> Patch 1 adds a definition for the clock stop capable bit in the PCS
> MMD status register.
> 
> Patch 2 adds a phylib API to query whether the PHY allows the transmit
> xMII clock to be stopped while in LPI mode. This capability is for MAC
> drivers to save power when LPI is active, to allow them to stop their
> transmit clock.
> 
> Patch 3 extracts a phylink internal helper for determining whether the
> link is up.
> 
> Patch 4 adds basic phylink managed EEE support. Two new MAC APIs are
> added, to enable and disable LPI. The enable method is passed the LPI
> timer setting which it is expected to program into the hardware, and
> also a flag ehther the transmit clock should be stopped.
> 
> I have taken the decision to make enable_tx_lpi() to return an error
> code, but not do much with it other than report it - the intention
> being that we can later use it to extend functionality if needed
> without reworking loads of drivers.
> 
> I have also dropped the validation/limitation of the LPI timer, and
> left that in the driver code prior to calling phylink_ethtool_set_eee().
> 
> The remainder of the patches convert mvneta, lan743x and stmmac, and
> add support for mvneta.
> 
> Since yesterday's RFC:
> - fixed the mvpp2 GENMASK()
> - dropped the DSA patch
> - changed how phylink restricts EEE advertisement, and the EEE support
>   reported to userspace which fixes a bug.
> 
>  drivers/net/ethernet/marvell/mvneta.c             | 107 ++++++++++------
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h        |   5 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c   |  86 +++++++++++++
>  drivers/net/ethernet/microchip/lan743x_ethtool.c  |  21 ---
>  drivers/net/ethernet/microchip/lan743x_main.c     |  46 ++++++-
>  drivers/net/ethernet/microchip/lan743x_main.h     |   1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  57 +++++++--
>  drivers/net/phy/phy.c                             |  20 +++
>  drivers/net/phy/phylink.c                         | 149 ++++++++++++++++++++--
>  include/linux/phy.h                               |   1 +
>  include/linux/phylink.h                           |  45 +++++++
>  include/uapi/linux/mdio.h                         |   1 +
>  12 files changed, 446 insertions(+), 93 deletions(-)

Hi Russell,

Since merging these patches, phylink_connect_phy() can no longer be
invoked correctly in ngbe_open(). The error is returned from the function
phy_eee_rx_clock_stop(). Since EEE is not supported on our NGBE hardware.

How should I modify the ngbe driver to meet this change?

Thanks.




