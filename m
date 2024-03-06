Return-Path: <netdev+bounces-78077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA85873FF8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15C01C22A99
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C113BAD2;
	Wed,  6 Mar 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ypTiXU33"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CC266D4
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751000; cv=none; b=b4N3MngYSfif0HtemSqeefL5gwvBl3MSTGjNazqQZX3Z2ByEtfT2E/0J0kJ20UIlnGK2Lqb9OjZnr83dpfZw4+Et/LTnzRtkTrcOqtQS/PVZPBT5ztyy+epka2wBRcCbpqt+c2st+VjW+jON1uIyseZO3UpCZaij788OstysLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751000; c=relaxed/simple;
	bh=3cWlLKNmDCSS1TuqFCTuTkyZPyp4Vtk5QK6kMtTs3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXse/dwDOIhCnQXC/h+iqCrRTJSrafsgroahLBetEEUfaxXnE6cyCdoNkzUQRV3wB/DlmNteQOdzjWgsgzZA7WaE2Iubi6FTaInBQSslxGKZYh6vBsdTMGcCG6/BtRV5qXcrea567QxOzVoUG1g1i25040jbdFaMoEFNjoPZkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ypTiXU33; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PzJz2kED182WsY2J3jUs+JvGdczNjFknZ8A1M4Atc8k=; b=ypTiXU33IxqWi8aBfP9JxX853Y
	CGayuiBAe7oIulpRI49USzwueGLvsij76Xpudm1H/tbN9eun5o1VhU6V6mXjvfAIW5e2961u02bd7
	pf2c3FKB6PgBUpEZM7llWXPOHyuhCYz73or3lkG+H2KSs9X8tgHl/gAEfuxBhQTy/OwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwLN-009WSa-7C; Wed, 06 Mar 2024 19:50:21 +0100
Date: Wed, 6 Mar 2024 19:50:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: update 88e6185 PCS driver
 to use neg_mode
Message-ID: <85e5b128-c11d-473a-82a0-6133efde4c94@lunn.ch>
References: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>

On Wed, Mar 06, 2024 at 10:51:46AM +0000, Russell King (Oracle) wrote:
> Update the Marvell 88e6185 PCS driver to use neg_mode rather than the
> mode argument to match the other updated PCS drivers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

