Return-Path: <netdev+bounces-251701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MezBGU1cGl9XAAAu9opvQ
	(envelope-from <netdev+bounces-251701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:09:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2324F89B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62BFE9CFAA4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74267339873;
	Wed, 21 Jan 2026 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckifaalR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A543101A5;
	Wed, 21 Jan 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961332; cv=none; b=QcncV/3TMfjTviuFaYHFlZfkil65DvKnZPVmcSq0HGjAbIxwnp7JkaNKSD3zAJwNQicxhtB6zMHL228gcFSJSsp0ljFrX12WLCzcWKFPgS2V0Mkk6F6YVodlo9zUeB49/SDmo3PigYnSAilRaSSpvmc9Y29tS6RtiwoqyPNEWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961332; c=relaxed/simple;
	bh=ZIVqkn7aaWPlZO+GqB+e1APPFmE6QxIG8Nb50lWT3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+rUQkN5Nn9PBN/1v9qNzVOk3qWsli/W37RXmU+AHN/pSxr8nOKBkABKiOcepkjdMC4W/BZazjz5h6bi2fekRTAjQGw1W15zL9OsLTbxxkuKoM2tyK/5r7R1fST0ujO2qPhBjbjfjmHjlfiWm3pBllDwOQJLtjosKI3y2wAyG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckifaalR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B79C16AAE;
	Wed, 21 Jan 2026 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961332;
	bh=ZIVqkn7aaWPlZO+GqB+e1APPFmE6QxIG8Nb50lWT3N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckifaalR4goMe5fZSVZsJfJOmxD5aIqoeFoGb4bi8cGfISyiSNIKM1fFDuX55O/6d
	 X4gJIU9T1VDa4s6F5wA1sowCSQjpdyiV26RrB7AA1m/L4r7H4WNct8Rygo6829LNWi
	 5JPS+rrEx6MLqDlOKDAitaljGN5nU2x7SCHd1PamCiX1nsPwfuIP63xgBrUEPXddZw
	 0RaaKbk1n+9HKG8BWSAoXl3ty1eFjJT73vNpvCTAmQypNufpEOkCYBNjJZOHfx64mp
	 Sn6tSwc7yuAQwqTX4wpMchPtIza2CSEdbDqTC3o2NdcSDJ7ZCsEnOSTp2iGzFq0W+z
	 seXZObBs7w0WQ==
Date: Tue, 20 Jan 2026 18:08:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 00/16] netkit: Support for io_uring
 zero-copy and AF_XDP
Message-ID: <20260120180850.45ae4214@kernel.org>
In-Reply-To: <176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	TAGGED_FROM(0.00)[bounces-251701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7A2324F89B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 11:50:25 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Here is the summary with links:
>   - [net-next,v7,01/16] net: Add queue-create operation
>     https://git.kernel.org/netdev/net-next/c/a5546e18f77c

I'm going to revert this, I sort of promised Pavel I will pull his
work and he has the cross-dependency with io_uring. Y'all can rebase.
Plus what this series does to "the code I wrote" saddens me deeply.

