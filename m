Return-Path: <netdev+bounces-251103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00AD3AB3C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98EE43000DF1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42E35BDB9;
	Mon, 19 Jan 2026 14:09:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66273587B9;
	Mon, 19 Jan 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831746; cv=none; b=BDt58V4S34Tr8TJPwkEYcnZQHwCsShC1f3YmX4YVPtXs3mTbslc9uPhdNyB6NGvANLKCB04hDhhNBss5eSR19Z91xy+g0csWoUpijkia5Fa/OsFmLmDEgnItjlzWkffl24yr/D84aJKZ/YNKHNVW8lNh9FKS9lV6dOGZAb1Dk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831746; c=relaxed/simple;
	bh=Axt2OkWGrdtO9W/2DGAOgSNtajlpbHvAeranRu0GADo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAvZ1xqDMHUmqPr5qlHjoM0qwsQ14ebk4naXr1l7ZIHPWKoxrPFcavW52lZq5GweVDlA4BsuZm3wnx0P7Cg4ZgI/UPemi7JPsexOtx4zOiiud5ub/B/NMkGz0rOIrb2pjGyQaUTIrz0VG2Qu/AjTt21STytivxx6Z/66C6rtVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhpw3-0000000074z-48At;
	Mon, 19 Jan 2026 14:08:52 +0000
Date: Mon, 19 Jan 2026 14:08:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: intel-xway: fix OF node refcount leakage
Message-ID: <aW467-D-2oBzFOY1@makrotopia.org>
References: <b6fe8f6a1c7cf190b899d99e0e3a1e1370f50496.1768708538.git.daniel@makrotopia.org>
 <02a2c8a3-3310-4e12-aba2-0dbb3fc780a5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a2c8a3-3310-4e12-aba2-0dbb3fc780a5@lunn.ch>

On Mon, Jan 19, 2026 at 03:05:54PM +0100, Andrew Lunn wrote:
> On Sun, Jan 18, 2026 at 03:57:04AM +0000, Daniel Golle wrote:
> > Automated review spotted an OF node reference count when checking if the
> > 'leds' child node exists. Call of_put_node() to maintain the refcount.
> > 
> > Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
> > Fixes: ("1758af47b98c1 net: phy: intel-xway: add support for PHY LEDs")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I guess you meant to put your Reviewed-by: under v2 I've sent yesterday
because this initial submission has a fat-fingered Fixes:-tag...

See
https://patchwork.kernel.org/project/netdevbpf/patch/e3275e1c1cdca7e6426bb9c11f33bd84b8d900c8.1768783208.git.daniel@makrotopia.org/

