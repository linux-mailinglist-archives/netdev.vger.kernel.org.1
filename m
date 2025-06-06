Return-Path: <netdev+bounces-195345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A0ACFAC1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C22F3AB506
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A233086;
	Fri,  6 Jun 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbnJ6vZI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310D4C8F;
	Fri,  6 Jun 2025 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173671; cv=none; b=qbuAk1FVempo334frwwSiD0lQI3Qeu16G8etmWtmEZXbdQlPbVu67O/Yjn2vHRNjO2bBWUOeAP+H2TXX1TKdCi99prKuRliz4ln/8meL2uZFAhKRsBtccukEx0G0QdiiXFNrmomKw4PzZDqPwxn3GvUAmtYOKsxSNhtg5uI4WFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173671; c=relaxed/simple;
	bh=ngJ9SSrUin6QJix+m8AJArBuNLj/I4InKuWeZdUwPeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TelHo3nNj8ArV4/gJOEzD0l+VP9UorN/DCYRZJiSXU5keBRB5+kxKaJ0B7bTQ3y5KwsqLd9zAYRFVHDD35vwg9ues6/1BaqfDorMgCw9xyGaUj2jxypv9LnUpD6OMdsP9RV6iDSbn/tPuwvgbbnlFNp92QS6MaYBzCvc2wo85Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbnJ6vZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32465C4CEE7;
	Fri,  6 Jun 2025 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749173670;
	bh=ngJ9SSrUin6QJix+m8AJArBuNLj/I4InKuWeZdUwPeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbnJ6vZICLLgzGsTPkPEalYDAndRokwH+RAKSBtB9Pw9X2Vy16IPCH8p5ltAztgvJ
	 kY/b7IcNiT9d/QAf7kLtlVHNWOclLr8BNRHt3bqN8QMWtL0OPH8mPeL6lP9Wo0UQD9
	 BTGV0G/1bYH5jg9MHLWEeZTDPosk77VE73ENHECkM0ZlQ3MXuiO1+vG5jCEuCCR+9J
	 gEjLFYW9SVRus2Nr/uVu/o5w8uC+KqJ9nSKT8LZvlEAFTa1bbwoX4qyndMCYJ3Jdtp
	 ga6X33co9jJiYRTOGyH6lAlSklKXCFLESFdus6sNZ7F9/kghSC507mGXObj0vWGS2X
	 F5sJXDOMauFeA==
Date: Thu, 5 Jun 2025 18:34:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 08/13] net: ethtool: Add PSE port priority
 support feature
Message-ID: <20250605183428.3bedd020@kernel.org>
In-Reply-To: <20250524-feature_poe_port_prio-v12-8-d65fd61df7a7@bootlin.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<20250524-feature_poe_port_prio-v12-8-d65fd61df7a7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 May 2025 12:56:10 +0200 Kory Maincent wrote:
> +	if (st->prio_max > 0 &&

and here

