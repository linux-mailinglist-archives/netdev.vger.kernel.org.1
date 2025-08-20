Return-Path: <netdev+bounces-215257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7EB2DCE2
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F0188FE85
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A8304BAB;
	Wed, 20 Aug 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2A/HxBwv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8702EE26B;
	Wed, 20 Aug 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693640; cv=none; b=ZLPEF7bOgp3wEyCX8uLUHE+Hebj6TNxMtynKHtcIicYs6xmtVTOGH3PiaxhFyjp3gropPRfmyZs48ynJn0baiQD/cfVUMTOc6+UvPwWubNZpOxxmq5cpOM+UM5cghX658DWVl7yk9HDkUjxwPlGPKS0Og+JpAPJwyNvxzCgu7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693640; c=relaxed/simple;
	bh=yJAClHFtugUAoSYRlkNrmIK5gTMOj6YoG4XNGBcvf08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcYyCR6Q47Ud9q1P1inh4iZAay2hQj+ngFZ/hmLoXW2fRe7NNctWf5Us/Ojz7EUEY7ZNC0oe7ZO+FxW+F7jRjCTmwsMonm96FfoD4+7upW8tmErxEtkW4/sCqSBuXV8NSYzIJpgbstxpB1HDw6WV3bZb77yDclQxRujN2i2Az+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2A/HxBwv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kVbzraEkUZs5N2tzXlQ0ET0bZb2r2ls66eEe6HoQDE0=; b=2A/HxBwvAv51G7OTBR2zzIPqa3
	8IlfvLPoioQSRLjjt4FjnoWuIPujPqIzOBJxIF5m4L97lr3fpfVvhLzTz/BYh/gkiN/Ux9QLl7WJv
	L+USSREjxP9j/eYJkeO68cGtRKNcPXXkOt+GoazC031CgSbQKXbPzbZUF5nhxV8OWNqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoi78-005JxH-2O; Wed, 20 Aug 2025 14:40:26 +0200
Date: Wed, 20 Aug 2025 14:40:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: mxl-86110: add basic support
 for MxL86111 PHY
Message-ID: <2bcbb7e6-c085-46ce-a3db-136263c30543@lunn.ch>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
 <eb4e42e02a729a084e2f995c29a08893ac24593e.1755691622.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4e42e02a729a084e2f995c29a08893ac24593e.1755691622.git.daniel@makrotopia.org>

On Wed, Aug 20, 2025 at 01:12:06PM +0100, Daniel Golle wrote:
> Add basic support for the MxL86111 PHY which in addition to the features
> of the MxL86110 also comes with an SGMII interface.
> Setup the interface mode and take care of in-band-an.
> 
> Currently only RGMII-to-UTP and SGMII-to-UTP modes are supported while the
> PHY would also support RGMII-to-1000Base-X, including automatic selection
> of the Fiber or UTP link depending on the presence of a link partner.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

