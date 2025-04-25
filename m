Return-Path: <netdev+bounces-186075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF4A9CF77
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B7E7B45C6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960511F872A;
	Fri, 25 Apr 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaF3QWKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031C1F76A8
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601912; cv=none; b=iMEqrDv2FEdtB3enSTfM399C1VCTPmqys1k1dxlVviCwr1/qnaRwo3aKOgpaWnd3BpkElOZ90yTkusRdz+GKJ3a7cB1f4b2U2mElqeSdtcbtXX9xQQxi9znFtzdRJFaf03lCkofHsUjGC2vFCrmTsgj0jMy9oU0QnEnKm5QA2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601912; c=relaxed/simple;
	bh=KylaNQkH6tMOZe8HcHzx0JmsNcK/kkz78+re5XMQi+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqSEkX50wIqu0+hftKzGCawzONAHA+lNHbtbYaKFhBVP0s3ZFhBAtY1u/BoVz0zXhncWf8Za+/ZzWtx9UEebvszkxTiU9PrBBf49vBNNIBk6CzlsmwUrwfSTVNLFXYZ+DE91FyIpQpK7hFr8f6Ku0wCg81hWQae5Ma3/MWceetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaF3QWKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBB8C4CEE4;
	Fri, 25 Apr 2025 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601910;
	bh=KylaNQkH6tMOZe8HcHzx0JmsNcK/kkz78+re5XMQi+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaF3QWKuT29dv+UI1g6W/9qM220T6ts/2LPfUvhhzlsNvEGkwfJh0yr3WhiBtqu8y
	 0Bm94OBal52GfsnM90BhGgDfKL+V45uElOix5hBlZ8d+jWsA11VJHGNtFowgCY18Vw
	 M8nEMxBJfBFK510eI708p/LJ7h36E0kZx8lEULnBbBwe8FpurtlS9G+PQJl32RMNCR
	 /lKnWukw9/8e0TcL+jLJMnPxyTRbV0eAAPGKEUDLE5HRydViSRXjVgo+E3bUTfhnvS
	 DDlM/44I9k/UsWT/ZE+85kP90aAE77d6B2s/KSUDEEqCTEfOLOeZs6pOfdwOpzNjP5
	 ZdagcawOvV/AQ==
Date: Fri, 25 Apr 2025 19:25:04 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Wojciech Drewek <wojciech.drewek@intel.com>, Matthias Schiffer <mschiffer@universe-factory.net>, 
	Christian Marangi <ansuelsmth@gmail.com>, Marek =?utf-8?B?TW9qw61r?= <marek.mojik@nic.cz>
Subject: Re: [PATCH net] net: dsa: qca8k: forbid management frames access to
 internal PHYs if another device is on the MDIO bus
Message-ID: <6zkm5l7wscrba2kkbpp5lhr5qeohj4vvd4rbnwrcvzyx6j7ydh@lw5rb22jheme>
References: <20250425151309.30493-1-kabel@kernel.org>
 <e4603452-efe9-4a56-b33d-4872a19a05b5@lunn.ch>
 <eetsgqoq2ztgeo34kvfi732qkpegujwiy5uavpc4jognzy4mrl@owxpxsrvlwhv>
 <fd5dcd78-8eb7-4b60-853b-4f3d318d2e6a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd5dcd78-8eb7-4b60-853b-4f3d318d2e6a@lunn.ch>

On Fri, Apr 25, 2025 at 06:53:21PM +0200, Andrew Lunn wrote:
> > >From the ASCII art in commit 526c8ee04bdbd4d8 you can clearly see that
> > I just assumed there is just one MDIO bus, because I saw activity on
> > an oscilloscope. I didn't test it the way you now suggested. I also
> > didn't think of the consequences for the driver design and
> > device-trees. If we prove that there is just one MDIO bus with two
> > masters instead of two separate buses that leak some noise in some
> > situations, the situation will become more complicated...
> 
> It is not really that more complex. Some of the mv88e6xxx devices have
> a similar architecture.
> 
> You need to throw away MDIO over Ethernet and stop using the switches
> master. Because it is async, it cannot be used. The switch MDIO bus
> driver then just issues bus transactions on the host MDIO bus, using
> mdiobus_read_nested().

But this is just in case when there is a separate device on the external
bus besides the switch, right?

The access over ethernet frames needs to stay because it speeds up
DSA operations. The problem is only on Turris 1.x because it breaks
WAN PHY.

Marek

