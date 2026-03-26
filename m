Return-Path: <netdev+bounces-271975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEoqAsoLxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:34:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D309333720
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B51BD305983F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709C3C9EDD;
	Thu, 26 Mar 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XJT4ilsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PaVursrP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XJT4ilsP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PaVursrP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893A3C8732
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521142; cv=none; b=CPC7P6PI4mJmdJjn9so9UEp9IdUIFdSvROhBOThyitoVnsY/dyDXYN0a0PrBlznTdYq9u63ZWX4fin2ryg1MsfzeebIYC+zWQRudpgpP76QdxdPZAklmWWTsIZELyF/bdkTDanx7m2T/Mp3utzafPVm/abrmlRfaNPLyIW6lH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521142; c=relaxed/simple;
	bh=LMfVNnrxJJd9gdlMkFmUVQdVmFGd4fGhz8RYFoXw1rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/zCo/O5w8ATQytceLLyyNVyvKnQIdJ+b9C2L2l/FX4CE0wbZOMTtDdux05PB7E0L2rmH7vloJLhQcpmDfoyxIIcY/Z3tuB5CEty2ULQQlc4nBFNAtLLUNBDskCzTEsZydai9IryK8L/ENtW9bs6IxnOqpG5eVzWHc91Zmqi1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XJT4ilsP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PaVursrP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XJT4ilsP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PaVursrP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 276385BD9F;
	Thu, 26 Mar 2026 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774521139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cALTDbWqnpT05rRD1IQCUi5i7gzg3zyuodKvM7itrYE=;
	b=XJT4ilsP49mNDgTZTdyTWWlgVHZmwfWuDPpPL5UADY+rdcV/PG4hjAhLoJRbc/ko6D/0fn
	Osh3kE+WOcTajQcCAKIWt+qomKimd7Cap5tceFoLmYZgzX+hNI32sR9bT7OeVhOGfi2QxC
	NhLShskVXMgOHZJn1iUrQGpw1QfL64k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774521139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cALTDbWqnpT05rRD1IQCUi5i7gzg3zyuodKvM7itrYE=;
	b=PaVursrPWn7NbG2sOrLpTtT97P7uegQkv2TjeCjIIiqEswZQoD3rp679tP3TWyK82bD+sp
	b5U1d05c0cHKc7AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774521139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cALTDbWqnpT05rRD1IQCUi5i7gzg3zyuodKvM7itrYE=;
	b=XJT4ilsP49mNDgTZTdyTWWlgVHZmwfWuDPpPL5UADY+rdcV/PG4hjAhLoJRbc/ko6D/0fn
	Osh3kE+WOcTajQcCAKIWt+qomKimd7Cap5tceFoLmYZgzX+hNI32sR9bT7OeVhOGfi2QxC
	NhLShskVXMgOHZJn1iUrQGpw1QfL64k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774521139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cALTDbWqnpT05rRD1IQCUi5i7gzg3zyuodKvM7itrYE=;
	b=PaVursrPWn7NbG2sOrLpTtT97P7uegQkv2TjeCjIIiqEswZQoD3rp679tP3TWyK82bD+sp
	b5U1d05c0cHKc7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 131BD4A0A3;
	Thu, 26 Mar 2026 10:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 54guBDMLxWnhLwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Mar 2026 10:32:19 +0000
Message-ID: <834dae72-fd21-4458-ba61-48fb36d05c6c@suse.de>
Date: Thu, 26 Mar 2026 11:32:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/6] tls: Purge async_hold in
 tls_decrypt_async_wait()
To: Chuck Lever <cel@kernel.org>, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
 <20260324-tls-read-sock-v5-1-5408befe5774@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260324-tls-read-sock-v5-1-5408befe5774@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-271975-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 9D309333720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 13:53, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The async_hold queue pins encrypted input skbs while
> the AEAD engine references their scatterlist data. Once
> tls_decrypt_async_wait() returns, every AEAD operation
> has completed and the engine no longer references those
> skbs, so they can be freed unconditionally.
> 
> A subsequent patch adds batch async decryption to
> tls_sw_read_sock(), introducing a new call site that
> must drain pending AEAD operations and release held
> skbs. Move __skb_queue_purge(&ctx->async_hold) into
> tls_decrypt_async_wait() so the purge is centralized
> and every caller -- recvmsg's drain path, the -EBUSY
> fallback in tls_do_decryption(), and the new read_sock
> batch path -- releases held skbs on synchronization
> without each site managing the purge independently.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/tls_sw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

