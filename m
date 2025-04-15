Return-Path: <netdev+bounces-182973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F336A8A7EF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45B4440B7A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DD24CEEC;
	Tue, 15 Apr 2025 19:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330F24C66B;
	Tue, 15 Apr 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745353; cv=none; b=U3fSWwo8FNdcbgO3ZoXU1Krm4Djg1JgRQ7WH+Kq6pV3iM3G++JQcX8I6lQuvgsbZvzl8Vufm6Oz8UqanNXrkZlmr3q9grqV8ZmC8X83+xxLIA5lMPVVg1YlrLZFw2c61RrhTFWcSvQnPmtdyXWokHtqNh0Q7YiXUk0jD/LswTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745353; c=relaxed/simple;
	bh=/0qEeGpvJtlthj0XEvHQzTGeK6rzfScWYxxhJaNAFBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szJOxyBFHIx6RRYLSLnSIkeoVNda5gGOqLxNaE8PRGV0FyKai5gTSbKVZjv/35tr9WwpL4Q+F7JG0U4vTJnbM/jOMOXRyGtP9nhdTXzaZFhW3xRmiyFnDooUxhsKtu/oHjgy1thiO1f69LgjjSgpDf+JNOXNRcAVhTiqaPfq4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1112340666b.3;
        Tue, 15 Apr 2025 12:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745349; x=1745350149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCgtVrolqhAnENHpHb8PB2Kjmb9EPgq1lIBAqVwvwpE=;
        b=P1CqyuJBfDY7L/544r5WEhU0alYWCYwP1krDcXDoH4Gf6PFRKygRiju9ZVsI98hgxI
         69FJRLZgtxmuEWOTMOa55T/BmqSlJNoneDVhF9KCC1aujUBtq61tE7kzBv8T6bjZ9kGH
         DQsNazJFkkAH5ixlASWUAxYBxrws526BUSzcu76dTzK9hjFS7h5F+x3P27ImRXYXhvd8
         tsVTXjdyncCNLkJiFgBub1NInl5qYM5QdcVfo2xsF6i+7c4EDAAZ8UhSUVcuNdBhVC9C
         XCERWR3MHK17RSCSJZqS/Ew1QKM5ReQV+8ed6As6sbss11jr9eLKj8BBqWqXYdsqd3jX
         p3BA==
X-Forwarded-Encrypted: i=1; AJvYcCX2DrwsmOyQQ/ARrcnM136/9c514ZbLe8g16q7UegIXax05gBq72h58h8Jfl7XS4xVBPJDuzaGpICWrvGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xKO7s1IxjxA4WMQW+KYlLgJWK6sNlxJ6IzoP7VcSTQMI83Gh
	oYuG61KjMNKUMFFrqHfo+Gjc78wBB6QYpMCRGvq3lHc813Tu+ucd
X-Gm-Gg: ASbGncsK6PWodrvnU827lUpeZTglwcozgVx4rhSfuSfEa3RTFvj0X69sGuKSDPPcHYs
	OfK0f8iwXw8PrHa1hsMOXJ04NlHMf/aBFcnf5Fuat+oTR4w7aWHPDQgGxfaG3cqyr+ikzVwbtBn
	qGg+0/ZWmOmo6liED7vQrtwDZlZdLNbXQ9nO/jsdbkkXjYms+3fO+D/mhe7Byn6Xlf2xEYikR+y
	BB6QD4tKiEknyCJ32xW/iptMliKpDNUC9wSwb1ZS8BdRRbvbFUBFsmg8vqXz59bg2RyHoMfmaiJ
	FmRX9G1nT5xWpzQnWHIGLrfCc4LIPpQfwHAUqIqKFg==
