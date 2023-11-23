Return-Path: <netdev+bounces-50654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E007F679E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C631B281B4B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB214B5D5;
	Thu, 23 Nov 2023 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nZgN+Ft2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166902D70
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IYrW5tzzZqBDkAAah/91+IF+KwCorD+hhjYJ4ixZ7No=; b=nZgN+Ft2Rm3BOz40nkZOJ219xY
	IPWFuE6FeGrI+hM3K/om0lpMS8kpu4rs/RgaX9eRJTHdwIYv7h7UkxLBwputcLkynu87bjucnLhxC
	vTfVvWInqj10zk4313UP/pDEn8aDZjtlO4ZDKcshXUoxRhbXS/uKfkSZCMqNmOa6sQ5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6FTP-0011iI-69; Thu, 23 Nov 2023 20:34:51 +0100
Date: Thu, 23 Nov 2023 20:34:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@kernel.org>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
Message-ID: <4d9ac446-5a01-4c97-bc1d-41feb2359cad@lunn.ch>
References: <20231122131944.2180408-1-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122131944.2180408-1-gerg@kernel.org>

> The Marvell 88e6351 switch is a slightly improved version of the 6350,
> but is mostly identical. It will also need the dedicated 6350 function,
> so update its phylink_get_caps as well.

In chip.h we have:

        MV88E6XXX_FAMILY_6351,  /* 6171 6175 6350 6351 */

So please make the same change to the 6171 and 6175.

This otherwise looks O.K.

    Andrew

---
pw-bot: cr

