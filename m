Return-Path: <netdev+bounces-16611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD6474E007
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115FD1C20BCB
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3288156CA;
	Mon, 10 Jul 2023 21:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321A154BD
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:10:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60223BF
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wzX93DPdbi/I0ptc0WjychNbRRKS3el1Bp4+U5jJhkA=; b=MT6ig2M5gD1ILvK3L8+X20lblZ
	zewdnurKzFTPT8Wn8OtOu9TFXec7z0QrFdhMXv6nvThrF7kJZxPgUOH79yMS83RLweINjcNnfMz3O
	kfZBdG2NniZ3sKAemfQ0Gz+kTgjvv1zFYwJhBfVN9Ow8Dgfhc+LTHR/gd9f5jvm8NoU0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIy9B-000z8U-Vz; Mon, 10 Jul 2023 23:10:17 +0200
Date: Mon, 10 Jul 2023 23:10:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: add the link modes for
 1000BASE-T1 Ethernet PHY
Message-ID: <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710205900.52894-2-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:58:57PM +0200, Stefan Eichenberger wrote:
> This patch adds the link modes for the 1000BASE-T1 Ethernet PHYs. It
> supports 100BASE-T1/1000BASE-T1 in full duplex mode. So far I could not
> find a 1000BASE-T1 PHY that also supports 10BASE-T1, so this mode is not
> added.

Is this actually needed? Ideally you want to extend
genphy_c45_pma_read_abilities() to look in the PHY registers and
determine what the PHY can do. You should only use .features if it is
impossible to determine the PHY abilities by reading registers.

	   Andrew

