Return-Path: <netdev+bounces-95418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2138C2306
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3647B282179
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36D171E4C;
	Fri, 10 May 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5OW2fI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA5171E41;
	Fri, 10 May 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339958; cv=none; b=X5ht7OkrKCiN1mW44wXyhnRnSCg4iUtgxqtdfhgVd4F3EYHPiyCyKPXYtF5CQ95iKdl3wVWBZg8jj/hHeuDfpaDMhnNsNHCDxn41iM5RMuSr3l8YfTyhos+kEdmvmDiE+/Iui4Gzo8af7TfYRBBEKq4rHM2OAv35ReunzWF7x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339958; c=relaxed/simple;
	bh=6/hr6NKWVk5ktON4L8zlBVjlDBR2emmr9M+/RKd+Pms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDxN4Y5Zebna3157QDUHxBOcEu1X+W48xQEhZVIsG2zqF1Bu4C5INFdpDjR3d5xXSUQBOexbfXVNOQTKebpt0C0JZ55AYquAVUXbmhGbtlgYMOK6Zp5gnl/8xI4ijn+c7uK2oDFWRLz4T0PJKkc//6B8V882JW5lX0GTyA3jEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5OW2fI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE2C2BD11;
	Fri, 10 May 2024 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339957;
	bh=6/hr6NKWVk5ktON4L8zlBVjlDBR2emmr9M+/RKd+Pms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C5OW2fI/fGe9x33M0ewfh2YfkWUOM/q5zIMqaQj8V4lADMF6ZrOCXD/RtHvWbHoBn
	 VR/DKJlrFJivzpkIe5uJEWmkTCWiEeaZcn+KhR6tG+C4+43TxrkEOwkVkHKOadD1CW
	 EzzK7WG+6CAW9+hnGqkSp0WeTbaRq74TEl2CjfK4qkCCrzCKiiQlN5WweOk992lcPM
	 HV//z+zvwNJsbLXIaK71RSWxS+NprZJSCbzfeIsaCHOI6S75L5z42takNHwMzhcf9E
	 Rao6QUxpwv2YOl7pkKe3zeFMJO0qBbDMg+KRvVtVuQEwwybwR/xZvtdueRM+xn68S1
	 DhTh2MbWr/jAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:38 +0200
Subject: [PATCH net-next 8/8] mptcp: include inet_common in mib.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-8-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=633; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6/hr6NKWVk5ktON4L8zlBVjlDBR2emmr9M+/RKd+Pms=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcPo3L1SVb73QC7nbRWCJhmgtvOCR1VhoGV
 yxh2JYims6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c9ZsEADaaL2em1xg7yqRBIWbfmc3hAErMgb6bkhT6qo6Ooy8fHtrCRCS7ohC7JePoKgsE2Uol0/
 EHmd4yuOBmI4xfTTY4mhrGsIbTDquZYoJDVQ2NDuD1AHMXvj65BwzfKJHPs+b8iD3qZbbB5Ty8D
 qcAG2zKt/JIGBpim8U/ysF5rnOhv6szQpd3JQcCzGqYySKza8v0MLIYpI3c6qVMi40RzuQxr1Cr
 fd4oYiIPrpp4e3TWFjuZAdW/dcwikiVTSfNMfi2vJYeN2tP7yonS4i+5dRQlby2bJHIlX5KOdPp
 rImjbCEgwZMu/K+rTpQIeXHdzcgIULkPO53D21+kt0WGvYALQK8iPgNIIJMtf0uoPamYb9T5Yv9
 8Sf2RsfC7H6DngaLe1M46cPB+U6L3spT1rVEoYSXdsfhHIaKP57Yoa6cVtBo+5LijdczAP2fr8F
 /X1DoWNil12dSit2H7kkXpGm0pLDCH3BgvmRFG5Oau87W7nOPW9NcmamFpqGGNjR04aiE954j+R
 N71t2KXZ6x4kcCdFlJixpQBNv5S2IEhBzaA2uqUSA/V5YsmIqZWCHrqWMVDJ0ceSacVWXQQmDhA
 ECvWzpmb8v05TgV8sRCK88zXfE97NzQl5In2Bs/CKk252lJbgU5mAhgWXahzHzZfx3YuHPLIwCo
 Sb2c+8m80MZE/Lw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

So this file is now self-contained: it can be compiled alone with
analytic tools.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index dd7fd1f246b5..2704afd0dfe4 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
+#include <net/inet_common.h>
+
 enum linux_mptcp_mib_field {
 	MPTCP_MIB_NUM = 0,
 	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */

-- 
2.43.0


