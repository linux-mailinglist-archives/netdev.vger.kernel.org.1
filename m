Return-Path: <netdev+bounces-113368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7593DEB1
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F60283996
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C986F303;
	Sat, 27 Jul 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuksPL5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21209537F5;
	Sat, 27 Jul 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075152; cv=none; b=iKZmw4SEHtJh5f7X2CyIVm6fKlAzCYEL4wMA7YpyGAE5aWWaQO5OJa3efUYCWrzZ1IO7UyKslfVAGNeUC+3Yg3yzmh9t8S9BdYKtbfBujty3qyWc/1enXVnvtwbDmqz7IO+xWaTIzo4UgYth4fFvqXdmxsQVCjjNA7+k8i3GDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075152; c=relaxed/simple;
	bh=siha0gETqKkpCOCou11om2FKnFkBx2msg5ODXag2Kms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI1QmJuSCo5NuNoUfiefEsuvKspe4j2/By+l+HYADu1rJfkFAsEkrisAxmqKXZR/0Rca3uePJI2rSk9gXrI8rAhv7Z8OYtv46y/bOaaSmbC4nl/u0ptMcNuqxYiAo34363B/j/Gkn9xh6FKbDivXPQsWnpWFxXsULRqsCpL4afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuksPL5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CC0C32781;
	Sat, 27 Jul 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075152;
	bh=siha0gETqKkpCOCou11om2FKnFkBx2msg5ODXag2Kms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CuksPL5+LT138DBvawSof00uLuOmI5g4+FM/OezHw95tgnoACfzQq2H0TWk20fiOP
	 8X8nvkcSPslaUmyvQGbgjIfmWYO05XucMWP3DZ0CgqpX36762D1NRIduHrnTzpckgp
	 m2fRDaQBEpbl8dXftViFI45k8P8W6LICPmIdurBDJ/1vcLXy8I2CwQlwvY+itHtRj4
	 HTYxckdCaiC+pEUojgiQvqa0BhzuyTUAA5VcAeSQxac36vLWWMXq8wuYv26mccX0cp
	 ArZmbqKMx0BWA1le742IWsln2tNxlmk6CIEa3gou0l+8dJYJp1hhv9ikPeHwQibJoq
	 aF+aDTRX3RyCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:36 +0200
Subject: [PATCH iproute2-net 7/7] ip: mptcp: 'id 0' is only for 'del'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-7-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=siha0gETqKkpCOCou11om2FKnFkBx2msg5ODXag2Kms=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgAAkXNwMnF2/o1lLBKtHNqd7mMVSPykdvM6
 17GT5/FGWGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 c2GhD/9qhZF5vhSE/4HyTz3W/pxrb2JLC0E5NP8vOvgeGyJpDFOqfHXlKh9OXXFZp8Kqh1vuNwH
 KIf/BCDYNsnMsnq2P2btv0v91LQUvXttGKARFe/SbwbfbXQOvgTEnNtMcwGEL3Rpo/dpO9t0yt4
 /WbpExsdfp2IpK1/31XbvDodXUpdOtZIPCo74zHCbuW0roYJtotk8B9xariuwhYccptkHYYqxAn
 zu0j9ZH6EG652SzTibdiXcOdTBXmhWbB+fC1W+uNJcwHHAGd0Z1uk+n2Z9wAH0zBpiddLVP8IUa
 EiPXTCCbIX/c0bk0ZEhyR3rBppoaQGqG1NdHQPKszdplVL/KUV40QJRi51klIeJQATeivfJCnqH
 lZBZsRHCKTgE2h3f3hctoY3h0A+vYNkHfVDmUh2Sy49JDD4Vjq2O2x1P4zESWE4K8NrLqEYDfXD
 rb69s8wwQ/vRANDLDYpsL6tJRCMBJY8+ZSUDt1kykopdJxYpt66UMDymQUFpcK8D5fvARXEC5HV
 GtLvZukjnUJQGildLsbgOaWf/shTqLk/jEU0Q4o7EBsVfTBztL33Rf+gh9ULNGg5l2nTswNF+83
 8ylDuWxTtx5UBUUSEysQh+lL1JZkQrYZ8pfSRobJQz/w/XZuyKhKVKOrUIBCPLVBqaLIopy078O
 vxs/TMDwtpCcIKA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding an endpoint with 'id 0' is not allowed. In this case, the kernel
will ignore this 'id 0' and set another one.

Similarly, because there are no endpoints with this 'id 0', changing an
attribute for such endpoint will not be possible.

To avoid some confusions, it sounds better to clearly report an error
that the ID cannot be 0 in these cases.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 9847f95b..118bac4a 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -174,6 +174,8 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 			invarg("invalid for non-zero id address\n", "ADDRESS");
 		else if (!id && !addr_set)
 			invarg("address is needed for deleting id 0 address\n", "ID");
+	} else if (id_set && !deling && !id) {
+		invarg("cannot be 0\n", "ID");
 	}
 
 	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))

-- 
2.45.2


