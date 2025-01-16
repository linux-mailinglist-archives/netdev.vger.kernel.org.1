Return-Path: <netdev+bounces-158970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4061DA13FE9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77B73A53AB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2D22FE00;
	Thu, 16 Jan 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btBbeVx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74B22CBEE;
	Thu, 16 Jan 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046482; cv=none; b=IvMaubL16SF1jV0sVwToNVrGue4rAxGxSSQcCMRadybgR67zizNBfeSzlG65svMwX8h4BuXuk/yLBwU1rRtASYdMFcrEBMEaLO7tfSvOeSksqsj/RXtKdQebFMJV/zfdLmreWjMf5LcB6BH2UE3LT+n1RV8Q166lU0W0s9qLl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046482; c=relaxed/simple;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVU4QI+ggoQik7atYRZe/4yaMP5+Nm+yF6BASiQo8k9Vb7uNU/BxXPYbz9fiUJiURluDstszr5hBY55NbFe3ztygF6XSj3XeQKixJiyBX8KsLZQrw9ULRlZTxzmMiWHsQkW6VAceeXOG2k7jHHVEXZxNcKBO4lXPKYBVFlYVBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btBbeVx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE51FC4CEE4;
	Thu, 16 Jan 2025 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046481;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=btBbeVx/B1fuysYHpZEhH7jEMNdt2aNgACM6lCp5Q0hWA+YffLyrA/OOgpImkhheH
	 1CJ9IPU7b+zqP3O0CXs3W+/YZCnAxk8vB3MHk98ZwL2Px25/rdC24pu9F/uonq47N2
	 ay6mN6FLlzEWk0zo4nc5MvDN7cTeGRqnOw+O56QVIk4dcaTV2Dd4nRh33aNuhlIVSj
	 2gvmcDxOuAuihInoFJLU62RICDiWoR97ZKB+7FWqF7eXbCkZXmInKOANpMAptpz9dU
	 IvsRlYSNfTIT5AR10QwVV/SEyfkUFZC9xwawEcEzjUPAmFJNcjkcmRsdc2Adc+mKP/
	 +cMwqH5/BeKmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:25 +0100
Subject: [PATCH net-next 03/15] mptcp: pm: more precise error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-3-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnG5p7BZzhyXeOBcJOMYIC0VKj7uIo+Eq/vA
 /HfLFgbB7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 cyL0D/99IRidY4r9bsEAuJusa/tUeU8VvT9pcdn7BtM8Roym098NToGpxGmB9z0j5G97uUctqEc
 bvyC99NohQQpkCNO0pZ59PcT2TkIfLt3Nw8uCgVsyfLGWTFTpoEKF3gwfLloOuWEMQ5MFNQLeOW
 WZRx2WXpXDaVOtQ7RIWi+SXMGeALx7kVd0z8gs6gfSkCPi1Ykah0chmAArmX+eBav7NN3mas0vx
 TgFjUylms7oPIBp7KXNFH/dq0BsXrUKNOv9/aTfw7O0pMSrm5GrptJsFf/w2egJLeq1QHZC/P3o
 cb47DDX/dnucrMGvmxIuvc4ugCmL2OfKJlcmjGUoUEDJwcUKKfsKSULDHaAv4wxVmcXfKC2rH0d
 dZW5LjNLinWY1dY8yIZjOYoyBnG5e0gY8IghdlyxrOZ/bt4EDbqMnQz5FLdG0m5/TFPsaLLiccj
 PutRPcpEaGb+w+7dixCLKy4wFm3+hzw1Z3K7wID5/mFA+F1n5fZXHQhAjVCjXsY1yXelTmFyLhi
 Jxuu6N8NzEKQea9tZq1JHlnDsIXxIecWYIyZyoUxQhcghku89/VfG2248EQGaebmgUWR4Lv+fM/
 SRzKB3RgDSwIUKxCd8RJ/yV4eCPeVS2Qf1veyBTJ5jO7aXCOTj4/H5oJRaOD609FH9rWwMPQE2Z
 9kKQdqUEIzfyxEQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

While at it, in mptcp_userspace_pm_set_flags() move the parsing after
the check linked to the local attribute.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b6cf8ea1161ddc7f0f1662320aebfe720f55e722..cdc83fabb7c2c45bc3d7c954a824c8f27bb85718 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		GENL_SET_ERR_MSG(info, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -531,8 +537,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		GENL_SET_ERR_MSG(info, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		GENL_SET_ERR_MSG(info, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -580,13 +592,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}

-- 
2.47.1


