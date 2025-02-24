Return-Path: <netdev+bounces-169040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52DA4236E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E0216A523
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA0D2586CF;
	Mon, 24 Feb 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT5k6XKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDA257459;
	Mon, 24 Feb 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407570; cv=none; b=OcyxVvYD/nraECfuOfrycgZ12eo/KqQzJ+5Jv2P6+2xLPIwnQcplQuqGdQBFax+yAX8WxkoeG1Bk+JO8IE2Dhz9emRBjjWUgAWPo0zbybMEMwSdEhN9lvIbeNE3j/FabGxpJyeWD0/99AqPUdZKq5ZOynn39bc6Jq1quxZHRMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407570; c=relaxed/simple;
	bh=loUIEO2AC7Kh+BeI5l4HVh2nj8MVsKVBozbddWhyxsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLnQ6CEJj1mppfV5XAqZu9EIxfrr7XnZUGGZwuzEIHbSxB9aYTMaaAiPlzKCZoa898oy/QhA1kyT7QBM15sgU1mkCV5LYd2i1AkQovV4O068duKFuHb+n6PpBbfYkTVptYnW2IgP427nK/ZOdBhGhQ1gQ4iYNtO/D3XMVEyjPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT5k6XKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A837C4CED6;
	Mon, 24 Feb 2025 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740407569;
	bh=loUIEO2AC7Kh+BeI5l4HVh2nj8MVsKVBozbddWhyxsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IT5k6XKCTKrb/qaWvhvZOi56fzZdXweZQi5AY8FEpjtPbCJTddi9Hnl/seaYS7qpP
	 6ffqH+L3sOnuVSLZYUlM3nobFHTWWWzDf30je3tCUlRCIeUJRauOIyxdLWzvI7tyap
	 EYR5xIZa3x9WuwcEGdO8/luMfQIcNauxgjuZBlDxjGI1udIN1HKyvDYa0Uf3bTCZ7Y
	 tzptPy3GyHxFUdcpgmzP1J29ejgd9w7tL1fxSzSoAF5dsaIijbgUZfuUceJUANN9jC
	 yXul2g/7y/9oS0fziew8VAZQsf77f53fU4aCuCJEuhmXzULXDdRA3xqFfTfv/2vPlI
	 Gd7eyn84Pk8UQ==
Date: Mon, 24 Feb 2025 15:32:43 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, 
	Romain Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <kqur446k5sryspwh4zzndytfqhpupfybimhgbtq5m7fm7vom7s@hhqlh3llrsxl>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
 <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
 <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>

On Mon, Feb 24, 2025 at 01:48:19PM +0000, Russell King (Oracle) wrote:

...

> "Please note:
> This hardware is broken by design. There is nothing that the kernel or

Doesn't "broken by design" mean "broken intentionally" ?

Marek

