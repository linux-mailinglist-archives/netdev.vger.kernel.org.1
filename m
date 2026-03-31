Return-Path: <netdev+bounces-273405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDacIRAWy2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:32:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5280362AC1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8117F3007CBC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D3248F7C;
	Tue, 31 Mar 2026 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaignE4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CF40855
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916946; cv=none; b=npmFPbxkHX4PVJsPCFIHykdta89tw2DgJ9pnlk/be36zQOwkEVQs/k0PcyExT8XZXBCFYPCF1F43hn6IEdvKF2ECv7Fuhy+DyBJExWfd4jn9wUr+kgdrQD3vrS4kbDlxprn3fUVujxhHJcxilhC7UMfrV3AYZohCi94NmJeUcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916946; c=relaxed/simple;
	bh=HqldPgKp9TGGyn7L65pc2nORgMdMa6raZULjHCR1jCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRXYI3MFPKalJEWFZRg9Mh1IulyMmNAGmdaCcYyEUsB3bIBjJwyWNEMA+rrIewTtpo9lmS3ei6PKsb5NRZqf2dMnJRye9+KGHQPRR8nw6M6LB526dPkE0mgpxpIQYMYrjDsgFczRP/AZeAmK6EgOlTljRqT1Y5UFLBp+KUVwV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaignE4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E3C4CEF7;
	Tue, 31 Mar 2026 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774916945;
	bh=HqldPgKp9TGGyn7L65pc2nORgMdMa6raZULjHCR1jCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UaignE4TkOdCWR+vxfEaWiwNOgV+brzQ80h1rNgUJxsm/9PunnuneMchdQcMT8OOZ
	 WDYsGFF0bcd8yNT7kJgVuOpNiyHk4+fj6pDzKnokCN9tyJbeAuDRcOgdeC4QymVtcv
	 t/vDxrU5q/MUz6+ViW+XGtvy8u35xBJy5QEW9o/ulNtuZ1b3gXE/RAWLooVujhpry5
	 7Y0pG3yClGmoojWnWmbDulqcrmd7+hu8WmDVnnLx/gehIAymFFskNMIWNNjZC+MX7L
	 4Xgdn7NPhQhGM45M9W3GiwU2kuSMEzJFoO8ZcY4//w6JCGT4h9mVaBx0gmVfTohZux
	 4FlkvsJ76abvQ==
Date: Mon, 30 Mar 2026 17:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Madhur Agrawal
 <Madhur.Agrawal@airoha.com>
Subject: Re: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
Message-ID: <20260330172857.0c94685d@kernel.org>
In-Reply-To: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
References: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-273405-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5280362AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 10:48:21 +0100 Lorenzo Bianconi wrote:
> In order to properly cleanup hw rx QDMA queues and bring the device to
> the initial state, reset rx DMA queue head/tail index. Moreover, reset
> queued DMA descriptor fields.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Take a look at sashiko, please:
https://sashiko.dev/#/patchset/20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org

Looks somewhat orthogonal to the current patch but probably worth
fixing.

