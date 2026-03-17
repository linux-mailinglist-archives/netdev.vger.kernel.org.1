Return-Path: <netdev+bounces-268458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMx1F6/9uGl/mwEAu9opvQ
	(envelope-from <netdev+bounces-268458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7212A495D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA1F300D691
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7B38657C;
	Tue, 17 Mar 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PUuD0vWg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8siJ5UFh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PUuD0vWg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8siJ5UFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E436212C
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731221; cv=none; b=R66GyFa0IAfzQSKf4Ymf/iLZsdfmA9gissD8sFtZAoQHGRym7w8VCRmI9DvaQKOmBpDoKIRuBaXeZIqyKez6fA1wwO9Jb3GagijQOeufkHnL6GyuBNVAv1lVIwwJvGt8rAC2BrE+1YfSrPcsTWMB28jvcEV+ry0Y/zg8t/IVrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731221; c=relaxed/simple;
	bh=NRCEZLGQ+Z77WXyGqbTpem15UYUPrRM/gfEOD3drGIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlQhq3uYurl5m/TRJ53fFKJpv5cs+ZlaQykNOrqhgqtuqWhpJtepPLz4HSnaCUH8Wz5M+r7nspvx6RZV4CQf4emUWTYHvlMCdSuFZ6ffvJKdTCb1HatPJi3ib6kwIVjyK5gVJKINaLSJyWoPpTBpB+SV0N8EWRMfIsWsh7R5Ed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PUuD0vWg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8siJ5UFh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PUuD0vWg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8siJ5UFh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B67374D240;
	Tue, 17 Mar 2026 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773731218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfIwQELYYHRkpz+OoqDN5zA9ftR0qFSiLQ58KKO02wA=;
	b=PUuD0vWgdLGoIZ3QsbzGOVwpc6JUAYx5rj0Rl9JagzmOmd9p6ZtKVoWmIY/1GwXZfVaT/7
	/HHsVj+d0ks6/qEc5bLc2Azp6jRo+iOYdSPVGS7yr/e09myUXmkf1fUrXLbNRw4L/mLe2N
	Kgtc4ystuDjOzLb6lJjWQ/GloPYc+Qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773731218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfIwQELYYHRkpz+OoqDN5zA9ftR0qFSiLQ58KKO02wA=;
	b=8siJ5UFh1Ro7VrQHyuHh9qHys07KKuzmlPlT8ZqvawJzkKBV6KatytHagT/EHkLyIZNMxN
	zAaNtougDFS7/2BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773731218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfIwQELYYHRkpz+OoqDN5zA9ftR0qFSiLQ58KKO02wA=;
	b=PUuD0vWgdLGoIZ3QsbzGOVwpc6JUAYx5rj0Rl9JagzmOmd9p6ZtKVoWmIY/1GwXZfVaT/7
	/HHsVj+d0ks6/qEc5bLc2Azp6jRo+iOYdSPVGS7yr/e09myUXmkf1fUrXLbNRw4L/mLe2N
	Kgtc4ystuDjOzLb6lJjWQ/GloPYc+Qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773731218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfIwQELYYHRkpz+OoqDN5zA9ftR0qFSiLQ58KKO02wA=;
	b=8siJ5UFh1Ro7VrQHyuHh9qHys07KKuzmlPlT8ZqvawJzkKBV6KatytHagT/EHkLyIZNMxN
	zAaNtougDFS7/2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 801A34273B;
	Tue, 17 Mar 2026 07:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lM7gHZL9uGk/DwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Mar 2026 07:06:58 +0000
Message-ID: <4d954145-4bff-4809-ba11-6bfafcc97e5b@suse.de>
Date: Tue, 17 Mar 2026 08:06:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] tls: Factor tls_rx_decrypt_record() helper
To: Sabrina Dubroca <sd@queasysnail.net>, Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
References: <20260312014804.5083-1-cel@kernel.org>
 <20260312014804.5083-3-cel@kernel.org> <abfZVw216f_YU-9e@krikkit>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <abfZVw216f_YU-9e@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-268458-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: BB7212A495D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:20, Sabrina Dubroca wrote:
> 2026-03-11, 21:47:58 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> recvmsg, read_sock, and splice_read each open-code the
>> same sequence: zero-initialize the decrypt arguments, call
>> tls_rx_one_record(), and abort the connection on failure.
>>
>> Extract tls_rx_decrypt_record() so each receive path shares
>> a single decrypt-and-abort primitive. Each call site still
>> initializes darg.inargs separately, since recvmsg sets zc
>> and async between the memset and the decrypt call.
> 
> Is there any reason to keep tls_rx_one_record()? You're replacing all
> existing callers, and not introducing new users in this series. Seems
> like what you want is just move the tls_err_abort() into
> tls_rx_one_record().
> 
> (I'm not convinced that "abort the connection on every error (decrypt
> fail or ENOMEM or whatever)" is right, but that's a separate question)
> 
It certainly is the sane option. Any error should be considered a
transmission error, so something has happened during transmission.
As the main point of TLS is transmission security, we cannot assume
anything (like being able to pick up the existing connection again),
and have to drop the connection to re-establish the security context.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

