Return-Path: <netdev+bounces-268148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZWBuP1t2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:21:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C82996CA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FBCB3023D81
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CA34EEFB;
	Mon, 16 Mar 2026 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NodKqvEJ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F393A1DB;
	Mon, 16 Mar 2026 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663563; cv=none; b=frUHl+c+xlxZjfg/dLDT+aQIskaj1uw3Oe9SCjbrEk+3bSTzOFKTdPY86Io0XWj3DX9Sr8aAX6QUOmUJChuoOMnOg4KhY1bW/ZmOwqyFa/pAOQqc/iYP4rVTw952iW3uLuUafbZTFu2xaNyIvha/ynfvAltm3ZoD3cjjzAo1+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663563; c=relaxed/simple;
	bh=+V81cM+GFTXdyBy40w4Yulv5X7DoF5rXneVOKOsiGlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=POLPLER9e6BO3+JySUw5yuBZ8e0TZbQL/CgzmBfi1YXzQ2H2dR/8dKNvtYJzVVQBFF3XMN/paWIGkOc4pEdDEd/9qGOyV9eoxGuGO/16K9iwk4i2Cuhd9okdzQA0iykJDSRijuH+lvw0PpcZgDVs88MYzv5lxJEEWIhl9DXsjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NodKqvEJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Oa7jPB1YIuKWw5WzId5M/uorq6CdolcKa3s4kiDxINA=; b=NodKqvEJm+hhydCGBmgc//T/fe
	FG1ffERPW2s41pG854JObBPEOtj0xx67Cx3rSRGc39QWt/l+Uwc+r3na97LGmVdZVXp4x7ofHK9bh
	W7l3J7YPbKFTBQ26Kp+qZJION1djCwTKcp9GE/GGMCP9xpvbIk5D0Eb4DXl1V7Zv/YsgJmR+ZMMcx
	5MUipBWKUQ9eX4TJZu1Ey8NtzhBRuUCYvFfdZ2jLI7KLMJZU0d3DLtKbboHviLhZSPc5b4hq6nVD0
	nOJJHqDEgBOaLXxFd4OxLJhXU6LmpeqFEeG50rP++RsrO/glBE2VHsFp2/y1+1Imuht4/B2PQA7Tf
	wgS6SnyQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26uj-0026mj-4w; Mon, 16 Mar 2026 12:19:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 16 Mar 2026 05:17:45 -0700
Subject: [PATCH net-next] bonding: move utsrelease.h include out of
 bonding_priv.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-bond_uts-v1-1-428696ea79d5@debian.org>
X-B4-Tracking: v=1; b=H4sIAOj0t2kC/yXMQQrCMBAF0KsMf91A2mIquYqItMlUx8VUMqkUS
 u8u6vrB22FchA2RdhR+i8miiNQ2hPQY9c5OMiKh813wfRvctGi+rdWcH4aZ8zknPgU0hFfhWbZ
 fdYFydcpbxfUvtk5PTvU74Tg+FZM/J3YAAAA=
X-Change-ID: 20260316-bond_uts-077fed8dce56
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162; i=leitao@debian.org;
 h=from:subject:message-id; bh=+V81cM+GFTXdyBy40w4Yulv5X7DoF5rXneVOKOsiGlM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt/U/oz9hZLi58u/WptrNBVs9fk3ViIgHMzvlQ
 tpvN5LXN92JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabf1PwAKCRA1o5Of/Hh3
 bccuD/9J3bxR+lq4VUtZfcHRSxG35J//GmjlddqeWnOY5kGVRlQD10ppCZwF6EdCV/MdvAMqrfE
 pYvl76XaI+wfClyJi1TR8q+WxKe+Jz/LouuMsGUCBCdvQB4eeJ30kkFDHgM44FvCAY45sqqqhvU
 JLsIL6RroxmJK2Q9iGklB0HIe+BC0ta7nrsqHdA48zt5cSG2HIOY/UIFl8gquej0OIxDRramgeI
 +CN4sd04iJrdRWew1XQ5BM9UtOE41J8NjB5r35Wv+S/AwBdrG9w0yFAwTTG8yjby5COVFsv/Pwo
 9YYOanGeTCKltxZ/WQhxytWFLSeq3WZrjkJEkutNCr39TIb4rnyt4dXfRmWi8e35c/pUefiPOSR
 ezqT+4isicNIH37kkYwmpBPsLETl8th6yTaYWCatGjYcrkDHHElJpFMxEb8FALe09+o1uGrV3jA
 kE8UmWfK+dBDaadPIcdIoRiT2qHTOrGJo4CmNBDV3eDGoGTpISD0/70SLywWTFwW+MrvTtNaxvu
 wJMcS8p82pr7Z6wJTEjSsdn+ulrffbW4Cr1fWg5y7TtI1YOCCCerFXSEfWKuiCqVP2qC6Nr6ohk
 2p6x+YqMC/nWALGbp3NrctIPEDzDOqojKI57O0HA/zCgiemi2+SdHjOJJBPj1/UPmq1jvnnEAw8
 aOsp+6dlY0umoHw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6C82996CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bonding_priv.h includes <generated/utsrelease.h> only to define
bond_version, which is used solely in bond_procfs.c. This causes every
file that includes bonding_priv.h to be recompiled whenever the kernel
version string changes (bond_main.c specifically). With
CONFIG_LOCALVERSION_AUTO=y, utsrelease.h is regenerated on every git
commit, so any git operation (revert, cherry-pick, bissect etc.)
triggers unnecessary recompilation of bond_main.

Move the include and the bond_version definition to bond_procfs.c,
which is the only consumer. This is consistent with how other drivers
use UTS_RELEASE (ixgbe, ice, i40e, ionic, nvme/target, DRM drivers,
firmware_loader, etc.), all of which include utsrelease.h directly in
the .c file that needs it rather than in a shared header.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/bonding/bond_procfs.c  | 3 +++
 drivers/net/bonding/bonding_priv.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 7edf72ec816ab..6abe8916202dc 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -6,8 +6,11 @@
 #include <net/netns/generic.h>
 #include <net/bonding.h>
 
+#include <generated/utsrelease.h>
 #include "bonding_priv.h"
 
+#define bond_version DRV_DESCRIPTION ": v" UTS_RELEASE "\n"
+
 static void *bond_info_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
diff --git a/drivers/net/bonding/bonding_priv.h b/drivers/net/bonding/bonding_priv.h
index fef6288c6944f..f9b327b6a494a 100644
--- a/drivers/net/bonding/bonding_priv.h
+++ b/drivers/net/bonding/bonding_priv.h
@@ -12,11 +12,7 @@
 
 #ifndef _BONDING_PRIV_H
 #define _BONDING_PRIV_H
-#include <generated/utsrelease.h>
-
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
-#define bond_version DRV_DESCRIPTION ": v" UTS_RELEASE "\n"
-
 #endif

---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260316-bond_uts-077fed8dce56

Best regards,
--  
Breno Leitao <leitao@debian.org>


