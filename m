Return-Path: <netdev+bounces-266525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUgLaEksWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:15:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55325EC6D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93C0D300646B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D02673AA;
	Wed, 11 Mar 2026 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aDt0qd9W"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96045128395
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216923; cv=none; b=VExYQGnGs+41looRWsTabVgI6ZMczP5wPMkHIWan+oEuElMM/QjbotNFWuxocAJipjS8ExXqLpeXb9m0aEnOOF59JaMEwwGGohHYdYA1ugDAmFnmkTxBeki7DGCKJyBPjJ9mgU94jWsqNTWIb6f9ZbiOIOhluutpOqERXt/UBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216923; c=relaxed/simple;
	bh=Ibv6mxb85Vjx6GR5bQ/iXScyrnppslxrk2BO6HTNO9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=FkBGc5pulugopaj99KTko8W1RHJ1tFVYqoPW5NgaNkd7v2yJ560XzHh767phvN+UswTu8+Y+DP0BS5pjsa80ONb/EjhHDxt3fOYe+T+QyotGCBBJIlsqfBkvFpIbFgZRryeFevmEESuhZuqYaX5eytptNYx/Pn7oR+Fh7PfglWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aDt0qd9W; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260311081516epoutp025e9721e68355dab62d6573c3dbacc704~bu2QACPoW1703617036epoutp02P
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:15:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260311081516epoutp025e9721e68355dab62d6573c3dbacc704~bu2QACPoW1703617036epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773216916;
	bh=h9QCX6BKlj6YsGEm1cfpdulcqfYz926u/2gberIih6I=;
	h=From:To:Cc:Subject:Date:References:From;
	b=aDt0qd9WcLNkF5kPaX0dJhZt9jVb010HlptXuMT71Zyfwwnreu3JnXn0lle7mOTuv
	 81iCdQxI/oQJw8SfWwvR50GBfeJN0Vd77OuWWIcE45oLhMR1RM68u8/FxHTZj1UxaS
	 A2bt8hQ+Zl6Mq4VufwS/0ecN9j4M4Qnl6cb1kCIA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260311081516epcas5p4a92c7912401b6fc8d7b9b7e362c12bb9~bu2PlYVg92240022400epcas5p4L;
	Wed, 11 Mar 2026 08:15:16 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fW3TH740Cz6B9m9; Wed, 11 Mar
	2026 08:15:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326~bu2PKsr952652726527epcas5p4f;
	Wed, 11 Mar 2026 08:15:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [109.144.5.214]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260311081514epsmtip1152ce47e14e910fee9d10d443392fbbc~bu2OTGv5w2716427164epsmtip1K;
	Wed, 11 Mar 2026 08:15:14 +0000 (GMT)
From: "tailu.shi" <tailu.shi@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, "tailu.shi" <tailu.shi@samsung.com>
Subject: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO packet
Date: Wed, 11 Mar 2026 16:14:01 +0800
Message-Id: <20260311081401.3832000-1-tailu.shi@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326
References: <CGME20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326@epcas5p4.samsung.com>
X-Rspamd-Queue-Id: 5B55325EC6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-266525-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,iki.fi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bluetooth.com:url,samsung.com:dkim,samsung.com:email,samsung.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tailu.shi@samsung.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

The Bluetooth Core Specification defines the 'Time_Stamp' field of
an HCI ISO packet as optional. However, it's mandatory to include
the 'Time_Stamp' field when using HCI ISO packets per section 3.3
'HCI Feature Support Requirement' of TMAP specification.
https://www.bluetooth.com/specifications/specs/html/?src=TMAP_v1.0.1/out/en/index-en.html#UUID-68138fa8-fd1f-1a1b-e552-ddcd8fede9ec

To comply with TMAP, introduce a new socket option BT_PKT_ISO_TIMESTAMP
that allows user application (e.g. PipeWire) to attach timestamp to the
data it sends to the ISO socket within BT_SCM_PKT_ISO_TIMESTAMP CMSG.

When the option is enabled, the kernel extracts the timestamp and copies
it into the 'Time_Stamp' field of the outgoing HCI ISO packet.

This also gives the controller the reference timing information
required for ISO stream synchronization.

A corresponding userspace change is required for full functionality.
A reference implementation is available in PipeWire:
https://gitlab.freedesktop.org/shitailu/pipewire/-/commit/5b3bd74e15febb974c8737a64f31fd17e18cd11b

