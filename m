Return-Path: <netdev+bounces-268419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fn4BYjNuGlfjgEAu9opvQ
	(envelope-from <netdev+bounces-268419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:42:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690D2A3473
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61D85301221A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223563093CB;
	Tue, 17 Mar 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcPPwQcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AF3081D7;
	Tue, 17 Mar 2026 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718915; cv=none; b=epVal1dl6lVKpVH2G/ALiVz5rG4NzqEXRy2J3zOVQe62qHFqk4s3KMOwbE8E19Lmy/o1WTe96anZITcOXMJP+USMN0WB47dBGiF733ytqCGKy2a66j1ECSpCPLenMpaVCDn85u5jiLDbKDeYMuZOygYuOepyjQS8KVjaZ4L3oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718915; c=relaxed/simple;
	bh=EFPIQGvSiWvqJ5SpNLa40uo/8NSdREio+xiR9Gfj4JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONNOl4qKunB8B7w7BD0xR1c6GaNAAtrK5B0FEe7etzW4RSGQ5yew5xVRyrnt9zg0whHZLX/OpcUK3eyay4ccy5YiqGw+xgcoIbAJoX+DZiGUBNlDxfG7C3KVJLBPaDf1kSKQFPQCwTmIaqKx5zT0B3a44VwtFumokNEOX7yL5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcPPwQcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D4FC19421;
	Tue, 17 Mar 2026 03:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718914;
	bh=EFPIQGvSiWvqJ5SpNLa40uo/8NSdREio+xiR9Gfj4JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GcPPwQcKlzRSnuiFkKNELL++37qfOYS091YabJMh2EBv/jB53ISEQ60abkmmsUj3f
	 qtW9qmTG7jVgnMn5Tw4FPHJT5YyMWyzJjGfLaHhtXiAFUoRqYWxXYoWVWIefZ8jl9Z
	 jgYfmEmQunArpfs3BGgu4MaEffZ1C2VidV/K9kncc2i0jtClG5TmLHLNEna2w1zyDi
	 YZK8ZzZNWi3Xs+lO6S/7vF6+q5iMH7O5Ip6VmHuLCzhoTQLFISPfhBd/Q3/c1V7iQK
	 Mg4ZiTru3t/qWAPxwL+//JI8btzNqqY9a0STScjUj5n5QT9L5b1g0P4ReFfV4IJqe1
	 H7aYyaa2WVBQg==
Date: Mon, 16 Mar 2026 20:41:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: dpaa2-mac: retrieve MAC statistics
 in one firmware command
Message-ID: <20260316204153.4643cd16@kernel.org>
In-Reply-To: <20260312142249.297192-3-ioana.ciornei@nxp.com>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
	<20260312142249.297192-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268419-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1690D2A3473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:22:48 +0200 Ioana Ciornei wrote:
> +	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
> +	if (!stats->values_dma_mem)
> +		goto err_alloc_values;
> +
> +	cnt_idx = stats->idx_dma_mem;
> +	for (size_t i = 0; i < num_stats; i++)
> +		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
> +
> +	stats->idx_iova = dma_map_single(dev, stats->idx_dma_mem,
> +					 num_stats * sizeof(u32),
> +					 DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, stats->idx_iova))

dma_alloc_noncoherent(), maybe ?

