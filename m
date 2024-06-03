Return-Path: <netdev+bounces-100403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418B8FA6A8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98721C223DB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB7137C48;
	Mon,  3 Jun 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJuAI/FS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EC81736;
	Mon,  3 Jun 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458845; cv=none; b=GwA3NFFQszlZkoAKYgO4bEosbugTKzu2ld3utSR88wUSNFRJHB5JXjGgRKfz20C9GqExkmnfl8WqBVP8m+MEUIuuUd2stRywcFY5v5zDJ62OFhRgcq1nTSJlDDbiB+ks5sAQlgeE9T7stuTMrqMiPyNx8AqPw+YhIPrkbR9fojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458845; c=relaxed/simple;
	bh=3iqePMcRCpRmCaztme16eVBY3ZAraIQTl1ul9uEadqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6tKyxu43q2+mKujbj6SCdVK+VUlCi/CUYRx+wn6/K1dkhRH2T289xHBpSJFmWg9QV+s96L+oRWpG7l9esFgzI/3K5zhJGBH6I26wNqNGIwiYsvTu7gQsCGpzspl1qteQMiT6TeP04u65cIqCKugJIA3AD76HGrO13hHrBon6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJuAI/FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175A2C2BD10;
	Mon,  3 Jun 2024 23:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717458844;
	bh=3iqePMcRCpRmCaztme16eVBY3ZAraIQTl1ul9uEadqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJuAI/FSiBhygz2JM9O4fcI4fU/klINi8S9mHKliPtRTIBucQZu+ihg5dBt9Bing1
	 2a5a1G5wQxnUeX5n6T7ia/z0xwQMZEIVEZ0WEz1h3y4D7ZZ0V0g1ymaMDXUoaRmz25
	 6JCiQqLNb+vaKbZQ6Tlzem5JwCo+2uqr20sH64OQhzzbePsE+3QsXpwj9w2JXdKV7u
	 C+y9u+5PZFC/qUJLHqgwuDsH77+qUU2H7OdvdgQVGFv7/V+44AxRof6i10I///blQT
	 qHjK3nMx6t9a6w28TbOh9txjMGXuSBvc5j2Hkg5LXYNBB/Iwro1SHKE5UZ839E0ENA
	 Scb0Uivq0S74w==
Date: Mon, 3 Jun 2024 16:54:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yojana Mallik <y-mallik@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, schnelle@linux.ibm.com,
 wsa+renesas@sang-engineering.com, diogo.ivo@siemens.com,
 rdunlap@infradead.org, horms@kernel.org, vigneshr@ti.com, rogerq@ti.com,
 danishanwar@ti.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 srk@ti.com, rogerq@kernel.org
Subject: Re: [PATCH net-next v2 0/3] Introducing Intercore Virtual Ethernet
 (ICVE) driver
Message-ID: <20240603165403.1133217c@kernel.org>
In-Reply-To: <8f5d2448-bfd7-48a5-be12-fb16cdc4de79@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
	<8f5d2448-bfd7-48a5-be12-fb16cdc4de79@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 17:45:29 +0200 Andrew Lunn wrote:
> On Fri, May 31, 2024 at 12:10:03PM +0530, Yojana Mallik wrote:
> > virtio-net provides a solution for virtual ethernet interface in a
> > virtualized environment.
> > 
> > There might be a use-case for traffic tunneling between heterogeneous
> > processors in a non virtualized environment such as TI's AM64x that has
> > Cortex A53 and Cortex R5 where Linux runs on A53 and a flavour of RTOS
> > on R5(FreeRTOS) and the ethernet controller is managed by R5 and needs
> > to pass some low priority data to A53.
> > 
> > One solution for such an use case where the ethernet controller does
> > not support DMA for Tx/Rx channel, could be a RPMsg based shared memory
> > ethernet driver.  
> 
> virtio-net is very generic and vendor agnostic.
> 
> Looking at icve, what is TI specific? Why not define a generic
> solution which could be used for any heterogeneous system? We are
> seeming more and more such systems, and there is no point everybody
> re-inventing the wheel. So what i would like to see is something
> similar to driver/tty/rpmsg_tty.c, a driver/net/ethernet/rpmsg_eth.c,
> with good documentation of the protocol used, so that others can
> implement it. And since you say you have FreeRTOS on the other end,
> you could also contribute that side to FreeRTOS as well. A complete
> open source solution everybody can use.

100% agreed! FWIW there's also a PCIe NTB driver which provides very
similar functionality.

