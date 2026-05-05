Return-Path: <netdev+bounces-284278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFnZBAq3+WmNBAMAu9opvQ
	(envelope-from <netdev+bounces-284278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1F4C98A4
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3B43084ADA
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0B308F36;
	Tue,  5 May 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="nvvez64D"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6A1EFF8D
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972730; cv=none; b=CRUB/ja27DCcuo1HQEsw9GDK7H/kXab8WvPrkFwE7IhNgfEPMvPnN9jEUkLjfs+itj3J8YnmEEaMcB3QhIvDcQSXhFNwL+dxHSUT2VCDKx0BsRihiQrQUwIpZHNdQ3EFnAxgul61bwebZhGSk80hftt7vfYco+seskiEPgGXZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972730; c=relaxed/simple;
	bh=fbaH5tqfWHy6Xd+b5dPwSbbhuawugoyvUcdleOfhvhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmIqQvqjVIs4KG9SpwEx0ABrBhYUXbHwuGq2wQb0MkL/+mbff4pETAVvK8IyasccRRUuzSGfawWJv+yzzXSYk87YGPPQ/WyYDQoX53AitFt8WetYNhJCESFREeskHlnxMfczdIBteoqgeM7fmYs47RmkR02nS0vdZ8fYakVo8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=nvvez64D; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=JWIYkX9BKeWAsCEgZ/rd1TTkuyCi2pBwyW9ZwolVWIk=; 
	b=nvvez64DENLqwQwQbb7bP1EL+uWeLiRnQDkInhwa7dawJmo3Zs90lJeyQ9Nql337N5bIBXpLLxV
	PmDK2t4wKxMZBcVbfsN/LjmIiRF/G+UfMaXyQHZBYLhmxmxdSq3VYA8D5MvrTtt5Vejc725qvacAV
	2fhpRpCut+R29zYnTYG3JZV7PvOYCaCD+8f1+AJEsYhgmkZch5dlV4ZkJDHEGK933jyWV9MnWId4I
	KtL/swiPiQHv/EuBz22QS6T8sie5AHntAsR6EdtSCbrWyc1CfANRm+FYvxE29XM4PFxve+fNDN4+H
	PECWDI7jypZj+cxocyA9y3trsC5otSeIacWg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKBvO-00BNfR-0X;
	Tue, 05 May 2026 17:18:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 May 2026 17:18:42 +0800
Date: Tue, 5 May 2026 17:18:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	ronbogo@outlook.com, zylzyl2333@gmail.com
Subject: [v2 PATCH] xfrm: ipcomp: Free destination pages on acomp errors
Message-ID: <afm18k8_CKGOl0oT@gondor.apana.org.au>
References: <cover.1777923646.git.zylzyl2333@gmail.com>
 <8c304d9250d947b94cebc1cb1f85c73aa2bf0414.1777923646.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c304d9250d947b94cebc1cb1f85c73aa2bf0414.1777923646.git.zylzyl2333@gmail.com>
X-Rspamd-Queue-Id: 61E1F4C98A4
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
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-284278-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]

On Tue, May 05, 2026 at 04:52:59PM +0800, Ren Wei wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> ipcomp_setup_req() allocates destination pages for the acomp output
> scatterlist. On successful completion, ipcomp_post_acomp() attaches the
> used pages to the skb and frees any unused pages.
> 
> On an acomp error, ipcomp_post_acomp() skips directly to freeing the
> request. acomp_request_free() only releases the request itself, so the
> caller-allocated destination pages are left allocated.
> 
> Track the number of destination pages allocated for the request and free
> them on the error path before releasing the request.
> 
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/xfrm/xfrm_ipcomp.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Thanks for the patch! How about just moving the out_free_req label:

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
index 5f38dff16177..2947321b043d 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -51,11 +51,12 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 	struct scatterlist *dsg;
 	int len, dlen;
 
+	extra = acomp_request_extra(req);
+	dsg = extra->sg;
+
 	if (unlikely(err))
 		goto out_free_req;
 
-	extra = acomp_request_extra(req);
-	dsg = extra->sg;
 	dlen = req->dlen;
 
 	pskb_trim_unique(skb, 0);
@@ -84,10 +85,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 		skb_shinfo(skb)->nr_frags++;
 	} while ((dlen -= len));
 
+out_free_req:
 	for (; dsg; dsg = sg_next(dsg))
 		__free_page(sg_page(dsg));
 
-out_free_req:
 	acomp_request_free(req);
 	return err;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

