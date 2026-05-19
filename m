Return-Path: <netdev+bounces-289321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGDrJzsbDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19544579BAB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A78301A7E1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C13DFC67;
	Tue, 19 May 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EtBeuN6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A6ShaazL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vB4ii3sw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vk7m+Dco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6C3DA7CD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177799; cv=none; b=j4tN7qof0xZVxF4rfEMq0Hry/D8u2MyvqclXFLgMmNKLU+1+XUiMBHq5E4slEoWJMWCUu8IOC2B1L8CHalx/6e7qTbEBF/mcVGNkf78yaRnMOw/JGgtYMZWVj73xeapa08XVLHPnTeN9DHA1zijoSEpOjbzSJjwl7tCRt0pH4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177799; c=relaxed/simple;
	bh=ktgZx5lF0h915wSIOcwByhmVMLhsCSbs+u1kHLKNjdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB74kewWJ4cQXnaH6TtcUIW5HcQXUhLtFjtSgZUeOS0jxGk/oxKjskZ3UTOiVutgDNK9hVdHADZgyR13h91KDdtNM3ImCu/LpkXxG64IS018FBYB/zyLzdMe67gOoO8f0lLIU1kAgwIKgP2Yg1HrxLzEw1QtN1AZ13D4X+WVzF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EtBeuN6s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A6ShaazL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vB4ii3sw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vk7m+Dco; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74A4067014;
	Tue, 19 May 2026 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=EtBeuN6sMsZjzFbbMK2RywnsywoYKYoBaSV+CK0S3E0+HPQyLA3P3Od3DFC6p+V0/iT2Bh
	ac/+9P79e7vHqvmkP/XyYhTqSx6+nemIowzwVjBYB2JJu9n/mP3PxMSVH5RJ6sAHI/ouNv
	sW/9GOI3/LgQnzN+Xa0Zk0MgPaJN8FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=A6ShaazLO+c6uvEMD7VD5cBoq66pPid8Dj0hEUESZK+R5Ej2ASB5NOZdvW83nti3kLwa8u
	MoZGoSgn2UM/3RBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vB4ii3sw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vk7m+Dco
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=vB4ii3sw2fDcdVt8rtp+d+33zCoZOZaB+VjTBSlTHPMe1jLBZ/7Yf2xJsgqnw6PXFq0+km
	Py5Y8TcaGHa+xqSabmAsVyipMjXSYC81uSr1ImR1AqN2nv6UX8dh4l/gK4hGi2O7rMjskE
	WV/jSOWwZ6Eqz9OHIeGB48jL3MEcNNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0q9lwj3nnlakW5KTMI7fuN3USfvSzP05/I1UZPbsbVk=;
	b=vk7m+DcomvzmFGfUK7f6x/OzezLyzZR15fbTFl5uG/Fn4JRr5922wm9Qy16tnj/KQtKLOO
	7+Vzb+cGhWb49ZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE70593A8;
	Tue, 19 May 2026 08:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bju+Ej0ZDGrFcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:03:09 +0000
Message-ID: <773a2f6f-5e58-4929-ba7b-d91042475e4f@suse.de>
Date: Tue, 19 May 2026 10:03:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/7] net/handshake: Verify file-reference balance in
 submit paths
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-7-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-7-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289321-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 19544579BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The new file-reference contract on struct handshake_req is silently
> breakable: a missing get_file() at submit or a missing fput() on an
> error path leaves the file leaked but does not crash the test, so
> the existing absence-of-crash checks pass either way.
> 
> Snapshot file_count(filp) before each handshake_req_submit() in
> the submit-success, EAGAIN, EBUSY, and cancel tests, and assert
> the expected balance after submit and again after cancel. The
> already-completed cancel test also asserts the post-complete
> balance, which pins down that handshake_complete() drops the
> reference and that the subsequent cancel does not double-fput.
> The destroy test gets the same treatment before __fput_sync(),
> which double-checks that cancel's fput() ran and the only
> remaining reference is the one sock_alloc_file() established.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
One wonders why this is not part of the kunit test suite.
But that's probably neither here nor there.

So:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

