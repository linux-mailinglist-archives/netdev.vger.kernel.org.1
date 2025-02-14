Return-Path: <netdev+bounces-166391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB43A35DDC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594C63AA8AA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7117BA1;
	Fri, 14 Feb 2025 12:48:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A92DF5C;
	Fri, 14 Feb 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537287; cv=none; b=E/TNSBPxCtTlRVPT+H68cFVYVRWvaKSW+XiBrANWIMHQnpdLMGkmAViptr4KzCmurNizzjnaf8N/1ZJOGEPm3AxpRcOZvQ1o43Hfj85vscZ3QGpkTpTozmLIO9+5yZLnfStMOWRtAcPBqOdU/X2AzTuwmiLyKC0DTQE+1s5Icqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537287; c=relaxed/simple;
	bh=BzDfEKhUE15vpc1INVw+F1pbXo84Ls4FTMQ+1iKgxtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VSrjb6PjL4xOMJ+WBByp6JYLs5zHM/nEyW6xZP53svWRrZeardi4FaHyAdYoH4JIXQZkHtpVmOASx8CO8wvVRw2P2xgguGjuf+olAtsReVoQQ6cIpN2RT3PhA/rWQ7SqaOwePPbslvuNjLOTJbNUm3t6Tc7R1x9xL4jzraPe+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso343332766b.1;
        Fri, 14 Feb 2025 04:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537283; x=1740142083;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWHiaeevD/r5R0u2eJ0CdX39n4tOeuiDl0zFf8oq09I=;
        b=YZL67qeow7L6/8NYR9xOS0n4cqERS5+HW3eN5Pzk9oTlQQfE6G/KkgahVQxTMisMUl
         A3PsRnkXMAJ4+aXiKKyDcy6Ji25Hy4iB7xVLO/rhbpRzr8gw2SFZokOVdbcEGzeFiMIA
         Bb9cmGXQCeaM9uqhTYFjKVfRUZMWdoUB4pXAj3bL5OkYLMo761gX/P+iGYEPi0fih8CW
         MicGD49iasbEyN5ZTj1fXQUkxWW3FRTW+mXVjIzcW7YEyd+jkMJ+YN50yK2w9WXUL/2V
         Nexe9mvnwuf4NLARqJ22NYtkqmRDR2MOJRC26mK3oTcTiTtya4vI6I80ECFxz/GAxI7q
         v1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn1XYLZRuPEVCpXXs1JpQ/mKg/Revol4StF6cuJ48sFJX1ewsf5sYIJRlrtk196tJ7C0bXtYOz0MTUFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsZYVy1z2cEqN8BfsVBvnu7JWVLJ45oQ65/dNdswqLl8o+HcA
	Vjk2ZY6ej9B8ePydeyz/kQ4Rtt9YZxi6RJy9RbdiRa0qeAKQxYBIkz/pig==
X-Gm-Gg: ASbGncvgvZOYFVk8N3uxKh5ejamQtf/EYztpyfB/Kf+hvL+bSyIx69qGFRS5gbqU2pX
	/5cYHhduXVWmwUwyeIc9nOgm7u0f7F6o3nbUKoRdRpUXv1xAJ+IaQGhlJbQNz9mtke8hptgG3EF
	8Vl5Dnjrpn9Mvb+rke6vKLqtwS6zgxsrkuNvotlOf25hW9pVyYI98du4lhmPwr8zvX8/ysYurjR
	b7EFgbGI4k/H5m7RGBC3D5LC36tipSNL6QfQEg0xCC4jD5ubnI2fWo8bAr7uQsQA5lkQVFGypbp
	M/Jg9w==
X-Google-Smtp-Source: AGHT+IF7ZajZlCF/chEKeP4PxK9xCSMbKF6UAl/NmWZoUrwYh3B2bv5d+6BhpcUTLjIYb2WEMGKRfg==
X-Received: by 2002:a17:907:2cc5:b0:ab6:f4e7:52f9 with SMTP id a640c23a62f3a-ab7f33d1874mr1216812866b.25.1739537283013;
        Fri, 14 Feb 2025 04:48:03 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53280ee4sm335240066b.78.2025.02.14.04.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:48:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Feb 2025 04:47:49 -0800
