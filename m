Return-Path: <netdev+bounces-284336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JuWEaLM+WlHEQMAu9opvQ
	(envelope-from <netdev+bounces-284336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D684CBF4F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C801B30A5F07
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887F40F8C3;
	Tue,  5 May 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfz4V1a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB15407583
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977751; cv=none; b=k7D1vMlBZcMt9suGKEF7PDaaXe++Zcc3LBCqx+VcyGdGQKw0mKhQJnNbIjtE45qKjEdlwu3wG2DXJvNKBhJcxfbbFJSZerMG9z4Qhf+5+FF5+fovXiwGHJJfi7tgCLIpW63aAHMWWlJ/kerGcRD3t67m93a8605xQzA3ro45K7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977751; c=relaxed/simple;
	bh=YhZwMUTRyWyfrMMn0VOaBy9tmw60nL85T+/PZnWnELM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxUClDGt/yHJWc3PlMZsekQOiNzcUMcAk7knIYBsrAXH6ZeNjxyX0OgEhRYo7WXU68y6dCTuUOAE1wsCW5imeiVvUja5RSDP8/pJci427Ewj4Y+KolhygJnqK6dMcnpPo3MnBivLM2k84Jl4CKZtUmCSzJyXPUWet6U7CMHQ30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfz4V1a; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd9061b1aso4656258a34.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977748; x=1778582548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEctwiaijkDd1U8s8JRDXgY/saaQUbwV6xXhN/X+GFE=;
        b=mNfz4V1abHYFWnV3lRnsHz55KiRyL7IlkoKrZnGGT2T5QHNFgTsahIJgGuBoMyENE0
         WU84FymeAHfmam7YZz3L6o7bHR2hK1f0ADBBfwMVu93No8Ql/RkBCAXU2NlmFHhoOIBK
         U7SibIomCy0ImJjbuyRnS2jIY48cFqooSYiwA1iJwMs73KdAqlgPwQFoOU3kN1043DBb
         U51Bs49tNzThQpZE0N3r2oAkersDV2jywW/IYENxE+erJd6VnOeOj5H76RKzLQ8RraqJ
         s6aM4aak5I/LVxINi4EEBaYkZtft8nOTyRp0DcGh1kBtpkWHFrwvY2LmM3i0QbByhXL/
         dU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977748; x=1778582548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bEctwiaijkDd1U8s8JRDXgY/saaQUbwV6xXhN/X+GFE=;
        b=EUwBmqM/E3tdaAYOVsgVPIzpul6fjd16qM/aP1pXLwM5K7CfCPBZ4l2X3h5KzhkUAr
         P2dEYz4nFZmNlbzJBLjdGcRNwwxqp666Zaw7DilSbdzl4XjZH4Lyh698MfMyuOvQ9Pti
         70+fOOKbYo5V5jSz/hTnDbaRtCXwJFSofY/C5KaSFBGdvM4q85MR4DgSt1UXKflWtsII
         kYVii+a8RdrBAKDk/+8zC/NPsyOxPfY7mfBH1Yxw8YRvxNTCu5J+x+fn3347mfYPAksK
         GUVtjFfTVRGoVdEzyEo5Vz7TC2fmzD9wynHWjPxdhASKiOqCArtUpFO0Qm2F4sFn/6U7
         +d4w==
X-Gm-Message-State: AOJu0YyxKaQ6xi2rBdlXnZHHSYUcYIAdZsL/fiHSZiwsWQqHW3sKdHdj
	P2gBrokqcQt4SQ0xY+goh+aJ01ja7ezIaI3F93z8A1mM+xMe4WqJkP/Hdgr6AQ==
X-Gm-Gg: AeBDiesr0eTObfXMpOJyb6nxFQq8fDRf2vxkmi8eWiihsBTA4kVTTloqAjfbvKqPtJd
	y5LG8aeopJsRDub+zXfslj9KTQ392Oiw0WS9vjhO0Vy8vEO1iW3255oDxBo17ID+SznRQQQc2/Y
	qQ2bYStPOm9lVuv/enI0o8wPzh3meIYi4EIMHyrcy3l6CYSA4ARk8ftjx6ftp4eHPaiD1zJQ4Kf
	3RR8h8+vxYOtAW/cj0PCQE0OnsTZI01AU2L/aT5VnBZJmjpmV8B1W2Cbv8rtDzILIAEHRwzrxNd
	AUWsAF/fat5QFPzyYFDEa+8VHv//LKBng49Mg1oob7UbmqFcjWO7tAHtAfhzKO7aA6dpao5xM4V
	bXdHdDXw8Dkf4r214bLLVfZ5IrXymkqF5yi49XGHH9Ha18zi7ykv/rwUg4Dfta+qotobz7rbnq1
	rRv4ZcHOR8lQDG7Szbi7PUR6I9wvx2CoumWFxSrteRGaK0Ti2BKdriyOTyVeM2R/TdUG4QWrjGv
	w==
X-Received: by 2002:a05:6830:67c5:b0:7de:a2cc:9da2 with SMTP id 46e09a7af769-7dee13a4e13mr7989212a34.15.1777977748655;
        Tue, 05 May 2026 03:42:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac26330sm9525858a34.13.2026.05.05.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:42:27 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 05 May 2026 03:42:23 -0700
Subject: [PATCH net 1/3] netdevsim: psp: only call nsim_psp_uninit() on PFs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-psd-rcu-v1-1-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: A4D684CBF4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

VFs go through nsim_init_netdevsim_vf() which never calls
nsim_psp_init(), so ns->psp.dev stays NULL. nsim_psp_uninit() guards
with !IS_ERR(ns->psp.dev), so destroying a VF reaches
psp_dev_unregister(NULL) and dereferences NULL on the first
mutex_lock(&psd->lock):

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  RIP: 0010:mutex_lock+0x1c/0x30
  Call Trace:
   psp_dev_unregister+0x2a/0x1a0
   nsim_psp_uninit+0x1f/0x40 [netdevsim]
   nsim_destroy+0x61/0x1e0 [netdevsim]
   __nsim_dev_port_del+0x47/0x90 [netdevsim]
   nsim_drv_configure_vfs+0xc9/0x130 [netdevsim]
   nsim_bus_dev_numvfs_store+0x79/0xb0 [netdevsim]

Gate nsim_psp_uninit() on nsim_dev_port_is_pf(), matching the pattern
already used for nsim_exit_netdevsim() and the bpf/ipsec/macsec/queue
teardowns.

Reproducer:
  modprobe netdevsim
  echo "10 1" > /sys/bus/netdevsim/new_device
  echo 1 > /sys/bus/netdevsim/devices/netdevsim10/sriov_numvfs
  devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
  echo 0 > /sys/bus/netdevsim/devices/netdevsim10/sriov_numvfs

Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a05af192caf3..a750768912b5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1182,7 +1182,8 @@ void nsim_destroy(struct netdevsim *ns)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
 
-	nsim_psp_uninit(ns);
+	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
+		nsim_psp_uninit(ns);
 
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);

-- 
2.52.0


