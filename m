Return-Path: <netdev+bounces-182215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE8A881DE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A626717937F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764812798E1;
	Mon, 14 Apr 2025 13:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203427585C;
	Mon, 14 Apr 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637090; cv=none; b=EpQ+YABmDV/Z5uJhDX/bilLjTltM/nQwinAAkUNUQVSuTnyjUP7f2XNMf502XBfFlBOybPd/tIfjXcT3PbxrTXMwwnuW8C5XgEq2jvXof8XfY06BdwLj8ULRWkiqSGmZB6ycvMnKiarXQ9Sc+mkUMji6MpbkmMeA2R5aG0VeJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637090; c=relaxed/simple;
	bh=QH4HBkEgzWlR+iLppNxzhUiHrA5hDihNEzcMAW7W4Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmNRxZw0RrwBujwmbO9PkP8lB+SdqDOt6oEbL1pv4s3lZD3N8wGamljQAVB7ZOz6b2a15w8kTeFHP6Ne4+82rN49PnzjfZit5y3mjCXdx3mYvQzN4+xItwFnuTLUO18nKkSQkmOhNZkY7vP3CPdmEAVA2J/Z3Nvkjaf2pfkbBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac289147833so866674266b.2;
        Mon, 14 Apr 2025 06:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637087; x=1745241887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRtNPlxz2zfsOHt7gPeh2UUvvFdJM11RSUvY0S+WMYU=;
        b=APeJONcCn286sZy66aYe+LgaT/3EFz/WatTUntgPKOMt96yulQb7BI7rhxzEY7hNtM
         LSCV6zbPtd+e/EF/vtgW+aWXITw7IQD0goiQvqJUF9BF8yRSxkDGCeOubBGou8WYKt4u
         Mps5sdVTqdtvqiXfkHl7RXXSIjJotBcD95sBz1LN5MT20bmFd+XZEH3sxUO9csnly8/a
         ziUqxjFUZ4rkcs3IlQ5NnS0MuemI/CKFgsifJa2YKSmkkqCopokzSZOk1rXQo1u+ywbG
         j9vq1uBcLX3D4H5Mx3jMf4Zg4Q6IO16HECnCz9Stcbd+tbd9mB3Z2ySfnDBpUbUSLP98
         GgdA==
X-Forwarded-Encrypted: i=1; AJvYcCU1ifWjG5770oDD+jcrTJTd1Z5fAnlCX8rE0kj/9XZIxoddliAU1G/oZOHMchEGGddNg70D1sdFYWxaa/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT5lj/JHG4EM0dlfM+OJqgqVYvHDtC/O0wJo3dLQWlYepBkOt
	k11aa+g4LdP0BxWPSW5nX9sP+Pf5gLeK1tyfab8Zx6c+koOfymgy
X-Gm-Gg: ASbGnctqigL0f5zC7tS0RIfm3tZ1d0X1UA1mPzUFAKuXOnsKA9VOr88AbzGcigvCurE
	91ngxHuzUg1hGYROnkzz2HYauL1lHH/4Rjk77rsRpJkJCOOwV+oj1AwZAfnzIoC9BWYXvwwhdeF
	k7ie1MU+fk76rHUtvHUZXOUwXwUTyab2kcc6pdWZAm+Y/KTYLA+H3OqOTsnasjfJK6yOuzyyKuL
	wcWoKshngSHb3voNbrRkoRxUfGuqin8rCH/vniyrPuk6rQjVYvF6qy9iIk7il2phTcSIKkZvwS7
	M2FBMOiVB/+KcH3HKk7CbrYICo3mINQ=
X-Google-Smtp-Source: AGHT+IGOWuCkTf+8tbhnvHToKES03iq4QshkRj7yoBfScEmpqVGoq4VGxClzsOy3zoBI1YXrodGUDw==
X-Received: by 2002:a17:906:4889:b0:acb:e1:6503 with SMTP id a640c23a62f3a-acb00e1666emr226128366b.50.1744637087053;
        Mon, 14 Apr 2025 06:24:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7fdcsm921165966b.176.2025.04.14.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:16 -0700
Subject: [PATCH net-next v2 10/10] net: fib_rules: Use nlmsg_payload in
 fib_{new,del}rule()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-10-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=leitao@debian.org;
 h=from:subject:message-id; bh=QH4HBkEgzWlR+iLppNxzhUiHrA5hDihNEzcMAW7W4Oo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyO/SuSwBqi5s9qnVkbc6llOeGblYxm27yEv
 ZvXm0acPDSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bTecEACpv2HtCD+FWwLu+5RJN460rj/87oBfaM8dK1Gu+3sOHXt/OW/YdI0jkj4HC+uz4OZpLKj
 5YeLycdVwlfHUf23eT04t7VlcTreOucWB7SmfM6MCOV5EbdnAxwGxczKSI53HZG3fM4ndTIE2Q1
 6vf+/BZO3XiX47Z7GZ+Qh9cdp4Zvqc/fSltIVCldkp7P/81DsWwKYRep4CHehWMHJzzEDRql469
 huXTxjzBH+aI30gCjBXCgCuUpLFqPX/0D7bW9H3GMx2q9kaoUKmj+DDTonN6frejmSoWfcF8Y7e
 6ELwFg2oPC4ENWLlXOhHJOX8ddKqqtoNiDh29MkxsNVgpmmjJ6XkxkEU/BABAA/uIM1Fsbi/93f
 4gV+uS1LIsrmWu5P2LO9hC2BcHutVQNZXoggNkWOieoMkaG4ZrXEmUeom+C8Sqf6obe0gzDR+Xf
 SDlvUwRSKL+WT9lBrKQ/ybTganD2KRnoI+aZibaukiDqQ0H4FsgBkhk5xJWcwtAcgFepk9by561
 ccx8tzzBPtz3HRqFxhpeKyX7LtbvcXEvpUaiXvWH9ur5DxIvSuN5q0JTwUrj2jh6XHxVEd2K+U9
 /qNMsJNBFn2SYRS4ugTlnb6ZIRDHH5Nq67IWy6aOeBSV3q7uHXU6qJIZUDfAsRlFD1LisGh81rR
 NOPSYSElMrNXQPg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/fib_rules.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 6a7a28bf631c2..06052b6c946b9 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -852,13 +852,14 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct netlink_ext_ack *extack, bool rtnl_held)
 {
 	struct fib_rule *rule = NULL, *r, *last = NULL;
-	struct fib_rule_hdr *frh = nlmsg_data(nlh);
 	int err = -EINVAL, unresolved = 0;
 	struct fib_rules_ops *ops = NULL;
 	struct nlattr *tb[FRA_MAX + 1];
 	bool user_priority = false;
+	struct fib_rule_hdr *frh;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
+	frh = nlmsg_payload(nlh, sizeof(*frh));
+	if (!frh) {
 		NL_SET_ERR_MSG(extack, "Invalid msg length");
 		goto errout;
 	}
@@ -980,13 +981,14 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct netlink_ext_ack *extack, bool rtnl_held)
 {
 	struct fib_rule *rule = NULL, *nlrule = NULL;
-	struct fib_rule_hdr *frh = nlmsg_data(nlh);
 	struct fib_rules_ops *ops = NULL;
 	struct nlattr *tb[FRA_MAX+1];
 	bool user_priority = false;
+	struct fib_rule_hdr *frh;
 	int err = -EINVAL;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
+	frh = nlmsg_payload(nlh, sizeof(*frh));
+	if (!frh) {
 		NL_SET_ERR_MSG(extack, "Invalid msg length");
 		goto errout;
 	}

-- 
2.47.1


