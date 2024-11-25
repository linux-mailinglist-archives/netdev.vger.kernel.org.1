Return-Path: <netdev+bounces-147209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529809D83A4
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6416816746F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAD1AAE39;
	Mon, 25 Nov 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="He/Nsu8T"
X-Original-To: netdev@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D8199924;
	Mon, 25 Nov 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531240; cv=none; b=sECDE6XqApn9pQ89XlA/Di9UEtmFmDpGfdTykrUQ2jV5EJuTRotfwUvrmTW3PCnPiN8g/rTrlzfs85qub+0skcXDQ2xv0nDrmGpftt5ovdZP1WfOvM0QWTO8pWt5CKQMqESInTXlxHV6jscmmUTazL1emgd1dz2w5im+eUybyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531240; c=relaxed/simple;
	bh=5zl918IEUyEEK6Zj6zbtZJmQTRCcBiXNutEld1pO/Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnsczJ3xfz+0i9zBBRgx6mLWFkJ2+Pk0DJAjywp8Ysy92JYKuk/17vp4Rc5V/4mqdJf8r86C/BTK94w4ioZavcUYLNB0Vbrq6jASp6GnfDaN+PmyszSp4mr/WUrFtppRZULUtn/mDIh1djhAECcjBBSk140FtVxv9Te4TJipC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=He/Nsu8T; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531236;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3xkA6/OPtNWl6A170imeRaHJSFeFAlcMrS6betDjBY=;
	b=He/Nsu8T8nvfNlUyWxosD+aqdOqwmX/wEHaa2TjwySQRhsy3y5mTIIxk/xGqu/tcDJ5953
	ZnRNBzqyhJWSs4bdvRWugPMdaEsZwP1EY0ud9vuXGWC4i3ViL8z0nnFQIVAsnam3OKt7my
	K2Ca6NHqvTfAEibYKAzLnT1cErwF54vzr0x0gtB5XB/U8Jumi5mAICsd54kb+UqDr39vt6
	jctvGmD/eh545sdjY605727XRkT0xXG6+ZLYPvzo7Bw//DkeQH4/XwiZL3HYSTqumPksvy
	biWPeTD9ZM37zKthExv/H7ZnuC3e8ZPnbE/4hQKbh6oXoC0j3uLMOb2YBU12kA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 10/11] skbuff: reorder capability check last
Date: Mon, 25 Nov 2024 11:40:02 +0100
Message-ID: <20241125104011.36552-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0..8bf622744862 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1656,7 +1656,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, size_t size)
 	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
 	struct user_struct *user;
 
-	if (capable(CAP_IPC_LOCK) || !size)
+	if (!size || capable(CAP_IPC_LOCK))
 		return 0;
 
 	rlim = rlimit(RLIMIT_MEMLOCK);
-- 
2.45.2


