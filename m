Return-Path: <netdev+bounces-290082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8InqHSQPDmrc5wUAu9opvQ
	(envelope-from <netdev+bounces-290082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:44:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3330598B0D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9220C301E48E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBDF34846A;
	Wed, 20 May 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="n2sbzxLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjwMDlXm"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37353332EBD
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306272; cv=none; b=lXhXtwVLAVGCwqEZkUMLEsLjVWAgXSA94CnWn1uJ87cegDXT4VOARw0fd++jC3nOtoEvLsfxjYaHoQaLMw5SVko7JP38licKfda6Wj/mCh3q7wVByGJgEloLdjSW51xbvL27IRapNBvmebomcQS3fr0dtZyRU+G5I47viHVWBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306272; c=relaxed/simple;
	bh=RKFF7HIHU1YKCeIb37C79khEbeQ5r/Zcbw8yghtUptI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR0k4Skqa+0kaWqM9zRqGEN+s5Xx3E9Wlqo9PFvHYjo2dXMbuNR3aYTS5OMdIT4BzpCbgXU2qX9oWzyqwZ90NoceFrcY+RF60VdfYvam68FrgTH13MilxD9m04MurftwuNJZrdqQQ33ezioaSsg2YYcW3GkVSwcnhSr/cYxJ1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=n2sbzxLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjwMDlXm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1937A7A0091;
	Wed, 20 May 2026 15:44:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 15:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779306267; x=
	1779392667; bh=w9OfuSRzfZvpOWdp3bC6cM8D5Fglt/e2Cj9SGX6eVGg=; b=n
	2sbzxLy3XlhG0odQtpzGRbE0u+0fChhWXVmPZ48ADz0e6Wl1azLDTnX+XijzXGYi
	0O6nLEB120dH+Ty6fuVIuXYLedLr1lhEQmiEBcQxmWcvYHFWai2XPYeLzYDw3X6L
	JBbmyCZPw5Y0CJGxuoN0gpdJ3k4ezTVim1RgbQYAWC6VYy9aXgX1bmbIKODTZnTC
	QFNQ/WASSvV+9XLo+i294Loys46z9BMis2pj2rpiyw+PcStGuwEtYIn7Cg8GGzID
	YTPi5HSNApH0ZCRtLGXl/ycaUhYjdWx4P86XFEmhT0SV01Q5hGpVDZhvDeHDYde0
	kf9XvAD8LUPbyCETfDmyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779306267; x=1779392667; bh=w9OfuSRzfZvpOWdp3bC6cM8D5Fglt/e2Cj9
	SGX6eVGg=; b=BjwMDlXm7HSsSNWzjNYCMGiDNtTCK3Oap8Wl2BwkBj1+ajKisZk
	qBQCf3H5zr0UbGwgOsSXuOCQ8tK0QkXpsH0aR8L2Bbx+rHBE41EEXI5KNKRNGEWO
	Z6AYOtrxv1bmmgHBLEe6ShD0vvmw32Reyn2gIpRevfuReCHqS6bOxWVknYDw0oEi
	wyNGr+uxVujL0oVuTRuYkpqx7Ti1HEpiSj0Bn1q/FgDRwuNHwY29tiDZnSw/ZMS1
	fZkgjD99nt3qAOCc0d12y/8nTIVvtc7KZJUnmmxugHBi5LCbC1+GE0DE94A9mvC6
	0O7DnckN+r0lwHvXMXRzSxZAAgRGFRSgTbw==
X-ME-Sender: <xms:Gw8OavT6_06ZMPJKQNTbDmNxXyuO7oNAGhTX4IeE0Wb1xKZ4Yl7zyg>
    <xme:Gw8Oav0Mzh0Vyk8fkYzXrS99Yv3sMUzA8_wAoI7WKziqMgWmyRofrmpg3RjlZNgeH
    butMIo2Q6_SzF9jOnjnvu4a3L-acUUPGpP0EA7Agubl74FU4s2EuWM>
X-ME-Received: <xmr:Gw8OarCTL8PqXWXFw5c4YFsxxuhVCkE1k8PQlbAQkZCMZlaksUTo9BYSaNFxoKE9Zl3w9hzM7t_wPaUEEn7AvNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhuiigr
    ihhfrghssehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Gw8OargfGxUCUZ-XsGaTgJq_hXrAItHmTFajxZy17q2X5-PbcB2xLw>
    <xmx:Gw8OatNf6lCAWZ9vzDv2tYvjCFlrR0eja3I-oD8d0YigmxXxc8xrmw>
    <xmx:Gw8Oar9cHjfqVIP54byr0C2JLVcMBedJISimiQjxfCySHfKt-hsyKw>
    <xmx:Gw8OaudnGGTJBc2Sm_EEi6bMdWwuK0awEPgYMZ2huJJzAfyoxgjZ2A>
    <xmx:Gw8OamuAsjtptqNp0GjVvt3JmKiCF5h18vusbARXTDvxKtFQDzbBcG1S>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 15:44:26 -0400 (EDT)
Date: Wed, 20 May 2026 21:44:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net v2] net: gro: don't merge zcopy skbs
Message-ID: <ag4PGDC8ZjtS9z9C@krikkit>
References: <9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F3330598B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-20, 17:18:37 +0200, Sabrina Dubroca wrote:
> skb_gro_receive() can currently copy frags between the source and GRO
> skb, without checking the zerocopy status, and in particular the
> SKBFL_MANAGED_FRAG_REFS flag.
> 
> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> on the pages in shinfo->frags. Appending those frags to another skb's
> frags without fixing up the page refcount can lead to UAF.
> 
> When either the last skb in the GRO chain (the one we would append
> frags to) or the source skb is zerocopy, don't merge the skbs.
> 
> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> Assisted-by: Claude:claude-mythos-preview
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/core/gro.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v2: as Eric suggested, don't merge those skbs
> v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/
> 
> Huzaifa has found this to be exploitable to overwrite the page cache
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..b22fb3ba7061 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  	if (p->pp_recycle != skb->pp_recycle)
>  		return -ETOOMANYREFS;
>  
> +	if (skb_zcopy(skb) || skb_zcopy(lp))
> +		return -ETOOMANYREFS;

Ugh I need holidays...

lp isn't initialized here. Sorry.

-- 
Sabrina

