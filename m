Return-Path: <netdev+bounces-12295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52273705E
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8582C1C20C39
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82563174D5;
	Tue, 20 Jun 2023 15:23:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B07168CA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:23:10 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CEC0
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=USzcBA4mSMQ6xvmpeApRsuzGtvNKiVE7VkyiINFJ6oQ=; b=HmvPj9wx7tBw5ptVstrPB9KJdF
	DuIiv+1pdHL5XzroepwQyAtbw4OwFYom88Pk6HqibCRrDd9TBW5bxf7U/vPVaxb5Q6pk5mN17Ggrx
	H4vhc3gAjbPALs27tj3M7GeHjJr315Gzs0nJfupaUKctI4bEyDM6Ef450cQJFS6RiJKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBdC2-00H1Ku-S1; Tue, 20 Jun 2023 17:22:54 +0200
Date: Tue, 20 Jun 2023 17:22:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH] net: fec: allow to build without PAGE_POOL_STATS
Message-ID: <7e10f2f9-a3a9-4615-b329-1d0aeebec5e2@lunn.ch>
References: <20230616191832.2944130-1-l.stach@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616191832.2944130-1-l.stach@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 09:18:32PM +0200, Lucas Stach wrote:
> Commit 6970ef27ff7f ("net: fec: add xdp and page pool statistics") selected
> CONFIG_PAGE_POOL_STATS from the FEC driver symbol, making it impossible
> to build without the page pool statistics when this driver is enabled. The
> help text of those statistics mentions increased overhead. Allow the user
> to choose between usefulness of the statistics and the added overhead.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

I don't think it does any harm, even if the saving is minimal. And
0-day has not yet reported any build errors.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

