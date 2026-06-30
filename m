Return-Path: <netdev+bounces-303343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBmqMlsXRGqIoQoAu9opvQ
	(envelope-from <netdev+bounces-303343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37B6E7863
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=AfUTRaK1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303343-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D779E312CB36
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328873DB632;
	Tue, 30 Jun 2026 19:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2003k-snip4-4.eps.apple.com [57.103.91.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6B3C5DB6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847092; cv=none; b=CMe9XCTOjLwyX4R4ir77X4enhM7gidx7wbn9xfqqC04UUhyup7hR+7jfX6x1ML+/MjFVhioTu6QyruwkCSO81KlvMLgxOz3987L9JWuOQmy5BPrhrH0hLoEopkjNEym2gg7M95K/Z6iZJC/BsypUabPxd7lWjrwcSd+SfkaZIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847092; c=relaxed/simple;
	bh=tDTKbjGelxHYdq0P/yQNXaUtsP+AKmJ6h8QfqI3vOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3Iq5fU8itjLkv+pHA2QwQbMpsggarUTkP+3PRhHMpGfAnYSW4I7RT0K4B87iX+PgmnZa4YNAilZmTppkEFP8ZFk4D5T2VJD6MLFA7L3Tkb3RhFVP+FnB9hbHYQF4rMuB1EaiZipcveZO3FTeEiCUNr2E8MvrWCkiU3WsBgTNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=AfUTRaK1; arc=none smtp.client-ip=57.103.91.235
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 1CBFA18015D5;
	Tue, 30 Jun 2026 19:18:01 +0000 (UTC)
X-ICL-RepId: 019f19f7-8e1e-7cff-a214-104e7a8a714c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGl4fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847084; x=1785439084; bh=J81YmnAPrP6zHKrLn+lQ24l9/ckBcDQUWCB+REgLVWI=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=AfUTRaK1VWjZGkuIaY/BToghmh2hUpHDGW5owJwcrziGZxY7tkdDa6GsoEz4LG5ZYWYc/IpVWm55a/qzZOSULgseO8RcyPEzaJZWK6MmxVbn2zgdYVoXeTL8F7eJO6+yeK3gMZ/k8ZMWGU7T0gItm/8AwSGKTaz0ijddoBQFioDGTXAnuQsXOqYxk07Z1pxc0F0ENIoJOo8N1Xzj9gxTJC61gJ3TyYPiOOtchyUp239zsk/r6gALCbQK7180wV8PEumFyHkJ0+JBqxLZV0rTKMV0vsGMVzJ6jRw35OKuHaS6eI2zydKTuT4vPMQ/C0arbI5LNuTnVT9Vx9MRPN9yNQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 3E07E1800375;
	Tue, 30 Jun 2026 19:17:59 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 4/7] net/mlx5e: support the rx_csum XDP metadata hint
Date: Tue, 30 Jun 2026 22:15:07 +0300
Message-ID: <20260630191510.81402-5-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6ZMu9A_ILdra1GCI_IansEXtJqcBIWzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX1YHBZ68OfrUk
 kBn4GvUUc8Caze7+5gSXYu+TQnoqnqk0Vbvwst6Iy8TQlZHtn81ElqSvKZVTgqAQL/iM9fMMv8U
 Nuom7/G91G7uNskChRB3Lifrpatm+UYg1uHr8DN4yJh77Wx7xd9+Pa58jSE3DUk2BzrKLsHSfuf
 9swgSzYs6Dzt873GWZARjTE97prETX3S1fDnbWMdzW3T97Js8aUu2jACoBjKGan583wm9sZ3YpX
 ayRBUQ5oK/GkNsJ6dq4ctUq7UlOdGKmze/YenKcpeOQaZCywzDYy9Zs+hLIAQZ3Jvfv0vO+1Hpx
 4nXsqwkhJ1VrgeIg7BA
X-Proofpoint-ORIG-GUID: 6ZMu9A_ILdra1GCI_IansEXtJqcBIWzq
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303343-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E37B6E7863

Implement xmo_rx_csum by reading CQE_L3_OK/CQE_L4_OK, mirroring the
verdict mlx5e_handle_csum() uses for CHECKSUM_UNNECESSARY.
CHECKSUM_COMPLETE is intentionally not surfaced: it is already
disabled while an XDP program is loaded.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d8c7cb8837d7..6ac06bd24c79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -277,10 +277,33 @@ static int mlx5e_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return 0;
 }
 
+static int mlx5e_xdp_rx_csum(const struct xdp_md *ctx,
+			     enum xdp_csum_status *csum_status)
+{
+	const struct mlx5e_xdp_buff *_ctx = (void *)ctx;
+	const struct mlx5_cqe64 *cqe = _ctx->cqe;
+
+	if (unlikely(!(_ctx->xdp.rxq->dev->features & NETIF_F_RXCSUM)))
+		return -ENODATA;
+
+	/* Same verdict the normal RX path uses for CHECKSUM_UNNECESSARY.
+	 * CHECKSUM_COMPLETE is deliberately not surfaced here: it is disabled
+	 * while an XDP program is loaded (see mlx5e_handle_csum()).
+	 */
+	if (likely((cqe->hds_ip_ext & CQE_L3_OK) &&
+		   (cqe->hds_ip_ext & CQE_L4_OK)))
+		*csum_status = XDP_CSUM_VERIFIED;
+	else
+		*csum_status = XDP_CSUM_NONE;
+
+	return 0;
+}
+
 const struct xdp_metadata_ops mlx5e_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= mlx5e_xdp_rx_timestamp,
 	.xmo_rx_hash			= mlx5e_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= mlx5e_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= mlx5e_xdp_rx_csum,
 };
 
 struct mlx5e_xsk_tx_complete {
-- 
2.47.0


