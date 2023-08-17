Return-Path: <netdev+bounces-28289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D677EE88
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C15D1C211EB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29669382;
	Thu, 17 Aug 2023 01:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FE379
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:08:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89FA19E;
	Wed, 16 Aug 2023 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ORBO1bgDwwLTGU2FQD05PvmXsHJhi0jAldTTQpGEgzk=; b=kzzL9qIYj3vwiOpab5xV3v2zOQ
	70bxdcMse0tMHvYi3pl1o48dQh8mrWo4aKhfKgEAtpfrXiR2mXFtyikn5pguXN6osBCE3Wy1bIYjk
	u7Lro3N0JELdQ7fYHjZpcjYSf0HucUVLTGVX5rPceWVbglzWNeS/DLEMHuQzkq4ObJfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWRUt-004KhJ-4s; Thu, 17 Aug 2023 03:08:23 +0200
Date: Thu, 17 Aug 2023 03:08:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nick.hawkins@hpe.com
Cc: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
	verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] ARM: Add GXP UMAC Support
Message-ID: <d37e1a1a-eea3-4151-b0a9-449049707b05@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Changes since v2:
>  *Removed PHY Configuration from MAC driver to Bootloader

By PHY, you mean PCS?

Can you still dynamically swap between 1000BaseX and SGMII?
Is there an interface to determine if the PCS has link?

Is the PHY code upstream in uboot and barebox? Can you detect when it
is missing because the vendor bootloader has been replaced, and report
useful error messages?

       Andrew

