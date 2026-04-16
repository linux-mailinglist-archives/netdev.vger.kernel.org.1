Return-Path: <netdev+bounces-278973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCTNCBqf4GlukQAAu9opvQ
	(envelope-from <netdev+bounces-278973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16A40B9E7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44B82300C34B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C26391E68;
	Thu, 16 Apr 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1CpifII"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD440DFD6;
	Thu, 16 Apr 2026 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328458; cv=none; b=BtVvhbcVRTZ+fjPMVk8TkaLVD/uTCgtpTIoffpwl+AeMxyZzYTPmRjj1u41suKXPc3eF1EfwndiBYYS1dkMFR3LOIfKcMsDhVC8avhh9P2tuzQKRY23nSah/I19FlcBGRzD8CxndV9TpDuDfo83CCteFxk+wrypy6XKQsvXTJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328458; c=relaxed/simple;
	bh=0fKKTSAQ+QwiXuruxbHu/bmkl5tn2565NbyFxpfvsM0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hZfJG4j+VSZf6U+F5c34/wsgvnAN+flZ79grBTKF5jP9zeQvASi8ke2cOGv+rzK4qQGdwjIouv0hFXZQpopg4XDnhNHdYIn5rwSg30yZ3o7Hd6ycjffnhrbZwiEd/qOET1T4mf8fWIoBtF9EyeQmiqFhZxbF5Liro6W7RZu9evI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1CpifII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA25C2BCB3;
	Thu, 16 Apr 2026 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776328457;
	bh=0fKKTSAQ+QwiXuruxbHu/bmkl5tn2565NbyFxpfvsM0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=E1CpifIIzsp/LIYCUz3G7LdNAEX8BOr72QT5Ug4mqLqWL1fmL0EkTuujOYsb33YMU
	 fr/f6K92GjWdz16dsT4q4ucKTGJ5ZSOpH4rCtixo1/ZINzs/uTTpnzWZfvriTKLU3f
	 2H8GGpksOOUtAM7InSQEOwrOAqYAg8MBZRk60Ia8GgSLamMHjkYxpMMV3+DyTYEivi
	 QF4raAaNjPTh83981KsnosgTDbCpW0d46ZXX/Nui0VLHvbi1zXq6GM2pmDn36DGIoS
	 RgnDu5wTT/6nYpYR63bkMqaaaotE42+AlbIAxlwtfM9GmYZ/l/VNHdLszeJVXHpvPz
	 ajB+NYVypqNwA==
Content-Type: multipart/mixed; boundary="===============6660733411948982654=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cacb7ce0c0fea96412e0af01e2d966e0748df2bb6f29e960c8fc25f7f7b69164@mail.kernel.org>
In-Reply-To: <20260416075514.927101-6-nhudson@akamai.com>
References: <20260416075514.927101-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in skb_adjust_room
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 08:34:17 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-278973-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D16A40B9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6660733411948982654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1dac64b50de4..4e77e9c46f1a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3657,6 +3657,44 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&

The symbols BPF_F_ADJ_ROOM_DECAP_L4_UDP, BPF_F_ADJ_ROOM_DECAP_L4_GRE,
BPF_F_ADJ_ROOM_DECAP_IPXIP4, BPF_F_ADJ_ROOM_DECAP_IPXIP6,
BPF_F_ADJ_ROOM_DECAP_L4_MASK, and BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
are used throughout this hunk but are not defined anywhere in the tree.

The series cover letter lists patch 3/6 "bpf: add
BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation" which would
add these to include/uapi/linux/bpf.h, but that patch is not present.
Without it, this commit will not compile.

Additionally, even if these symbols were defined, BPF_F_ADJ_ROOM_MASK
and BPF_F_ADJ_ROOM_DECAP_MASK do not include the new flag bits.  Both
bpf_skb_adjust_room():

    if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
        return -EINVAL;

and bpf_skb_net_shrink():

    if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
                           BPF_F_ADJ_ROOM_FIXED_GSO |
                           BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
        return -EINVAL;

would reject any flags value containing these new bits, making the
new code unreachable.  Patch 4/6 "bpf: allow new DECAP flags and add
guard rails" from the series would presumably update these masks, but
it is also not present.

Are patches 3/6 and 4/6 of the series missing from this tree?

> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);

[ ... ]

> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {

[ ... ]

> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum = 0;
> +				skb->remcsum_offload = 0;
> +			}
> +		}

This isn't a bug, but the BPF subsystem convention is that multi-line
comments should have the opening /* on its own line:

> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */

Should be:

    /*
     * Selective GSO flag clearing based on decap type.
     * Only clear the flags for the tunnel layer being removed.
     */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24499314045
--===============6660733411948982654==--