X-Google-Smtp-Source: AGHT+IGJEIIWAJLdpiq1/aoVLjcDmvAfjVPwDuxdL/CF8dk5dHr5H4aRse4u7FcEchQ25PdaRUQJNg==
X-Received: by 2002:a17:907:6d27:b0:aca:a35e:59fe with SMTP id a640c23a62f3a-acb381a8673mr24965066b.1.1744745348932;
        Tue, 15 Apr 2025 12:29:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm1148483366b.59.2025.04.15.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:52 -0700
Subject: [PATCH net-next 1/8] ipv6: Use nlmsg_payload in addrlabel file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-1-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=leitao@debian.org;
 h=from:subject:message-id; bh=/0qEeGpvJtlthj0XEvHQzTGeK6rzfScWYxxhJaNAFBo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOB4Hks/uOdzS97B/+n3WvdEMT+s1o25lBMU
 Ok+dzlNOnKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 bQ8aD/9E3r86asVBGhf0yR6h0lCZhb1IfmRUmJmuKxv01HKEafom33GHvS7JHRXyF67lPJ7Jn72
 om/8q5oSc1sAVf7cpUPnBlcrK1Apj63t9HYCHznxoJ4gyz6ZlIsHn51imgKw68+vo6ScT/BOqal
 pK3DwDdqd6TQO/HC4oAvqU+feSE1oh7SY0Cb2W5OeGrTUtm11tjY9jFu4Ur6vhNVmzXKMJyKr03
 r82Nubt4fTHeF6xGwE/VInTcsmUOji9TtPa5dyjh/HPehlRKP1KFro5YsRmRiz4caibzmqPNd+X
 nEcVksGKQIf6CsVMJu4Cw+r7JoM2+Es7XomqYBRw61bgewMc9vHKtRUwiryXuIgK4MuHTtq9Hhb
 PtKwDSAfUhB9ITgqqe/KBrgpn0lrogKIM+IC1GqkLp6oeSgRj5GtNcq/KCG7RxSb/TbyoXOvavu
 CgctzYuRy6DATyraTiCQ89DyOHLu596A+yKxAK+eCklA7xQoC4LXQgudn90juywRKA9vSm/yLiT
 wXU4XT4w7VqodFVFp7IWCBlCgRkI0ebrxs+QMVSpTMUCM3zn8ZOA/Dgo2osDZuXa/WnR+mzSsyc
 SZ4cbz4HLD9rOmUrMP6COUTsvmDHIlp5dkLPO44WaH6zwJFghFVvkeGZ774j2KfQPMaU8jQuwAZ
 ES3QcgdP/+aK59w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

This changes function ip6addrlbl_valid_get_req() and
ip6addrlbl_valid_dump_req().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/addrlabel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
index ab054f329e12d..fb63ffbcfc647 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -473,12 +473,12 @@ static int ip6addrlbl_valid_dump_req(const struct nlmsghdr *nlh,
 {
 	struct ifaddrlblmsg *ifal;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifal))) {
+	ifal = nlmsg_payload(nlh, sizeof(*ifal));
+	if (!ifal) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for address label dump request");
 		return -EINVAL;
 	}
 
-	ifal = nlmsg_data(nlh);
 	if (ifal->__ifal_reserved || ifal->ifal_prefixlen ||
 	    ifal->ifal_flags || ifal->ifal_index || ifal->ifal_seq) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for address label dump request");
@@ -543,7 +543,8 @@ static int ip6addrlbl_valid_get_req(struct sk_buff *skb,
 	struct ifaddrlblmsg *ifal;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifal))) {
+	ifal = nlmsg_payload(nlh, sizeof(*ifal));
+	if (!ifal) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for addrlabel get request");
 		return -EINVAL;
 	}
@@ -552,7 +553,6 @@ static int ip6addrlbl_valid_get_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*ifal), tb,
 					      IFAL_MAX, ifal_policy, extack);
 
-	ifal = nlmsg_data(nlh);
 	if (ifal->__ifal_reserved || ifal->ifal_flags || ifal->ifal_seq) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for addrlabel get request");
 		return -EINVAL;

-- 
2.47.1


