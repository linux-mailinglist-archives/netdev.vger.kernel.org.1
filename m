Return-Path: <netdev+bounces-15154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE38745FA8
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CCA280DD9
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668BD100AA;
	Mon,  3 Jul 2023 15:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BC100A3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:18:08 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C33FD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:18:06 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 57B79212CC;
	Mon,  3 Jul 2023 17:18:02 +0200 (CEST)
Date: Mon, 3 Jul 2023 17:17:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, francesco.dolcini@toradex.com
Subject: Re: [PATCH v1 2/2] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2110 PHY
Message-ID: <ZKLmpl6GqTN/0ia1@francesco-nb.int.toradex.com>
References: <20230703124440.391970-1-eichest@gmail.com>
 <20230703124440.391970-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703124440.391970-3-eichest@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 02:44:40PM +0200, Stefan Eichenberger wrote:
> Add a driver for the Marvell 88Q2110. This driver is minimalistic, but
> already allows to detect the link, switch between 100BASE-T1 and
> 1000BASE-T1 and switch between master and slave mode. Autonegotiation
> supported by the PHY is not yet implemented.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

...

> +static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
> +	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
> +	{ /*sentinel*/ },
No comma for a terminator entry.

Francesco


