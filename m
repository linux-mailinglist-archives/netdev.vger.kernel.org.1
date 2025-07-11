Return-Path: <netdev+bounces-206259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFEDB0256C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A8A17FECF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E92F1FDB;
	Fri, 11 Jul 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT4ThKpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B531F2382;
	Fri, 11 Jul 2025 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263631; cv=none; b=P2L6C59KQPW5gSa9OuYjswySS9VDby8n1E+V/CbbL64hBcuHt+3/tvPhQHKJLY4EAyGe/vzl4g8J7sThduYrXQHYSuaYfXkYg/GS2+x1Ng4R1zH5lupEl2cmQRTDMwIpaOrVY6T/crbjlKZD+tAw3hVdUHn82VFRu8qsfCkF/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263631; c=relaxed/simple;
	bh=WYXRyS4t9dECZkBVNQum/0iQ/pFkMEhtJosW4euJws8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/iwpuPi8Bo8td1fU8gbRbxFMbUZsFuHncOvuIoPMVnBWqM8PzFTe34yUcfmxMMbT3+1KOgywFo0jJW6Nqmg6IZaAT9lDVSGJm3e3Dy8Yx4nywI6gb3c8ozIYsRWp3AWL1T4XLFt7HqtT7ojSXLMSevsrebqtJ7yi7yCjZUnCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT4ThKpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D027C4CEF0;
	Fri, 11 Jul 2025 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752263630;
	bh=WYXRyS4t9dECZkBVNQum/0iQ/pFkMEhtJosW4euJws8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HT4ThKpftRIH9FHRwTJoW1isukBW3G2nSZ0IxKIIk+IRuZh4Tm2knlnKlfAONc0qC
	 uGhUOEt72FOFm4qBgQKJ1bDfXWQjjPSZrjigiYS6hT3fsdDyNTol9xk2VmXFNHw2ue
	 82Ye8tjx80ZjzB/0kkT1gC/Rf2ZPffH0/a+lULxbKzFY6FeDq+jqxpzMU9aqRT5ww/
	 AEsC+39cfQbAK6xNh8UZ9XuI5UbNQKeA/2wcWPMafgX3W9SUIIuawhP978QnebGaFD
	 qT5Z/qojNXqNm77mwg5ppNPgLotRUdvgfMLGaGrkSg1xUbR8OVZG87/hb7GygbiSmu
	 ewjnV3WTvlTiQ==
Date: Fri, 11 Jul 2025 12:53:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
 <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
Message-ID: <20250711125349.0ccc4ac0@kernel.org>
In-Reply-To: <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
References: <20250711151002.3228710-1-kuba@kernel.org>
	<CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
	<20250711114642.2664f28a@kernel.org>
	<CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
	<CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
	<CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
	<CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:42:54 -0700 Linus Torvalds wrote:
> Were there any other socket changes perhaps?
> 
> I just looked, and gsd-screensaver-proxy seems to use a regular Unix
> domain stream socket. Maybe not related to netlink, did unix domain
> sockets end up with some similar changes?

Humpf. Not that I can see, here's a list of commits since rc5 we sent
minus all the driver and wifi and data center stuff:

a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
a215b5723922 ("netlink: make sure we allow at least one dump skb")
ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")

ef9675b0ef03 ("Bluetooth: hci_sync: Fix not disabling advertising instance")
59710a26a289 ("Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state")
314d30b15086 ("Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle")
c7349772c268 ("Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected")

d3a5f2871adc ("tcp: Correct signedness in skb remaining space calculation")
1a03edeb84e6 ("tcp: refine sk_rcvbuf increase for ooo packets")

ffdde7bf5a43 ("net/sched: Abort __tc_modify_qdisc if parent class does not exist")

Let me keep digging but other than the netlink stuff the rest doesn't
stand out..

