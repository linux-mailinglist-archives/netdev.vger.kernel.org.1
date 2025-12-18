Return-Path: <netdev+bounces-245316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F4CCB5A6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DBFF3032D89
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF56347FD7;
	Thu, 18 Dec 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RQxO2nNd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957C348453
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053496; cv=none; b=KqF7AszO0aFZW0W8WERJZSJa0xxxhwOHUlyIrKwNvYHtCt28ZWVRRviz/ZKWOnKGEQheTgpJMg/q0yyCWryp/eEXd4l/G8JWYWREXjFGxR4z/LezItIDexE6zDqrSiuy7Z3lQG1VtCxFp16CT+QngnYYfBzwaFa1yjRmrQ6kKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053496; c=relaxed/simple;
	bh=OS715kNwMYqu0HmlNpJiL7JgGLnskFbi5ZqqQWQziIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skEOnR9914xNnmlqqEaPv6XpsOveeiroZjfUZetsa13c1kaiQa3VoGzYG/36mZu2L20DBL2KTw5o8iDug9fM3jfDQKtwa/6VE6ZBbqhD//s6P2sQ/TuMm4r4Y4LYV58zxQ/7AwLIc6oHQQv7AYGraZd9mNIC7/ikQBFeNaTppe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RQxO2nNd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9chQrG4I5DsNOvePC2n8tAeuXWb2nr7AjljhY/R+dXE=; b=RQxO2nNdLrJWPHzwRPWM49vnvC
	i+wQ2X12YLe9sNn3QxrR05gG02gc56qMRLQWqSzgXjiNWof1t1KXbU4gP7CakVtnvHr3ftPm30DLZ
	OU8cPv6o6jBZCq9P1hHiwXT+S0SwCdNv4INLP9FzM0AGecNV0To1WgZ1vBlWoqiV7nnc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vWBBk-00HKC5-KR; Thu, 18 Dec 2025 11:24:52 +0100
Date: Thu, 18 Dec 2025 11:24:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Merging uli526x and dmfe drivers
Message-ID: <ebb762b3-d69d-446f-a94f-fa27e66ddfbb@lunn.ch>
References: <CADkSEUgY=eQz+0VWzAZwH6r6THHEgJaO1-SYemANZGaKEaWkOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUgY=eQz+0VWzAZwH6r6THHEgJaO1-SYemANZGaKEaWkOA@mail.gmail.com>

On Wed, Dec 17, 2025 at 09:15:16PM -0800, Ethan Nelson-Moore wrote:
> I just noticed while investigating the state of lesser-used network
> drivers that uli526x appears to be a fork of dmfe. They are so similar
> that they could easily be merged (with the differences being selected
> by the device ID, as dmfe already does), reducing future maintainer
> workload.
> 
> This can easily be seen by:
> cp uli526x.c uli526x_undo_rename.c
> sed -i s/uli526x/dmfe/g uli526x_undo_rename.c
> sed -i s/ULI526X/DMFE/g uli526x_undo_rename.c
> sed -i s/uw32/dw32/g uli526x_undo_rename.c
> sed -i s/ur32/dr32/g uli526x_undo_rename.c
> sed -i 's/phy_read_/dmfe_&/g' uli526x_undo_rename.c
> sed -i 's/phy_write_/dmfe_&/g' uli526x_undo_rename.c
> diff -w dmfe.c uli526x_undo_rename.c
> 
> uli526x has get_link_ksettings support and dmfe does not, and they
> have other small differences which might be bug fixes incorporated
> into one but not the other.
> 
> Would patches to combine them be welcomed? If I were to do so, would
> anyone be able to test the combined driver? I do not own the hardware.

When did you last see a DEC machine? Probably in a museum? There is no
point working on such old drivers unless you happen to maintain the
museum and like to keep a modem kernel running on these old machines.

	Andrew

