Return-Path: <netdev+bounces-303344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0QFQFLkWRGpNoQoAu9opvQ
	(envelope-from <netdev+bounces-303344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F313D6E7836
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=n84PIVDW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303344-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F825305C5F2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980653E3DBE;
	Tue, 30 Jun 2026 19:18:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2003d-snip4-4.eps.apple.com [57.103.91.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7254272E7C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:18:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847094; cv=none; b=L2aLzFdU9G8P6zr9VIyDfN5ouxtGyLREacOYBPWG9pZa5uQO2pmuq4bYkRqPw+bXOKV174PcLSK2hrQ29ZuyVETmntEiOMuvk2UoDuJ3TQfvJycTY01afzmI4zR6y1He7DtAnqHnSSCiDX/5tipPMOREF8cMq21Th6pntH2a2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847094; c=relaxed/simple;
	bh=5BykT81qTnmm4vpcgmzIZjA/frIMRr2JvZYfSYh06Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qH/oG6p0EX9V6FuVFX/XjRwHDGPMnXIkmwcFq8orc5x6b5GiIMT+ph3h77kCXglvDxyw2LoIE5GJvzEdMZkvQ5n7UJbB8H5/TWgDhHN/I8hdHzniG5EYauYqeq8siIWvNo6qCWr4LlmDFsaQfIhdVYqVHSM14nuU0ddIqfZdFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=n84PIVDW; arc=none smtp.client-ip=57.103.91.165
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id B42A11800350;
	Tue, 30 Jun 2026 19:18:06 +0000 (UTC)
X-ICL-RepId: 019f19f7-a042-7bb6-9150-451fadb1a01c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlwfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847088; x=1785439088; bh=J8z0BiiSjdwjKKt9TLWZCWvOoAAMr8hZowRTHIkZBCQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=n84PIVDWy55gep61QyicHC+c1aZniluA1McIUJTzA2/URYS243pZ8gXcCENxCyhb8a7H56XOyTpZjOR27sqeR4Arnte87e7hbJ0M6AIFBFXb0HvQ5dJ5C23IViuQlFKNBknowEJQeJ8yQGbOWtQf6WO3uAcAgCrb3KVQHx61zNXGk86qyg2LEdyT9X4+XtzKQL7nO0MP7ELfORZQHxdt+gflLA6QhwARuHRDq4sLVJMvIwc5AY8M1jIFRZyh2Z0YdEwEUj/slNqYru9ou2gQU5cI9m7cT/e4Qk/92TcQoBp9iWnPiPPiPNpbewXu3VrwK34Ux8qLRJiJWRok60a0qw==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 180311801A8C;
	Tue, 30 Jun 2026 19:18:03 +0000 (UTC)
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
Subject: [RFC PATCH bpf-next v1 6/7] veth: support the rx_csum XDP metadata hint
Date: Tue, 30 Jun 2026 22:15:09 +0300
Message-ID: <20260630191510.81402-7-deliran@verdict.gg>
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
X-Proofpoint-ORIG-GUID: BXq2mXTp8n7D_PbQzsLZ1LGacAcheszS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX1W5294QcEWPR
 xI6facMuzf6VBJaKPGUfrU+iMkcHDa++bxhALJXzbEvKdfDUSLRpF6W0yJ7DMTma+FZkehmO9mJ
 vfY5eP0KrvBf4Md9Q2hlUecg8Qeyon7tu9JQir1qjCydpTkVcQvBMBzBc46MwsC8/FYcWfXFd38
 FdJZoJgoWJqif6modoVFlDWNLNkarxEhh9J2S+Mw58+jvzxLR2mbStrDbzpL4RSxRE8qnZmc1g2
 ysJOua+QSJzoyYiwEuwo/qK1PFD2AvpsffWWbgVpyql4ic4z+v8S5+zXxWQOsf1rUyn/XomxsE9
 IFRsFtkoo27FZM80E9V
X-Proofpoint-GUID: BXq2mXTp8n7D_PbQzsLZ1LGacAcheszS
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303344-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F313D6E7836

Implement xmo_rx_csum from skb->ip_summed.  veth has no real hardware;
this surfaces whatever checksum verdict the skb already carries and makes
the metadata kfunc testable without a NIC.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/veth.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..b7bc5a3b07e5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1700,6 +1700,28 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_csum(const struct xdp_md *ctx,
+			    enum xdp_csum_status *csum_status)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	/* veth has no real hardware; surface whatever checksum verdict the
+	 * skb already carries (e.g. CHECKSUM_PARTIAL/UNNECESSARY from a local
+	 * sender or a previous validation).
+	 */
+	if (skb->ip_summed == CHECKSUM_UNNECESSARY ||
+	    skb->ip_summed == CHECKSUM_PARTIAL)
+		*csum_status = XDP_CSUM_VERIFIED;
+	else
+		*csum_status = XDP_CSUM_NONE;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1725,6 +1747,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_csum			= veth_xdp_rx_csum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.47.0


