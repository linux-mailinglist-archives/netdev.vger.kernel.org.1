Return-Path: <netdev+bounces-142745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772CC9C0343
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DE91F237C8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111A1F12F4;
	Thu,  7 Nov 2024 11:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B651EF923;
	Thu,  7 Nov 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977394; cv=none; b=YTjw5R/bWgyul4ezDujNB3Ro0AEsybeoSfz1fN8hs3nL+N8pacamcrBNUWn8X+wJD1sy13aJJYIVIs7e7X3DJSJqC3ItCy0IhT8tua6/mUVrEZGBifZBP5WjgauoARmUAk0HTfTLdG1qQkqvYuGua3c8rbN5wBn570GYDI4GZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977394; c=relaxed/simple;
	bh=3ErXnkzPXHXYk1o/fqIsJm8Zuq6K3DTzluGq+w0yz4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S6bI8PJsQz8NeDtyKx9+QG/QwdiIyaeg9E0zRA6Aq/xNr5HhG/AziMGdGShywTKRx7j39QqZa9Wp/87JTtqu8XquZCgMLqRBcUnarX2cCFg3leDUD75ijMC/4plhtwxqBb1LUOh+23Y13QbLhUkYlToV2UJ9nBPkqhXDhFDJQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9acafdb745so178031066b.0;
        Thu, 07 Nov 2024 03:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977391; x=1731582191;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwWoCBwVR8kG9o/zCItPBe6Zux0DZ6w5rjMAQQHp/eQ=;
        b=tfy9/g+ONpKtQ1I+THLWnLBSgUJODBn0KQHgXMm8lCZ1Na5Bv/ZHt81mKG0Str6oeE
         0oD/Q5czBAnfdpXsfGXrvzwMpC3kcfYiLi+RWwzTInaGK/ex8H6y7i4N4+v9TC/GkZQG
         32/TIVmmdrpGxGRMV7j7H5Dir+JxOZ6f8pP3Zh0PfLjJWNyvv8pRlNbPcOkTwDCPEuap
         4Ixux3tPLChVdrkUEioK4XxZN8WD0sHlY958T5q2yYOZeXpMp2haE3cmwoet1bh2ilYd
         lOfG0sZ83LtVa0GBFkvh1tqKlFzOVStDcRVEYpVd42npEi5W68y4v6If75GbUfHYniiN
         ZOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR7i0dzdQ3zSmtznxLeUQ+vf6OUB7xnGRplAUzV4u1xRKX4ywxaq4ovRbmfYSh8/lIOsQHkl9I@vger.kernel.org, AJvYcCXgCsMTRuk95QOEC4jNSiT3emNbbEulAQPKODoWddgKIHgpL+HbtxchjgrwzGOfGjLy4kvL7YP+K4hOuNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1tBArdLE7XtZS3XkvDIL6ZSmL8GnOVBUftLxhBNlYKdGNVKe
	BHPHKe37uE5Ja4ExS7FZvn3FahbIYTMHJTpT3NhaORVjJ1O6K3Ac
X-Google-Smtp-Source: AGHT+IF0Qkc1R64OCdjzgxELkwdGZYOG5tKXrgQSGfnLeYaE34acOHkan5W/vJL7fOnSw45FcxpKdg==
X-Received: by 2002:a17:907:3f97:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9ee6c615famr75107066b.29.1730977390483;
        Thu, 07 Nov 2024 03:03:10 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc5db6sm76795966b.119.2024.11.07.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:03:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 Nov 2024 03:02:55 -0800
Subject: [PATCH net] ipmr: Fix access to mfc_cache_list without lock held
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
X-B4-Tracking: v=1; b=H4sIAF+eLGcC/x3MWwqDMBAF0K0M99tAJtiq2UqR4mPU+TCViS2Cu
 HehZwHnRBZTyYh0wuSnWT8JkbggDEuXZnE6IhKCDyWzr5xuq71t+LrQ8Fg/Su97fqIgbCaTHv/
 qhSQ72uu6AbIhanxfAAAA