Signed-off-by: tailu.shi <tailu.shi@samsung.com>
---
 include/net/bluetooth/bluetooth.h |  5 ++++
 include/net/bluetooth/hci_core.h  |  1 +
 net/bluetooth/hci_core.c          |  2 +-
 net/bluetooth/iso.c               | 49 +++++++++++++++++++++++++++----
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 69eed69f7f26..f88c83d21c5e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -259,6 +259,10 @@ struct bt_codecs {
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+#define BT_PKT_ISO_TIMESTAMP     23
+
+#define BT_SCM_PKT_ISO_TIMESTAMP 0x06
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -409,6 +413,7 @@ enum {
 	BT_SK_SUSPEND,
 	BT_SK_PKT_STATUS,
 	BT_SK_PKT_SEQNUM,
+	BT_SK_PKT_ISO_TIMESTAMP,
 };
 
 struct bt_sock_list {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..e39d192f8ef6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -740,6 +740,7 @@ struct hci_conn {
 	struct bt_iso_qos iso_qos;
 	__u8		num_bis;
 	__u8		bis[HCI_MAX_ISO_BIS];
+	bool		iso_pkt_ts;
 
 	unsigned long	flags;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 31308c1de4ec..4264c0229dfb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3335,7 +3335,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 	list = skb_shinfo(skb)->frag_list;
 
-	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, 0x00);
+	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, conn->iso_pkt_ts ? 0x01 : 0x00);
 	hci_add_iso_hdr(skb, conn->handle, flags);
 
 	if (!list) {
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..dd4d198bab4c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -73,6 +73,9 @@ struct iso_pinfo {
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
 	struct iso_conn		*conn;
+	bool			ts_flag;
+	__u32			ts;
+
 };
 
 static struct bt_iso_qos default_qos;
@@ -542,6 +545,7 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
+	struct hci_iso_ts_data_hdr *hdr_ts;
 	int len = 0;
 
 	BT_DBG("sk %p len %d", sk, skb->len);
@@ -552,13 +556,20 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 	len = skb->len;
 
 	/* Push ISO data header */
-	hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
-	hdr->sn = cpu_to_le16(conn->tx_sn++);
-	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
-						      HCI_ISO_STATUS_VALID));
+	if (iso_pi(sk)->ts_flag) {
+		hdr_ts = skb_push(skb, HCI_ISO_TS_DATA_HDR_SIZE);
+		hdr_ts->ts = cpu_to_le32(iso_pi(sk)->ts);
+		hdr_ts->sn = cpu_to_le16(conn->tx_sn++);
+		hdr_ts->slen = cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS_VALID));
+	} else {
+		hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
+		hdr->sn = cpu_to_le16(conn->tx_sn++);
+		hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS_VALID));
+	}
 
 	if (sk->sk_state == BT_CONNECTED) {
 		hci_setup_tx_timestamp(skb, 1, sockc);
+		conn->hcon->iso_pkt_ts = iso_pi(sk)->ts_flag;
 		hci_send_iso(conn->hcon, skb);
 	} else {
 		len = -ENOTCONN;
@@ -1471,7 +1482,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb, **frag;
 	struct sockcm_cookie sockc;
-	size_t mtu;
+	struct cmsghdr *cm;
+	size_t mtu, hlen;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1485,10 +1497,23 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	hci_sockcm_init(&sockc, sk);
 
+	iso_pi(sk)->ts_flag = false;
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (err)
 			return err;
+
+		for (cm = CMSG_FIRSTHDR(msg); cm; cm = CMSG_NXTHDR(msg, cm)) {
+			if (cm->cmsg_level != SOL_BLUETOOTH)
+				continue;
+			if (test_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags) &&
+			    cm->cmsg_type == BT_SCM_PKT_ISO_TIMESTAMP &&
+			    cm->cmsg_len == CMSG_LEN(sizeof(u32))) {
+				iso_pi(sk)->ts_flag = true;
+				iso_pi(sk)->ts = *(u32 *)CMSG_DATA(cm);
+				break;
+			}
+		}
 	}
 
 	lock_sock(sk);
@@ -1502,7 +1527,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	release_sock(sk);
 
-	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
+	hlen = iso_pi(sk)->ts_flag ? HCI_ISO_TS_DATA_HDR_SIZE : HCI_ISO_DATA_HDR_SIZE;
+	skb = bt_skb_sendmsg(sk, msg, len, mtu, hlen, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1840,6 +1866,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_PKT_ISO_TIMESTAMP:
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
+			break;
+
+		if (opt)
+			set_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.25.1


