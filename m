Return-Path: <netdev+bounces-193391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E82AC3C01
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA651896727
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E21E990E;
	Mon, 26 May 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="BC2p1f9f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/VS0awA"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259911D799D
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249451; cv=none; b=lTWMoi3ycvsZ7fmQFs8Id3Is/scalDYwKajp5i2afeN5nay9iE7R2IgmKyDCrlKwu/s9zs+K6Pmnn8KwiIqGmpe399tS6u1NpqwSOjotTR57U3DKlSFU5o5AAuA/gwoDErFni9BiDgdqp6dOAiaj0hp35hsuB9EwGz+pX4ttlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249451; c=relaxed/simple;
	bh=XVhR17W9nCEMs6dlPUsZlQ8fqzGAlp94LcoGZtcQhno=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b6JYwU+ic0G2p6unghpGKxane8dl+pDtmKIdqFPQRf8BUHqj0gKDuLKP3Lsup0vqo5hbN6aA8ig1pR82XcT/4O9ZQOzypmIW9ON3cI2/UJ5vAsBg/zkYxTWfLSd/PcRtyFUOTv04r8MOpIKXqml1RdKuzmSiFy9If7AUjfmNUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=BC2p1f9f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/VS0awA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B95913804A0;
	Mon, 26 May 2025 04:50:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 26 May 2025 04:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748249448;
	 x=1748335848; bh=cMuVAw+qhzwZiUPSpjSsaZyQ5uNP7lZyk8DPF+M3miA=; b=
	BC2p1f9fXY3KOCZWacG50GusPyg0eNLHW8qq2oDtyyBaC3VPz5ITIE+VlG84L9y1
	kDHzCE/r1DjUwHJ632G97xskNFBx1Ar7d4074yLXEUuSOkMSrrCl1QJ7DrWFj0mw
	/WvwYD8dueU87iAYTK0QkbdFeav8HBxnoqYNbzsost5KF/PgBUctPsr9X+8BC+tp
	xPIkTFplNHRVWJmgaZLHrzVPnYTyZfPx1jqqtuvgnZWNfeV/RrfxufEROQ4A4iIR
	5HHKBRBqUFrn5sCG6AvWkNYCtMOBPr2OwxoUVwzdqOgqK6l2qCP84tNNQ6bqTxNU
	0mJZz8w9RvFs9a8qzxME0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748249448; x=
	1748335848; bh=cMuVAw+qhzwZiUPSpjSsaZyQ5uNP7lZyk8DPF+M3miA=; b=e
	/VS0awANLVoc4qmVIJ4TcucdgjCt0GF6DVnzULxTHReevQFsjh4Ow+077r3iHpE4
	W/tBStoEyGUuc4x+ppNPCRkvJ0ZR4MgsIk2Yf9N5tdztQfoWDwrzUjiLcQTc2BwT
	Xrsgo+I5tehqYQhK0qd3lqyZtUw+pEKFDritPsFjh/FOdrHOyn4CUUqE/Sco/gZZ
	AEf30gHkdZQDsZFwMxODCfnH71DRitchykT2R9y7knPBFp0MTvVgZjUO3akyVcWs
	qVvoL+2Wnmf8vxhMJJhDD6d/woxQRn7aoBQap2UPNPOg/wBM5LYZ2YATclrJKytM
	EiI8QwRlRSwgBUMIRJziQ==
X-ME-Sender: <xms:Zys0aJoja-VPe1bvpE-58J8fTFGnQXCaBWTtu8lxG-X1jnqV_ngxkA>
    <xme:Zys0aLqgiJb0ZrAyFo_nke13bWi1uDxHf46STuZPVU05qgYW-X1JcsK9Mev1xExDS
    z83q_-vDu1wM6oExh4>
