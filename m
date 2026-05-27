Return-Path: <netdev+bounces-292205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMAfE+CzFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:05:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC25E1807
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C97304E0E3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201C3E3D99;
	Wed, 27 May 2026 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gK10SUuT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKdk5VZP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ui+HFhQ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4k+N5o3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE443E3D86
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872350; cv=none; b=s6nNrC+JiQerSyoSkT3LYaWVu8Cc7ykXhp3Ff4izKOQV7DJwuzO19R6y5Wew4LoGPnr5x3n8kTkZsvB5HiCZMKDK+y1lIqh211+RUThlNja7Lh+sXdTBchzK0vPq4avd9oGp6uKKnJR1veuE19240HCpWbKeUlWY7BUB5FgQ2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872350; c=relaxed/simple;
	bh=9OEdkZej6oJw1Wpgq+qPVogAwNJZPrwBbruo86zGjN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLdPrmLGW8NlOP8jRjSkUGCzuQm3Xx9xhAOoQ6uLXWMCu/2MWtaxHlaUJL3TQM6b95HJA2GeyVwxGxPe5WuJFBJQIB1vGXzSkfEMWPrdt00xU0tRz976r7RB6PPZm8g9r+6hCioUnq0VI7ywtkj/DwNH/sv6aY+cpQ/mz07npuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gK10SUuT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sKdk5VZP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ui+HFhQ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4k+N5o3+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F6816B349;
	Wed, 27 May 2026 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779872346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=gK10SUuT6lbqqbS31kyzPsir6baLPihKO+dw2bUO1uW1zCQZF7vlsXNYR5g4w/GHyyi/I2
	ho82JGHgZVCpWu/rHVy5jrbC8we9l3r87Zlrnq6jg9sZUe5S2t01hwFMCvdf4sNRi9DYCW
	ZKRw66x3dp37w6nuuo8MgTVD5PGNhdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779872346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=sKdk5VZPACSXDaj7nPx0r8lqAbnQGrrKTcVm+fzQ+e0XHrfRMGhWfEwStUOCl6MzwqFXk/
	lg8+D4UrFcSe9UDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ui+HFhQ7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4k+N5o3+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779872345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=Ui+HFhQ7RkndRReirphQRTOzgaHkLCGYn0GN7oCQBLJrWb29im7ZXaGGpvsAxH4AGWwBqo
	lFHp3BBBKEYYzzS/gX0HxLq2vqlI0HzkFsPGnDJiOH4s2EnVeb+jI97rWPkNxzT62FGmbD
	er/Rl+EDiWHOLqa9f/aXzdy4uq/Iplo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779872345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=977a+qSrvpHRQv2EJ+wo7dGtItpSp2s4oX0PjoYBUxE=;
	b=4k+N5o3+5rEunRDnSyrTGVVKA45ZjrfsLhssYJLJN4pvjt0c2gPw0Lm0pJFO0SeLo1g9S1
	ZpfMZ8Ajv7oX0pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59AED5A74E;
	Wed, 27 May 2026 08:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DNcOFVmyFmpbEgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 08:59:05 +0000
Message-ID: <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
Date: Wed, 27 May 2026 10:59:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
 <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292205-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: B7CC25E1807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 18:51, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> nvmet_tcp_state_change(), a socket callback that runs in BH context,
> can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
> and tls_handshake_cancel().  handshake_req_cancel() acquires
> hn->hn_lock with plain spin_lock().  If a process-context thread on
> the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
> the lock attempt deadlocks.  This is the only caller that invokes
> tls_handshake_cancel() from BH context; every other consumer calls it
> from process context.
> 
> Deferring the cancel to process context in the NVMe target is not
> straightforward: nvmet_tcp_schedule_release_queue() must call
> tls_handshake_cancel() atomically with its state transition to
> DISCONNECTING.  If the cancel were deferred, the handshake completion
> callback could fire in the window before the cancel runs, observe the
> unexpected state, and return without dropping its kref on the queue.
> Reworking that interlock is considerably more invasive than hardening
> the handshake lock.  Convert all hn->hn_lock acquisitions from
> spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
> never taken with softirqs enabled.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/netlink.c |  4 ++--
>   net/handshake/request.c | 14 +++++++-------
>   net/handshake/tlshd.c   |  2 ++
>   3 files changed, 11 insertions(+), 9 deletions(-)
> 
... and there is always the question whather we should be calling
tls_handshake_cancel() in the first place.
We already call 'tls_handshake_cancel()' from the handshake timeout
handler, and this instance of 'tls_handshake_cancel()' is called
from a socket callback (ie when the soecket is closed or something).
I would have expected that the handshake code cleans up outstanding
requests on socket close already; if so, we can delete the cancel
here.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

