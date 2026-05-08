Return-Path: <netdev+bounces-285727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHMGK/2p/WmEhAAAu9opvQ
	(envelope-from <netdev+bounces-285727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DED4F4236
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736183005D08
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4538B7D5;
	Fri,  8 May 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PeX2oysT"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01D389472
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231652; cv=none; b=E31lRAECif1xfKYxA5mQBAr43Xe2IcBuCY4TACyieuFUhPtr6MOpshqeM7JUrXbcSsM8Qv1I6Yg0ts65rnLWbZZsncm6MWqH0INOoFtwIuM4YgF7cSR6+cfv3M26BFAyJRX05U9cjzyPXZPGOKCxx4rtgaUN9bFAOG4bHKhGgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231652; c=relaxed/simple;
	bh=Rkt5k+d3zqABGzEnnA/rW2G20Ap+bhi83t9spG4THNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkuzLUID3PuPJHd65pWw16481YcWLJrkx6aPA0Pmxtv+6I/WGzlKeXkOK2aKbh0E/9l5GmO7O8riLEvO/qVqDNF/DoGXQJj7YCbkqTsEiPFPiqD/s1MgNUY/nGS+RwjGNiZpE+SUefeKgvR/DTkWwrofCyBNo/ljxOdHo3XovXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PeX2oysT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VF+obDiJaw0tsLGDj3KMDjmSjcYaTw8RxnhvxbFgA24=; b=PeX2oysTEqOB3ZQ5BtD10ICpmw
	9qY7uGAPsHXTtiVJb/fwqVznU1W1GngbbdsNumyhWeXSZk9s/VQayqvURAsgmVN7lzo24CltYlM4i
	ZCZL+/REs2i8DSNCjgs8C0u8QHQHKgB52cXc8gpl/6IeyX/Fo8x0gYrpsUCCC3CxET+AS+q2u+OF/
	6P5Hw+nFhK0bgdqe4xJmDBueuXMFkLR+ReQmNC6eOTDXcjf3L+G0RSoyvLXin6srMuSy9u/TZIxIs
	BSiOZDFXmyRtCelOT9p9PfbLLucC9q7veq8d+f91vmvG312D0hykXTEcrp+9psPsGGg9bv+9AywhW
	9Acl4btw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLHHN-0052Zs-29;
	Fri, 08 May 2026 09:13:53 +0000
Date: Fri, 8 May 2026 02:13:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ethtool: fix inverted memchr_inv condition in
 ethnl_bitmap32_not_zero()
Message-ID: <af2o77Fbou5pnBKy@gmail.com>
References: <20260508080211.636177-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508080211.636177-1-zhaochenguang@kylinos.cn>
X-Debian-User: leitao
X-Rspamd-Queue-Id: 13DED4F4236
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 04:02:11PM +0800, Chenguang Zhao wrote:
> memchr_inv() returns non-NULL when a byte differs from the given value.
> Return true in that case, not when the scanned words are all zero.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

There is no Fixes: tag. It seems the buggy check was introduced in 
commit 10b518d4e6dd ("ethtool: netlink bitset handling").

> ---
>  net/ethtool/bitset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
> index 8bb98d3ea3db..56b0c4867ed2 100644
> --- a/net/ethtool/bitset.c
> +++ b/net/ethtool/bitset.c
> @@ -105,7 +105,7 @@ static bool ethnl_bitmap32_not_zero(const u32 *map, unsigned int start,
>  		start_word++;
>  	}
>  
> -	if (!memchr_inv(map + start_word, '\0',
> +	if (memchr_inv(map + start_word, '\0',
>  			(end_word - start_word) * sizeof(u32)))
>  		return true;

>  	if (end % 32 == 0)

The fix itself looks correct, but is the rest of
ethnl_bitmap32_not_zero() consistent with the documented "true if there
is a non-zero bit in [start, end)" semantics?


