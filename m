Return-Path: <netdev+bounces-157445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA96A0A51F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C49168F0B
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336B1B4237;
	Sat, 11 Jan 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yH/jvYcX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345251FC8;
	Sat, 11 Jan 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736617465; cv=none; b=pBiyi50nCyJcI0N/CRBfXoa92VSSdlI2vTPjJEW1t5nJGUbULUvKCIic5mKGyiIlvh5gsmLcrejDfFQZDe3eS5w3Izu7W1rORUCVp4Uc2jA+IJZR8p4AmxChSuMeqLrMk+/jGDf3WPT27fKcuOarLkV6+1m4lRs4JrQlEMFLJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736617465; c=relaxed/simple;
	bh=eJhJ8mkn+p/ocHaeHrWJ3A/XLrg7E+3BulN4WRdfZyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjPOIjiyIRz/P1NgD47aAYYY33lj/vHnx3RMosY4cw6/NA0L1iA2xj/wbAT/BzCowDTJP1Borv0MMGhou8/HdaSRHeOGIJGYe5NQL7+jyCg+/68mnI6k9KU07n3++tpvDjIy6y/BeZoYB1h/O6AFnTQeujghLdw6C2xSIIBTLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yH/jvYcX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HQq70dNwMW7hxKMV+uX3GvqMWngpCl13d6E+iJ2SuUM=; b=yH
	/jvYcXMCnSAU0dLQHSy5kdKwV1ay7BatVpZbYVgdYKeDKWVT8qslvFWCHmt8HpqFgjbg3RNYhB/iI
	9YrjupIFOr09bP+1FOtaRxL202LE+FDyDQnAwgmBqvqJITId4Y0pAeC0ulh1vvi0UDWptA507oPu9
	zzcUBRzAdDJFUHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWfWt-003aVV-6L; Sat, 11 Jan 2025 18:44:11 +0100
Date: Sat, 11 Jan 2025 18:44:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <eaa27d71-2532-4060-8d6d-db0c76d16876@lunn.ch>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
 <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>
 <0adfb0e4-72b2-48c1-bf65-da75213a5f18@lunn.ch>
 <e8bd6c18-1c71-49b0-a513-e38bacac90e7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8bd6c18-1c71-49b0-a513-e38bacac90e7@gmail.com>

> On my system the over-temp threshold set by the BIOS (?) is 120°C.
> Even w/o heat sink I can hardly imagine that this threshold is ever
> reached.

So this is to some extent a theoretical problem, in your setup. So i
would not spend too much time on it.

	Andrew

