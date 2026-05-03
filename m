Return-Path: <netdev+bounces-283556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDT3Ji3q9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D44B49C0
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E3E3003E90
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB153A8727;
	Sun,  3 May 2026 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnusn47/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C913A7F78
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789431; cv=none; b=hWabObZTPOzEractp63iUdxF5E49ubaexa5pxqr1/8WIIvhkQ5t+Z8YBFdoQ4yh7jqPMjI4zugXbICaAlRU7jlK2Sd4saKCBqMdLFxuL/W+5gEaR20lInviFe0/S4dWuKxsxx7XcGb/Jr6Vns1KICsg/1Oh3dRvCWNeUWsuBlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789431; c=relaxed/simple;
	bh=Fsmgq5cAKrXPL9pLv0TXR5n4zPRRZMK9jy8Mv9X5XLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQGk8bAbFr1SJ37wu4yFmQu65sW6UV0myohG6uX3VJXF6pyDiCAXwRT4PWbjOisViZC4hG+GbPGdC5b9qtIm4KyuEqM76v9QTRkV9VTOgCbhUyZPy7D99bd1swJzZGG/iDidLMdhmf6F9z0cs2/c8Hv/CWvo9C/GyPpBlsVEQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnusn47/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-365212191f6so376140a91.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777789430; x=1778394230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jauMLsv8rVhaM9q3nubRO4klXhEWZOV4Z40Yc2+Ynwc=;
        b=Jnusn47/gLBcYwmf37RoNooyu6JOJii+mFOmJnqk1EiwQoUgYVe/hZQRJ1S+6om7Xh
         gTIyc0YfmMBYDR9jO4pp1EwYVN3VBgeQ94u1CnofFGv3xqRa5v9HdnW749wVTvxfybLr
         04G6VQyZIN45aMLBRMbdJOy8+djOxcKBikODtPrpsVOqNPBa45arDuK088idEKEacfFI
         z9UhLu4Fuk+JYdI4NeTDjrdaslYW79wID27/zA2g8fyNIPMJfgpaMknGC9trGuiCgZQn
         7cfB5AMwC3lSgD5zfO8/voUeMI3ve03uCnoDsPXU/DF9axD0O5UY/1qTHYh6ODYSFVL3
         ZCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777789430; x=1778394230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jauMLsv8rVhaM9q3nubRO4klXhEWZOV4Z40Yc2+Ynwc=;
        b=nIQLu6zZcpnZlpHmXIrS5nmqdbBIs+UPLEuoDuUM2EZ2RGs8jUxg8iZQeQWNFAVHpO
         BY3BN6EZjMHzLMaG0ikyU6DTNL1Lw6CVLX3eE4TOOGyUIbGfy2ZCBjvu9PQ1gI/NeX5a
         VWWptUPHKFA8bIPzMQWWPQcQ2vllKHMKQdzKVT50SELQ46MGTCD4EOKXo/9FvNRGoOF2
         CXzKRfgeFcQBF3h9hGQphFFS1xRAAZeZasRml3V9NGMb1Y5u7ihujaccs0Ncaq5SQ3x8
         CCIAb3FeXS5FIg+OkBCqJbtejok8ebSX1MzT0zVhhsELt9OSbd/FUKjatCjvAxLbup9h
         7n0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+hCm6XLssmJjktbsxZLPmF4HWelxSrxSix/zc7vyDOx+IOZjLgKpLLIivCg6X4FJUIDFBK69s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3jXbn4lDY7y5Dpgs7oqlHSL4CDeDM5ZMy49wOG8z/cdi7smi
	PUncPWt0Xy3/943beHqbDc5ZplLXrc3L4RYzL7RBVi3Xvuv3TjAz8PBp
X-Gm-Gg: AeBDiesc2FnR7Q0fP1XlsJYZiI01FL2RLYzituF6d55mbwsvGsDsvCYYljUjmbBbw7k
	RbYREFMsj+w3S5v2SN4zW8ntgAtkuZJtuL/FAx7KljYyy++aUt+qwhlNo9BGc9NLsd5zl6rPTzD
	X4l5QX9FnaiypCjzMRMK3KjKYci9Kisvvi9IsFojndnEoYWq2INPIRMeYu1fF09s260yAdZvFAr
	dGOOmIA4LuuGmx7pWs4iXdJPWItZI5JeHNa1D1mFfj7D5u0KMqpD7BOvTDpl6Wb8DMPwKoMIZqi
	03ZHLinXIMA7xdyOSBss1XsJ/SDy5NTbe796XbxN+/55hrYO1aikV9LyG2bwx+ziG/PFBUmtbug
	d6sp05MPWNK0X0SqySSZzTIZ/vQF8MF9OPw0gTgJsFmNCVLe3/Z9Nx1vJm5qhxBcAJI4x78+Jo7
	r9OrVkBs+e6bjuRYlaoJznM8S9AlaekMHvVc7dgIFg/D7V8SFD2eiXOovAVNm6u3TC
X-Received: by 2002:a17:90b:3849:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3650ce38382mr5709647a91.17.1777789429662;
        Sat, 02 May 2026 23:23:49 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec736dsm7243126a91.3.2026.05.02.23.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 23:23:49 -0700 (PDT)
Date: Sun, 3 May 2026 15:23:45 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH] rxrpc: always copy skb on in-place decrypt to avoid
 pagecache aliasing
Message-ID: <afbp8dod6IK2xTVd@v4bel>
References: <20260502211340.446927-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502211340.446927-1-n7l8m4@u.northwestern.edu>
X-Rspamd-Queue-Id: 036D44B49C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283556-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 09:13:40PM +0000, Ziyi Guo wrote:
> skb_cloned() does not detect frag-level page sharing introduced by splice()
> with MSG_SPLICE_PAGES.  When such an skb reaches the rxrpc DATA path,
> in-place decryption (rxkad/rxgk) writes plaintext into file
> pagecache pages still aliased to the source file, leading to
> corrupt the page cache of any readable file.
> 
> Drop the skb_cloned() gate so skb_copy() is performed unconditionally
> for DATA packets, severing the alias before decrypt.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  net/rxrpc/call_event.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index fdd683261226..39d19a354172 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -333,10 +333,12 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
>  
>  			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> -			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> -				/* Unshare the packet so that it can be
> -				 * modified by in-place decryption.
> +			    sp->hdr.securityIndex != 0) {
> +				/* Always unshare: skb_cloned() does not
> +				 * detect frag-level page sharing introduced
> +				 * by splice() with MSG_SPLICE_PAGES, so
> +				 * in-place decryption could otherwise corrupt
> +				 * the source file's page cache.
>  				 */
>  				struct sk_buff *nskb = skb_copy(skb, GFP_ATOMIC);
>  
> -- 
> 2.34.1
> 

Hi,

A patch for this issue has already been posted earlier:

https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/

Best regards,
Hyunwoo Kim

