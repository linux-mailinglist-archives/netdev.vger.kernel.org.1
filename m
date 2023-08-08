Return-Path: <netdev+bounces-25276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3F773A47
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B442817E7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22398101F0;
	Tue,  8 Aug 2023 12:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784911CBF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 12:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815BC433C7;
	Tue,  8 Aug 2023 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691499106;
	bh=czHewSu/ClbRoBJAOohHZjA2+Uw0usYmOLRzJpX+Gbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqCClGIeqYURWbJwbJ6UGvvGF1nj31U1Zj6RfvULDPR4ISd6EiPAw3ibb6fbOjIp0
	 ze8z+VMY1X7Fd4SmiuGnxRwjqg71xm54CA1Dd/yyMTPKVk39X0Wt2PVpbYANWGYIA/
	 3R6JliH2Msy0JfbNp6fhnLKQpqpTiOU2I4rrt4yVxaH5pZR8/brkRNkEGNGocoVYku
	 Lwu/iNj1/fnR/tiSo6xo5mVwceepYwH4C+aUcQ1T4qH1fnkZRpU+plXFDTWlkM7j3y
	 rju9ki2Z3awM2RHPAAUGhWz/XmWsmRlvti2jLd8AG5qxYwqSC9STIQh12W6dMYGVge
	 VbulLnCCgWYig==
Date: Tue, 8 Aug 2023 14:51:41 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Jacob.e.keller@intel.com, przemyslawx.patynowski@intel.com,
	kamil.maziarz@intel.com, dawidx.wesierski@intel.com,
	mateusz.palczewski@intel.com, slawomirx.laba@intel.com,
	norbertx.zulinski@intel.com, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] Revert "ice: Fix ice VF reset during iavf
 initialization"
Message-ID: <ZNI6XSBM2ULz0CZM@vergenet.net>
References: <20230807094831.696626-1-poros@redhat.com>
 <20230807094831.696626-2-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807094831.696626-2-poros@redhat.com>

On Mon, Aug 07, 2023 at 11:48:30AM +0200, Petr Oros wrote:
> This reverts commit 7255355a0636b4eff08d5e8139c77d98f151c4fc.
> 
> After this commit we are not able to attach VF to VM:
> virsh attach-interface v0 hostdev --managed 0000:41:01.0 --mac 52:52:52:52:52:52
> error: Failed to attach interface
> error: Cannot set interface MAC to 52:52:52:52:52:52 for ifname enp65s0f0np0 vf 0: Resource temporarily unavailable
> 
> ice_check_vf_ready_for_cfg() already contain waiting for reset.
> New condition in ice_check_vf_ready_for_reset() causing only problems.
> 
> Fixes: 7255355a0636 ("ice: Fix ice VF reset during iavf initialization")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


