Return-Path: <netdev+bounces-281125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id siH+Fgkh7WmCfwAAu9opvQ
	(envelope-from <netdev+bounces-281125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE14679F7
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19FF3009F82
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950F1FCF41;
	Sat, 25 Apr 2026 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFX2e1uZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475FE555;
	Sat, 25 Apr 2026 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777148163; cv=none; b=Irv237OwwiEGZqWnnj5+bD0+SAZSZZHswHrUN1qZ/klf2K++/Y2fI5Ykun/P5+A+6JF9uEBTVriTd0bdYxvjCSBZxyzZZCZE3ETjP9DM7bP7vkHWqgXPulG88vKaQOJkmMJ7Pgkx8DvW/V0f5E/yxMQy/OMZmwIGF1Zw7OEx9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777148163; c=relaxed/simple;
	bh=rLa50qL98+ez6OtlPEZ2OTIxU2VSfQEVMNz8bk5lpSw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JYcIFBnYkSt4nHYPKVq1a21/HcN55W+sP3oezWbxmKUJDaWA2cXNngbhVrEUGUeL4sCYvDj4UF7oItLgiFxok5L5KZBKSPSKHxT3oFlhfMTzMuqPyr++9YR/Rv4Z9qHAwIc4My89ONYUYVjERBndecXFxPYuYr4on5nC0bGjOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFX2e1uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C6C2BCB0;
	Sat, 25 Apr 2026 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777148163;
	bh=rLa50qL98+ez6OtlPEZ2OTIxU2VSfQEVMNz8bk5lpSw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cFX2e1uZk2F5BWXHEFxHM7YltQ4P2c48QUla5QCoHQjXXSfPtWVIdke1aNj0wKivO
	 ZoM9EbW+QUlQzfC4/m7i+Z8B2bcK0iAXwnwK6o5QfkYmb198GC4bHQODOEPryl4x1h
	 1+U2DiYUXwP/Zi+UQHx+fHENKctEcJCH39vwHELNdYp4ouCL1z4ve8z6hnywvSeD+J
	 frSFKAZGzHWBpoTEOBNCdTqQX3Mc08xhM1IFn6JSGX86GpOmK4xqcW4ghFj8t7d2Xa
	 QC7Nxno9Sb1s5LpFHm9ht7ePP6VjVPyJx8L0BBMuEhJi4II3NzSXUPv1t58PEUNQ45
	 DxGSafEWITfAA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A53E8F40074;
	Sat, 25 Apr 2026 16:16:01 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 25 Apr 2026 16:16:01 -0400
X-ME-Sender: <xms:ASHtaWrEjYtanfQsUQPw0r9YajNDL3Ff_5VykkGJhuxFGfBlvtVvIQ>
    <xme:ASHtafewGqMcpHKBl2gXHObRyMgG-wBmi-C0iRwLwNcfok1Z-cazx33t0ZoMUD3ww
    SZHIk3bJ_3Kw7sxGw2qoK5K8M6IqgYTVlJhMj1sQOZ1Yqyp5aCFgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejfeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhh
    rghnughshhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuh
    gtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    ihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhm
X-ME-Proxy: <xmx:ASHtaWowm66cmvBOmPkBPUlHryKWXbei1CXArbam6AMoO62ntBrGcA>
    <xmx:ASHtaQrXAjQlo1rIopxHhWUp9gLXydf2Us1uDJq-y0hVMUJHtwnKCA>
    <xmx:ASHtadbbYx42rf4ASWLB22KV9ugkyJdCrbLF8Ennh8RDK2WZ5XkiHA>
    <xmx:ASHtaW--AhhjPUWErmfXoLzCbckqMUFEJ4C_JkbIlwZWUn8SYor55w>
    <xmx:ASHtaTmktAeNfZJMU-sbRvlXwpNSeKd3oP5AnIeiWEPVcDEKNOEJ_mDP>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83AF0780070; Sat, 25 Apr 2026 16:16:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5XFUYgNEVqc
Date: Sat, 25 Apr 2026 16:15:41 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <4a802e09-d1af-4af3-8f02-3e2c8d25e734@app.fastmail.com>
In-Reply-To: <20260422190815.7f678ad6@kernel.org>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
 <3fc31ab1-23de-4381-b85c-5faa39169ad9@app.fastmail.com>
 <20260422190815.7f678ad6@kernel.org>
Subject: Re: [PATCH net-next v7 0/5] TLS read_sock performance scalability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 42FE14679F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281125-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Wed, Apr 22, 2026, at 10:08 PM, Jakub Kicinski wrote:
> On Wed, 22 Apr 2026 12:41:43 -0400 Chuck Lever wrote:
>> I see that this series is currently not in v7.1. What is left to do?
>
> It's marked as Changes requested in patchwork, possibly due to
> mis-reading of the discussion on patch 4. We process patches within 
> few days (well, we used to before the AI swarm) so if in doubt you
> should ask sooner :S

Thanks for the pointer to the netdevbpf patchworks instance. Anything
I can do to move this series to "Awaiting upsteam" ?

-- 
Chuck Lever

