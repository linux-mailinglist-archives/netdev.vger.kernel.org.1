Return-Path: <netdev+bounces-265665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGTzIfcFr2knLwIAu9opvQ
	(envelope-from <netdev+bounces-265665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:40:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319523DBDA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98AD302C6F7
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C832F068C;
	Mon,  9 Mar 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="RVEWjUQT"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2D2EFDBA
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077839; cv=none; b=S6C9nOS9F7SxxXHN+kDoWh6X9g28r8NYZfgEQ8F5bK4/oBB41QIokzEyziGKAkiYgrWylJEjkxSUg6sQNE1NsPT4mjr9HecDFyvTBPSp7LtKnLp/ccMlxhohVi8RBJC0OZz91llxZOT6P9irTHjYFCFoLsUD4DLVfE+hNxNzifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077839; c=relaxed/simple;
	bh=lhdWjsxTf2lIiRTeEMbmfr0YCXcVg4omPfLb4PUw7Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY473EmQIScDzyQVk3bDTF11wJ89HEIEg83OJbs54FpZOvx//WiLq/V+NS3bY04vwdICD273fZvBd9WPY6z6StdPz6xYH9ThgLLYZ8sRckJYmCLtVscWqGsS5pzbUDEoqNgXb4XMz2Kg0CmBUhRg7YMfZjwcHDAE7dy5LjGwAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=RVEWjUQT; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1773077827; x=1773941828; bh=lhdW
	jsxTf2lIiRTeEMbmfr0YCXcVg4omPfLb4PUw7Eg=; b=RVEWjUQTTR5FxAqcw156
	si/Kbx/QslZYnj6lcserrtQqNkXIgOByQQRQ52nnoR3enNHypXVeSaX7o9o2rmjs
	OUHMCsjJQ/i6Ih7gUdmNbde3eOZU4VIUg/P8RLLA4kXSxXkJ1thO7TEfVq7NnPHc
	OrQrK2RJo3GQJfVzc/v7jZJaTQuvMML1JEH65fzTd9l7jntJ2AIGaO7hSq8Z+mah
	H/idFu/cbT3pwYRwi8NbYMMSz+yiPfUK8mOt29KgCP4sDZJop00Hl0uG8IYxem+t
	aykyPon0skFuguyZ+v41JFrs3/cTjGYU1msGQYr+33xYVH4aT6xW+I1/70W80ngj
	Zw==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 09 Mar 2026 18:37:06 +0100 (CET)
Date: Mon, 9 Mar 2026 18:37:04 +0100
From: Antony Antony <antony@phenome.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, chopps@labn.net, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, Hao Long <me@imlonghao.com>
Subject: Re: [PATCH ipsec v2] xfrm: iptfs: fix skb_put() panic on non-linear
 skb during reassembly
Message-ID: <aa8FQEdKU9lNnGDv@Antony2201.local>
References: <20260304140935.19783-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304140935.19783-1-fmancera@suse.de>
X-Mutt-References: <20260304140935.19783-1-fmancera@suse.de>
X-Mutt-Fcc: ~/sent
X-Rspamd-Queue-Id: 1319523DBDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[phenome.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:09:35PM +0100, Fernando Fernandez Mancera wrote:
> In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
> packet 'newskb' that is being reassembled. First a zero-copy approach is
> tried if it succeeds then newskb becomes non-linear.
> 
> When a subsequent fragment in the same datagram does not meet the
> fast-path conditions, a memory copy is performed. It calls skb_put() to
> append the data and as newskb is non-linear it triggers
> SKB_LINEAR_ASSERT check.

I wonder if linearizing has a performance penalty? Did you test that?

I tried to reproduce it but had no luck so far. It seems the NICs I tested,
CX4 and virtio, veth, deliver the inner packet as a linear skb.

Any tricks to force Mellanox CX4 and virtio to deliver
non-linear skbs?

-antony

> 
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>  [...]
>  RIP: 0010:skb_put+0x3c/0x40
>  [...]
>  Call Trace:
>   <IRQ>
>   iptfs_reassem_cont+0x1ab/0x5e0 [xfrm_iptfs]
>   iptfs_input_ordered+0x2af/0x380 [xfrm_iptfs]
>   iptfs_input+0x122/0x3e0 [xfrm_iptfs]
>   xfrm_input+0x91e/0x1a50
>   xfrm4_esp_rcv+0x3a/0x110
>   ip_protocol_deliver_rcu+0x1d7/0x1f0
>   ip_local_deliver_finish+0xbe/0x1e0
>   __netif_receive_skb_core.constprop.0+0xb56/0x1120
>   __netif_receive_skb_list_core+0x133/0x2b0
>   netif_receive_skb_list_internal+0x1ff/0x3f0
>   napi_complete_done+0x81/0x220
>   virtnet_poll+0x9d6/0x116e [virtio_net]
>   __napi_poll.constprop.0+0x2b/0x270
>   net_rx_action+0x162/0x360
>   handle_softirqs+0xdc/0x510
>   __irq_exit_rcu+0xe7/0x110
>   irq_exit_rcu+0xe/0x20
>   common_interrupt+0x85/0xa0
>   </IRQ>
>   <TASK>
> 
> Fix this by checking if the skb is non-linear. If it is, linearize it by
> calling skb_linearize(). As the initial allocation of newskb originally
> reserved enough tailroom for the entire reassembled packet we do not
> need to check if we have enough tailroom or extend it.
> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Reported-by: Hao Long <me@imlonghao.com>
> Closes: https://lore.kernel.org/netdev/DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: adjusted fixes tag and dropped skb_is_nonlinear() as skb_linearize()
> is enough.
> ---
>  net/xfrm/xfrm_iptfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 050a82101ca5..c96bec84bfa6 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -901,6 +901,12 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>  	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
>  		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
>  	} else {
> +		if (skb_linearize(newskb)) {
> +			XFRM_INC_STATS(xs_net(xtfs->x),
> +				       LINUX_MIB_XFRMINBUFFERERROR);
> +			goto abandon;
> +		}
> +
>  		/* copy fragment data into newskb */
>  		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
>  				      copylen)) {
> -- 
> 2.53.0
> 
> 


