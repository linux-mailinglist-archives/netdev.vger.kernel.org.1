Return-Path: <netdev+bounces-175300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC8A64FCB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE9318910AA
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040623A982;
	Mon, 17 Mar 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zWSxkV0Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DC149E00;
	Mon, 17 Mar 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215976; cv=none; b=lhlX/bDD4y6uuZe3JZLkhZt7agGzMCNeDMnPOabQ8uZddJFNeDvt2GG1g92+vzEW+FhA2FVgyPAgQzdAVhDvUz6ohrhh75TPAwCNx4WEamsAHYFmc8t13EW3uAlc21OtP1ngJDSCX10TLv9c3CUS+7BDZwZLbkS9Ob237DlxKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215976; c=relaxed/simple;
	bh=3Q69/D9Rd3DmfgKV2WC9fKZgHhcyfl6HFbdij0haqEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ouxi2sl8rvX+YlriCy9HIg9cHCwrKXxbR1EPQm+CC0TCWC2iv0a8sWjE7+KdSteKGSst4o5mdJ3n8UZiXS+beGc5idKfH6oWB0n+Jbmw/56qu8TC1ORt7UyEd44TwTx4n+1bnmrawPuhQBK5MWE2OgYgbkP4Ry7jkvogSdrNZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zWSxkV0Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dq8TNjOCjLs57PNkzG69jW5zDo7b4i7oIyvx27qBQHk=; b=zWSxkV0Q5r82QAJmVgOTeKBxX2
	QlJGtpW4wD4DoQLscaef5r+m/p6377j9uwUH2+sJG2lRQB6I7jpkoaao+92cm5D/467eylsaMCJL3
	YxPYpQf11dRIFZXHQeE50Chsa3rVeV9qtiEe4T6XdNzXdxxT9saD/JiNxDAz7smLprOc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9xP-00689D-H9; Mon, 17 Mar 2025 13:52:39 +0100
Date: Mon, 17 Mar 2025 13:52:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 4/4] net:
 ftgmac100: add RGMII delay for AST2600
Message-ID: <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> The RGMII delay of AST2600 has a lot of steps can be configured.

Are they uniformly space? Then it should be a simple formula to
calculate? Or a lookup table?

	Andrew

