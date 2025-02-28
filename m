Return-Path: <netdev+bounces-170758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62770A49C9F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B8C7A6C3A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E32755E5;
	Fri, 28 Feb 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="NUxlybCl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuTvYExH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EE270EA9;
	Fri, 28 Feb 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754770; cv=none; b=ZJJJGb+rxHZAL2ZWYeW5CBeyQ5+OkthblGAbjC1K6V4tTqbC32v1EPXFid0hjuFYFOzwVgvIpxx345MQEX6VYgQJXfeoWyl9Qa78TkH0rg1Svsg5w54YPvQe+9tsz1aOF9gVASasYP1PDt0JgJJhOC1jXwBbevIbO3Ly7UZloJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754770; c=relaxed/simple;
	bh=MR+6e54mvrr55U2P4InC/IkkhvtYltb38oGdqZ14wLA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m9XzIdI3fTYusz6C22b1qLAjiZWu1//eXXmckF9un65oJamhE3dQEXUgUfR55R8Dh5VItfswcPbIb/GlWhuEgn+updrj/776OGCioE99h0xv9jm7vpQlH4Z911k98pvrdUhIBRDn4KpaOTxf5nnIr2VfcSlIKW88qRHwetzAuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=NUxlybCl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuTvYExH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CC3911401A1;
	Fri, 28 Feb 2025 09:59:26 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 09:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740754766;
	 x=1740841166; bh=SkKwIhvnfqN2r+QHSzxVSlp38AINO68uiTWQnDmFEaM=; b=
	NUxlybClqhUUMJKEhwaSw9gahKPK/yi6cKqYkNcj/Z+SSv9EMtvrT81Z4JL7ujhl
	4AtjvgXLqUMFGCYCTNWhsz6/pJSQp2GeaI41UMV18cW2LEXgqZfEBZn8LSbsHvgC
	FjUv9D5DQtBnLxcpHyvtCzY+XIGVuSINivBhq4O1w6k50IpUFLNUGuEvnqZQ7wIT
	QPgQ6BzSG3/qvr5a/N6Vz3sY0sDVfHjHjVR4O5vYElyIGwI96Q+CFFYxOXDm4VgN
	mLGc089/E6fH5gqtzg3SZeCp/JCD0VV2Hbjt0tbvCEVeOdAXS4C8myyHFkoSvPFP
	erFxVBVBfdEG8fqxySdCyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740754766; x=
	1740841166; bh=SkKwIhvnfqN2r+QHSzxVSlp38AINO68uiTWQnDmFEaM=; b=D
	uTvYExHaNIlUxU7caUsluXfPuLmeoLKJSy/k2F4mwCS/aeRiFiwUcQAnfO/YRN7Q
	yAFVHY6hofkLpcP60hihjYTFciaZ1TEXUaBdPH5sVTUxdP/QPpuJGHiTxmaxw64J
	vd2IYBrSEKzeUr5sSVe3fnBi6eMnw4AT04r6qXZ/QDKUbwaMoLwqZsuqHvhApWbL
	CYHRLLqh58fllgFGiUHHfvMFQsVjbhr3hc7JhX9z1bcTyu8VUWyA5ubSM0cUgDVx
	6AxsZ0nWxooV813ipSlyU0Ai/8N2yP+XB/ftSCVZDlWJbxObPMOl+KjDKrcjvCCV
	tL792Fv0D/su1FvXqEjxw==
X-ME-Sender: <xms:Tc_BZyRfJVovarecw5r84IZmVCOkEtAzwaudCPx7n957vpFzvXqivA>
    <xme:Tc_BZ3z2iSoFyu7rOZ5oiwqIRzK74GsQRpfJ8kFBFJL93O9ZDDe5zaHHtk2k8iWku
    cwmzQQ9RR9vAY4BwUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhhthhhonh
    ihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivghmhihs
    lhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhi
    shhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvh
    eslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphht
    thhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Tc_BZ_2y4ckCx23_IJtJSJpM74WixsElSA9JsqF9gxnoE7Nz6sq2XA>
    <xmx:Tc_BZ-DvB2iQbtIdAdbNTYviTfRMepNlnuC5QywMZSEBire0mHM5yA>
    <xmx:Tc_BZ7gmqAu6cVv3Ovw99YRgaLlNVQW2Q4rT_1FFMzfr_NxdV__vpA>
    <xmx:Tc_BZ6po6MsSJ-Hj_N1N9AtyH3dnMYZWBa70Dpir5wb33eJHrHSOMA>
    <xmx:Ts_BZwbXxWGU-98a7GoEX06bG8wLsWjZi7oeM-MOl_g2BOX1Tf9Ju4vd>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85C9D3C0066; Fri, 28 Feb 2025 09:59:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 09:59:05 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
In-Reply-To: <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew

On Thu, Feb 27, 2025, at 11:07 AM, Andrew Lunn wrote:
>> >> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
>> >
>> > Please add some #define for these magic numbers, so we have some idea
>> > what PHY register you are actually reading. That in itself might help
>> > explain how the workaround actually works.
>> >
>> 
>> I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.
>
> What PHY is it? Often it is just a COTS PHY, and the datasheet might
> be available.
>
> Given your setup description, pause seems like the obvious thing to
> check. When trying to debug this, did you look at pause settings?
> Knowing what this register is might also point towards pause, or
> something totally different.
>
> 	Andrew

For the PHY - do you know a way of determining this easily? I can reach out to the platform team but that will take some time. I'm not seeing anything in the kernel logs, but if there's a recommended way of confirming that would be appreciated.

We did look at at the pause pieces - which I agree seems like an obvious candidate given the speed mismatch on the network.
Experts on the Intel networking team did reproduce the issue in their lab and looked at this for many weeks without determining root cause. I wish it was as obvious as pause control configuration :)

Thanks
Mark

