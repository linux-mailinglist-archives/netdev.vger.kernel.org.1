Return-Path: <netdev+bounces-113366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4D93DEAF
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D651F2261A
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB76CDCC;
	Sat, 27 Jul 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGdpCBBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897721C2D;
	Sat, 27 Jul 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075148; cv=none; b=Lc/YLEq+3tJCI+Hi5VBD8UASEcZQyoFiKRtvdgn49e0PI+2uXRd4JiTTmQdMSz8cyMxc3Nln+empp51dZUmVMk2a7Gf0ILGjSPxNAd/a2c68AbHXWj5rXg3GyM+/g+LGFCsn3mQuEyF4S3JP0Hraxj7qynTrlYfxKKy42geYSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075148; c=relaxed/simple;
	bh=DzynoOoC7+thgs+TYKlYcgcBgYWHSkzlGjhag0lPEks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQ1ZtroSMvwk4yMgIXLvgWbY3OH+CeFuDAs+cwk4oBvKVUjBUFqs3zTIFrVHdhxJwPwZzzDyeMPmx4MFGRA1EL3sYBHduNsrbUugjFJru/Xei28rd1pcKgxGf7+3vkqV4fbxrBMgWIwH+8Tmhwp1GRz6wEw2OTDzkqEsm6ss28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGdpCBBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C532C4AF10;
	Sat, 27 Jul 2024 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075148;
	bh=DzynoOoC7+thgs+TYKlYcgcBgYWHSkzlGjhag0lPEks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dGdpCBBY5dkw7CtZKjNmnZyAt2Hnv2vhFn/Je0Kyr7JimrwFXPYkc5/3AZp0Yfv1T
	 9YwfbxDhGeBtEnCDdv+reWUwIuffxO4Mh+k7Bgg8OXbIvWMPA2lDS3+U5eGbQJREBL
	 Y0d0Rz1+9Ow/NmrFeYpkmXjUJspIZ2aDWfuY2uqApsNf8eRvlg7G8AIgWA0Nqhwp9S
	 kveS2O3gd9+Ds3bTCJdS7AWHSmM+aQIo4fKW95+GMTA/qCcDBCIZ33wHkVhOkWtqIt
	 dsDqdmgOCjw6oCs5QFWLoQUZXTXtlYgJIUgkZBw3FqzdgcObArM31t0ZsC2nedvanw
	 XvjY2H9BEldCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:34 +0200
Subject: [PATCH iproute2-net 5/7] man: mptcp: 'fullmesh' has to be used
 with 'subflow'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-5-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DzynoOoC7+thgs+TYKlYcgcBgYWHSkzlGjhag0lPEks=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgA1nOfSI8wBxFpB/DuDl6QbJgrVh1gn3Tj9
 9aG4KYledaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 c/PAEACjZo0TziZ8rgTRHqgeIf9vm4ITvFfkpylqoXO3jLwc6fuCjNr1jST1C0WCZZu/2WiSvSs
 KA/oFvqXGEtR5ZHwjTriz4tPJdGALgoovekJB0/+N6tIml5AVILk3TJ6KRuydD/eUpLlRNWJlk3
 3IIQ8rkMZH3E38Jib6zNkY+QzQMJztBlvJJP8Ipf46/JuZM/Nq5Qf5IXAM/nBLsDasxBo8/25jW
 T4ibLYlDPhGtBVGZhQ3tz5MmMZACTqH7835ceFnIyPCMqrkL8cwQUb4ko2ElHzaDo1w0QsA8dm8
 GMsHl+Jwl7c05ldy4wLLn4Xsf8TBr9QLC8Tk2ZMMyC3CL5+NGQhjmSk3dK8Q/58kg5q0pU8LSUT
 jLxnJqYS7Z9VsIzEHGBTcVXkAvMcJWE/Juv/yEcArRL/1no0voV8g9FDwZUEW2ud1DmgCf2ebo7
 G3WTtBaQg2aMft0+JknM5TE6kQCXIK07uz8Dv2At3nKTmkFUuRLevKx6q4PUiDgYLE/c3wHE/Bf
 PflLUoqSXmAoEuMtwtn87VA34BvJ+R0d69P2O/aZoDgIvx7CPOBE6AGgxyyX0V5/L4H8TFLaBFa
 ktUl6cCI4CVcgWZ7GcJNRVokax/B+BrPrHP7+LgfVXAv95k9KXRZSqhtv5z3M7f7lGlLL+jWiEd
 CeBa6fwzCnU2YDQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'fullmesh' affects the subflow creation, it has to be used with the
'subflow' flag. That's what is enforced on the kernel side.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index f3d09bab..4c1161fe 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -190,7 +190,14 @@ this will behave the same as a plain
 .BR subflow
 endpoint. When the peer does announce addresses, each received ADD_ADDR
 sub-option will trigger creation of an additional subflow to generate a
-full mesh topology.
+full mesh topology. This
+.BR fullmesh
+flag should always be used in combination with the
+.BR subflow
+one to be useful, except for the address used by the initial subflow,
+where
+.BR subflow
+is then optional.
 
 .TP
 .BR implicit

-- 
2.45.2


