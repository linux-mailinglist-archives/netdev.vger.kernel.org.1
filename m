Return-Path: <netdev+bounces-269444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCx/B0T5u2llqwIAu9opvQ
	(envelope-from <netdev+bounces-269444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:25:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455342CBED8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7D53042FEE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C33D3CE6;
	Thu, 19 Mar 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHmzbm3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDD36C58C
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926544; cv=none; b=pNpPSFlNu7+Vq/jV6r2mgYMpaYE82mMWRITTEYg3+dGDahI8tFzpb6g3eL1KJj+CuRfHTDCuuuta3Pxg/F6kRN9TmPa1RVtIw6JebZOonkXNBJZZGmN+bIY9uUlaa3cqxRbkTs0ZOGjnaA+E0F1iQxGYLc2H+2tzyckBu4C5644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926544; c=relaxed/simple;
	bh=onzrOYEYgeK9puwSj7RmBF9bSxmOLmUBbpb5z+/Xdmc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SHGDohEGHNS1ezcn5uGFLWF5PKnEn2jaF84ozkxGfhyNButcRK4x+dQuvf3UX0p71EPScwlqxKyDDrbrLNZ9COuPlFvcuPUL0w01rNyQWPA96CAb/D4MWHbwjM7l65aK6PXiO7qcC0EDekeikSLGD+voO49ZLlWbRx4rvGdut58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHmzbm3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6622C2BC9E;
	Thu, 19 Mar 2026 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926544;
	bh=onzrOYEYgeK9puwSj7RmBF9bSxmOLmUBbpb5z+/Xdmc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rHmzbm3GWZXrwS5OWFIxkRZ64fnuOCbERdmkGVj8rerxfuwovXOpH/A3wno2tbDe/
	 Ap+CD/yB5Q9L4x0I7RDhmSYjtK2v0FH+J6q1Jze0r38GZqNiZVqDHfFr7IvCxaykpz
	 xTjfttlqN1WRiTF/4CTuhDKj5bksn5T90jWxRUX5oVwfkRSMWQCjKRdA98u9bNh2/o
	 eMC7PDDXhC420uyRRyDY1jkqQXyD86wud3xDFS5LXYrKbUsBtNflPSe28GnY+tZBW8
	 amRVaauS12z4R+V0fMKASEhncu8R71dP73XON5pwiu1PqyMWSkXvoxnuWTfq9Yj1VZ
	 1EJHz9BhPCQSQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9C1ECF40074;
	Thu, 19 Mar 2026 09:22:22 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 09:22:22 -0400
X-ME-Sender: <xms:jvi7acqR1gW8AeruRdVYm6SNmhJzXxlWlrA2UUXhhYTNUu4jcaw1Kw>
    <xme:jvi7addiHrEW_kL40-nfMjqgqQKvigYSjFEJd8yF9d3VG2_1xdSo8uhHHkAZlG5C1
    UjM7ZUZ3h5bTWHEgp_TS6eOTNMP1T7sQa-lhiRhY_7-9JdsoFHeYo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhonhhs
    thgrnhhtihhnucfthigrsghithhsvghvfdcuoehmrhhitghonheskhgvrhhnvghlrdhorh
    hgqeenucggtffrrghtthgvrhhnpedufeekteeugeevveeklefgudeifefhhfekkeeliefg
    jeeugfdvveffheffudduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmrhhitghonhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqudeigedttdduvdeifedqvddutdegjedtleeiqdhmrhhitghonheppehkvghrnhgvlh
    drohhrgheskhgvrhhnvghlmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohephhgvlhhpuggvshhksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jvi7aXq1KC_KVjIACPQ9JqMvME1Z6EgYcQZEg4nxn-ybNrerdqn97g>
    <xmx:jvi7acn_CE_S1-2mgi1JFf4eWguTp3EpCo4FkzEluUPY-HevtOI5Fw>
    <xmx:jvi7aTP19-W3q0O0InWngmisXfpe2tKenDoobLUNbOMT-u5ytQpPcg>
    <xmx:jvi7aQM9sfTZR_m8MAsTASt2cqi-Gq1QmYJBVmqhLTrfnLgSsjdBhw>
    <xmx:jvi7aUiITzBL6UWVrraB0vDggSs1EJf5hHkWYUV_tgBXYKu4_Tf-Zyi0>
Feedback-ID: i40364868:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7931815C008E; Thu, 19 Mar 2026 09:22:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5V-PA_1cc6R
Date: Thu, 19 Mar 2026 09:21:58 -0400
From: "Konstantin Ryabitsev" <mricon@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, helpdesk@kernel.org,
 davem@davemloft.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <6aec1245-d290-4d81-9a98-355bc8c3ca59@app.fastmail.com>
In-Reply-To: <20260318194822.434c0485@kernel.org>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
 <20260314104436.31bcf68b@kernel.org>
 <20260315-majestic-beluga-of-fragrance-cf42c6@lemur>
 <20260315132013.75ab40c5@kernel.org> <20260318194822.434c0485@kernel.org>
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-269444-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mricon@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.815];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 455342CBED8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026, at 22:48, Jakub Kicinski wrote:
>> > It won't work retroactively, but it should find future pull requests
>> > (hopefully!)  
>> 
>> Thank you! I'll report back in a couple of days.
>
> Since I promised - pw-bot replies to pulls seem to be working fine now

Great, thanks for following up. 

-K

