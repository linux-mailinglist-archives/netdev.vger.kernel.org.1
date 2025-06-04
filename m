Return-Path: <netdev+bounces-195057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A271ACDB07
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203E43A4558
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBB2185A6;
	Wed,  4 Jun 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeK3BH+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E0149DE8;
	Wed,  4 Jun 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029482; cv=none; b=lpSAuhnV/8I0x9VMafNCA3HR34y4E3tSca32sZESzAty9SvVcNQBbAf2au6xLN1u7XolNPxD10Xcn+0Q8BdtGpr6o8ThD/VZvkt3oB9x0qFMLd0xOr7j7HP5n0f8V7TIVsFmC3Rp3dOwehM0Ifx6G9CPu04m4glx+FVOTWch8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029482; c=relaxed/simple;
	bh=bFpcIRD0c9LLof/PdetkL//XZfkCKEYyMCBz7/VsI9w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oNOmHJhbYe1D0ZSy3lnmmRmn29SH5E7IDtxKt4z1iN+7+rTWYERI0Odsw+ALrUDGmQaQLMccV84e72CYpAxnkvQvoQPvNTV6yvBDQWGqp2tsgA0HFtknJ9laCug4enc9r46Lce2ihO8YjpScCVfaK044LCKuPvA0DHVy8SX7GdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeK3BH+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9880C4CEE7;
	Wed,  4 Jun 2025 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749029480;
	bh=bFpcIRD0c9LLof/PdetkL//XZfkCKEYyMCBz7/VsI9w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EeK3BH+aJ+XWU1a3l4QB95KyiU+D7WPU8LeXxP7FMOPHgwt2idLBk9tx481VLlj13
	 Ae0thqA3Q0QzlcVDpdaQ+Teq+Y72yj+gXRwnB8ZzNBSFFIroXJe76lKs4hoSlEWQzB
	 Bzu3I1wx0YAxon4Dgiwto2MmL716AP49cg4hLph0X1GVSaYUwBCltsMlKFIyN2cqrs
	 dh3qH5Z4xidGt9vDBnfSPPn3A8j2QPWMCrO0M8zP49hv/RdtBs+Z+MchCsz/7Wip+w
	 3YEDCMk8HYrtfC6xq/AxSP3JRpkSvglOHBBoMYrona6An5GnTtDsQyX9c6qGG0EYn9
	 ttb8B/9Ia94Rw==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1D851200043;
	Wed,  4 Jun 2025 05:31:18 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 04 Jun 2025 05:31:18 -0400
X-ME-Sender: <xms:ZhJAaH2tUo-POMQlVMJS1JdxoZbRQHDzZm6q6NkQWRCFrPLXGzZ6EQ>
    <xme:ZhJAaGFIROvgUhZHDZ45bAEUCuWrYQnParvOPuzvufupm7IO2SeKs9kTgwWoikRS_
    GMt_fwnVW-i8IPntik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtoheptghlrghuughiuhdrmhgrnhhoihhlsehngihprdgtohhmpdhrtghpthhtohepvh
    hlrgguihhmihhrrdholhhtvggrnhesnhigphdrtghomhdprhgtphhtthhopeifvghirdhf
    rghnghesnhigphdrtghomhdprhgtphhtthhopeigihgrohhnihhnghdrfigrnhhgsehngi
    hprdgtohhm
X-ME-Proxy: <xmx:ZhJAaH5P5lNIpPXLwG00cpYGVd9F08GLP6paESxLjOKmfrD2WyzXwA>
    <xmx:ZhJAaM14hnX2ZSvIHVDTxDADfiIHSX-2aOyqdqqUEGHaPaTBQL9RYQ>
    <xmx:ZhJAaKFhCTpisa6eaCocpL43Nks27xKOfFJBYZhX_aESGHx2yq5dRw>
    <xmx:ZhJAaN_TB0MxrKs2QNqUOfN4OhiBCDNm4ZOMI_WrxHKJBWu1lUke0w>
    <xmx:ZhJAaHkh4bgY52R2t8wjkBm8alDUUHkG4rn_3efDjkaYuG_qS3Vchm4M>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8E7E700060; Wed,  4 Jun 2025 05:31:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcd26d72acdec76a4
Date: Wed, 04 Jun 2025 11:30:58 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: "Wei Fang" <wei.fang@nxp.com>, "Claudiu Manoil" <claudiu.manoil@nxp.com>,
 "Clark Wang" <xiaoning.wang@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
Message-Id: <effd3e84-8aa7-4c06-ae36-effbf3b4f87d@app.fastmail.com>
In-Reply-To: <20250604091111.oo2o2xd2zeqqisaf@skbuf>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
 <20250603204501.2lcszfoiy5svbw6s@skbuf>
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <b2068b86-dcbb-4fee-b091-4910e975a9b9@app.fastmail.com>
 <20250604091111.oo2o2xd2zeqqisaf@skbuf>
Subject: Re: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 4, 2025, at 11:11, Vladimir Oltean wrote:
> On Wed, Jun 04, 2025 at 09:24:22AM +0200, Arnd Bergmann wrote:
>> On Wed, Jun 4, 2025, at 04:44, Wei Fang wrote:

> Thanks, this seems to be the best proposal thus far. IMO it is also easy
> to maintain and it also fully satisfies the imposed requirements. I checked
> that when FSL_ENETC_CORE goes to m, NXP_NETC_LIB also goes to m, and
> when it remains y, the latter also remains y. Note, FSL_ENETC_CORE only
> goes to m when all its selecters are m. More importantly, when
> NXP_ENETC4=n, NXP_NETC_LIB is also n. The drivers seem to build in all
> cases.
>
> Will you send a patch with this proposal, or should Wei do it with a
> Suggested-by?

I'd prefer Wei to send it as a tested patch with my Suggested-by.
I've also tested this version overnight on my randconfig build
system.

     Arnd

