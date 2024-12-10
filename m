Return-Path: <netdev+bounces-150834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBC9EBAF7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039F81887D93
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669C22757D;
	Tue, 10 Dec 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="s16QIesh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCsHx2A6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F123ED69
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863528; cv=none; b=JLr32y4L7zCh3ILNuz1/HkYQIa4ZLmMhqlwgRPxfsDk4GqibDC2/zmr12bgeyw+A85nzFzOTwhPoQkeGYDLmufqJHNN8ELwkDwgBennpgVAIx9GPP9ScCBCil5L8lTRQ1veiHsQwK7xIXL0obG4Z6owwY5HMqfUZ5DyJAcCKoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863528; c=relaxed/simple;
	bh=9M1DsEvwc5rxA09k/IW+vmBWPZ2/gtrpu/7TS912vNY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=PdIkUf5gEBL/diRh3+BFmHoGeM66xDbqwLoPp/Ey10wgsY6SznuCpTTjIIeMXxvSfmw9Dc3mhasZs9UFPFrbtjnNHlu1jKT14Tw0oKwEGtW7oFMEE7+TU07gWIlHYn3C/fKGIbD3F+7P5hcLgcr4/U4TcG0rTUaH3xlCxA00oqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=s16QIesh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCsHx2A6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 091BC11401EE;
	Tue, 10 Dec 2024 15:45:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 10 Dec 2024 15:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1733863523; x=
	1733949923; bh=BsiO2QCwL2jdmBjcxAhmN0EQb9Ul1S29rCmW+nqrcTc=; b=s
	16QIeshRCSj1cVLsjutBqYV25Hu5MTSiM2nB5Xv5EtQLvaV9RgKTs5Gb7xbbGYYP
	6lUN7GdBVGEJoVvHhHGEfs9VRwiCZqxWCtPekS/upmSuB0rwzOhuXonem6JHl4zp
	slJyXZNa6Q6jVMLTqlFFyHG7BEXxHZpAgF0pa68WpGrPRGfkgsmOSngiKU0Z9I/N
	9BSpPeDrr9PcpdAbCsyBCxIOHpJvL4cvPOc02WVYgayaYLmr9C/H6di69EjretZj
	Z1xDMxQwgkT8A5WYZvmc49uGyHq2MJvxFL5h2IGy8K5GssW4nMKLp5rhuFdQ25xw
	ZkkqGv5Mr4Jnkuw58C3GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733863523; x=1733949923; bh=B
	siO2QCwL2jdmBjcxAhmN0EQb9Ul1S29rCmW+nqrcTc=; b=DCsHx2A6nUPLjV7af
	h/BwP7s8L1mqUZG36j1HpgjMpkrUYa4veAfjfpZ5MGZQllyrnBACHkdzMrd0EH4c
	dxlaeKkSCoi7qUDaH7HT6QBwOgWxP9ga7tQn3Zb1geDSr9SbziT1mJcK5cuoHsaK
	AjBhqs2oki5MLa7F7bOBX3meItJwZs7Boj1WNGB9D5zLqW493K4GPqcXeCeHKUpB
	YUCoVyv0fcXxu3QEVV+0RPSR2H3/zGsDTDCqjQkmmoIRRk8lu48kQPwY36Bph7B0
	TxnkvM9HO5SAXBRiwb3Mm5xdDWd8hNlx2An1HU0YD4VzViQQsLbk4ZtQ1q76lOs3
	05WCA==
X-ME-Sender: <xms:Y6hYZ-H3DC4PNHR7sg4ybv0dCAOue08Rt4M3zRbyS8dVaMdgOUFFTw>
    <xme:Y6hYZ_XMmytJMGxIKzoZ0byjKum-vVasURvFkeDCMcyxt2y9rhkNWsdpX7l4rPKBo
    garRdDNCGnLzlCVpH8>
X-ME-Received: <xmr:Y6hYZ4K6turC3n4faFUrSLyQfIfQlbIIEun5mLflAC-9k3rrSYTSKLSnn5Yj17OEjg0PZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhfogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcu
    oehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedvgffhte
    evvddufedvjeegleetveekveegtdfhudekveeijeeuheekgeffjedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrgh
    hhrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrshgvugguohhnrdgtrgesghhmrghilhdrtghomhdprhgtphhtthhope
    igihihohhurdifrghnghgtohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehnvght
    uggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y6hYZ4GhGQycrXbxIPV0PtJOVmP8HXjEr0rDMkY7K9gwr9WNLOSh-Q>
    <xmx:Y6hYZ0VuMys0Xa2gy31lJsF2elxxAglhu4kLAsO4hkoRq_yHNU2qKQ>
    <xmx:Y6hYZ7ONepjLL4wexPrshDIUy7P-iacIFdRkfofwdPUBwLN2DyfLJg>
    <xmx:Y6hYZ724HlXJpCRy13hrfpu-qnJcDEPcIe0hnWkhSk9bHqBfhW5Z6Q>
    <xmx:Y6hYZ7TWVVPXlzxCukHkFpKSAXtkjZo3yw-uQ6vnfGwbLvusPIlJpxD6>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 15:45:23 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 3D40F9FC91; Tue, 10 Dec 2024 12:45:22 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 3A7EA9FC90;
	Tue, 10 Dec 2024 12:45:22 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Cong Wang <xiyou.wangcong@gmail.com>
cc: dave seddon <dave.seddon.ca@gmail.com>, netdev@vger.kernel.org
Subject: Re: tcp_diag for all network namespaces?
In-reply-to: <Z1fO0rT9MZs5D61z@pop-os.localdomain>
References: 
 <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
 <Z1fO0rT9MZs5D61z@pop-os.localdomain>
Comments: In-reply-to Cong Wang <xiyou.wangcong@gmail.com>
   message dated "Mon, 09 Dec 2024 21:17:06 -0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1373212.1733863522.1@famine>
Date: Tue, 10 Dec 2024 12:45:22 -0800
Message-ID: <1373213.1733863522@famine>

Cong Wang <xiyou.wangcong@gmail.com> wrote:

>On Mon, Dec 09, 2024 at 11:24:18AM -0800, dave seddon wrote:
>> G'day,
>> 
>> Short
>> Is there a way to extract tcp_diag socket data for all sockets from
>> all network name spaces please?
>> 
>> Background
>> I've been using tcp_diag to dump out TCP socket performance every
>> minute and then stream the data via Kafka and then into a Clickhouse
>> database.  This is awesome for socket performance monitoring.
>> 
>> Kubernetes
>> I'd like to adapt this solution to <somehow> allow monitoring of
>> kubernetes clusters, so that it would be possible to monitor the
>> socket performance of all pods.  Ideally, a single process could open
>> a netlink socket into each network namespace, but currently that isn't
>> possible.
>> 
>> Would it be crazy to add a new feature to the kernel to allow dumping
>> all sockets from all name spaces?
>
>You are already able to do so in user-space, something like:
>
>for ns in $(ip netns list | cut -d' ' -f1); do
>    ip netns exec $ns ss -tapn
>done
>
>(If you use API, you can find equivalent API's)

	FWIW, if any namespaces weren't created through /sbin/ip, then
something like the following works as well:

#!/bin/bash

nspidlist=`lsns -t net -o pid -n`

for p in ${nspidlist}; do
	lsns -p ${p} -t net
	nsenter -n -t ${p} ss -tapn
done

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

