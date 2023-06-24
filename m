Return-Path: <netdev+bounces-13736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B473CC99
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 21:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDE51C20973
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A879E4;
	Sat, 24 Jun 2023 19:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709B7486
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 19:33:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F88E113;
	Sat, 24 Jun 2023 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XzCdTix0xRKxmSkEQFnNFoYSsIEO5imla3RxHxrM7iM=; b=AuZuuPeW42aaz6LP8e0Ysanbs8
	iX1n0kYyDzzKmHmYQMSgoDL2QTj/Z+40IJ+cJq8l8AOM5saJMlOs7rOHSdb4ZSHpHYq5M8LND0tJi
	7dNHxFrgNYr1iYZN22Kc7k9z75ejwRGK8767vyvbgKPnBGl1Z5SKytC9Cm8NTryV4CtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qD90J-00HRdD-7w; Sat, 24 Jun 2023 21:33:03 +0200
Date: Sat, 24 Jun 2023 21:33:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH v2 13/13] net: phy: nxp-c45-tja11xx: reset PCS if the
 link goes down
Message-ID: <0c2033a2-beb9-47ce-92f6-3c700e7980fc@lunn.ch>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
 <20230623074123.152931-14-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623074123.152931-14-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 10:41:23AM +0300, Radu Pirea (NXP OSS) wrote:
> During PTP testing on early TJA1120 engineering samples I observed that
> if the link is lost and recovered, the tx timestamps will be randomly
> lost. To avoid this HW issue, the PCS should be reseted.
> 
> Resetting the PCS will break the link and we should reset the PCS on
> LINK UP -> LINK DOWN transition, otherwise we will trigger and infinite
> loop of LINK UP -> LINK DOWN events.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

