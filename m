Return-Path: <netdev+bounces-271737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEeSEPBHxGn5xwQAu9opvQ
	(envelope-from <netdev+bounces-271737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:39:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186932BE82
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FECD301CC87
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FE374195;
	Wed, 25 Mar 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIcidpz1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="adIw+3+t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIcidpz1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="adIw+3+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F5308F38
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471149; cv=none; b=HWOOuE8TZmJJ9VCxPyw97+zIv0ZvHG201YkFSpYd5+xnVPr7x2lXyvx2gWJ5P+GgSp4jdJLfUoBqG8R4GIU6E3pe9EwXNiKJx8RzWErHHjh7P+rBVkaUe1wgVFdYNezq14TQihs7ytEigtrWm957hNODKHANXBk/IuxaockX014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471149; c=relaxed/simple;
	bh=41UAIRmk7Lv/hucfqbrnpErXwXBNPsKaFkf1TvCfAHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPhRAUBUF69YbyaooX0RIzE20N3y3Y/HVxQ69jXoWIFNhkWLvGLXEd+HoHVDADrDTOM9U6I/USh0+hPLk4JS4yTTeAUrwE7EyM9H0497MZ8ky4L1ZEXLdl9DW/Req2P9CtjYZwZqITzSK1jzp7dJGN/Q9jD++mko8MYTTSGJqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIcidpz1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=adIw+3+t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIcidpz1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=adIw+3+t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6522E5BDE2;
	Wed, 25 Mar 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774471146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQIPGjdjyd1dum29OmxtciN1iNLNz3H/rMBrQeCduwQ=;
	b=lIcidpz1RGXd6qvEtprShO1icP92i6sjMO3BOEiYBcUirQOC8ZZG0TwrhjusA9OaB6rUQm
	6zW5imbAIuQKn2z9qJqHBGC7GdneFihO25p0f4YoBDg6GDU4VZLWhXEAnDBMSF1hkKOMY9
	rf7ydHiSyVEWHf3kzYkXhii81rfvtTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774471146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQIPGjdjyd1dum29OmxtciN1iNLNz3H/rMBrQeCduwQ=;
	b=adIw+3+t0R6DP2yCxNiJZCRU9XS+ZXFe8feVyY3+z/iP/LB88xw/jd5897shz+8DhID41Z
	nwPfQ10zeLLBtoBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774471146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQIPGjdjyd1dum29OmxtciN1iNLNz3H/rMBrQeCduwQ=;
	b=lIcidpz1RGXd6qvEtprShO1icP92i6sjMO3BOEiYBcUirQOC8ZZG0TwrhjusA9OaB6rUQm
	6zW5imbAIuQKn2z9qJqHBGC7GdneFihO25p0f4YoBDg6GDU4VZLWhXEAnDBMSF1hkKOMY9
	rf7ydHiSyVEWHf3kzYkXhii81rfvtTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774471146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQIPGjdjyd1dum29OmxtciN1iNLNz3H/rMBrQeCduwQ=;
	b=adIw+3+t0R6DP2yCxNiJZCRU9XS+ZXFe8feVyY3+z/iP/LB88xw/jd5897shz+8DhID41Z
	nwPfQ10zeLLBtoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74F64A0A2;
	Wed, 25 Mar 2026 20:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8jDNOlHxGnBQgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 20:39:05 +0000
Message-ID: <9ba63bbe-1222-4b97-9698-a9c847b0a47b@suse.de>
Date: Wed, 25 Mar 2026 21:39:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions
 on netlink updates
To: netdev@vger.kernel.org
Cc: horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
References: <20260325161020.3516-1-fmancera@suse.de>
 <20260325161020.3516-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260325161020.3516-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-271737-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 0186932BE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 5:10 PM, Fernando Fernandez Mancera wrote:
> When IPv4 device configuration parameters are updated via netlink, the
> kernel currently only updates the value. This bypasses several
> post-modification actions that occur when these same parameters are
> updated via sysctl, such as flushing the routing cache or emitting
> RTM_NEWNETCONF notifications.
> 
> This patch addresses the inconsistency by calling the
> devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
> required, we defer it until the netlink attribute parsing loop
> completes.
> 
> This ensures consistent behavior and side-effects for devconf changes,
> regardless of whether they are initiated via sysctl or netlink.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>   net/ipv4/devinet.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
[...]
> @@ -2507,6 +2521,10 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
>   		return false;
>   
>   	switch (attr) {
> +	case IPV4_DEVCONF_FORWARDING:
> +		if (new == 1)
> +			return true;
> +		break;

This is missing disabling LRO and also the proper netlink notification.

I will fix that on a V2. *facepalm* it does not matter how much I 
reviewed this, I missed that detail, sorry.

>   	case IPV4_DEVCONF_ROUTE_LOCALNET:
>   	case IPV4_DEVCONF_ACCEPT_LOCAL:
>   		if (new == 0)


