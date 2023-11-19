Return-Path: <netdev+bounces-49036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694B7F076A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219B51F21A90
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FD4C60;
	Sun, 19 Nov 2023 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f0wyT6U7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA4F9
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xPOxEf+NZ24lKgdIU2RmKY0Md/5YZZjsaANCVnQCO4o=; b=f0wyT6U7p78DnnZFsltB0nllVG
	aC3nL2wxWa+UH6DSLqnTFbXFi5Sm8iDhik9lozv4hha9NdSbCjjIL2lW7hpe514tyeNx0j4brgzfT
	v6KCVu2EqC6Vd91ST78IHZnlWD/83zt8SFj5EmWcIm777APICj1qO7/yRGmGv4JkZ8Mc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4kVV-000ZVy-8A; Sun, 19 Nov 2023 17:18:49 +0100
Date: Sun, 19 Nov 2023 17:18:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: HeinerKallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S.Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC] support built-in ethernet phy which needs some mmio
 accesses
Message-ID: <b8c29d27-e0a2-4378-ba5f-6d95a438c023@lunn.ch>
References: <ZVoUPW8pJmv5AT10@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVoUPW8pJmv5AT10@xhacker>

On Sun, Nov 19, 2023 at 09:57:17PM +0800, Jisheng Zhang wrote:
> Hi,
> 
> I want to upstream milkv duo (powered by cv1800b) ethernet support. The SoC
> contains a built-in eth phy which also needs some initialization via.
> mmio access during init. So, I need to do something like this(sol A):

What does this initialisation do?

If you are turning on clocks, write a common clock provider, which the
PHY driver can use. If its a reset, write a reset driver. If its a
regulator, write a regulator driver, etc.

      Andrew

