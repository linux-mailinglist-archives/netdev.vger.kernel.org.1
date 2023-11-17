Return-Path: <netdev+bounces-48739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992CE7EF63B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B6B1C2091F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD7171BB;
	Fri, 17 Nov 2023 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rudieRb3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B3194
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UCXRbX+OXCE59D45Xv2GBtYV5gJGwwus/nT5//dT6So=; b=rudieRb38uM4k2OlPACPBGlGO7
	qrW/EUqEYLpEwR700k2rEhojSKtrfwuie9BsA58qBOc1OlPpI5Y5LyDD8+JqXEPzpr+CSu1T6h30X
	oYV4xKmDukDnAz4PW8V5T5NiME40g3R0EbqqXRPJvZZbHt4DtTN11KXz2No43gG07bNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r41jt-000SNP-RD; Fri, 17 Nov 2023 17:30:41 +0100
Date: Fri, 17 Nov 2023 17:30:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: use for_each_set_bit()
Message-ID: <07171a9c-ef9c-4dcd-a977-61a7a068dfc6@lunn.ch>
References: <E1r3yPo-00CnKQ-JG@rmk-PC.armlinux.org.uk>
 <84b4b1b4-83e7-477b-9316-21c7a76689aa@lunn.ch>
 <ZVeSEv2nN1xioYz5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVeSEv2nN1xioYz5@shell.armlinux.org.uk>

> Hmm, indeed, thanks for spotting. I always forget whether I'll need to
> send a v2 for something this trivial or whether netdev folk will fix
> it up when committing it. I'm happy to resend.

You should resend. netdev patch acceptance is pretty bot driven, with
the normal 'fast path' not allowing the patch to be edited by the
merger.

	Andrew

