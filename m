Return-Path: <netdev+bounces-266961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BlKH5uJsml4NQAAu9opvQ
	(envelope-from <netdev+bounces-266961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E222726FB26
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68EC33063AD6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CEB3B894C;
	Thu, 12 Mar 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TiyHsAHX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4883B8934
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308272; cv=none; b=J6sUREEqEZNbZv6EAAZW+kQ/CXkK0iurCnXX1XM6VJs+tc2DBljBLnY5J/N/wOkRwC8Sv0GIiDs9DwMLOF34tl+oX02WQldS+zQwcXTkGV3Fe4zRCbMnWx0OQEQ8FxZfFsIGrxTg/0JrpmY2nYZsFFa+Y29lRybHpc0tK3NRyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308272; c=relaxed/simple;
	bh=GVTx0aICEl1sexvjaWQDs0Ao9QyPU+Wgn0nKaJJnfd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWOiWtIptlJ5tTgEoAOEnhYi3eVVeR0Y2c1kmsA3la0W5vwiGybYih5/MNYTXhZwcQToDstzDkNVXrnltSsukQa/Hl3nkEtCIcdjbjsk6/r1STYVr8fQnj7YOa+hVeay4QODVqU+fqPcUHz3yPls20AmaFgjMFq22AHOhOQVYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TiyHsAHX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A2A5F207E4;
	Thu, 12 Mar 2026 10:37:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SMIG07uzVm5c; Thu, 12 Mar 2026 10:37:42 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 96DF020660;
	Thu, 12 Mar 2026 10:37:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 96DF020660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773308262;
	bh=3hDlKexcWSFjHGP7egx6KKrXleEikrwgK4OL8b1DQRw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=TiyHsAHX1nR1+niRd5sueuGw7ATMeVbyQmxqOox9S9w4SRmmwFLHsA8VLkv0Zd41l
	 2Zfxg0WdnPDcwJN3xIUrtVwEXY2xIF/qxt7Uc25tDPeVXEpXoARmruiq7OOebhu2iK
	 n4SFSD4hMPLQzvkeqI/V4mx6r27B8LfCs4kzzufPSmKcjxznC9lSvJbozVjvyoBemk
	 VBJ+ZqHntzihcYsaL8fOBFEFZIpCLgxww+yohtpQg9WVn71pDu0cICqqUoUIJCHFsX
	 LsLfAnrENYsixQU3LYMDsEoNZs3yi+X44oUGMaTLFpZ0NTKd/xBym/HMQik3mEqp3E
	 3PdiMaACff5SA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 10:37:41 +0100
Received: (nullmailer pid 2516229 invoked by uid 1000);
	Thu, 12 Mar 2026 09:37:40 -0000
Date: Thu, 12 Mar 2026 10:37:40 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Tobias Brunner
	<tobias@strongswan.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	<devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next] esp: Consolidate esp4 and esp6.
Message-ID: <abKJZHIr2THzZk09@secunet.com>
References: <aZ_8Adz1m47-yzhp@secunet.com>
 <aaVzz834HRXnR-to@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaVzz834HRXnR-to@krikkit>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strongswan.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E222726FB26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 02, 2026 at 12:26:07PM +0100, Sabrina Dubroca wrote:
> 2026-02-26, 08:53:37 +0100, Steffen Klassert wrote:
> > This patch merges common code of esp4.c and esp6.c into
> > xfrm_esp.c. This almost halves the size of the ESP
> > implementation for the price of three indirect calls
> > on UDP/TCP encapsulation. No functional changes.
> > 
> > Changes from the RFC version:
> > 
> > - Fix a typo in the commit mesage.
> 
> the commit "mesage"? :)

It was not AI generated :)

