Return-Path: <netdev+bounces-14458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33CB741A79
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB600280CF0
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8D11189;
	Wed, 28 Jun 2023 21:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F711181
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 21:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441FDC433C8;
	Wed, 28 Jun 2023 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687986716;
	bh=koy1OSVClFvab/lF2oDpHJ8TmCs3jlviG8/MsiVo+Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvmuZcGln587JyJuaJDrT+al7I2gKijxRz621UF4LqnsGqSeDrahvWqCqKroQFFhq
	 ApOTUfy0a8iGFpGGntTJg1TBl3dd9VVM8kUAudJeLfkoLsujBbbfd4JPiP8Ht87M2m
	 pZARl4XrdTylp3oTBYox5IqPadcRQ0OVbZKdqen7tQ25qtu5Em2rNL24xj+t1EhEIk
	 p/qPwnfXtf3QwA6x4qizYyRkXUyEoPKUnCGRsvQKH8qIE+aA1FP8WB4m/VFCP3Wwla
	 I6YJMAa9btFARFeIQxjsHsoBB9z/pa1AIHRNMGTj4+TSQGkzmtCk9p/+Kq9gov7Yiv
	 q5jljPvmNR1nA==
Date: Wed, 28 Jun 2023 14:11:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: jiri@resnulli.us, vadfed@meta.com, jonathan.lemon@gmail.com,
 pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
 richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
 ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
 michal.michalik@intel.com, gregkh@linuxfoundation.org,
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
 vadim.fedorenko@linux.dev, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [RFC PATCH v9 01/10] dpll: documentation on DPLL subsystem
 interface
Message-ID: <20230628141153.15709d97@kernel.org>
In-Reply-To: <20230623123820.42850-2-arkadiusz.kubalewski@intel.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
	<20230623123820.42850-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 14:38:11 +0200 Arkadiusz Kubalewski wrote:
> +    'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
> +                   {'pin-id': 3, 'pin-state': 'disconnected'},
> +                   {'id': 0, 'pin-direction': 'input'},
> +                   {'id': 1, 'pin-direction': 'input'}],

This bit of documentation is out of date now, right?

