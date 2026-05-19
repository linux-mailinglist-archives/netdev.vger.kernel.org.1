Return-Path: <netdev+bounces-289310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAm+EX4WDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF95796DC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FD553006904
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB853DCD91;
	Tue, 19 May 2026 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BT9lY7Xa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RRGWgfTf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FLl1CWGL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C/hLsOIX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF83DCDB7
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176832; cv=none; b=Ins4ew004Ec9OkmsiHt3OpVoG6XxXYM/b8toGQGkWznJs9NvpzXdECRZJaHEm3KwowoiqUC5nL4Y1yCJIARh4PhNqUGqO7vNpNGi1y5+oLjw5E6fiovgDybzbXXOhxVKDpuolhQUHr/VnTCz3Oomf/YsmThmVjq2edDwODRuThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176832; c=relaxed/simple;
	bh=NxTM2Gwr6riTFUWyA008FzU36mkupnoPxwH8HNyxZxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbR4+kVEXX3QuKIMpOVvA2+ElwzzfanHWqlSWe8xpOAk14lri6TKStimNbvk8dq3Eu8ozkTR3wdqHtxkKToE0Bs/Ex+Fg5vl72/pIG8d3DOJPi8NScYNKlqUleXRElt0tJ5MhVtRtI/0pww6M1veWiqr3HgNjIP7bYL4/OI8464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BT9lY7Xa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RRGWgfTf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FLl1CWGL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C/hLsOIX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D340E6A87E;
	Tue, 19 May 2026 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=BT9lY7XaMOXE2QxpzLbKfmE8iPaN7bVwCbACJMORW5z+HFegvmfDjvReIpa9SdzG4okcXM
	DpsbMZkRm1JIMS7Vf0bT0liPWJsmoX2aBVjDtr4l3qG/ds1BDzABCSL8Yq9hl7PVtMWcPx
	iMvSTwKomJFhwKEoorF8jvIBJnnMDVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=RRGWgfTfhEgSJY97glMUtN3oKsCR8zA5oPxRJfKIVjZaTCLaqip834AKqwaQXwVYUoxWg5
	GqakPJf2VGoq6rAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FLl1CWGL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="C/hLsOIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=FLl1CWGLJJeMWjwK6hzZcNkXwjTlCsMUQL7PrrjIiYrPbIkaAKKsqA76KBA4bqnMdOVI29
	ANhcF6QH9vXkUmnmDYs5ATpqtj+zTy+zTnnRzTXB5qk3eGtmvedDOxUIxaQEXmgsDVAEZO
	wo8CarcJ0KULU7bUMDtG9eA7ShimTAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs9k8KdLzc/e52jeBD+E/kRY12OZR57QS+tDyPt1+6s=;
	b=C/hLsOIXoKkTkYGnRXAP+oXTXT1l4fpx31Oc/AlZURDa3cObHMPtf3PeTdn/xuxyl2Kmrr
	hjY8GyHfBsOWsTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FCB593A8;
	Tue, 19 May 2026 07:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IF7vJHgVDGpMYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:47:04 +0000
Message-ID: <794447b7-ae61-4524-894b-45f05e5b5eec@suse.de>
Date: Tue, 19 May 2026 09:47:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/7] net/handshake: Pass negative errno through
 handshake_complete()
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-3-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289310-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 4AAF95796DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_complete() declares status as unsigned int and
> tls_handshake_done() negates that value (-status) before handing
> it to the TLS consumer. Consumers match on negative errno
> constants -- xs_tls_handshake_done() has
> 
> 	switch (status) {
> 	case 0:
> 	case -EACCES:
> 	case -ETIMEDOUT:
> 		lower_transport->xprt_err = status;
> 		break;
> 	default:
> 		lower_transport->xprt_err = -EACCES;
> 	}
> 
> so the API as designed expects callers to pass positive errno
> values that the tlshd shim then negates.
> 
> Three internal callers in handshake_nl_accept_doit(), the
> net-exit drain, and a kunit test follow kernel convention and
> pass negative errnos -- -EIO, -ETIMEDOUT, -ETIMEDOUT. The
> implicit conversion to unsigned int turns -ETIMEDOUT into
> 0xFFFFFF92; the subsequent -status in tls_handshake_done()
> wraps back to 110, the consumer's switch falls through, and
> the xprt reports -EACCES on what should be -ETIMEDOUT or -EIO.
> 
> Fix the API rather than the call sites. The natural kernel
> convention is negative errno in, negative errno out. Change
> handshake_complete() and hp_done to take int status, drop the
> negation in tls_handshake_done(), and negate once in
> handshake_nl_done_doit() where status arrives from the wire
> as an unsigned netlink attribute. The three internal callers
> were already correct under that convention and need no change.
> 
> At the same wire boundary, clamp values above MAX_ERRNO to the
> default -EIO. A well-behaved tlshd never sends such a value,
> but negating an unconstrained u32 invokes signed-integer
> overflow when the high bit is set, which UBSAN would report.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c | 2 +-
>   net/handshake/handshake.h      | 4 ++--
>   net/handshake/netlink.c        | 9 +++++++--
>   net/handshake/request.c        | 2 +-
>   net/handshake/tlshd.c          | 4 ++--
>   5 files changed, 13 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannex
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

