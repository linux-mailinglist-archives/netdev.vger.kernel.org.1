Return-Path: <netdev+bounces-176703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C9A6B768
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595CE17CAAB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB641EFFAF;
	Fri, 21 Mar 2025 09:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A71E5707;
	Fri, 21 Mar 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549472; cv=none; b=KBSo9UN9UWgCpYNB1aQykVyJepJ4Gp/5seSfYOrRg7qv0UQH/o9DRUh6mviXK+RDTC67fXHGTk+WqysLJ/cKS5FJ9bKg41nNFpE7d7ZKAa5a/SwA3eQV5Gg42LmX2pCm66FzSnQin+9ZYIHlCYCbdrCvlRZw8LBy0DepLc/bb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549472; c=relaxed/simple;
	bh=Y6I/8vVmdfk6sGCvQTPk4i11HKqhHcWpJd91MnYDdOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TXHGY79XJCnR8mot8lCY2mkUNNwwjM/ELK/mzijUUV5jtW6SSwQjvHpPMpFVGwiQ4r3Ld8+T4CcHNd8e3PhRMBFMfNi1AxqwTjK18QLzs9ULR6v/ospfSnYcTQfYN0+0JKx8+wme0pMf02KnH8AF6YyUQaDOwrmgsqSjzp1agVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso349084866b.2;
        Fri, 21 Mar 2025 02:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742549469; x=1743154269;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/NPUaREURJ6mCKVAccGEeQmvtTeXxq8+4zuow6YaFw=;
        b=rWHQlOigmqcksMmd1Gbrl0B7d/55p5uwBnHKhy9SV39PV+i5Llax5CuoeuwaHF0QhZ
         sZj5gzynWzZi8vjaTpP2rH5cZxgi6aPNb6Vrbo6xJo/uzRl5iTUYRktuD77L2e/AQ7IE
         JFyiLxrhSHrxVXNMTheREcKp0FXUYo2n7s0jeY/oKIxCqU/jHsL1XO6FDsoRmnGIJ3qE
         HnjyPAs6u574s5ZvxX3GEBmgnxN57GViuqUhRxHkZNVzONpcoaQj5afn5tGzvkhZ6e2J
         quvqrlvzE8DW3sB7nRysXVkG86jlBzdX8zE1CXSFbQabkYaDWUjoaIvQkVlFJhty3DHB
         EoaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5I3icIdbl5MheYRmxDu+l+LIWssVeC6DJwxrtmWV+vG13WQhX4fBo0iipQ6Kr/4z4Ft2nI+8+@vger.kernel.org, AJvYcCV5Nq7CybI/pRQykVZWMTedsPnzJ2onDzcDCMShtMCieedE1LbfsF9uq75OT8t8RqQogjHUrt2PEsxjCXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztochO7roMXzCMpTtbJ7WDbTzczTwlZPrhJfpuaxpJQ0sJUKWn
	+zZnxt4Zux+vPCCUnM0g5T+TYvGGm99HoD5PAlAygR8zVtnWXF8q
X-Gm-Gg: ASbGncsQs/Yo+5jtwtnpjJT3yRr3SoBb+gPC6U8uIdbZPVq5g16CTKOU51OsLKpuhsp
	d1dZe7G0lOlbHqfpfstMKtnxSmKg8bJklrsMGeFiMgW2Ah1eOBoC1Ek331ITHZ/hlnypF9eHIZx
	8JmHDNPornsBvKYUsfSTEez1NOkXkTvpmK7VYNkS7EBffCLjR/35dB8XpwB4XJQ2LtRqHsLCh+0
	oWNr5DHSocWPE/9JHcmDEfy6fMhzI5YyYH1ZS2Lpu2vfex9N5TxdZHCGANFISp95uNTWwyCtg20
	Eo3QIvuzFwEh2/2rA0iELGfspHnzWrtVmrw=
