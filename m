Return-Path: <netdev+bounces-216511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F4B34310
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A43D3AF1EE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23FA2FA0FB;
	Mon, 25 Aug 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xg2ZjGzm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E272FABF7;
	Mon, 25 Aug 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131424; cv=none; b=X6bzjEV+6Kyd3mhrljnLoR5yfLfFRbu8LkeNxWx+isdqDuBzTD/WC79uAE5wjYwlIypbNtxe9Sq1NUkdf04NIvynT+pP6MxE9acIfP3QcHGOfVmlKo8xeW3UTl8M0u+0Rccf+zTMVu0iZm9cMOm1oLxJfosfSyawZgC9x9LVZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131424; c=relaxed/simple;
	bh=O3t5JOzXi+sdrXxjqmg9uDhVBC+lpj4SoDnPKJctIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKrmIOBJ52BQkqCIzybJb0c5Hctq23FIS9pxtyVIPu99y2FJpCh3AyUJvsNMiuML5BxOsKODuhXxVf015RY4T9x6FZkLDUjwaiCyPh/nBWJc5lfL0S5XjJsoZe6PQYMO6/sg4XeT7gJuxldRe05pIDiCCFawGD/higN/nA1V/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xg2ZjGzm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ydZFNKQ4o6k7G6/FeIQ641mcBswh13KPhBDwWcViGko=; b=Xg2ZjGzmqJtD4KXUzRQ9aB718O
	A9Ywwl1AUuYP3rJWd2R5HCmouttcL/NnBu3tq4nj0Gh/YI4tFYElNWUSTxDI8NTZA9yF3teSgXQpT
	ZGfoGlFJCj4hLtQuvK9N9i8FG7XI35ESVr8jFQd0leZuDXIRTWFgSZktFOdNMcb36Gzca+TQjuO6O
	yQdGjCdTPzp+ujShHZJifOJqmoREPYV6/cG3tLFcyBS58EdKGVCSWIN5geRCygWh4kHCSgyRyf6kU
	Ej9ZTH8sxh+0Z9XX+xuDdiC7NA2L2X3IIbDlr/OnsnBnjwhhVeIHK0mIvkHxJ9QByjp1CJYFRer3k
	+htsoWdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqY0E-000000006cP-1hjr;
	Mon, 25 Aug 2025 15:16:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqY0C-000000008ED-2egY;
	Mon, 25 Aug 2025 15:16:52 +0100
Date: Mon, 25 Aug 2025 15:16:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdiobus: Move all reset registration to
 `mdiobus_register_reset()`
Message-ID: <aKxwVNffu9w8Mepl@shell.armlinux.org.uk>
References: <20250825-b4-phy-rst-mv-prep-v1-1-6298349df7ca@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825-b4-phy-rst-mv-prep-v1-1-6298349df7ca@prolan.hu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 25, 2025 at 04:09:34PM +0200, Bence Csókás wrote:
> Make `mdiobus_register_reset()` function handle both gpiod and
> reset-controller-based reset registration.

The commit description should include not only _what_ is being done but
also _why_.

Here's from Documentation/process/submitting-patches.rst:

 Describe your problem.  Whether your patch is a one-line bug fix or
 5000 lines of a new feature, there must be an underlying problem that
 motivated you to do this work.  Convince the reviewer that there is a
 problem worth fixing and that it makes sense for them to read past the
 first paragraph.

Just describing _what_ is being done doesn't do anything to convince
a reviewer that the patch is worth applying.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

