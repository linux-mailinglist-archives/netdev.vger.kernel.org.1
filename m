Return-Path: <netdev+bounces-13480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB0C73BC19
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D221C212A7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603BC8DE;
	Fri, 23 Jun 2023 15:53:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2580C2FD
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94577C433C0;
	Fri, 23 Jun 2023 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687535619;
	bh=LO2ZlO08aZVmvLBPdoTl7wZfWJdem3/WH71EoJNOLT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPKlUylbJIXpldlDEdYgOUqmxx+MdfOUA5CfZ2018ys73LdvAryMsIz4OpewSRK+j
	 KG6x2V+HTnkocCO6RQNv9ixN23S/NmN/svxHFvj1I3/j7UopQ3vi3wc5Cqi8B/B2hR
	 ObZimg/ux3CsntQYi3GGU0SDlBoDe50mv8YSg6fPceWtPa6kRRmhX8Z3X4yM0JvS9K
	 5mS/WanIjcqtwGkXdYptKmALsi0gecaYLsgsEXLqPYgTtBxDMbtnzk+rlKZU0/wTCc
	 mXGVmsGOz9ev8DLJ+6aU2b4cAXYX5rQM4eSGBnBgyGSfiRp3guqTrK21XRAYfJZQfe
	 AFXvVmRRbtJuQ==
Date: Fri, 23 Jun 2023 08:53:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, vadfed@meta.com,
 jonathan.lemon@gmail.com, pabeni@redhat.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, vadfed@fb.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, saeedm@nvidia.com,
 leon@kernel.org, richardcochran@gmail.com, sj@kernel.org,
 javierm@redhat.com, ricardo.canuelo@collabora.com, mst@redhat.com,
 tzimmermann@suse.de, michal.michalik@intel.com, gregkh@linuxfoundation.org,
 jacek.lawrynowicz@linux.intel.com, airlied@redhat.com, ogabbay@kernel.org,
 arnd@arndb.de, nipun.gupta@amd.com, axboe@kernel.dk, linux@zary.sk,
 masahiroy@kernel.org, benjamin.tissoires@redhat.com,
 geert+renesas@glider.be, milena.olech@intel.com, kuniyu@amazon.com,
 liuhangbin@gmail.com, hkallweit1@gmail.com, andy.ren@getcruise.com,
 razor@blackwall.org, idosch@nvidia.com, lucien.xin@gmail.com,
 nicolas.dichtel@6wind.com, phil@nwl.cc, claudiajkang@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 poros@redhat.com, mschmidt@redhat.com, linux-clk@vger.kernel.org,
 vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <20230623085336.1a486ca3@kernel.org>
In-Reply-To: <ZJW37ynDxJCwHscN@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
	<ZJW37ynDxJCwHscN@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 17:19:11 +0200 Jiri Pirko wrote:
> I don't understand. The discussion in the RFCv8 thread is still going
> on. The things I mentioned there are ignored. Like for example:
> 1) mode_set op removal
> 2) odd ice dpll locking scheme (either fix or describe why it is ok -
> 				that's the unfinished discussion)
> 3) header file bits squash I suggested. Vadim wrote that it sounds
>    reasonable, yet nothing changed
> 
> I thought we are past this. Why I have to point the same issues over and
> over?

FWIW I'm lost in the previous thread, so for me there's value in
refreshing the series.

But you're right, at the very least there should be a summary of
outstanding issues / open items / ongoing discussions in the cover
letter.

