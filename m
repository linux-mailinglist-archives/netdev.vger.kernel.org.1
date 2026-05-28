Return-Path: <netdev+bounces-292756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF3kLpRrGGrcjggAu9opvQ
	(envelope-from <netdev+bounces-292756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5805F4E9A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83650314F48F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80823F870C;
	Thu, 28 May 2026 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngt0zBZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE72E7364
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984530; cv=none; b=KVPxwy98imhjDgxlxFljXZR6RuSqOO2B7cpioPEogi3AvG/1nryCAwRXgSxd40UfH70D3GMMP9ZCXFrAzUw/9ZuO1wx31fwx/uGGDLj6rGAlMUHnEovEFbYy91v/SMYlXMW9QofnpMvnZHeiTRtxcnnqpqXy5Yk84ud837SFcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984530; c=relaxed/simple;
	bh=ArFEvS4iIE1COp0yWeMQ913sIk1iOU6y5FWc4jgQSiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmX1rC9jUBPhOcYrDK4glMjvKLbjpg7XdL4FKqpaMVSe6i25cIMlk1wGW85BV3yRSwLsE880k12W64prvZmZcvdmjezayrR8eL8P4dr6kAwp26Ndswb1IJgrD3HNguVQimfWyL0HB7yAHNR7Tep8QpbvX88TURWOZoTzUooqnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngt0zBZV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so53290725e9.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779984527; x=1780589327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vx53jYFxFDkAaLXRXoaHF+KJ6Qv4XL53bOT7CIR8w+k=;
        b=Ngt0zBZVdrv9VisRHKAKEEYXzwa2DNKEprnFQ/4lSjytKPMaWTWAdd/81jdBsGFHIN
         fC9zY4DJLTPs4Ndv97boyWNpGKH+JpvHCRE3XTgsFFjVtiLO0HPUvLMA76TWnV08lxc3
         3w2XbN1ww4l0xZXXr/8KHN4MPdzbDyync+wc9RPixnWJ1AX5UpZXAM1BRukQYfCKLjGR
         pWkgnR5ksnby8EwqFTNiWoNWDqQmKj9inGdjIViJ7MaRL3aKK9DJxXNyMjSgGVlb+0eX
         tGsChi+BOajyjx4HemewYkfEupCGxfJ5GM01hZIWFRcX1otZTyA+EBuuadGQvwSPN0yb
         RWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984527; x=1780589327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx53jYFxFDkAaLXRXoaHF+KJ6Qv4XL53bOT7CIR8w+k=;
        b=kyi4iOOEb6dizA1ntLN9PKFNs0LYo3bJ1Yd92Fr65LRJHqGKV2Tmw5K9PvYlYk4943
         j9jc+QIWU369q2ABu2LBUyk2Q69VZuMyahMWVO36ES3uvcWgW6SnTXtUCo2+XHduWdRi
         Sb/MgMiYUwCm4ezTH1mJGjCEd5MAJNii1UcKAJPgk/MDwgS86EIIoqdXq8fuM2EprMk5
         de/eL2WJa7EAJNl5hWE1IwkyQjENWQ3912+LRoLkeWOB+9nHO6fLrp0t55fheRZxwLc1
         vhv29xepUJHKX7YI9vHkc6iynlu1XjcVqCKDPy3YWx+CMfP/93Bw9tSfeFr8OvE9eeyd
         VWqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7A23lRAdWlrKYR4B4Tv/mOlitHflvGfkm05Zra+1yg7HoqAM6jvvtJ1klt2XPzLLQQIHeuAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkskUnCREwIkSUjgyZisADKP4gwneghStAf/sSOd8TkrjwtDB4
	E3cHBm6/RrPAStm0+nBQCVoKWE1CyVVN/W0mojbLlWcjqdUCulE3Y4E=
X-Gm-Gg: Acq92OGuFvzGOOQbH1yczzmO2ZDd9ommKd/EEY6J/dWH4yvPkJcndM9yKUM5MCPW70D
	1yd0PK5GfXMaBVS6XvGx7MQcteZx/7t6f6zml8HNPFPUC4NAyb2HKRuuIB/DrapPVlGgn8x0Ye/
	OGP9Mv/K645nqF2Kmt7cUQZtARfnu1AI5z/dKx5nww3OWXXBsYdWa33awOajkw4WAy6ViOo2HHI
	/iGaOqszXngAFH5ynNGy0i3YBBdmbyHHY+cwmU+qWBmGlI4V0OKFzYp0Y8FPlLKedYQF+IdUVbh
	D/xJKBVqzmOlowRrwfv56Mn0o3/hffykbjSM/huXlB9MrlXIR8n7/74bb5YvW5A4Ao5kMbkrwoR
	q0yzFKOAZgGr1unNNtA69JjXosLOh2DOV8N33UkfnPMCRntzoGPMIHYL8SK8n9FOfnzINw1V1ZT
	TuKU2T+cri6/VaGsvA
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490519170bamr421905655e9.18.1779984527176;
        Thu, 28 May 2026 09:08:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee4491d77sm6950094f8f.4.2026.05.28.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:08:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: shaper: use kfree_rcu() in net_shaper_flush()
Date: Thu, 28 May 2026 16:08:45 +0000
Message-ID: <20260528160845.2636043-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292756-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E5805F4E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_shaper_flush() frees shaper objects with plain kfree() after
xa_erase(), but net_shaper_nl_get_doit() and net_shaper_nl_get_dumpit()
read shaper objects under rcu_read_lock() via xa_load().  This creates a
use-after-free window where an RCU reader may still hold a pointer to a
shaper object that has been freed.

The race is:

  CPU 0 (reader)                    CPU 1 (flush/unregister)
  rcu_read_lock()
  shaper = xa_load(...)             xa_lock()
  // shaper points to valid obj     __xa_erase(...)
                                    kfree(shaper)  <- frees immediately
  net_shaper_fill_one(shaper)       xa_unlock()
  // use-after-free
  rcu_read_unlock()

Other code paths in the same file already use kfree_rcu() correctly
(net_shaper_pre_insert error path, net_shaper_notify_down,
net_shaper_cap_pair_update, and net_shaper_rollback as of commit
b8d7519352ba).  The struct net_shaper already contains an rcu_head field.

Fix by replacing kfree() with kfree_rcu() in net_shaper_flush() to
defer freeing until after the RCU grace period.

Found by source code audit.

Fixes: ff7d4deb1f3e ("net-shapers: implement shaper cleanup on queue deletion")
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/shaper/shaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index dea9270f3e57d..92a6939787240 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1475,7 +1475,7 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		__xa_erase(&hierarchy->shapers, index);
-		kfree(cur);
+		kfree_rcu(cur, rcu);
 	}
 	xa_unlock(&hierarchy->shapers);
 
-- 
2.47.3


