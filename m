Return-Path: <netdev+bounces-291798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HOlNzfGFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD85D9672
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2C6330C92AD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA43AF67F;
	Tue, 26 May 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR53INpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F3AEB35;
	Tue, 26 May 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811334; cv=none; b=Dt1U2jCGfYC0Iatam+nHFSWwn0fwHLJWQEDlUsidIvfhyfILs2hfINoAX/9/zI8dENTEihTbJpLIeV+67zZ1zgA4m0eryGUvvMGiYzOiQwa0PcdBe6bqNN32vlMqG7K5wvORKsu+vCRI4B/e5b5kephWW/3nMYarXZczZdKAqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811334; c=relaxed/simple;
	bh=ARXfsjvpbWr3CjKrwxt9Lji4HOVeeGtUFplvuYKqyWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3sqgQPfYVfERr2xBw7c/WyBhJhsUjebfdknQ/j1wmzT9dWXSOSFffwMeYiWuXFIu0G89OKbwWhBZs7XD953dCbZAF6nlzGGpwNuxKLYRjZVKjRpz0XaF7WGuQJk+puMc0QkU2dUkPFt4ouciEZCiHQfe1S6dkMbVHXVMq8viJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR53INpP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422F1F00A3A;
	Tue, 26 May 2026 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811333;
	bh=Eqi9ELBAbYp2SpC0lQWFiyGLnq7pA7MCAdzWH1HoE7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iR53INpPb7jJHGBV0HhUkNKSIjOUYVNY6iDAggU470kauMnnE1U9dB43QpeHu3b4Z
	 1ClOP/eyjcs7ohUv3LQsF9g4x/T5RSFITVlcobtxh2yxiP3FaMPJntm5O/EmTBw351
	 Ix/Z2ud0qJSBNWxrBhcsv1rdH5UoyTxb+M0JwfYXwuujCmXh4Ebp1+7/sFqSoc5u0t
	 KvtGufuhDOpVNjf1ijl6pL0JTRYmi0ap/vxtr2H00XEVNSTFg0aFL8uV03508r2OhE
	 UlC3ITKdnFJCqGMgGt+8bx/si2n1MHMFHgaymHK5t5InoJ9I68571RAb77jlmPIAov
	 EsttZL0Wyoa+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/10] docs: net: fix minor issues with segmentation offloads
Date: Tue, 26 May 2026 09:01:51 -0700
Message-ID: <20260526160151.2793354-11-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291798-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 69BD85D9672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the segmentation offload documentation to match current GSO types:

- clarify csum_start for encapsulated TSO
- document TCP AccECN GSO and NETIF_F_GSO_ACCECN
- distinguish legacy UFO from UDP L4 GSO
- add ESP and fraglist GSO entries

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../networking/segmentation-offloads.rst      | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 72f69b22b28c..25a8b7eca847 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -14,10 +14,13 @@ to take advantage of segmentation offload capabilities of various NICs.
 The following technologies are described:
  * TCP Segmentation Offload - TSO
  * UDP Fragmentation Offload - UFO
+ * UDP Segmentation Offload - USO
  * IPIP, SIT, GRE, and UDP Tunnel Offloads
  * Generic Segmentation Offload - GSO
  * Generic Receive Offload - GRO
  * Partial Generic Segmentation Offload - GSO_PARTIAL
+ * ESP Segmentation Offload
+ * Fraglist Generic Segmentation Offload - GSO_FRAGLIST
  * SCTP acceleration with GSO - GSO_BY_FRAGS
 
 
@@ -38,7 +41,8 @@ In order to support TCP segmentation offload it is necessary to populate
 the network and transport header offsets of the skbuff so that the device
 drivers will be able determine the offsets of the IP or IPv6 header and the
 TCP header.  In addition as CHECKSUM_PARTIAL is required csum_start should
-also point to the TCP header of the packet.
+also point to the TCP header of the packet, or to the inner transport header
+for encapsulated TSO.
 
 For IPv4 segmentation we support one of two types in terms of the IP ID.
 The default behavior is to increment the IP ID with every segment.  If the
@@ -57,6 +61,10 @@ DF bit is not set on the outer header, in which case the device driver must
 guarantee that the IP ID field is incremented in the outer header with every
 segment.
 
+SKB_GSO_TCP_ACCECN is a modifier used with TCP segmentation offload for
+AccECN packets where the CWR bit must not be cleared during segmentation.
+Devices advertise support for this using NETIF_F_GSO_ACCECN.
+
 
 UDP Fragmentation Offload
 =========================
@@ -71,6 +79,16 @@ still receive them from tuntap and similar devices. Offload of UDP-based
 tunnel protocols is still supported.
 
 
+UDP Segmentation Offload
+========================
+
+UDP segmentation offload allows a device to segment a large UDP packet into
+multiple UDP datagrams.  Unlike UFO, these are not IP fragments.  The payload
+size of each datagram is specified in skb_shinfo()->gso_size and the GSO type
+is SKB_GSO_UDP_L4.  Devices advertise support for this using
+NETIF_F_GSO_UDP_L4.
+
+
 IPIP, SIT, GRE, UDP Tunnel, and Remote Checksum Offloads
 ========================================================
 
@@ -154,6 +172,23 @@ that the IPv4 ID field is incremented in the case that a given header does
 not have the DF bit set.
 
 
+ESP Segmentation Offload
+========================
+
+ESP segmentation offload uses SKB_GSO_ESP to mark packets that require
+IPsec ESP segmentation.  This type is set by the XFRM output path for GSO
+packets handled by ESP hardware offload.
+
+
+Fraglist Generic Segmentation Offload
+=====================================
+
+Fraglist GSO uses SKB_GSO_FRAGLIST to mark packets whose segments are
+already arranged as a list of skbs.  The segmentation path splits the skb
+based on that list rather than by creating segments of skb_shinfo()->gso_size
+bytes from the linear and page-fragment data.
+
+
 SCTP acceleration with GSO
 ===========================
 
-- 
2.54.0


