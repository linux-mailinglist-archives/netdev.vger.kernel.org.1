Return-Path: <netdev+bounces-22697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE1768DAA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F53281305
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3846AF;
	Mon, 31 Jul 2023 07:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623041FDA
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C0C433C7;
	Mon, 31 Jul 2023 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690787797;
	bh=Kbl3vl8F9PAkSdvmheeUSu12turbgGYFzXBz/7n21cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=me8WSfKgL7EuiAQCQk2k/wnTmUfKNmqXGsSpWG+gwMjoqU2XRNroqffRh+zTdKxd8
	 oirX0a+WPlMLaE2hG+crYRWK7ZFqJ52ztSd0t97QlHdVZ7WTr1BUOTKOsFav4gJqV7
	 tAOuDZgo3GGo40lrlp9cTc30WF0OFHYIyEhjeSi0lXjNzRfV11TbmVBQmD8Ear9yXT
	 X5bKETveI6O1oBCq2xOvNQFld4CHQ6XqneB/PuhrMmpIooWTEHshbQSZw/aymC+Q91
	 mImzaPZbGlu9cvWP9D1Xo2cAdfCP09ucDLlx+5UIlq8aXkgUFqSBR26PMv1uEobcwg
	 H+wx/shfBal6Q==
Date: Mon, 31 Jul 2023 09:16:30 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	saeedm@nvidia.com, leon@kernel.org, simon.horman@corigine.com,
	louis.peens@corigine.com, yinjun.zhang@corigine.com,
	huanhuan.wang@corigine.com, tglx@linutronix.de,
	bigeasy@linutronix.de, na.wang@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v1] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080522.1064569-1-linma@zju.edu.cn>

On Wed, Jul 26, 2023 at 04:05:22PM +0800, Lin Ma wrote:
> The previous patch added the nla_len check in rtnl_bridge_setlink, which
> is the only caller for ndo_bridge_setlink handlers defined in low-level
> driver codes. Hence, this patch cleanups the redundant checks in each
> ndo_bridge_setlink handler function.
> 
> Please apply the fix discussed at the link:
> https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> first before this one.

FWIIW, the patch at the link above seems to be in net-next now.

> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


