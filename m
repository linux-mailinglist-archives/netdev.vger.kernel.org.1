Return-Path: <netdev+bounces-197750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBAEAD9BA5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B403BB802
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BE1F4CAC;
	Sat, 14 Jun 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="sxOeCoRZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmNwlVeQ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0C282EE
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749892440; cv=none; b=HEPJcp8Y4LLqjkJ63aCHVrUvvsAcxHa8Su42SYpUv7hHuh/u8iOyarcP+ujiLeUGOGVhUAEc2qBHH7KJyRdA36QGCbna4pynIdBMIN8MB7eNxwlAndc3nSDmk8lTeAm76j0ZAwONRrKrxfiVeD9n75wilsiBOZAJHvWLR5t/plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749892440; c=relaxed/simple;
	bh=Gf4Kg//PAOI7svmDUo6iMmXvFYrH0gwIWf1XFi7/9qI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z3NxVNkslQI4VMgbOPTHclilwKuwKmwFKN0QqeA7OO8A6UC37CAmZMh8pJcBtkmEzg/mA/I9oDMlTA2G3EG/8cyfHKat89xnzpuh3BXfDBO6NTbm4sNmbz+suVM2pa/YPTnWFxi0OuN3fxwiykiXO8d2wvitRgHr/pT05UEaB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=sxOeCoRZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmNwlVeQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 389AB114017F;
	Sat, 14 Jun 2025 05:13:56 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Sat, 14 Jun 2025 05:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749892436;
	 x=1749978836; bh=Gf4Kg//PAOI7svmDUo6iMmXvFYrH0gwIWf1XFi7/9qI=; b=
	sxOeCoRZwtiwsIl7rQxEzQRg4IzWOuq1CK7WpGIpaFBc7/8a8wgZ9LVA6KjX9T0C
	TJ0n78uEhOKDNDBg68nfdV0k+saeDVcqAen0uOMQ+mDt+JrYoGB+5w7wfaQx3P7l
	fIqW72QI3xVT1F23xv0NR24QSXcYTsoASlrRxEXhQViSd8Jq4GHXy4deeBKwsS0K
	HiapZ0SZEkOH33IbjloUTsfFhSNvU7WfDBXeNdKehP/wRSHa8CtXAW7u04L44ewC
	7mCiySOXuBvujs8gwkogYAPBH5UMvA614QWSJiaH3D5uqkcBjJXPEasV073oX5Xk
	1Ua2YkCru45+boBLbtsLTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749892436; x=
	1749978836; bh=Gf4Kg//PAOI7svmDUo6iMmXvFYrH0gwIWf1XFi7/9qI=; b=g
	mNwlVeQc3fDb2IG97s/RjnxxnI3XeOx15zE51IeE2deJ2ukOG39PEx+BAB4d01xU
	h1ws6sSsukjotXzrF12YkA5lkFhjPq088elh2rHEssWYCIxi9iGe1hG9wG0ARrDc
	BOa7eXYRfHZIspCyiUBNHp5cgszlneLLM4hm7jyMifyi8mpT0uVCx/JlA99hUA11
	4cQODKxpuNXHhLjy7Q8VOrTCGdT9SXQPc6jNlG7QFlR86NeG+xuBnWh2aG+I+61w
	WaJtSJVdXq0/mCIOerrEL1WfoRGYFfES5sIDj64mJNnU8k2r8Q22Rs/5HyG4duL0
	p1cfOHBCs2yleJa2fPF0A==
X-ME-Sender: <xms:Uj1NaC_rPAtAsk12nmsxGFSRktNS8cNmIcrHrP5xj8HbkkveGTaboQ>
    <xme:Uj1NaCt5hl2OxwKwqnk0CasoFZ79WMd2Kqi2mP3KyKJ_3fW42NQLDYQ2ROzI4pyjU
    1nUc2YGtw35-_cz_Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvtdeggecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Uj1NaICRIpjcLME9WVKzgtSCjtoSoUx2hKdUIoOiGUHYWSzKB3ZxFA>
    <xmx:Uj1NaKdfVDwY5DMdGY3jCyuxrYx378RongdSukWPeZGbXezwHJVYCA>
    <xmx:Uj1NaHOIFLq0V5kQE-MZIYuygxzImvY316uuEIRbD_kybL13VWb9wA>
    <xmx:Uj1NaEkHQLKpZOZxdFqQtRx2T4ilrf031E0ML7dqW_gKnZU5SOUpdQ>
    <xmx:VD1NaM_wykRw2xoK2G5AWaXzonGgi8rX6CMLAg8M4ksoYmlpITyfkIpk>
Feedback-ID: i583147b9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52AEC2CC0081; Sat, 14 Jun 2025 05:13:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9bfb5a61a13769a7
Date: Sat, 14 Jun 2025 11:13:53 +0200
From: "Ricard Bejarano" <ricard@bejarano.io>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Message-Id: <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
In-Reply-To: <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
References: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
Subject: Re: Poor thunderbolt-net interface performance when bridged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Any ideas?

I've rebuilt the lab with 6.15.2 and I still see that ~12-15% receiver loss.

Thanks,
RB

