Return-Path: <netdev+bounces-113362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D898993DEAB
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102B81C21251
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC545381B;
	Sat, 27 Jul 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lesZFCSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5C40849;
	Sat, 27 Jul 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075140; cv=none; b=TlzrmfFFn4A6hpQaSK5F4W8LqMO5aaegrksuhbA8+VkqlQxivBSTV7C8gFKPyuwi2SG08jy7eudz/voC0Ummi0nRpPPSlNPELPB1+ZloZIIXPyRgDit7HIp4G+EM1z8DHG1NbwtpYMwF8s/UoFva23X9PU14V3DrGosBFF6jt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075140; c=relaxed/simple;
	bh=bCaMgVST+E6nlnwmefePq27Eu3ZiZE5vGpFBfhZlblU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3RgiGSHQ4eJRRU4mYCWcxp82Nnbj2rJVIKj1d6/HkiOChEEewWo5PvPb/MzdQudw3Mh4HHoztyB8rDx6NHwmx3r0itpJtOyYdw3g5uebgSxWG5eVnwf0krl0249hiw44RlSIBMllXsHdtcVzSQYxGeaXIsi6l0t3AYnszKUTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lesZFCSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D064EC4AF09;
	Sat, 27 Jul 2024 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075140;
	bh=bCaMgVST+E6nlnwmefePq27Eu3ZiZE5vGpFBfhZlblU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lesZFCSw82Lvj7lfYviIrG770L5/v/8zxtuAYqnDEKUUXfQZcGToY5Tg/Z6SXrN2+
	 WlMO9fIj2iXDXH8WoG5dDxtExnlv3AhMPYRsPeZw0yQsT2YPRcxwwNjzCZdNiFxBDL
	 bJ2jREr69uoubznx4kpRK3P3AEuCkBlAtxH6s/lJjevqiKTTHLsrAlueIjXN1OBWMZ
	 vNfuMbcrpRjrlN+RqxTsGmrqCN7xN04tJNxfndH+ihzn17otfOw7xWoTr0CO0VakNW
	 qJukt72nYW1eUisr/ByxfTN9x9SAasGymez/vDCylMGRyC6vdi8UHhkodR92Ac5O/T
	 g/46jxSuvIC5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:30 +0200
Subject: [PATCH iproute2-net 1/7] man: mptcp: document 'dev IFNAME'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-1-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bCaMgVST+E6nlnwmefePq27Eu3ZiZE5vGpFBfhZlblU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgAstfIOovUd8Yhzbd7mp7xtRP9EMSgj0gch
 7EcDktVEPaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 c0k8D/9GbxRSkx2obBwjmEF1U3QimDSjJdwzA92kA1IY8mtvJYMqV4o+Wt3xT37RVs3+Fralq43
 VNW47rJ1gvqzkCDGc4URCjrqbQ7aaLLN9WlvIqoKDtghXAPjt2jb9MEA4Q5WQtN2z48nwRpCXwE
 ldre2gwknYzSaxdCJ81Bt/MIyVrK8ofB9JfENqGvhNRriwyArsaS8cFe76ptKclhRY9UBd7a3fQ
 TUjyrXoc+O8HW1YLvShy7TCB5MkNT9cJzhyTVAJSdBBv/Av582lKaVR0r9QQ32hfnMgkwfFCpos
 pm/b+RgIE+b3+vXte3k2uHCBwX8vDPO3z//VuHGEeh1QevLXkdvTJWMfze9642kIbTiSYW5JpKU
 S5sANC7NRz/3ly+SPH6rojxtVw18IjdkZaGHNrI07B2PVBwfD8D9m4zMZQTtZ8duMRBsf0ggrLY
 0PcPe9w3KyjndetUMSF07Hah3mpMQ16UnF2nWki6pA/TiHIT5HNs5EtyNMV1dRAx2yYncc4AYtg
 qNqbMruoV0DS8ZPTV6v07nb2OIqE4L+8D4VTnVdT2eDymUV86u2urYlcrpyrIYxlowBKZ96fmGQ
 I/pTC+GjSTrH8tYGQmEjUsOJPp4BAFf0QM0IlTmhGmstnUKhsfHi9N7ZpCVoQCHpoUxN5U2oJ+B
 HBm6Lgn6etT1KxQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It was missing, while it is a very important option.

Indeed, without it, the kernel might not pick the right interface to
send packets for additional subflows. Mention that in the man page.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 6c708957..89fcb64f 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -135,6 +135,14 @@ established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
 this peer being actually on the client side.
 
+.TP
+.IR IFNAME
+is the network interface name attached to the endpoint. It is important to
+specify this device name linked to the address to make sure the system knows how
+to route packets from the specified IP address to the correct network interface.
+Without this, it might be required to add IP rules and routes to have the
+expected behavior.
+
 .TP
 .IR ID
 is a unique numeric identifier for the given endpoint

-- 
2.45.2


