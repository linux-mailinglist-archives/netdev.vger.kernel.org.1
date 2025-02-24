Return-Path: <netdev+bounces-169014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB66A42052
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7761F164795
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE91B041E;
	Mon, 24 Feb 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SI8tpfzg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003E158D96
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403103; cv=none; b=PPJKasg5yF5qAzHNirr2rMN3pmnFe8YGY1WG6y8cKMYEuTiE1M53LM6tj/IdonXVQjwNEOw7U0TR/3Fo+b1fCE1GAS1mSBINzbt+MUAOYBLUlNdDlhXnIBTYW0B35jC91B0dQTuYBflcnJUakGrp/D5q1tm7vYXbnc+dnXxxib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403103; c=relaxed/simple;
	bh=CtE4kOp+CRbRH340BnBBUxRvSan+7x+GqmL3ATG0zSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzgLO7p/zabAAIBAUJqOJNcgSa8N7OM/zqvhook7UiRxp5HW+8XO6ng7nadwYJ90Wiakrxj5x+e16ZYwvrImzXWAzQ3h0HfzhMY3rd8oWKpRDUxCgeXsjFFQhWNkSHiAQW9b6yw8k6wCv3IQdcNVUQEbpd2OCB54tI1/BwzsoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SI8tpfzg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ku7Js3X5Nj95xO2vzKklKiqsoYh4kNw12uKQOjV+q3c=; b=SI
	8tpfzgG2lcxqH5vIqbpZ3wEzPvTEFWS/0KpAuGNyanHf2xhCkUkSf93dThPpoAZJd5xVQoQTP6sNC
	ZjVGo0yEKNQIQua5qIPGbVHIfADJ96aE9musUNy4z65jTB6JMyw05+Emd/CJSTAS81ddGdcgpiWY6
	wH/llo3TV1S2ywg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmYLh-00HALP-A3; Mon, 24 Feb 2025 14:18:17 +0100
Date: Mon, 24 Feb 2025 14:18:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org
Subject: Re: Phy access methods for copper SFP+ disguised as SR
Message-ID: <eb92da6a-b614-4deb-9321-df5a57ed987d@lunn.ch>
References: <874j0kvqs3.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874j0kvqs3.fsf@miraculix.mork.no>

On Sun, Feb 23, 2025 at 12:34:04PM +0100, Bjørn Mork wrote:
> Got myself a couple of cheap 10GBase-T SFP+s and am struggling to figure
> out how to talk to the phy.  The phy does not appear to be directly
> accessible on 0x56, and it does not respond using the Rollball protocol
> either.
> 
> Are there any other well known methods out there, or am I stuck with
> whatever SR emulation the SFP vendor implemented?

Those are the two i know of. The problem is, copper SFP modules are
not part of any standard, so manufactures are free to do whatever they
want.

For 1G, the Marvell 88e1111 is often used, since it has a built in i2c
device. For 10G the Marvell 88X3310 is often used, but that does not
have i2c, as far as i know, and there is a small microprocessor which
implements the Rollball protocol, talking MDIO to the PHY. Since it is
not build into the PHY the MCU could well be talking a different
protocol.

	Andrew

