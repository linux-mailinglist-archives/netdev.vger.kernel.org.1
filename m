Return-Path: <netdev+bounces-274986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHhKGk6bz2mLxwYAu9opvQ
	(envelope-from <netdev+bounces-274986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D966B39367D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE005301601B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F3308F36;
	Fri,  3 Apr 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n6UYQNWp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgyIcM96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n6UYQNWp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgyIcM96"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253F37BE78
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213387; cv=none; b=PEaz8k+54U5OdSiRKYD3Yi0bcXbMXoCBez/d8WuE6SAFKSZ2cbSQ2kfBV/SpXszz4ZtQf7t40NaAsCA/dWdzMjD9lcgT8cA7KQkV2RGWa+zAEgW2vaeRKvJR1lbjO9uG3cAlwKBK9MMoxB8j40Y4mtvMmMpvu0JylxqGGZmgpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213387; c=relaxed/simple;
	bh=Au4hGnCTtNWKNCccnUCPnnL4HfR/9Y/mMQNSs9TdLw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1AL94ihNGTR0gdRZB9Sxi4sVojT5Ix0SeU1fqUpXKoY8L/cnRlOk3CA6VjdmXInQcgcIiRU6AEoWewEWC9q7B5nSZZ8l7uNuCcOXeZzAmjpJIzQuZhkfjWGXJYocEgFxx3/Kws3DcuncHmoZOW7w/VNrhgmsP2DGMm+ravdS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n6UYQNWp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgyIcM96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n6UYQNWp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgyIcM96; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A84B4D298;
	Fri,  3 Apr 2026 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775213379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1O0JOVrqlSZv9tlF00U+ZDpPRIp1KvUkeuwrsjBmpU=;
	b=n6UYQNWphKRHRqXdpkIs34tpRWGjVnL1C7c+xzkuL3quMaKD/XsLqSVohCOMxRHm2DjFhL
	GalBveP5lLYZPGbbhEKpTfjgxvhDRgU+RJVJEJYbYj1GwIjcuYW0GRbM8tScmnRX9oBlWL
	/eVO/ZKEE6YXh6+D8gsihZknzf4w9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775213379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1O0JOVrqlSZv9tlF00U+ZDpPRIp1KvUkeuwrsjBmpU=;
	b=rgyIcM96IywCWKy2qZvAjzhOx6DvQSCoeF1nKJyFWlqoXLiy3bpr5yOT74OWvQRuDH8SVO
	sKzbjl4L/5ZiZ5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n6UYQNWp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rgyIcM96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775213379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1O0JOVrqlSZv9tlF00U+ZDpPRIp1KvUkeuwrsjBmpU=;
	b=n6UYQNWphKRHRqXdpkIs34tpRWGjVnL1C7c+xzkuL3quMaKD/XsLqSVohCOMxRHm2DjFhL
	GalBveP5lLYZPGbbhEKpTfjgxvhDRgU+RJVJEJYbYj1GwIjcuYW0GRbM8tScmnRX9oBlWL
	/eVO/ZKEE6YXh6+D8gsihZknzf4w9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775213379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1O0JOVrqlSZv9tlF00U+ZDpPRIp1KvUkeuwrsjBmpU=;
	b=rgyIcM96IywCWKy2qZvAjzhOx6DvQSCoeF1nKJyFWlqoXLiy3bpr5yOT74OWvQRuDH8SVO
	sKzbjl4L/5ZiZ5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4654A0A6;
	Fri,  3 Apr 2026 10:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9cvsJkKbz2meCwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 03 Apr 2026 10:49:38 +0000
Message-ID: <4677d96d-3509-4bf3-855d-b3e0bd956722@suse.de>
Date: Fri, 3 Apr 2026 12:49:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet: remove leftover EXPORT_SYMBOL()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260402174430.2462800-1-edumazet@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260402174430.2462800-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-274986-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D966B39367D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 7:44 PM, Eric Dumazet wrote:
> IPv6 is no longer a module, we no longer need to export these symbols.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/ipv4/icmp.c        |  4 ----
>   net/ipv4/ipmr_base.c   | 13 -------------
>   net/ipv4/udp_offload.c |  4 ----
>   3 files changed, 21 deletions(-)
> 
Thank you and sorry for missing this.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

