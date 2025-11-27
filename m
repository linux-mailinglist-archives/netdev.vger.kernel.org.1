Return-Path: <netdev+bounces-242149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F42C8CBDC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998063A6436
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9372BEC4A;
	Thu, 27 Nov 2025 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5JvYELa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5F125A9;
	Thu, 27 Nov 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213681; cv=none; b=WVB3eP+SgV3hrPoEsYG28V2lGiGVDYHgnkwnQhbVV4ywNVaB233K+kg9MV5DkCEHTaoHQ8XdJWvXo2eHsCmPI/zEVSYkApFdxki7RY7Fl1+71R+z6BSTx98XHmW1dkbKf/cNPm1dF3r/jbqLRou3aZPkDg+OChqUnxINI68D+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213681; c=relaxed/simple;
	bh=P8jxfYSJftEgcsHOR5X5lyo7/LvzrbP9eo130pWUCSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MJT7Yisf2ED1plz79pBscldVEPSDaf+r8x7ylMDNkWPpMi0SDsTEv/ELkq5ufAGxNbk5jP2fdWWscC6Xg2tY1mDYzvU4KFE5I797TVDHxUOkkJjFdppQKgFlKhM8augNWvBUFRpipeKd5Egsnr0Q/0PXUTX51fMLrsee+5IHFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5JvYELa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D8BC4CEF7;
	Thu, 27 Nov 2025 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213680;
	bh=P8jxfYSJftEgcsHOR5X5lyo7/LvzrbP9eo130pWUCSo=;
	h=Date:From:To:Cc:Subject:From;
	b=o5JvYELai7QNJZ+381QC1V2zfSxr4NG0KVrLgR4mrGcloTZ0vtuSUC/I/Dwlm/LTV
	 G9LeEX1EKqrack8LUpSrQqc37ED3DhRNeAWW3Px+gpuIAh6j0ofUQDPXeGjaykJf9L
	 G74GHtb4L2cI303IfT8NzZKtK+enfv0Fk7Exht8x76Q6XjyXsp9QSsC8gS4RkV47GW
	 dvfFv9GraDWRErjicaohl8Ydjyvt6gpF/Hx/P0zBp3xoaDZ9l7MCkIdqIsY1iLPWpl
	 8OXSQiumw7ZerdhvMrK4mPsBXbV7KH9PNLCNJcFlIEzcPfPXyXQiBSaKlbdc2IjLP4
	 moavstTSQolgw==
Date: Thu, 27 Nov 2025 12:21:14 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] nfp: tls: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aSfDqouLFcA4h8JX@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with flexible-array members in the
middle of other structs, we use the `struct_group_tagged()` helper
to separate the flexible array from the rest of the members in the
flexible structure. We then use the newly created tagged `struct
nfp_crypto_req_add_front_hdr` to replace the type of the objects
causing trouble in a couple of structures.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

Lastly, use container_of() to retrieve a pointer to the flexible
structure and, through that, access the flexible-array member when
needed.

So, with these changes, fix the following warnings:

drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:58:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:65:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Avoid 80+ character lines.
 - Add RB tag.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aR5_a1tD9KKp363I@kspp/

 .../net/ethernet/netronome/nfp/crypto/fw.h    | 24 ++++++++++++-------
 .../net/ethernet/netronome/nfp/crypto/tls.c   |  8 +++++--
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/crypto/fw.h b/drivers/net/ethernet/netronome/nfp/crypto/fw.h
index dcb67c2b5e5e..1e869599febb 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/fw.h
+++ b/drivers/net/ethernet/netronome/nfp/crypto/fw.h
@@ -32,16 +32,22 @@ struct nfp_crypto_req_reset {
 #define NFP_NET_TLS_VLAN_UNUSED			4095
 
 struct nfp_crypto_req_add_front {
-	struct nfp_ccm_hdr hdr;
-	__be32 ep_id;
-	u8 resv[3];
-	u8 opcode;
-	u8 key_len;
-	__be16 ipver_vlan __packed;
-	u8 l4_proto;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(nfp_crypto_req_add_front_hdr, __hdr,
+		struct nfp_ccm_hdr hdr;
+		__be32 ep_id;
+		u8 resv[3];
+		u8 opcode;
+		u8 key_len;
+		__be16 ipver_vlan __packed;
+		u8 l4_proto;
+	);
 #define NFP_NET_TLS_NON_ADDR_KEY_LEN	8
 	u8 l3_addrs[];
 };
+static_assert(offsetof(struct nfp_crypto_req_add_front, l3_addrs) ==
+	      sizeof(struct nfp_crypto_req_add_front_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct nfp_crypto_req_add_back {
 	__be16 src_port;
@@ -55,14 +61,14 @@ struct nfp_crypto_req_add_back {
 };
 
 struct nfp_crypto_req_add_v4 {
-	struct nfp_crypto_req_add_front front;
+	struct nfp_crypto_req_add_front_hdr front;
 	__be32 src_ip;
 	__be32 dst_ip;
 	struct nfp_crypto_req_add_back back;
 };
 
 struct nfp_crypto_req_add_v6 {
-	struct nfp_crypto_req_add_front front;
+	struct nfp_crypto_req_add_front_hdr front;
 	__be32 src_ip[4];
 	__be32 dst_ip[4];
 	struct nfp_crypto_req_add_back back;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index f252ecdcd2cd..9983d7aa2b9c 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -180,7 +180,9 @@ nfp_net_tls_set_ipv4(struct nfp_net *nn, struct nfp_crypto_req_add_v4 *req,
 	req->front.key_len += sizeof(__be32) * 2;
 
 	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
-		nfp_net_tls_assign_conn_id(nn, &req->front);
+		nfp_net_tls_assign_conn_id(nn,
+			container_of(&req->front,
+				     struct nfp_crypto_req_add_front, __hdr));
 	} else {
 		req->src_ip = inet->inet_daddr;
 		req->dst_ip = inet->inet_saddr;
@@ -199,7 +201,9 @@ nfp_net_tls_set_ipv6(struct nfp_net *nn, struct nfp_crypto_req_add_v6 *req,
 	req->front.key_len += sizeof(struct in6_addr) * 2;
 
 	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
-		nfp_net_tls_assign_conn_id(nn, &req->front);
+		nfp_net_tls_assign_conn_id(nn,
+			container_of(&req->front,
+				     struct nfp_crypto_req_add_front, __hdr));
 	} else {
 		memcpy(req->src_ip, &sk->sk_v6_daddr, sizeof(req->src_ip));
 		memcpy(req->dst_ip, &np->saddr, sizeof(req->dst_ip));
-- 
2.43.0