> > - Remove some old comments that don't make sense anymore.
> > 
> > - Let the ->input_encap functions return the needed offsets.
> > 
> > - Remove the IP_MAX_MTU check from UDP/TCP encap.
> >   The IPv4/IPv6 local_out function will do that ceck later.
> > 
> > - The comment on IPv4 ESP offload with UDP encapsulation
> >   is true for IPv4 and IPv6, so remove the IPv4 from the
> >   comment.
> > 
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > Tested-by: Tobias Brunner <tobias@strongswan.org>
> > ---
> >  include/net/esp.h       |    6 +
> >  include/net/xfrm.h      |    4 +
> >  net/ipv4/esp4.c         | 1065 ++------------------------------------
> >  net/ipv6/esp6.c         | 1081 ++-------------------------------------
> >  net/ipv6/esp6_offload.c |    6 +-
> >  net/xfrm/Makefile       |    1 +
> >  net/xfrm/xfrm_esp.c     | 1017 ++++++++++++++++++++++++++++++++++++
> >  7 files changed, 1132 insertions(+), 2048 deletions(-)
> >  create mode 100644 net/xfrm/xfrm_esp.c
> > 
> > diff --git a/include/net/esp.h b/include/net/esp.h
> > index 322950727dd0..5761c762c69a 100644
> > --- a/include/net/esp.h
> > +++ b/include/net/esp.h
> > @@ -47,4 +47,10 @@ int esp_input_done2(struct sk_buff *skb, int err);
> >  int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *esp);
> >  int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *esp);
> >  int esp6_input_done2(struct sk_buff *skb, int err);
> 
> Those 3 are gone now and can be removed.

Done.

> > +int esp_init_aead(struct xfrm_state *x, struct netlink_ext_ack *extack);
> > +int esp_init_authenc(struct xfrm_state *x, struct netlink_ext_ack *extack);
> > +void esp_destroy(struct xfrm_state *x);
> > +int esp_input(struct xfrm_state *x, struct sk_buff *skb);
> > +int esp_output(struct xfrm_state *x, struct sk_buff *skb);
> > +
> >  #endif
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 0a14daaa5dd4..e3217cafe582 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -455,7 +455,11 @@ struct xfrm_type {
> >  					      struct netlink_ext_ack *extack);
> >  	void			(*destructor)(struct xfrm_state *);
> >  	int			(*input)(struct xfrm_state *, struct sk_buff *skb);
> > +	int			(*input_encap)(struct sk_buff *skb, struct xfrm_state *x);
> >  	int			(*output)(struct xfrm_state *, struct sk_buff *pskb);
> > +	struct sock		*(*find_tcp_sk)(struct xfrm_state *x);
> > +	void			(*output_encap_csum)(struct sk_buff *skb);
> > +	int			(*output_tcp_encap)(struct xfrm_state *x, struct sk_buff *skb);
> 
> This CB is unused.

Removed.

> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index 2c922afadb8f..6c5568a96f0a 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> [...]
> > +static int esp4_input_encap(struct sk_buff *skb, struct xfrm_state *x)
> >  {
> > +	const struct iphdr *iph = ip_hdr(skb);
> > +	int ihl = iph->ihl * 4;
> >  	struct xfrm_encap_tmpl *encap = x->encap;
> [...]
> > +	struct tcphdr *th = (void *)(skb_network_header(skb) + ihl);
> > +	struct udphdr *uh = (void *)(skb_network_header(skb) + ihl);
> > +	int ret = 0;
> > +	__be16 source;
> >  
> > +	switch (x->encap->encap_type) {
> >  	case TCP_ENCAP_ESPINTCP:
> > -		esph = esp_output_tcp_encap(x, skb, esp);
> > +		source = th->source;
> > +		ret -= sizeof(struct tcphdr);
> 
> I'm trying to check how all those offset combine, isn't that
> susceptible to the same problem as 17175d1a27c6 ("xfrm: esp6: fix
> encapsulation header offset computation")?
> 
> Also, since those new ->input_encap should return a negative value on
> success, the "return -1" for error is a bit confusing.

Yes, that was to align with IPv6, ipv6_skip_exthdr() returns a negative
value. I did not expect this and got a crash on my first try.

> Maybe:
>  - make them return +1 on error, without going through "goto out"
>    (return -1 on error should be fine since that's not an expected
>    offset)
>  - make the final return (the one that returns the negative offset)
>    have a DEBUG_NET_WARN_ON_ONCE(ret >= 0)
> 
> Or if my math is correct, the caller's hdr_len after adding
> ->input_encap's return value is the full length of the ipv* header
> including options/extensions, so let ->input_encap return that
> directly instead of doing the "hdr_len += ret" dance (and keep the
> return -1 on error)? That would make things a bit clearer than
> "skb_network_header_len + skb_network_offset + [whatever
> ipv6_skip_exthdr returns]".

I'll try to make this a bit clearer in the next version.

> [...]
> > @@ -1164,13 +194,16 @@ static int esp4_rcv_cb(struct sk_buff *skb, int err)
> >  
> >  static const struct xfrm_type esp_type =
> >  {
> > -	.owner		= THIS_MODULE,
> > -	.proto	     	= IPPROTO_ESP,
> > -	.flags		= XFRM_TYPE_REPLAY_PROT,
> > -	.init_state	= esp_init_state,
> > -	.destructor	= esp_destroy,
> > -	.input		= esp_input,
> > -	.output		= esp_output,
> > +	.owner			= THIS_MODULE,
> > +	.proto	     		= IPPROTO_ESP,
> 
> nit: since you're reworking the whitespace, this is:
> 
> \t.proto\t     \t\t= IPPROTO_ESP,
> 
> (with a few spaces in the middle)

Fixed.

> [...]
> > diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> > index e75da98f5283..b90e93fc1a70 100644
> > --- a/net/ipv6/esp6.c
> > +++ b/net/ipv6/esp6.c
> [...]
> > -int esp6_input_done2(struct sk_buff *skb, int err)
> > -{
> [...]
> > -		/*
> > -		 * 2) ignore UDP/TCP checksums in case
> > -		 *    of NAT-T in Transport Mode, or
> > -		 *    perform other post-processing fixes
> > -		 *    as per draft-ietf-ipsec-udp-encaps-06,
> > -		 *    section 3.1.2
> > -		 */
> > -		if (x->props.mode == XFRM_MODE_TRANSPORT)
> > -			skb->ip_summed = CHECKSUM_UNNECESSARY;
> >  	}
> >  
> > -	skb_postpull_rcsum(skb, skb_network_header(skb),
> > -			   skb_network_header_len(skb));
> 
> This doesn't get carried over to the new common function
> esp_input_done2. It originally came from commit a9b28c2bf05d ("esp6:
> Fix RX checksum after header pull"), not sure if it's still needed but
> I guess so?

I think this skb_postpull_rcsum() is misplaced here, and the
skb_pull_rcsum() call below as well. esp_input and esp6_input do:

skb->ip_summed = CHECKSUM_NONE;

So both function do nothing because the checksum is recomputed
anyway. The only case where we need this is HW offloding because
this does not call esp_input/esp6_input. So both function calls
skb_postpull_rcsum() and skb_pull_rcsum() should go to 
esp6_input_tail, and maybe even to esp_input_tail. Looks like
esp4 has the same problem, but we do it just for esp6.

I'll move these calls in the next version.

> > -	skb_pull_rcsum(skb, hlen);
> > -	if (x->props.mode == XFRM_MODE_TUNNEL ||
> > -	    x->props.mode == XFRM_MODE_IPTFS)
> > -		skb_reset_transport_header(skb);
> > -	else
> > -		skb_set_transport_header(skb, -hdr_len);
> > -
> > -	/* RFC4303: Drop dummy packets without any error */
> > -	if (err == IPPROTO_NONE)
> > -		err = -EINVAL;
> > -
> > -out:
> > -	return err;
> > -}
> > -EXPORT_SYMBOL_GPL(esp6_input_done2);
> 
> [...]
> > diff --git a/net/xfrm/xfrm_esp.c b/net/xfrm/xfrm_esp.c
> > new file mode 100644
> > index 000000000000..f277dc114ba6
> > --- /dev/null
> > +++ b/net/xfrm/xfrm_esp.c
> [...]
> > +
> > +
> > +#ifdef CONFIG_INET_ESPINTCP
> > +static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
> > +						    struct sk_buff *skb,
> > +						    struct esp_info *esp)
> 
> nit: alignment
> 
> (checkpatch complains about this and a few other whitespace things in
> this new file, probably all carried over from the existing code)

Fixed.

> [...]
> > +EXPORT_SYMBOL_GPL(esp_init_authenc);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Generic ESP");
> > +
> 
> nit: git complains about the empty line

Fixed.

Thank a lot for your review Sabrina!

