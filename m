Return-Path: <netdev+bounces-141334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914E9BA7BF
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BC41F215D8
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96A1885BB;
	Sun,  3 Nov 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+UeW6oK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5014F9E9;
	Sun,  3 Nov 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663592; cv=none; b=oadQcWc4rpenowsb67gRJEy0zxhncluS0ah0cOTLuy+b4zS/FEF67ZmtihXMEI6RNMSB5Mgmz63N2bxYbt4ENAkrGNwPvSvZrnNcKseuMs17NZ/pi1XDOdm5blqCGhho/UEidTyzG8PLwGuBIp2qkjOHod0+zMqj4nVZ/J30E0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663592; c=relaxed/simple;
	bh=h/lamnr7nl1eLEeIvKsQlIYXvEl0IMpMXenrPk9JjPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDmDGTugl6heqlUzwa15UGcSFaA3JKoqH2Gk5qm4Se0uLJrgbN57jqt/Ut6+qTF+Gr1OArfRKACHAzfg1hoF1XTKw1Na3u9OM30XKPUt5+RTmm0MIYbLBexsaaOHTIAYOs8JTrGQgmaNF6ewjwekiAGrI3jBZBBWZKf9b6Wowg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+UeW6oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F96DC4CECD;
	Sun,  3 Nov 2024 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663592;
	bh=h/lamnr7nl1eLEeIvKsQlIYXvEl0IMpMXenrPk9JjPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+UeW6oKQ2i72CHEzm9mAHq6+v/yXENRcvvwt25ugoIsPgygMUG/adjuW+vazo0OP
	 WZr3LmcBJxUw2yoNEian/vJPrHyyenRzIJkK80SKAsikKGl9GZHHksWTcT0CYInXgY
	 PH3+0qKxT+05W20B9mJfbutBxM49cFSePPpSOhLHTELMlCKUj4RUpBmdK80gqfgZEH
	 lUQjXy8r6sKhqwPBYYv4uPhL58TXEX3llk4LTBBnoCRGrQCjhG+/40FuDNWiUiJ11C
	 vCEF0XBf05kam65VGMTsyA/IkAbz14UFRj4gEw+orkTQ+9kUXIevW4hQ2EI+CI9zXE
	 BsmTR0lSmdk0Q==
Date: Sun, 3 Nov 2024 11:53:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>, <jerinj@marvell.com>, <edumazet@google.com>,
 <pabeni@redhat.comi>, <jiri@resnulli.us>, <corbet@lwn.net>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 2/3] octeontx2-af: Knobs for NPC default
 rule counters
Message-ID: <20241103115310.61154a0d@kernel.org>
In-Reply-To: <20241029035739.1981839-3-lcherian@marvell.com>
References: <20241029035739.1981839-1-lcherian@marvell.com>
	<20241029035739.1981839-3-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 09:27:38 +0530 Linu Cherian wrote:
> +	struct npc_install_flow_rsp rsp = { 0 };

@rsp is reused in the loop, either it doesn't have to be inited at all,
or it has to be inited before every use

> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	struct rvu_npc_mcam_rule *rule;
> +	int blkaddr;
> +
> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +	if (blkaddr < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&mcam->lock);
> +	list_for_each_entry(rule, &mcam->mcam_rules, list) {
> +		if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, rule->entry))
> +			continue;
> +		if (!rule->default_rule)
> +			continue;
> +		if (enable && !rule->has_cntr) { /* Alloc and map new counter */
> +			__rvu_mcam_add_counter_to_rule(rvu, rule->owner,
> +						       rule, &rsp);
> +			if (rsp.counter < 0) {
> +				dev_err(rvu->dev, "%s: Err to allocate cntr for default rule (err=%d)\n",
> +					__func__, rsp.counter);
> +				break;

shouldn't you "unwind" in this case? We'll leave the counter enabled
for some rules and disabled for others

> +			}
> +			npc_map_mcam_entry_and_cntr(rvu, mcam, blkaddr,
> +						    rule->entry, rsp.counter);
> +		}
> +
> +		if (enable && rule->has_cntr) /* Reset counter before use */ {
> +			rvu_write64(rvu, blkaddr,
> +				    NPC_AF_MATCH_STATX(rule->cntr), 0x0);
> +			continue;

so setting to enabled while already enabled resets the value?
If so that's neither documented, nor.. usual.

> +		}
> +
> +		if (!enable && rule->has_cntr) /* Free and unmap counter */ {
> +			__rvu_mcam_remove_counter_from_rule(rvu, rule->owner,
> +							    rule);
> +		}

unnecesary parenthesis

> +	}
-- 
pw-bot: cr

