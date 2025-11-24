Return-Path: <netdev+bounces-241141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF6C802EC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3544E6506
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B612FDC58;
	Mon, 24 Nov 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebj1QtEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F542FDC43;
	Mon, 24 Nov 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983190; cv=none; b=XKXG0WNSx55CjISC7ENVWsS2XfjRJf657359KDYZMr2GLYpSU6Ogrg38k53JvMGcc5D/uOq6MW5sd0q+lPmXKjh4eP1WUdrxMsm0g45IBkM38M2WshxNVGmuD51HSSNiXPff7nbjHy3tfE8syFNLdupxQZZNZPMaBa0kL6u6044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983190; c=relaxed/simple;
	bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oE/AzvtvTlBDULwrmMRSDdKeybxUuMvaMAwuJCKmRLDUALdT6ddhiFljpUaADIV+2xR2+FVVLGrhe4ZXHD2/t8liFYzB47hQSzGhhSYoujjRRm7KzjivxgnO32NdZ3tBr2KIo+e3DYKBrc3jIRtNx0fG2EHSmvJWi5ZpTl8kViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebj1QtEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D10C19422;
	Mon, 24 Nov 2025 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983190;
	bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ebj1QtEo/ND2pMi73mjwyELohJaW4fQMNLq7ZSoZuplsv+QCdvTWjiZ0jdBuAtKKr
	 LBjoxB3Mc8d693XwZpsV+JGzLZKOppL7uuh66/q/dizq9fm1KnIPAduyr5zTBOX3Q+
	 MfT+fwYfbzF3zWNMYL5jZnliMZ3lmtZ7YONTo+bpbpOHP6vysRhePbaaoN3gTEJBWf
	 hzY6P7SrA4955fmTNpxZBsTI7jcRUeEWjXDC662d2rs2hyCOUKMPGvrTu3IpzGMcsw
	 7OvfOxsjAmiK5Lkpons1DuKGSS86v+4TgpZaBfj24BoKEYgYwR6pDAU4p/IDqFFtbY
	 u+UC1pGk0uErg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:25 +0100
Subject: [PATCH iproute2-net 5/6] mptcp: monitor: add 'deny join id0' info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-5-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bOQsq2XrOhtU0EBb/p1+2MsayISWWKNP/oCn0/irc+4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7L2bFjyduMDG7Nffx23992zYn/IfStNjkDq7e+PJk
 K+BVv8ed5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkCy8jw2FTP9kt76zMSrf9
 mqt9dSajIv+9tdYPLzftPHt/q3bf5nxGhmOKsjeKmycd/DBf2+hlG/8lLgEBVd2SmcXzTsslCx7
 24AUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Until recently, the 'flags' attribute was not used. This has recently
been changed with the introduction of the 'deny_join_id0' flag [1].

This flag is set when a connection is created and the other peer set the
'C' flag in the MP_CAPABLE packets [2]. This flag can be set to tell the
other side that the peer will not accept extra subflows requests sent to
its initial IP address and port: typically set by a server behind a
legacy Layer 4 load balancer.

Now, when this flag is set, "deny_join_id0" will be printed instead of
"flags=1". Unknown remaining flags will be printed in hexadecimal at the
end, e.g. "flags=0x2".

Link: https://git.kernel.org/torvalds/c/2293c57484ae [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index aaacc0a5..01f6906f 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -477,6 +477,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	const struct genlmsghdr *ghdr = NLMSG_DATA(n);
 	struct rtattr *tb[MPTCP_ATTR_MAX + 1];
 	int len = n->nlmsg_len;
+	__u16 flags = 0;
 
 	len -= NLMSG_LENGTH(GENL_HDRLEN);
 	if (len < 0)
@@ -526,8 +527,6 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" backup=%u", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
 	if (tb[MPTCP_ATTR_ERROR])
 		printf(" error=%u", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
-	if (tb[MPTCP_ATTR_FLAGS])
-		printf(" flags=%x", rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]));
 	if (tb[MPTCP_ATTR_TIMEOUT])
 		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
 	if (tb[MPTCP_ATTR_IF_IDX])
@@ -539,6 +538,15 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
 		printf(" server_side");
 
+	if (tb[MPTCP_ATTR_FLAGS])
+		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
+	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
+		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
+		printf(" deny_join_id0");
+	}
+	if (flags) /* remaining bits */
+		printf(" flags=0x%x", flags);
+
 	puts("");
 out:
 	fflush(stdout);

-- 
2.51.0


