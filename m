Return-Path: <netdev+bounces-35518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0907A9C1C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4607C1C213A4
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A342C00;
	Thu, 21 Sep 2023 18:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20393F4C3
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A8AF96C;
	Thu, 21 Sep 2023 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0Pf7QAqDNb+p8bWlfrIyHJVZ4jtnajPgptNvSy4IZPI=; b=g5
	gkpSG/9cOftC6F92ZPW42OexlxLwh7n353jEq11uPhN6yUs5OqKea93qAl2ERfGW/0mINvTnnHFNw
	K2W3YVYGZXE6BdfWyFwBnv7Ny6H9YqIU0zirZRCrbqbylTM9W73z7bNDbZfjWzmbCaoV+Qn/O4mgf
	KXrttycikFARIUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qjMdy-0076bl-CW; Thu, 21 Sep 2023 18:35:10 +0200
Date: Thu, 21 Sep 2023 18:35:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, vladimir.oltean@nxp.com,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <f54b6cd6-3f9f-4a4c-a14d-de2201f1e8b0@lunn.ch>
References: <20230921070031.795788-1-danishanwar@ti.com>
 <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 01:42:36PM +0300, Roger Quadros wrote:
> Hi Danish,
> 
> On 21/09/2023 10:00, MD Danish Anwar wrote:
> 
> Can you please retain patch authorhsip?
> 
> > ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
> > in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
> > configuration.

Does the switch version of the firmware support this?

     Andrew

