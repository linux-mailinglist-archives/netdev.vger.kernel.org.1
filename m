Return-Path: <netdev+bounces-282113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKLXHQk48Wm/egEAu9opvQ
	(envelope-from <netdev+bounces-282113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED448CB52
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C9530065D5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9E39D6EC;
	Tue, 28 Apr 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbVIyxpM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451E397E80
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416140; cv=none; b=TIA6EijEGtZ6BpjMOgyML18BKEueCLBqN+CXx0hvfUV/dVym8pu48ya7CL1EOEtqGVCkJbX72KbVjAgffCVNWFODGJR8tTyJToMfqpS3+4ZDuJW4XvJjljv4G4hl8o2xWn1fSlQvRi2ioh1PHRbD1AOTDVuAsOlJIzYbHRxECvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416140; c=relaxed/simple;
	bh=w8Q7fwzhxuNDsmhOs8CU1x0IUrDfpFLHCoe3mI0Gkkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cc49USMYV6vuhh28EM0EzrFNmrljsYgGle2FToFlLrB48Py0f9mNJ9MoT5o5Qg2CFkzJKpObOOxTb8ejhCQxUEjOttjCik5fNONWutlRzIYtyl4uFkXEiW2eyGcmw9C5mIfeaouXaVJD6F7LJeQsdmC2LBdLE914zoMyam7RcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbVIyxpM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986e538decso122604787b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416138; x=1778020938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf9C9Vs78X6Tori5C+6AMAUG6Jc3jDAPqdDnnefTEsY=;
        b=ZbVIyxpMWHXCvIrzJgV9mWyOvTaIOnoNxuTsNhnHC1iCMZzlOc7dDg7p817Hl4FHQM
         xFjWwCuJg7TPW6uQrJ8S6INB3wj7NwfhuCwyuVaXu5tJ4x8Gt0iSiiepFaSOY9pqS1HJ
         clIsEXhAZa7t5C6o7WWyaMppBRkUYtE9JaSGxz67lMgvXOOpqPmzfQkKrgcEcCHqckVx
         oPwNbFsY5GAkerbDc7GwNF3cT8PbV3TC+bEFEa1Dp7y7PldcbLlAk5w0SEFTdfKCrHNP
         xwqHwR8t07skJuRzFtJrlVTeiLLGgnBsizsHNM0/d5pPhVgD8qr80f7VPRoKuhjybJ6D
         SI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416138; x=1778020938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf9C9Vs78X6Tori5C+6AMAUG6Jc3jDAPqdDnnefTEsY=;
        b=Rz7kl92j8B1tnDSjfex3YrIVFi1PSDA/nrI1eToxnfcn2avGTu+CMIZpQuehxD0y35
         xR3QSbYP/fzsW22cJSkNWkWaURSgSkg0PU5a/MEFQkeZhFBLqX2YoZox6wBcjSw52D9f
         yvfR7PdEa+rG6voVC8Y+vlCrS19992/eBuQB2/JBtdZlACjnUKFb/hw8LIBQWGYKe1dG
         0zXR31KLXwealhwg8bpfMgnCdsSc9C7dR4+PTmBLHDY0XgC98Yr5DgApdA2Q0tt2Em8i
         xssWDAywjf4nlP0PGT5iRCY43DMw6iCwiEvjoAKGPbSrLUuTjcCB9NKSjxb3/EChF1pR
         AOsw==
X-Gm-Message-State: AOJu0YwM3/rUt1NP6HRMIPXo6mDBE+4xgv0+LOG5raDFH/uLRUdVCs1K
	Li8ItLXkLzoTQFabbkZU8/bskrP0Jhzy5wS4U5vQ4ZGTJVvzH5LDAtIC
X-Gm-Gg: AeBDievHUq1CvDIEwByzcH+zk1L3PhFlaQUGsEAdugnJtkDz4UuvC5MrvMhAIiUBzNt
	E7ZLvMW+n+Ww8I7oIw2jf2pU2WaCZCIcLzs2fvuXASeiUdLMDNs1x2weekYcTU3YEQvYDCSyrJR
	EDMDt3eY3stVNuGwrVy1ZV7EaUrUibINyUT5DONIyxyt4/3MsfVAd3Cnxb4zgXjNEjQVWiKq0I4
	S1gR0+gLNguWBzAfe7xnIF6fyceyVxWQ244oLFXZrjPSsVRPRj4T/v/eYPb2CmY/eesG5kBlm3F
	n+8X3DRFPw3RYxcoelq2d8JuOiS4+YhHfac7BtxTlo3nWyBWQxgTsgqM43HSD1JAUrLvxeBvviw
	wuWa0WFAdV4hGDipg4K9HXH1v92S+nDXXJIXuwirB9EuQ7j6fYKdomZQbmRG4w7hZ2kp6edrhm8
	mu1AEjqEjHrf1j+hCPF6z3mZDnFnina3w=
X-Received: by 2002:a05:690c:6:b0:7b8:338d:7d78 with SMTP id 00721157ae682-7bcf579a631mr48995027b3.41.1777416137774;
        Tue, 28 Apr 2026 15:42:17 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd24b8a86dsm5096607b3.0.2026.04.28.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:02 -0700
Subject: [PATCH net-next 05/11] eth: fbnic: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-5-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 21ED448CB52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282113-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c406a3b56b37..138e522ef9b9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	fbnic_set_ethtool_ops(netdev);
 

-- 
2.52.0


