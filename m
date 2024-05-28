Return-Path: <netdev+bounces-98526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7688D1ABB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F147AB25BD9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102A16C87F;
	Tue, 28 May 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kzmxndAd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263171753
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898210; cv=none; b=Fg5xgR1BuPCXG0tUk6yuSCX0bGYaqBnTQV6Txi7spYfGMfsB7m6VI4wXcoyikoaCtYnzvO1+8O5QoXXWjDDz9U0dkRkndu+RzMbkebmx88nvdZDuHCbqHvy4GIaWDW2JYqq0opUBqHRWCwy2V+Nkq5p5cU22YMvpBpmRkfstzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898210; c=relaxed/simple;
	bh=yazDqYywSmFjQDc2J+pSUe30adxyZ2bPDMMc8mgGPFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjF40kd79YHZbc9Ap1yq9jEzmy6EIqSvThT+BxrJccGtEkoPKoOTB+8JbRV3FSKRM4wsgGZJRPkbRyPzNOaLSdxkaHRFmS5MQpNyEpIMPw8HisEcmI7HPkuukRSFLVG8Nhc/NOFVhq1HBytqJVwkY1AflPgr/QKh97DTNkyeB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kzmxndAd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zPoRzvXoaJMm8mmXYtcnAi8qnnv0U5IHizCY59Fi8sc=; b=kzmxndAdO838L8kwxr5/u7qJKi
	vHg0TD9RY57m5aYbIEUnDPz6qaidrFgWdWbaBcdbga77ooFCXy3b4BVPszBzh67IdK2FKTr3ndjxK
	a8nHFve8Yt6sb6VHp9OUsSsAgF1s0dHBXQdvo/82Kd5rYlKzd057r/C0wNJnccUX3jAI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBveY-00G9Nf-Bw; Tue, 28 May 2024 14:10:06 +0200
Date: Tue, 28 May 2024 14:10:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: imply SMSC_PHY
Message-ID: <3fd1b0f0-01ed-4df6-9efe-11977f7cc23f@lunn.ch>
References: <20240528073147.3604083-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528073147.3604083-1-alexander.sverdlin@siemens.com>

On Tue, May 28, 2024 at 09:31:13AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Both LAN9303 and LAN9354 have internal PHYs on both external ports.
> Therefore a configuration without SMSC PHY support is non-practical at
> least and leads to:
> 
> LAN9303_MDIO 8000f00.mdio:00: Found LAN9303 rev. 1
> mdio_bus 8000f00.mdio:00: deferred probe pending: (reason unknown)
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

