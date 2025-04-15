Return-Path: <netdev+bounces-182980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB54A8A804
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C924F5A03AD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EAC2512C7;
	Tue, 15 Apr 2025 19:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88E2500AF;
	Tue, 15 Apr 2025 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745362; cv=none; b=F7N6dR2eXe5LU30SU/vD3S0GMaE03CaOUz6r4n7cu2kQW/xYGY8rWlebPAQrn+m6ZRry7qSpXKXpkMsrb5mS9FJfju4oNHSQjJ8hYQ+NAG3vdyvhxnqkwSsDPmZ9NNmFUAV3NvWpqtebrRF6puUQjZD+Q8RD+5XqQeomEcpdEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745362; c=relaxed/simple;
	bh=OgrBYJChauo/HPg7YP4x5vW5FU/rpTEOS7oljUwK8rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTkX0e9HEHNr3t63e/ZItYunAbWKVh37mPHu0gKAAzrvetUwziHhicCP5H9l3muPGBVwwnojW4rhmucR/tWsQN76QDAGOGyRqJCJXsErlc3Tc7A2cnY/yx9yC3LBfZgMjuWa9z8Q2StTwbvpSuekwvUJW/O57gPFnwL0Rwxl2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso1042725166b.2;
        Tue, 15 Apr 2025 12:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745359; x=1745350159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6hvu4BsV8Pf9sNrCipl1rnYTmbH/rxrZvF7/I/JnHw=;
        b=DJyYG55cFkx8/YGCBfj0xPCmVQkNqS6tB5cLqMtrSUJANrq0PzjTvbLdwYjX4OqXdT
         0/RFViI6ktzQIPZLj04l+g5px6nHBbVTceIyaoTItPK6FpNT4fohswc8LVGy0AyPOIPO
         C2yCOk6bQy+rYVTeQ7iUEYVY8FprFzGfZXsGIbUDZ+sixFVjl86ih7el1lNWv5zxvTbx
         yIPCQQyZ0kO05v+Tah2HL5OyLOhtM0fXtyiP1yPYOCvEFd2Xd/MiF0cC1Nj6WPe31zCJ
         GVfksI1T+zCgLaqJgJcO8FNpIOxaBtzzrdSKLlfK07MAbIWueGk+HikWNC3nFW3bqH6d
         8U4A==
X-Forwarded-Encrypted: i=1; AJvYcCU54nYcG8kPSkA5PDL2QQ53/hTLEuOjPxkU9eW5pNjcO4Al/eJ5GJ9jiIZzwPsk61uq1YW9FrxctJE+bio=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHofTdmcqyCwIb3SLvXEZNpd6J75a9DP4YGjWFnpUDMZn9fZL
	3zIzQzkPIJfogerlvWshV/JjsZz0fDzd6oZE/dk8cUUTj/qoq0z2
X-Gm-Gg: ASbGnctcJumICfshQScBnLsOeh+6bcP+ZQJt7Ji81RNboMymUNl3zJstiSpFvW+QFWx
	K7yPAbi+s7Qxk+b8qvsiY8gU82A9M04rPXpT4zC8y7kxvgJ4kOULIrHN3jDy8Fgs9y8+R7WklZH
	RQK2S914seLCs1KZbMex0h0uHlsXiPQbXZohtSdIrP8p8swft4sp3s7O84aiNuxXuxC5kmJAh9/
	RC1beS1QE8SD8OQ4f3cf7qwsULHFu8YCFkWusf/QvEeojqBUWv7PH+m6dEqF3HCL26vsg8kAeZ+
	L7cQ/IE3btTK5bLtaRy+eakmdPkORaFD
X-Google-Smtp-Source: AGHT+IGVfUJY7W1XY/WBNr6AudkjRfbjJR9dZA+ebNVkkbGmeuRcsY/9F3AKwsFYN6oIvfdsXAxr9Q==
X-Received: by 2002:a17:907:c807:b0:aca:c4a6:cd90 with SMTP id a640c23a62f3a-acb3818e421mr28861666b.5.1744745359175;
        Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce732dsm1162393166b.171.2025.04.15.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:59 -0700
Subject: [PATCH net-next 8/8] vxlan: Use nlmsg_payload in
 vxlan_vnifilter_dump
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-8-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=leitao@debian.org;
 h=from:subject:message-id; bh=OgrBYJChauo/HPg7YP4x5vW5FU/rpTEOS7oljUwK8rM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOCEUemxTQJ0FDQkWPxEA6SxvBxQkovRNSa7
 cWLckBmgDSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zggAKCRA1o5Of/Hh3
 bV3RD/47K97tUzXRHFT1jK072Q9PeGv4X/4956I8jmYt9tyzYwDRYiocnRf2zCWf4STa7o3OMSW
 C8hHVG6ZVDopKtD1qvbkYRseEjehPGKNOM0505K1oMZmLoqIRmRxWq8A3isvFibavBqSLtVe0Pp
 ACYIEWyKYbHJ8oYOjbfdgPXJpcGbraxjMjYt1eDFVCcwdIP4gJ4IUdJCQw68Lkihy7Wr7zjmu6s
 pq5SlvzEvWK0HVJWidovqDeE7ZajFVPftAdsLDNEn4c8Dw7hobgjq4IzYGdeEx4wnKT+U0bHpEO
 QkIS7/9xhwdqdTI0S2UJvTXUlX3Stigvk4Q7fxoisu/XPakV+dCL47P9SzTpi7eFpFYZHe9FLBV
 CUOsdq6chW6fm+8JnMZ8b99VG4xI+l+3fFWuWp8tRTI0mq/BrnqwaN4HmEirSx02gpdpmiBN407
 hk6QMOKL3DW6QMzaYvx+S+6Vt7860dynu1afFOBjdFNAsAOmdJ1BRFE+2yYQ5l9TqOe0eGQCM3d
 esKZ2Sc5Jv049l+tK+IJgLufeICCfTsTb2oua9RVBL4aZuS0Cr4Wh4ZzcrwxanjDgyN1hJpgiBt
 faeB3T76cerrlBtUXFGrzZ2xf4ImFsccnUAnZKfpArdKwsMEKVdnCeIWwm+a4djnAWLGUd8o4LR
 NIZEwq7WCPGedVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 6e6e9f05509ab..d0753776d3394 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -411,13 +411,12 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	struct tunnel_msg *tmsg;
 	struct net_device *dev;
 
-	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(struct tunnel_msg))) {
+	tmsg = nlmsg_payload(cb->nlh, sizeof(*tmsg));
+	if (!tmsg) {
 		NL_SET_ERR_MSG(cb->extack, "Invalid msg length");
 		return -EINVAL;
 	}
 
-	tmsg = nlmsg_data(cb->nlh);
-
 	if (tmsg->flags & ~TUNNEL_MSG_VALID_USER_FLAGS) {
 		NL_SET_ERR_MSG(cb->extack, "Invalid tunnelmsg flags in ancillary header");
 		return -EINVAL;

-- 
2.47.1


