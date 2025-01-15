Return-Path: <netdev+bounces-158511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F65A124BB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D37188C394
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B52147EE;
	Wed, 15 Jan 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ij3Sj/Tx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F62459AD;
	Wed, 15 Jan 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947834; cv=none; b=OL4kcIUSsCB0yB8RikglJ2+3A+oAcx54LNMnlO/Ik8Eicks+fpv2mqc97eAGbNphx6QSXXLQhFkCwXKeVbUzdbrskdMYI3gw/Z8j2G5sF6op02qARMcxL96il3kkXO5WTitKx4/vUu7bydnNLCDMJkT9B8T6i/Paw83/0MivtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947834; c=relaxed/simple;
	bh=0fP2qXYJ9uOGdVghTyrI4O9YFrOe+BcwZsEGn+X/AOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9EApoFyeMe+lTYcwIJWOYzupau97comCd3G9LZF8XO8a6yiJAmi86ecygCcg/vyLwnDglOzeEZ3Sq2e7Wtn40pRhycX08iPV0099/2EhQo2MaKJSU9IqFLj/Iv5oQVvYbQO+tW++zoXycfErC4IeX9OYdbvVYU3xoXbPyoHuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ij3Sj/Tx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Jxfu41iCy3/Xl/2SlMHlq/E6+bEJVMK0dEbie6RGZA=; b=Ij3Sj/Txb2dxOJgo3P6GgArB+/
	dEwiCa+37ZNiUwU0vMWkSRkhXvTogV3InoFtWWh2wqagd9Zjs5v4p5SaaJBMjx4HbDjyeWCYxm17j
	gkhD2tSn1E2sWqOKsblQoPD7u3iP/onq5igWETBEd8eJ9Cp0Wr9GQFrhWHjEi4xkdokI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tY3TA-004nPe-5A; Wed, 15 Jan 2025 14:30:04 +0100
Date: Wed, 15 Jan 2025 14:30:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiDlm57opoY6IOWbnuimhjogW1BBVEM=?= =?utf-8?Q?H?= v2 05/10]
 ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <f28736b5-f4e4-488e-8c9b-55afc7316c5e@lunn.ch>
References: <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
 <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > I already explain how this works once. Please read this thread again.... The
> > MAC can apply the delays, but it must mask the phy-mode it passes to the PHY.
> 
> Yes. I have read these mails.
> 
> I understand what you mean.
> "rgmii": delay on PCB, not MAC or PHY.
> "rgmii-id": delay on MAC or PHY, not PCB.
> 
> ftgmac100 driver gets phy driver handle from of_phy_get_and_connect(), it will pass the phy-mode to
> phy driver from the node of mac dts.
> Therefore, I use "rgmii-id" and the phy will enable tx/rx internal delay.
> If I use "rgmii-id" and configure the RGMII delay in ftgmac100 driver, I cannot pass the phy-mode to 
> phy driver.

Quoting myself, yet again:

> > MAC can apply the delays, but it must mask the phy-mode it passes to the PHY.

If you decide the MAC does the RX clock delay, it needs to mask that
from the phy-mode, otherwise the PHY will also do it. If you decide
the MAC does the TX clock delay, its needs to mask that from the
phy-mode.

	Andrew