Subject: [PATCH net-next] net: Remove redundant variable declaration in
 __dev_change_flags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-old_flags-v1-1-29096b9399a9@debian.org>
X-B4-Tracking: v=1; b=H4sIAHU7r2cC/x3M4QpAMBQG0Fe5fb+ttptFexVJ4o5bGm2SkndXz
 gOcB0WySkGgB1kuLbonBHIVYVrHtIjRGYHAlr1lV5t9m4e4jUsxntso1nPduAkV4cgS9f6vDkl
 Ok+Q+0b/vB8be6gZlAAAA
X-Change-ID: 20250214-old_flags-528fe052471c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=leitao@debian.org;
 h=from:subject:message-id; bh=BzDfEKhUE15vpc1INVw+F1pbXo84Ls4FTMQ+1iKgxtU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrzuBGr06RVPZHbr3vzDgq0KoAoIzIV5+aOhvr
 STWQhRjDAaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ687gQAKCRA1o5Of/Hh3
 bauND/oDDyzI76zBxHqHhMyT2m/sm8HmPORt6uKeYx9YhkNvMpZkSQyLrUKSZQXZ9cHTdowd6U+
 ln3EGuS8j9H3Q6L0Ilh0w6PPfuWvuUCu1zQrfjLyENUId/DX7328NMhP00SYFrVZ7rIZKjNxdQ3
 O2CQ9T4b5pyhv9PRJycr3MoEcBZs6EmIkdMFc7YZqJ6VFYvwCaZrLX5nnG2SvE34hkhYegMRJ07
 tawIFc5rVaMSBg96w/7MY4sXoZsIUzQ1ru+9/z0/JuPK+pz7GPMcyNwCaYAdEtKTSKudbbyaPsO
 WU4eentTLOr/piMIeHhjs6umEnSJcRY+aarealuWz3P0KVFqWlP1phgHBiUaxjZFcNTgtZEl+t6
 FKHQN4GISNESz/BXfCK5G15Vg29hf3ivC7HDIx6nXWwmh4KZPAI1DehDBmMi5pmigHzU5OIVGjo
 x8vEfSRi3ssf2Mw4NPnj9j23AiOw9fSurshjtgZxMUqIO7Eqo7P/wvPPn9+0qQdO4zncnhRWtRK
 RSfiLs/coLE51Re0TGM0QbJk9su0FKAeuvAsVYGrbjKwSKG8fIMl7Q8IWtozCZjrVw7AwI74On4
 N47IABt7VXvZ73fUAtzd3Ndfr+SqU/pxcLvwIhnFGaCmuLFSeNMcgA9N9st3rl4WyvzcBzdlJcP
 np7nodxTc9GZpSQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The old_flags variable is declared twice in __dev_change_flags(),
causing a shadow variable warning. This patch fixes the issue by
removing the redundant declaration, reusing the existing old_flags
variable instead.

	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
	9225 |                 unsigned int old_flags = dev->flags;
	|                              ^
	net/core/dev.c:9185:15: note: previous declaration is here
	9185 |         unsigned int old_flags = dev->flags;
	|                      ^
	1 warning generated.

This change has no functional impact on the code, as the inner variable
does not affect the outer one. The fix simply eliminates the unnecessary
declaration and resolves the warning.

Fixes: 991fb3f74c142e ("dev: always advertise rx_flags changes via netlink")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..cd2474a138201e6ee86acf39ca425d57d8d2e9b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9182,7 +9182,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 
 	if ((flags ^ dev->gflags) & IFF_PROMISC) {
 		int inc = (flags & IFF_PROMISC) ? 1 : -1;
-		unsigned int old_flags = dev->flags;
+		old_flags = dev->flags;
 
 		dev->gflags ^= IFF_PROMISC;
 

---
base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
change-id: 20250214-old_flags-528fe052471c

Best regards,
-- 
Breno Leitao <leitao@debian.org>


