Return-Path: <netdev+bounces-148599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71F9E28C2
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50213168604
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0311F9EAB;
	Tue,  3 Dec 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qTKwebU5"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361E1EF0B0;
	Tue,  3 Dec 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245804; cv=none; b=WHXIXKHUxJzpFIxovb1TMpo8jDMYmqgs8nWY/sIolyEicV7jiaz6nW2Wm1YK1ScD6VvDfA1zoT5EWqqX+VxkskUXzRCNWf4ogCG1j40mAiyMwVHc6Da+CWDoNt0nPZFd/3AYY0sMghJTX47Wnr1+Dq23LiVXfhlRgXK1pJLo5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245804; c=relaxed/simple;
	bh=rwEHrrXueGZMJiVETxJoeHOIYYHseKE4baJD4wTStts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fjVCfZUNXkFwm0uwP087gCtHpoe5uhHdy243roNFVSDkfH0P9qxr9kLQY25VjkINZD1d5eAU2dL/jfocYcsPo78fCWxWr2F/EoVZ2nlPSdKx+wNFHPMcr7a4UPTQYSEgnlfHHqa3hJCIndjUR3EJhOE3jhV7cJVZqz/gAY+55/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qTKwebU5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733245799;
	bh=rwEHrrXueGZMJiVETxJoeHOIYYHseKE4baJD4wTStts=;
	h=From:Date:Subject:To:Cc:From;
	b=qTKwebU54UNDqPL8vrh1qxJ+nT6yt8ZcOfwWgZ0zRejXNiK6Qt4pvawdd97nn/g+f
	 A98KoeMUA0KjHDn7daHffa5k6HkPlj53LFBIcaL0Lizt9s9LjWxMHnZhLS7smYEY44
	 zROXqksRxf1prDnRjT4PvGTVEQ3YH06vak/Ot+Ow=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 03 Dec 2024 18:09:55 +0100
Subject: [PATCH net v2] ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV
 from kvm_arch_ptp_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-kvm_ptp-eopnotsuppp-v2-1-d1d060f27aa6@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGI7T2cC/32NUQrCMBBEryL7bSRZCq1+eQ8Rqc3WBDFZsmlUS
 u9uyAH8fDPMmxWEkieB026FRMWLj6EC7ncwuTE8SHlbGVBjZwz26lleN86sKHKIWRZmVlZr7Ae
 LeNcG6pITzf7TrBcIlOFaQ+clx/RtT8W06q+0GGWUnUfqBkvHHqfzm7yITG5xhybdtu0HAPcBf
 8AAAAA=
X-Change-ID: 20241127-kvm_ptp-eopnotsuppp-d00278d22b01
To: Richard Cochran <richardcochran@gmail.com>, 
 Jon Hunter <jonathanh@nvidia.com>, Marc Zyngier <maz@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733245799; l=1737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rwEHrrXueGZMJiVETxJoeHOIYYHseKE4baJD4wTStts=;
 b=5bedkw5e3KI7XfnLhXwxDPx+WP47G6SMv1QXPAIjDxl8r6Po6WhJUVaL9GzBMThZ8yET9iGKT
 i502KuT3DSaBlUA5QkVQ1mpNAlhs46Y8txVEACHhJ8XqtPteQHfnXdC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The caller, ptp_kvm_init(), emits a warning if kvm_arch_ptp_init() exits
with any error which is not EOPNOTSUPP:

	"fail to initialize ptp_kvm"

Replace ENODEV with EOPNOTSUPP to avoid this spurious warning,
aligning with the ARM implementation.

Fixes: a86ed2cfa13c ("ptp: Don't print an error if ptp_kvm is not supported")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Reword commit message slightly
- Retarget for net tree
- Add Fixes: tag
- Link to v1: https://lore.kernel.org/r/20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net
---
 drivers/ptp/ptp_kvm_x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 617c8d6706d3d00f7167fbf7e5b624ced29a206d..6cea4fe39bcfe46ba3b54b0815d3a3d034d415ea 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -26,7 +26,7 @@ int kvm_arch_ptp_init(void)
 	long ret;
 
 	if (!kvm_para_available())
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		p = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -46,14 +46,14 @@ int kvm_arch_ptp_init(void)
 
 	clock_pair_gpa = slow_virt_to_phys(clock_pair);
 	if (!pvclock_get_pvti_cpu0_va()) {
-		ret = -ENODEV;
+		ret = -EOPNOTSUPP;
 		goto err;
 	}
 
 	ret = kvm_hypercall2(KVM_HC_CLOCK_PAIRING, clock_pair_gpa,
 			     KVM_CLOCK_PAIRING_WALLCLOCK);
 	if (ret == -KVM_ENOSYS) {
-		ret = -ENODEV;
+		ret = -EOPNOTSUPP;
 		goto err;
 	}
 

---
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241127-kvm_ptp-eopnotsuppp-d00278d22b01

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


