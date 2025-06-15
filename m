Return-Path: <netdev+bounces-197873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DCADA1F7
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041181890714
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25017C224;
	Sun, 15 Jun 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="jwlyPSv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chKQPRpc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48306BA53
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749995791; cv=none; b=dc1DHp6+IVnrWR0XsD3YfuOVPFXP2zvR5Fgoi6RNOZ8HRaijk0NJ0JwMN0sTH2pjvZCDpmzKnG1DFkUpAyW8Gb6wC459Hx+oTlVEJ+qmykNSLUzdBj0tLZHl97a1bskuW8f7EW0ckh/3dBaWxy7PJjJ96ndBcsH/2LAQlCi3CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749995791; c=relaxed/simple;
	bh=Vr0tSugC0pIf11BMt76w//f+Y/4OWhDMzHAtEaFLSf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CkExtvK12Fv3aZ1U9TNwRTaTRW7l2cwaeAC2qXCEE9JdDQgBKiLhkEfEv+dFt0um+k77+SnoO3qGNEjoktvnzJU85+dM6F8TJdxVZ9fSTo650pCceYxXKG22FmyMTPHWdozpFkRCJ7tlSic1/yMWidJFPi8dprED0J1k4wTn0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=jwlyPSv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chKQPRpc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 674A31380323;
	Sun, 15 Jun 2025 09:56:29 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Sun, 15 Jun 2025 09:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749995789;
	 x=1750082189; bh=Vr0tSugC0pIf11BMt76w//f+Y/4OWhDMzHAtEaFLSf8=; b=
	jwlyPSv73UxoCFFuCKIZWzgtH8ca0qV09vPUQhp+w5QUJEGQlf8KEdkv44AxLxtY
	tlYgMUbXD24myIjEdfSyktSqo92kmoLOt7jthtDhp4mtqGeRC1H7dogP7sXyAK7I
	xzSxq0vmnQeGenlMwfuBTefobv2h+IciDRxGRJ27s4Ogi7NnGFXiRAfu4+OnU06M
	LhPmrckEQqWJEg297qBnLYTyFUW45eLbLgu1S+PsFvP3WvttPhyGFcUlKRPb9fDV
	Aw2hqlXIIgwRUzbWEy+tUJzwi9JR9e5XTzOC2LSa3XDXoeNwQ8sXf0LblpD4MeH8
	iHe+QOHIlAdFKmj49IR63A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749995789; x=
	1750082189; bh=Vr0tSugC0pIf11BMt76w//f+Y/4OWhDMzHAtEaFLSf8=; b=c
	hKQPRpcB7XIn6uMxpugMGlzao1aXRr4SbNT0fvKqSoSKq39XSa3waletHDkM9agR
	LR2swFTXok4J5LnNlahy+RgYOYpJy864qEh0kihk4t/Aq0C3kW2LTlwL4F1TfGWf
	gj+3p5+FihN010PDkNL7PThl5IZcbFFHIDhwG1RjpxJ0pw8atmmRWCXvcCk6u2bE
	j4SzmfD34WWG1eU1CCyBp6wbe8QicL0b92pJQM/3iziZUIgzMbTtWHeFKhm+RLFl
	zW7p2uJQM2rguto/kbEXLIpJXQXQD9IyT9G17qVjIZ13FtfZ8zqPBr5Z2YCzzIy6
	oFa/LcDZR5r6zHp1XSwwQ==
X-ME-Sender: <xms:DNFOaA_xMwlyVC9jRh4GCzGVG9VZwznmQp6DfR0CD8sytDKxLsENMw>
    <xme:DNFOaIs5exm108LwZGztP_cevZqox2WMaoQ0k32nvI_O2uaY7QH2Co1H2OrQpBNUm
    VQVrapGaQbA-ZbTyIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdftihgtrghrugcuuegvjhgrrhgrnhhofdcuoehrihgtrghrugessg
    gvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnhepkeehveefffefffdutefhteeu
    udelgfehheffledtteekgeeigeelgefgveevteeunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegsvghjrghrrghnohdrihho
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeihvghhvgiikhgvlhhs
    hhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghlrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrg
    drfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvfi
    eslhhunhhnrdgthhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:DNFOaGC6rhx4Vxvyq6YVgIAqKaQMaAIzICIho6-ySZpjpNF8_jDucw>
    <xmx:DNFOaAcHO4disyl6qPY9Wip63U_Xy4Vh-NhO-ULaYNqKXzqyCujQlQ>
    <xmx:DNFOaFMMKmXiGPVz17O0WDPP5-2r3gXd9wwNK-HUJx9D6VQyOqfN_A>
    <xmx:DNFOaKltZLGodU9T9ZVepDZoJ7G9VTAd5vdKn-Wuj2OR6DdBz8x4lQ>
    <xmx:DdFOaC-6f6lfet3dwnEVzLnoZeA6QDyJbyw-sqxCZ2v_A6nsyCarv5bf>
Feedback-ID: i583147b9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 141122CC0081; Sun, 15 Jun 2025 09:56:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9bfb5a61a13769a7
Date: Sun, 15 Jun 2025 15:56:26 +0200
From: "Ricard Bejarano" <ricard@bejarano.io>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Message-Id: <e48cc5fe-d741-4260-b561-f33c1c995cb2@app.fastmail.com>
In-Reply-To: <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
References: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
Subject: Re: Poor thunderbolt-net interface performance when bridged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Did you manage to prove it is skbuf with fragments which are the
> problem? As i said, adding the skb_linearize was just a debug tool,
> not a fix.

I did not, all my tests with skb_linearize made iperf3 fail. I did
manage, however, to prove that all UDP SKBs we transmit are linear,
thus all non-linear (if any) SKBs we see are TCP.
Thus, I could not test loss with skb_linearize vs. loss without.

Thanks,
RB

