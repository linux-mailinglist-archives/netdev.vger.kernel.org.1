Return-Path: <netdev+bounces-277331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yODzJjHW2GmuiwgAu9opvQ
	(envelope-from <netdev+bounces-277331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C23D5DAA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAB95301A53F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6573A8736;
	Fri, 10 Apr 2026 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfsd09PS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nbPxXTMr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfsd09PS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nbPxXTMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08D3AD511
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818285; cv=none; b=RdmfTSJK9eVsoeaKKfQkUDGVqmdFTlKlteJaYKDk6Bo480OhURAqUSvHSaEoSfRFl6ScOkU/2oSa2FFIWFc8PgmBJy2lpYlHngaGbmfXrU4Bm2PMLUHwetkHupE432gSsf6nDpIaY3gid4C0HF5fBkvT8f1G2VMBdO63YeeW3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818285; c=relaxed/simple;
	bh=51Jg5TFmmgVGsK9fhcPQhce+vfBf9j8iZDL1kekV5Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAqladJsExZpArAw4V4sYUPvdW7nqO3muX2aPtvGjlIAbkep553+UC4Lr8d3UnstJwv1sSfWBvWSojyT4lrdg1J53LmCjwrVLlPmnm7NTN4mud69bc55WdeVjkHo5rw397Ld0HjKJUCUetg8FsJa8hiVY6NnWmHqWWUnwmqxg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfsd09PS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nbPxXTMr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfsd09PS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nbPxXTMr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DEBE6A7EC;
	Fri, 10 Apr 2026 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775818274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhiSXq1+cbgG13O4ZNbPZLqfuVp5wl2Ou9EzkFVPaN8=;
	b=lfsd09PSYP6GNFejzRVcxoc3uC2vkedtADIfZ9/3tSTCSLSvhcuVIceHHkYZ3py/k5W0NW
	az4dmrADqTdO/BPkUizqJok13/uhaiZoaAtgVcpaaDbiAGWsaJBD4qkrSX+6QXI5b413ie
	ESjkdNWUQWpCQKCLgRPl6QmzDaCnB8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775818274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhiSXq1+cbgG13O4ZNbPZLqfuVp5wl2Ou9EzkFVPaN8=;
	b=nbPxXTMrYMubJOIwzEsrzWQMluSZeBrkimwEtdL5Q2ngunqqGbz2toqO0du1zqFW/C5s+8
	zkw5EsXcVBF0rOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775818274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhiSXq1+cbgG13O4ZNbPZLqfuVp5wl2Ou9EzkFVPaN8=;
	b=lfsd09PSYP6GNFejzRVcxoc3uC2vkedtADIfZ9/3tSTCSLSvhcuVIceHHkYZ3py/k5W0NW
	az4dmrADqTdO/BPkUizqJok13/uhaiZoaAtgVcpaaDbiAGWsaJBD4qkrSX+6QXI5b413ie
	ESjkdNWUQWpCQKCLgRPl6QmzDaCnB8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775818274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhiSXq1+cbgG13O4ZNbPZLqfuVp5wl2Ou9EzkFVPaN8=;
	b=nbPxXTMrYMubJOIwzEsrzWQMluSZeBrkimwEtdL5Q2ngunqqGbz2toqO0du1zqFW/C5s+8
	zkw5EsXcVBF0rOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E7C4A0B2;
	Fri, 10 Apr 2026 10:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4mkAOyHW2GlWEAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 10 Apr 2026 10:51:13 +0000
Message-ID: <00cba68f-2e37-4ad9-872b-cc41a113de00@suse.de>
Date: Fri, 10 Apr 2026 12:51:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
To: Dan Carpenter <error27@gmail.com>, Yiqi Sun <sunyiqixm@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <adjOCdCW1EpPl8lf@stanley.mountain>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <adjOCdCW1EpPl8lf@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 132C23D5DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 12:16 PM, Dan Carpenter wrote:
> Hello Yiqi Sun,
> 
> Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
> icmp_build_probe()") from Apr 2, 2026 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	net/ipv4/icmp.c:1351 icmp_build_probe()
> 	warn: 'dev' is not an error pointer
> 
> net/ipv4/icmp.c
>      1341 #if IS_ENABLED(CONFIG_IPV6)
>      1342                 case ICMP_AFI_IP6:
>      1343                         if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
>      1344                                 goto send_mal_query;
>      1345                         dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
>      1346
>      1347                         /*
>      1348                          * If IPv6 identifier lookup is unavailable, silently
>      1349                          * discard the request instead of misreporting NO_IF.
>      1350                          */
> --> 1351                         if (IS_ERR(dev))
>      1352                                 return false;
> 
> It looks like there were two patches that went in around the same
> time.  Commit fde29fd93493 ("ipv4: icmp: fix null-ptr-deref in
> icmp_build_probe()") updated the checking for
> ipv6_stub->ipv6_dev_find() but d98adfbdd5c0 ("ipv4: drop ipv6_stub usage
> and use direct function calls") changed it to not return error pointers.
> 
> This IS_ERR() check can be removed.
> 

Yes, I thought it was going to happen during merging but I guess it 
makes sense to do it on a separate patch.

I am sending a patch to net-next addressing this.

Thanks!


