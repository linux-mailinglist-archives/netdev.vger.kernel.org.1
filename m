Return-Path: <netdev+bounces-141232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F289BA18F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D135B2132A
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691C171E76;
	Sat,  2 Nov 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a+WJc3N9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D93C3C;
	Sat,  2 Nov 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730567006; cv=none; b=NMOqT+unrfb7I6m2uEI5ymIAG2gZ7iOrrHuR79FSDor9FmWLouUXtKFi20OZxxVBy7yws+z75hUI9JVleROkbmHRWOIW+FHAk5cMgB6mzseDGWXRagtO4vCNOmHvHVQMz69+moRQkDwAgRaJxZXlMqYU82k5fvtQQbv0dQrsN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730567006; c=relaxed/simple;
	bh=3ACyveipojrmN/PCwvTW+IDNBtMDqVzAv3GYyqMlnnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug5NdPKpOaBE5lm6JDgr3yxU2iFGWo5b5h73IvEtB9GO87lN7z5R1qMB5eEahnemXMCN0iCsdth9AZ8pdCLGiEHLsIKbkQs9GaHUN4orINar56JTY36TSFfY7WCz6SaYN3Aj3ut/DwtU3kdUecuMt6cCSE7CpEexXzBlaCNvw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a+WJc3N9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oP145i++rm3i2laxEVa359PHCFb5oUOJpBrFpEuBJ1M=; b=a+WJc3N9qNmtacwniYwmxwDHVN
	xqvPt+s2LOmnUSYO60hBDVX0j+AW0FKNozh9TP29H9qGWwYeX8PFZdtCnvOeA95G48OM4fyme9UX6
	hDErdMtyCWyLjHx/PJeitK1U2L2QJYOv3aK9PiJO6arFCcL+IuE/cGqUPLAzIszG6454=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7HWl-00ByYT-4p; Sat, 02 Nov 2024 18:03:07 +0100
Date: Sat, 2 Nov 2024 18:03:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	tolvupostur@gmail.com
Subject: Re: [PATCH] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
Message-ID: <900d2449-ff88-45ea-9b29-da145541d42b@lunn.ch>
References: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>

On Sat, Nov 02, 2024 at 04:15:05PM +0100, Diogo Silva wrote:
> From: Diogo Silva <diogompaissilva@gmail.com>
> 
> DP83848	datasheet (section 4.7.2) indicates that the reset pin should be
> toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
> make sure that this indication is respected.

Do you have the datasheets for the other three devices this driver
supports? Do they all require this flag?

	Andrew

