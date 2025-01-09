Return-Path: <netdev+bounces-156754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B6A07CAB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D451653CF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6943B21E088;
	Thu,  9 Jan 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlheHF91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3421D5A5;
	Thu,  9 Jan 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438369; cv=none; b=R4wlC5n4hMgvt0RqFyTCKhROZdf3V9bJewpm6CRgfsxhNl4n8DVpKVY5mPavPpgabazl+xhDKfbtQ1/p4tK9agYbVwXtLw9XKQvZ0EWJfC14ZT9ptGmUfnXlIwcXusKoUs12APnMHDxQ3B1ZvjDZj/ks10ACiMRaqbbhVhY+xjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438369; c=relaxed/simple;
	bh=6rJdDDGZqg0Yf4aYNo0QnolT8D23SVAI2YfvGyqd7bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzUzM7fATQBWY9n5w50nb2FUz+lF/gpZl1j+J7583zt8ibn9ST7hSriHl6Chvgw0LhEyl2mQURSEDhlBgNA2VHgIQsA4cmdnWczlHZ4VNRiWI28mqXBACqiSD6j1ULgFKivXoe8tVTQvvcAoSoIU50ad7FoPOX0L1xd0EyoFEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlheHF91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04573C4CED2;
	Thu,  9 Jan 2025 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438368;
	bh=6rJdDDGZqg0Yf4aYNo0QnolT8D23SVAI2YfvGyqd7bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlheHF919gjywUL6mtdPc+PKN/aYM8IzYd2pXgisIZPcsb2x3ao18GxkIAi1vHMkW
	 mdkKbPc4LM0X7n3f4x3usbEs8MtAzM57ti8Ojo0G/aKakjGXNnYwAEt4y6DVBi7cqg
	 GrkrLE3rUQFSFVVVMU3kOE+k4yCcWtfxd5pdrywE8LeDdL9N73xF5D872Gv4xG0GZ1
	 HsKRY7th+3tK1AnDa/cfY5PJTG5ZKR/FCllmKB7Q0NZuOzZeb5EmbmuZJ8qmpjRnYT
	 DZOFVElKo7wfwh2wnuksJ67oSgaXdJXTAqu/6ru4EIKiw79uefgr/W0KinFqkFcKOL
	 HynysvA6Zu58A==
Date: Thu, 9 Jan 2025 07:59:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <20250109075926.52a699de@kernel.org>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Jan 2025 11:18:05 +0100 Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for a PSE device index to report the PSE controller index to
> the user through ethtool. This will be useful for future support of power
> domains and port priority management.

This index is not used in the series, I see later on you'll add power
evaluation strategy but that also seems to be within a domain not
device?

Doesn't it make sense to move patches 11-14 to the next series?
The other 11 patches seem to my untrained eye to reshuffle existing
stuff, so they would make sense as a cohesive series.

