Return-Path: <netdev+bounces-289286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLlCBXUFDGq+TwUAu9opvQ
	(envelope-from <netdev+bounces-289286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:38:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECAE578351
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0ADA3038F4E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091F382F0A;
	Tue, 19 May 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="JhWK8ac0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580D37CD35
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172131; cv=none; b=rW45nmsALQjZCwX0IwlpErqlVQ2EEB76bA7lCCzC9VPCQeynHGJh9TZZkFrdRD/HcUtIJb49JlUY2ZoltmkSWVNhish3uZi1nhltZQKKemDQay/sKMOe+ty9QPnw3OrszzG7CAwyCoh2H/wB/0rDU6Te5VFv6TPYjpXsawHqfw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172131; c=relaxed/simple;
	bh=H6RNv3g1Ds2kKIb9mbKPwle8pMhHto8h2eiocv6qV68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCBKOEaX4AEP6G/pPIUlIIjDOn1NOazc5SYKnSRG3s2xMlnD+K5lnb/iyopEQuIKxEkKuOS8XJO0brxcYdg1kIOrUAlj6QkNebPGemHpWM52LBEJ5h4tbpmn7xZDbiLSWXD3TPWSXnXL7eRP+etpdNCJZSoXJ86pCRzJ0TaZOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=JhWK8ac0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83d31ac4017so1391153b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779172130; x=1779776930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zUEbH0RzskapC2a5NR15SwMDD1KBLfzEqEE74hnw70=;
        b=JhWK8ac0Cpa6D1/fLMmJcIEk7hAANA+AMuFfPkT7pWPDCLxCJ6sWm3Vs1bExv5lTc/
         Gi4qARbwwI//nPz5ysZvxIoASaSnlkaGiZEerxy6/w+NYZvHlz+1muE1QNPHWtKu3AWk
         V+WCF2YKNh7lfpFeMJzTcSUQI6JPCvDOm/zUbwGexjPmemEb/LwBgeKkZcAy6I9/2mhV
         /jXdfOpr0b9ohCodE2n2jU6/5lzG4XPCQdoQKjti5owMGgjGh09kDsWp1MZtB0wfj4yx
         cwJFuuZlRe8YzPQOVp2ug6wD8N3MR4HnAWVzxhKFkdfyyOLOoblOpf8VSf9UnIPl1XEM
         6sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779172130; x=1779776930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zUEbH0RzskapC2a5NR15SwMDD1KBLfzEqEE74hnw70=;
        b=EN7CB+5nJsXmloflKBpn+hWlrATdhu2dw66Sf/EP72TnBEnIQ+d2TV33inkYjyjjca
         bxhzgU+58RRNwZ7yZlrEknyARMh3E+y49Iu+0FOCZO8Cr+HOPAgsEHHU+oX169MJ+tyR
         lCD/sysekJ4mrShCsSwMdUYUa6wrdE8u6DXjBQseL+hG5c6seEq7Djwv1d9HO/IdxCJ/
         Xb9jcxhgJEk1Sz82jLFu4sF3SApQ3PnqTbAD3aqh3uS+OBlAEjSeXnKlbCO1PjevqIQ+
         o5QgmRx92Jjmpwrflx46sVFx0qmNRTPr2ld4Uwk9jEpJtmeJGNb3kcj2mEU0yG1LrQfl
         dE1w==
X-Forwarded-Encrypted: i=1; AFNElJ/BuAOw/v1fcsxzDpKf6D6hLg+tgxRICfT1A+tdtA2jTLlPS3WtnIGajqE0RIs2UQf/XI9JIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtseWo+PszZnQctVJIEvvWEyaN04kQcomnGYn5XeDVc5iQi9R
	Zjv6XF9bumVlFfyZ/d3T8/7N7VOd8FnCWQRYr967R1Ftsq3KAQHh8LJjLrwSMo1YBM8G34VEuFu
	MtLdLMDA=
X-Gm-Gg: Acq92OH2k+XQpwUDb/0O26hqgTQpoA/aulRXKZf+74cq26ER35azb3UYD2wbsdyYN3R
	MmrqVc4sdVXG4dFoj25mVzTj10BgydbNkkU4/hyuVoA8WDfJvyswB+dfPvweVgizJuVBX4Mib6u
	4ZzI+5E3joyTEtjIEBvnPOYximSbVuJ3/0dVYEc7+zx3V6f3eic+tZ/DaJClfYpSv3dNIOE7aWO
	E3mRLRT2QF4o3WqoR2K6Csd7h82fmylLxa2vzb8Xh4xsBjYWKHlS4ngRB62kXzHhl5lcIMxvvna
	2YKD/zHbR0eCEM3RX4Cfw2JUYQzT6Kuqm9+p2vB0qCO84o/Guzzk/jWb6+lbRM1Z0BK7lIDJLWn
	/KTZz+TdlfWGDBIfd9bwmL1Nd/JVOQJPP7p4X19WTLMrl36EDku/JoJ+v7vJ/U7fBO+OMDtBgLR
	YJO6cUKkNoXUzaYkM3hth96QKr0HcLhrX+N5T8Yd0/bXpNPKD6ZlU6EbfCBnUVQWFTJRDfQR0rX
	OwlKygWlCROdAhgmfH9ei64rm4QOh306hwww3arhDPh4/o2T4j4Ij37C/kV5qhIUynM
X-Received: by 2002:a05:6a00:3e22:b0:83e:f208:b113 with SMTP id d2e1a72fcca58-83f33c541cdmr17707506b3a.7.1779172129825;
        Mon, 18 May 2026 23:28:49 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f1966471dsm17045725b3a.6.2026.05.18.23.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:28:49 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: loic.poulain@oss.qualcomm.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Tue, 19 May 2026 11:57:39 +0530
Message-ID: <20260519062815.55545-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289286-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email,cse.iitm.ac.in:mid]
X-Rspamd-Queue-Id: 9ECAE578351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
v1->v2:
- Moved the ipc_protocol_deinit() call to a point after the tasklets and
  workers are cleaned up to avoid a possible Use after free, as
  suggested by Jakub Kicinski.

Link to v1 patch: https://lore.kernel.org/all/20260508092141.82495-1-nihaal@cse.iitm.ac.in/

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1b7bc7d63a2e..4405c8531888 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1425,6 +1425,8 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *pcie, unsigned int device_id,
 protocol_init_fail:
 	cancel_work_sync(&ipc_imem->run_state_worker);
 	ipc_task_deinit(ipc_imem->ipc_task);
+	if (ipc_imem->ipc_protocol)
+		ipc_protocol_deinit(ipc_imem->ipc_protocol);
 ipc_task_init_fail:
 	kfree(ipc_imem->ipc_task);
 ipc_task_fail:
-- 
2.43.0


