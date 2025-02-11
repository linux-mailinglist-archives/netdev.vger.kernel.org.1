Return-Path: <netdev+bounces-165183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD42A30DBA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED381888F9C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5FE24C67A;
	Tue, 11 Feb 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SUQXAHgp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647624BD0A
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282742; cv=none; b=khxczMnMyfsK4JA9FgRd8+83PDmscWapnV1hTq7lxJ5+FhoWDx7YjZajLq1LwG74V307id/2flFt7YabCV1BI1i3+In9l+Qqk+oOkBeIySgVWjd/uTgtaJgJqQTCRQaW3NIcprle4bnTIUnRG6/lQwuMQdXg+8oM87IAZ5GEYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282742; c=relaxed/simple;
	bh=g0zK6kL2LrrKB/b5jBFWzYGKTNFeNoDa9wVuD4RFn9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjq1oDR+KKWFj7nuaPI7AoMoWox0Memu+2HGS5KCczx6Gth+a3cajYFs4GIG/SLdQ5fjnLxudwur4A/uTHzmjZcrfvt11MCJL+uhWbjaW/f0ELX/n7+uwovjuVSR8XuL5pX09pdBhz+96X3zjrTDjREmZtxK+7M7owC7YU+uf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SUQXAHgp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aZG8YMfO0GGrm/guuA7TIuCM9amNy2d3JRmx+de4M9g=; b=SUQXAHgpSH7DkoG811Hi2TbhHQ
	2svV/4/1dg4ztwKJyvAwy6HVnj8GfAOLIixGb9EbYv1TlhOSc8FsSI4V+tnaZX9+nRdxlYp1uDtER
	Iyc1baAdBFDz1uBVSpgL1jbJXV3ggwzebvdBfThMAVqmxjVREKsA5hvG931w035ZARmU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thqtL-00D4vo-5e; Tue, 11 Feb 2025 15:05:35 +0100
Date: Tue, 11 Feb 2025 15:05:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: rename phy_set_eee_broken to
 phy_disable_eee_mode
Message-ID: <ab9e9d4f-e563-4d6c-8c02-b352ecf20086@lunn.ch>
References: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
 <30deb630-3f6b-4ffb-a1e6-a9736021f43a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30deb630-3f6b-4ffb-a1e6-a9736021f43a@gmail.com>

On Mon, Feb 10, 2025 at 09:50:10PM +0100, Heiner Kallweit wrote:
> Consider that an EEE mode may not be broken but simply not supported
> by the MAC, and rename function phy_set_eee_broken().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

