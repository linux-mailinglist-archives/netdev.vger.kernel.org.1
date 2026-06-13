Return-Path: <netdev+bounces-298973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gfBvG2BzLWregQQAu9opvQ
	(envelope-from <netdev+bounces-298973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8F67EE18
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="gmWuQ1E/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298973-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29679301C6E8
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E2336EF8;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC0283FCF;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363543; cv=none; b=Wflr0KUe1xEPj/zYcqtuaZFn2Tk8IYqSvjIif944cBEXA+5PKEll9o+JO0A6GZ5hOh7Vf7obq9rqyfczsL3vFcQb0u8GAqZEzPQz5oJ2AACetAJKswwwIcK2kOPmMjrse3+eb3XGuFhK/c0jirsQBdW7l5h+sFpQQNN4pcVngSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363543; c=relaxed/simple;
	bh=3iGuNRGwF6KbqdpQpYzoRFx8DEAq4BukQGQRoH2vc8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Is8LnJKiDggITXZaNgL9Ksq5v++11DwUhAUqXbRb8entjUq0bWzFt3nd9MGWe00VxhLK5DKAAic5enQ1iwClMdD3vQlGSdW5lJXz6psdZQr4NEn0wZWReSQM3H6pPKFk1+/ToQFFYVlTjbTF8GZ6M3rL9K5ubs8epJAsOD6URMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmWuQ1E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19974C2BCB3;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781363543;
	bh=3iGuNRGwF6KbqdpQpYzoRFx8DEAq4BukQGQRoH2vc8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gmWuQ1E/0HRqMpAIk2vYdWHT4qvlCQv8UgpbDM5/PO9sK+Gdb/APwcCpRbr+hmAUp
	 JEbydBrx2wW5FTnXnv7hbsx0dQdnlxywGawi2uspATexjfEk2iInpnD02vhslYVRgj
	 +bZo32gEVmURYJ2Jy3J2FuialnhS2FICDRU26CZmcdKCwvz2EF5FLMhgH6jFJ9xojv
	 1rkKJ7jPljLNBnWVJLwC1/5t2ZZOSTFnbRnyg3+vX8NT41cC1ZTzIeYOwvoErextRP
	 PC6ia4Y7iLG+77G8o7Bk1H3TFeLQYDsC1yI9O7FDpMmQy3OFNVWphdoabsiNQ9aVks
	 J8/eLQMtEgz3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A15CD98C5;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
From: Laika Price via B4 Relay <devnull+laikabcprice.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 16:12:17 +0100
Subject: [PATCH net v2 1/2] ip_tunnel: drop stale dst from generated PMTU
 ICMP replies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-master-v2-1-061b70fd45dd@gmail.com>
References: <20260613-master-v2-0-061b70fd45dd@gmail.com>
In-Reply-To: <20260613-master-v2-0-061b70fd45dd@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Laika Price <laikabcprice@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781363541; l=1524;
 i=laikabcprice@gmail.com; s=20260613; h=from:subject:message-id;
 bh=SlqlJpKzoB/L6zkG+UEJ69lP6dwHHlp+epcI3iSb4DM=;
 b=19U2jc9o7dSPmdznWNvS6iJjFcuXe0vKHvSe18xGApN9ZJGbom6qtXHnZSkhgfFMnZoVdnE+i
 4uuaihEIcPYA2sfzPS5jZhiUWhd8a/CUwaAC0Oryoh6IU9i67tyhuM6
X-Developer-Key: i=laikabcprice@gmail.com; a=ed25519;
 pk=mFSMw2odvyxt1H4QHAdwZVuwHduNzUMDKbWFOcwhDCg=
X-Endpoint-Received: by B4 Relay for laikabcprice@gmail.com/20260613 with
 auth_id=819
X-Original-From: Laika Price <laikabcprice@gmail.com>
Reply-To: laikabcprice@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:laikabcprice@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298973-lists,netdev=lfdr.de,laikabcprice.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[laikabcprice@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4A8F67EE18

From: Laika Price <laikabcprice@gmail.com>

iptunnel_pmtud_build_icmp(...) and iptunnel_pmtud_build_icmpv6(...) take
in an sk_buff, modify it to create a PMTU ICMP error reply, and return it.
As part of these modifications, the source/destination ethernet and IP
addresses are swapped around which makes the sk_buff's current dst invalid.

If the stale dst is left, the packet can skip input routing and be
forwarded using the original output device. This was observed when sending
packets to a VXLAN over a WireGuard tunnel - the ICMP reply was generated
but it was sent over the VXLAN instead of to the WireGuard tunnel.

Drop the stale dst after building the PMTU reply so that the packet is
routed using its new headers when it is reinjected.

Signed-off-by: Laika Price <laikabcprice@gmail.com>
---
 net/ipv4/ip_tunnel_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index d3c677e9b..949150e43 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -267,6 +267,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
+	skb_dst_drop(skb);
 
 	return skb->len;
 }
@@ -370,6 +371,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	eth_header(skb, skb->dev, ntohs(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
+	skb_dst_drop(skb);
 
 	return skb->len;
 }

-- 
2.54.0



