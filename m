Return-Path: <netdev+bounces-280752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI8kKl8U6mmytQIAu9opvQ
	(envelope-from <netdev+bounces-280752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70E452321
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01EAB3097DE0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B63EDAA3;
	Thu, 23 Apr 2026 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL71IOE+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE93ED5DB;
	Thu, 23 Apr 2026 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948146; cv=none; b=k2P7c8j1Bmurwgr8KqABJFBL9LyUfZQyY1S8LlSciFrZbotLJljAoasR6hB8EK2gZBJAZjXduf3bo1lIUnIv4w5e7C/6+EuVLpD6Ra50MDOJk6YRl/+LqYgZym/1hXJ4rmqZbzom+Bh8/HmEwbOn+pcOmrTj+hB7XLaC5W+dXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948146; c=relaxed/simple;
	bh=Bx/9m+ue0sbCmAlZZ7RlFUBHs/8rfUrIxfR7ssMhcc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvfuAl8vDhTpnOF1mTL3RRX7DpzpyA2LqWnDX+k+34akPZMOmXHDFS3ZcQAmAWzHtCH364AlRpu9FLqSrsG0B59YeziMPzmkWpGWhhofElRLb2OVXbIOylrbvCisk3OG6GwV54jbZHev5xin/Q2VP6QGXdUMoUTG5FDFPSiNlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL71IOE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F1C2BCAF;
	Thu, 23 Apr 2026 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776948146;
	bh=Bx/9m+ue0sbCmAlZZ7RlFUBHs/8rfUrIxfR7ssMhcc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CL71IOE+/XqllE4gYeqIHJf426vw84w4SoA2ZVOayvrebeHYvQ/L/8I8J7jQThlg0
	 o7odu713HJiu38cDrLMMAy6AKG4up9pVyOqWAzCTktQZI9VBukjro7Byn6fvIYaXL9
	 DhsXvWiVmaT9jowX+hVWtgGMqm7ojepdldQMh2lnoI997DbPM1f2wKYXBYyAiPLzWu
	 yTdXSdlCBVwn0qNXNsGBljChDdRd7p4NZZ+I/stYiV5uWthvVcGjbFxkJk5LolVpbQ
	 4TT2G7y5k/5+s2SVIhsi3KV5c0UhZY27SguPk/9BbGASqQ0sfisbnxXrv/OJIr5A8L
	 77V3cIdwYpOyQ==
Date: Thu, 23 Apr 2026 13:42:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org
Subject: Re: [PATCH v2 net 04/11] octeontx2-af: npc: cn20k: Make default
 entries as x4.
Message-ID: <20260423124221.GB900403@horms.kernel.org>
References: <20260420023442.3295891-1-rkannoth@marvell.com>
 <20260420023442.3295891-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420023442.3295891-5-rkannoth@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280752-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F70E452321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 08:04:35AM +0530, Ratheesh Kannoth wrote:
> X4 profile users won't alloc x2 entries. Allocating x2 entries
> would cause under utilized subbanks(X2). Avoid this in X4 kex
> profile, all allocations will be from x4 subbank.
> 
> Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 26 ++++++++--
>  .../marvell/octeontx2/nic/otx2_flows.c        | 48 +++++++++++++------
>  2 files changed, 56 insertions(+), 18 deletions(-)

Hi Ratheesh,

This patch seems to involve a non-trivial amount of refactoring
in order to facilitate implementing the change described in the
changelog. This makes review a bit challenging (for me).

I am wondering if the patch could be split into two: a refactor
followed by the functional change.

Also, this feels more like an improvement to be targeted at net-next
than a fix for net. If it is a bug fix, I think that warrants a being
explained more clearly in the commit message.

Lastly, Sashiko generated a review of this patch. However, I do
not believe the concerns it raises are bugs or need to block
progress of this patchset.

...

