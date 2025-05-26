Return-Path: <netdev+bounces-193501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C8AC4414
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A857AC631
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC247241136;
	Mon, 26 May 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="GuHzJLkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gvt7fSXs"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043782405EC
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288205; cv=none; b=tC8bY73j2WFfzVx+IQt+cUtO1LjC/S/dqeOBwrlpbyzUc5agG7+Zc7036s4yl0m5Kp590CXznCDcYc8Jai3ez5dxDAs2QuzLb2UAXwQn8WvFL5xD1BY6+NkmiEdwOFc0PA4uQNBFAWyL51wxyjN+AiVB1EJaU/s/IAbXAceA8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288205; c=relaxed/simple;
	bh=jNXui1pdUX7f2EMtq2S/gt3wu/Rauk3khpgDoa0mnBU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VK4YX72O5QX1zzyCwJWK2d88huKjAUPkq7sold+3Q4DWYM7LhXijhsccwGM/bAwQKeDlMiq6A/lPHrJSGrH89ScDRp7KZlawuAfVv3Z+DqX4GU6Iqzd4phsi/O6gDFBmepQsapz6HmsqAHhjnye9nVvBuDETbF9H7QzfcO7PQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=GuHzJLkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gvt7fSXs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD2C525401B0;
	Mon, 26 May 2025 15:36:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 May 2025 15:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748288200;
	 x=1748374600; bh=PS63K127kxANEhto6mBpREn4uLv49FiTnV/Fm60V/Hw=; b=
	GuHzJLkWxTulXMRvm69eevd6EZztpPXVCirvD95TGR1bJNoGpBqfTw2/q9UjQZRm
	Ewu90kuP/Hv7IyHENkaM/XkPVtwZgCsOLvTDLCD5Z8cA7iG5cRRbhoy/+yMEpuf6
	0wKnZDi28gOQN1EBCJjLb1Al5v8OCng+XZzxlHpVoQMuTGYWPfY59ccEaToevxKl
	CbDChDdmHumS/n45sSKnJkPA1t284Sk/onhA50EjAMlmEjRip591Ur03eutDpg1p
	zXcVM94QcNduWwMj9I3UDR4mzC9hUORmFRUhTR+CDdUPSOdg3Fw0ISECUhKP03GB
	Ll7NJDWVlVNIwM0/2isLAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748288200; x=
	1748374600; bh=PS63K127kxANEhto6mBpREn4uLv49FiTnV/Fm60V/Hw=; b=G
	vt7fSXslaEGNYelH/rl8PpqaQqDqtCGe5xjf/OL1/zYWKiR4aRVCExZ49exzFAMI
	hTV9MI2RiIbG8M/W4LXtGY9eQZL7Dt3sttZVqzpz29wnX9MjoNZzWbKlj9PoaaFg
	Vmc2loaHbH/5J62Z+ToIYC7ViJVj720S2iFOhtV9Fe91O2ZZFIOrQ8QCYdVMa8S9
	p50juTxeDsSuH4BJo0eUlCp6T0KO/WX63j4zNYUfvEXPhdWXIsO+mgnJgVhFA0Cq
	Y1C3Q+nfHgk8pdFTCScyFbnSCLReOcQltzBPFHsYF2yLCBRojjtMG6ab2Z7d6NVG
	xLmykN7y9CXj1LJybS7Xw==
X-ME-Sender: <xms:yMI0aDinvOnHP1Ijwvc_zkumsSF9sNBebcQIZLg2HSuRPOZvk7RIjA>
    <xme:yMI0aACfJQM_kQgInZuoa0OQhRSWxs2kOjtrf4wu8VnugXywlsoaNZDwV1lggcRVl
    ziRFWSYV1GZtsiT450>
X-ME-Received: <xmr:yMI0aDELP6_NFdm6loL1L7mZvAPyplybgr_7_UEKo1anU2-L4VMyJSEbgzrjlDSzxNwmm8-hd2ii3B4V2FVjpWtolvUtGEKfJXwG8BiJQ3LUgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukeefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
    pdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgrrd
    ifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvg
    hlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlshhh
    sgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluh
    hnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:yMI0aAQ29VUt4TKuauCb1etURsUebJwF06VXXQKmdpDoLgvxugUddw>
    <xmx:yMI0aAxc42dmhoK9ay4gMHUAI6E3uCK9XjOWazMt7v28iIJ09N5axQ>
    <xmx:yMI0aG6Vd0RNoo9LEBRE1k_Y-rBMNxmlIr0VfSd_lYiVSvjR9mTRMw>
    <xmx:yMI0aFwFMS_GCEhrmLp1iTGMImL3HEz3k2m8KeO-1mjOVoqCEAZ_0g>
    <xmx:yMI0aFduSg1L9tVlo_o_WSaiTcIFtH1p2kGdC5H1_qsF-IPhOWczVj1K>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 15:36:38 -0400 (EDT)
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
In-Reply-To: <20250526080956.7f64a5f5@hermes.local>
Date: Mon, 26 May 2025 21:36:37 +0200
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
Message-Id: <88E7B346-18BE-4149-BFD7-8DB5B48ED52E@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <20250526080956.7f64a5f5@hermes.local>
To: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Stephen, thank you too for chiming in.

> What is MTU?

MTU is 1500 across the board.

root@red:~# ip a
...
2: eno1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group =
default qlen 1000
    link/ether 94:c6:91:a3:f5:1a brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether ce:42:52:00:a0:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
8: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP group default qlen 1000
    link/ether 02:5f:d6:57:71:93 brd ff:ff:ff:ff:ff:ff
root@red:~#

root@blue:~# ip a=20
...
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
master br0 state UP group default qlen 1000
    link/ether 1c:69:7a:00:22:99 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
5: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether 3a:4d:83:e0:ab:3b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
6: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP group default qlen 1000
    link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
root@blue:~#

root@purple:~# ip a
...
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
master br0 state UP group default qlen 1000
    link/ether 1c:69:7a:60:d8:69 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
4: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether 1a:45:1d:c0:46:02 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.3/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
root@purple:~#


