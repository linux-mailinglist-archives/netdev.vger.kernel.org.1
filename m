Return-Path: <netdev+bounces-174997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911FA62077
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 23:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450141B6186B
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF01FA856;
	Fri, 14 Mar 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="nhz/RpS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKlgQKVo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEFA32
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991655; cv=none; b=BubST9gxVQpJBwWDZ6BXK4tJiHfUan/05VGWU7LoYGLSxvMV7VsgtORcdkuUlgUhRT6yO9NOvcMrYWQdMzQyFRI8d3+VyCKSos9iLk3NT9QvLkUmcY23vkfOSN0ACta0HyP2XdTADrvbbomlSZAfzmaUZmqUuQW3MHuyXsIB9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991655; c=relaxed/simple;
	bh=KSoNqwiYVq/VohgT1XEcXsukqyUDBYp62guyb1RZ7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3rqXyJYbef4OmM8PXc1US+nwrqIT0tlFM6NtFbq/uh8gx3ySUHSOgkBvKbBC48FafeURIWEaebHJE2HAYShATaA5QnAvn3DYH+t1I/FgK/ofEiuXcMKy5lmXOCcXm0KtUbGZAgr6ZXBCfx5E+MC6oSbSCMWbshhf2KkB+mKHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=nhz/RpS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKlgQKVo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50D72114017B;
	Fri, 14 Mar 2025 18:34:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 18:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741991642; x=
	1742078042; bh=hZ4RMoibPO0Y6oALSw1Z920muGbtqBVZ071PmuLepp4=; b=n
	hz/RpS8MFG/fpaM7ySZumTMLEg4fdqHEfowB1/cIBmEAMreZ1BQYxtdTdPsPvrL9
	1C4aNDb/u5gKzKv1ln7G0P1uV3+oHjn6EMp6Q7hWP4UV/qowB5kPJwwcX8m51jhT
	3dKnO1qrxW4eK+NFd1LyatCp2+AoHI59trbhfIl0Zp6j8y8EH9kO0xMgGGEj7hlS
	YjraZmVbmmQ68YX8rI+iAOivszEPtKDoRO3F+6Ua/jFG0ighKX2FDbJRYx7BNYeV
	QzVveanMUd5ow7IhSf58uMLbj7L+ZHgNFzXQHFNkBChZ4Jsz/oURyUTxLl1HZdRo
	zjnGQESktUtWIWbMz8Pgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741991642; x=1742078042; bh=hZ4RMoibPO0Y6oALSw1Z920muGbtqBVZ071
	PmuLepp4=; b=gKlgQKVofQSXHWsIU1YxrJ0Wfy11zHf2m1wtWRdmyOPkttaoWtR
	LRdZRZw5DxCOiB3xQtU6tXLHlWvcDDB6qAe8JA08EEB8CJPD3GFUmAyNh0BPU8jN
	L5K/lH6dLvBMU9vGXuKY7F++L+a0FBKGI+b+06x52vobtLaObjSoZ8j6tp814dLT
	EEFFuvyAP+89rfm82c3VHOFG2nx4xPBB0dEDk8BczIR4YUzXcwCezJK2L9QQscgU
	HgZO7B+QBlMe8wliwAUOsw2KmlSXa+5Gqaa6RiX900Z65OXGPFNPiply64PRih2H
	5vLFvk6WKeq8vIWUDBNFNLeJThbZ3nxSDaA==
X-ME-Sender: <xms:2K7UZ-saS6l1ArxZ8NJxiPn5MoUbzWaP_RFYxErXQ4FmqhlopbYg8w>
    <xme:2K7UZze0w3HbCPFIYU4RbcXNFXyGdAQ82v08yVYzHNH5yel8zRwTLWe3x10gP7Nmv
    uRP_oKelEJaYSf8jbQ>
X-ME-Received: <xmr:2K7UZ5x9URCOEg1kxpYyi3XjyWxS80GaOPI7foz2ogMaou0JLEsG1PQh7_Wd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepiefffefguddvudekgffhvdeguddv
    udduhfekieeutdejkeejvdeiveefiedulefgnecuffhomhgrihhnpehpthihphgvpggrlh
    hlrdhnvgigthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvth
    eslhifnhdrnhgvth
X-ME-Proxy: <xmx:2K7UZ5MPQIJo7BAeAbcUBZiup_tbgKJa8XMEkXy8x4wPYAsON93kQg>
    <xmx:2K7UZ-93DBUnj71f8jlCfYHxRtQjCJcOQB07Bp1zhlfyo-9UaTDxbQ>
    <xmx:2K7UZxVnSn3qFVcqsNVyzwxw7lZS38GQSDA9fzxt6bg7ynL91xBmmg>
    <xmx:2K7UZ3dTROF4ECK7CZR_X7amkpDTDLS-ZhgU3glpw9tASHQZG79sHA>
    <xmx:2q7UZyQFC2r0F2Nxvt-Qygm-4LtAvdETMCgeK6CEgAY8qU9c1BEOj39N>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 18:34:00 -0400 (EDT)
Date: Fri, 14 Mar 2025 23:33:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 1/2] net: introduce per netns packet chains
Message-ID: <Z9Su1r_EE51ErT3w@krikkit>
References: <cover.1741957452.git.pabeni@redhat.com>
 <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>

2025-03-14, 14:05:00 +0100, Paolo Abeni wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6fa6ed5b57987..00bdd8316cb5e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -572,11 +572,19 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
>  
>  static inline struct list_head *ptype_head(const struct packet_type *pt)
>  {
> -	if (pt->type == htons(ETH_P_ALL))
> -		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
> -	else
> +	if (pt->type == htons(ETH_P_ALL)) {
> +		if (!pt->af_packet_net && !pt->dev)
> +			return NULL;
> +
>  		return pt->dev ? &pt->dev->ptype_specific :

s/specific/all/ ?
(ie ETH_P_ALL with pt->dev should go on &pt->dev->ptype_all like before)

> -				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
> +				 &pt->af_packet_net->ptype_all;
> +	}
> +
> +	if (pt->dev)
> +		return &pt->dev->ptype_specific;
> +
> +	return pt->af_packet_net ? &pt->af_packet_net->ptype_specific :
> +				   &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
>  }

[...]
> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index fa6d3969734a6..8a5d93eb9d77a 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
[...]
> @@ -232,16 +233,15 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>  				goto found;
>  			}
>  		}
> -
> -		nxt = net_hotdata.ptype_all.next;
> -		goto ptype_all;
> +		nxt = net->ptype_all.next;
> +		goto net_ptype_all;
>  	}
>  
> -	if (pt->type == htons(ETH_P_ALL)) {
> -ptype_all:
> -		if (nxt != &net_hotdata.ptype_all)
> +	if (pt->af_packet_net) {
> +net_ptype_all:
> +		if (nxt != &net->ptype_all)
>  			goto found;

This is missing similar code to find items on the new
net->ptype_specific list.

I think something like:

 	if (pt->af_packet_net) {
 net_ptype_all:
-		if (nxt != &net->ptype_all)
+		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
 			goto found;
+		if (nxt == &net->ptype_all) {
+			/* continue with ->ptype_specific if it's not empty */
+			nxt = net->ptype_specific.next;
+			if (nxt != &net->ptype_specific)
+				goto found;
+		}
 
 		nxt = ptype_base[0].next;
 	} else


(and probably something in ptype_get_idx as well)


> -		hash = 0;

hash will now be used uninitialized in the loop a bit later in the
function?

	while (nxt == &ptype_base[hash]) {

> +
>  		nxt = ptype_base[0].next;

-- 
Sabrina

