Return-Path: <netdev+bounces-12399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5073750C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FED281411
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1817AD3;
	Tue, 20 Jun 2023 19:28:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142C17AB5
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:28:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1BB1B6;
	Tue, 20 Jun 2023 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wv2H4gRrgWftVHyvUxA7jfonUlGoWajnFkHFHQqMGlc=; b=W9QCZLRUqgLqFaY900qUZFRgLP
	G/2cXlQYYil53FWS3q0TzUiY+0ZvU9vnZw2Vh1uxkjKrNWdr8i+AqwxMToRZOO6cu4xgOc1Tijuct
	n8oYO3S+IhZ2mdmu+bOahI/CF7uftZG56SlHZpnGI+GQkKlSdz9sEMmjUcnxdhGY6xz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBh1Z-00H3Cq-HA; Tue, 20 Jun 2023 21:28:21 +0200
Date: Tue, 20 Jun 2023 21:28:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: microchip: fix writes to phy
 registers >= 0x10
Message-ID: <88474092-70cb-40fc-9c01-1fc8527d5bcb@lunn.ch>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
 <20230620113855.733526-4-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113855.733526-4-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 01:38:54PM +0200, Rasmus Villemoes wrote:
> According to the errata sheets for ksz9477 and ksz9567, writes to the
> PHY registers 0x10-0x1f (i.e. those located at addresses 0xN120 to
> 0xN13f) must be done as a 32 bit write to the 4-byte aligned address
> containing the register, hence requires a RMW in order not to change
> the adjacent PHY register.

ASIC engineers do see to come up with novel ways to break things.

I assume you have not seen real problems with this, which is why it is
not for net and a Fixes: tag?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

