Return-Path: <netdev+bounces-275143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPtmHEntz2lF1wYAu9opvQ
	(envelope-from <netdev+bounces-275143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30039686C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CAD930BD9A6
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F13CCA1D;
	Fri,  3 Apr 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSr+hnLG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB93C660C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233916; cv=none; b=ZsSTIBmvGrIm2VkYBBU1Tvc3SXp561hSgH02oxpwZLBxVjIMKGsMMVgRi3LXRCaubhQZI3417WwcWYagpvsG/z16lrToJ5N1dLMZ/IzuZB5nGTYnBEWPLQKv1XVce5FdbN3U4EEYU0FtzF4jNJ5jQsA7XRywr6eqPlpuNmTdRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233916; c=relaxed/simple;
	bh=9M8gcmoNR1XCaccptQ5bXfDN2IjxU+LkTwaaPEGAJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5vDXxczDYJpbdQKRUXhtAg9/3WpYu/NKdptgbxwSPNFGlD+JpQpj07o2GJXcBFHYWS60FWLJwaDHXimHy1RZlb2sEZzQzGmoYAraX6qGia6+YlALz5StaHW3ucrQ5X2ORFpi3XEXsOWnUXnINMMe0Cm12WE2WxFjWpxeaFGOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSr+hnLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC304C4CEF7;
	Fri,  3 Apr 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233916;
	bh=9M8gcmoNR1XCaccptQ5bXfDN2IjxU+LkTwaaPEGAJNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSr+hnLGemZv3UtVFqaHjPWBSQnaEgnD2DCC2WK06NGvQpRpflINfzXo09iN6zb9e
	 r5O8xp0zqZOxFEuxLz6TRx1GAnEvU9/NKAu6CQzEHLwk9RugBnaMSLw3h0ar2+K88Q
	 /ENhatK2g9zDmY7GcUMcepBHq1TpU1aLHS2UKDnt4xv1gjG+NIBNu8w/XYGRXKT2NO
	 fEMlKkBCiPEVp4cRxEazEEdQfsVACiBMAmCmoK56MMqT3WXHIGMWfYFdYPOgjfUmvo
	 C8NfOsy3nvFExmAP5aAX6Kn/tfj0/GjPpqneN8GGC+0gOkRcdKE/Y5Ebrturjx4J12
	 yfWqF98LvICwA==
Date: Fri, 3 Apr 2026 17:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: always inline some skb helpers
Message-ID: <20260403163152.GQ113102@horms.kernel.org>
References: <20260402152654.1720627-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402152654.1720627-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: BC30039686C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:26:54PM +0000, Eric Dumazet wrote:
> Some performance critical helpers from include/linux/skbuff.h
> are not inlined by clang.
> 
> Use __always_inline hint for:
> 
>  - __skb_fill_netmem_desc()
>  - __skb_fill_page_desc()
>  - skb_fill_netmem_desc()
>  - skb_fill_page_desc()
>  - __skb_pull()
>  - pskb_may_pull_reason()
>  - pskb_may_pull()
>  - pskb_pull()
>  - pskb_trim()
>  - skb_orphan()
>  - skb_postpull_rcsum()
>  - skb_header_pointer()
>  - skb_clear_delivery_time()
>  - skb_tstamp_cond()
>  - skb_warn_if_lro()
> 
> This increases performance and saves ~1200 bytes of text.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 4/24 grow/shrink: 66/12 up/down: 4104/-5306 (-1202)

...

> Total: Before=29652698, After=29651496, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


...

