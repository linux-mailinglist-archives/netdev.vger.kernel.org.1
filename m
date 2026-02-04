Return-Path: <netdev+bounces-256681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCnpBxExg2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:44:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90548E5430
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5373C300D9C5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284103E9582;
	Wed,  4 Feb 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0ORvtPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLoaOQI6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6A286D7E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205454; cv=none; b=e4eUFAL9ghwTESm9hHd3V4GIzo7P0jaH2PJIcGo+EnCTdtKemr5CM4172xmB0ft+/7zksXIsw6/Fgi/thw6S0OntCJ5mt8Ie6uHBmTbui9rw5KGkO76EVHH0WY8cPbKzN96yRe5VDTBzPwsPL49X28i6QePW7XiHa3b2rwhX2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205454; c=relaxed/simple;
	bh=wEsJwwCexS21kQg/D87r2WruLi1KZLl+3a7DHDMUCs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIHsuaonFTDAHJOQ0QrZg5Ov9r2KcgO2H9G/TDbWAa/+16NtyxAiY1Flzw6UyHRF1lwfXXmMBdwCiN1D6fNOTuNSsLY6QKgtDooxcTRN2JORDCOF3ltsZkDZE8HeAwt6r/cYoMIKBVf0/j6On6yiEKHufdEcZwq/Lvn+ezJ7HzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0ORvtPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLoaOQI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Feb 2026 12:44:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770205451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEsJwwCexS21kQg/D87r2WruLi1KZLl+3a7DHDMUCs4=;
	b=c0ORvtPnWNmc/RksSiA+j1nEdHbK0ttrSWRiKKaV1IaH3CIZAiloq0dPT12LqJ2dJ2ikxK
	XLVWrH9hewbF1jfcp0D0il197/EEg7ub8wC85Jb7/zgRmL55dhM9hhozk4cgAeWD0eLQSV
	FE/6CsgqBVIo5/RShusCjbjyHYPCCCYxnkQ1eNA2+3VZ4E4RlAqoUCgo8d5zv6lGKHdTFw
	yhBXaDpJSK0kHV/1DaL0+BLpHp1aOuxcoS7lV4GHRnpelMdctK57EBcWCIxZirFlLugpvy
	Qr/A10sU3ePUakhBa+4xn+X8bnEADJUNG7likAmtgccP4Ch+Jmy2biFnZC2G9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770205451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEsJwwCexS21kQg/D87r2WruLi1KZLl+3a7DHDMUCs4=;
	b=aLoaOQI6o38gSl/nnEDMwOOG1ReEw4sCsbtLIAVLicdXg7T9yudRtaDsm5rPLR8N3pfihi
	oieay5/Hyv9GNeCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@kernel.org, mingo@kernel.org,
	matttbe@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v3 4/8] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260204114410.aGPGVf5A@linutronix.de>
References: <cover.1770041682.git.fmaurer@redhat.com>
 <d767a756f426b8906ea12e411a97cf2ba04182c5.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d767a756f426b8906ea12e411a97cf2ba04182c5.1770041682.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,abb.com:email]
X-Rspamd-Queue-Id: 90548E5430
X-Rspamd-Action: no action

On 2026-02-02 15:19:20 [+0100], Felix Maurer wrote:
> Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> Fixes: 05fd00e5e7b1 ("net: hsr: Fix PRP duplicate detection")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

