Return-Path: <netdev+bounces-113364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22A93DEAD
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C21D1C21509
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EB58AD0;
	Sat, 27 Jul 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwu4cLMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E958203;
	Sat, 27 Jul 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075144; cv=none; b=CucZ9uw1Cvxbd1QUKjK7bSvGiACYf+0G8H0fkSPA6KovcYwO1oitiq45qmRE0XxdCkTErRFLWkoXCnOHbGkJnx/+JpVqwFhOPlXTtKvU/tPWE27IjufDfbdHuRN1dQoGccwaPtVnmsKizfGkX/Air1k0PlIKgcLygNeH7ab7T2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075144; c=relaxed/simple;
	bh=Eg4C6ZPAfMWBhmGpVUvBdOM2+OEckNAuop6FhUHVt60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbE7Zo40iqK00zLzregVEK73Z6GFfXi/QjaDSkWHi5M0MNtu0D3O8e8HJB4+BToNLgpW1MTcfsw5WZQk6D4UR4pmh0SEEHolAkmODt054rKeSpRPb/ComMlVZxpy4ONPpzHWK27Nkv/Ljg6avmt08eQOWCmV1Wpk9WIKAlUiO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwu4cLMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61F1C32786;
	Sat, 27 Jul 2024 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075144;
	bh=Eg4C6ZPAfMWBhmGpVUvBdOM2+OEckNAuop6FhUHVt60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iwu4cLMegLousCQrzmVYTo6b7P9hDlSmVBy+0CNxJfxAu/FxOv5aOhZbhQMkqGj4g
	 onPRUA0edxf3YFmcby1R6kvXl5TLAqa/OTdg3fHjceaRn/Lbb1HccfClBAg5/rKzcH
	 Aywz/A50K5YTX1sUzQCBtdL0bjX3HuMWoqg7sd1KxngLApiGNlGX3KQs/dF7/iMRGB
	 QMUqF5W56NDDqla3ftOWpbIT27gKkHx5ziUpHQe7z1B9mCJqKJ7xHxHh0/CMgWN9bY
	 V1hYz6NNlbUnRfZg6rDdYoP+D/AA6uHrrZStPIm1QbGf6KZklCWSkkIPXkihwnjvKB
	 SfVeV6er4Oq7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:32 +0200
Subject: [PATCH iproute2-net 3/7] man: mptcp: 'port' has to be used with
 'signal'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-3-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Eg4C6ZPAfMWBhmGpVUvBdOM2+OEckNAuop6FhUHVt60=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgAEkZxKixtdp2t675k2vJgI7nBO1CLg0pun
 BjlXAeaeBGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 cwVgD/9IDhs50LM5foYRFi8M+HJ0TMK9zVqaaj1eFrGogYndUZVJce8bRBlraPSyGehhw11XSlY
 dXBSgxKNqeFDNbdDzip3y8/5c9KdydtLuDTa1hEeO8daA5cZLKWgcNxkcHu29qnlzyWKVE+Tllx
 JZX2nASb3EfAGz8nWbd2LtjNPyOfgR507E3KdCZQfzoDFQ8fLCqab3HfbV7LCdf0oWfhc5Erak6
 V8/Ct2IbDQn5dlQHVLI+09cY+NQeKE5J7Do50WWFSrEseCx82C+vtiplLJY2D+kn4N30miWX1ua
 lcZsNlaAuNY4vhiGccxmct891soE+xd8zKX3TPcSM9b+9GP3GK/WRND37YechOqhPdQt8ehsvsu
 8gIhzeWSUsBo4H5MFDzZ6a6X02h9N5220/2mTqrUrg7Kl291lu0Lde5yzh9j6a0QkeHNUvLEoeo
 Eoen06CJa2GWQ8QpRbeZLCk/BvmMT++PPZEthLV+qcKzOMMDzzoD+qooJudJIQ5yeaC1okuIad/
 K57Cob8ag+IZHj7sHSLDDMhoyJm3+UPWdcASsKIbHWQGz8L7ybYFu/HyM9+YohjZHTSeEN/IYnx
 pGvLPXusuk7fxaLHF7Rs7PBc4AjZS7RM1lCEZRoPaEkXrXQCfxi+6dkg/iHIbcx0P8ETl/kRA6/
 Xp4ELsC+j7pXT8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's what is enforced by the kernel: the 'port' is used to create a
new listening socket on that port, not to create a new subflow from/to
that port. It then requires the 'signal' flag.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 2b693564..11df43ce 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -133,7 +133,10 @@ is 0.
 When a port number is specified, incoming MPTCP subflows for already
 established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
-this peer being actually on the client side.
+this peer being actually on the client side. This option has to be used in
+combination with the
+.BR signal
+flag.
 
 .TP
 .IR IFNAME

-- 
2.45.2


