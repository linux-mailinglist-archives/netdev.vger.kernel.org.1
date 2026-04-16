Return-Path: <netdev+bounces-279012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNG8NkTI4GnjlwAAu9opvQ
	(envelope-from <netdev+bounces-279012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:30:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666E40D6E6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB41830EE8F5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D5396D2E;
	Thu, 16 Apr 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XfAAfkit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="429nCgNW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XfAAfkit";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="429nCgNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205839FCB4
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338734; cv=none; b=YVu9FU8ckUf6MwXuTsPGBd3+rtzdl7eCcc3nX98z4L2ChOxOsTYXQSelkGrBAPMCH950nuZmo01qWstdUpTHTgwJibalsFQwGuaRk11dYoSzK37pSSCXj4ph3ZSAQOTDNA5aUZMcBSzKn0tS2QB7nFKEMPwfKlAXwUVSKdnNYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338734; c=relaxed/simple;
	bh=MDT0EpxI7FYj3XC7ziE+as+s2FSA367oMU36RFoC930=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFFbIaWvBOj1nqf84//u4YpGtPdU+ddgAS7wvOHHLWb4g3IgtX1j5dOjGH2a8L/wC5te7LacQEpXhXRJBBmI0OFEgWoXHoNBLdm+IOpo8VBHxBEjDZ7Qf4CHplXebXUaFLuPPM7mjfwRoNfHuDJ6Q8U8OGhukbK/9+Xc5EJ1esA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XfAAfkit; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=429nCgNW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XfAAfkit; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=429nCgNW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DA7C5BE53;
	Thu, 16 Apr 2026 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776338731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKaq1Gag/E7c4D6ZKnA1WevGKpgHO+6fri2e2955kF8=;
	b=XfAAfkit6o/17ymBcAzkF3pLyc8Eq1v2mTaQeGZ6ZXnyUqVuJB+BcZov1wH5A1Xk5AsM7H
	4NaWCqotxsMUwv0NrM/noNbEEofneBpa3zEqB8qLHrR3IHKQnRGVuH3TKchQhcIs7LTzn2
	E3HcjgRHSuUfD2rZhEXCoMamCsFU3b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776338731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKaq1Gag/E7c4D6ZKnA1WevGKpgHO+6fri2e2955kF8=;
	b=429nCgNWpjslEElsIuc6qH1VO4o2NTzQ5wTf1CTWDLQsWO0cOg9eBD4Gd72j9omUNCJ8X9
	hNC5SYjD72lLy+Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776338731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKaq1Gag/E7c4D6ZKnA1WevGKpgHO+6fri2e2955kF8=;
	b=XfAAfkit6o/17ymBcAzkF3pLyc8Eq1v2mTaQeGZ6ZXnyUqVuJB+BcZov1wH5A1Xk5AsM7H
	4NaWCqotxsMUwv0NrM/noNbEEofneBpa3zEqB8qLHrR3IHKQnRGVuH3TKchQhcIs7LTzn2
	E3HcjgRHSuUfD2rZhEXCoMamCsFU3b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776338731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKaq1Gag/E7c4D6ZKnA1WevGKpgHO+6fri2e2955kF8=;
	b=429nCgNWpjslEElsIuc6qH1VO4o2NTzQ5wTf1CTWDLQsWO0cOg9eBD4Gd72j9omUNCJ8X9
	hNC5SYjD72lLy+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D89593A3;
	Thu, 16 Apr 2026 11:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3fa6KSrH4GkiXgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Apr 2026 11:25:30 +0000
Message-ID: <f9bb16ac-a392-4cd0-a290-035c7e692e77@suse.de>
Date: Thu, 16 Apr 2026 13:25:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260416103505.2380753-1-edumazet@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260416103505.2380753-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-279012-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 2666E40D6E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 12:35 PM, Eric Dumazet wrote:
> Caching saddr and daddr before pskb_pull() is problematic
> since skb->head can change.
> 
> Remove these temporary variables:
> 
> - We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
>    when net_dbg_ratelimited() is called in the slow path.
> 
> - Avoid potential future misuse after pskb_pull() call.
> 
> Fixes: 4b3418fba0fe ("ipv6: icmp: include addresses in debug messages")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

