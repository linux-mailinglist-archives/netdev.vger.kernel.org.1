Return-Path: <netdev+bounces-216329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3954B33249
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998031B20788
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393C2264A1;
	Sun, 24 Aug 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sq0OQVgk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C572613;
	Sun, 24 Aug 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062875; cv=none; b=o1jY7vWWtGDiXx+50Mar37Srk4ylCLn/j5014AikGgMqkUmu+Rt0eN4RmBm7i6iqlMnUy9pxfiBHbkE2lK3IjDwPhssSvH7vg4hDX1qgVI1Msz0LH7a3AgVlkWHwdhLjo2PA/jBPImHmK2R8zOlQUigVpXaPr6LApF7eEtRfwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062875; c=relaxed/simple;
	bh=Dqi5imgTMo+GIPv0TKUfIqfxBW/kuSOB2mlWatlCLew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkG43R3aS+xX1QYDW4rVsOBUNbltQrCa2XXw2qMY978X9420RK3dE5FEYKXPen1UHNY0nnEqg7NsG2FHTbVQMhuP9EmVO8taiospXM7+6JtND7lUyWKgGtqtdDT9Ylky6wuhVNgVjiWYroZfITeLrrQTLAjQNtYkODgz0ZEA0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sq0OQVgk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aPxew34gLbgHlqv9pcRjA5Xq7NTu5xb+NdZW3VC1XTo=; b=sq0OQVgkLnBxktCtdjXV627GoW
	wOvd47vuNzfW6p0qRC4uGVGY4rzx6PoEqb75kIC6pam5d4u7fNh73ak8uhTxKVJvLTp7qbifeY41a
	BqJKs+fsSUCIL9Vs6CSWlhD2Y96r4bfNkS8nAGQ91qXI/B8rBmm+ihtFS9voTXu0WP8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqGAX-005qy3-Ug; Sun, 24 Aug 2025 21:14:21 +0200
Date: Sun, 24 Aug 2025 21:14:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <d87a35c8-3d4c-469b-a490-9be116b982f3@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
 <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>

> Port 10 is dedicated to the internal MCU. Although I could not use it,
> anyone familiar with the chips would know it's Port 10 that is neither
> internal nor external.

The mv88e639X family has an internal Z80 CPU and its own port on the
switch. You will see code like:

                .num_ports = 11,        /* 10 + Z80 */
                .num_internal_phys = 8,

It is considered external, in that there is no internal PHY attached
In theory you could list it in DT, to instantiate the port, and then i
guess bad things to happen :-(

The good thing about this is, if you actually try use both the Z80 and
DSA to manage the switch, bad things are going to happen anyway.

So i would say there is some flexibility here, given how other drivers
handle this.

	Andrew

