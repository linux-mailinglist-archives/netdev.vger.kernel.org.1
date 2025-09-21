Return-Path: <netdev+bounces-225097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E90B8E43C
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC331789D5
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632191D5174;
	Sun, 21 Sep 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aWk6B1jq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XBKvgh9/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13619DF4F
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758483241; cv=none; b=geuBiglzBMAAjvorTWWJ1NeyJHTH4q6iB314YCIkbZirSuZ8LClvHyK2ubZgMw42ayBVylWgiuiyUEQXeWBmZ3i9HRwfQp5xz1L34DEfe/cFuofKK/TV1ly3CBuGYhI5k7zk4kGms1EuLBfOJ5VfEUSozZdSflNAFlGOnRYnC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758483241; c=relaxed/simple;
	bh=qGC3Kxkf1zgq7sxFnC/2TlD97WX8hGkSnHEBCOP++bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh1XgsLIpP5T3q5B2CQPG3ermmeVLqO8Wt2tk3qfagN2dQZQj08FK3vCvFD/l8Pone+U1/Z4jQqCLPvqgR4IjzSaBW/DWjaVN8cuepPYSYdBCIgMRn+oXX/IfwRjqKuR+rixp44BxtSKSN7zisbcdnFuXEoPGCxB6hCptLqu7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aWk6B1jq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XBKvgh9/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 21 Sep 2025 21:33:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758483237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pzi1PpfNBX5JFQ5Y7yP5pyXsMmv9unfm52Ed2IjfP/k=;
	b=aWk6B1jqYc4y37ENTtjkQ7cCOQIs4khbHbE5n7cEd1iak5BU3PwIqXuscWxjxSSuAoroET
	kB11pWVtKz8rt5COJEz3Szvkcd1fibCg0pzYPvIqoCMtWQxmCn27NPrkzB3YnyF2zwxrg6
	briyG6UNgs1pwjrpHokXYSqMan7neVYP/f0W8KzvLeB/aHBQ1Lkn/ceH/fh0ObdpcK7dd+
	adt9oxYCwNI8clxPUGPHfwAiA1X8F6+dXFf+o1fmoH0zTh83YxN2D0ybLjRsLiRmfBqyYa
	vVWN0tGA55FCMDc0J1AmG7LNIM+89gIGLyQMuu/L35W1Wa6jHamniA3CmWnemA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758483237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pzi1PpfNBX5JFQ5Y7yP5pyXsMmv9unfm52Ed2IjfP/k=;
	b=XBKvgh9/dUERkGhnMzvlvBjkahz3VCn1dBABCoe4Fpqp1XNaFkGWwDI/fFkGRnVaifmqtQ
	Ziw/yUkjntu5MKBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Yunshui Jiang <jiangyunshui@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>, Geliang Tang <geliang@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [HSR] hsr_ping test failed
Message-ID: <20250921193356.rCL4R8lo@linutronix.de>
References: <aMONxDXkzBZZRfE5@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMONxDXkzBZZRfE5@fedora>

On 2025-09-12 03:04:36 [+0000], Hangbin Liu wrote:
> Hi, Sebastian, Yunshui,
Hi,

> I tried to run hsr_ping recently on x86_64 arch (build via vng --build
> --config tools/testing/selftests/net/hsr/config, latest net branch,
> iproute2-6.15.0) and the test always failed due to error
> "Expect to send and receive 10 packets and no duplicates."
> 
> I checked the normal ping test and found it also has duplicates.
> e.g.
> 
> PING 100.64.0.3 (100.64.0.3) 56(84) bytes of data.

Something is broken. I traced it down to commit
	9cfb5e7f0ded2 ("net: hsr: fix hsr_init_sk() vs network/transport headers.")

haven't put much into it but appears that skb_reset_network_header() is
expected to be initialized "late" which leads to the large mac-len.

Sebastian

