Return-Path: <netdev+bounces-190772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DFAB8A83
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DB81BC1D23
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062221638D;
	Thu, 15 May 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O1sydzeC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052F211A0D
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322581; cv=none; b=AXr5pgGlCPW6KQHWdmh03KxXAifyJjEfb+RIUB+w8FCmqLvqxCG6FHuyXatZ15qN1c2RIZlTp8r+9oWgJ2mwrRLUwj4ZcuT7xA5sIGWNMkQt1s9Wa2ipAhzFtGqlOZOidzEwwWaNvwUNPL4sJxliJhBlmg/tx+eZe971nrItgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322581; c=relaxed/simple;
	bh=hhlcR2U81sPXphrNLF7N98yyO3Y4y1DMjhRbF5rLamk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0GnP1wjbMI5ozhOUnaTbYFExOgn4YFOhn1mBfJQLaOm0S6W7s4P538/lsVqu6jgAIE7ZedOWdR+9t27FItp51E6JEPPUpueVaE+HVt7bEuE0kWKEu9j8L8ZU6kVnOWgmNp8auChPlqDtDI/mfXlTCYq08rADz5oGLsRf2S5zQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O1sydzeC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U2pbaVFtdRa1mp/b1kzTzBJe894InFTpWKcTnMoSbrw=; b=O1sydzeC2V5GRnMlibw1JqworX
	xpn4EuIKfoMf1LytBkoqjdrnaPpztG9YUysUIjwcwszp4r449uDtm3D0h9qBtJCiEZlM57y2UuAKu
	tB1K8AdbA9Fb7DhmUStKIEmdHPKS8IFeLv96bex9eEArDuMUHlhp6j/pOWNiqrzf3pIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFaQ1-00Cg86-4J; Thu, 15 May 2025 17:22:45 +0200
Date: Thu, 15 May 2025 17:22:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: add RTL8127-internal PHY
Message-ID: <300c4d31-6ea0-48f5-9baa-54e37bd9c092@lunn.ch>
References: <20250515030022.4499-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515030022.4499-1-hau@realtek.com>

On Thu, May 15, 2025 at 11:00:22AM +0800, ChunHao Lin wrote:
> RTL8127-internal PHY is RTL8261C wihch is a integrated 10Gbps PHY with ID
> 0x001cc890. It follows the code path of RTL8125/RTL8126 intrernal NBase-T

internal

When you have fixed that, you can add Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

