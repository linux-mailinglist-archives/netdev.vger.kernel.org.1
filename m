Return-Path: <netdev+bounces-87320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A38A2924
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829D11C22032
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A344F5E6;
	Fri, 12 Apr 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwZv0Qi+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641B4F1E5;
	Fri, 12 Apr 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910017; cv=none; b=Um8YcUdrK7b8AD4L5J29nGJdbhBb+2hCX6Cw53v5USXmkt19XWLcZOj9vvmMpFqYyYw3aBTKfrgLVwzikQXXmpQ3ulQbyqKuUraE6DXXeSC5Bf/PQmUDLiEwPwcLHlWUi4PbYsVl6NNczMb9PVVgIzQ7BSmXxM1IaXNo7LVwtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910017; c=relaxed/simple;
	bh=BpPsC576jT/hFv4s4WL/XpSNwMDP08RHf2v/qnvEtE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AujWE/VVwEEs7l8rRMxVKoiTpSDDJGf+eb1nNuILRybk4zvzkh7mM/2PU7wrvzstbyF2bnjFdSCEi8mvDq5laBgtTLUEyAzV6QivoWEk2Xm1pvup+6jIyUI1DuoQz2MHX8TKedmJUXWqNTsDPyFAGDRkZ/IPqXbUKEKiaCPTqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwZv0Qi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A5C113CC;
	Fri, 12 Apr 2024 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712910017;
	bh=BpPsC576jT/hFv4s4WL/XpSNwMDP08RHf2v/qnvEtE0=;
	h=From:Date:Subject:To:Cc:From;
	b=LwZv0Qi+LzViGwgyWbcQGgRtyjLucHRObXbvA555c7LXSNk1ARxvUfpMbtP3xgy+W
	 oPsibri48fYsZF4oJz73w+VnMOIpIPojNnKETCWz3AvCE0ShIL7F2flwaE38CjGmLD
	 kEtU43PxQHrO1Osl2FC8BfB0ojuv4lDnHvz0S6IE/S6ouJFx+jFHkrVTJdB9VEa+JM
	 yivmA5RX7ea7H2xVw0t6ytIRvp5zIDBNUrQ84vemMfdgvjdasqYRamMRS6izi/KmmE
	 kVuAqAZ00bMv9dDAApk55YqH39U7BNhLQi8RFwqQSjykeFHKhka44Myt6QSvNBDx9u
	 Pu41wFpqB2xog==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Apr 2024 10:19:52 +0200
Subject: [PATCH iproute2-next] ss: mptcp: print out last time counters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKfuGGYC/1WNQQrCMBBFr1Jm7UAaulCvIi7GZKoDJhmSaSmU3
 t3gQnD5ePz3d2hchRtchx0qr9Kk5A7jaYDwovxklNgZvPOTm0aPizarTAlFa1mMPWbeDH8+qQX
 FNzVDk9TneS4YyV0inR9MIUBPa+VZtu/tDf5CcD+OD3BKERqVAAAA
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=peEZPkCHANfDFAZBTs/k1zY2RZcbXFVbmdGN61yaLdY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmGO6/F6YlvRUHp4hH1Fz5aEMIVph+unLpj0WzR
 AYt8xlkenKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhjuvwAKCRD2t4JPQmmg
 cxezEACq5hKrWRv32luqJbErk39Z+AocHlbyWmCoGUMJqzdOimON2otIk/KJQx72zhbWbRk4O7i
 evOOf13xBn0u0f9heO6gRHA5RtZ+epa7q30ekTWNG+yEICrpKR48E8UDi0f85Tb5kJUyaj2p7rd
 1ymiDMOlHLfceB/oAMUvqjwJlWX7r4UTkr/KSRwHHnK7QtsDQlFxJCsvIUQcY/vAPDiUVK5ZEfF
 pRBPOLY6I/VmUI21vbv+dEaBecfbp5SZ2GQ0ljzWHK/hQUkL79VCByElcaLHiUIVdNfUgU3XajY
 ov+REAwiPrH3OyFo55Yg+1OULD7fVrwpK6NoxEPAt/h10iX79TrdAX9uhxMmV0uVuez+XIokSD1
 4a4VhZlf8U+jQtefWlzGn/Cdd3+QkZ73EVQnTFDDc9/5X71FDTTb/uF35mr6ca3cImu0OKdv61u
 vMIFEJ2wXy7S1XILS7fcW2ETD/0mDgSd98cFYwL+3rjnZ5HOFCJ5jf5N5kQVzmElf9eg4ee2bBD
 ktLqc6NXJbMskYfAKi8xr8TnYPBCNwhzBtirU0Z33Or20dKz5bGPRc3DMoT30k4jqTkLaviFSiO
 4dyOwC1BkQ5J+tSDAd4owEODTAneLEi/0pK13pqFMM1xL+zhcBl2dNV/liSIKuUG+2KxBeMkMoc
 ZbMLv03+Ea4gw2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

Three new "last time" counters have been added to "struct mptcp_info":
last_data_sent, last_data_recv and last_ack_recv. They have been added
in commit 18d82cde7432 ("mptcp: add last time fields in mptcp_info") in
net-next recently.

This patch prints out these new counters into mptcp_stats output in ss.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 4 ++++
 misc/ss.c                  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c2e6f3be..a0da2632 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -56,6 +56,10 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/misc/ss.c b/misc/ss.c
index 87008d7c..81b813c1 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3279,6 +3279,12 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 	if (s->mptcpi_subflows_total)
 		out(" subflows_total:%u", s->mptcpi_subflows_total);
+	if (s->mptcpi_last_data_sent)
+		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
+	if (s->mptcpi_last_data_recv)
+		out(" last_data_recv:%u", s->mptcpi_last_data_recv);
+	if (s->mptcpi_last_ack_recv)
+		out(" last_ack_recv:%u", s->mptcpi_last_ack_recv);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,

---
base-commit: 7a6d30c95da98fbb375e7f1520fad34c1e959441
change-id: 20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-da09da8beacc

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


