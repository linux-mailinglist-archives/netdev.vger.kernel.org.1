Return-Path: <netdev+bounces-280247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ge5HW/e52kBCAIAu9opvQ
	(envelope-from <netdev+bounces-280247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D890C43F787
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E16D3118A6D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569F3DDDB0;
	Tue, 21 Apr 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iBxX3kfE"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A213DCD8D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803054; cv=none; b=ML+Xe6YpLPgRdDHSYM4GhK6yqXk09WT1YJvE1qFf/gOBjMIrfy6rDzGMSMas/ZtA6QvWagPFZNBiexn5bse8YDptFMo5Ouzzc90ojjBkO5/MyIL8dpM7NZFIzJZzDOr/GtHTFNEwP542duyFdxLCsugXbvk5rnZwulllAdYCl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803054; c=relaxed/simple;
	bh=BTLGDVBv0alg8QuEgZ/VjW8L47uXNsBRtvET8itbm08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5Cm3YtwW5XaYYv7xJ3IBjpZpzDkP4xZ024RIoK6n+3JUsFiXjuPbuLlXlP/1WeeheTkuBWRslTGTdNLthnoq8GI48UFUTEyHlsTfCjnhhYkraKHBIzPPELWRGxVueWjfQ5bo7lk9RnA22d7tp15nontdJfWXcjaPr2LkUwGigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iBxX3kfE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=YNuaCHxI6jA4cGLf4fhTd4+L9B+26Qqb0MCb6mrfy8o=; b=iBxX3kfEG/psfeSBIVy2lBUroe
	+uO7KoLu5GJ5GOLHkNKp6oGMIEwYPEUqN6eb7yRuwNxgW1va8uDBHuxMBlvf0HDf/rsSM+Eg7hsoj
	p6jPLftJ20vNNK8umTLb3IVUz04SEF3LQM1txm4LuKHnh6vzaAdwXjKbBJjrIWNX7WUOm0KhVqTsN
	UebliBhONBHJ+4JO+NrwA/x+CdL5tGZQyVmJA8Miyl+s7q6OB1dz1QmYAjrQZGW8kd3BA8Pg6beoB
	0y4Cg5fjsW9zEe9+Xh6SsksIVn7sII1vycrnyxgORDwf6hgWgRTbK5EHOhkOZc1eMLyiHmSEd7+G3
	/yyUEorw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wFHdg-000BVY-1z;
	Tue, 21 Apr 2026 22:24:08 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3] ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim
Date: Tue, 21 Apr 2026 22:24:06 +0200
Message-ID: <20260421202406.717885-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27978/Tue Apr 21 08:26:17 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D890C43F787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
and applied them in ip6_parse_tlv(), the generic TLV walker
invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().

ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
loop is bounded only by optlen, which can be up to 2048 bytes.
Stuffing the Destination Options header with 2046 Pad1 (type=0)
entries advances the scanner a single byte at a time, yielding
~2000 TLV iterations per extension header.

Reusing max_dst_opts_cnt to bound the TLV iterations, matching
the semantics from 47d3d7ac656a, would require duplicating
ip6_parse_tlv() to also validate Pad1/PadN payload. It would
also mandate enforcing max_dst_opts_len, since otherwise an
attacker shifts the axis to few options with a giant PadN and
recovers the original DoS. Allowing up to 8 options before the
tunnel encapsulation limit TLV is liberal enough; in practice
encap limit is the first TLV. Thus, go with a hard-coded limit
IP6_TUNNEL_MAX_DEST_TLVS (8).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
  v2->v3:
   - Hard code limit of 8 instead of max_dst_opts_cnt (Ido)
  v1->v2:
   - Use abs() given max_dst_opts_cnt's negative meaning (Justin)
   - Remove unlikely (Justin)

 net/ipv6/ip6_tunnel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 907c6a2af331..4546a60942ab 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -62,6 +62,8 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("ip6tnl");
 MODULE_ALIAS_NETDEV("ip6tnl0");
 
+#define IP6_TUNNEL_MAX_DEST_TLVS    8
+
 #define IP6_TUNNEL_HASH_SIZE_SHIFT  5
 #define IP6_TUNNEL_HASH_SIZE (1 << IP6_TUNNEL_HASH_SIZE_SHIFT)
 
@@ -430,11 +432,15 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 				break;
 		}
 		if (nexthdr == NEXTHDR_DEST) {
+			int tlv_cnt = 0;
 			u16 i = 2;
 
 			while (1) {
 				struct ipv6_tlv_tnl_enc_lim *tel;
 
+				if (unlikely(tlv_cnt++ >= IP6_TUNNEL_MAX_DEST_TLVS))
+					break;
+
 				/* No more room for encapsulation limit */
 				if (i + sizeof(*tel) > optlen)
 					break;
-- 
2.43.0


