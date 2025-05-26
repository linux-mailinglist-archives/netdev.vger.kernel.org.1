Return-Path: <netdev+bounces-193425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62ABAC3ED6
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819FF164D02
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A761C8601;
	Mon, 26 May 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="Kb0YmD12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkjDVazK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F4158DD4
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260086; cv=none; b=Q6ZdCf8r0sedggZ5Pog86L3p02CtfArPgK045fu95H0e49Xf80aRMyk8rXA4QGUltaggWrEgBkqUHQ2PVH8/3Lt5G67QHVfIcp6NQm2rQnkYvwBIkjmtTuk+boZDlHLSyDyYtUOmf10nn6hKMdVmIw3faw5oIDyrNfncMOWVg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260086; c=relaxed/simple;
	bh=/IOOB8KFr2AThigSN9CiWRGlON+ps3AKfam1f76YkLI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=dTdlJk1Of5pvKipCPN6QlZrnW90Uf6Wfn/mCCey6V7VXVUcjUWKBDGYJKQ8zERn6DoFy5qXoACs1xCmrdZdC+WGM/XIZm4qGJJBIBeqQ/j19yhFDZQMEQwv0I+35xcZJCt92nLkTc6aCC4/uJ2GyMD7N6LANC2W0ZAARIuV7yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=Kb0YmD12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkjDVazK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 30D6D13806DF;
	Mon, 26 May 2025 07:48:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 May 2025 07:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748260083; x=1748346483; bh=r3DDIvCCF4
	vrldDktj0U7F1dCS9vattSs9NO+WPTcnE=; b=Kb0YmD12ls2+q1SKt4OQ1oVJ8G
	nBRFwjivb8hMbapGsATqKlIpOAa3ZfAey+O2yYmSFFMHCVx+QGEdsTIzIZdrVAuZ
	cotc0EX/jPyD8HRexepP4fu6hE00T2hmCTVVtpDNLE/8cUelbRRnsndXoay/UtwT
	U5LBa0VlYgLznteFYojv3r+C6oxDjMlIs0/k3YoTXR79t1cIY+Cm5BxvPhu/uM2u
	TT6/lDCJY4kVSdQck1tWz2vXg0O6RypehITyKUlzp0gQN5vTE6zNxvTLH2eZF1hW
	kqNnOiSivNj945ZRQwCFmR+XOnudkz2FiiT88k4ghHZ7ScqJzXyDxnng9YKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748260083; x=1748346483; bh=r3DDIvCCF4vrldDktj0U7F1dCS9vattSs9N
	O+WPTcnE=; b=ZkjDVazKDajJvDgLuBE9ZMC5bjLPlTP7LyzeDrxX/c1MP7FnoDw
	QZz2R3XUPaRL/lJ6LOAe2dZnGlIFO8AJVrkw3wHo/sZuDhvETSS9bRkC14Ug8KTd
	cYk/2CM2rBLCvsR27WJsDuCJkjVD6KT9a1SOc5hnkUGewnWOyqdHC4qrRH/Egmsz
	CMqwLw1uo5yq+Mu4UpiQLjom8wB6qT+HNjNXNfNj30ZCouonf/bscWU0QT0kBCCF
	hYyVuvh+toVu6rW7i0lS1XZfF+UPlgBQoL4akgXQWN0kFB+JxpeQMT1ZJ3hVirLD
	S0RfGUDE92utL5tOohvQPUMTAB5iZ7SRUiw==
X-ME-Sender: <xms:8lQ0aNTnmij-tY22gs6TGsmC0oYtUIEXRazH7iptSvVTwWSETdtEFA>
    <xme:8lQ0aGxJo03U4voixAnYLbBUcByV9Wy4aAaO398dEhqOqglOfPzCrw4Hz7b6Mmu8C
    6KPgEuJR5D0tC5XuCQ>
X-ME-Received: <xmr:8lQ0aC2jbRHXmvJtpPXsTTKGCpbCReXi0Yyxx9g38uMiy_fK4ZjjIAwUZH1xPiStGtkPQnKUJA8G9OE_KT5-F95UouOAPIgx7YoQgQbdNo4t4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhkfgtggfuffgj
    vefvfhfosehmtdhmrehhtddvnecuhfhrohhmpeftihgtrghrugcuuegvjhgrrhgrnhhouc
    eorhhitggrrhgusegsvghjrghrrghnohdrihhoqeenucggtffrrghtthgvrhhnpeffhfek
    tdejhfeigeffjefgveekueehheehleekheekveelkeegleeifffguefhudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrihgtrghrugessggv
    jhgrrhgrnhhordhiohdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthht
    ohephigvhhgviihkvghlshhhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurh
    gvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:8lQ0aFBUqKQ0pTfbUI8PLy0hPsp3GXE8bm2Bdz0io69K6r87H0MNKQ>
    <xmx:8lQ0aGiKb61WwjWDZ_91dX-ZsV1MIdvcDCYEeK84MgxDBcUt-tg9RA>
    <xmx:8lQ0aJr6nVcZU9OwTQswxFLcnOYCa6gZ-x1dKVoCnEEy0uXQzyYxtA>
    <xmx:8lQ0aBih_0H_LY-RJH0c6_PiPIfIVmI3oo2oSgTy-UIF6456mJc4-w>
    <xmx:81Q0aCgX9JwDEYpLw0xhyqZpLFiQWDdmqdvuh0MhFlt35-t3F33yODcC>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 07:48:01 -0400 (EDT)
