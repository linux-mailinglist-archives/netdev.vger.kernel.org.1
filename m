Return-Path: <netdev+bounces-261653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCKZNNbxoGm0oAQAu9opvQ
	(envelope-from <netdev+bounces-261653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:22:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105F1B17AD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF07E30151FC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFE254841;
	Fri, 27 Feb 2026 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5OrxpEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0923313E;
	Fri, 27 Feb 2026 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155328; cv=none; b=XVNPfD/Vq1g2YC3aeuXA1djV1wElD2twePqGLVrWXX0i99J7Y1n8mIdCEtNvwbW1QTgpoefmVV/RdCCoFHcuDlPzAlo5Zq6tAYcHF2tgApWrzUoFSY/cxNht/n0E6xchd8Nsl2bAa3ymFr+lKam3U3GTCTwryyWdy7c5cxBVOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155328; c=relaxed/simple;
	bh=G4uchlvH63oz+1IjKzG/Jr/BaWL2cOYw9voZpGzc5tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eowB4ofl0fMYSOZ9e7mFIVmGJ8w6N+dMhJr4Lkh2uSn05k8EsAcjl/t6Arx28vOLV4bwgAbW7jxbE1GXoQ7lCWpr3czYEGnwvzGWhnj9Y7w1qd+wnBlzKz5kjxMAmILExwfWoq9g8jQNSe+qkoerRHXWf5JzKDWBX/jnrwPE98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5OrxpEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F3C116C6;
	Fri, 27 Feb 2026 01:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155328;
	bh=G4uchlvH63oz+1IjKzG/Jr/BaWL2cOYw9voZpGzc5tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I5OrxpEH1wiwILSs420ljzmcg6NbjRwsycEk4fRT2Xj10Lvcr542HfmrWulkOLhie
	 MJuZ7+OPnqRobl3eQn1zIxjriD2PMDAp93wgStXlTClHqXM6uU+/hkuONAUK10sP6i
	 WSyEePW7kjuIPb8QGDZnRrcAJk7bjDmXOHpaorUNrQF1SgnAy/AQj32usPWKw0qbq4
	 dWaE4RdHboII2rW1wOn9AQ0yZAzqyx0t0G8OQtsCd5oPeHaxW0BctLEvchsN5IxGAp
	 9vS+ZLH1Z/toc1aPNSyNQMveBePqiQ/lODa7DbGDr4x4L/ggUCnxddjIv3DlaFdhd+
	 Ss+cqZ2xX5ksQ==
Date: Thu, 26 Feb 2026 17:22:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 8/8] bng_en: implement ndo_get_stats64
Message-ID: <20260226172207.6810e8ce@kernel.org>
In-Reply-To: <20260226182133.1566714-9-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
	<20260226182133.1566714-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3105F1B17AD
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 23:51:33 +0530 Bhargava Marreddy wrote:
> +	set_bit(BNGE_STATE_READ_STATS, &bn->state);
> +	/* Make sure bnge_close_core() sees that we are reading stats before
> +	 * we check the BNGE_STATE_OPEN flag.
> +	 */
> +	smp_mb__after_atomic();
> +	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
> +		clear_bit(BNGE_STATE_READ_STATS, &bn->state);
> +		*stats = bn->net_stats_prev;
> +		return;
> +	}

There can be multiple concurrent readers. Two enter, first one gets
stalled second one exits clearing the bit, close frees the memory,
second reader proceeds to hit the NULL pointers.

Again, please don't try to invent synchronization primitives.
You can probably use RCU here.
-- 
pw-bot: cr

