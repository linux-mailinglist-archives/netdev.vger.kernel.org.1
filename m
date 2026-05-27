Return-Path: <netdev+bounces-292224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJXNG8m+FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C83995E2272
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACE723014C2F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB53C1F46;
	Wed, 27 May 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4Bo7e8K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NWie4Znc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y4wswlU6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYAtsh/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807863E3D9F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875487; cv=none; b=HqtecGdGyOjbBHep9JVN/VGFICz+TViJppRV5YB41YLFAEUebdt7fJ6SDhujjY9ENqo5QGXRYs8+58/bpaLraqtExYoocWUUejXA6cHIZ4PGocZNXer7SkJ6whh5vNEwZPUlhaSaVYT2XKAEotiD6tCMxkIhjT0hzrcP/2EGbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875487; c=relaxed/simple;
	bh=ZiLx+nwXbAzw55MofB7jcB/7mAUOEnbPtGIwaOTJwf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ppe8XQ+/mEbm8auXFS0uoSRIvTChJrRG5iAbrvaKSv/Yvji9jZoAq65kIxrl0fNjN++59wTaiMU0p03RYvOqpC1SiihsTe0n1HCPndE3dYL5mdgnHYQEYf75PJrD55FcITZ0i/GZdxF5pljHj4Pm0fTLr2Q65BDn42rZEkdqdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4Bo7e8K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NWie4Znc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y4wswlU6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYAtsh/p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F69166DA9;
	Wed, 27 May 2026 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2H4Ds2xHRFPE6LU/zFl+RiPaXvfcANNxLP9YZsqiDM=;
	b=f4Bo7e8KQTaVhDEBtHmrHfdQoUkQ4EgKHaTD4Z3TVbk+yW6f/zViVenDQ0ENZUs6wYPcg9
	b1SIrc8KL80jVlRhizNnvRMovUM3XC1YNRy1oFME+EbJ4A8jwJuiTDsIqwu2PsiQctcJV9
	U91HdhlREqSbd+UOH8ULgQ4QtDjzngU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2H4Ds2xHRFPE6LU/zFl+RiPaXvfcANNxLP9YZsqiDM=;
	b=NWie4Znc2aHUq+allxUAXf1WwzUMoFi4IwRPwGzNf8ivSLACfy1tPfwHd6MBq+9s05JM9I
	bisCb/FN2HW380Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2H4Ds2xHRFPE6LU/zFl+RiPaXvfcANNxLP9YZsqiDM=;
	b=Y4wswlU6aywgHssrQz6TFQALP69d1knBgssqu2U00wnpcDSHm/j7ZobxINjFwEGtNH2M7X
	HEQbQFlbPTjuJ4uIfKHwR5j3YEnFVFr1apj/6mrWgrXALlCPE3E5CowUGtteVfDoGcCpY9
	bJocVrtT17RBPA5s9XsqjfVv/4vyrmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2H4Ds2xHRFPE6LU/zFl+RiPaXvfcANNxLP9YZsqiDM=;
	b=sYAtsh/p3pmX3jzlv3UVVgXUWsE9bzrIWvVfxHla4qPLdAHGugPtcaDKtJqhgAVtvMySCT
	wiYL5H7hAOXHzKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776845A782;
	Wed, 27 May 2026 09:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VKFrHJq+FmpxRgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 09:51:22 +0000
Message-ID: <15b63b82-1572-418d-9ed9-8ccc11217beb@suse.de>
Date: Wed, 27 May 2026 11:51:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 5/6] tls: Suppress spurious saved_data_ready
 on all receive paths
To: Chuck Lever <cel@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-5-244fe1dc4abd@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260526-tls-read-sock-v11-5-244fe1dc4abd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-292224-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C83995E2272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 16:21, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Each record release via tls_strp_msg_done() triggered
> tls_strp_check_rcv(), which called tls_rx_msg_ready() and
> fired saved_data_ready(). During a multi-record receive, the
> first N-1 wakeups are pure overhead: the caller is already
> running and will pick up subsequent records on the next loop
> iteration. The recvmsg and splice_read paths share this waste.
> 
> Suppress per-record notifications and emit a single one on
> reader exit. tls_rx_rec_done() releases the current record
> and parses the next without announcing; tls_strp_check_rcv()
> gains a bool announce parameter so callers can request the
> quiet form. tls_rx_reader_release() fires the deferred
> announce on exit through tls_rx_msg_maybe_announce(), an
> idempotent helper that calls saved_data_ready() only when a
> record is parsed and has not yet been announced.
> 
> To keep the final notification idempotent against records that
> the BH or the worker has already announced, tls_strparser gains
> a msg_announced bit. tls_rx_msg_maybe_announce() sets the bit
> when firing saved_data_ready(); the bit is cleared whenever
> the parsed record is wiped, by tls_strp_msg_consume() on
> consumption or by tls_strp_msg_load() when the lower socket
> loses bytes from under the parse. A second call for the same
> parsed record -- as when recvmsg() satisfies the request from
> ctx->rx_list without touching the strparser -- becomes a
> no-op.
> 
> With no remaining callers, tls_strp_msg_done() is removed.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/net/tls.h  |  5 +++++
>   net/tls/tls.h      |  5 ++---
>   net/tls/tls_main.c |  2 +-
>   net/tls/tls_strp.c | 23 ++++++++++++-----------
>   net/tls/tls_sw.c   | 27 ++++++++++++++++++++++++---
>   5 files changed, 44 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

