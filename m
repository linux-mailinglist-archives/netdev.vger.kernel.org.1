Return-Path: <netdev+bounces-305190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4ecBHXyS2oUdgEAu9opvQ
	(envelope-from <netdev+bounces-305190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:22:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33471473A
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:22:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="y IxEb55";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=fmq0cV8T;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305190-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305190-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50ACC304920F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3797436BE1;
	Mon,  6 Jul 2026 18:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62815436BCE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362064; cv=none; b=C5Cg9B3oqibs6J5yqmAaKpKS3I6rHmE8adL3mlYVvoDvpcoTq9EtGLSZUnVBgorSoH6pv2n46wuVr0WgVDxmCbKURIVSe2FeI+03l6byGNWUh20TnKfKDKK6GZQ/uzUFiL9nD9x6F9qXRvt06M0nMnFbjeDb+ZZNNr329GbkthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362064; c=relaxed/simple;
	bh=j6RT/OCnC/DPUdMPpCvN5GGj86YCUCrkN6fjx+3ZR2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPg8ZOODUthMnUvY1SifS8B3nwb+/vHG5TbnD/AtdFkOxiS0F00AZqm4zcLgMF/YdY1OyieTFI8JlBQGbk5hrzk34OVW+fh5d9BoR91j56vBdhU6q93vcF7hmKGs9B6HtNW8ifsjg/siPITm1IfVxbEkC22iw6ljG6FN2xj50dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=yIxEb55b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmq0cV8T; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A42EEC0184;
	Mon,  6 Jul 2026 14:21:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 14:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362062; x=
	1783448462; bh=c6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=y
	IxEb55bnhMcEEa6z/Tc0gfMSc2X433rx25jIUHOnbvBJdptCWFMULUoykOgw32/a
	crIv9uM1PgCgiVwz5k30jCubnHXHpnMabTHPaG5aIA871/qN2pn65fGY6rsnmj1N
	mw/IArJHxNOSyLXSmHi8lH6mgWQgrEh36McZCPOIp2EwKansjicv/A5kDqndlxpP
	cDmgXdYJa5Ov8Er9VJ/qObuBKplKidrRjxhOq5sn0Txx+ZV6l9aZHuWNfZiEdPUN
	ClPqCCnRbKQ5rtRnIaZM7gEv0OOGVN8du2aJ1rtKmvAH8A6jk436dOZjxuqSvkYO
	n2RpvKD8+/zZSRiXgyKtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362062; x=1783448462; bh=c
	6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=fmq0cV8TgRgxAO8Po
	rJpK0WMrk1tg8axK6FiKhQ9c6u7WTHr8nDMu7TTWPRJxuR/aawUL2QeXc8Swlr9S
	l0kzSgZI8reQJrT/7OFQhPWB11ZEUrNDkDBnBNVQoaNm+GdO2tkcaerllxkhdajc
	uRQhHngbdOEtVRmo9wV1OAXEMm+ZOJTlM0CnXz78jOE6cGtXV1eWfHcgBuA7KhAX
	uoxsuWwrnJVDqJ0L629F+g0VvJLHlnb7M+tKGe8BmFiwK9StmBeBgZkIa/Coi7+s
	/KYzjSgfhlBpOqMPsCNtXEbb62ktmMnyyaAGY7A+rnRrtWtIo4VF6KzTYCdDAjKd
	LQzPQ==
X-ME-Sender: <xms:DvJLavaYW1pPhjOwAyksVQb69AdnhClW8-d7zqzmodUpiGf9f3yXTw>
    <xme:DvJLas5iu_ochw8eAPSwPd6rBKhfoPy_pT9YmK_PO2YpNqYs2jjK0ut7S9orDHbgV
    OQkC4pDsRCStt9E9l231gv0gd9Q28UJf55RafTqufhDa0GN7XsfWSo>
X-ME-Received: <xmr:DvJLaoxBckxx6RsKmXla3gvgoFQK22mwVyQlwxNylBwYwEyyEjJU5MUVIAU>
X-ME-Proxy-Cause: dmFkZTE1ABw/OWYVKfVUuLK8laugMprmtXYFa40KQSYPaWqbaJzVPwWQi8VLwqO4sHbFRW
    Nmr3XP6+snMgMU4BbLlCJAuayz2rzf1erFm45clXYNstSwc1c5077I5GsYSE/300BtUWP0
    1ED34r1vnpsFyqJG7egIDtAAJ/7QUeCRbRi+yKNg+b3551sVJqUqqZAZD58Z4KMXhlQi0Y
    C67bxX31KgbolYLdc1Ag0/XkZgyne4qXM+z6P+2q/tBU/inD9Pii2KQ4RRZzSd8oMQmqSF
    5NzaHiCDCnCcVgh2ktOccYhEQTIrKfbs0LaBvHV4JprfyLFkmik/8XtfWHlld6VAyQ2YqQ
    H6kEFkV6s+1Da7u4pimZ+gpZEQ29DnGkKRouJ2aE1CBwBRMn9RnUxqOn6pZYQ/5hLaewQq
    s3U/4U7ANbGzijpTtWRLhCM8AZ6EkJROWt30zQHt8eblYW6jO3mG3di9vclluZO/q9WY6W
    CSWoxdiQ43wKMW7/ZXJz7Ln4k3+gINAMygtOH/ff7JWt+zU7VX6xfxQzALt+/jgZ2qIce2
    nF0eQvcxpE4W7AilRKyOjRBSpMoRZcRvVkriqScPLUuGdYx63vo/n43qnME63jbTAmw/De
    Ozv7ZASRM7cffqaPi9wjQBrdLLq6PstRBX/gPXMSHJ/wJPF8opukEh55Vnqw
X-ME-Proxy: <xmx:DvJLalr8_9mDw9vlG3HwFR54GlSgva25T1CBcFAwVlv_Zq4oozYA2Q>
    <xmx:DvJLai2Mrk2UhHD6MIVSyr51K6M2Rw4SL2768Z-TZZVCRqpOECd3-w>
    <xmx:DvJLamCb9mCkcdVMNwjoP9MaZTGJitOKQuKDIOSL6uu8yB0unBge6Q>
    <xmx:DvJLarNtxTMikxEv7Jao_6ru7B69JLJyQgHnutNTpXrLMLjAT0vDSg>
    <xmx:DvJLarhfXpVhFzKk_ZGRBk-BqV814j2vk55WiqpIjcSe5bbARcoD7XkS>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:20:59 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v8 5/9] udp: Validate UDP length in udp_gro_receive
Date: Mon,  6 Jul 2026 21:19:37 +0300
Message-ID: <20260706181941.385672-6-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,isovalent.com:email,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA33471473A

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. Filter out malformed packets coming from
the wire with len=0 at udp_gro_receive to exclude them from GRO.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 4f9a3922937c..8f77c8788f6d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -707,12 +707,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		return NULL;
 	}
 
-	/* Do not deal with padded or malicious packets, sorry ! */
 	ulen = udp_get_len_short(uh);
-	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+
 	/* pull encapsulating udp header */
 	skb_gro_pull(skb, sizeof(struct udphdr));
 
@@ -782,8 +778,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
+	/* Do not deal with padded or malicious packets, sorry! */
+	ulen = udp_get_len_short(uh);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
 	 * otherwise we could corrupt the inner stream. Detecting such packets
 	 * cannot be foolproof and the aggregation might still happen in some
-- 
2.54.0


