Return-Path: <netdev+bounces-171026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2DA4B2E8
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570C21676C1
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FE1EDA15;
	Sun,  2 Mar 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="k54U/7Dd"
X-Original-To: netdev@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DA1EBFED;
	Sun,  2 Mar 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931639; cv=none; b=Ef3982hmblbtJyAH7H6ef/j9Y1+IBeVhSXBDxZKxCvvE8OD/PgjUrZ9OCSk2Dl0x4wUdUqZ/tEyq7mI/tiAdDAbRm+DjNMxZmy0LyDRoGP5qhzRck2Q7DP6EpjlfE2rNpHNsdWU3yQ2WB75xmNcMmTr8oNieJnc4dF4chhOY5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931639; c=relaxed/simple;
	bh=RN76k8ewK6+gsyTcan9ooTB7HAoL+bwmZL7k3n+IX8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEzCQdliDIj9ktUJ5HtRkLR3imIwOwW8sZMGdyUFq7M4pGesLvi894T95E8bveyEwhzWi2A4F1Ss8cRy6ZvUol2Sxt880K5a7i3sDu1/p19yd3Rv8h+M1RUwokRFAtYiIbU2Yz5GWfatK9ptCpR1o6M/qCbm8lZOAQS58wvbHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=k54U/7Dd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpiJeKuvGtt7uxh2hFS+dsziMi5lwoHgf9YFZ4de7gM=;
	b=k54U/7DdT6xtoAVoeM2idgM1EIL6B5xU5Evn3d7IbnrfCB2uh2H/qmdz55n6qzYx70t3uH
	0p35FZeateL7Ag1b3jOl59aFVU3uNUOoOaGtOoNKxNo3iH9LD7LNawzzrdlfxamMZoAHC1
	T4vS4zw8LYD9l4XzCHBQ9dNgv8JAvXRo428TjONJUaI0xQTyFQMJX+VS52vdyUL23crlYb
	+J4Sv/UqlrVYkluFgPUsjHozs8BE3AiLiM8Q1M8DmCmIduSNhFqN/T0n9qRtUf54yqrNCd
	+sYwCjsV5cLzQ5txbqd95Gy8aMLJSbY4fHiroYyecsj9apwFsLeTUQqV7hOD+w==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Christian Hopps <chopps@labn.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 10/11] skbuff: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:46 +0100
Message-ID: <20250302160657.127253-9-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b1c81687e9d8..7ed538e15b56 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1566,7 +1566,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, size_t size)
 	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
 	struct user_struct *user;
 
-	if (capable(CAP_IPC_LOCK) || !size)
+	if (!size || capable(CAP_IPC_LOCK))
 		return 0;
 
 	rlim = rlimit(RLIMIT_MEMLOCK);
-- 
2.47.2


