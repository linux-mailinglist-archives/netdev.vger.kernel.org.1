Return-Path: <netdev+bounces-292997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD8oM8wqGWrCrggAu9opvQ
	(envelope-from <netdev+bounces-292997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011B5FDA86
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07AA23023DE8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43752315D21;
	Fri, 29 May 2026 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nO89yUOd"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE33A873C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033941; cv=none; b=gJ0pcZSGPb0SeqH3BuspyhK7Tf4wQbXVDtgZj2WgucVv222DKpmYnLRSLidlJmXF/HozJrpzhmAinuRdgRU3KhpDQQM4GHMxUWJztMAAYajjuJHmB4ocq8BTW3N1uEvBGI1MozusIt1F856dgKGpWzP7SDBUJezGqky+j0Gi5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033941; c=relaxed/simple;
	bh=CQWwFg0VuPHV6v/0p3H76JZlDmHCcPNvRANBYb6CHOc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spzrS5tF0eu0FluGKh+LW6rgCdfwx4pC39kWJEzazRTFwzHkxQyazAh3h2u8oAoA/keg2ZXUiSSnn0lZa65JelA3tg7yRZHq48t4cE+6z0NfCUFP4OUcHUgaRz3LQqtmGqb7o6oXie0zI6iDoe1NI4fNKklUosurfAv6OK7pLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nO89yUOd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2395C20799;
	Fri, 29 May 2026 07:52:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3k-6cML-gjS; Fri, 29 May 2026 07:52:08 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4447A2058E;
	Fri, 29 May 2026 07:52:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4447A2058E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780033928;
	bh=2dEMSpsSAIeGTikNzHlc84YZcPWIIuscRkLyMvZsR9w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nO89yUOd1hIPzXf+0kg2SrkvfSJsiQA9oewnsOQWg9uwl++lUuNZHCAhL5ad9nQoO
	 Umr2BjUwTF5K5P1vP7HcN/swi6OoyfFFK7sCqWbewaGYhGNryyb0fvrx5S42yG5rTe
	 x7EaKvz0He2IxUmX3Y0nM/FoxZi+2OHgn2F2oPyLCDVREhtwFd4a7a3C+JsoeOE6nb
	 Y+sR6+FkBoE5Xdbi089h8AjGkiI89A817GBTx8suBoV65FKnCsaqDs9tSNpI2orlox
	 k/HiwVgxlJJk8xEKs1iRpg4Xkmjp3YqxPerTxDkR+5b39k2yTu65+GYZ8VtRrUNs0B
	 gp7mmzG6gV47w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 07:52:07 +0200
Received: (nullmailer pid 3691757 invoked by uid 1000);
	Fri, 29 May 2026 05:52:07 -0000
Date: Fri, 29 May 2026 07:52:07 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: Re: [PATCH 5/9] esp: fix page frag reference leak on skb_to_sgvec
 failure
Message-ID: <ahkphzYYBeoCcbRI@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
 <20260527084148.3489759-6-steffen.klassert@secunet.com>
 <0902bdb9-2746-45fd-ba4d-8e5b96617b8b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0902bdb9-2746-45fd-ba4d-8e5b96617b8b@redhat.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,gondor.apana.org.au,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-292997-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sbb.ch:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2011B5FDA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ccing the author of this patch.

On Thu, May 28, 2026 at 03:44:14PM +0200, Paolo Abeni wrote:
> On 5/27/26 10:41 AM, Steffen Klassert wrote:
> > From: e521588 <alessandro.schino@sbb.ch>
> > 
> > In esp_output_tail(), when esp->inplace is false, the old skb page frags
> > are replaced with a new page from the xfrm page_frag cache. The source
> > scatterlist (sg) is built from the old frags before the replacement, and
> > esp_ssg_unref() is responsible for releasing the old page references
> > after the crypto operation completes.
> > 
> > However, if the second skb_to_sgvec() call (which builds the destination
> > scatterlist from the new page) fails, the code jumps to error_free which
> > only calls kfree(tmp). The old page frag references captured in the
> > source scatterlist are never released:
> > 
> >   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
> >   2. nr_frags is set to 1 and frag[0] is replaced with the new page
> >   3. Second skb_to_sgvec() fails -> goto error_free
> >   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
> >   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> > 
> > Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> > unconditionally unrefs the source scatterlist frags without checking
> > req->src and req->dst, since those fields are not yet initialized by
> > aead_request_set_crypt() at the point of the error. Existing callers
> > pass false to preserve the original behavior.
> > 
> > The same issue exists in both esp4 and esp6 as the code is identical.
> > 
> > Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> > Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> > 
> > Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > ---
> >  net/ipv4/esp4.c | 12 +++++++-----
> >  net/ipv6/esp6.c | 12 +++++++-----
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index 6a5febbdbee4..8314d7bddcb7 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
> >  			     __alignof__(struct scatterlist));
> >  }
> >  
> > -static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> > +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
> >  {
> >  	struct crypto_aead *aead = x->data;
> >  	int extralen = 0;
> > @@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> >  	/* Unref skb_frag_pages in the src scatterlist if necessary.
> >  	 * Skip the first sg which comes from skb->data.
> >  	 */
> > -	if (req->src != req->dst)
> > +	if (already_unref || req->src != req->dst)
> >  		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> >  			skb_page_unref(page_to_netmem(sg_page(sg)),
> >  				       skb->pp_recycle);
> 
> Sashiko points the above is still unsafe:

For the original patch submission, sashiko reported 'failed
to apply' because it was targeted to the ipsec tree. Now
with the full pull request it applied and it found issues,
but now it is too late for me to fix this.

Would it be possible to integrate subtrees of net and net-next
into the netdev CI? This would avoid such problems in future.

> ---
> When the new caller passes already_unref = true, can the loop still be
> reached safely?
> Looking at the allocation and request setup in esp_output_tail():
> 	tmp = esp_alloc_tmp(aead, esp->nfrags + 2, extralen);
> 	...
> 	req = esp_tmp_req(aead, iv);
> 	sg  = esp_req_sg(aead, req);
> esp_alloc_tmp() calls kmalloc(len, GFP_ATOMIC) — the buffer is not
> zeroed.
> esp_tmp_req() only does aead_request_set_tfm(req, aead), which assigns
> req->base.tfm. It does not touch req->src or req->dst.
> The local variable sg is filled in by skb_to_sgvec(skb, sg, ...) but
> nothing copies sg into req->src; that assignment is performed later by
> aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv).
> In the new error path the call sequence is:
> 	err = skb_to_sgvec(skb, dsg, ...);
> 	if (unlikely(err < 0)) {
> 		esp_ssg_unref(x, tmp, skb, true);   /* before set_crypt */
> 		goto error_free;
> 	}
> 	...
> 	aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv);
> Inside esp_ssg_unref() with already_unref = true, the predicate is
> short-circuited but the loop body still dereferences req->src:
> 	if (already_unref || req->src != req->dst)
> 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> 			skb_page_unref(page_to_netmem(sg_page(sg)),
> 				       skb->pp_recycle);
> Since req->src has not been initialized at this point (the kmalloc
> buffer holds whatever was there before, and aead_request_set_crypt()
> has not yet run), sg_next(req->src) walks an arbitrary pointer,
> sg_page(sg) reads sg->page_link from arbitrary memory, and
> skb_page_unref(page_to_netmem(...), ...) then drops a refcount on a
> fabricated page.
> The commit message also seems to acknowledge this:
>     Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
>     unconditionally unrefs the source scatterlist frags without checking
>     req->src and req->dst, since those fields are not yet initialized by
>     aead_request_set_crypt() at the point of the error.
> If req->src/req->dst are not yet initialized, how can the loop
> sg = sg_next(req->src) be valid?  Should the helper instead walk the
> local sg returned by esp_req_sg(aead, req) (which was actually
> populated by the first skb_to_sgvec()), or should
> aead_request_set_crypt() be moved before the failure check so that
> req->src/req->dst are well defined?
> The same construct appears in net/ipv6/esp6.c:
> ---
> 
> And the SoB is incorrect for this patch. Do you rebase your tree? (I'm
> not suggesting starting that otherwise!!!) If so you could possibly drop
> this patch ?!?

No, I never rebased the ipsec tree so far. I could revert it, or you can
do so if you don't accept the patch as is. Rebasing would be the last
resort as this creates problems for everyone who cloned my tree.