From: Ricard Bejarano <ricard@bejarano.io>
Message-Id: <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_5D33D6F5-ADF4-4AE3-A528-8DB54853A01B"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
Date: Mon, 26 May 2025 13:47:58 +0200
In-Reply-To: <20250526092220.GO88033@black.fi.intel.com>
Cc: netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


--Apple-Mail=_5D33D6F5-ADF4-4AE3-A528-8DB54853A01B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> Simple peer-to-peer, no routing nothing. Anything else is making =
things
> hard to debug. Also note that this whole thing is supposed to be used =
as
> peer-to-peer not some full fledged networking solution.

> Let's forget bridges for now and anything else than this:
>  Host A <- Thunderbolt Cable -> Host B

Right, but that's precisely what I'm digging into: red->blue runs at =
line speed,
and so does blue->purple. =46rom what I understand about drivers and =
networking,
it doesn't make sense then that the red->blue->purple path drops down so =
much in
performance (9Gbps to 5Mbps), especially when the reverse =
purple->blue->red path
runs at ~930Mbps (which lines up with the purple->blue link's speed).

> So instead of 40 Gb/s with lane bonding you get 10 Gb/s (although =
there are
> some limitations in the DMA side so you don't get the full 40 Gb/s but
> certainly more than what the 10 Gb/s single lane gives you).

Right, but I'm getting 5Mbps, with an M.
That's 1800x times slower than the 9Gbps I get on the other way around =
on direct
(non-forwarded, non-bridged) traffic. I'm sure I don't have hardware for =
40Gbps,
but if I'm getting ~9Gbps one way, why am I not getting similar =
performance the
other way.

It's not the absolute performance that bugs me, but the massive =
assymmetry in
both ways of the very same ports and cable.

> You missed the attachment?

Yup, sorry. I've attached both the original tblist output and the =
reversed one.

> Well, if the link is degraded to 10 Gb/s then I'm not sure there is =
nothing
> more I can do here.

This I don't understand.

I will see what I can do with the 12/13th NUCs which are TB4 and have =
certified
cables.

Thanks, once again,
Ricard Bejarano


--Apple-Mail=_5D33D6F5-ADF4-4AE3-A528-8DB54853A01B
Content-Disposition: attachment;
	filename=tblist-flipped.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="tblist-flipped.txt"
Content-Transfer-Encoding: 7bit

root@blue:~# tbtools-main/target/debug/tblist -Av
Domain 0
  Type: Domain
  Security Level: User
  Deauthorization: No
  IOMMU DMA protection: No

Domain 0 Route 0: 8086:6357 Intel Corporation NUC8BEB
  Type: Router
  UUID: d1030000-0090-8f18-23c5-b11c6cd30923
  Generation: Thunderbolt 3
  NVM version: 33.0

Domain 0 Route 1: 8086:0001 Intel Corp. red
  Type: XDomain
  Speed (Rx/Tx): 10/10 Gb/s
  UUID: d7030000-0070-6d18-232c-531042752121
root@blue:~#

--Apple-Mail=_5D33D6F5-ADF4-4AE3-A528-8DB54853A01B
Content-Disposition: attachment;
	filename=tblist.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="tblist.txt"
Content-Transfer-Encoding: 7bit

root@blue:~/tbtools-main# target/debug/tblist -Av
Domain 0
  Type: Domain
  Security Level: User
  Deauthorization: No
  IOMMU DMA protection: No

Domain 0 Route 0: 8086:6357 Intel Corporation NUC8BEB
  Type: Router
  UUID: d1030000-0090-8f18-23c5-b11c6cd30923
  Generation: Thunderbolt 3
  NVM version: 33.0

Domain 0 Route 1: 8086:0001 Intel Corp. red
  Type: XDomain
  Speed (Rx/Tx): 10/10 Gb/s
  UUID: d7030000-0070-6d18-232c-531042752121
root@blue:~/tbtools-main#

--Apple-Mail=_5D33D6F5-ADF4-4AE3-A528-8DB54853A01B--

