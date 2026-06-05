Return-Path: <netdev+bounces-295546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZO1KP4lImqPTAEAu9opvQ
	(envelope-from <netdev+bounces-295546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:27:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22354644679
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:27:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=common-net.org header.s=mail header.b="GnujR/id";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=common-net.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24C60302F4D8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C1390205;
	Fri,  5 Jun 2026 01:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.common-net.org (mail.common-net.org [139.28.148.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429F3ACA40;
	Fri,  5 Jun 2026 01:27:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622842; cv=none; b=IwsUNcZqvs0nHh4E23jXOesl86rMROczqNkY0skSVKQnULQNm8BV74YSi78IvG3UsmcI6uCmVXVY+nhWv2QysEy5zIgx2pEec/THgkHzOcV3NSb2kVQFNn1MX970691BtMCJsiAFRt+jp2O60CY8+gsS4oIxJBVM8uWLp4rewf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622842; c=relaxed/simple;
	bh=EkcKrqemSCY0yi6n9Ks+W0G6p9umKM5KsvIETQ42Lhw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KCGRJSyNQcv5RlUSfCvaUS7XycUxjru0byYEaf4jFWDogKE++fDJCHACR6mW/tw/SbJii+//JQWPjJKWGkh3s5mdAfQ/rUJmbaQ0+0pl0eoIBEMHCqgcmCSdfK1p1RiyYovIWFh20t30nQbOFvsrpAfhXAvVd55sxQrtH1G+YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=common-net.org; spf=pass smtp.mailfrom=common-net.org; dkim=pass (1024-bit key) header.d=common-net.org header.i=@common-net.org header.b=GnujR/id; arc=none smtp.client-ip=139.28.148.254
Received: from lubuntu-18.04 (host-87-1-225-234.retail.telecomitalia.it [87.1.225.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.common-net.org (Postfix) with ESMTPSA id 07DBD6D20B88;
	Fri,  5 Jun 2026 03:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=common-net.org;
	s=mail; t=1780622402;
	bh=EkcKrqemSCY0yi6n9Ks+W0G6p9umKM5KsvIETQ42Lhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnujR/idGnSi5mGQRyJpB5v7OxJ9uhhF0OB6ssCQOxa36Ge0tb0ayPT/7fwiMX34b
	 i3K0zZCAYN2LKE7DjNZJVtutm7xJhcpelM43O7i0CH8LX8W04A7BfS/RWJKLoeN3rV
	 08T1XsUzlLspHeuxtLQmLo1zBHY+8swP6ca913qM=
Date: Fri, 5 Jun 2026 03:20:01 +0200
From: Andrea Mayer <andrea@common-net.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, stefano.salsano@uniroma2.it, ahabdels@cisco.com,
 Andrea Mayer <andrea.mayer@uniroma2.it>, andrea@common-net.org
Subject: Re: [PATCH v2 3/7] seg6: add End.M.GTP6.E behavior
Message-Id: <20260605032001.2f46e6a55f69896d29da69df@common-net.org>
In-Reply-To: <20260505-seg6-mobile-v2-3-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260505-seg6-mobile-v2-3-9e8022bdfdb6@gmail.com>
Organization: Common Net
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[common-net.org,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[common-net.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295546-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com,common-net.org];
	FORGED_RECIPIENTS(0.00)[m:yuya.kusakabe@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[common-net.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22354644679

On Tue, 05 May 2026 01:30:13 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

I do not repeat below the points from my cover letter and patch 1-2 replies
(drop reasons, OIF/VRF removal, C helper, coding style, etc.).

> Add the End.M.GTP6.E behavior (RFC 9433 Section 6.5), the IPv6 dual
> of End.M.GTP4.E.  An End.M.GTP6.E SID always sits in the penultimate
> position of an SR Policy (RFC 9433 Section 6.5 Notes); when it
> becomes the active SID (segments_left == 1) the kernel pops the
> IPv6/SRH outer, recovers TEID and QFI from the 40-bit
> Args.Mob.Session field encoded in the locator-relative slice of the
> SID, and re-encapsulates the inner T-PDU in IPv6/UDP/GTP-U toward
> the next segment held in SRH[0].
> 
> The flow info, traffic class and hop limit are propagated from the
> inbound IPv6 outer to the new outer (RFC 6040).
> 
> When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
> NF_INET_PRE_ROUTING between the SRv6 strip and the GTP-U push,
> mirroring End.DX4 / End.DX6.
> 
> Configuration:
> 
>   ip -6 route add 2001:db8:e::/64 \
>       encap seg6local action End.M.GTP6.E src 2001:db8:2::1 \
>       dev <dev>

SEG6_LOCAL_MOBILE_SRC_ADDR (the "src" attribute) is copied verbatim into
the outer IPv6 source address. In patch 2 (End.M.GTP4.E) the same
attribute is used as a template from which bits are extracted to form
the IPv4 source address, and may be entirely unused depending on
v4_mask_len.
This UAPI overload needs revision.

>
> Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.5
> Link: https://www.rfc-editor.org/rfc/rfc6040
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  include/uapi/linux/seg6_local.h                    |   2 +
>  net/ipv6/seg6_local.c                              | 312 ++++++++++++++++
>  tools/testing/selftests/net/Makefile               |   1 +
>  .../selftests/net/srv6_end_m_gtp6_e_test.sh        | 402 +++++++++++++++++++++
>  4 files changed, 717 insertions(+)
> 
> diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
> index b42cb526bb81..8e46ede2980d 100644
> --- a/include/uapi/linux/seg6_local.h
> +++ b/include/uapi/linux/seg6_local.h
> @@ -75,6 +75,8 @@ enum {
>  	SEG6_LOCAL_ACTION_END_MAP	= 17,
>  	/* SRv6 to IPv4/GTP-U encap (RFC 9433 Section 6.6) */
>  	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
> +	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
> +	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
>  
>  	__SEG6_LOCAL_ACTION_MAX,
>  };
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 4051fe89e6d1..4e5d138c3657 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c

> + [snip]

> +static int input_action_end_m_gtp6_e_finish(struct net *net,
> +					    struct sock *sk,
> +					    struct sk_buff *skb)
> +{
> +	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_NOMEM;
> +	struct seg6_mobile_gtp6_e_cb cb = *SEG6_MOBILE_GTP6_E_CB(skb);
> +	struct dst_entry *orig_dst = skb_dst(skb);
> +	const struct seg6_mobile_info *minfo;
> +	struct seg6_local_lwt *slwt;
> +	struct ipv6hdr *new_ip6h;
> +	struct udphdr *uh;
> +
> +	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	minfo = &slwt->mobile_info;
> +

Same dst/lwtstate issue as patch 2.

> +	/* Reject GSO packets that would not fit the egress IPv6/UDP/GTP-U
> +	 * path after our outer headers are added; the GSO segmenter cannot
> +	 * adjust mss across SRv6 -> GTP-U conversion.  Skip the check
> +	 * entirely when no MTU is known on the current dst.
> +	 */
> +	if (skb_is_gso(skb)) {
> +		unsigned int ovhd = sizeof(*new_ip6h) + sizeof(*uh) +
> +				    sizeof(struct gtp1_header_long) +
> +				    sizeof(struct seg6_mobile_pdu_session_ext);
> +		unsigned int mtu = dst_mtu(skb_dst(skb));
> +
> +		if (mtu && (mtu <= ovhd ||
> +			    !skb_gso_validate_network_len(skb, mtu - ovhd))) {
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_MTU_EXCEEDED;
> +			goto drop;
> +		}
> +	}
> +
> +	/* Reserve worst-case headroom for the entire outer chain we are about
> +	 * to push: IPv6 + UDP + GTP-U long header + PDU Session extension.
> +	 * Subsequent skb_cow_head() calls inside seg6_mobile_push_gtpu() then
> +	 * become no-ops.
> +	 */
> +	if (skb_cow_head(skb,
> +			 sizeof(*new_ip6h) + sizeof(*uh) +
> +			 sizeof(struct gtp1_header_long) +
> +			 sizeof(struct seg6_mobile_pdu_session_ext)))

Same ovhd scoping point as patch 2.

> +		goto drop;
> +

Same missing iptunnel_handle_offloads() as patch 2.

> +	if (seg6_mobile_push_gtpu(skb, cb.teid, cb.qfi, cb.pdu_type,
> +				  cb.pdu_type_set))
> +		goto drop;
> +
> +	uh = skb_push(skb, sizeof(*uh));
> +	skb_reset_transport_header(skb);
> +	uh->source = htons(GTP1U_PORT);
> +	uh->dest = htons(GTP1U_PORT);
> +	uh->len = htons(skb->len);
> +

Same fixed source port question as patch 2.

> +	new_ip6h = skb_push(skb, sizeof(*new_ip6h));
> +	skb_reset_network_header(skb);
> +	memset(new_ip6h, 0, sizeof(*new_ip6h));
> +	ip6_flow_hdr(new_ip6h, cb.tclass, cb.flowlabel);
> +	new_ip6h->payload_len = htons(skb->len - sizeof(*new_ip6h));
> +	new_ip6h->nexthdr = IPPROTO_UDP;
> +	new_ip6h->hop_limit = cb.hop_limit;
> +	new_ip6h->saddr = minfo->src_addr;
> +	new_ip6h->daddr = cb.next_sid;
> +
> +	/* RFC 8200 requires UDP/IPv6 checksums.  Initialise the
> +	 * pseudo-header sum and let the stack/NIC complete it via
> +	 * CHECKSUM_PARTIAL so we do not pay a per-packet linear sum and
> +	 * we cooperate with offload.
> +	 */
> +	skb->ip_summed = CHECKSUM_PARTIAL;
> +	skb->csum_start = (unsigned char *)uh - skb->head;
> +	skb->csum_offset = offsetof(struct udphdr, check);
> +	uh->check = ~csum_ipv6_magic(&new_ip6h->saddr, &new_ip6h->daddr,
> +				     skb->len - sizeof(*new_ip6h),
> +				     IPPROTO_UDP, 0);
> +

udp6_set_csum() already handles the CHECKSUM_PARTIAL + pseudo-header seed
setup and also covers the GSO case. Using it would avoid open-coding this
sequence.

> +	skb->protocol = htons(ETH_P_IPV6);
> +	nf_reset_ct(skb);
> +	skb_dst_drop(skb);
> +
> +	seg6_lookup_any_nexthop(skb, &cb.next_sid, 0, false, slwt->oif);
> +	return dst_input(skb);
> +
> +drop:
> +	kfree_skb_reason(skb, reason);
> +	return -EINVAL;
> +}

seg6_lookup_any_nexthop() already calls skb_dst_drop() internally. The
explicit call above is redundant.

> + [snip]

> +static int input_action_end_m_gtp6_e(struct sk_buff *skb,
> +				     struct seg6_local_lwt *slwt)
> +{
> +	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
> +	const struct seg6_mobile_info *minfo = &slwt->mobile_info;
> +	struct seg6_mobile_gtp6_e_cb *cb;
> +	struct in6_addr next_sid;
> +	struct ipv6_sr_hdr *srh;
> +	u8 hop_limit, tclass, qfi;
> +	unsigned int outer_len;
> +	struct ipv6hdr *ip6h;
> +	int inner_nfproto;
> +	__be32 flowlabel;
> +	__be16 frag_off;
> +	u64 args_mob;
> +	u32 teid;
> +	int off;
> +	u8 nh;
> +

Same reverse Christmas tree issue as patch 2.

> + [snip]

> +	/* RFC 6040 outer-to-outer propagation: copy DSCP+ECN (tclass) and
> +	 * the flow label from the SRv6 outer to the new IPv6 outer.  Use
> +	 * ip6_flowlabel() (not ip6_flowinfo()) so the tclass byte is
> +	 * supplied exactly once via the @tclass argument of ip6_flow_hdr().
> +	 */
> +	flowlabel = ip6_flowlabel(ip6h);
> +	tclass = ipv6_get_dsfield(ip6h);
> +	hop_limit = ip6h->hop_limit;
> +

Same RFC 6040 question as patch 2 (here also flow label).

> +	/* RFC 9433 Section 6.5 upper-layer S02 mandates "Pop the IPv6
> +	 * header and all its extension headers".  ipv6_skip_exthdr()
> +	 * walks every extension header (HBH/Routing/Dest-Opts/Fragment)
> +	 * so HBH-before-SRH and DOpts-after-SRH are handled too.  The
> +	 * terminal next-header value also selects NFPROTO_IPV4 /
> +	 * NFPROTO_IPV6 for the NF_INET_PRE_ROUTING hook below.
> +	 */
> +	nh = ip6h->nexthdr;
> +	off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh, &frag_off);
> +	if (off < 0) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +	outer_len = off;
> +

Same BAD_INNER misuse as patch 2.

Same frag_off check missing after ipv6_skip_exthdr() as patch 2.

> + [snip]

> +	/* For inner IP traffic that may traverse NF_INET_PRE_ROUTING below,
> +	 * pull the full inner IP header into the linear area so a netfilter
> +	 * hook reading skb_transport_header() does not access stale data.
> +	 * Non-IP inner is forwarded as-is via the GTP-U T-PDU payload.
> +	 */
> +	if (!pskb_may_pull(skb, outer_len + ((inner_nfproto == NFPROTO_IPV4) ?
> +					     sizeof(struct iphdr) :
> +					     (inner_nfproto == NFPROTO_IPV6) ?
> +					     sizeof(struct ipv6hdr) : 0))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +

Same repeated ternary as patch 2.

> + [snip]

>  static struct seg6_action_desc seg6_action_table[] = {
>  	{
> @@ -2153,6 +2431,17 @@ static struct seg6_action_desc seg6_action_table[] = {
>  			.build_state = seg6_mobile_v4_validate,
>  		},
>  	},
> +	{
> +		.action		= SEG6_LOCAL_ACTION_END_M_GTP6_E,
> +		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_MOBILE_SRC_ADDR),
> +		.optattrs	= SEG6_F_LOCAL_COUNTERS |
> +				  SEG6_F_ATTR(SEG6_LOCAL_MOBILE_PDU_TYPE) |
> +				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
> +		.input		= input_action_end_m_gtp6_e,
> +		.slwt_ops	= {
> +			.build_state = seg6_mobile_gtp6_e_validate,
> +		},
> +	},

> + [snip]

> +/* End.M.GTP6.E SID layout (RFC 9433 Section 6.5):
> + *
> + *   | locator (route prefix)  | Args.Mob.Session (40) | pad |
> + *
> + * The locator length is the route's IPv6 destination prefix length.
> + * Reject route additions whose prefix leaves no room for the 40-bit
> + * Args.Mob.Session field at setup time so the operator gets a clear
> + * error from `ip route add` instead of silent per-packet drops.
> + */
> +static int seg6_mobile_gtp6_e_validate(struct seg6_local_lwt *slwt,
> +				       const void *cfg,
> +				       struct netlink_ext_ack *extack)
> +{
> +	const struct fib6_config *fib6_cfg = cfg;
> +
> +	if ((unsigned int)fib6_cfg->fc_dst_len + SEG6_MOBILE_ARGS_MOB_LEN > 128) {

Nit: fc_dst_len is int in struct fib6_config (IPv6 prefix length, range
0..128); the (unsigned int) cast is not needed.

> + [snip]

Thanks,

Ciao,
Andrea

P.S. I am temporarily writing from another address due to a mail
delivery issue at my @uniroma2.it address. Please always Cc my default
andrea.mayer@uniroma2.it address on replies.

