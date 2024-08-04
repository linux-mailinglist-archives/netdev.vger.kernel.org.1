Return-Path: <netdev+bounces-115596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FC947193
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928731F212C4
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48513AD26;
	Sun,  4 Aug 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4GycfeVi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B447F7A;
	Sun,  4 Aug 2024 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813136; cv=none; b=bRI7x8HkwPpvh3Uq4ip/2UrPsJvS15tdP7tk4TXuVjDft1KSagIsdxcUtikEceY0du0ux8VPZX18xqd0zh7LF1C0ISrWFeZbH1ore/nYANHqljJyfOR4btrJ8sXJ/D60+uzYFdxrQV0SsEo+9tVVVuHX7zadA7kauKCBRrkrRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813136; c=relaxed/simple;
	bh=STSmyuvoEZeIJ76tZn5m21cnBSblhhhAhiOxFGzgZ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs/lfWLXPiIxQKOC/30ClumQ4+f4LWBNJJ1ehAUltibAOaJQuPaGtzv9yuvZxdHGqVXRJPsAMxqRkdQ018RnEm6Bs7uzHwUdyn+SOVO5Yz6aW1n4/9CNX4glAsycdZCgwjOu4qOMuZD6cjsuAwVRlfbVi0eGL2WIDT3oVZjnbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4GycfeVi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uQzw6/bHjvnwxWG9DN+X28Op26Q/VqcHnuYp8+EIB68=; b=4GycfeVif7Ncyp+oeZsfT4sjqB
	77jAhtgCdvNYgnrYFMIPcZ159BeaEEwZKBAGjvJLVY7DLfRnjvb62ab+r09Oyhk7I/XVaGu2kE9PV
	EU9LAS3cC0BHJC9Akw7EpnytsPkwgKalU8Nw3q0HBPawNuaqoqVES7pL/GR29Yn0ZkdA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sakOW-003zhd-7p; Mon, 05 Aug 2024 01:12:08 +0200
Date: Mon, 5 Aug 2024 01:12:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/6] net: stmmac: Expand clock rate variables
Message-ID: <44221c82-b198-494b-b1fe-3f62292e1dbf@lunn.ch>
References: <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>

On Sun, Aug 04, 2024 at 08:49:49PM +0000, Jan Petrous (OSS) wrote:
> The clock API clk_get_rate() returns unsigned long value.
> Expand affected members of stmmac platform data.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

