Return-Path: <netdev+bounces-146057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAE9D1D9C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4F62827AF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F6136357;
	Tue, 19 Nov 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FoRpVWRN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C93398A;
	Tue, 19 Nov 2024 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981023; cv=none; b=BbxpwKPs3uQr6E9M8lUCzuOIjQFuL+gmFa5Kr2KRCQOfDj0qj2Wv0C9wxY64Z7YrREg/b+3DKXpLC+OFhJS02NcjpVWkQSCyNpNCcZtP/ksT+EdJ4xPHk+831F7gqHlBoy25QGme5aGoF3JtF6XP6EOs19W8Vb446X4WrsvxMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981023; c=relaxed/simple;
	bh=ZLvzK+7W9pfv/c/rKo8MT8ANCSB2u90QGyu15CT7M5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxoE9I1aZIIoV7D+3DqWFvS70QVosJDwjITeermRRJ9EGKIt7BVWqvhHd9k7R8Yq3NIC7dqI9YyHBLTxCCInTPwMHF6xnv1I7AbJ6TWm4DJtpUgERdP38dDTrlD0WOsxm2e8SI4NZHV0DXibA60ldisf2lTK00OZa/EfB9V9tzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FoRpVWRN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AKexsWnSH++iKlU+BchMFxWV0f36/dz0tcdVIEQsvg4=; b=FoRpVWRN0AyTJEZev+FVhNBVHj
	5/xsNYxf4HOCeqSHtbzissQs1dxF411e5l+8PmCZin9veDYrjVRHpTAHlnbb2yTXqtaCAZrb07tHN
	DaFy4wtE3ClyJFgWz4xOZW8DtXC86fzJ6s9IohxQH/wzHMOurDr29anPNX8D8R1b2NP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDNQ-00DjXv-Tj; Tue, 19 Nov 2024 02:50:00 +0100
Date: Tue, 19 Nov 2024 02:50:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 0/3] Add Aspeed G7 MDIO support
Message-ID: <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:32PM +0800, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three MDIO controllers.
> The design of AST2700 MDIO controller is the same as AST2600.

If they are identical, why do you need a new compatible?

	Andrew

