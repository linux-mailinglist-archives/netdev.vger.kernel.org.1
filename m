Return-Path: <netdev+bounces-31658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54978F6C4
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E8D1C20B05
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2710FA;
	Fri,  1 Sep 2023 01:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64C10E3
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58501C433C7;
	Fri,  1 Sep 2023 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693531988;
	bh=nmrHaG018wY/DNDHLlevsfQP0j2tRtJhM5Z3Cv69FT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UINJE8aYcs0nJ/rjjyxH4COFqtI/x3ioS7j4J+aucywC2O6X9H/hhu4YVFCy76WVE
	 UVTBOy8ZrEkeAxMrbNK7VdPMvzRi9/0bylrlVMKM/bNgcEe+jQMre3Kub7XmSaCeOh
	 X1Qu5oNj/Z5IUjsKlzcHSOf8+EocYvhiu26QhOi6bCTQGKYYAvRVE6WUxK/9l+Yfo4
	 chlRXut28PpKNmrV9243b38J0Cb94UxFnhROuXx3g1HpVh6vmawsFLdfSYRruVIr8+
	 amn7hnIpzy+Q43sSbh6KVMH1AVhyFvOwc6Lm6JuHbb2U/bDSpI4Oh0clGEWRYAeE84
	 RdsBvFWvoW+SA==
Date: Thu, 31 Aug 2023 18:33:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1] net: phy: micrel: Correct bit assignment for
 MICREL_KSZ8_P1_ERRATA flag
Message-ID: <20230831183307.6145542e@kernel.org>
In-Reply-To: <20230831112342.GD17603@pengutronix.de>
References: <20230831110427.3551432-1-o.rempel@pengutronix.de>
	<ZPB3cYMnFq1qGRv0@shell.armlinux.org.uk>
	<20230831112342.GD17603@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Aug 2023 13:23:42 +0200 Oleksij Rempel wrote:
> > >  /* struct phy_device dev_flags definitions */
> > >  #define MICREL_PHY_50MHZ_CLK	0x00000001
> > >  #define MICREL_PHY_FXEN		0x00000002
> > > -#define MICREL_KSZ8_P1_ERRATA	0x00000003
> > > +#define MICREL_KSZ8_P1_ERRATA	BIT(3)  
> > 
> > Please can you also convert the other two flags to use BIT() as well to
> > make the entire thing explicitly bit-orientated? Thanks.  
> 
> Ack. This patch is for the net. The cleanup will got to the net-next.
> Except clean up will be accepted for the net too?

The change is simple enough, you can convert all three bits in the fix.
The commit message could more explicitly say that these defines are
supposed to be masks not bit positions, tho.

