Return-Path: <netdev+bounces-182974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B20A8A7F0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D653BB40D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC824DFE9;
	Tue, 15 Apr 2025 19:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2324C69D;
	Tue, 15 Apr 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745354; cv=none; b=pkfcxaEQGSY1tttoX4tFFWEFvqRxtZHmowCav5t9zujTTE/ONtCxwZppVGVZk883q1qYuWRYXRk4dr4jrjyhkRcs2LFGNfmnyIuBo9zOufSl7P+i1s97RDgfjhlx3PXw3rCcWXbTzlQE3u8nF9+n0KPZRJDer1sR2tx1X+14j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745354; c=relaxed/simple;
	bh=DfIBCMT+6BUsIC40qa/OF087bN/29ObJUmGCZa0NpJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CL9pGiezZ7mA7PbErUoMqWSqJyVqda5kCRQ1QfzYEak1JfbY4bHuZrTr47d3/EFbfT2RGyG4trT/34RIMlTkGkqimBEp7r3JztlUGGlFexXyBKnHBlIZiQADfaMh3ea4aosMjyxXRRqPa78g3ndL2fGM5XAelmWwpTvF4fjBEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so10938300a12.1;
        Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745351; x=1745350151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAllUsbZRKY5Q3B6oSHQ3YEpDIRJItkrkCfulUmg9yU=;
        b=FdWchtzMcVqBEJzQkxjpaaM4Sij+4hke/TXb9oN60VKoFsl372L8T07DOlBMKWEU0q
         MnTf+RnewEZ1MnGMtcIws0cgL1T/yCYGGBTn12QvhYPcALqQknMf5vmH9/A0ftQRstr9
         s/SqtCn4+naPwGx55clDSNl/MePgUlIYdzHryGqRfijAFPPVBVGD8Xb9OZlfI6LJohxy
         rmbaOrcob8i/xFwgnD6GtPLY+gyFZriASfLdzh+5cOdRQxwK591+DYcsKtxlSec3JBfz
         WUPmtR2/2pdn1EpcoGx2GVrbS6U04J+VFJlecIepWtTqms3wWo/h/GsiWoKLgpLG9y5y
         ZVVg==
X-Forwarded-Encrypted: i=1; AJvYcCV9cS7vqKWAWCcQb8gZQvMHuokxTaE1G9VyIdi1a1mZTKS+o47jMSW6QteAM7Fa3JFrRAO5ZGown+p3yi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcsE2i+DRxaMzI3ak+gow8WJTf05rgkE8DcLDvbY2iMPz8CAhm
	C1HCGxNOIobvg2uidRLb18O2cCMP/s/WPaDy/0fZUnXGAX3+vSuA
X-Gm-Gg: ASbGnctwE/nk3wGcYSQ1ytPHCWjmmMDMGWKyeGxMJ+JX4cufer+5ithJNaDdlmhqLGU
	oTzTcKK362RsB+dwFlOzDkVKyxOiN7cRndWW5JecoPIIyqlKw5Ib2r6F5ZOB9wden2KCxhcEFOR
	su6pAw9PyqjRmk24Nh1k612FR8M0k3dpO4vYUfGb6efDzE/Oglb+AlJEzrRAfyjjGfydIUdMyRr
	q5wMV3bJbsl2AoJMkB9NpDyFlJnLZakDJCBeEJrquAjLYReXBlJ71IAtNQbiGvxvJXIn/2VB+Bs
	JurbvNAWai9v43UAxLlZd974O+vxHQEZQiPV2x/tgA==
X-Google-Smtp-Source: AGHT+IHDxsjYASSE9b+bzZNilOFfJqod3I32o0Ynht0qVmZ9UCG0inBB5NLljmSHsOvDoh7PZRtFqw==
X-Received: by 2002:a17:906:dc93:b0:ac7:9835:995 with SMTP id a640c23a62f3a-acb381b067fmr29335266b.5.1744745350469;
        Tue, 15 Apr 2025 12:29:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd262sm1157633966b.136.2025.04.15.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:53 -0700
Subject: [PATCH net-next 2/8] ipv6: Use nlmsg_payload in addrconf file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-2-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=leitao@debian.org;
 h=from:subject:message-id; bh=DfIBCMT+6BUsIC40qa/OF087bN/29ObJUmGCZa0NpJk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOBh112PYvRcXwd6GVmpZxW2pBffAHCKmLE8
 CdfZalBlLeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 bSzRD/0Z1UhaagcylfT8dUgVketr1F4GfKI4lfHfevrS+AcmLCD2Re4EnMz13u5AdHEJeb2Dqpb
 S0hHXKQC8zLBqET6UPyyhTAj/wNuifJvtZj1bxA/wiwUmYP4d84uNqO/kR+t1G3QrF/5r5yi6Y8
 OQM1ygnb8tS3h4ZbviNGSe2YXitDVZMCPpXfaYMOk5mQpgU2sUGWwrRHdwCnVKJdCu5Mt4dHko0
 aDlZcKPFtQzTGbCBT0K3EGO5nwD+NjntAIFc1aBFGED4xRXyxxcnp3lV2NstOEZ2qhsKpKMR614
 3p/o7xk2iIFlHuvXXj9rZulWIMllXo/V1JRgAvwrCzzrRWIWuTfbCNywSuoCxAboyWG9ykV5fm0
 UK8znz+gqcexWXVIk2OwLZ7o4cVAoAlr63fA3ARgczTEsYANkOU74+WzCZXmi+cwUO/r/W5zrMS
 7ROmeHUSAGsWH5naqn1Wl/s+trRsRnqP0LCfvySFp0cP6r6KOFPZdNMfReycXiEe7toZHADsMUP
 SfKDN0mowilTFIn6bCcmj0ojRPz0NEFBG5EbClhuMLikYTX8G7l2zwVFEXEP/xTzA1YZAm8eXPO
 IyRJyJJqwI5MnbwCCMeWJDtxtffdRY4Der0mbE5cX7RL7aKCA6YcZyjPrMVt+vpgjWpJ5+8+Czg
 AwD2Bab92TX+Mww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4af2761795428..ec6c4ca6d6d99 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6112,7 +6112,8 @@ static int inet6_valid_dump_ifinfo(const struct nlmsghdr *nlh,
 {
 	struct ifinfomsg *ifm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for link dump request");
 		return -EINVAL;
 	}
@@ -6122,7 +6123,6 @@ static int inet6_valid_dump_ifinfo(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->__ifi_pad || ifm->ifi_type || ifm->ifi_flags ||
 	    ifm->ifi_change || ifm->ifi_index) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for dump request");

-- 
2.47.1


