Return-Path: <netdev+bounces-219090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E29B3FC10
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53322C24A2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34819283129;
	Tue,  2 Sep 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="JFgdDSeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aEI6dyH3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E128137C
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808346; cv=none; b=R8+c+b5GVLmksjqYSplkEmhyL+MKhHBOcNzPX27gNc4LUFYhNCdIbGa+NsXt102ojaamhSM86PH/cr/S8Ocf9pYIJGPBSS2q5BXkMTEYqx9PsGxMZrijR8hHMcSnflJ4L1lvcJucC0OH6GaCqbZ/m+IEG0zujKAmPgZNJHi/ntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808346; c=relaxed/simple;
	bh=jeeegofo5mbEvbjxh8ydrY5MFkqcVcLsk7316Lwafxc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hBxUgxe8rmu+ODQz6MIX8/+u+pEpDKXjA8qekAO6J1qwEYhTZC8REK/XNJAqlqEKkY94P+iLsfbPAmuslV+DO+tMODi8sro96rVtz1eP5VENGEE/wdiMhs3Mu2UZvZBY7b0OG4K2rDZWH7n7bAFIuvg9gy6fe5sGEno+w8qxtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=JFgdDSeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aEI6dyH3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 08AE0EC0474;
	Tue,  2 Sep 2025 06:19:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 06:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756808343;
	 x=1756894743; bh=jeeegofo5mbEvbjxh8ydrY5MFkqcVcLsk7316Lwafxc=; b=
	JFgdDSeVkn3rMKTZx4YXA0KjYoMU7Rtfd70bY6cuQ5a6Ca1k306va1qhCWzv3L/V
	NW5DVaTBY/HVYxnq7zQF0ewuBwnLnrjL6mlAD4HFdOEuseJxtDpq3PhHO8Jvo7Q7
	VbuHOX7R1x8FObx2h5SNCs/PaySypudb0/LtYPs4qYalrp12wb/08mSks0nfl796
	NYLmU1BIn/y4P6K/ZoDIGtINU2v7we2twke3RMIXZqZ8ir/uJIp4+LVJH4fNFSdh
	jjcf+i+4KDEbR8UakThH79W9Ag2bPluYiFCCkG3QoD+8p2lTkzLtoMp5FcXTa+cN
	RA2n4j/fqNlFbre/uig4eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756808343; x=
	1756894743; bh=jeeegofo5mbEvbjxh8ydrY5MFkqcVcLsk7316Lwafxc=; b=a
	EI6dyH35Pyjq6k6dk+rU18AlRcJLYaAsLVOQTehAcSg0XvjuohOp/IWCRy1Ox+d5
	57xG1KFd/PhUe9zxcYFyYel88P4A0JZVt/4M6XP14owcfOyRLBjhBseQFN29NaAj
	J/p0QRHLTYOwdI9aD8pFFMZWtsM0Wx8dRgkjTFacTGlKU7fQRYTCMGOswU7IyV2y
	6KIWx+67tsfeOdeIkDo0qjhFgMy1gXTaYh0/azVwP/RnjNxjxiDfgnot5Co48qAX
	g7tlGVxomDT5vH28yB6sGmVVh+bnYiUth1dog+9kiBooNbiMlv0UUvLDUlo5U4zJ
	HfntRMkVKlCXSnuwGC3nA==
X-ME-Sender: <xms:lsS2aMc89pUyGvQXf8eZMnkoxfrZU2iSx5ieKZBLHZ-Ndem9kQMV4w>
    <xme:lsS2aG3uNKV_qHZLcBrX0bfoQ40jlwEmLf2D-W-aI8mL-XG-JbnvOf4l3au3Vt1qR
    cSvUehqf3QHHXoRoE0>
X-ME-Received: <xmr:lsS2aE9FIC9qd3YowK7YoGsKTTHSzVZhge5CnJDTwm2NoKuSumFzHN6di6MFEH6IQsO8_fQV6pYNGDrQLQPzV7Y2oWYgCqjySbFfq8hVhbMy5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghilhhouhht
    mecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptggguf
    fhjgffvefgkfhfvffosehtqhhmtdhhtddvnecuhfhrohhmpeftihgtrghrugcuuegvjhgr
    rhgrnhhouceorhhitggrrhgusegsvghjrghrrghnohdrihhoqeenucggtffrrghtthgvrh
    hnpeethfelkeetffehtdegkeduieevhffgveetvdegtdejhfffjeetleegtefhvefhuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrihgtrg
    hrugessggvjhgrrhgrnhhordhiohdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehiughoshgthhesihguohhstghhrdhorhhgpdhrtghpth
    htoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgrrdifvghsthgv
    rhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhjrghm
    vghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlshhhsgesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:lsS2aL6XoUUdZopsfqHmCB9a2HwpIxr91G2kjEJ3aLxr-fZu2JvKBw>
    <xmx:lsS2aMu6ezhtvGF6FmcmnsG6cKSk6dN7HyJuS8Exjo5JwnjjtqPTWw>
    <xmx:lsS2aN0j9jugIOVMJKfppCMaVF9X5DdldgXTyfqAXbOwSy0Tp3Xk5w>
    <xmx:lsS2aFoQcJRhzSgJotUePHuQjcut4SDDO3VMZZsUt55rgwkOdukFUA>
    <xmx:l8S2aD8SqcCJtqOq_ZtXBQKfmnMjhF_VG6mUPY73_a_xpb9spQFVWFX3>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:19:00 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <aLYAKG2Aw5t7GKtu@shredder>
Date: Tue, 2 Sep 2025 12:18:59 +0200
Cc: Andrew Lunn <andrew@lunn.ch>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A68375CA-57E1-4F53-877D-480231F07942@bejarano.io>
References: <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
 <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
 <aLYAKG2Aw5t7GKtu@shredder>
To: Ido Schimmel <idosch@idosch.org>
X-Mailer: Apple Mail (2.3826.700.81)

Hi Ido,

Thanks for your reply!

I'm afraid we don't just see it with TCP or with bridged traffic. That =
was my
original observation and so the title of the thread, but it happens at a =
much
lower level, at the data link layer. We observed CRC checksum failures =
in link
stats. You can see those in my May 27th message in the thread.

The last thing we tried was to force linearization of SKBs with =
fragments, to
see if the problem is with how the driver puts those on the line, which =
might
offset everything out of its place, making CRC checksums fail. I was not =
able
to do it, however, as that would simply hang all my tests.

Any ideas?

Thanks,
Ricard Bejarano=

