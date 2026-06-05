Return-Path: <netdev+bounces-295820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NPPNGqXEImrFdQEAu9opvQ
	(envelope-from <netdev+bounces-295820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF864846D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:44:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=n3PKsgAy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295820-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DFC30A2CC0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016A381AE3;
	Fri,  5 Jun 2026 12:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8C18BC3B;
	Fri,  5 Jun 2026 12:34:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662849; cv=none; b=FGu/19iJ4nXZ3SpJHA6BAyp3xwz4Ys1DvSMmDAuMzNO/yAF7lXXcrIYNB4rI0hlpaQ2OBlNWvb12elc3rk56eUV01rRRYlzDXkjm3W8o/Wpo3DA9CkndleGE+JZlMe5CN6aV8kKJGasqMHyoFGPvqhzSkrQpmx+yakdPjFm4VmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662849; c=relaxed/simple;
	bh=w4rChrUOsyDQFUNbvsiBR+csdsviDShe3ptWz8mB1wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRx9LE9IqQXrHhojSOpZPmqX4/9N5xdUetiHG686YcaM1JvaZ8/nJoUOcWGkOoo+MzgA3h2EIgyMKOCxorQtG35Na1o26jYr/TlSema85x5FYLm5hz2hysCQ3FbTgpkcB/eYGurTQNhhIIxDiqucDOKcXiNLkVDDoikTgGadKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=n3PKsgAy; arc=none smtp.client-ip=195.10.208.47
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gX0xS36cVzDs62;
	Fri,  5 Jun 2026 14:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1780662284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rzw23HqIHJPtzDt+5Kp05vr651n/WjwjQt8cmi1SSTg=;
	b=n3PKsgAyBex9vc7r+X3IhvHBr4YNRC6jT9KDY7ejkNJPrqRb92czoFz6HdYez6rXLCUzVr
	tyx0hDtx3XLVr9B5HYsKzKFQvmUcWtWL+Hq38h8y6Q1RcxQC2HCNIJU/ZV6xIgQrKhPRin
	Gore+bVgMDAk2J4PXndxttOFRAX4XyT0imC762CWD3pottdpAttFtxRKjyZfw2v7CVhbMr
	LEGZJnRDKrX02/tOWOvmGg9mBf/MCC7BwQGqmCnVBSnejvZFfUO6wMgF1lvXbo4Rw9qKVz
	N31tdxK9yjeu3knAYJty4MyR9XxP50jSYJ5qiY0FKpNlc6zsGuRHLpnVqzdjJA==
From: Ralf Lici <ralf@mandelbit.com>
To: Xavier HSINYUAN <XavierHsinyuan@outlook.com>
Cc: andrew+netdev@lunn.ch,
	antonio@mandelbit.com,
	davem@davemloft.net,
	dxld@darkboxed.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [RFC net-next 10/15] ipxlat: add 4to6 pre-fragmentation path
Date: Fri,  5 Jun 2026 14:24:27 +0200
Message-ID: <20260605122428.402982-1-ralf@mandelbit.com>
In-Reply-To: <TYRPR01MB1266606B1144F3896FC712C3CCA032@TYRPR01MB12666.jpnprd01.prod.outlook.com>
References: <TYRPR01MB1266606B1144F3896FC712C3CCA032@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:XavierHsinyuan@outlook.com,m:andrew+netdev@lunn.ch,m:antonio@mandelbit.com,m:davem@davemloft.net,m:dxld@darkboxed.org,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,vger.kernel.org:from_smtp,mandelbit.com:mid,mandelbit.com:from_mime,mandelbit.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9DF864846D

On Mon, 18 May 2026 20:36:25 +0800, Xavier HSINYUAN <XavierHsinyuan@outlook.com> wrote:
> Hi Ralf,
>

Hi Xavier,

Sorry for the slow reply. This got buried while I was busy with other
kernel work.

> >+int ipxlat_46_plan_prefrag(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
> >+{
> >+	unsigned int pkt_len6, pmtu6, threshold6, frag_max_size, pkt_len4,
> >+		old_l3_len, new_l3_len;
> >+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
> >+	const struct iphdr *in4 = ip_hdr(skb);
> >+	int l3_delta, frag_l3_delta;
> >+
> >+	if (unlikely(cb->frag_max_size)) {
> >+		DEBUG_NET_WARN_ON_ONCE(1);
> >+		cb->frag_max_size = 0;
> >+	}
> >+
> >+	pkt_len4 = iph_totlen(skb, in4);
> >+	old_l3_len = cb->l3_hdr_len;
> >+	new_l3_len = sizeof(struct ipv6hdr) +
> >+		     (ip_is_fragment(in4) ? sizeof(struct frag_hdr) : 0);
> >+	l3_delta = (int)new_l3_len - (int)old_l3_len;
> >+	pkt_len6 = pkt_len4 + l3_delta;
> >+
> >+	pmtu6 = ipxlat_46_lookup_pmtu6(ipxlat, skb, in4);
> >+	threshold6 = min(pmtu6, READ_ONCE(ipxlat->lowest_ipv6_mtu));
> >+
> >+	if (likely(pkt_len6 <= threshold6))
> >+		return 0;
> >+
> >+	/* df packets are never locally pre-fragmented */
> >+	if (likely(be16_to_cpu(in4->frag_off) & IP_DF)) {
> >+		/* Let the IPv6 forwarding path raise PTB when needed and rely
> >+		 * on the reverse 6->4 ICMP translation path for feedback.
> >+		 */
> >+		return 0;
> >+	}
>
> How about putting the DF check before the PMTU lookup?
> ipxlat_46_lookup_pmtu6() requires ip6_route_output() and dst_release(),
> but the DF bit is much cheaper to test and is typically set on most
> TCP/QUIC packets. It looks like a pure reorder but I have not verified
> it carefully.
>

Yes, that looks right to me. The PMTU lookup is only needed for the
non-DF path, where we may actually compute a pre-fragmentation cap. For
DF packets ipxlat_46_plan_prefrag should leave frag_max_size unset and
let the later IPv6 output path generate PTB if the translated packet is
too large.

I'll move the DF check before ipxlat_46_lookup_pmtu6, after the stale
frag_max_size clearing.

Thanks!

-- 
Ralf Lici
Mandelbit Srl

