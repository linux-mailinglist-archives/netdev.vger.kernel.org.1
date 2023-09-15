Return-Path: <netdev+bounces-34084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05F7A2050
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF48282F9F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192E10A25;
	Fri, 15 Sep 2023 13:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4910954
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:58:54 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3E1FCE
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QvVRYtWOCyMDuzncQnkYEAfoirjzGGs2skJ72Y0JYro=; b=uQxf4rz0Q6q4sgnHDKl2jtTbnK
	hsYKYXGtz72u7tWy0W2KhSxEy+2Ihuek0I8ATLf1MwVULLqxcZ51PEv98sh5AbQdxHUpB2D0IA+Xs
	1wt4el7lJEfsrYkA2Vz0xWwU/l2PCOidRyyGqaGKhW5icXC67W5PLJBd/lp8cRSG4a4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh9LK-006Y3M-A3; Fri, 15 Sep 2023 15:58:46 +0200
Date: Fri, 15 Sep 2023 15:58:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, aelior@marvell.com,
	intel-wired-lan@lists.osuosl.org, manishc@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
Message-ID: <145ec8c7-ae64-42a2-ab7f-b77b1b0d23bf@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
 <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch>
 <ZPCQ5DNU8k8mfAct@baltimore>
 <87ea2635-c0b3-4de4-bc65-cbc33a0d5814@lunn.ch>
 <ZQMYUM3F/9v9cTQM@baltimore>
 <3713a4ff-c977-c62e-aa56-9293cf2cfd1f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3713a4ff-c977-c62e-aa56-9293cf2cfd1f@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Here I'd like to add that we're planning to try to use Phylink in ice
> soon. It may take a while and will most likely require core code
> expansion, since Phylink was originally developed for embedded HW and
> DeviceTree and doesn't fully support PCI devices.

Cool.

And yes, not having device tree will require some changes, but i don't
think it will require changes to the core of phylink, just the edges
where you instantiate phylink, using a different configuration
mechanism.

	Andrew