X-ME-Received: <xmr:Zys0aGPja0dH_4yzPmaMijazc8Mlb9cVsWyOhek3ZRGnomnt9k2pkYkDYwCqxNpsCX1pJbBG2DEl3wKcV8sRdB9rZqi5pXtNi-kCbBgP7VY4VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujedtleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnhepuedu
    vdeuudegieeffeeiudffjeevjeethedutdefhedvtdfhtedtkeekueeggeegnecuffhomh
    grihhnpegrmhgriihonhdrvghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprhhitggrrhgusegsvghjrghrrghnohdrihhopdhnsggprhgtph
    htthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhkrgdrfigvshht
    vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhdrjhgr
    mhgvthesihhnthgvlhdrtghomhdprhgtphhtthhopeihvghhvgiikhgvlhhshhgssehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgt
    hhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Zys0aE4vYhVT6R-5oruUSKg9-31TdT81_VRgFilLjTHtOtPjqLYWoA>
    <xmx:Zys0aI78ec0sIBENcaIaXlplVJA_ZJzk9gRIjqezbg6VrjSvGZg9Ig>
    <xmx:Zys0aMi4po1eWx58HDVYrhf75BE-fy1o07gVT9RTZY6boCC2EbWbKg>
    <xmx:Zys0aK7u_VSRU9Z0QiY2FgCEYvwg299WNNmVnibSErMYSxrgSDmJaQ>
    <xmx:aCs0aMb9QGPHXnsfFlrMtAnOu7fY0SAk25vtsKAJ2hrYksI_3FJTpiHs>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 04:50:46 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <20250526045004.GL88033@black.fi.intel.com>
Date: Mon, 26 May 2025 10:50:43 +0200
Cc: netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hey, thanks again for looking into this.

Yes, these are 8th generation Intel NUCs with Thunderbolt 3, not 4. And =
yes, the
cable I have used so far is Thunderbolt "compatible" not "certified", =
and it
doesn't have the lightning logo[1].

I am not convinced, though.


Part I: Thunderbolt 3
---------------------

I first ran into this issue a few months ago with a set of 3 12/13th =
generation
Intel NUCs, each of which has 2 Thunderbolt 4 ports, directly connected =
to each
other so as to form a ring network. When hopping through one of them, =
bandwidth
dropped from ~16Gbps to ~5Mbps. Both in routing and bridging. These 3 =
NUCs are
in "production" so I didn't want to use them as my test bench. They are =
rocking
"Thunderbolt 4 certified" cables with the lightning logo[2].

I could justify running any one of the following disruptive tests if you =
think
they would be helpful:

Note: A is connected to B, B to C, and C to A (to form a ring).

1) Configure A and C to route to each other via B if the A<->C link is =
down,
   then disconnect A<->C and run iperfs in all directions, like in =
[4.6].
   If they run at ~16Gbps when hopping via B, then TB3 was (at least =
part of)
   the problem; otherwise it must be something wrong with the driver.
   I am very confident speed will drop when hopping via B, because this =
is how I
   first came across this issue. I wanted nodes of the ring to use the =
other way
   around if the direct path wasn't up, but that wasn't possible due to =
the huge
   bandwidth drop.

2) Same as #1 but configure B to bridge both of its Thunderbolt =
interfaces.

3) While pulling the A<->C cable for running one of the above, test that =
cable
   in the 8th gen test bench. This cable is known to run at ~16Gbps when
   connecting A and C via their Thunderbolt 4 ports.
   While very unlikely, if this somehow solves the red->purple =
bandwidth, then
   we know the current cable was to blame.

These 12/13th gen NUCs are running non-upstream kernels, however, and =
while I
can justify playing around a bit with their connections, I can't justify =
pulling
them out of production to install upstream kernels and make them our =
test bench.

Do you think anyone of these tests would be helpful?


Part II: the cable
------------------

You also point to the cable as the likely culprit.

1) But then, why does iperf between red<->blue[4.6.1] show ~9Gbps both =
ways, but
   red->blue->purple[4.6.3a] drops to ~5Mbps? If the cable were to =
blame,
   wouldn't red->blue[4.6.1a] also drop to about the same?

2) Also, if the problem were the cable's bandwidth in the red->blue =
direction,
   flipping the cable around should show a similar bandwidth drop in the =
(now)
   blue->red direction, right?
   I have tested this and it doesn't hold true, iperfs in all directions =
after
   flipping the cable around gave about the same results as in [4.6], =
further
   pointing at something else other than the cable itself.

I've attached the output of 'tblist -Av'. It shows negotiated speed at =
10Gb/s in
both Rx/Tx, which lines up with the red<->blue iperf bandwidth tests of =
[4.6.1].


How shall we proceed?

I reckon all my statements about the 12/13th gen NUCs are anecdata and =
not as
scientific as my 8th gen NUC results, but I'm happy to perform any one =
of the
three tests above.


Thanks again,
Ricard Bejarano

--
[1] https://www.amazon.es/-/en/dp/B0C93G2M83
[2] https://www.amazon.es/-/en/dp/B095KSL2B9


