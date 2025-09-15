Return-Path: <netdev+bounces-223049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C56B57B6F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD6447061
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950330C601;
	Mon, 15 Sep 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lKyKz/ke"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C3302CC9;
	Mon, 15 Sep 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940165; cv=none; b=Xqzsy36yfNhPuqdSiKcZqacQdKgobBUA3s4p6O7Qm1BpfR+GDoeKw6oYz1nADjAZyFtJ9nPXlvjRW9ep5l8sKPjiyzqmpj8niWF/ftSs7zPKqQdwDmE1R45SbIvwCBOhxNfMlDQpEsvr+Q4Gy0kqCDuDxOu1p7eAtaT7Wa1Nqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940165; c=relaxed/simple;
	bh=aNskhq3Cmzm3alKPr9Rro+188cJKwfTQ8rO/BJf4CyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbbWxP0Un2JSb1U7AM8/3w17EjaBGdyd5T0289jtjTprZ5ec2WrJZfHTHV4dxzzsGShED9wXUbw277tLYPF2h9imNhbocBwLkmFtZ3z5/+nnlsHUljGEk1G2QeGlsWL2bdbo6hnATFPfZ7f2MbcYtJiZRaHtFBm9EfZfI0TCpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lKyKz/ke; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jZcPuO3anU5LkN9y1m2FeE7inKsARtSp8ndgiLojr2I=; b=lKyKz/keXRJK/B0spe2Kgwelbk
	F63gnLL77Wtp1c2ofxyqNX6PCV1pKwPi3urXU0Sig/LrKLZt4KvZf28UNgHWPSKOmzSWxzsk6XWCi
	ywE21yRXb/FqDMiSw0KVqzPFgrcvkMcqdJzT2yACOVloMkKvkM3/oVQIQAUSy9Cp1Zew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uy8XP-008RIJ-Ca; Mon, 15 Sep 2025 14:42:31 +0200
Date: Mon, 15 Sep 2025 14:42:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add Fast link failure support
 for lan8842
Message-ID: <698d4fbe-a84b-40cd-986f-1ebaecbf60b1@lunn.ch>
References: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915091149.3539162-1-horatiu.vultur@microchip.com>

> +/**
> + * LAN8814_PAGE_PCS - Selects Extended Page 0.
> + *
> + * This page appaers to control the fast link failure and there are different

appears.

And just curious. Why appears? Don't you have access to the data sheet?

	Andrew

