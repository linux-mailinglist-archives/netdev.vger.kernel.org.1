Return-Path: <netdev+bounces-148265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBC9E0F98
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638361643B1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2D1362;
	Tue,  3 Dec 2024 00:22:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF01CABA;
	Tue,  3 Dec 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185337; cv=none; b=Tp6YpI21OpNlXOvHAxZyXcUH2pOMr+AdXxwHM3zcVEDtt9TfjeqJ9T3D+/GgtA8Jg8Z9D3aZgzprgCeUYHabxveeNASkI2QLwxDOEhmbamM+9CfEAOdFkdBjFEVmcgRK0PvXLsgk7FOtl+DmA+JhDVfFZ3yxGdZMYl4MuMVlFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185337; c=relaxed/simple;
	bh=FEdYhWbX1ktjJWhrNGE95iYZxN2flC9/9+OY5Qrf82g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=syMmr1Gl95pNNS8OzGi5agh58mRhFxTB7INW02G3t6dz+tZRD/oe++Jd0sE97ayJUrBLTR6NGbBXKm6dKnOYGDv+agz32kJ7h3Z8jvcJ9EWkmlzpyVHunWdgNalqAATntbHQNaRLiSw+sITeXy4UQuF0YHOlMbLF87BnQrUrJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa52bb7beceso563634466b.3;
        Mon, 02 Dec 2024 16:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185334; x=1733790134;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTJLHISN93NueCES22Bj6/yLdEvLjYu4oKh8KeAHgvg=;
        b=eIU2ROn2/YLdljNklyw6vDl+Huy8UH810UsitwvaH5HWOR2XiMbvT8irXlautN+QvM
         +keI4Wvkf5vfBSZb9TbudnwFcAyUPRo7enNpbA9hbiKkxBgl9UMm2YdHD/xV8DUvq+y5
         PzP65AI0+6BQ3pLBUmK5ySZp+36aNwekJqz34XmugvpOoSnLjxgzIfiotaue8aEe0D5x
         aCw9CnXkvVfcPO/3CttiUPXloOn0vpi3R2WK3VwW45UoBEYq/1fWsK8qalezglOkalCf
         mHFo4jzL44IlwfYFgZ/VTRrNsywbbizg2eJYO7AHAVASzknYPKaR0J5VRSS9dArB7oFr
         iPeA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfGSLkZjCY6nULuYzu0RNxtrVBlW2kOKoz4m/7V8PtQ24T+MV0OPbU72rszZFg8qDSMpj5ZuBKqWpvJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Wrlh+Jn9vhJyYuwwGeZs+6YNpl/sMaR7y/JVUH9l+IQLHjs2
	O5Qi4gjOy+FHGxrZsBgYKNd0Tt8iUA5XH5XVff8DgdIrxHv1N1tG
X-Gm-Gg: ASbGncu2PBKGB7qNC61nxi88ht5Ca77aWgNQI8I0Y8f3U3L9K4iST+I79wwt+r1o22c
	of0fYOZaXjO2Oa5EUroF75Q1rYEl95rq5hp9ExTHC+B01gJCpUxkzTWVdhsV1vfunWgWFEBgAkU
	K8Wmjp3OKjtIkgP8aZPat1MXtqD+Q7JaIAdNwmWxwhUXUuKaYzeBQDpfFuw9L/WuuMEp1JCDx0l
	z6Q7ZlRjyIC0swc3nGJY+oIyTmSrnUpsB537oTOPNQ/X715fOE1McThdm3spO+VAO+CXPamv3iD
	Dd0=
X-Google-Smtp-Source: AGHT+IEUOk/iyWhfLGsKgCCArT7N7iLJqFlfsKupNomnbTW0lCJ0xs7C039Zt4bnP5GtGYREEtAbmg==
X-Received: by 2002:a17:906:cc1:b0:aa4:ecf6:baa2 with SMTP id a640c23a62f3a-aa5f7eefb7bmr13378766b.46.1733185334149;
        Mon, 02 Dec 2024 16:22:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996dfc2fsm557686666b.70.2024.12.02.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:22:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Dec 2024 16:22:05 -0800
Subject: [PATCH RESEND net-next v2] netpoll: Use rtnl_dereference() for
 npinfo pointer access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-netpoll_rcu_herbet_fix-v2-1-2b9d58edc76a@debian.org>
