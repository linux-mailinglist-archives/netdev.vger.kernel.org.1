Return-Path: <netdev+bounces-193744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77DAC5ABD
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C5716E233
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035927FD78;
	Tue, 27 May 2025 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="s6ZHIB10";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNKdoyHt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583213790B
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374367; cv=none; b=bx6u/N+xVaKbZ5qVxtj2CFCwRw2AwgrJh+sZjS/vJuN1thPhCdBkdqhnaNHyK6+kAwZnO+0s/ySLgfcuaqUldI+1+98nEkwv5sB+XmQwAj1Ou+bE8SgAYat3ugDXCsiRXgT2HJ3L7r/P3BFiuzBNTZMzeSto/cintK27OaPQutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374367; c=relaxed/simple;
	bh=UA3C67ZpKmUMmamjf4Q7B4VG2jKzEU0YXAADnc4GxAo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gSPWqo3XdN/nrJ4P+8vKBKUzCCMlBZ9iwcboh4TLWHP/hmLvAmUq7BhU1+34Qz628nR84xd0gMI0E42cVnX+OUurfqexp+iX0yhTBnFDLZ1vXhpMuaFz6cBABU+aHnCaPbOLDNbEnPAviZq5uibjNfOyWcnyurw4bPQgGsK7L2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=s6ZHIB10; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNKdoyHt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BCEE61380139;
	Tue, 27 May 2025 15:32:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 15:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748374361;
	 x=1748460761; bh=en0q+58E4XRob97I9MvKkWFAtJhVgEiAUAa2S0Ct+40=; b=
	s6ZHIB10OCh6lzQr3/13gyxUV8zPd9FjoFGMR3cydklCLC/r0vRsaz3MCbGokc+Y
	JZhUvf5H3EdjnBZGq3UxOoNtLKq81pSDwttvF8rbDFRKlyqeMankzKKtKTgo3aGT
	zPMzHpeIQdwKwrp1jzmvY0FcPQLaLKfgfmT60Tu34pihlegtyfx3/rMdv1IJJarJ
	w2xfynVOs9+izE2Z+qnOYyQtkZO3TnCgfOKAmWigftj5dHjhUF2nRNiUfLk9mqbc
	vh2hdv+g4X++UNOn/TXN1CkVMrgJyfysvtHFokeP0Xj+We1mw7K/TI4h6JVDhxSw
	AyCUCVAst1+2VdDOpJpXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748374361; x=
	1748460761; bh=en0q+58E4XRob97I9MvKkWFAtJhVgEiAUAa2S0Ct+40=; b=M
	NKdoyHtWNvpKKEBEkmBdzL599vzy4uRd5nSKnBxNEYq0UMhntN+1kIYepHc0jA+X
	ej6oQtTgGfgLHV0HQmQ52BfFzrdpsoR5XSEseZuTgZnHwfIpBERRrKLZv0Kw9z39
	Hs9quDlavWAT1al8iW62p9Ubeikj370pztSheuOQd5VlH5PcTn45RirBimxWn+qm
	1HAJhSj5D7/Qlqzu70JMQICHG2E+l+55jjg3Q0dpY2IOxZ8lyGCkTvykINgwUkTT
	p+yn5LLrcqNcc1+orR4L77JthNBUjg2CoW/GkCJCj4/U7YpM8gco7+7eqhJNy0OG
	baHxuyqAOxT9g5zC1pl1A==
X-ME-Sender: <xms:WRM2aLlUBEzyOrVEH4G7JeYz1LcljpYBnqRy4hFTZwMsmc5Xw18wLg>
    <xme:WRM2aO1keBLyAn_MBrF9iGdyAZafr2UGDDT4IWZ2REGvhcVgff1YkeWvJDN5n2-zh
    -XzX232NMLgWBdeud8>
X-ME-Received: <xmr:WRM2aBo_zI-Y52aEiiCRvG3Lqt89FweKJt8SW015Z50R8SR4Y4OE_vYompAvkZBcVRTP1Z5Q6c_0iiyQzl_zsUnJvfuxb6ktAfJ5f-reRbKKdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvuddvvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WRM2aDmmg7ctZ39Ad9odfS-n8V-iJ3A0WpLEhld8e_SaVluH8x9Q5A>
    <xmx:WRM2aJ3ANFGYkf4CFVTa-lFtEDm2_2zogj1IQoeg1AU_Tp4C0WljLQ>
    <xmx:WRM2aCutJTAmYQiQjnJj0oVXcT69QVFEs_QvorkkJeFx7uF8nV2cXw>
    <xmx:WRM2aNXu4Lm3MY1G2RnBWODGXYRdF3uAG_jPe7dPrQZd42tE93ofww>
    <xmx:WRM2aG-dptnobsa5yaQR_3m5UljPE7Vcif2wZDnlWHXRUIWRD8cm4n6l>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 15:32:39 -0400 (EDT)
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
In-Reply-To: <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
Date: Tue, 27 May 2025 21:32:38 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
References: <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Also, I'm doing this instead:

diff --git a/drivers/net/thunderbolt/main.c =
b/drivers/net/thunderbolt/main.c
index 0a53ec293..3cd72aa2d 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1116,6 +1116,8 @@ static netdev_tx_t tbnet_start_xmit(struct sk_buff =
*skb,
        bool unmap =3D false;
        void *dest;
=20
+       skb_linearize(skb);
+
        trace_tbnet_tx_skb(skb);
=20
        nframes =3D DIV_ROUND_UP(data_len, TBNET_MAX_PAYLOAD_SIZE);

skb_linearize already checks if skb is non-linear, and if so, it =
linearizes it
directly without copying.

RB=

