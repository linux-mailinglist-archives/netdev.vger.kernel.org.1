Return-Path: <netdev+bounces-90145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A218ACDEC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF1284293
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DF14F123;
	Mon, 22 Apr 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iaeG34/B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AD14658A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791579; cv=none; b=qmqJ4CzCeR1vJP+fkUEhFtD9Tqsz/xMuRda0FsN8EfkyiEOjAAYoAY2EFZFF0HmtivtyIdszV4kXlSDxbOFimoYe0dH1iHzBugxNy0EbcbwkXu2eFoxlaikd8VaSXIDr1AFmycX/CrYY7MpC6PPqA0lO1dWWUEjUbFS//YayI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791579; c=relaxed/simple;
	bh=7Th6jpk5aqSC6dBRXOwcObhu3Sl2iC28B6SAo0gBYE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeRg8hSjc2A14v1cKN/lf8JuXfMh/IKtZNzQTZJ2z5rUzc441zn5QKEYkz44EZaRK+a0lcCcXkWX2z9YFL3rKaBiXjoiU+EW+q0VBglBE8jSknd8yJaRBtit7FzrLRXPLSP7OIGdesxokN+D9qCLoOq5QqDNL+wPgLvPVBTHr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iaeG34/B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qtHRFvl89JvL1VkMkuSsXHtXNT5MbEuBWsWE6zwIe70=; b=iaeG34/BIjOtWn6rcPUoP4fJ5y
	ws2g1/rJHPZWQ0Vg1SrbOpYVIjYbQLwRioqoihv8HOQlvZuhFEMCG/Bu6TkEnX9RvY17JAUegy3mN
	JtjjdgjTqpNHKnH7Uxg1Lr0pC74sDEfIV7i0AMhuJ/X2pUaFjepNQINyD3BOXFPGJmZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytTb-00DcOM-DZ; Mon, 22 Apr 2024 15:12:55 +0200
Date: Mon, 22 Apr 2024 15:12:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Simon Horman <simon.horman@corigine.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore 2.5G
 copper SFP module
Message-ID: <4e07c66a-fd5d-4640-8a26-c64426aa3c7e@lunn.ch>
References: <20240422094435.25913-1-kabel@kernel.org>
 <20240422094435.25913-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422094435.25913-2-kabel@kernel.org>

> The PHY inside the module is Realtek RTL8221B-VB-CG PHY, for which
> the realtek driver we only recently gained support to set it up via
> clause 45 accesses.

This sentence does not parse very well.

The PHY inside the module is a Realtek RTL8221B-VB-CG. The realtek
driver recently gained support to set it up via clause 45 accesses.

???


    Andrew

---
pw-bot: cr

