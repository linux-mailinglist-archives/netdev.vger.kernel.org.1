Return-Path: <netdev+bounces-145411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0239CF669
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665B5286A91
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8DB19309E;
	Fri, 15 Nov 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="FxT85VUv"
X-Original-To: netdev@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5C1D5CF1;
	Fri, 15 Nov 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704006; cv=none; b=DePzEL/8rZgHTkr0Z5WfH/5Omv4nx3u6XwplGfYBqctNlKvCiGSR3EnzMzarT5oOdl8fKkSZQW2laYLT+Y5SYrdGyjOr2APbrygBrPRYiAhN99iCZmGKhVNvEVs2nmkIYq2HW2b4i55679nAGRVjLWrfjJCne8AX8N62tcHZoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704006; c=relaxed/simple;
	bh=8V1VAweJBdHvycsiKdURAzqcW5AbmpAsGaJpU+BRN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7DRhyZx2JGdJSWZ69Obk3pQ4NIQ4v+PO9HfrGH06Qi7RonUDBTAV0InNIsiNh+iouRgbULGBHTbKxLGJZAw+VHbVbrfim4imXXxaa0RwgAws6a+3kUHv46zHWL+vYYrvfd9nqF6IwdoDzJ75q3hJ5mbd7rCspYHFMhLWUBsXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=FxT85VUv; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731704002; bh=8V1VAweJBdHvycsiKdURAzqcW5AbmpAsGaJpU+BRN+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FxT85VUvAvnBZxJUw8cR7SQLknea/P9K4cXoHocsR1MJlkRiZ2xHpvX/4XbpKRcYd
	 GK0gvGGwchRs5OXGixhyc9QsiSrqBVUY3b/JMSfjqeKg3nJAk+bZnzpno3QFCyyM5E
	 ZaHUXXA1OjI9Fn97bd8PgoLa0hRwoGesM9/Rya7bagv4zwaytRgwZaTJVh/TpFzqhu
	 0cquQjGeU3btotzTjm+2u3MtV1/x3A20Q4rgyftTe/gs0lKmyFC2JKlR+YaVz04NgE
	 uc5bPtFnX8mGjeZWH5h7gc6lTw9gt9wDXnjQca32xwENtuXH890suAxi6qD0YFTqej
	 S+TVT8OOsBPt9NkIUZ5IhvG4tFrL23ETXdLSNsh0LrQW8bKbruuuQ6RclrQeSR6vbC
	 u6orXfyxHe8tzm07GzZGPFcvdM66KH4i4MCTQteVUe+zNw98EQ/fLtgWnPxdDQfdSB
	 OQY12tZu1iicFJ47U6xN3yxWQjVzhRVaA0jf0YgROG5OVcx1Io4trI2Zf5HyTmpy29
	 /xlEjHl8xSwpLSLZiBUoU8TJBZZWc0JPUiAOuldhX/VTGm3dbDQOV8oTRxahAXuakp
	 RMjYhHwUwbHV+XpLbiY07Efy2ae3jRGmLP+vtsK1TB8/OPPZV3FfBMiqU+4Px7hxry
	 GlqTGaEIgaG9pIj3f3LZ9tIY=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id DF1ED18E000;
	Fri, 15 Nov 2024 21:53:21 +0100 (CET)
Message-ID: <01c3b716-1450-4e15-85f5-76985ccf3f13@ijzerbout.nl>
Date: Fri, 15 Nov 2024 21:53:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v12 11/12] octeontx2-pf: Adds TC offload support
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 jiri@resnulli.us, edumazet@google.com, sgoutham@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com
References: <20241107160839.23707-1-gakula@marvell.com>
 <20241107160839.23707-12-gakula@marvell.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241107160839.23707-12-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 07-11-2024 om 17:08 schreef Geetha sowjanya:
> Implements tc offload support for rvu representors.
>
> Usage example:
>
>   - Add tc rule to drop packets with vlan id 3 using port
>     representor(Rpf1vf0).
>
> 	# tc filter add dev Rpf1vf0 protocol 802.1Q parent ffff: flower
> 	   vlan_id 3 vlan_ethtype ipv4 skip_sw action drop
>
> - Redirect packets with vlan id 5 and IPv4 packets to eth1,
>    after stripping vlan header.
>
> 	# tc filter add dev Rpf1vf0 ingress protocol 802.1Q flower vlan_id 5
> 	  vlan_ethtype ipv4 skip_sw action vlan pop action mirred ingress
> 	  redirect dev eth1
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>   .../marvell/octeontx2/af/rvu_npc_fs.c         |  14 ++-
>   .../ethernet/marvell/octeontx2/af/rvu_rep.c   |   4 +
>   .../marvell/octeontx2/nic/otx2_common.h       |   7 ++
>   .../marvell/octeontx2/nic/otx2_flows.c        |   5 -
>   .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  25 ++--
>   .../net/ethernet/marvell/octeontx2/nic/rep.c  | 115 ++++++++++++++++++
>   .../net/ethernet/marvell/octeontx2/nic/rep.h  |   1 +
>   7 files changed, 154 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 150635de2bd5..9d08fd466a43 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1416,6 +1416,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>   				      struct npc_install_flow_rsp *rsp)
>   {
>   	bool from_vf = !!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK);
> +	bool from_rep_dev = !!is_rep_dev(rvu, req->hdr.pcifunc);
>   	struct rvu_switch *rswitch = &rvu->rswitch;
>   	int blkaddr, nixlf, err;
>   	struct rvu_pfvf *pfvf;
> @@ -1472,14 +1473,19 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>   	/* AF installing for a PF/VF */
>   	if (!req->hdr.pcifunc)
(1)
>   		target = req->vf;
> +
>   	/* PF installing for its VF */
> -	else if (!from_vf && req->vf) {
> +	if (!from_vf && req->vf && !from_rep_dev) {
(2)
>   		target = (req->hdr.pcifunc & ~RVU_PFVF_FUNC_MASK) | req->vf;
>   		pf_set_vfs_mac = req->default_rule &&
>   				(req->features & BIT_ULL(NPC_DMAC));
>   	}
> -	/* msg received from PF/VF */
> +
> +	/* Representor device installing for a representee */
> +	if (from_rep_dev && req->vf)
> +		target = req->vf;
This now makes all previous assignments to `target` useless. See (1) and (2)
You created an if-else construct with an assignment to `target` in both 
paths.
Can you please check the logic again?
>   	else
> +		/* msg received from PF/VF */
>   		target = req->hdr.pcifunc;
>   
>   	/* ignore chan_mask in case pf func is not AF, revisit later */
> [...]

