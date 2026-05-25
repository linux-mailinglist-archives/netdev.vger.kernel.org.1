Return-Path: <netdev+bounces-291293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE28NXYwFGqUKgcAu9opvQ
	(envelope-from <netdev+bounces-291293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:20:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3335C9E36
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A7153025712
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476293446B9;
	Mon, 25 May 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mPQs3cdK"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B62DC321;
	Mon, 25 May 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707728; cv=none; b=PMJHUdnylZ3dIE0C3i3Tyd2mR3KE0EUBmE95cmEfsaSzk+4hv2cI7J7U6xG64+zKCTOb3hZ4gcjyFvs2/a1HlI/iN+wytg5MPY+6UlLwD4S+qTlNryqL5/UB9tNnE2azlQu5yDVAbOKiBcmUwBGZTECrwjFUBzA2Wr9EUvJgJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707728; c=relaxed/simple;
	bh=EbzlufNXW6YBgeATlTQezHzXvQyS5Z8qWV+S44goOcU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k66vQEnSmkmc6+nqajAoeZcai8VxteXYVT2vG+mgT3Q6lsK37MukxBvKlPdUbj7pR4yFTZeKFnIOh72uw8vpLreBQ84ViuZNuURXuvOOgjJtqMjeTsAPsXIhwgeif9IlbxEAvRCrLm3ncfoG/FH8fDp2VnCCmv46QCk/JSsbtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mPQs3cdK; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Un59sVCYBVbCELbPAJniZwPhDx+Hpg7qitcILgjJSZo=;
	b=mPQs3cdKtpmGn+KOuFPZGV+r7Uk+h7yeuJ57vWiCIxhAip7CNQ0vK09k7WGHCMXoRi1lxQHmo
	JCYabtvaQbvWAfgtqk8utmV1YbkC67gDNh5EapUrYd/GGXzoAMPJ49rtvVxtg8n2S6B1BAhfInw
	K5Ij0nIl63hX1u/d51wcV9c=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gPClM3p7JzmV6J;
	Mon, 25 May 2026 19:07:27 +0800 (CST)
Received: from kwepemr200009.china.huawei.com (unknown [7.202.195.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 3912640562;
	Mon, 25 May 2026 19:15:13 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr200009.china.huawei.com (7.202.195.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 19:15:12 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Mon, 25 May 2026 19:15:12 +0800
From: "malin (R)" <malin89@huawei.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>, tanjingguo
	<tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: Chenzhe <chenzhe@huawei.com>, cenxianlong <cenxianlong@huawei.com>,
	cuirongzhen <cuirongzhen@huawei.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, tanjingguo
	<tanjingguo@huawei.com>
Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Thread-Topic: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Thread-Index: AdzsNwDXM3GXlP0rSUS4BU76FCpiCg==
Date: Mon, 25 May 2026 11:15:12 +0000
Message-ID: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[malin89@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C3335C9E36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
From: Jingguo Tan <tanjingguo@huawei.com>
Date: Fri, 22 May 2026 19:53:45 +0800
Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb

virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
before entering the send loop, but virtio_transport_alloc_skb() still
fills the skb before it inherits that uarg. When fixed-buffer vectored
zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
skb_release_data() falls through to ordinary frag unref.

Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
before virtio_transport_fill_skb(). This keeps control or no-payload skbs
untouched while ensuring success and rollback share one lifetime rule.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---

 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio=
_transport_common.c
index df3b418e0392..73f58925ff72 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -205,6 +205,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_=
info *info,
 						  size_t payload_len,
 						  bool zcopy,
+						  struct ubuf_info *uarg,
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
@@ -245,6 +246,11 @@ static struct sk_buff *virtio_transport_alloc_skb(stru=
ct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
=20
+		/* Bind the zerocopy lifetime before filling frags so error rollback
+		 * frees managed fixed-buffer pages through the uarg-aware path.
+		 */
+		skb_zcopy_set(skb, uarg, NULL);
+
 		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy);
 		if (err)
 			goto out;
@@ -364,6 +370,7 @@ static int virtio_transport_send_pkt_info(struct vsock_=
sock *vsk,
 		skb_len =3D min(max_skb_len, rest_len);
=20
 		skb =3D virtio_transport_alloc_skb(info, skb_len, can_zcopy,
+						 uarg,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
@@ -371,8 +378,6 @@ static int virtio_transport_send_pkt_info(struct vsock_=
sock *vsk,
 			break;
 		}
=20
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
=20
 		ret =3D t_ops->send_pkt(skb, info->net);
@@ -1183,7 +1188,7 @@ static int virtio_transport_reset_no_sock(const struc=
t virtio_transport *t,
 	if (!t)
 		return -ENOTCONN;
=20
-	reply =3D virtio_transport_alloc_skb(&info, 0, false,
+	reply =3D virtio_transport_alloc_skb(&info, 0, false, NULL,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
--=20
2.53.0

