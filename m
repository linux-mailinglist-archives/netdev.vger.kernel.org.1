Return-Path: <netdev+bounces-300666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ki6KGTMNNWq2mQYAu9opvQ
	(envelope-from <netdev+bounces-300666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B23356A4F93
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xy+0x16K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300666-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85014302F38C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A63546E6;
	Fri, 19 Jun 2026 09:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064633342C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861680; cv=none; b=PI7X6HRVpkAUTqBMNDOQ8hNwu+NhldPW16KV3bfn1PXYaA2jQQlGpnyfzc6WK5Z2DoBRDef9mJU5jtA0JZ5eNhjiJZo/t2o+UUZ6b/jXIo4/LDRrjMmDCaDUd1L3i/9u474R+ZXGTqpu+SOEnYTdTNuI4cxqnSYoO+vCTpRwhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861680; c=relaxed/simple;
	bh=AlWIf+LaKAnUBfHhAuzpjF2RXFEUF/fCpySf9vJFU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3uqYlvBR0QLfIM1TAL18HMJTjD49a+f13DYpyEA8rlzxfCzo5GRTRNNa5oKkWZJfcciAUW4/54FuCoKVdGyVBVQdM6FaDACMaqAoTi5Gg5faUwWvq6Uf/m0V3aBkYMp9XrjY7MiAi89gZmcB2KAwBCgz+A/FtodTPbSiVcrjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy+0x16K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8F91F000E9;
	Fri, 19 Jun 2026 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861679;
	bh=gRRwy50K4JnGdt30eWE2lTF1ai/8iZTtgfay12HVjsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xy+0x16KZlwG5haPppjzskvBUiSoLb5G9gkeIbPo6nFvNOReDSO7RgJHtDvinTwQI
	 2QZ1c3ZoA6RtJzRy8Xp/nJSX1Zz8vdigEGLBnD3wq+2er7mojMW1KpckFtkeK3JRy4
	 XJt6hXfhR1TwV0fn/hMECuAcPGBlnDwPy/DZa6+fDGPqfEiKcPsp3YV+k12UxyQvtB
	 39lrenqCbPtUrYMJsmgVM2awBAoCvevmfa2A7LRUMS8IADDyVx2FPOgqbsoTxAgc/C
	 4qZJVOuAedeFXR2SMv1ud6AjUhF7QuntFk3tGk1dgfac2/5rRxCTcAme8qyV/RdrRm
	 dLg3W+yI4MMKA==
Date: Fri, 19 Jun 2026 10:34:35 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: airoha: Fix off-by-one in
 airoha_tc_remove_htb_queue()
Message-ID: <20260619093435.GU827683@horms.kernel.org>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
 <20260618-airoha-qos-fixes-v1-1-37192652157f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-airoha-qos-fixes-v1-1-37192652157f@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B23356A4F93

On Thu, Jun 18, 2026 at 08:00:29AM +0200, Lorenzo Bianconi wrote:
> airoha_tc_htb_alloc_leaf_queue() computes the HTB QoS channel index
> as opt->classid % AIROHA_NUM_QOS_CHANNELS and stores it in qos_sq_bmap.
> However, airoha_tc_remove_htb_queue() clears the HTB configuration
> using queue + 1 as the channel index, causing an off-by-one error.
> Use queue directly as the QoS channel index to match the allocation
> logic.
> 
> Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


