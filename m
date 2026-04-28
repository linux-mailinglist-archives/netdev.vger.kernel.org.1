Return-Path: <netdev+bounces-282111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CADiKSk48Wm/egEAu9opvQ
	(envelope-from <netdev+bounces-282111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A94D48CB9C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44619306F18E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED33921E4;
	Tue, 28 Apr 2026 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9zpQ80s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449738B147
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416137; cv=none; b=rcV9v8uwcowI2yYgSOk1TDlkCJ88y4KqmlVXIU9vbRn+p1fpd9hSL6vmmbwc01dWpkUsNqKtBVJbydEToDd2gsjrWy8bVgmmkY9QQEJwrkqG+XPxJyDAlWUBqeox8qTzbHh3FHyI2qS26a3RYGR49qJ2WXtSxDS476KNARQ3LQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416137; c=relaxed/simple;
	bh=vzUUg5dUyzpvG2rKRSov0XZCUJEJWBan5Kd7XHmSVMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0tZr8iLae123pSSHWOF3CefwHpyQ4KbEc83KSkbxguRc+CiG+PKz68n4+0c48MO+0QyWxE7oNGMn62UkdDAWtyCniPrxkw08X4Kf3V7DDw6A0Y7CtWL3IwJumHSdymvoYnZ3p3IuhetOue6ylmI+PEFWjCKPRzRrABTl+C2OPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9zpQ80s; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ee5037d44so5603097b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416134; x=1778020934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=i9zpQ80se0Jlxr9Ek7vx74wnKI3t49CkgH9GRtaRn61bW/xP4d0r3b8BP0dtNHh9UJ
         0t1ZLXuzCeY/o/6tIKtYh6BJfydOT9oHLHeJMhTkERl14A7yZ1oiRKbzUtdlFAYY6oD2
         7CGfmY9EP+PxdfnX4SBNfc2EmprinvWNN7sZzWKAg7EeDGI2nlMoLhKLH2K9XxweuLSo
         O0zusU2GY+Xh+xDyR3qdLwA/MFuYGT6OLH+P6QcS7XVfVIdiqjteEYX6HpDAX+7nBAgC
         2GLsscizSa53j1jAZ9GcVwvOdAR9AGW2sBQgkoUUdeoLHjEgOeXidFuSW88JOxZir5NF
         i3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416134; x=1778020934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=AzyB++aZY+1+dd+PxtpEwYtXv7Zih05kBGxxBEOk5EX4+rkmGBYcEkrHAS30qZDmvT
         4i71tXBPD39SMy4Ji0bKyzyvY3TqVZnOJaMU63GBX/umvca+OnZVjEgujsNKiSb1d0Eo
         d4rm6tXmxAxAVsAYswQwhIHwGOx5gEa8L9FmB2gw4sfxl0+6bLJyq/gyr0UJekTsfMC+
         MI7cbdnoA2Oup2IzldvIjMSbOEeq0VBS3mI98fSYN7XcPT/oN4dB3GHRJ9LST8bZgoGl
         1puA/EMifamN8LaNgE3l6s+OlN7KB6vGI+kD0LgszzTlMDGBpJtSmKxJJDlGYqA2WRMN
         ngvg==
X-Gm-Message-State: AOJu0YwBiD+w7d1hoLTuJAYeOBYcpMbEv9MU9vKpWOyiCgNbXVQ7z0a5
	bOjLw3ZCJPGw2FuO+7d2/K+eQpmiRCt+dPLwvW4dTmf1XMaxIjYh9Bdv
X-Gm-Gg: AeBDiettAogwLVHZXvKd9e1ApY/SkE895Hg2mqrZzqcIpkJ1mCXRvxnpnVtfDrJ5JzH
	yrG5CCVoGiRcZwsJEQ7wv4NhLE61Y34UAEz/M8Jg6FGDYQq+LOjQemY2+ZI7Qd1r7N94vE3VHtO
	aSGnOKJY1Hv6VyiKD8TM3D5mQdCgOa/Qowvr8BEdpa8rXj+qaUtyCCY5XkTh7XP3XIHeZvG6y4Z
	PUT1xfUNOBTUaVEHyHIeXEyiSgBY3EgLbfOTIveh22SoLyhdZaKV00traPzhI7fo0zHWuhrZdWI
	E0+O3QxWMDh4aZOQGh+VsQ0BN3Z3tyR02Ex9jMqYncW/narqXmdmjKq91QIU/p4C3SFbFfDSmPt
	k/by/wllnwFQCA+g+2HHwXVY2W6vUQHRkvnpTSTY3/704Yv/ZEB5O377aFCeuoVHCeeTIk6hQWS
	AoMv4UDwyxuhXRCWHq+I040zRyFgjhNSSm
X-Received: by 2002:a05:690c:6d84:b0:7b3:b0a6:2c6b with SMTP id 00721157ae682-7bd241aec69mr6798867b3.20.1777416134516;
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:19::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd252ca6b9sm4764757b3.19.2026.04.28.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:00 -0700
Subject: [PATCH net-next 03/11] gve: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-3-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: 5A94D48CB9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282111-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..dd2b8f087163 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_wq;
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
-		dev->netmem_tx = true;
+		dev->netmem_tx = NETMEM_TX_DMA;
 
 	err = register_netdev(dev);
 	if (err)

-- 
2.52.0


