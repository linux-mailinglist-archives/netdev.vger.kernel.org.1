Return-Path: <netdev+bounces-289315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FvaKG0aDGrrVwUAu9opvQ
	(envelope-from <netdev+bounces-289315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F1579AEC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E990B304BE71
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE43DF019;
	Tue, 19 May 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dWgXVszO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4U7yZB6/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eQXV43ea";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sphRMA2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794D3DEAD2
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177677; cv=none; b=WVXsB+aS4KyMZ5G7bO2KBqgX2trAv7//NE1mx1olqwWCmcmHlB2B9lIq8TnAK+EGGFlI/8efDCHDtw4VpFFITmgtcxgYF8IAO1rwdZf3AouU/xidtbx0PvwR7HXIm1ujfiG3HbMV9usOpSwIy2X6C6rXm+l68DUkYlwbSws4NxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177677; c=relaxed/simple;
	bh=RXoo0DCg9qN4h4N9PU5nU0OKNRkR4J7RgaDXvK7+ZfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doxUJnMYXCcIguuP9B22EkBoXA7lGfTERq32SI7SZ3FJA3YQWvfc0ItUcvlvxpVE9JyFvysOpWlnyCufYC8Hdqe/wLXGGah3Bpbaj0rkeXZ0N9yG8myH4ce+l0dKG6XZa11cTgpzisNn7GWXEQPkG1BRYb4xvkeOAiu5Q9I8ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dWgXVszO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4U7yZB6/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eQXV43ea; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sphRMA2L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 641C566DE0;
	Tue, 19 May 2026 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=dWgXVszOHSvTAxL1R6XhNnzAMF45MeoGSNYRk8y3Q36K/evpsAV6Q2lKNcZ/pF4N2LMgvA
	DY3y/HU4nTtxGZSOS2wxryKPj0xGEArw0CYElh60jcHkQ1Oegg3H8YCh7HoLDrtIlvuojR
	pqxjM7C2BSMJzgZuoDi8HCqcMGMVBSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=4U7yZB6/A3ReGNvSgiWPoMCuojXWYWhZV65WBrbGFj+rVAybJDMY18Oi5BSnPftt+kuPaG
	xgZFnbZ/ReOWhIAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eQXV43ea;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sphRMA2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=eQXV43eaHNXfHxZvBEiZzBfUimYlNoFtK0FIMsSbwRV9n9TVNLYnQYnnFQADElbYlRXQPh
	p22gD8Cv/ivhNgFScbbcMKzvdKOy7CKx/dG5qD90UIq+vY+6ISTO43kc9CM+Ki3Uf+ImK+
	/DnJNrAx+SGFE1/GiBxVSscL/UZJLBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+tkiZkbFahlsQ3PpXuWXmKySLsE4NqqO7zpi111kOU=;
	b=sphRMA2L+WfjInq+EeM9tT+hMSMHvphQ0aASHDLqICExeREbsQ+U3p81gniIrzkdKZq5/1
	sL9oTJAe4ETcXmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B494593A8;
	Tue, 19 May 2026 08:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id egXLDcgYDGoncQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:01:12 +0000
Message-ID: <8fecedbf-1fdf-49ad-a7bf-f2ef2c68906c@suse.de>
Date: Tue, 19 May 2026 10:01:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/7] net/handshake: Close the submit-side sock_hold
 race
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-6-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289315-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 1B9F1579AEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_req_submit() publishes the request via
> handshake_req_hash_add() and __add_pending_locked(), drops
> hn_lock, and calls handshake_genl_notify() (which can sleep)
> before taking sock_hold() on req->hr_sk. A fast tlshd ACCEPT
> followed by DONE can drive handshake_complete()'s sock_put()
> into the window between the spin_unlock and the late
> sock_hold(); on a system where the consumer's fd held the
> only sk reference, the late sock_hold() then operates on an
> sk whose refcount has reached zero.
> 
> The preceding two patches install an explicit file reference
> on struct handshake_req. That file pins sock->file, which
> pins the embedded struct socket, which defers inet_release()'s
> sock_put(). As long as hr_file is held, sk cannot reach refcount
> zero from the consumer side, and the submit-side sock_hold()
> with its matching sock_put() calls in handshake_complete() and
> handshake_req_cancel() is now redundant.
> 
> Drop all three. Submit's pinning is strictly the file reference
> acquired earlier in the function, and the lifetime story is
> contained in a single get_file()/fput() pair.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/request.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

