Return-Path: <netdev+bounces-304282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EgkwDkfpRmq9fQsAu9opvQ
	(envelope-from <netdev+bounces-304282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:42:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40636FD450
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jaaMr1iq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304282-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304282-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5D563028199
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4803CF69E;
	Thu,  2 Jul 2026 22:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B23C5550
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032117; cv=none; b=Ozz+Q4/WPIyQ1AMJuQ+ll+F2sR2ChLvZi0o5f+KVvAx/xEEbZB/whIKZKgKRQlrLbyX2tmRPLGNlmsbSQelOvqAZNhZnGt9lNcV6mXNXGuk1i2zqrx/eSmYXJvNy37c9+iIQdR5vuH3wXNDH0AXclZHRNRBJRYc0ym5oZGqHt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032117; c=relaxed/simple;
	bh=2Ar/mW5Y5VgDOgKTlgwEKyY0xuG8RrEyry6lC5D6q8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3WaR1v6gr6p87E69EMi91ls3/ckLjpS9lsf2XaL0Gwgc5YxvmmrWw4zF5nb+CrrgaDDoujcTjIaShZnHc1GHQ3gnVKHwfScgYycF5ghkwCktGDPP4MhZIElEuHRUR7JM5451qxrZC40LDVFUJhQ4JVe/jcfN7M9KrksKkEO6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaaMr1iq; arc=none smtp.client-ip=74.125.228.1
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so82474a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032112; x=1783636912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLS+PGgTZx0teeb0doa9Yv/49/wXqR6ear68kfo8xTc=;
        b=jaaMr1iqh8ebszkHRdJriwA6FUQG4bdwNYmG9EfaCeADj+/tbehR0FRslGC4Fgp3Ha
         nO4zNYrPpDqz5z/f/cFRi/EVCaiz6V9ljCpgxup590im4WXS1yHiIxXUcekexomJdwmW
         kM1XyH5B5JlthDZ595K7KBJ7mp5a3529toc2Sk3WyAhQAoSSq0Novdpx8hcpRtGJwOBt
         c06pn8zGDnrXWKlkQhw3i9ZFgeZa3Y9PbWRv13Ru2qHHqDHJVaB2wDql+BykU6o7jR7g
         Q6PaKAyytDucuGcAxG2GoRuWkH+r/4ky0tkotqVwYEwIebbGLrttS2si/5W82Q6L/6xn
         R2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032112; x=1783636912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLS+PGgTZx0teeb0doa9Yv/49/wXqR6ear68kfo8xTc=;
        b=D1/W4KU3RznTe7BaCnedwibrMv2qa1flUO+fZdCtjfaUEzu+MPmMCCq7EhFW6tWXXY
         iJQmLbE1iVjqKPWYNU1z4SO3N9txJBl+pvUdfL7Jn7X7NbLXJOGROVK/+B4rCCkrWp0q
         OL5ImxP/0QIriEP/OyKyTB9VdJFCPU2B9ceCbxzi13YA4jXHcCWL+22zBPRpBhhyaGMJ
         rmGXKXvYQuS8rb0Xcx5ZRe1r8BxRhR3Nqd00qkAfo4lCk/iHFd8GJTWcvEvWqbR5Urr/
         x9UYj/w8nBu6yBYvSrjRchUYWZ0XYHHGaRLFOyq/c/q7g/1/EqA1yLr5pen38ByAKLk4
         hVZA==
X-Gm-Message-State: AOJu0Yzsn3HQ1KIFwmCZMz6BQtr2W6aRxeeUPbx755ZAAlThHdX27nvD
	k1n/8Ql/M1rt+ea45yn9kAUWYFfCHgJst2PbJdvjXgwwg3Zm0YeZYItwAkMXj0w0
X-Gm-Gg: AfdE7cl/7bWXTVg2aEeAhEtaz/iQQJJMipRCVL8aNaBG1PBAqRkv6T3Zml4HwJYMqZ+
	VPVv7K92n7Ouh6ex60UB9vZz2if5KMGY3Vdc8Rkb8eEGUAK4ViB01t82ggCwx0b0TT6u35SbTWP
	2c8qRLZe/wCBbjzqpTjOCehxrFV4CMQUtyXQjfcmlhQVwMoDLmGnOBYlb3ZCxSrM1YLvKk1dUFE
	KDJluQBV9opuhXuf3F0riqGr0MINPFz3ygaQdWgyxbT0mIvzYW19hhn3a/BmqLcaP5+nhRMM/60
	Y59/GzjRbmXgLjLWf/FU1zipidtJJcwT1gOEE+Ep0Fp6SI68hh0y97MXuHZPU7LZ29tk0kvHSqo
	nH0U5l0SNoitq3aAiDOrEfvwigIowYfDG6O3z7hsGdWonoWQkiR+UOe9J4M8K8F+luG4R0f92CK
	JVATpb4Q==
X-Received: by 2002:a05:6a20:2589:b0:3b4:8300:7019 with SMTP id adf61e73a8af0-3bff40dd9e9mr7955899637.18.1783032112491;
        Thu, 02 Jul 2026 15:41:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b07646sm1713773a12.16.2026.07.02.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:52 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 1/6] net: hold instance lock around NETDEV_DOWN/GOING_DOWN
Date: Thu,  2 Jul 2026 15:41:45 -0700
Message-ID: <20260702224150.3730033-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304282-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C40636FD450

Mirror what call_netdevice_register_net_notifiers does but for the
teardown. Cover only DOWN and GOING_DOWN. UNREGISTER is still unlocked
because of the SW devices using dev_xxx methods.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..9d49493f4fb5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1912,9 +1912,11 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 						struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
+		netdev_lock_ops(dev);
 		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
+		netdev_unlock_ops(dev);
 	}
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
 }
-- 
2.53.0-Meta


