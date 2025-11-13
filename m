Return-Path: <netdev+bounces-238296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D4C571ED
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0BD63436A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2502DF71D;
	Thu, 13 Nov 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y742DFPU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5424335BC1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032294; cv=none; b=QYHmcM0+/WLvpmFGh+HTXQPBPLbWsw4bQP9OuTwMVwTFqEsCMrG7aosLJtJJCh88Vx6hfA4eOeJcXjBN7MN/7WvPG1aTs4fm8qS4ahFyLrS/fo9VYFGBhkuhwf9LMFtKllogBiD2pQMUAhe79R6LOVAbcLrb6UL4cM4idO3l2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032294; c=relaxed/simple;
	bh=OPicjN8qu+hvR6aCIzhEw7I+0bY8tCVqFQeoa5f2gCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gjgu8U1854lB25Co0528M0rVahdNVxjMfJeAjhQ7TqqQUVfZ1YZpxdcC9dkFDF72zOMFZS+iIEK9lOh6KGTDt2p1LETcRx/my6YqXRS1er1JBHBISS6xG6EgOYPXv/IeFnAdqjl094yPzrAaCMD2GayBHcEEKse/P0FqTMoKkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y742DFPU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0B98C4E41682;
	Thu, 13 Nov 2025 11:11:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCB7C6068C;
	Thu, 13 Nov 2025 11:11:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68623102F230B;
	Thu, 13 Nov 2025 12:11:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763032273; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LOJb35hgkf2c9HwiLF/R5/wo9jrGPEQtQfpQyRGK1QM=;
	b=y742DFPUBjB5daLlQ2ZQc+jNpE3X30+XaV+cmyOLcC8tWAUeb3RmwzR6ZL0iCULPwYKklb
	bagCYbfP2QWcPOkBSoO/RyyZqIiJ3H5Qbs14eCVYgP91QvPkbWU4n+x4qV2nyeERwEM3KL
	kqN/DHbmSElfIUGcQ6G8Ryp6XQcbM2G14lp4jmT6IyBLSjFk2mWr8nMJ7tYm3zJpzplSkR
	1RlQ/+FMH9ApqR6Se6FIqEdyQAxfeBndj+dIxGJlzpG4QbaPMPNoL+t87y197LDFqohSop
	MS+z6tZGUDE+SEqfipv7bBqb3R/MT9BGA8b+LCFa6PDBJEPNe80n/HwU4cjgKA==
Message-ID: <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
Date: Thu, 13 Nov 2025 12:11:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool: advance phy debug support
To: Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
 mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
 Andrew Lunn <andrew@lunn.ch>, Lee Trager <lee@trager.us>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 13/11/2025 06:12, Susheela Doddagoudar wrote:
> Hi All/ Michal Kubecek,
> 
> To support Advanced PHY Debug operations like
> PRBS pattern tests,  EHM tests, TX_EQ settings, Various PHY loopback etc.....

Added a bunch of people in CC:

I don't have feedback on your current proposition, however people have
showed interest in what you mention, it may be a good idea to get everyone
in the loop.

For the Loopback you're mentionning, there's this effort here [1] that
Hariprasad is working on, it may be a good idea to sync the effort :)

[1] : https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/

As for the PRBS, there was a discussion on this at the last Netdevconf,
see the slides and talk here [2], I've added Lee in CC but I don't
really know what's the state of that work.

[2] : https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html

Maxime


> proposing a solution by custom ethtool extension implementation.
> 
> By enhancing below ethtool options
> 1.ethtool --phy-statistics
> 2.ethtool --set-phy-tunable
> 3.ethtool --get-phy-tunable
> 
> Currently standard ethtool supports 3 parameters configuration with phy-tunables
> that are defined in "include/uapi/linux/ethtool.h".
> --------
> enum phy_tunable_id {
>         ETHTOOL_PHY_ID_UNSPEC,
>         ETHTOOL_PHY_DOWNSHIFT,
>         ETHTOOL_PHY_FAST_LINK_DOWN,
>         ETHTOOL_PHY_EDPD,
>         /*
>          * Add your fresh new phy tunable attribute above and remember to update
>          * phy_tunable_strings[] in net/ethtool/common.c
>          */
>         __ETHTOOL_PHY_TUNABLE_COUNT,
> };
> 
> 
> Command example:
> # Enable PRBS31 transmit pattern
> ethtool --set-phy-tunable eth0 prbs on pattern 31
> 
> # Disable PRBS test
> ethtool --set-phy-tunable eth0 prbs off
> 
> 
> Let me know if the proposal is a feasible solution or any best
> alternative options available.
> 
> Thanks,
> Susheela
> 


