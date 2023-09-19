Return-Path: <netdev+bounces-34847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627767A5790
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 04:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8936A1C209DD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654F2AB23;
	Tue, 19 Sep 2023 02:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B4241F4;
	Tue, 19 Sep 2023 02:54:58 +0000 (UTC)
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EF95;
	Mon, 18 Sep 2023 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
	s=mail; t=1695092095;
	bh=HchvUGBBFEqF4PByO8v4Sq08CusQeF0JV4G/0/i5bpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qx7sGoh2RzGd/ateids9qPmYhBFFvUFAFpLaZMYwxPGsRpPTcgFd3jw5Xrg3fLWNS
	 SgF8hzVKti7EjgvQHabXAkdRKtayTekEWm4iPVkrc21VnlStCL9zULYmrI29Buia3f
	 dJk/aB7Q2obUJsPkN5uduBd0iSPZmJhdus9NRDV7pGuJ0ZkwF1eYrDb9zN2gb6jQlL
	 8WdXleFK9XOSBCa+TGJuVzEk1lRZsUYX91EGCGqCPp0WR2mkGs/AO2Gtqua5gntVfA
	 O2LFkHIVZTs0y0mxgywGV4JNKIFAfkrIQNQ4ElK4qP0+SrWWu81u1MIy2xBvsBOSP9
	 Ndwzv6Nudhzig==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by core.lopingdog.com (Postfix) with ESMTPSA id 446694402DB;
	Mon, 18 Sep 2023 21:54:54 -0500 (CDT)
Date: Mon, 18 Sep 2023 21:54:52 -0500
From: Jay Monkman <jtm@lopingdog.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>,
	Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH 4/4] net/onsemi: Add NCN26010 driver
Message-ID: <ZQkNfAOYgsBIhBRW@lopingdog.com>
References: <ZQf1QwNzK5jjOWk9@lopingdog.com>
 <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 06:00:37PM +0200, Andrew Lunn wrote:
> Is this an OA TC6 device?  At a quick look it does appear to
> be. Please make use of the framework Microchip is developing:
> 
> https://lore.kernel.org/netdev/20230908142919.14849-4-Parthiban.Veerasooran@microchip.com/T/

Yes it is. I wasn't aware of Microchip's work. Thanks for pointing it out.


