Return-Path: <netdev+bounces-296248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YZ/lFEl6JWo8IgIAu9opvQ
	(envelope-from <netdev+bounces-296248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8732650B2D
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=common-net.org header.s=mail header.b="t/HU8RzL";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296248-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=common-net.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A070D30087BA
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1DE3859F6;
	Sun,  7 Jun 2026 14:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.common-net.org (mail.common-net.org [139.28.148.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAF2253EE;
	Sun,  7 Jun 2026 14:01:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840885; cv=none; b=ngHJgYSbFk6xBbWE21BgYDf1+FBa/KdwVZP+HjWNE8ZANIOEgO3hBU6h9PauRO4jw1E9wC6rcggzUgjIlInzt6XQk9Zc6OJb1O4Ltpci91DOzaNKRXVRvCSSsZ3CH1xqlYja66tCugqCctmgO9pJYK4ILDR1J9kLwmZytpt1weE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840885; c=relaxed/simple;
	bh=7IIMnHWhVf+twJaSVJxFuCA1jrlaS+iWejGB0SPwmUI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sbfHbGKNsLoSUBp7sH+TCcnh0R+DJrKsan8dezDrtLgqr2akSgOTpajAA41b0DFTS25+W93OycPUNQyRbqeoDLegIvqs+bIsBuiz9TaJLrgPWZT6/7/sCrRj4ENiZkeGcwAmh3WcYtUmkGXhzQe8rOyoTbYditZVeXaMe7UqLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=common-net.org; spf=pass smtp.mailfrom=common-net.org; dkim=pass (1024-bit key) header.d=common-net.org header.i=@common-net.org header.b=t/HU8RzL; arc=none smtp.client-ip=139.28.148.254
Received: from lubuntu-18.04 (host-80-116-255-177.pool80116.interbusiness.it [80.116.255.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.common-net.org (Postfix) with ESMTPSA id AE0FA6D20B88;
	Sun,  7 Jun 2026 16:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=common-net.org;
	s=mail; t=1780840880;
	bh=7IIMnHWhVf+twJaSVJxFuCA1jrlaS+iWejGB0SPwmUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/HU8RzL4/U+SOIbtwUDTdZ1tq6YpQE+B8fu/n6ihwN5scNcji7geBeqComDRMyI+
	 kfU0amV1PGzXCJtIFhguAYQNjEo0zr03dOqkwjgKlLrg2454pF3vpWQGohnSuJaFDO
	 mV/bXt7sgJHOQbsu2XxAZTsFO0PZ/y5iExEvod5M=
Date: Sun, 7 Jun 2026 16:01:19 +0200
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
Subject: Re: [PATCH v2 5/7] seg6: add End.M.GTP6.D.Di behavior
Message-Id: <20260607160119.ed2022e8a358d700e1134318@common-net.org>
In-Reply-To: <20260505-seg6-mobile-v2-5-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
	<20260505-seg6-mobile-v2-5-9e8022bdfdb6@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296248-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email,rfc-editor.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8732650B2D

On Tue, 05 May 2026 01:30:15 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

I do not repeat below the points from the cover letter thread and patch
1-4 replies (drop reasons, OIF/VRF removal, C helper, coding style, etc.).

The patch 4 review applies here, except for the parts where Section 6.4 is
implemented instead of Section 6.3 (which is incorrectly implemented in
patch 4).

> Add the End.M.GTP6.D.Di drop-in mode variant of End.M.GTP6.D
> (RFC 9433 Section 6.4).  Unlike End.M.GTP6.D, the drop-in variant
> does NOT fold the GTP-U identifiers into Args.Mob.Session: the
> original outer IPv6 destination is preserved at SRH[0] of the new
> SRH, so the destination side can keep the original address
> untouched while still benefiting from SR Policy steering.
>
> The augmented SRH builder/destroyer is shared with End.M.GTP6.D.
> The TEID and QFI parsed out of the inbound GTP-U header are
> intentionally discarded for this variant (matching RFC 9433
> Section 6.4).
>
> When net.netfilter.nf_hooks_lwtunnel=1, the inner T-PDU traverses
> NF_INET_PRE_ROUTING between the GTP-U strip and the SRv6 push,
> mirroring End.DX4 / End.DX6.
>
> Non-T-PDU GTP-U messages are forwarded the same way as in
> End.M.GTP6.D: passed through via the lwtunnel's saved orig_input
> to a downstream peer that owns the GTP-U control plane.
>
> Configuration:
>
>   ip -6 route add 2001:db8:f::/64 \
>       encap seg6local action End.M.GTP6.D.Di \
>           srh segs 2001:db8:2::e,2001:db8:3::e \
>           src 2001:db8:2::1 \
>       dev <dev>
>
> Link: https://www.rfc-editor.org/rfc/rfc9433.html#section-6.4
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  include/uapi/linux/seg6_local.h                    |   2 +
>  net/ipv6/seg6_local.c                              | 222 +++++++++++
>  tools/testing/selftests/net/Makefile               |   1 +
>  .../selftests/net/srv6_end_m_gtp6_d_di_test.sh     | 427 +++++++++++++++++++++
>  4 files changed, 652 insertions(+)
>
> diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
> index 7d3d3d245b47..326da65ad5aa 100644
> --- a/include/uapi/linux/seg6_local.h
> +++ b/include/uapi/linux/seg6_local.h
> @@ -80,6 +80,8 @@ enum {
>  	SEG6_LOCAL_ACTION_END_M_GTP6_E	= 19,
>  	/* IPv6/GTP-U decap into SRv6 (RFC 9433 Section 6.3) */
>  	SEG6_LOCAL_ACTION_END_M_GTP6_D	= 20,
> +	/* IPv6/GTP-U decap into SRv6, drop-in mode (RFC 9433 Section 6.4) */
> +	SEG6_LOCAL_ACTION_END_M_GTP6_D_DI = 21,
>
>  	__SEG6_LOCAL_ACTION_MAX,
>  };
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 09e912e17df8..a6cd57ebcbde 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c

> + [snip]

input_action_end_m_gtp6_d_di() and its finish callback are largely
identical to the patch 4 functions (input_action_end_m_gtp6_d() and its
finish): the SRH check, GTP-U dispatch, outer strip, inner protocol
detection, and NF_HOOK invocation are identical. The duplication should be
reduced via shared helpers.

> +static int input_action_end_m_gtp6_d_di(struct sk_buff *skb,
> +					struct seg6_local_lwt *slwt)
> +{

> + [snip]

> +		gtp_hdrlen = seg6_mobile_parse_gtpu(skb,
> +						    upper_off + sizeof(*uh),
> +						    &teid, &qfi);
> +		if (gtp_hdrlen == -EOPNOTSUPP)
> +			return seg6_mobile_passthrough_non_tpdu(skb);
> +		if (gtp_hdrlen < 0) {
> +			reason = SKB_DROP_REASON_SEG6_MOBILE_BAD_GTPU;
> +			goto drop;
> +		}
> +		(void)teid;
> +		(void)qfi;

D.Di does not use teid or qfi, so these variables and the (void) casts are
dead code and should be avoided. For example, seg6_mobile_parse_gtpu() could
accept NULL for teid and qfi so callers that do not need them can pass NULL
directly.

Thanks,

Ciao,
Andrea

P.S. I am temporarily writing from another address due to a mail
delivery issue at my @uniroma2.it address. Please always Cc my default
andrea.mayer@uniroma2.it address on replies.

