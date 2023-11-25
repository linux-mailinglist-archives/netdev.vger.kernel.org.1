Return-Path: <netdev+bounces-51049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291C7F8CB2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6531C20ADC
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2972C85A;
	Sat, 25 Nov 2023 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CYKSW+Y7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F79EE
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=L65KIYYSN1luJB5iPglsbw88Y/cQPIAk9HMA3prrUZk=; b=CY
	KSW+Y7emv1X6/mnmL9HkDjP3BoaUbyK4zUZ36iDlew/qoIPU4p7SK8VFzEBQLf4XqF28MLFSqfhwV
	hFgd8DQy0Fvapan/lrF4rAT1Z9GepQcYk3/rlj7IAQi/Vg3jym1whskHdQURcB9j9GamJmcpjtNGd
	E3jhlkiA3srOVSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wLS-001CUV-Mm; Sat, 25 Nov 2023 18:21:30 +0100
Date: Sat, 25 Nov 2023 18:21:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: sfp: rework the RollBall PHY waiting code
Message-ID: <a709db23-1b11-4818-babb-6e6dd74ae04d@lunn.ch>
References: <20231121172024.19901-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121172024.19901-1-kabel@kernel.org>

On Tue, Nov 21, 2023 at 06:20:24PM +0100, Marek Behún wrote:
> RollBall SFP modules allow the access to PHY registers only after a
> certain time has passed. Until then, the registers read 0xffff.
> 
> Currently we have quirks for modules where we need to wait either 25
> seconds or 4 seconds, but recently I got hands on another module where
> the wait is even shorter.
> 
> Instead of hardcoding different wait times, lets rework the code:
> - increase the PHY retry count to 25
> - when RollBall module is detected, increase the PHY retry time from
>   50ms to 1s
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

