Return-Path: <netdev+bounces-282657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ih5KMgfa8mmNuwEAu9opvQ
	(envelope-from <netdev+bounces-282657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975649D4CA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCCB3007E13
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A122475D0;
	Thu, 30 Apr 2026 04:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NLC05A6R"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A43BB5A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777523203; cv=none; b=K07wPjcJLpXWGDWvQdr2BO+YD3zelzI3cZAL5XbvftS5bUrygefII+PAmQH40ZdqtH5YXRTTQ08oJDcvhhbsa8CtP2Ua2eL//MKHwDKybU77cQ+HK9dEueSCQts5jT7h5xpX67aNeB8kEFXeMl4ab8bZV1bgIuksf3GdB3abqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777523203; c=relaxed/simple;
	bh=+FqJGllwZTY/wRivqejVPDtjLmdI1VPrAbBIslafRY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEaHQw2ULZG+3qV2z7Uj9odYltad3Yynuyvq7TAzSHXMkMGi58aJGCyKvIrtUs13Gukfrx4kPCCNd48lQI8S071D6h3/Nmp3akV530jXT46tPgW7XBVmJFiT5L+RBNSq1GmHqFnW7LNgLIlU4eLIygJbyxz/VBg+7+2qoAbl2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NLC05A6R; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=TcIdzSkcQcLfoXYuAHpwjC7oL3jUr9yZzSPiFlEYIGo=; 
	b=NLC05A6RnaFjLKqki0lctdtfqRJDw5X2PTWs6sxsojGpNM0fDmH4G5Ul/E8ksPgW5PIDJq1q+Cp
	xasD1RMaQxpVZ5kuMQfbNIOsutSZ/zNEsNIEeLvf+UTRoe2cjpcIOvPDKWWB4ShggU7ncUmmEpdYg
	eO3/u2q6/gWLiu+AEPzCy/bbQWp3PsKDTu13GufDSIkaqECOeg3LYBR0xLCAL1e31bZCU7tFOGAw9
	bAGQP5YMIw0/+Bjwz11Q59gbihgWtT0MNDWZA7gGI1Q7PMUS9SezLVdewz1vZDRIma2BDZl6ZfoLS
	+2TBBA/TZsjMjKVYypuKH7g+RIYt0QtTG+VA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wIIye-00A2tW-21;
	Thu, 30 Apr 2026 12:26:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Apr 2026 12:26:16 +0800
Date: Thu, 30 Apr 2026 12:26:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: steffen.klassert@secunet.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ilant@mellanox.com, sowmini.varadhan@oracle.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec] esp: Force skb_cow_data() on RX when the skb is
 non-linear
Message-ID: <afLZ6Fl6b2ChTnus@gondor.apana.org.au>
References: <afLDKSvAvMwGh7Fy@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afLDKSvAvMwGh7Fy@v4bel>
X-Rspamd-Queue-Id: 4975649D4CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

On Thu, Apr 30, 2026 at 11:49:13AM +0900, Hyunwoo Kim wrote:
> esp_input() and esp6_input() skip skb_cow_data() on uncloned skbs
> through two arms: one for fully linear skbs (nfrags = 1) and one for
> skbs carrying paged fragments without a frag_list, which sets
> nfrags = skb_shinfo(skb)->nr_frags + 1.  In both arms the skb is mapped
> into a scatterlist via skb_to_sgvec() and passed as both src and dst of
> aead_request_set_crypt(), so the AEAD operates in place over the
> existing frag pages.
> 
> Drop the paged-fragment arm so any non-linear inbound skb falls through
> to skb_cow_data().  The fully linear fast path is unchanged and the
> existing skb_cow_data() error handling that follows the gate is reused.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/esp4.c | 13 +++----------
>  net/ipv6/esp6.c | 13 +++----------
>  2 files changed, 6 insertions(+), 20 deletions(-)

Good catch!

When a packet comes from a device driver, it's usually safe to
write to the fragments since they would have been allocated by
the driver.

But when a packet originates from our own stack, then it's not
safe to write to the fragments.

Unfortunately the two paths cross with the loopback driver (and
probably other means of creating loopback).

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

