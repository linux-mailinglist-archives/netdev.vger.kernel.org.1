Return-Path: <netdev+bounces-193762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891BAC5C6B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7AF1701B2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113D214A64;
	Tue, 27 May 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G88J1JyN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1F211A3F;
	Tue, 27 May 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382493; cv=none; b=LJ/TYDQttqokfaqw+JCUUhXIQajA3Llum9Xl0GnkVlOV4x0aTY9XHLX6Kf6XWQyc+NywIT0lZSvKdvN0P4ZgaJdw5hZlmWSH4uAMR7+7HNvwN6CIEoa6+hOzMpLCVxVO5QwkFaDB+uiV5b2W5mBjL0ugL2AXdNkTTiSRs5BomMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382493; c=relaxed/simple;
	bh=Q8QydlWvLOycl8oxn2MATnHseBCSeQkXcao3rUZbNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlQNfBDu8EOORH/5xUQKprZo2WJK24pwi0KGAY1TM9lOh3thAyxEbVB5TZSMli+m8Ip8RECoIrNATZZcN+sFi4PBLBM/KTYIhABXkw6FX4cuZkYHOHeYKba5vMAPVtQwOaQtzVUdyvl/ROWB7FROpP9wIFOGdnNDDBJMddOLwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G88J1JyN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Yo5i6Cfp507HWKu8x8QsupHsb5V8DAsofc1dKd1g6JU=; b=G8
	8J1JyNZI1h77yRUT+EqGtVaguMkpS9J7EEusMtT2VRNZY8u+RhYP/vtnUNsA1CKnMk7ooz/nriaji
	nCera2wrUOrrpjnS0rXf8vk8P3KxQ0XblNMMvzlOIpwyB9Qm3Nwc8h4FL7a8FUCPS889BGfiVlKJu
	bgfVxfJiLPHa2gU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK29V-00E70R-Kg; Tue, 27 May 2025 23:48:05 +0200
Date: Tue, 27 May 2025 23:48:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <93bfec74-c679-400f-8ce4-3bc84d6d803f@lunn.ch>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
 <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
 <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
 <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>

On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> On Tue, May 27, 2025 at 2:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Sure, that may make sense to do as well, but I still don't see
> > > how that impacts the need to runtime select the PHY which
> > > is configured for the correct MFD.
> >
> > If you know what variant you have, you only include the one PHY you
> > actually have, and phy-handle points to it, just as normal. No runtime
> > selection.
> 
> Oh, so here's the issue, we have both PHY variants, older hardware
> generally has AC200 PHY's while newer ships AC300 PHY's, but
> when I surveyed our deployed hardware using these boards many
> systems of similar age would randomly mix AC200 and AC300 PHY's.

Are they pin compatible?

But i assume none of these boards .dts files are actually in mainline?
So they need to go through review, and are likely to be horribly
broken and need fixing? So you can fix up the PHY node as part of the
cleanup.

	Andrew