X-Google-Smtp-Source: AGHT+IF8f1GC7wbrCO3eXH1B7reEeFIOUHS0zx+PYz/rKNz+5eov4VmNDk0rBsgjC169SJCW/K90hw==
X-Received: by 2002:a17:907:6e87:b0:ac3:2d47:f6af with SMTP id a640c23a62f3a-ac3f212b833mr201431266b.20.1742549468664;
        Fri, 21 Mar 2025 02:31:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8676c2sm116468566b.9.2025.03.21.02.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:31:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Mar 2025 02:30:49 -0700
Subject: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
X-B4-Tracking: v=1; b=H4sIAMgx3WcC/x3M4QpAMBQG0Fe5fb+tNmyyV5EfMxc3QltJybsr5
 wHOg8xJOMPTg8SXZDl2eDIFIS5hn1nJCE8odWl1ZVq1HXEd+VSD4Rh03bTOWRSEM/Ek9z91/ft
 +5JbwcFkAAAA=
X-Change-ID: 20250319-lockdep-b1eca0479665
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>
Cc: aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com, 
 Erik Lundgren <elundgren@meta.com>, Breno Leitao <leitao@debian.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y6I/8vVmdfk6sGCvQTPk4i11HKqhHcWpJd91MnYDdOk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn3THacqvxp5klqqqxekE7OYBsb7EMCXA8usIVX
 OhVJnYS046JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ90x2gAKCRA1o5Of/Hh3
 bWszEACxTC+Ie5buHGAr7rv5ihfTYSdVtFYTgDBg7vdatWsfs39+6AdMD/p3O4eqUWs/e/TTGRy
 sTIMHuNC6FbfEfqY/2J6+OGybKh0B7GIZhCnos3xAAst7oR1knZ0PsYqEWVZK7dkkWLlTCYycAQ
 J5FIn816Grs4G8L2hEZk/VLuSxSlCDe1XSBOfSF79ltHk7DqUgcIzc0O8y+S/kkgfDVvJFzxgfE
 GEHclgsI/bZv71856R5aSS1Z0tF7IpfJV7I6TShhjquYYjFnuTu/4VgBK16lG8gPfx79cIO4lMg
 pcj74c6Wt/UhSONLbTz267UgUhCmA6uzmaq/mIRwD/z91enQmqJG6T0lPMWrA9m3BVFgA1hDaIo
 vSu9xrMtCkiGRtXwLuaIPbkFRp6U5D+YVHhhRwwzAiPnevFrfs4lye5dfpQtdybiqW6VAByfpfC
 RLemQxsdOrixHpjQen9hWl894MFOJWq2kp+uWSRb8UdYt4rBIc/GAo5r/pFRktxtEtOH5S3d2Gc
 GpvMGss3Y2ELlcj4/6AndV6OwYKEUiLLupkxPC1gTc2eNjaOPokDj6gafjH7fcYtnL+AZ43Yk9G
 k9IvikeSZhkX1uf5QozaaHOxlRf39WYHB8CuuMJ6nmi4mxs7IYs8IxC1ZUHRGmJA9Q54mXxsCW9
 dqp8+dNwrQU7qOA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

lockdep_unregister_key() is called from critical code paths, including
sections where rtnl_lock() is held. For example, when replacing a qdisc
in a network device, network egress traffic is disabled while
__qdisc_destroy() is called for every network queue.

If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
which gets blocked waiting for synchronize_rcu() to complete.

For example, a simple tc command to replace a qdisc could take 13
seconds:

  # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
    real    0m13.195s
    user    0m0.001s
    sys     0m2.746s

During this time, network egress is completely frozen while waiting for
RCU synchronization.

Use synchronize_rcu_expedited() instead to minimize the impact on
critical operations like network connectivity changes.

This improves 10x the function call to tc, when replacing the qdisc for
a network card.

   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
     real     0m1.789s
     user     0m0.000s
     sys      0m1.613s

Reported-by: Erik Lundgren <elundgren@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f02269..a79030ac36dd4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	/* Wait until is_dynamic_key() has finished accessing k->hash_entry.
+	 * This needs to be quick, since it is called in critical sections
+	 */
+	synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 

---
base-commit: 81e4f8d68c66da301bb881862735bd74c6241a19
change-id: 20250319-lockdep-b1eca0479665

Best regards,
-- 
Breno Leitao <leitao@debian.org>


