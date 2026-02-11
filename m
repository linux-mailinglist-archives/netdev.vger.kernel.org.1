Return-Path: <netdev+bounces-258270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM/nACpwjGluoAAAu9opvQ
	(envelope-from <netdev+bounces-258270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:03:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 914BF124114
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89A113007882
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D2329C6D;
	Wed, 11 Feb 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+ZXjyFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02273254B8;
	Wed, 11 Feb 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811429; cv=none; b=Z1q0Bz6VtDmsYi1+CP4VfZVMuVOjF691n6+1COBpUPJRac4oqwND8sPj9p9HO0AMHH2NKFRoxvv0bSPlXpmMjhw0IGPSUipG0hsHPzA5rRr7dYu1j0WnX12wEI89wnFBDUmsB1/etDIzyPWqNWzHt8XTEmX9wBVLqg14BTNdCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811429; c=relaxed/simple;
	bh=4Y2UCoSWSRuaxLv4DmU6PPatIlxyrlwrGRIRs4c0HWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMkD447BJMOIzDP15i/S77cJUPclOMYxAZfwuqIdg7c4IreV4azo02uX29ladpiBAVD6RB+sxbTz9UUjEMvfdAHQbFmDshVn/m8sbYghhgWKi+Wk2FPpCTr+eGumSK2Nc4tlBZ7oMq5/Aoa936INaTqSC2eIq1R03yn8lsMM3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+ZXjyFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78576C19421;
	Wed, 11 Feb 2026 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811429;
	bh=4Y2UCoSWSRuaxLv4DmU6PPatIlxyrlwrGRIRs4c0HWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+ZXjyFNak01Y69qbNBG/+J0ojL8mad6r/CRux0oRe1AM8FshYbXqiPMzQpNlN+fZ
	 wrXjrrMI9nPf313JFIcfufKbkGCJi0Tt6myRMUDACYo6DCTSJFWqCMIuaY9l9+TNEV
	 yCw1rZdijxKlq7HuYvBi2uOBlLxlsOJVUByG3SzqBcN9KxJjc9u+VVK0ttFSyNjSCy
	 wwNqDiU0vSIoDwLVXXbbOhQ5n98W5i22qxk5VpSeYkHTwCk0kzLtNVXVPtkmmUiyOU
	 kxtWLb6lsazctdw7SIbVP5miN9rLAUAVUX0T/pfs/YjKjIyJ2KxdcvMGjD0TV7AwYx
	 XGqia+tjwDyDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Feb 2026 13:03:18 +0100
Subject: [PATCH iproute2 2/2] mptcp: display addr & ifname in color
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-mptcp-color-v1-2-01832777611d@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
In-Reply-To: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2339; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4Y2UCoSWSRuaxLv4DmU6PPatIlxyrlwrGRIRs4c0HWc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7ChTfuJav6WnLOqw+43Mpb+L2kLNuMmvdu/IWTjOwe
 vW0S461o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKWExkZVm9xuyzCplFxfmun
 9drNuz6Jzpy72lQt3uSw+12zuRr+jIwMF7ZHxzQytzadWLL7w1fZIp6FdyYunro25JmImdX8f7d
 UmAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258270-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 914BF124114
X-Rspamd-Action: no action

Similar to other commands, now the addresses and interface names in
"ip mptcp" commands are now displayed in color if supported/requested.

That's the only attributes that are used in ipmptcp.c: no MAC or state
(UP/DOWN) attributes.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 5f194aca..ec9ef62a 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -243,8 +243,11 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
 	addr_attr_type = family == AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
 					     MPTCP_PM_ADDR_ATTR_ADDR6;
 	if (tb[addr_attr_type]) {
-		print_string(PRINT_ANY, "address", "%s ",
-			     format_host_rta(family, tb[addr_attr_type]));
+		print_color_string(PRINT_ANY,
+				   ifa_family_color(family),
+				   "address",
+				   "%s ",
+				   format_host_rta(family, tb[addr_attr_type]));
 	}
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
 		port = rta_getattr_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]);
@@ -263,8 +266,11 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
 		index = rta_getattr_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
 		ifname = index ? ll_index_to_name(index) : NULL;
 
-		if (ifname)
-			print_string(PRINT_ANY, "dev", "dev %s ", ifname);
+		if (ifname) {
+			print_string(PRINT_FP, NULL, "dev ", NULL);
+			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+					   "%s ", ifname);
+		}
 	}
 
 	close_json_object();
@@ -467,8 +473,10 @@ static void print_addr(const char *key, int af, struct rtattr *value)
 	void *data = RTA_DATA(value);
 	char str[INET6_ADDRSTRLEN];
 
-	if (inet_ntop(af, data, str, sizeof(str)))
-		printf(" %s=%s", key, str);
+	if (inet_ntop(af, data, str, sizeof(str))) {
+		printf(" %s=", key);
+		color_fprintf(stdout, ifa_family_color(af), "%s", str);
+	}
 }
 
 static void print_iface(int index)
@@ -478,8 +486,10 @@ static void print_iface(int index)
 	printf(" ifindex=%d", index);
 
 	ifname = index ? ll_index_to_name(index) : NULL;
-	if (ifname)
-		printf(" dev=%s", ifname);
+	if (ifname) {
+		printf(" dev=");
+		color_fprintf(stdout, COLOR_IFNAME, "%s", ifname);
+	}
 }
 
 static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,

-- 
2.51.0


