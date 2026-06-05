Return-Path: <netdev+bounces-295592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +gBuHWk2ImqiTwEAu9opvQ
	(envelope-from <netdev+bounces-295592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D5644B50
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HcrEvOi8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295592-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295592-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06A453002B58
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C237AA65;
	Fri,  5 Jun 2026 02:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BA3E2ABF
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627041; cv=none; b=WZW3MG9H9RWbNyO1LJEmGrfufhz3Go16JSbG4i80UdICni04/r5UTk+py5rbtHIr6bpTq0W553UVShP7ROFfi4jPDPj/ugwmH5ZacyVebmmVyv8K7bEgwZ/pRWW5k+kYDaIBFs3oKfPeu7g0wwLToCNBAcZRF+pUmbbyknN4NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627041; c=relaxed/simple;
	bh=IbY5PVTOrL8eCaLa3jm1ws2zoEcSQsbPbwxz+zUyn1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuVlZ00xlt/eHtI6wo7cvZDlYQXnqTXohhClruI7LNN0on/h9pCTZWVF/SgkThy+DhCik6cZwi55Sx/xp4wCZFLO8FD3XCtnWjGg2RACJ83RU7Qq1XOd9ofhngyRXlQy28RR9BOMwnHaSrhUbV9MVoreLNuJZUFgzGhyqGzYoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcrEvOi8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF9D1F00893;
	Fri,  5 Jun 2026 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627035;
	bh=9lPe3V1kbXwQcy11sW9IOTZnFlvLl5J21zXgtrx0sp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcrEvOi8fn1Uv0faiTif0FKT/GeSxSATG2b/i9Os2vBRMbDcknYXhXZgL3dCeKG+W
	 CRbrhDTrD1RcwKQUv1kv7zFmpF17ADd21xXhwIeewwf3zNsNzAJGfBxwBb02J2/Iqs
	 VwQr8GADFXdKb7O5PJUIK4X/yNp9lQpvm1YmEB/IRGtYrNKuHMwQX6ax1YC6NKtksM
	 JA38qJpx9j5+sDTSAN3bsA1rfvXt/WLa87k99iXnvCLltt5X2pUWNQvQlLqaApzfmw
	 AgVzPVh34V8XFxh/8mAjPDztbiexYyfg/Rb9UBzX7iCG3sPAn62DS99Hl6YcwLtXbx
	 oNs+0BTfDk05g==
From: Jakub Kicinski <kuba@kernel.org>
To: alice.kernel@fastmail.im
Cc: Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lucien.xin@gmail.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	dsahern@kernel.org,
	razor@blackwall.org,
	shuah@kernel.org,
	stfomichev@gmail.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	fw@strlen.de,
	netdev@vger.kernel.org,
	alice@isovalent.com
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
Date: Thu,  4 Jun 2026 19:37:11 -0700
Message-ID: <20260605023712.3627277-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-6-alice.kernel@fastmail.im>
References: <20260602093931.516281-6-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295592-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:kuba@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 470D5644B50

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
udp: Support gro_ipv4_max_size > 65536

This commit allows GRO to aggregate UDP packets larger than 65535 bytes
by writing 0 to the UDP header length field (via udp_set_len()) and
restoring the real length from skb->len in udp_rcv().

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 3e92575f1d55..856c23b9d6dd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>  	if (ulen > skb->len)
>  		goto short_packet;
>  
> +	if (!ulen)
> +		ulen = skb->len;
> +
>  	if (ulen < sizeof(*uh))
>  		goto short_packet;
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 96987b1c05cd..f7da760f046f 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  	struct sock *sk;
>  	int err;
>  
> -	udp_set_len_short(uh, newlen);
> +	udp_set_len(uh, newlen);

[High]
After this change, udp_gro_complete() may write uh->len = 0 when the
aggregated packet is >= GRO_LEGACY_MAX_SIZE (65536).  How does this
interact with conntrack on the receive path?

Looking at udp_validate_len() in net/netfilter/nf_conntrack_proto_udp.c
at this commit:

    static bool udp_validate_len(...)
    {
        unsigned int udplen = udp_get_len_short(hdr);
        ...
        if (udplen > skblen || udplen < sizeof(*hdr))
            return false;
        ...
    }

For a super-packet where uh->len has been zeroed, udp_get_len_short()
returns 0, which is less than sizeof(*hdr), so udp_validate_len() returns
false.  udp_error() then logs "truncated/malformed packet" and
nf_conntrack_udp_packet() returns -NF_ACCEPT, leaving the flow untracked.

The deployment this patch enables (gro_ipv4_max_size > 65536 with VXLAN
or Geneve TCP-in-UDP and conntrack) is the very example given in the
commit message.  Should this patch also update udp_validate_len() (or
otherwise account for the zeroed length) so that conntrack does not drop
out of the state machine for super-packets, breaking NAT and stateful
firewalling?

The follow-up patch in this series, "udp: Support BIG TCP GSO packets
where they can occur" (b73c2d663201), updates udp_validate_len() to
accept udplen == 0 when skblen >= GRO_LEGACY_MAX_SIZE, but until that
patch is applied this commit on its own appears to regress conntrack for
the configurations it is intended to support.

>  	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
>  				udp4_lib_lookup_skb, skb, uh->source, uh->dest);

[ ... ]

