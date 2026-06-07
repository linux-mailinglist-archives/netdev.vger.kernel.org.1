Return-Path: <netdev+bounces-296167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SHk0C9i1JGp/+gEAu9opvQ
	(envelope-from <netdev+bounces-296167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9308864E8D5
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=common-net.org header.s=mail header.b=qMAAXsVe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296167-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=common-net.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A85D30154AF
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A01F5EA;
	Sun,  7 Jun 2026 00:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.common-net.org (mail.common-net.org [139.28.148.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F226FC5;
	Sun,  7 Jun 2026 00:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790735; cv=none; b=DMCgme0SeviPhiB12w1fSo2v9KQKWm4F82cTPWFEqfgGdolRF1hcW5InKXAxIl937lCXbg4R1rE6ol6yIEWMN7RroC5TpK3w9qyft328OG5/s3J2j8nHb6czE/68AOXaaAnQXik2kZHfo99UpurSyOJ3D1hGb6d+nyBCLgRzgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790735; c=relaxed/simple;
	bh=NWFBCu2B/hOgRgPYBbtOPgraJi3Lq7X64mNbNbI7pl4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nk5fPLEHqXwjtGG760PYlMdHp8ik4uqfF62KwbjaV+oe17S9LVaIAWWDPkOyjgOiv09NAqNxMtOxkh5LgIDxblv6et3XpvS5UfKm3EhFYROJyMEgI9+oHPy9CcfwSAiuctp4zC74fCcDJ6iG4hSFTt3IHTjb21F1zgowKovyEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=common-net.org; spf=pass smtp.mailfrom=common-net.org; dkim=pass (1024-bit key) header.d=common-net.org header.i=@common-net.org header.b=qMAAXsVe; arc=none smtp.client-ip=139.28.148.254
Received: from lubuntu-18.04 (host-80-116-255-177.pool80116.interbusiness.it [80.116.255.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.common-net.org (Postfix) with ESMTPSA id 567626D20B88;
	Sun,  7 Jun 2026 02:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=common-net.org;
	s=mail; t=1780790723;
	bh=NWFBCu2B/hOgRgPYBbtOPgraJi3Lq7X64mNbNbI7pl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qMAAXsVeSxWgOk5gZfdwKiZQxM5kheGaws4prN9liZO8ncfVar4NiO7Kdg3LRI9O4
	 KWP7Q+FU4hQPpF73ycC9XOpyO+XfsX95oxVBY+s/OxZx7YbPMvQKCnPSZIBDI5rNkx
	 Hfzo/7HaVQooibNcARn/uRvzDF0RJ7EBV9Gl3tVM=
Date: Sun, 7 Jun 2026 02:05:17 +0200
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
Subject: Re: [PATCH v2 4/7] seg6: add End.M.GTP6.D behavior
Message-Id: <20260607020517.0c6bbb8beba505ac9447545e@common-net.org>
In-Reply-To: <20260505-seg6-mobile-v2-4-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260505-seg6-mobile-v2-4-9e8022bdfdb6@gmail.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:yuya.kusakabe@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,uniroma2.it,cisco.com,common-net.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea@common-net.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[common-net.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniroma2.it:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9308864E8D5

On Tue, 05 May 2026 01:30:14 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

I do not repeat below the points from my cover letter and patch 1-3 replies
(drop reasons, OIF/VRF removal, C helper, coding style, etc.).

> Add the End.M.GTP6.D headend behavior (RFC 9433 Section 6.3), which
> receives an IPv6/UDP/GTP-U packet matching a locally instantiated
> End.M.GTP6.D SID and re-encapsulates the inner T-PDU in SRv6 using
> the configured SR Policy.  TEID and QFI are folded into the 40-bit
> Args.Mob.Session field defined by RFC 9433 Section 6.1.
>
> RFC 9433 Section 6.3 Step S08 specifies "Write in the SRH[0] the
> Args.Mob.Session" for a single-SID SR Policy.  When the SR Policy
> contains more segments, the augmented SRH must reserve a leading
> slot for the original outer destination D so that the downstream
> End.M.GTP6.E (which Section 6.5 requires to sit at the penultimate
> SID and Step S01 instructs to "Copy SRH[0] and D to buffer memory")
> can rebuild the GTP-U tunnel.  Args.Mob.Session is therefore stamped
> into segments[1] (the End.M.GTP6.E SID's locator-relative tail).
>
> The augmented SRH (slwt->srh + one extra leading slot) is built
> once at build_state time and reused on every packet.
>
> The new SEG6_LOCAL_MOBILE_SR_PREFIX_LEN attribute carries the
> locator length used by the remote End.M.GTP6.E SID; it is required
> because the SR Gateway has no way to discover the remote SID's
> prefix length from the FIB on its own.
>
> When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
> NF_INET_PRE_ROUTING between the GTP-U strip and the SRv6 push,
> mirroring End.DX4 / End.DX6.
>
> Inbound GTP-U packets are classified by message type (3GPP TS
> 29.281 Section 5.1).  Only T-PDU (type 255) is encapsulated into
> SRv6.  Any other GTP-U message (Echo Request/Response, Error
> Indication, ...) is forwarded unchanged via the lwtunnel's saved
> orig_input so that a downstream peer that owns the GTP-U control
> plane can process it.
>
> Configuration:
>
>   ip -6 route add 2001:db8:f::/64 \
>       encap seg6local action End.M.GTP6.D \
>           srh segs 2001:db8:2::e \
>           src 2001:db8:2::1 \

The "src" attribute is used verbatim here as the outer IPv6 source address,
same as patch 3. The src dual-semantics overload flagged in the patch 3
reply applies here too.

>           sr_prefix_len 64 \
>       dev <dev>
>

Thank you for the follow-up in the cover letter thread. The finish callback
writes orig_dst into SRH[0] and Args.Mob.Session into SRH[1]. As far as I
can see, this matches neither Section 6.3 (Args.Mob.Session in SRH[0], no
D) nor Section 6.4 (D in SRH[0], no Args.Mob).

The comments below apply regardless of which section the behavior
ends up implementing.

> Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.3
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  include/uapi/linux/seg6_local.h                    |   3 +
>  net/ipv6/seg6_local.c                              | 512 +++++++++++++++++++++
>  tools/testing/selftests/net/Makefile               |   1 +
>  .../selftests/net/srv6_end_m_gtp6_d_test.sh        | 497 ++++++++++++++++++++
>  4 files changed, 1013 insertions(+)
>
> diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
> index 8e46ede2980d..7d3d3d245b47 100644
> --- a/include/uapi/linux/seg6_local.h
> +++ b/include/uapi/linux/seg6_local.h
> @@ -33,6 +33,7 @@ enum {
>  	SEG6_LOCAL_MOBILE_V4_MASK_LEN,
>  	SEG6_LOCAL_MOBILE_PDU_TYPE,
>  	SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
> +	SEG6_LOCAL_MOBILE_SR_PREFIX_LEN,
>  	__SEG6_LOCAL_MAX,
>  };
>  #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
> @@ -77,6 +78,8 @@ enum {
>  	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
>  	/* SRv6 to IPv6/GTP-U encap (RFC 9433 Section 6.5) */
>  	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
> +	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
> +	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
>
>  	__SEG6_LOCAL_ACTION_MAX,
>  };
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 4e5d138c3657..09e912e17df8 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c

> + [snip]
>
> +/* Parse the GTP-U header at @skb offset @gtp_off.  Pulls each
> + * additional region (long header, extension chain) into the linear
> + * area as it walks; on success returns the total header length to
> + * consume (mandatory + optional + extension headers), or a negative
> + * errno on failure.
> + *
> + * Returns -EOPNOTSUPP if the packet is a well-formed GTPv1-U header
> + * that this code path does not consume itself (any non-T-PDU message
> + * such as Echo Request / Error Indication).  Callers pass such packets
> + * through to the configured forwarding path via
> + * seg6_mobile_passthrough_non_tpdu().
> + *
> + * Returns -EINVAL when the GTP-U header is structurally malformed
> + * (truncated extension chain, ext_units == 0, etc.).  Callers should
> + * drop those.
> + *
> + * On success, *@teid is set to the GTP-U TEID and *@qfi is set to the
> + * QFI found in a PDU Session extension header, or 0 if none is present.
> + *
> + * Callers must re-derive any pointers into @skb->data after this
> + * function returns: pskb_may_pull() may have reallocated skb->head.
> + */
> +static int seg6_mobile_parse_gtpu(struct sk_buff *skb, unsigned int gtp_off,
> +				  u32 *teid, u8 *qfi)
> +{
> +	const struct gtp1_header *gtph;
> +	const struct gtp1_header_long *gtphl;
> +	const u8 *gtp;
> +	unsigned int hdrlen;
> +	u8 flags, next;

Same reverse Christmas tree as patch 2; same issue in the other functions
introduced by this patch.

gtp is only used as a cast intermediary. Could it be inlined?

> +
> +	if (!pskb_may_pull(skb, gtp_off + sizeof(*gtph)))
> +		return -EINVAL;
> +	gtp = skb->data + gtp_off;
> +	gtph = (const struct gtp1_header *)gtp;
> +	flags = gtph->flags;
> +
> +	/* Accept only GTPv1-U T-PDU (3GPP TS 29.281 Section 5.1).  Other
> +	 * GTPv1-U message types (Echo Request/Response, Error Indication,
> +	 * ...) are dispatched separately by the caller.
> +	 */
> +	if ((flags & ~GTP1_F_MASK) != SEG6_MOBILE_GTP1U_FLAGS_BASE)
> +		return -EOPNOTSUPP;
> +	if (gtph->type != GTP_TPDU)
> +		return -EOPNOTSUPP;
> +
> +	*teid = ntohl(gtph->tid);
> +	*qfi = 0;
> +
> +	if (!(flags & (GTP1_F_EXTHDR | GTP1_F_SEQ | GTP1_F_NPDU)))
> +		return sizeof(*gtph);
> +
> +	if (!pskb_may_pull(skb, gtp_off + sizeof(*gtphl)))
> +		return -EINVAL;
> +	gtp = skb->data + gtp_off;
> +	gtphl = (const struct gtp1_header_long *)gtp;
> +	hdrlen = sizeof(*gtphl);
> +
> +	if (!(flags & GTP1_F_EXTHDR))
> +		return hdrlen;

Nit: gtphl and hdrlen are assigned before the GTP1_F_EXTHDR check. On the
path where the E flag is not set, gtphl is unused. Moving the gtphl
assignment after the check would make the flow clearer.

> +
> +	next = gtphl->next;
> +	while (next != 0) {
> +		unsigned int ext_units, ext_bytes;
> +		const u8 *ext;

Maybe ext could be renamed to ext_hdr? It would be easier to distinguish
from ext_units and ext_bytes.

> +
> +		if (!pskb_may_pull(skb, gtp_off + hdrlen + 1))
> +			return -EINVAL;
> +		ext = skb->data + gtp_off + hdrlen;
> +		ext_units = ext[0];
> +		if (ext_units == 0)
> +			return -EINVAL;
> +
> +		ext_bytes = ext_units * 4;
> +		if (!pskb_may_pull(skb, gtp_off + hdrlen + ext_bytes))
> +			return -EINVAL;
> +		ext = skb->data + gtp_off + hdrlen;

ext_units is only used to derive ext_bytes. A single ext_len would
remove the intermediate variable.

> +
> +		if (next == SEG6_MOBILE_PDU_SESSION_NH) {
> +			/* 3GPP TS 38.415: the PDU Session extension header
> +			 * is exactly 4 bytes long.
> +			 */
> +			if (ext_bytes != 4)
> +				return -EINVAL;
> +			*qfi = ext[2] & SEG6_MOBILE_PDU_SESSION_QFI_MASK;
> +		}

If the extension chain contains more than one PDU Session Container, *qfi
is silently overwritten. Is that intentional, or should the function reject
a duplicate?

> +
> +		next = ext[ext_bytes - 1];

ext[ext_bytes - 1] reads the Next Extension Header Type field from the last
byte of the current extension. Would a short comment help the reader?

> +		hdrlen += ext_bytes;
> +	}
> +
> +	return hdrlen;
> +}

> + [snip]

> +static int seg6_mobile_passthrough_non_tpdu(struct sk_buff *skb)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +
> +	if (dst && dst->lwtstate && dst->lwtstate->orig_input)
> +		return dst->lwtstate->orig_input(skb);
> +
> +	kfree_skb_reason(skb, SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU);

input_action_end_m_gtp6_d() does not change skb_dst(skb) before this call,
so dst and lwtstate are the same ones the caller already dereferenced. When
can this NULL check trigger?

> +	return -EINVAL;
> +}

> + [snip]

> +static int input_action_end_m_gtp6_d_finish(struct net *net,
> +					    struct sock *sk,
> +					    struct sk_buff *skb)
> +{
> +	struct seg6_mobile_gtp6_d_cb cb = *SEG6_MOBILE_GTP6_D_CB(skb);
> +	struct dst_entry *orig_dst = skb_dst(skb);
> +	enum skb_drop_reason reason;
> +	const struct seg6_mobile_info *minfo;
> +	struct seg6_local_lwt *slwt;
> +	struct ipv6_sr_hdr *new_srh;
> +	int inner_proto;
> +	int err;
> +
> +	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
> +	minfo = &slwt->mobile_info;

Same dst/lwtstate issue as patch 2. Not introduced by this patch.

> +
> +	inner_proto = (skb->protocol == htons(ETH_P_IP)) ? IPPROTO_IPIP
> +							 : IPPROTO_IPV6;
> +
> +	err = seg6_do_srh_encap(skb, minfo->aug_srh, inner_proto);

Same missing iptunnel_handle_offloads() as patch 2.

> +	if (err) {
> +		reason = (err == -ENOMEM) ? SKB_DROP_REASON_SEG6_MOBILE_NOMEM
> +					  : SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;

Same BAD_INNER misuse as patch 2. seg6_do_srh_encap() can also fail from
seg6_push_hmac(), which is an HMAC error on the new SRH, not an inner-T-PDU
problem.

> +		goto drop;
> +	}
> +
> +	skb->protocol = htons(ETH_P_IPV6);
> +
> +	new_srh = (struct ipv6_sr_hdr *)(skb_network_header(skb) +
> +					 sizeof(struct ipv6hdr));
> +	new_srh->segments[0] = cb.orig_dst;
> +	if (seg6_mobile_write_args_mob(&new_srh->segments[1],
> +				       minfo->sr_prefix_len, cb.args_mob)) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_SID;
> +		goto drop;
> +	}
> +
> +	ipv6_hdr(skb)->saddr = minfo->src_addr;
> +
> +	/* seg6_do_srh_encap() copied segments[first_segment] to the outer
> +	 * DA before Args.Mob.Session was stamped; refresh it.
> +	 */
> +	ipv6_hdr(skb)->daddr = new_srh->segments[new_srh->first_segment];

As noted at the top of this reply, segments[0] = orig_dst and
segments[1] = Args.Mob.Session matches neither Section 6.3 nor Section 6.4.

segments[0], segments[1], saddr, and daddr are written after
seg6_do_srh_encap() already called skb_postpush_rcsum(). skb->csum can
be stale. Same for any later change to the outer header or SRH.

HMAC, if configured, is computed on non-final SRH and saddr, hence invalid.

> +
> +	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +	nf_reset_ct(skb);
> +	skb_dst_drop(skb);
> +
> +	seg6_lookup_any_nexthop(skb, NULL, 0, false, slwt->oif);
> +	return dst_input(skb);
> +
> +drop:
> +	kfree_skb_reason(skb, reason);
> +	return -EINVAL;
> +}

Same redundant skb_dst_drop() as patch 3.

> +
> +/* RFC 9433 Section 6.3 -- End.M.GTP6.D
> + * Receives an IPv6/UDP/GTP-U packet matching a locally instantiated
> + * End.M.GTP6.D SID and re-encapsulates the inner T-PDU in SRv6 using
> + * the configured SR Policy.  TEID and QFI are folded into
> + * Args.Mob.Session.  Per RFC 9433 Section 6.5 ("End.M.GTP6.E SID MUST
> + * always be the penultimate SID"), Args.Mob.Session is encoded into
> + * segments[1] of the new SRH (the penultimate SID at the egress UPF)
> + * while segments[0] holds the original outer DA so that the egress
> + * has a real GTP-U destination after End.M.GTP6.E decap.
> + *
> + * When net.netfilter.nf_hooks_lwtunnel=1 the inner T-PDU is exposed
> + * to NF_INET_PRE_ROUTING after the GTP-U strip and before the SRv6
> + * push, mirroring End.DX4 / End.DX6.  This lets nftables / conntrack
> + * apply policy on the inner 5-tuple at the SR Gateway.
> + */
> +static int input_action_end_m_gtp6_d(struct sk_buff *skb,
> +				     struct seg6_local_lwt *slwt)
> +{
> +	unsigned int outer_len, inner_off;
> +	int gtp_hdrlen, inner_proto, inner_nfproto;
> +	struct in6_addr orig_dst;
> +	u8 inner_first, qfi;
> +	struct ipv6_sr_hdr *srh;
> +	struct ipv6hdr *ip6h;
> +	struct udphdr *uh;
> +	u64 args_mob;
> +	u32 teid;
> +	enum skb_drop_reason reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;

The initializer on reason is dead. Every goto drop path sets reason
explicitly before the jump. The variable can be left uninitialized here.

> +
> +	BUILD_BUG_ON(sizeof(struct seg6_mobile_gtp6_d_cb) >
> +		     sizeof_field(struct sk_buff, cb));
> +
> +	/* RFC 9433 Section 6.3 SRH-S01: drop if outer SRH carries
> +	 * SegmentsLeft != 0
> +	 */
> +	srh = seg6_get_srh(skb, 0);
> +	if (srh && srh->segments_left != 0) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_INVALID_SRH_SL;
> +		goto drop;
> +	}

Same SRH validation concerns as patch 1. HMAC is not validated here.

> +
> +	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}

Same BAD_INNER misuse as patch 2: this is pulling the outer IPv6 header,
not the inner T-PDU.

> +
> +	ip6h = ipv6_hdr(skb);
> +	orig_dst = ip6h->daddr;
> +
> +	/* RFC 9433 Section 6.3 upper-layer S01-S11: dispatch on
> +	 * (NH == UDP && UDP dport == GTP-U); otherwise delegate to the
> +	 * regular End behaviour (S10-S11).
> +	 */
> +	{

The anonymous { } block scopes three variables that should be declared at
function top. Splitting into smaller helpers would make this easier to
follow.

> +		__be16 frag_off;
> +		u8 nh = ip6h->nexthdr;
> +		int upper_off;
> +
> +		upper_off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nh,
> +					     &frag_off);
> +		if (upper_off < 0) {
> +			/* Outer IPv6 ext-header walk failed; the GTP-U
> +			 * envelope below it is unreachable.
> +			 */
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
> +			goto drop;
> +		}

Same missing frag_off check as patch 2.

> +
> +		if (nh != IPPROTO_UDP)
> +			return input_action_end(skb, slwt);
> +
> +		if (!pskb_may_pull(skb, upper_off + sizeof(*uh))) {
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
> +			goto drop;
> +		}
> +
> +		ip6h = ipv6_hdr(skb);
> +		uh = (struct udphdr *)((u8 *)ip6h + upper_off);
> +		if (uh->dest != htons(GTP1U_PORT))
> +			return input_action_end(skb, slwt);

Limitation note for both input_action_end() calls above: correct per RFC
9433 Section 6.3 S10-S11, but the SRH is absent or SL == 0 here, so
input_action_end() will always drop without signaling non-GTP-U traffic.
Perhaps you meant to drop directly with BAD_GTPU?

> +
> +		gtp_hdrlen = seg6_mobile_parse_gtpu(skb,
> +						    upper_off + sizeof(*uh),
> +						    &teid, &qfi);
> +		if (gtp_hdrlen == -EOPNOTSUPP)
> +			return seg6_mobile_passthrough_non_tpdu(skb);
> +		if (gtp_hdrlen < 0) {
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
> +			goto drop;
> +		}
> +
> +		outer_len = upper_off + sizeof(*uh) + gtp_hdrlen;
> +	}
> +
> +	args_mob = seg6_mobile_args_from_teid_qfi(teid, qfi);
> +
> +	if (!pskb_may_pull(skb, outer_len + 1)) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +
> +	inner_off = outer_len;
> +	inner_first = *((u8 *)skb->data + inner_off);
> +	switch (inner_first >> 4) {

Nit: inner_first could be an inner_ver with the shift done at assignment.
The name would say what the variable holds.

> +	case 4:
> +		inner_proto = IPPROTO_IPIP;
> +		inner_nfproto = NFPROTO_IPV4;
> +		break;
> +	case 6:
> +		inner_proto = IPPROTO_IPV6;
> +		inner_nfproto = NFPROTO_IPV6;
> +		break;
> +	default:
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +
> +	if (!pskb_may_pull(skb, outer_len +
> +			   ((inner_proto == IPPROTO_IPIP) ?
> +			    sizeof(struct iphdr) : sizeof(struct ipv6hdr)))) {
> +		reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_INNER;
> +		goto drop;
> +	}
> +
> +	skb_pull_rcsum(skb, outer_len);
> +	skb_reset_network_header(skb);
> +
> +	/* Set skb->protocol to match the inner header so that the
> +	 * NF_INET_PRE_ROUTING hook (and seg6_do_srh_encap() inside
> +	 * the finish half) see a coherent IPv4/IPv6 packet.
> +	 */
> +	skb->protocol = (inner_proto == IPPROTO_IPIP) ? htons(ETH_P_IP)
> +						      : htons(ETH_P_IPV6);
> +
> +	skb_set_transport_header(skb,
> +				 (inner_proto == IPPROTO_IPIP) ?
> +				 sizeof(struct iphdr) :
> +				 sizeof(struct ipv6hdr));

Same repeated size-selection ternary as patch 2.

> +	nf_reset_ct(skb);
> +
> +	SEG6_MOBILE_GTP6_D_CB(skb)->args_mob = args_mob;
> +	SEG6_MOBILE_GTP6_D_CB(skb)->orig_dst = orig_dst;
> +
> +	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
> +		return NF_HOOK(inner_nfproto, NF_INET_PRE_ROUTING,
> +			       dev_net(skb->dev), NULL, skb, skb->dev,
> +			       NULL, input_action_end_m_gtp6_d_finish);
> +
> +	return input_action_end_m_gtp6_d_finish(dev_net(skb->dev), NULL, skb);
> +
> +drop:
> +	kfree_skb_reason(skb, reason);
> +	return -EINVAL;
> +}

> +
> +/* Shared between End.M.GTP6.D and End.M.GTP6.D.Di -- both
> + * prepend a single leading slot to the user-configured SRH to leave
> + * room for the original outer DA at SRH[0].  End.M.GTP6.D writes
> + * Args.Mob.Session into segments[1] at runtime; End.M.GTP6.D.Di
> + * leaves segments[1+] as the user provided them.
> + */
> +static int seg6_end_m_gtp6_d_aug_build(struct seg6_local_lwt *slwt,
> +				       const void *cfg,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct ipv6_sr_hdr *aug;
> +	int orig_len, aug_len;
> +
> +	if (!slwt->srh) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "End.M.GTP6.D{,.Di} requires srh segs");
> +		return -EINVAL;
> +	}

The "{,.Di}" shell brace notation is unusual. Emitting the actual
behavior name (End.M.GTP6.D or End.M.GTP6.D.Di) would be clearer.
Same applies wherever this notation appears in the patchset.

> +
> +	/* The augmented SRH adds one extra leading slot, so its hdrlen
> +	 * field (u8) must still fit the +2-segment-equivalent encoding.
> +	 * Reject pathological srh inputs at setup time so that no
> +	 * silent overflow can produce an undersized aug->hdrlen and a
> +	 * subsequent OOB read in seg6_do_srh_encap().
> +	 */
> +	if (slwt->srh->hdrlen > 253) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "End.M.GTP6.D{,.Di} srh too large to augment (max 126 segments)");
> +		return -EINVAL;
> +	}
> +
> +	orig_len = (slwt->srh->hdrlen + 1) << 3;
> +	aug_len = orig_len + sizeof(struct in6_addr);
> +
> +	aug = kzalloc(aug_len, GFP_KERNEL);
> +	if (!aug)
> +		return -ENOMEM;
> +
> +	memcpy(aug, slwt->srh, sizeof(*aug));
> +	aug->hdrlen = (aug_len >> 3) - 1;
> +	aug->segments_left = slwt->srh->segments_left + 1;
> +	aug->first_segment = slwt->srh->first_segment + 1;
> +	/* segments[0] left zero; data path stamps the original outer
> +	 * DA into the in-skb copy after seg6_do_srh_encap().
> +	 */
> +	memcpy(&aug->segments[1], &slwt->srh->segments[0],
> +	       orig_len - sizeof(*aug));
> +
> +	slwt->mobile_info.aug_srh = aug;
> +	return 0;
> +}

> + [snip]

Thanks,

Ciao,
Andrea

P.S. I am temporarily writing from another address due to a mail
delivery issue at my @uniroma2.it address. Please always Cc my default
andrea.mayer@uniroma2.it address on replies.

