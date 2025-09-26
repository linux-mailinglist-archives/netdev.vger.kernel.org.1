Return-Path: <netdev+bounces-226566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAEBA22AF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E061C24221
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A301B4138;
	Fri, 26 Sep 2025 01:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMB7Xx91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBEC8FE;
	Fri, 26 Sep 2025 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851553; cv=none; b=ceX6zfQ5lDvavP9mURkD5NnjLIhH6x9U5mPN9H6AHXTJbFNbwL1IkjRBIrJ9Sih0yQbDju1gkbFZlt0QeHlPygXzvNSrajf7MO+RYMlWOqx1Ugof32qemSjsQe7Uxs4yyy2V0eOxw1VB8BbPyhDE4jJcNr7LtI8HxGo88CAH3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851553; c=relaxed/simple;
	bh=O8SEbiV6bsY5wk64SP2GhKRTTTiaEXDFSuX28Ph1mjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2tiPQ++/b5BCjieSXl61yfY5CK/TAob2EKb2YCJWjaPJLcqSs/mQACmgRaH3s0S6cu+hbaGoHYGvxtT+EkRMHgGZkaDSTKwOospe4ut8GWTgoV3pvf0bjbKsHzJZyF/mN9HyhxyD0fj3uMmkMLXfPSE1YEai45i5uGMTn6+bMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMB7Xx91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C302BC4CEF0;
	Fri, 26 Sep 2025 01:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758851552;
	bh=O8SEbiV6bsY5wk64SP2GhKRTTTiaEXDFSuX28Ph1mjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMB7Xx9105TLqKoh1eoqR0qRNhgr14jO3tRI1OchdSW2gQCzp3jbBaNCQqBxfDSNg
	 KqqJFu2EKPQMUEOdCOx+tlE0pubYwQ2IqPpHXDmyB1j5P7y0+6Q7grJymYg5sANG6d
	 uH7lsHvSva+WWyHgufaCC9jStvSoFTJhTtUG2umoHBevxEIicsu3OcTgo0uSqOMisS
	 3RS/BzofuflXzDC0oHFqgOPSkD9a8Glc0SpTQS2xoPSLXl3C9wmNkIyBDPGkYYWMpJ
	 NvJnOcYkzd7xM76Ql2RLLL/0oE1jdFecH0EOm0jhiyRDvMWemB1IcNVw2MSSODcbS9
	 MfnadFklajciw==
Date: Thu, 25 Sep 2025 18:52:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Rohan
 G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <20250925185230.62b4e2a5@kernel.org>
In-Reply-To: <157d21fc-4745-4fa3-b7b1-b9f33e2e926e@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
	<20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
	<20250917154920.7925a20d@kernel.org>
	<20250917155412.7b2af4f1@kernel.org>
	<a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
	<20250924160535.12c14ae9@kernel.org>
	<157d21fc-4745-4fa3-b7b1-b9f33e2e926e@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 16:33:21 +0530 G Thomas, Rohan wrote:
> While testing 802.1AD with XGMAC hardware using a simple ping test, I
> observed an unexpected behavior: the hardware appears to insert an
> additional 802.1Q CTAG with VLAN ID 0. Despite this, the ping test
> functions correctly.
>=20
> Here=E2=80=99s a snapshot from the pcap captured at the remote end. Outer=
 VLAN
> tag used is 100 and inner VLAN tag used is 200.
>=20
> Frame 1: 110 bytes on wire (880 bits), 110 bytes captured (880 bits)
> Ethernet II, Src: <src> (<src>), Dst: <dst> (<dst>)
> IEEE 802.1ad, ID: 100
> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 0(unexpected)
> 802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 200
> Internet Protocol Version 4, Src: 192.168.4.10, Dst: 192.168.4.11
> Internet Control Message Protocol

And the packet arrives at the driver with only the .1Q ID 200 pushed?

Indeed, that looks like a problem with the driver+HW interaction.
IDK what the right terminology is but IIRC VLAN 0 is not a real VLAN,
just an ID reserved for frames that don't have a VLAN ID but want to
use the priority field. Which explains why it "works", receiver just
ignores that tag. But it's definitely not correct because switches
on the network will no see the real C-TAG after the S-TAG is stripped.

