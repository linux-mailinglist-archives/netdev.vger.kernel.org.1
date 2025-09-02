Return-Path: <netdev+bounces-219297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E6B40ECC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4905E75BD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7B2E6CAF;
	Tue,  2 Sep 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUiOR0cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7F26C3A4;
	Tue,  2 Sep 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846126; cv=none; b=a5R45yTvE7FAn2fiUpQIdATHSbtdL0KBaxF8drU2stAJPthP02grdnimA5rDqZ2JxWd1rnxUg9qd0qB4+spQ6aSAt0PBb+7mIgr84R7kBM/OgyE8Tyf67gmKyqcPv/OQU+Cs62lRjZO8cJD7krE/ceaQHYm8SYkhNWjKdl6ZyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846126; c=relaxed/simple;
	bh=Ko89yqThQbtEVD/Z6qOUqkc0NWxBpqJX4NF3Pv6PF3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/wZV9Vn12KXbHLIXZgj7Kc6YM1Mq5yaaL6LqP1U5UVqP+xC/dxQ8FIsgvbQqPp+lEjghfkTZZT+lPkZ+GUc1UcJWe/PXRUYTzlR0uC9wycY5jHJvob9B8SSS5lYeTeKwZq83sQjmUCd+unRyqJdP3fydjIZGeVBb4+k1Sdzk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUiOR0cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B7EC4CEED;
	Tue,  2 Sep 2025 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756846126;
	bh=Ko89yqThQbtEVD/Z6qOUqkc0NWxBpqJX4NF3Pv6PF3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nUiOR0cbn66EUQdHnk6+dq9j3saxVLgS4v+jfDCG4UNDl5JhNL+YaW+Yx9WQtyBho
	 NqRTwW19embFDgLRAFUj484i/somimOZYvffPVHB+LjgjBMkZrG923xUcaJ/ErqtOd
	 L0b8S/gx/58nEPVbSAAtHvk1BDmaHP0tOHzCg6ccimSVAs1vT4DJjgaXVqEiQDnxY0
	 HLlvDGz6PGaT3HV1CcSlA062QgzUkqx+De4oUQTN/iUEexf47B1PNw0Wy2F5DVWj8F
	 rSIgiibW6wWozZX3P4rTIakAUSbwcRgBI8PQFaRkNWK978zceJAGNPIf+tG/l0qn4v
	 eD/XOtKxs80kg==
Date: Tue, 2 Sep 2025 13:48:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <20250902134844.7e3593b9@kernel.org>
In-Reply-To: <20250902134212.4ceb5bc3@kernel.org>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
	<20250901133100.3108c817@kernel.org>
	<20250902164314.12ce43b4@kmaincent-XPS-13-7390>
	<20250902134212.4ceb5bc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 13:42:12 -0700 Jakub Kicinski wrote:
> On Tue, 2 Sep 2025 16:43:14 +0200 Kory Maincent wrote:
> > > Sorry for not offering a clear alternative, but I'm not aware of any
> > > precedent for treating devlink params as action triggers. devlink params
> > > should be values that can be set and read, which is clearly not
> > > the case here:    
> > 
> > Ok.
> > We could save the configuration for every config change and add a reset-conf
> > action to devlink reload uAPI? The drawback it that it will bring a bit of
> > latency (about 110ms) for every config change.
> > 
> > Or adding a new devlink uAPI like a devlink conf but maybe we don't have enough
> > cases to add such generic new uAPI.
> > Or get back to the first proposition to use sysfs. 
> > 
> > What do you think?  
> 
> If you are asking for my real preference, abstracting away whether it's
> doable and justifiable amount of effort for you -- I'd explore using
> flags in the ethtool header to control whether setting is written to
> the flash.

PS. failing that the less uAPI the better. Tho, given that the whole
point here is giving user the ability to write the flash -- asking for
uAPI-light approach feels contradictory.

Taking a step back -- the "save to flash" is something that OEM FW
often supports. But for Linux-based control the "save to flash" should
really be equivalent to updating some user space config. When user
configures interfaces in OpenWRT we're not flashing them into the
device tree... Could you perhaps explain what makes updating the
in-flash config a high-priority requirement for PoE?

