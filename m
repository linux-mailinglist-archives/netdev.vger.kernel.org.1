Return-Path: <netdev+bounces-247295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC03CF688D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE246301693B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0352225A3B;
	Tue,  6 Jan 2026 02:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDA22172C;
	Tue,  6 Jan 2026 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668292; cv=none; b=Pnt2yD87QilXHHv/5BBeImp8xoAEFQNMNKBl2Woap3Hvudx6A/9t1+2uvv91G7isq1MRiJ0UkjYv1xvuBuFi7Y203LPSMtbhjokR/v9bQPk56Z8oJaMv2wBhjLfihyMHDNA2fI52JCzWqw1BdS2aPqEAahIL8wsxo59NO7cT89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668292; c=relaxed/simple;
	bh=piHqaYT/Pg5JffobCD10YogGqPLXFXxpF9+T+W0urKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7d83mXJ44X3MuYQZKnKnUXuOG9ReGilhJy4SsdF9RoiLxahMIXTGsPC+r5Kg0dBfDHxrSfG/fUzAj659NHQG3xbSTtBRbiLvH9EL5dYWmJ7AN8HyUD0Q5W/VYGbaEiPy86zoc1f9dYMUaUrUDJ9xJE/J57GPFM2CbQcnOBS1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcxGi-000000003tJ-1qgp;
	Tue, 06 Jan 2026 02:58:00 +0000
Date: Tue, 6 Jan 2026 02:57:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 2/4] net: dsa: add tag formats for
 MxL862xx switches
Message-ID: <aVx6NABI_8gEEysQ@makrotopia.org>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>
 <20251216203935.z5ss4sxbt6xc2444@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216203935.z5ss4sxbt6xc2444@skbuf>

On Tue, Dec 16, 2025 at 10:39:35PM +0200, Vladimir Oltean wrote:
> On Mon, Dec 15, 2025 at 12:11:43AM +0000, Daniel Golle wrote:
> > the actual tag format differs significantly, hence we need a dedicated
> > tag driver for that.
> 
> Reusing the same EtherType for two different DSA tagging protocols is
> very bad news, possibly with implications also for libpcap. Is the
> EtherType configurable in the MXL862xx family?

Only the egress EtherType can be configured, there is currently no way
to configure the ingress EtherType the switch expects to receive on
special-tag packets on the CPU port. MaxLinear, however, said they could
in theory release a new firmware changing the EtherType to any suggested
value, but it would be incompatible with existing downstream drivers in
the field, obviously.

