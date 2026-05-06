Return-Path: <netdev+bounces-284838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP96NLZB+2lPYgMAu9opvQ
	(envelope-from <netdev+bounces-284838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:27:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BC4DAF3A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BADA3003637
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525063F166B;
	Wed,  6 May 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="HkPiQcFF"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8146AF16
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073826; cv=none; b=VMQEadvVe1QkPAzmKuI7ZNWbAXzvo6qnJIi5EcKw2vjQkbF11KN4imo4zArNsrZp61WtS2GXBXZWTW1LkUrxk3SKDmyxXPlKk1nX4wQfkhgpY/ysipvxd58vRLpkfeuVthnssPk87+GZVU7kGTLOo6SQvE1Wxq10P0M+2lthPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073826; c=relaxed/simple;
	bh=G3B+m6SHavcpSmCaXLVVnJxkXVoZR5FFJjOL/YYrdtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=erqewQhfNemS64V5oSvx53hk3Epwl6YAPflQmW+eTVZ3DNjU/hSTEajmvxYnEbUxV6t+vUPDrrQAxNe85WzHhhSn5MubZyxD+HHIowtfnhJ3m4BXrtk2lhEvwdy29URdV2qpH6TR3FxhidWdnw+8awkh6pbHTU8h0NklPB2wCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=HkPiQcFF; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=yPaL9jC3EmeaUjAPKaSXdHpHBJQTTLDYXYYztvTpV9w=; b=HkPiQcFFH+3y2z5ZsiAmNZ4oOX
	hZXGjK4L1k2Zwxlg90DL/OTrTKGn7lOSwQCRgz1F0AUuEL40U9KDbB1HG/NMuSp5bA0EBVr9blaDi
	zseDyhASuplXB6IRLDOC1MQ40fLkBX8maWPVE3jNbYjF2KRsswc/z/H44zZ4tYDUnTkCYbPodZ/P2
	6/3Bozh5tsdZ2CfFC9T+d8ZzSvRsnNWwZLKw/iRd54z0ANwk7Mg/oWGkhRG2+ZCnXez1tckrmjjAQ
	toMxc+2FLAKEIHXVljWyD9s5Xvi/VVrhDEiC1GPAKr6AojUwtus1/gdEOn8ceruxjfAh+5aR9wSrq
	GOxRSpBw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKcDo-00BnR9-1A;
	Wed, 06 May 2026 21:23:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 May 2026 21:23:28 +0800
Date: Wed, 6 May 2026 21:23:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Orion Zhu <zylzyl2333@gmail.com>
Cc: n05ec@lzu.edu.cn, netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	ronbogo@outlook.com
Subject: [v3 PATCH] xfrm: ipcomp: Free destination pages on acomp errors
Message-ID: <aftA0Iwi2aX_4ORo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAAOPT9Jw_TKnuqyQ_5es_ot0SNLprU2fSJwtEORj3OLf_QECA@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.netdev
X-Rspamd-Queue-Id: 2D9BC4DAF3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,secunet.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-284838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]

Orion Zhu <zylzyl2333@gmail.com> wrote:
>
> Thanks, but I think moving the label is not safe for all paths reaching
> ipcomp_post_acomp().

Thanks for checking!

We could fix this by checking whether req is NULL and whether
sg_page(dsg) is NULL.

---8<---
Move the out_free_req label up by a couple of lines so that the
allocated dst SG list gets freed on error as well as success.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 5f38dff16177..671d48f8c937 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -51,11 +51,15 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 	struct scatterlist *dsg;
 	int len, dlen;
 
-	if (unlikely(err))
-		goto out_free_req;
+	if (unlikely(!req))
+		return err;
 
 	extra = acomp_request_extra(req);
 	dsg = extra->sg;
+
+	if (unlikely(err))
+		goto out_free_req;
+
 	dlen = req->dlen;
 
 	pskb_trim_unique(skb, 0);
@@ -84,10 +88,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 		skb_shinfo(skb)->nr_frags++;
 	} while ((dlen -= len));
 
-	for (; dsg; dsg = sg_next(dsg))
+out_free_req:
+	for (; dsg && sg_page(dsg); dsg = sg_next(dsg))
 		__free_page(sg_page(dsg));
 
-out_free_req:
 	acomp_request_free(req);
 	return err;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

