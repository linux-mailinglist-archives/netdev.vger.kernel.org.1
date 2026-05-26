Return-Path: <netdev+bounces-291795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDw2I37HFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981F65D9812
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAA4D30504AC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5E3AF672;
	Tue, 26 May 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7rMHvmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5E3AEF3F;
	Tue, 26 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811332; cv=none; b=a0kbju2SnKcQVfnBwputRaSZjTej4SgxYHOZ8CSNFFSkcsiQn6sd2rIXuUOVv5iAKgxVpjfOPcvAkwhIwZSqXVF8jn8f7Zqb0d1n+AMcQhimP/pjPquOHUrvQUnThkulDwhzUhyfGDaypi4P0a0BLNFWFiHms0PXCCTfIa+V1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811332; c=relaxed/simple;
	bh=+6JonLfnR49JoVbven1hZlBSlCZtIJ2DwjmUTj9B1a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB5AuuwyBua2QQMxyC1cglRQUh+Nc5rv/Sxzj1lP6/TWMrYExPaES3jwGwrqQYXhOqjd/rlaZHq7b1UsqkDl5oSskdmmwVP+M+v9li03NLwAhxB0JxJCn73RqmGlIn0iy5QjX+tm4isauJbtoCk2Oua098wT91r86nzQKV4mrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7rMHvmK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7924E1F00ADE;
	Tue, 26 May 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811331;
	bh=bEANdEjU06ApuaPqpYPEr2/kktelC2YCUEohwHJFl1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7rMHvmKQjquledVR6Co8gkhBijRB+IwjDoH2kp9Bvl15MMcqY1+ucp/yTd+oGa+q
	 a3jHCk1wzGuH+9DP2taFwjwU0b4Y88uz6Debbq0TogOBT7P38lOOh+NQDlRSJlwMUc
	 /cgXtceeyU3sFsUqQZDeli5mIcgvDNf3Tf2VMQXPFh6Jp9qL+yfv68bkBHq89MbgRo
	 0TlYtsbmorhwy6JWAyskdqUXWW1MTbQl4h4DnVNlKVCCNbtlGd+eoTXhAV+o5ko3Uk
	 EkEe8lJBr6AH+l6Xr1+c2g7gyCHrshM9agw0hVvwhHv7ADOURtfYDecODVpMylDRQH
	 1PYSUjQxBeWbg==
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
Subject: [PATCH net-next 07/10] docs: net: fix minor issues with checksum offloads
Date: Tue, 26 May 2026 09:01:48 -0700
Message-ID: <20260526160151.2793354-8-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291795-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ietf.org:url]
X-Rspamd-Queue-Id: 981F65D9812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the checksum offload documentation to match current code:

- SCTP CRC32c offload requires NETIF_F_SCTP_CRC, not ordinary IP
  checksum offload
- NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM are restricted legacy
  features; new devices should use NETIF_F_HW_CSUM
- GRE LCO is handled by the shared gre_build_header() helper used by
  both IPv4 and IPv6 GRE
- VXLAN_F_REMCSUM_TX is a VXLAN configuration flag, not a field of
  struct vxlan_rdst

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../networking/checksum-offloads.rst          | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/Documentation/networking/checksum-offloads.rst b/Documentation/networking/checksum-offloads.rst
index 69b23cf6879e..907aed9f3a3b 100644
--- a/Documentation/networking/checksum-offloads.rst
+++ b/Documentation/networking/checksum-offloads.rst
@@ -45,9 +45,11 @@ encapsulation is used, the packet may have multiple checksum fields in
 different header layers, and the rest will have to be handled by another
 mechanism such as LCO or RCO.
 
-CRC32c can also be offloaded using this interface, by means of filling
-skb->csum_start and skb->csum_offset as described above, and setting
-skb->csum_not_inet: see skbuff.h comment (section 'D') for more details.
+SCTP CRC32c can also be offloaded using this interface, by means of filling
+skb->csum_start and skb->csum_offset as described above, setting
+skb->csum_not_inet, and advertising NETIF_F_SCTP_CRC. Drivers must not treat
+ordinary IP checksum offload as SCTP CRC32c support. See the skbuff.h comment
+(section 'D') for more details.
 
 No offloading of the IP header checksum is performed; it is always done in
 software.  This is OK because when we build the IP header, we obviously have it
@@ -59,14 +61,12 @@ recomputed for each resulting segment.  See the skbuff.h comment (section 'E')
 for more details.
 
 A driver declares its offload capabilities in netdev->hw_features; see
-Documentation/networking/netdev-features.rst for more.  Note that a device
-which only advertises NETIF_F_IP[V6]_CSUM must still obey the csum_start and
-csum_offset given in the SKB; if it tries to deduce these itself in hardware
-(as some NICs do) the driver should check that the values in the SKB match
-those which the hardware will deduce, and if not, fall back to checksumming in
-software instead (with skb_csum_hwoffload_help() or one of the
-skb_checksum_help() / skb_crc32c_csum_help functions, as mentioned in
-include/linux/skbuff.h).
+Documentation/networking/netdev-features.rst for more. NETIF_F_IP_CSUM and
+NETIF_F_IPV6_CSUM are restricted legacy features and are being deprecated in
+favor of NETIF_F_HW_CSUM. New devices should use NETIF_F_HW_CSUM to advertise
+generic checksum offload. The skb_csum_hwoffload_help() helper can resolve
+CHECKSUM_PARTIAL according to the device's advertised checksum capabilities,
+falling back to software when needed.
 
 The stack should, for the most part, assume that checksum offload is supported
 by the underlying device.  The only place that should check is
@@ -108,11 +108,9 @@ LCO is performed by the stack when constructing an outer UDP header for an
 encapsulation such as VXLAN or GENEVE, in udp_set_csum().  Similarly for the
 IPv6 equivalents, in udp6_set_csum().
 
-It is also performed when constructing an IPv4 GRE header, in
-net/ipv4/ip_gre.c:build_header().  It is *not* currently performed when
-constructing an IPv6 GRE header; the GRE checksum is computed over the whole
-packet in net/ipv6/ip6_gre.c:ip6gre_xmit2(), but it should be possible to use
-LCO here as IPv6 GRE still uses an IP-style checksum.
+It is also performed when constructing GRE headers with the shared
+gre_build_header() helper in include/net/gre.h, which is used by both IPv4 and
+IPv6 GRE.
 
 All of the LCO implementations use a helper function lco_csum(), in
 include/linux/skbuff.h.
@@ -138,6 +136,6 @@ For this reason, it is disabled by default.
 * https://tools.ietf.org/html/draft-herbert-vxlan-rco-00
 
 In Linux, RCO is implemented individually in each encapsulation protocol, and
-most tunnel types have flags controlling its use.  For instance, VXLAN has the
-flag VXLAN_F_REMCSUM_TX (per struct vxlan_rdst) to indicate that RCO should be
-used when transmitting to a given remote destination.
+most tunnel types have flags controlling its use. For instance, VXLAN has the
+configuration flag VXLAN_F_REMCSUM_TX to indicate that RCO should be used when
+transmitting.
-- 
2.54.0


