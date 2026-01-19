Return-Path: <netdev+bounces-251188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BED3B397
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01AC6323A9FD
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE132B9B9;
	Mon, 19 Jan 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAUg3KN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807932B9A9;
	Mon, 19 Jan 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841208; cv=none; b=od6GE7cG9J1YfbOBB9npS+3ieda/1mTVOcDenZXLZokD3m2tsWe6k6puzkhUE9zNoRmrFkuyLy6Ltgcaa7vPBXO8hsFmDHDIAyvXRU/5DHqCi0F5TvmmXe21bLov97V2Cod6dQURvcSeKrqBL7/tfMyBKlT3y1/SMTdab9Z5id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841208; c=relaxed/simple;
	bh=kqcwi5MqlAqFZXrbgx1vjvCTwF5sWC/GlFe/d62UsJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9C4X3/s1EZ7Ga1FptSR08dnyXLMzM06T+hdgMtlM/jqMfaAscNgGDdZwQ5vHC3isjzXdA0To3huH1wa+rbSHP1zY2FRxndsi+G3vP0/xZOZcMhLewmgVk3XC6rE6L85672o4KwCTY1h3jH+t36dBj8NJp+xIguibQuk0QWjWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAUg3KN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241D1C116C6;
	Mon, 19 Jan 2026 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841208;
	bh=kqcwi5MqlAqFZXrbgx1vjvCTwF5sWC/GlFe/d62UsJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iAUg3KN6TswMfuIqXHqj6mIVK+z3TNbpckSb1E5h7OOK8ZtrqrycJA4qbkZaJRvtt
	 bhdVy4yqY7MGx1Il4oXGmvgweTBWeA2nwJ6/iMDG19nixnO9Ns27vuZp6kyI0OVsLB
	 QYsP/ldkQLmBxq68gjrkWSiPw7iDAjYB7taROUhD6VqKx0TV81/i+KUeHhrLD3K5wu
	 FdeG+LC2psVyAsgzep/gOfJa5e1uPZvR5jy0zmkpg1UU1xJSxHoSr2HF0pUUEyTbbt
	 hHxBd0RmFLd2ikijH0YC43fhGJwqaHTFp2izdL2X1oJBCwWGcTkg6cIAbrzoGm532k
	 HTOwVefqVeIDQ==
Date: Mon, 19 Jan 2026 08:46:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+list849c3c7cc70ceeb09a59@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [syzbot] Monthly net report (Jan 2026)
Message-ID: <20260119084647.34505b70@kernel.org>
In-Reply-To: <696de90d.a70a0220.34546f.0436.GAE@google.com>
References: <696de90d.a70a0220.34546f.0436.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 00:19:25 -0800 syzbot wrote:
> Ref  Crashes Repro Title
> <1>  22186   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
>                    https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26

Thanks for the report! Could you reclassify this one? It's in RDMA.

