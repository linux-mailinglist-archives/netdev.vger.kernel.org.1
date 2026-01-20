Return-Path: <netdev+bounces-251556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJPeBpnGb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B508149470
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6D567EE197
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225344A712;
	Tue, 20 Jan 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KNImgKtE"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016A449ED2
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927095; cv=none; b=fOTzYBwgCmL+4EQZ/OeAgSIH0dDQIYQGuzIuWHE7HoLp2lrmoxVz8SvtywQKloidwWZm3d1GdKKBY6eRO+fhXKWtIG4Sw643EI5GnRDU9kuxzG4dKm9nbV28L2g0DoOP0F51vNt1nE6whpxxPvFvhcFQE1ZTkDulLH6mPDkAhls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927095; c=relaxed/simple;
	bh=kWPI3k7zwigOfsCR+jAiwbX3dWuSFTBsKeVPxecmZ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8y7IXf10nbciS4JKhc0zUVF3aXNrlHZxnvEkxjFnfVUWv4meaMjQSSavLoBHYPsE5PIpuAgSMZKNj68hm0LIqENyZB1/y3aSG2GP9mlkz2Yyurqu+hufq1CinywU7QIxAfSm3Q/9TWBh992st//SR1m5ZQLw1rPHnCFcw66V1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KNImgKtE; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927092; bh=j/fxblqY/eUwAQ8LvWyyAWz5KW8pCAtnpcDNc1BHti8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KNImgKtE3W+kUbLvoNxDZleNMxof1E98P1Bhg/ijPD0d0Rf9t3d/A64n5Shz1gv1B6NUJ/f/K8/f+6anZnRilFgw6VNUZ7LDUFPFzryYGbrKqOkg0bjAalv6bmulmu10pBv/Nmq77BaeeadX58o+vR3sJu0in5scPNcfnjzzzNLHwEWTD3MQd5t8dLWMAvX6US/gQwx8/0dwkgCEu4ByEsF/UTqekYQ4fdilVLT/gbiszO+Lrrp6zFOqwn0+sGB1t9FrpgeM83Kp37HELB8qp8OdI5bZhF3Vfy7D6mPq3aQwkr/CiGxSkhIS66216UuALOkNcsYa0oaMttbkoZjDWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927092; bh=s5jrn4ZYQ+ds4MuZfg6LO6K+jcsqDwd5htMBo/hqyUH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lgQRwGNzWZWVgk04yqc+DDy8d2k20ZA1jXqAjPY76llOybhTbCBX8Eq3coG6cqSuWi29ZyTjB2Kt8YwpIyVV9ry//c1Ykv07tTnE1MBhAqrBTkCNS2irlBy40r29CYpzJvG8UxJeX0zJfNM8kqOZBzBHJXqOzCd/+bo/SMDBIQrZ4X4Y6GjaoqYJ5s9D/u/cA4uwiPXDgNj21YX8/SKm8ksWtTz1CTx6pRSFfGxmf0Metd1dYlGaG/HoSu1Ck8FzkrrfX9hePi7PBefxcfkmE+gou2r48a+HnD/rdi2PPmz7Xxc3lMQpsseNuTkUWPYxMNoqC1jfKMKNB4YCsxr6Uw==
