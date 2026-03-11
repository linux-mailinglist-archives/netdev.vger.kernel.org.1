Return-Path: <netdev+bounces-266726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFJ3IV6lsWn4EAAAu9opvQ
	(envelope-from <netdev+bounces-266726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:24:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48584267FBB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A6B33012B62
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C4F3148D9;
	Wed, 11 Mar 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OGGdr7Sb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pgEi3Cr3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OGGdr7Sb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pgEi3Cr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26433CEA9
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249881; cv=none; b=nnlua/Aklec03ly3Mh76EZe2tzyC2XTGWIJwjPYUluAeCqEOcu7Mj2V2ott4fTCX9Zmsuzo4fyft/0KoVIp1tOYnTsmFBvR09D3JCZIGyojRIIvZD1v51kP41BcnQKwMHBrbeavs+kMMZEyqO3neU52HVuGNYIMbcsnY4o1r2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249881; c=relaxed/simple;
	bh=TSRbPisBjlJ8TPFgxRbcN7Z0vch8gpyxlAjB71W7V0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuw0HNzzbuoExbfsF2S775dnyJDt407HEHDFKwwRsMDMGThBi4o8MLXksD1CQqM8pxfS0dw84CSJifRnIE+XhtAU8HuU7qboLkBm0oxMTmyAw3wmTqWSbfOKiGCxWE6Y2cDKWtFKKx3EDyWeH/HeqR7aJomiVFWYHdaSXPmDgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OGGdr7Sb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pgEi3Cr3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OGGdr7Sb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pgEi3Cr3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CC865BCC8;
	Wed, 11 Mar 2026 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773249878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsXSBSsWFackrErRFk1u9TiV0UR1/knFbBI/BSAoNHI=;
	b=OGGdr7SbmX4SU3OqP0IJPpDOm4K1YQva8rm5vcvuY5C+P5i+b9yYaWhHVr4Ck6ZG9scijB
	naolFBMYdDtcRVKxnZ9q1LMWF3CUJuB82966AWLfNNsRvkBlTJzseJ/iwm7+JRNrXBtvWK
	3u8UvqA8vteQB8ReP+mN1lkEHEHyuuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773249878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsXSBSsWFackrErRFk1u9TiV0UR1/knFbBI/BSAoNHI=;
	b=pgEi3Cr3jj3JS+PnDVx5TrgSRyve+jH097t8Ec3aXO/JGJ7FgF+hLGYMyQREVVQRmX+O80
	c6tueoLJqzQIsADA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773249878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsXSBSsWFackrErRFk1u9TiV0UR1/knFbBI/BSAoNHI=;
	b=OGGdr7SbmX4SU3OqP0IJPpDOm4K1YQva8rm5vcvuY5C+P5i+b9yYaWhHVr4Ck6ZG9scijB
	naolFBMYdDtcRVKxnZ9q1LMWF3CUJuB82966AWLfNNsRvkBlTJzseJ/iwm7+JRNrXBtvWK
	3u8UvqA8vteQB8ReP+mN1lkEHEHyuuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773249878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsXSBSsWFackrErRFk1u9TiV0UR1/knFbBI/BSAoNHI=;
	b=pgEi3Cr3jj3JS+PnDVx5TrgSRyve+jH097t8Ec3aXO/JGJ7FgF+hLGYMyQREVVQRmX+O80
	c6tueoLJqzQIsADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C28513FB23;
	Wed, 11 Mar 2026 17:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8llILlWlsWn6UwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 11 Mar 2026 17:24:37 +0000
Message-ID: <a3dbc990-e6e8-4b0a-95ed-64004ce82a8a@suse.de>
Date: Wed, 11 Mar 2026 18:24:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] tls: Factor tls_decrypt_async_drain() from recvmsg
To: Chuck Lever <cel@kernel.org>, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260311001952.57059-1-cel@kernel.org>
 <20260311001952.57059-2-cel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260311001952.57059-2-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-266726-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 48584267FBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 01:19, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The recvmsg path pairs tls_decrypt_async_wait() with
> __skb_queue_purge(&ctx->async_hold). Bundling the two into
> tls_decrypt_async_drain() gives later patches a single call for
> async teardown.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/tls_sw.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

