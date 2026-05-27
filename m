Return-Path: <netdev+bounces-292222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHeIDDq+FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BADD5E21C1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB543008214
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969A33FE26;
	Wed, 27 May 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XaKYu9z0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eQq0LEOe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XaKYu9z0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eQq0LEOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A72236F2
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875343; cv=none; b=u9ko4Kcwdv7sPwsH4tChD/3qwgzISdk/piTqTzVFCg+r5MMUsUOx/D/IfavPPMixoKE1N9p9jQk3anS5aJu8pohI5MVK3cYb6FdLOET1kl9tqwY2oKqZNvx58wLANxfXvHtw4LFESV6g1mwGmKHF/3o4fQlmYcJY15hyUZd5PNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875343; c=relaxed/simple;
	bh=DA68zz1aR0f04tI/zt35rwbvJ3ARxlpW3iIbrY0Xwhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2s2n+FgtvuOk5k/dtaGCHR3K8OcGxnJaAGaApUDA0ppzRve7J0kQ/OJJowJaGIlLmNA6KzFhmnkHmhgNuUeNawrFDGQRfyqy88vnYMtnRWwaJJGGfnxnNaNLSmPRTBOFi7RHK3t452LL1U+YOY97J8ul5zVZVm5oOCOl5himEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XaKYu9z0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eQq0LEOe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XaKYu9z0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eQq0LEOe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FF4F6A87C;
	Wed, 27 May 2026 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA0Z5lg0Y048+dDZG9woYw9lX9oN508Zv868mII7sQQ=;
	b=XaKYu9z0bzfDtEhAxT+IxfboJcIbfumaspQketaD482+05F9iYDrfacalgiX4b0N/81tjn
	BLeSHalwiMDehgPb3FpiOYCIEpORv/Z4NtoTw5zRIvJ9W6YIJlNge6H8HR9f/CUjNt3/4A
	+c/q0INAt4gPz5/C/AELIEdHMQnenrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA0Z5lg0Y048+dDZG9woYw9lX9oN508Zv868mII7sQQ=;
	b=eQq0LEOeJXw9RUseK6sW7mlIMtfGj9QMjUTzB1/ApWZ2dhzdeeIPeiGlopDUlau8JI0CI3
	4tjJffZdq+ztheAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XaKYu9z0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eQq0LEOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA0Z5lg0Y048+dDZG9woYw9lX9oN508Zv868mII7sQQ=;
	b=XaKYu9z0bzfDtEhAxT+IxfboJcIbfumaspQketaD482+05F9iYDrfacalgiX4b0N/81tjn
	BLeSHalwiMDehgPb3FpiOYCIEpORv/Z4NtoTw5zRIvJ9W6YIJlNge6H8HR9f/CUjNt3/4A
	+c/q0INAt4gPz5/C/AELIEdHMQnenrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iA0Z5lg0Y048+dDZG9woYw9lX9oN508Zv868mII7sQQ=;
	b=eQq0LEOeJXw9RUseK6sW7mlIMtfGj9QMjUTzB1/ApWZ2dhzdeeIPeiGlopDUlau8JI0CI3
	4tjJffZdq+ztheAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B7595A780;
	Wed, 27 May 2026 09:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +48PBgy+FmqwRAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 09:49:00 +0000
Message-ID: <c3ec9726-6d51-4aad-b652-f284c7f03941@suse.de>
Date: Wed, 27 May 2026 11:48:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/6] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
To: Chuck Lever <cel@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-2-244fe1dc4abd@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260526-tls-read-sock-v11-2-244fe1dc4abd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	TAGGED_FROM(0.00)[bounces-292222-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 7BADD5E21C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 16:21, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The tls_sw_read_sock() loop releases the current skb whether
> read_actor() consumed the full record or only a prefix. When
> the actor takes only part of the record and leaves desc->count
> non-zero, the remainder is lost: skb is neither requeued nor
> freed, and the next iteration overwrites it during dequeue or
> tls_rx_rec_wait().
> 
> No mainline consumer reaches this path today. The only
> in-tree TLS read_sock user is nvme/tcp, whose actor
> nvme_tcp_recv_skb() loops until the input length is exhausted
> and returns either the full length or a negative error.
> 
> The path becomes reachable with the upcoming NFSD svcsock
> receive built on read_sock_cmsg. Its data actor,
> svc_tcp_recv_actor(), parses an RPC fragment stream
> incrementally and returns at fragment boundaries. When a TLS
> record carries the tail of one RPC fragment plus the head of
> the next, the actor returns fewer bytes than offered while
> leaving desc->count non-zero, and without re-presentation the
> trailing fragment header vanishes.
> 
> __tcp_read_sock() handles the equivalent case for plain TCP
> by leaving the unread bytes available for the next iteration
> to re-present, via sequence-number re-lookup. Adopt the same
> loop-level behavior: when read_actor() consumes only part of
> the record, update rxm->offset and rxm->full_len and requeue
> the skb to the head of rx_list so the next iteration
> re-presents the unread bytes. Switch the open-ended for-loop
> to "while (desc->count)" so the partial- and full-consume
> arms share a single exit check and read_actor() is not
> re-invoked once desc->count is exhausted.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/tls_sw.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

