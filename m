Return-Path: <netdev+bounces-260556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLYRL929nWnzRgQAu9opvQ
	(envelope-from <netdev+bounces-260556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:03:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E1188C92
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5176F3011753
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8443A0EA0;
	Tue, 24 Feb 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB49gmgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB83A0B35
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945162; cv=none; b=hLTJFqF9pU8GFzmNzBg29R117mHWndD+zcViWj5fI7zNIdMMcMRrrbBmUtcBODVA31DvWQTIX3ChAL3B3j33RGWrSmi5FSnueC7tXKazwKHbpZAnw5rn7Gv99LeSrTX05uXYga3zNX6mC5aJ2CQryPWiuxpL7cx33/dTtgzTMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945162; c=relaxed/simple;
	bh=3WJXgXBsi7ueacomYKE5ZbVkQ0IS6FrU+8srbKbqG6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXiqHcShB2LMnqhu4QvWn/DSgv7mYzLf5BM4Q99iN/fbdbXSioN4IMOunE+U/sNtiirc6KzOMNCsh8B4gii3mqpv/eKWaWf4YDrSGwCNykVJX7uMBFoMLL2J1CnJnECqLLOd0G7FKptBe7tD9E62absg3QjUrhtlOrUVfmSunuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB49gmgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525B4C116D0;
	Tue, 24 Feb 2026 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771945162;
	bh=3WJXgXBsi7ueacomYKE5ZbVkQ0IS6FrU+8srbKbqG6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CB49gmgb6vDqQFI0DcOMUliy1pKnawWd9m2tX81Oa3PXO/2BKcpRb99ThWzKaa2N5
	 0B+spkV1uQMZHvpNEhWJ29IUxaVdrEclRCkfmfYSyuzanDjx6I0XzSP5kkTib989uC
	 pCg8XwlWAGcWDsW6UKJJnnfAPt5ZAgc+l3ZMFqY83y0ypRgwZ5lHoDKqtKp45uvGv8
	 /QBq/FHoCZjgL9ppRV/Ewo+FcZQp/B7915xNy6NW3hi0jVNVeNeGP6CTX0jsDVIAE7
	 glQ+1fJ/D28jdTEhJ3rAlhJZGHQ5ixBe7cJwa7x41dLSQ+fVBNTamOwtq80SP3ujO5
	 f2K/DkdsLyiaQ==
Date: Tue, 24 Feb 2026 06:59:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>
Subject: Re: [PATCH net] selftests: netfilter: nft_queue.sh: increase
 udp_gro_ct subtest timeout
Message-ID: <20260224065921.0d4f5cdc@kernel.org>
In-Reply-To: <20260223190108.28139-1-fw@strlen.de>
References: <20260223190108.28139-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260556-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 127E1188C92
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 20:00:58 +0100 Florian Westphal wrote:
> Jakub reports test flakes on debug kernels:
>  FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 23 and 17
> 
> The nf_queue listener exits when it doesn't receive a new packet after
> 2s, seems this is too low. Use a 5 second timeout instead, same as the
> duration of the packet generation side.
> 
> Fixes: 59ecffa3995e ("selftests: netfilter: nft_queue.sh: add udp fraglist gro test case")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260218184114.0b405b72@kernel.org/
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Hello, unfortunately I can't repro the flakes here, but 2s is rather
>  short and a nf_queue listener that exits while packets are still queued
>  does explain the error message (more packets counted as incoming than
>  outgoing).

Thanks for looking into it! Unfortunately we saw the problem again with
this patch applied:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/nf-dbg/results/531881/3-nft-queue-sh/stdout

Looks like it repros once every 25 runs for us:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-nf-dbg&test=nft-queue-sh

