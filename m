Return-Path: <netdev+bounces-35268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7A7A83AF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910D21C209C4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9F37CBC;
	Wed, 20 Sep 2023 13:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE5328C2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975FFC433C7;
	Wed, 20 Sep 2023 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695217450;
	bh=x8NpMIW8Pp/mAHMBkzDCo1hL2KYMDL8gMyPggszSqTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTDilutzuNQ8Cq9DRivU0cu4sIvWpFMc+2nDJJACtK9H6FIX6jVv39897fjrBLVlO
	 e4H8Lew4ran5F230aLrpeRk8tbsD64DPBWeuZc8TeVoAtYwCm3SiyOKNT8/Xrt6ZUj
	 r17SDIDOeAiEVk/6yd0cfdcrmxDFf7kzlEbdm6gYTls5mytpU5FaCeAVwyq7pWRc7n
	 siPNdJkHtBQ8mq4JKIUJLsBsWiGRBhcdVsDAXWUh9caAe5seJCG2iypF3mcvcWj9pZ
	 bIpYhBT7qbV9fvRMCDv3QMQ2QAb0WoSphsX03ZkQteozaf6b6cjQ2y07sncP141VuV
	 8H6xCaagoIINA==
Date: Wed, 20 Sep 2023 14:44:03 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net] ice: block default rule setting on LAG interface
Message-ID: <20230920134403.GH224399@kernel.org>
References: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915153518.464595-2-marcin.szycik@linux.intel.com>

On Fri, Sep 15, 2023 at 05:35:19PM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> When one of the LAG interfaces is in switchdev mode, setting default rule
> can't be done.
> 
> The interface on which switchdev is running has ice_set_rx_mode() blocked
> to avoid default rule adding (and other rules). The other interfaces
> (without switchdev running but connected via bond with interface that
> runs switchdev) can't follow the same scheme, because rx filtering needs
> to be disabled when failover happens. Notification for bridge to set
> promisc mode seems like good place to do that.
> 
> Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LAG")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


