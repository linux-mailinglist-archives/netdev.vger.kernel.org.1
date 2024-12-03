Return-Path: <netdev+bounces-148292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934CB9E1084
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5673E282783
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC528828;
	Tue,  3 Dec 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DwKx3BzA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6F10F2;
	Tue,  3 Dec 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186934; cv=none; b=YJ9en59i8yVn6olDuktfJ9k/GAenmOdHuUF7Bzs6cFCFy6aU3GZPJCPR4KMfoMguUQ2MQoGPAk48iQzKvaMxdfrQ6pCnTj8KO4cu6uGkQ+llRlUxW6lUkiP1U0j/2YLKIps+GAVKkrfpbCEdo5RcstNK99si9uaNjxgB5jgUiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186934; c=relaxed/simple;
	bh=Kohrn/r3kJUIE/1CLkLKKsDIsURJR9Q6soGM08rJq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T05yYKjHmPYwrP5L89/eaBvTdiGrr18rMzuv+EGYe6OZMaKM8EKVHj6aICdNVVHg574EWWN1Co2fvOY+xHc1IVfjZHKiYwPiClnuLFRQBjTauu5KubjORC1O6+p9TzjCgvrOWd1GXsyUfHAQP/JWIzaIJAHN8AY2z8ibsj70zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DwKx3BzA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BwYIYsnjo2/NyptkkM25mrPtyLgZ9LTr+fZrUyhiw4s=; b=DwKx3BzAjMbVdclLZH5DeQEtr2
	7hHfikBmqmprVeYmL4K+nae9Qyz8J1jISKnuscXEy+bHZaPXYO5e4vtu7gsVseEnstpkKpWdnRcaM
	mrMFYCEKvFmueMUlb17EVG2uYzheQFVgJ+JPIxRH4JvWA0BTZSO0Avu13ZbT5Gtt5b58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIGPL-00F0o5-GB; Tue, 03 Dec 2024 01:04:51 +0100
Date: Tue, 3 Dec 2024 01:04:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhiyuan Wan <kmlinuxm@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Subject: Re: [PATCH 2/2] net: phy: realtek: add dt property to disable
 broadcast PHY address
Message-ID: <bc8c7c6a-5d5f-4f7c-a1e2-e10a6a82d50e@lunn.ch>
References: <20241202195029.2045633-1-kmlinuxm@gmail.com>
 <20241202195029.2045633-2-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202195029.2045633-2-kmlinuxm@gmail.com>

On Tue, Dec 03, 2024 at 03:50:29AM +0800, Zhiyuan Wan wrote:
> This patch add support to disable 'broadcast PHY address' feature of
> RTL8211F.
> 
> This feature is enabled defaultly after a reset of this transceiver.
> When this feature is enabled, the phy not only responds to the
> configuration PHY address by pin states on board, but also responds
> to address 0, the optional broadcast address of the MDIO bus.
> 
> But not every transceiver supports this feature, when RTL8211
> shares one MDIO bus with other transceivers which doesn't support
> this feature, like mt7530 switch chip (integrated in mt7621 SoC),
> it usually causes address conflict, leads to the
> port of RTL8211FS stops working.

I think you can do this without needing a new property. The DT binding
has:

            reg = <4>;

This is the address the PHY should respond on. If reg is not 0, then
broadcast is not wanted.

If reg is 0, it means one of two things:

The DT author did not know about this broadcast feature, the PHY
appeared at address 0, so they wrote that. It might actually be
strapped to another address, but it does not matter.

The DT author wants it to use the broadcast address, it might even be
strapped to address 0.

Am i missing anything?

	Andrew

