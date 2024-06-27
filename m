Return-Path: <netdev+bounces-107386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085591ABF7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B671C21B07
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE371991C9;
	Thu, 27 Jun 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="PC1OkiYC"
X-Original-To: netdev@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BB1991C3;
	Thu, 27 Jun 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503730; cv=none; b=bp24cj9w7FKM2JhbQPRyvVUAe5bX4dIEM6vLlZ6ZnpKzj1YnwVVvANM1rHC2+fLFZwsG4KLVqkI8L0mngHLryks52WKGeMKVCa2qi8kqyf5kbv6NSv+UaSaHpMv162bV4HPy1jyZnZd98T+54w/VwqDf9+CBWSsCRT/+BCMBS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503730; c=relaxed/simple;
	bh=hmm691HVF/fl1r0xfHpfk9Q2PjdsKJMbjGjGacpzrow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjAL3n/nmmj9Ubargr0uaspvUqxUVFsY9BCa5aidxqf9fAFU6VtwhzspVTGs79CLEOEWQaL9I+3HIV6uzsZW0Srup2e+83oGdCSSuvAqMUhB66N7Ltwfqb1ICFiWAGx5acOgIXj9CYHQPtYp6AyNWFctzRy9f2r++wRQRkkmf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=PC1OkiYC; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Thu, 27 Jun 2024 18:55:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1719503716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmm691HVF/fl1r0xfHpfk9Q2PjdsKJMbjGjGacpzrow=;
	b=PC1OkiYC/dgqHHnJJ04Wx6wVZthbitubnmFRwstPi613Vyow17GPCUG1Q2oVz6g9YLBBtS
	1zTol+Znsodxdtf6b8E+jQDEHtYhGJv4Lpbi2FrzsZwrLNJG5NUYEOqq2AWwZLSKOw0/2O
	bSukeuL4kJSVx2mTTpz4iSwqoalSw8w=
From: Andrey Kalachev <kalachev@swemel.ru>
To: Michal Switala <michal.switala@infogain.com>
Cc: davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
	lvc-project@linuxtesting.org
Subject: Re: Progress in ticket
Message-ID: <Zn2LY7gGod2J4UpH@ural>
References: <ZnWSHbkV6qVy1KHd@ural>
 <20240627115544.1090671-1-michal.switala@infogain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240627115544.1090671-1-michal.switala@infogain.com>

On Thu, Jun 27, 2024 at 01:55:44PM +0200, Michal Switala wrote:
>Hello,
>
>I am currently looking at this bug and checked your reproduction.
>Unfortunately, it doesn's set xfrm transformations in the same way as
>syz reproducer. The effect is that in xfrm_lookup_with_ifid, the packet goes to
>the nopol section instead of notransform as in the original.
>
>Regards
>Michal

Hi Michal.

Most likely system("ip xfrm policy update src 254.136.0.0/0 dst 255.1.0.0/0 dir out flag icmp") does not work.

syzkaller uses Busybox based disk images.

ip is present there (/sbin/ip), but it has limited functionality.
In particular, the xfrm framework commands are not supported.
The original reproducer worked with ipsec/xfrm via netlink.
The rewritten reproducer will work with a Debian-based image with iproute2 installed.
I made a Debian image of bullseye (the easiest way to do that is to use create-image.sh).

Regards,
Andrey