X-Change-ID: 20241107-ipmr_rcu-291d85400b16
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=leitao@debian.org;
 h=from:subject:message-id; bh=3ErXnkzPXHXYk1o/fqIsJm8Zuq6K3DTzluGq+w0yz4Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLJ5s2DLNLfVUR5XEhUtDtpUR0i8TR+SgzDIQh
 rPcWOtAt/qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyyebAAKCRA1o5Of/Hh3
 bRTQEACMBDVbyND6f42JQfVgt2FLPK8ak5R8Dxg/QqrqDNjJcmVyRAVbAAbOPgMwGjae9KjHmPe
 jaHUEuIPLmJcZ99SgtoIHknpOfaG/hz3qRIfMTZc8WPT1wKGWZAsdA3YG9RFEmMa1Ia5ZHb4Cxq
 7dT+1DMdKwUFoIbKHer5IBHoExsns6F5s2KdHnL8NzOF1b/HPjf8VcSFPIh9O10i4r/17FyYWS9
 W2pt5kDxNs5CsBPuPNusJ6cES6b0qE16oGIxrJmmh3HpcMENiPhBDxZGj+M26YZZc9uGrzvX38Z
 6/DqPq3IGM7EMkHKc9IX4Wj0K3IyeuSsyJEm8ibs0iVUCXF3i4jid87xBxxklc3HmjuRzL+75Mk
 8ZReM5HAMiam7l1mAfbIlynATlRjogNM/Zja3aVFexoPyV0qIFD3rb8gDLJJN+Vo3dqg4COPD4N
 WFVq0bd5qofmKLilMSCOfcYISBtjFYfY/BRJoPdIJ1TtJY7d5ks4tli2H9xU7fmScshtgAO4z0m
 Je9j02WfL+DyOuK5isWSMV7mToQbAcAEHycVfZnqnnjH2oJH5W+0aT2uSFMtjNefSeBIODq36Lg
 OgxmIv1WKlKvwJIRTMYUY3ujIAvvJTvnKhLewHUX4Cbs6vn30qFmuVcRhMFG7UdXtUSGlRNPg2W
 rMTnORCueQ5AJWA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
following code flow, the lock is not held, causing the following error
when `RCU_PROVE` is not held.

	6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
	-----------------------------
	net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section!!

	rcu_scheduler_active = 2, debug_locks = 1
		   2 locks held by RetransmitAggre/3519:
		    #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x8a/0x290
		    #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x6b/0x90

	stack backtrace:
		    lockdep_rcu_suspicious
		    mr_table_dump
		    ipmr_rtm_dumproute
		    rtnl_dump_all
		    rtnl_dumpit
		    netlink_dump
		    __netlink_dump_start
		    rtnetlink_rcv_msg
		    netlink_rcv_skb
		    netlink_unicast
		    netlink_sendmsg

Fix accessing `mfc_cache_list` without holding the RCU read lock. Adds
`rcu_read_lock()` and `rcu_read_unlock()` around `mr_table_dump()` to
prevent RCU-list traversal in non-reader section.

Since `mr_table_dump()` is the only function that touches the list, that
might be the only critical section in `ipmr_rtm_dumproute()` that needs
to be protected in ipmr_rtm_dumproute().

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 multicast route dumps")
---
 net/ipv4/ipmr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 089864c6a35eec146a1ba90c22d79245f8e48158..bb855f32f328024f384a2fa58f42fc227705206e 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2612,8 +2612,10 @@ static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 			NL_SET_ERR_MSG(cb->extack, "ipv4: MR table does not exist");
 			return -ENOENT;
 		}
+		rcu_read_lock();
 		err = mr_table_dump(mrt, skb, cb, _ipmr_fill_mroute,
 				    &mfc_unres_lock, &filter);
+		rcu_read_unlock();
 		return skb->len ? : err;
 	}
 

---
base-commit: 25d70702142ac2115e75e01a0a985c6ea1d78033
change-id: 20241107-ipmr_rcu-291d85400b16

Best regards,
-- 
Breno Leitao <leitao@debian.org>


