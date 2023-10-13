Return-Path: <netdev+bounces-40752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4797C8960
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0341F2134D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B331C297;
	Fri, 13 Oct 2023 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LeitdU9u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FA1C288
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:00:34 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85263B7;
	Fri, 13 Oct 2023 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YJ2WmwaOdUeneIw/Q5PT7IiBFVxA19ldRBu/8pCiZi8=; b=LeitdU9uKWU/vjLbeLWfeyUChM
	UszrF5X7zGTSXEN5Txtu9dHjLRvvODPJqFRG+lWOqa5SXQzUamGNgZGspOCQV6N5uXiL2ekAnGD0P
	3WUGhLFOO0LqABXgBKeEIJ6p4V6KiDGJI+0M+Ea9WCnnidSXwNeKCC8tqitoRvPm6pL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrKaQ-0026mP-EM; Fri, 13 Oct 2023 18:00:26 +0200
Date: Fri, 13 Oct 2023 18:00:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Message-ID: <8b11140d-6d91-48aa-be66-9c4a117366af@lunn.ch>
References: <20231013111758.213769-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013111758.213769-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 04:47:58PM +0530, MD Danish Anwar wrote:
> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
> in the latest ICSSG firmware.
> 
> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
> EMAC_PORT_FORWARD commands do not work.
> Update r30 commands to use the same bitmask as used by the latest ICSSG
> firmware.

Please indicate in the commit message this is backwards compatible
with old firmware. I assume it is actually backwards compatible.

    Andrew

---
pw-bot: cr

