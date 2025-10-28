Return-Path: <netdev+bounces-233517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05EC14B97
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6A11B23704
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC732ABCC;
	Tue, 28 Oct 2025 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="REpZddWG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861730F536
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656243; cv=none; b=ATHztir1RYNt98rC2m8biHanTxoBlzx3TrXfUYxbIk5NnrgLm9McbBSjx3uwjzUb3p5eEBC3swwI75lxnxeONnovETNUeHkW1QOL6dPwLEmXTEgkgmoAaiG4hGphO6FRojUbO758xbZuAFB7I0mza0tqhLG1xZ/970LZSIbrRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656243; c=relaxed/simple;
	bh=BZlvQ5adigxbCIOZC8ENgkSkD2oFCh2Hrb2JoDFLDAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFTPKOeHviRZl/gh1CWKrNoPXSulq1srROoHoAC5WT3TVeqbJlpgAOmdvT5NJobmBXdM7oIqPEJ5OTEsJHLonlayTIb/uyD/ECZcUx9M9VbUxC5+iHxuJvtT1Kyfjabu2xA6bHCoNONPnu5c/JbZPpuyaYtW/NekS7OZPyG1gVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=REpZddWG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3UjlmCdFD7aPWW1NJHa4UYv4qhXN283+wsfv+4LoR8I=; b=REpZddWGlet/Q2zb5zISgYINyN
	e7/JlEaKUwTzgS+m5K2j/6zyF5oXovcy7dx4Xuu+iZoALTHRYp6m/S6Etme/eLjmyEsKm+T72v7EF
	zHUtbnvGfP6SWgoakLRmknaxRlujIf2mNrHjbLtnDkLqkvWJb4GxcCH/yRCAD71hzOIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDjGJ-00CIPH-Cf; Tue, 28 Oct 2025 13:57:19 +0100
Date: Tue, 28 Oct 2025 13:57:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
Message-ID: <59f1c869-58c0-4158-82d7-e7b11870b790@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>

On Fri, Oct 24, 2025 at 01:40:53PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. Note
> that 3 of the 4 are IEEE compliant so they are a direct copy from the
> clause 45 specification, the only exception to this is 50G-CR2 which is
> part of the Ethernet Consortium specification which never referenced how to
> handle this in the MDIO registers.

Does the Ethernet Consortium have other media types which are not in
802.3? Does your scheme work for all of them?

	Andrew

