Return-Path: <netdev+bounces-31845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA0790C55
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF652280F37
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D42593;
	Sun,  3 Sep 2023 14:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57162572
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 14:01:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2647B6
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FRmvoZb9t6APhYJBtCKJrCvXQcrJ9in/X9+fCHbnW6w=; b=3tXvc7/7TjDjVhrzlFQFzrSQsj
	JHAXRK4NsORbzL6xAJaeJNyoBDCf+z0+YTgjpDlDVQ/chI3DRuJ6Bf9wy3B2c8co3iH4DZ+I9Yiei
	hjSddfw8kLk+SJ0tMAjjDaM4q1sxAiLmkdTslvP3dxZ79BOPctPlQ2WOarayMQHmtpaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qcner-005gdi-GE; Sun, 03 Sep 2023 16:00:57 +0200
Date: Sun, 3 Sep 2023 16:00:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, aelior@marvell.com,
	intel-wired-lan@lists.osuosl.org, manishc@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
Message-ID: <87ea2635-c0b3-4de4-bc65-cbc33a0d5814@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
 <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch>
 <ZPCQ5DNU8k8mfAct@baltimore>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPCQ5DNU8k8mfAct@baltimore>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Let me check if I understand correctly- is that what was sent with the
> v3 [1] , with the initialization helper (ethtool_forced_speed_maps_init)
> and the structure map in the ethtool code? Or do you have another helper
> in mind?

Sorry for the late reply, been on vacation.

The main thing is you try to reuse the table:

static const struct phy_setting settings[] = {}

If you can build your helper on top of phy_lookup_setting() even
better. You don't need a phy_device to use those.

	Andrew

