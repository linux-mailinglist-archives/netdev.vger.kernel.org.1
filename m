Return-Path: <netdev+bounces-289313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD9TOVcZDGrrVwUAu9opvQ
	(envelope-from <netdev+bounces-289313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:03:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C35799BD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10AFC30D8AEE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6993B19D9;
	Tue, 19 May 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veWnd5gU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MvxkyHAx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veWnd5gU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MvxkyHAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAC1C3BFC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177352; cv=none; b=Pn1NVlQWwJyJnGp0YXpiMxak63JuAj9To1sW5p1ePgiCotBDX1GWjHujKKU6SoaQI8u/Ll6PH+NtCrakYAWOinelfMExo4hT2SvHcbNzbu3L/3kl0xdV2UbuZxk1TT4HWimE5b9KQtZYlompifcVOiDwd05keJuJb8eEJPfzV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177352; c=relaxed/simple;
	bh=ljnwFwORCer+VUJr1iMq1FU8ABqb7EObT0yQgeghEPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci8eHFvt/tRgkz5x5S1H92Kqi7kaSkGbhKlTagvUIOzbrUh3+dj0zTfCddsH158D4NT6r4A0seRVTqQkQ3ONuvoH6DepGza13WOrB8l+Is5GRWHyGfFkBIe9ckpo318zm71qTe7AigFCLIPX7D99pMk+p+xW+NtQVBF1xbaZI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veWnd5gU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MvxkyHAx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veWnd5gU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MvxkyHAx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E0767BE0;
	Tue, 19 May 2026 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=veWnd5gU+IacJtakxKB5Bq8XPrPBybU2tIE8hkMMKOAdihO+GSBQZR8k3K9L6bnimySqeI
	rxEvYgGBKVJY6usR26pgMDrBMmbl4/k8UulRf7LtlyzMduJjGyJtEY8D8Ge6kpdgj2iqPl
	0j9QpsIoN/hN6ckvB0OwjTWBXeA2xZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=MvxkyHAxTy0I4vLj366t/wr5Xz5/Dv70kNQvK1NcxhrEhCZnNeQIjb0XIgT60eD/9AuL8S
	OmWpaMScjiFfSEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=veWnd5gU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MvxkyHAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=veWnd5gU+IacJtakxKB5Bq8XPrPBybU2tIE8hkMMKOAdihO+GSBQZR8k3K9L6bnimySqeI
	rxEvYgGBKVJY6usR26pgMDrBMmbl4/k8UulRf7LtlyzMduJjGyJtEY8D8Ge6kpdgj2iqPl
	0j9QpsIoN/hN6ckvB0OwjTWBXeA2xZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIuSa4Q4dMultZ8PBSbLMyy9WSo6AwaKdXcHKLDBDC8=;
	b=MvxkyHAxTy0I4vLj366t/wr5Xz5/Dv70kNQvK1NcxhrEhCZnNeQIjb0XIgT60eD/9AuL8S
	OmWpaMScjiFfSEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19245593A8;
	Tue, 19 May 2026 07:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J7w8BYUXDGrLagAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:55:49 +0000
Message-ID: <76f6bb7c-c0b4-4dfc-b101-13d0bb7d7f0e@suse.de>
Date: Tue, 19 May 2026 09:55:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/7] net/handshake: Take a long-lived file reference
 at submit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-4-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-4-4bbcb7e62fda@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-289313-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: EE0C35799BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_nl_accept_doit() needs the file pointer backing
> req->hr_sk->sk_socket to survive the window between
> handshake_req_next() and the subsequent FD_PREPARE() and get_file().
> The submit-side sock_hold() does not provide that. sk_refcnt keeps
> struct sock alive, but struct socket is owned by sock->file: when
> the consumer fputs the last file reference, sock_release() tears
> the socket down regardless of any sock_hold.
> 
> Prepare for a fix by adding an hr_file pointer to struct
> handshake_req and acquiring an explicit reference on sock->file
> during handshake_req_submit(). Release the reference on the
> completion-bit-winning path of handshake_complete() and
> handshake_req_cancel(), and on the submit error paths that destroy
> the request before it has been published.
> 
> The accept-side dereferences are not yet retargeted; that change
> comes in the next patch.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake.h |  2 ++
>   net/handshake/netlink.c   |  6 ------
>   net/handshake/request.c   | 27 ++++++++++++++++++++++++++-
>   3 files changed, 28 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

