Return-Path: <netdev+bounces-30433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA5787485
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29302281588
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBBE13AD0;
	Thu, 24 Aug 2023 15:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A6100DC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07B4C433C8;
	Thu, 24 Aug 2023 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692892033;
	bh=bo80xRhwCxiBHOSnaUm4RwomNMAJj1C5Ft16yClya1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgJTwW8b1JHCW2ZVKlUx7zvpcTSlrUs3PMdSQ6fut+sJreSg7OZl09T2NP++fNIr9
	 PEzpAGuoIWVisKZOvCrOjiEWDgxaMMiMTCxYt7hsGt7wNPkqK4S941iBqMUVuaAgO8
	 i7zputd0mm5JLJFdaBm4DCcv1ZNmmS3eOPgOe3OmNhLn87SSHd6wUliZLD8faKSrzc
	 h1l5CjQGYPpk6HTcdPA+DnkyXQuoN0SMKKkEam5AtfJ6hqAK6oSyiLpDfrDW9hzlo4
	 Dnkfd0+TXPBxAchqI2Gp5TQ9SYyn5zBUWsLJOW64P7E8IiwhVaAbXvG0hpqpVEYxDO
	 sBO7OZMIDZmTA==
Date: Thu, 24 Aug 2023 17:47:05 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, danielwinkler@google.com,
	davem@davemloft.net, edumazet@google.com, haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com, jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com, johannes@sipsolutions.net,
	kuba@kernel.org, linuxwwan@intel.com, linuxwwan_5g@intel.com,
	loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
	pabeni@redhat.com, ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com, soumya.prakash.mishra@intel.com,
	nmarupaka@google.com, vsankar@lenovo.com
Subject: Re: [net-next v2 5/5] net: wwan: t7xx: Devlink documentation
Message-ID: <20230824154705.GK3523530@kernel.org>
References: <20230823142129.20566-1-songjinjian@hotmail.com>
 <MEYP282MB26978F449A3C639B1DB89984BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26978F449A3C639B1DB89984BB1CA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

On Wed, Aug 23, 2023 at 10:21:29PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Document the t7xx devlink commands usage for firmware flashing &
> coredump collection.
> 
> Base on the v5 patch version of follow series:
> 'net: wwan: t7xx: fw flashing & coredump support'
> (https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Hi Jinjian Song,

some minor feedback from my side.

...

> +
> +Coredump Collection
> +~~~~~~~~~~~~~~~~~~

nit: the line above seems to need one more '~'

> +
> +::
> +
> +  $ devlink region new mr_dump
> +
> +::
> +
> +  $ devlink region read mr_dump snapshot 0 address 0 length $len
> +
> +::
> +
> +  $ devlink region del mr_dump snapshot 0
> +
> +Note: $len is actual len to be dumped.
> +
> +The userspace application uses these commands for obtaining the modem component
> +logs when device encounters an exception.
> +
> +Second Stage Bootloader dump
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ditto.

> +
> +::
> +
> +  $ devlink region new lk_dump
> +
> +::
> +
> +  $ devlink region read lk_dump snapshot 0 address 0 length $len
> +
> +::
> +
> +  $ devlink region del lk_dump snapshot 0
> +
> +Note: $len is actual len to be dumped.
> +
> +In fastboot mode the userspace application uses these commands for obtaining the
> +current snapshot of second stage bootloader.
> +
> -- 
> 2.34.1
> 
> 