X-YMail-OSG: E..riKEVM1nLPPEpA9uktr337J42ACB2nusc_6O1nkvOUr.DZ.4IFrtFOM1kxrm
 od4NdnPHfM1jFkReoadVki4cGoUjcb9qonQgjaEbZBuMatN2cqkDPs4FW5oVmhi1dmYeTC9id9pf
 P.ztqJx9kz7UB8MeUYlTfRFNaBxHg6LhX8cjU2bbRcwMa0hbD4BUQD23TgrpL_547XgluLB1OjBv
 PkuG2XWN6U9m8w1luQr5Il4PjtbotXGPXK3o2mFyf30IJ9aM4oqCTLVcy4Xlc.odZY30Xd5AOimw
 3_TuG6QiI5dMl4D0HrdLQDB6b8sDnypEBR3_jFXl8chzmEsVl.yJ3wAQN8n.tsnceCk.I9b.US9X
 pFgE_V3jA_1aY9D5TUL.Kkptu2dAcDMw4bBiM4uKgETGsQ8BmoVFklHP5.BHfm24jryVXHpAzokQ
 Fvx8flizLCNIaEVJKhLjZTc2pb8KA7WjbPvaRrHHWYfCZK1P5mMyovjEvlQeMoC8QY0i1tfs75p9
 hHT6RvE7fcZK0PlTK6waucscXWQeB10sLBnxmWZN0Iumw3AKuieD2b41VTi3isFe0nSMf5MSAlpU
 p4jI13pkhrdlJ.3NOKy939CQyXlFj534Op1Jg9UKF49tzguv5VqGnwE6XcpjANnIPZiihe0hXDAG
 dOLDi1VU0QfROASQ2oGEhjqPaeuDQmSRSg.k.ydjoig1HTy6AAtCXFo.JpBD39JU3A..kUGHiM7g
 e8815WTu6GIbwmTjPNpYgF5MLiqUl94P0.UdYWyooGwQ6UcsGDAmbydc_YSNNDj3k0NCHfLcgVCq
 a5S5DbgyPN7OiWzezKghh2tda87PgyrliaCd86qvKrqtPFqs8eIAOhF_V9bjE_ABOqjXQ0jH3EGx
 IndwRgo7yPIcMDBU6gp1toptdIumqHFGevWMdWS0fd7FFcLi6GWGIehNCo9jCfJaYdNImKRBhRvL
 DEHAwenG8joXyKKED7017Xr_NC_IKPQJDe2VwojppUJDmQNdCUM7X.8isH3nh18bjLCyYadkxQpG
 YAFmUOnvKb4wY2F4718bBd7VPIpSlW.4Jxf44nsyB2kcv7L.LgauSMEdKoyQi2MvoyoEzgJ4y2SI
 QIuj93y6Jz2AWgj5GKDCwIBavRmpKfBI79mNsJVNNwNjogax5sZgkyDw03ULKx1R.SQ4kjRiOGC7
 GR48nXQO0WwGkB3fDjmMZOnixT9XhkNSAYzSbn9RgK4uPsKmtKWWa8Fc6Tr1yE.MNWdqU3HMu9W1
 VYmPoyXEuOZL5TJj6xqGzqAG_saVbYwjP5p4MbtRq76xesaXVRtPthcH1lxFoaUbrXQNoV_BDH2a
 KMh8AL4WoCWquYorHZ8qQGW0RhEGExYY2i2yW8CYMICK0KxSyUVBvA0.M7FSkSP0FXs5peP6orrX
 .2x5KPcVV5sYh1RbXtIw3KkZj8eirXksbZJPK_snHk8rtmR.dkdnz7FEDxDhx66H085_gzIuUxNG
 z1OU45DWrV2aaOjDBqp9khDbKtkbT9LepFESZPjICSOdHdYKn1JT9dX4rnPAnnFO0myFnDNqtUEM
 XjtQV1DOmA6Pkeb6beyMg8QNxMCwPdN0Qn.YXuNAAgDoozsYn_IZ8tv9Yqi8Nrr4k6iYEeBVZ3Ih
 OFtygSH3yZqw1aUuNJ9kuK_E_LxtiJQkxbDciNhzn_z0zC1aV3HfxiwXvkR00_qMiv_ydpKi9TxL
 973Nzji2ZVsT9u.iSuZEQyi_UrpPpJieGR.7GIzMAVDZV4O9W4u9dw82HKeW06S3Nl03GGZunm7c
 8ycQC0lDc0NkQms.ykBM0xURQGYAlfiHsq5_LAVXxzr6xxk8RWB4tXNVnc1EcFdwLocZEkpC8H0u
 f25.nEqplBeKLpU.5dGzgGuGadoVn.ekglKEc6K17PMcjWDpxLCfPqk2ndeBUYLCD3TwU4u_PqFf
 SYRp3clFqgE_eRccnMShs.tokjEdSoitbaFP29Fww0LGtT2v.JWiiimLSaaCdR_HxxC5mf6owIrg
 ViaxIEQRZnRBo9LDAOhnSEoDffnrUh6ueU_EneEcUdvK.JSZ7n82NIaiFmSE7uLgu0buz1crDbWb
 5mj1UNTSsSPd5xi5bUvhdtUzOAPVwHoKvR9nSQhVJcRZ_brlzIl6.7DReskTJUXobiGG.IBuf.oE
 mGOL3.KzoDf26ac3KCZHZNlMwErkZfQ6mpP8WJ8Ees2TrfN7k
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 221f2e4a-4e8e-4317-abbc-a69c0a2d0df0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:38:12 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:27:57 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 09/11] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Tue, 20 Jan 2026 17:24:49 +0100
Message-ID: <20260120162451.23512-10-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251556-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B508149470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_v{4,6}_xmit unnecessarily clone the dst from the transport when
sending an encapsulated skb.

Reduce this overhead by avoiding the refcount increment introduced by
cloning the dst.

Since t->dst is already assumed to be valid throughout both functions,
it's safe to use the dst without incrementing the refcount.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/sctp/ipv6.c     | 7 ++++---
 net/sctp/protocol.c | 8 +++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 38fd1cf3148f..71fb9ff6276f 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -219,7 +219,7 @@ int sctp_udp_v6_err(struct sock *sk, struct sk_buff *skb)
 
 static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi6 *fl6 = &t->fl.u.ip6;
 	struct sock *sk = skb->sk;
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -243,7 +243,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
 		int res;
 
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		rcu_read_lock();
 		res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
 			       rcu_dereference(np->opt),
@@ -261,10 +261,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	rcu_read_lock();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
-	dst_release(dst);
+	rcu_read_unlock();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ff18ed0a65ff..fb26b927391b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1038,7 +1038,7 @@ static int sctp_inet_supported_addrs(const struct sctp_sock *opt,
 /* Wrapper routine that calls the ip transmit routine. */
 static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1056,7 +1056,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	SCTP_INC_STATS(sock_net(sk), SCTP_MIB_OUTSCTPPACKS);
 
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		return __ip_queue_xmit(sk, skb, &t->fl, dscp);
 	}
 
@@ -1070,11 +1070,13 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+
+	rcu_read_lock();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
-	dst_release(dst);
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.51.0


