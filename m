Return-Path: <netdev+bounces-273024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C6VvMaijyWnj0QUAu9opvQ
	(envelope-from <netdev+bounces-273024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11513354412
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576B9300BC93
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7836BCC3;
	Sun, 29 Mar 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPvbeLS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AB30F547;
	Sun, 29 Mar 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774822309; cv=none; b=opD+b+q82rp0Lx2aH9Q+pYsA9n2rMp+WZIIyg42xKqzOwJn3pjNF4s/tq5nnY3BxBsW7kuEM9oK3VsjrUfajmhP4z1Ycmx2tuHKhIiZihYlKURqi6pQWh6z0Z1nAoqnVWvxXnZei94KN60IaoCQgLuDdec6erWsEE1y4konyB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774822309; c=relaxed/simple;
	bh=JRvJneMHtrsi4yXBNe6LRlO/CoN/jkmSP5H4YoABJz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POshLGGhTZka/U4Yz5rvNGFB1ZF4y86dgTH1lcm/mH194Uk7OU4R2ysGKK9cyX/QuR/p4tOcu8EbgCD1/G7K3UnYjR0Qdd2zYUsg/RPd3bTPDRXU5Yg3fImennpAT5omzjC8UivBmKFvJerPd5QD4S3tyTLrwyi8FmRB66N257g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPvbeLS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946D9C116C6;
	Sun, 29 Mar 2026 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774822309;
	bh=JRvJneMHtrsi4yXBNe6LRlO/CoN/jkmSP5H4YoABJz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPvbeLS5SMngDD87LJ4R2e44su0XT5Q9/K1513B1FfdyJeI1wQMVTK1eB2gzGILmm
	 9ypJqhM0kt43isErXMYwNqzz4NxtPzdyiy+W47oVwtU7O73blO23trxxK+DlJZBBDM
	 dbd646gC4Qhl+TmZHMSxi9B4l+f2VNqR/8rDKzTanPR0C5lwdo5K1wpYq7mjnC05H+
	 imnKzwQtChYatuWCAuZOZFlm4KpXTU49HiaUCOxDAVk03vNYIc2DXyKoZJLS9q/4Ao
	 uiklx6WLp9E2+Rlm/yu0S8g4+7ioksnWBVsvK83D03K1S7O6EuTfxkppi2SYlmyhO0
	 tUoc2mWdrlLxQ==
Date: Sun, 29 Mar 2026 15:11:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 01/12] net: tso: Introduce tso_dma_map
Message-ID: <20260329151147.6d2fc8e0@kernel.org>
In-Reply-To: <20260326235238.2940471-2-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-2-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11513354412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:52:20 -0700 Joe Damato wrote:
> Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
> GSO payload data.
> 
> The struct combines DMA mapping storage with iterator state, allowing
> drivers to walk pre-mapped DMA regions linearly. Includes fields for
> the DMA IOVA path (iova_state, iova_offset, total_len) and a fallback
> per-region path (linear_dma, frags[], frag_idx, offset).
> 
> Helpers to initialize and operate on this struct will be added in the
> next commit.

Let's squash this with patch 2? Quite useful to see the struct when
reviewing the code..

