Return-Path: <netdev+bounces-304713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6fqRKPEkSWrlygAAu9opvQ
	(envelope-from <netdev+bounces-304713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 17:21:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E806C707D3B
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 17:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304713-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304713-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B19C301227B
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157E39182D;
	Sat,  4 Jul 2026 15:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014A3939A3;
	Sat,  4 Jul 2026 15:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178474; cv=none; b=QTJPRwM3IfF9rI60ZnPXCZkzhuZbvAikJM6EE8gcgAEvEGXQtsWLCyWLiaPzvrVQ7dQ0GgSStTFunNk8y5lvNiRy4iz3z9doMsQ5/wzMckkdJ31vQhf0rwhz0mW79hNN7rKG1lsf5sLbfsixpEpF7vcKdM2mzH/32xLF1fT/yNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178474; c=relaxed/simple;
	bh=jt6H9AP/LKpkGsxB6PFB159a8pPwiWIyDbsL8WDzj8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JntXBGXbkCKnDPj31ic855S6+4rBy5ZT2DBaeaSRFdCyr3IuqaMwOaTL8brk2g2a9brY2cG/n2uQq/z+hQzb8++cQFmWEtGf8sC9RMRnElJU4vn/Spii5YT7Po8NwPy8sugBCtrnsDDYnLbMGliFGtgNMpTTEBi6FZFxO04NoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABX7RDXJElqnJfbFg--.64851S2;
	Sat, 04 Jul 2026 23:20:56 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: alacritech: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:20:53 +0800
Message-ID: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7RDXJElqnJfbFg--.64851S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUGF1fCF1rCF47Cr18Grg_yoWkAFgEkr
	yfXF4Sga1UCryYkw47KrWrZ34I9w1xXF93JFykKrWYqw1xXr13JFWkGr93Aw1DCr18Jasx
	JwnxuF1fu347tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1go2U
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:LinoSanfilippo@gmx.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pengpeng@iscas.ac.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E806C707D3B

The driver has a match table for the pci bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/alacritech/slicoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index c1949ca060ca..14b74c09233e 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -34,6 +34,7 @@ static const struct pci_device_id slic_id_tbl[] = {
 		     PCI_DEVICE_ID_ALACRITECH_OASIS) },
 	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci, slic_id_tbl);
 
 static const char slic_stats_strings[][ETH_GSTRING_LEN] = {
 	"rx_packets",
-- 
2.53.0


