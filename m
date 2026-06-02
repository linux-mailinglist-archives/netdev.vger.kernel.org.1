Return-Path: <netdev+bounces-293948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCmnF+01HmrZhwkAu9opvQ
	(envelope-from <netdev+bounces-293948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:46:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B0626ED5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1810C3021B25
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 01:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0A1B6D1A;
	Tue,  2 Jun 2026 01:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F227442;
	Tue,  2 Jun 2026 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364769; cv=none; b=nHJHxBiFgqpte3yN3IN+zH/cypmJzQ6FgRbR9Fcnp1wrCBJXByIsE0QXBhE1taxxRCVvd23ojz+1aWG8mmll8vLUIDxNzvOMuEeIGx9jX5jDm1Po5chjb3kx9tOam/Qi2ko1VVxCYINIiCWWy0DJbWAe7v1zv7FZ7BV+P4oeEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364769; c=relaxed/simple;
	bh=a7Yz3qdl38krnr4pSkSfcrU5L/RK9rTLPoX9j9MHDsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9xIhYbKE82D39p7vYbt6EKxyZ3A0iGKw0Ryt4aWcvPNmWIxRR8T2Udqdd1HcQFJiY3QD2c6iyb4N33kHMTLoVABKYUFdHzkCgUwOz4yAHhVQhouLwmnetCOiDcGJzVPcjFww+4/4IopIHtt8HWKCeLYgIv79nYC891J5+dn7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgAnO568NR5qcGcgAA--.15328S2;
	Tue, 02 Jun 2026 09:45:34 +0800 (CST)
From: lizhi2@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	sashiko-bot@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net v3] dt-bindings: ethernet: eswin: fix hsp-sp-csr backward compatibility
Date: Tue,  2 Jun 2026 09:45:28 +0800
Message-ID: <20260602014528.2076-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnO568NR5qcGcgAA--.15328S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15Xr48Zr43JF17XFy7KFg_yoW8CrWkpa
	1kGrykJ3WfZr12q397t3W0kF1fXanrCr4YkFykAa4Igwn8ua4YqrySgr15W3W5ArWkuFW5
	WFW3Ca1Fy3yqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[eswincomputing.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.763];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url,eswincomputing.com:mid,eswincomputing.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: B99B0626ED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhi Li <lizhi2@eswincomputing.com>

Commit c36069c6f46c ("dt-bindings: ethernet: eswin: add optional TXD and
RXD delay register offsets") added two optional cells to eswin,hsp-sp-csr
but omitted minItems: 4.

As a result, dt-schema implicitly required all 6 cells, which broke
backward compatibility with existing 4-cell device trees.

Add minItems: 4 to preserve backward compatibility.

Fixes: c36069c6f46c ("dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260519022334.35742C2BCB7@smtp.kernel.org/
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
Changes in v3:
  - Fix commit reference format reported by checkpatch.pl.
  - No functional change.
  - Link to v2:
    https://lore.kernel.org/lkml/20260601032852.961-1-lizhi2@eswincomputing.com/
---
 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
index b66ae6300faf..65882ff79d8d 100644
--- a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
+++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
@@ -84,7 +84,8 @@ properties:
       This reference is provided for background information only.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - items:
+      - minItems: 4
+        items:
           - description: Phandle to HSP(High-Speed Peripheral) device
           - description: Offset of phy control register for internal
                          or external clock selection
-- 
2.25.1