X-B4-Tracking: v=1; b=H4sIAC1PTmcC/4XNPQ+CMBSF4b/S3JkabsEPmBx0ddDRGNLSW2hCC
 imVYAz/3dhJB+N6cvK8TxjJWxqhZE/wNNnR9g5KJhIGdStdQ9xqKBmIVOSIArmjMPRdV/n6XrX
 kFYXK2JlnJpV5lqntbpNCwmDwZOwc4Sucj5fj6fCeHQXuaA5wSxi0dgy9f8T2hPH5LzMhR56vt
 /XaEBXa6L0mZaVb9b6J5iQ+HfHTERx5kckcjVYKC/nlLMvyAgXnZ6gZAQAA
X-Change-ID: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michal Kubiak <michal.kubiak@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herbert Xu <herbert@gondor.apana.org.au>, Breno Leitao <leitao@debian.org>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=leitao@debian.org;
 h=from:subject:message-id; bh=FEdYhWbX1ktjJWhrNGE95iYZxN2flC9/9+OY5Qrf82g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnTk8zg7hQ1TyVCiuRFBp3PuGYL44zHBZh7D7+l
 uszw3c4zS6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ05PMwAKCRA1o5Of/Hh3
 bdmOD/9RU3N6dMhPag/GSsOnHh0tIB90KoRteud0xwql81uqorDc7cYUPEyUa7WMYZkkJCSarvl
 aQeI8fPzTc30YZVu8j7LrGDyYNp2/lmjQ1l2HJHAIHuL+SyY6lmbF5qdx1ubqjivR4insLkjpmL
 NZdAKd49aO1kBJWJ53wPrqt1vxJ0DzBPq2Pf+tU43fvz9/fZ+DvNXu9wcveR+vOH18GFW3a4NYI
 q0tb9EtS9zHCv5fdS0XtdyvQdYT5+mbUjk1MXz52ZPRJMxT0NfRNtxQJo7i1EK+pK4013yNXmTE
 S5k/rkHQgvqW2iVgwy2E6poY1uKb1wsrnbaan0Dc/zI570rQYSgTVUZGyVpcEZhsfD4lQPTFXsc
 199YC4OgWl9a3oDwPwKWYbw1e0ymTfVqbTRp2yo+e9BIpqW1tfiIqINT2ZFsDZumfG/0XADEV7P
 4Csy42WK7oBSpVDYk9FavTbzDHNOydfouZxQOVlLkP4Rv23eSD+99OM1Dx56Bs4hbpge8MqVlz6
 C2L/KaqApjnUsEQp/aFXkptQzCE/IEko0NJSB9VGjrQE0exPjKz80gVzza02OJ0V76ENdn/bIyr
 e4QTb752yIU/V7caOHRKTKgBrNg0PlU7MbliAi1ZECIvEM3hMoyWlxL5tDkAcZAvsDxjtYq51ts
 Ha5zzcUePAWdHJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

In the __netpoll_setup() function, when accessing the device's npinfo
pointer, replace rcu_access_pointer() with rtnl_dereference(). This
change is more appropriate, as suggested by Herbert Xu[1].

The function is called with the RTNL mutex held, and the pointer is
being dereferenced later, so, dereference earlier and just reuse the
pointer for the if/else.

The replacement ensures correct pointer access while maintaining
the existing locking and RCU semantics of the netpoll subsystem.

Link: https://lore.kernel.org/lkml/Zz1cKZYt1e7elibV@gondor.apana.org.au/ [1]
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
v2 RESEND:
- Resending the same v2, since I sent it when the net-next was closed.  :-P
- Link to v2: https://lore.kernel.org/r/20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org

Changes in v2:
- Targeting net-next instead of net
- Added the Acked-by and Reviewed-by
- Added the link in the commit summary
- Link to v1: https://lore.kernel.org/r/20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org
---
 net/core/netpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb52b7c5e4710bf3f7740045d9314b..99e5aa9cc992f429eecf20aeadd04dc293b8f22b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -634,7 +634,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!rcu_access_pointer(ndev->npinfo)) {
+	npinfo = rtnl_dereference(ndev->npinfo);
+	if (!npinfo) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
@@ -654,7 +655,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 				goto free_npinfo;
 		}
 	} else {
-		npinfo = rtnl_dereference(ndev->npinfo);
 		refcount_inc(&npinfo->refcnt);
 	}
 

---
base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
change-id: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860

Best regards,
-- 
Breno Leitao <leitao@debian.org>


