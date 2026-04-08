Return-Path: <netdev+bounces-276692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAqDBXSs1mmZHAgAu9opvQ
	(envelope-from <netdev+bounces-276692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4F3C30DF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6B230E0541
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037F3D092A;
	Wed,  8 Apr 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1O/Tnqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D13D4134
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675110; cv=none; b=XS938AWyFZ8x5B4clR0rt4xAv/e9WxJvzgreo71WgOrGuEmj9NA+ugiY8UcLZDgSDXxbmDPzhZWf2nzIcuHOXE6VqX4pfI8cA+xd1vNmzTKAjUFKq0kO7oQnilvouTt8D66tVqL7Z5J9PeX8RdWnWkbqCFe6kF7F0bONCcwFwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675110; c=relaxed/simple;
	bh=dnr1zORZcAqmCMKUEYcJrMmO4aiTN35DMRq8VPgOeiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPzsD72lavWm2ODFurNV4iqngytKcIC+BwAIhF2StUtzTz8xHJuJ2zKSd4DGhpYJSWnI6hwkL5XfU/lcBLp+O6M0L4gUKckbtrzahEWbmNjAIvciw7o86b39pbTorSpyqZ+tzaK2h5q04lrBM0EhlCwwvrf85/Jwh23q7u2sYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1O/Tnqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EF2C19421;
	Wed,  8 Apr 2026 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775675109;
	bh=dnr1zORZcAqmCMKUEYcJrMmO4aiTN35DMRq8VPgOeiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1O/Tnqcm/LpX8p1YQaVQizNtyhpFn2wnj1tCkS0qwxarmONv6KEl21/m4uTscKcX
	 uXdiSQ/inzBRqDU4XdJP0gE0IM/f3OoAnW87p40EyPwGsl4clxDLlrPaC8em8YFkD2
	 fngovXm+qfHG5axArQnpFbkfEyt7h/wmc3LDVk6Bx3SrsU6zic3qMqfUzlUQT6bdbt
	 7w/K7JDxXWCTO8U7Z8M++wwq+cVNelP93yD/PTw0M+0SVwqDx/MkuRbkmM60kSoFOS
	 bwv7xZDuIdDrgMuFRMcZiyofLdEmwRBv7xziz33O0zU2gO3uTq81lSnMza2N+9LrfA
	 a7lpM8AxzExIQ==
Date: Wed, 8 Apr 2026 20:05:05 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, security@kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH] nfc: nci: fix OOB heap read in
 nci_core_init_rsp_packet_v1()
Message-ID: <20260408190505.GK469338@kernel.org>
References: <20260404103016.1292588-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404103016.1292588-1-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276692-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 95D4F3C30DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 12:30:16PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nci_core_init_rsp_packet_v1() uses the raw chip-supplied
> num_supported_rf_interfaces byte to compute the rsp_2 pointer, but
> the preceding min() already stores the capped value in
> ndev->num_supported_rf_interfaces.  When a hostile chip returns
> num_supported_rf_interfaces > 4 the memcpy is safe (capped) but rsp_2
> lands past the end of the skb, and the fields copied out of it corrupt
> nci_dev with data from adjacent kernel heap.
> 
> Use the already-capped ndev->num_supported_rf_interfaces for both the
> length check and the pointer, making the relationship between the two
> explicit.
> 
> Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
> ---
> v2: drop intermediate offset variable, check skb->len directly against
>     ndev->num_supported_rf_interfaces + sizeof(*rsp_2) (Jakub Kicinski)

I'm unable to locate v1 and Jakub's review of it.
Could you provide a link?

> 
>  net/nfc/nci/rsp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> index 9eeb86282..4aaf362b9 100644
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -66,7 +66,16 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
>  	       rsp_1->supported_rf_interfaces,
>  	       ndev->num_supported_rf_interfaces);
>  
> -	rsp_2 = (void *) (skb->data + 6 + rsp_1->num_supported_rf_interfaces);
> +	if (skb->len < sizeof(*rsp_1) + ndev->num_supported_rf_interfaces +
> +		       sizeof(*rsp_2)) {

There are accesses to skb->data before this check.
And it seems they could also overrun the length of the skb.
So I think a check needs to be placed towards the beginning
of this function. (Sashiko has something similar to say.)

Also, I don't think that checking skb->len is sufficient,
as data may be present in the non-linear portion of the skb.
I suspect pskb_may_pull is needed.

If so, I think the same problem exists in the call path.

> +		pr_err("CORE_INIT_RSP too short: len=%u need=%zu\n",
> +		       skb->len,
> +		       sizeof(*rsp_1) + ndev->num_supported_rf_interfaces +
> +		       sizeof(*rsp_2));
> +		return NCI_STATUS_SYNTAX_ERROR;
> +	}
> +	rsp_2 = (void *)(skb->data + sizeof(*rsp_1) +
> +			 ndev->num_supported_rf_interfaces);
>  
>  	ndev->max_logical_connections = rsp_2->max_logical_connections;
>  	ndev->max_routing_table_size =

Sashiko also asks if it is valid to read the packet
if num_supported_rf_interfaces is truncated. Won't the beginning
of resp_2 lie in the trailing supported_rf_interfaces of the rsp1
header?

