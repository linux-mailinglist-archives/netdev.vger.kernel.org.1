Return-Path: <netdev+bounces-36025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A07ACA2D
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CD1701C2040C
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7CD27B;
	Sun, 24 Sep 2023 15:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6ECA70
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:03:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31759FD;
	Sun, 24 Sep 2023 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ISXHFZfy7wb5XDVZZ1sXGvbmcOHYJDZzw7ueOHnl5tI=; b=D4xVKH3bSACGIP4XTgGsJfMkXn
	xpYRdBSEFMwNP7PenQnViz5mOa8eFoZZ8qBgjbIj7Yjx92pt69nY4z2Sz0VSjbJ0HY/XjuN2XF3Jx
	85MDFRpnBr5x2UTanZbiSqSglYFulF6ub2Eb4g8VBWIE1wJsL5xjYDZcQTRg2gk9phjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qkQdO-007M6X-Ap; Sun, 24 Sep 2023 17:02:58 +0200
Date: Sun, 24 Sep 2023 17:02:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: amd: Support the Altima AMI101L
Message-ID: <c58a7ba6-d899-4a23-abce-973a55a70a71@lunn.ch>
References: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 10:19:02AM +0200, Linus Walleij wrote:
> The Altima AC101L is obviously compatible with the AMD PHY,
> as seen by reading the datasheet.
> 
> Datasheet: https://docs.broadcom.com/doc/AC101L-DS05-405-RDS.pdf
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks to even have the same OUI in the ID registers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

