Return-Path: <netdev+bounces-285736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBcNOOOt/WmlhgAAu9opvQ
	(envelope-from <netdev+bounces-285736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D414F44A4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6B330134A5
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3A3BFE44;
	Fri,  8 May 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MOmyCPW8"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795D3A451B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232659; cv=none; b=c2uJIJZ4kVj4WbAUq5jx+BHDwF+zn1enc1RjcVTlgIuK7UHVMeHoscd+FMbbsDItG45f8bYS5OQTqqB9yJNAxcCqC5y+l7ud06ejCGYJFkscjR2ArEFKe42PQj81/NemOR6Y1oKDeOuapuuo82/2f1IwwKymKdXQLfNoZ3p41B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232659; c=relaxed/simple;
	bh=NOB2ptxL8dE1Y9LNF612Zf4gU5IdXC9Br58KlDf3JHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNFSmZg1mzk+nHoPYuYJUJIqefHVDITCJuB559Scx8kBalmTKpDH867GaDSwBLgWBU98099PGWjSy3a4wjkp7zyRAkOJB/WML8du0tlWiiecO7UAcarUba4KN2omknAxUrRMBYmZin5/tvELLmavzEs2/P1Z1oXvFVeiL57Guns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MOmyCPW8; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <539af15d-3d38-49d9-9023-6b074220149a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778232656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6QY7g9qkuQ6dWIXFQsCUwwqjFrRk+mfQdDgCMmtD80=;
	b=MOmyCPW8TNvo8y5FbrRVEdcJ2OyG8GZzIzDl0v7lhOTVzmKC6Xg4GFb1WsELAJvMEk1SVo
	uyOM1EVXorAZKaZ84s23pSQZ5JHjqOgpODWHbVo+QtDePibzYH2XxkvZqgI4smz7rIxVFk
	Y6fEru1z3DFjDpKK16+AbiEi6jPa2Vg=
Date: Fri, 8 May 2026 10:30:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ethtool: fix missing closing paren in
 rings_reply_size()
To: Tao Cui <cuitao@kylinos.cn>, andrew@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org
References: <20260508071402.183909-1-cuitao@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260508071402.183909-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 40D414F44A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim,kylinos.cn:email]
X-Rspamd-Action: no action

On 08/05/2026 08:14, Tao Cui wrote:
> sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
> parenthesis, causing nla_total_size() to absorb the subsequent
> _TX_PUSH and _RX_PUSH entries. The resulting size estimate
> happens to be numerically identical due to NLA alignment, but
> the nesting is wrong and misleading.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   net/ethtool/rings.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> index 0fd5dcc3729f..9054c89c5d7b 100644
> --- a/net/ethtool/rings.c
> +++ b/net/ethtool/rings.c
> @@ -63,9 +63,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
>   	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX */
>   	       nla_total_size(sizeof(u32)) +	/* _RINGS_RX_BUF_LEN */
>   	       nla_total_size(sizeof(u8))  +	/* _RINGS_TCP_DATA_SPLIT */
> -	       nla_total_size(sizeof(u32)  +	/* _RINGS_CQE_SIZE */
> +	       nla_total_size(sizeof(u32)) +	/* _RINGS_CQE_SIZE */
>   	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
> -	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
> +	       nla_total_size(sizeof(u8))  +	/* _RINGS_RX_PUSH */
>   	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
>   	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
>   	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

