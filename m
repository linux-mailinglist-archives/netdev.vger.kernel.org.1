Return-Path: <netdev+bounces-241138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8BCC802C8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4246A344F8A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFE2FD1DA;
	Mon, 24 Nov 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLFnIBwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C52FD7DE;
	Mon, 24 Nov 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983186; cv=none; b=HTtHD4dt6gvvWWWxUFkVosQ5ZF9ZyFzZ5DIVz2tq5l+E2/rA7UyJuFimuh0LDPNcIu5aelWAAIkzfIAgg6C2ISrX/ZPYeXIfYHteHZu54pahGhZp3/sw8eB/6v8VfzVCq0/m+FAIjKSimPdRIINWZUl/o8/+EGSlOGnp7KbN58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983186; c=relaxed/simple;
	bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bt8SrCKJxtt+n+DjWYUpvZ99u8jSDB7NrfkmxsZFDTw0YOHt7SS201WEsut09Mg+iMcFvrrjNPOWKlPmkk+gTLQhPiQH+xmuUsi108Nri4m0jiRKOoIVcFluTCdQQ9BcRtRi15zrIheW8BAdZVDEXRhY1l1zO6nPc5L9Zo2h9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLFnIBwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9FBC4CEF1;
	Mon, 24 Nov 2025 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983185;
	bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eLFnIBwgKyizQBgIyvEqkt2/5l/HAdTaZmz2sJbUMAuDcnAGk4HwA/5OZ4+fb5Om5
	 hifZqa1t9avaTqctpKcnt9coReDxEBuNIbyg9TUBh6V+OE4gAVaAQe+mU+oZgmzqdr
	 q9C8ZonDkNVzionxeouZzSVNO0/C4qiFk+qMmtLzCCyoTvGp7qeQd6yTVRpJOY1ukz
	 TbfcfHzffxioyHyoN1DGdpdeZM16N6xZJVsWVDGrn6l4Cvx4vHwiN3LqGEzQuNqMQ+
	 7yxsqEEgSLO3oOJl/wz3Qyw36DPwEpwj2squ9hSWyiblOcYAInQDpKhCylnd/BqCtI
	 cn0ZHceCZFq6w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:22 +0100
Subject: [PATCH iproute2-net 2/6] man: mptcp: fix minor typos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-2-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7D0Nnz08c/R99PwvTok7ngfbfOB43hR3zUdesOnT2
 wPHuwvFOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYy4Qcjw5qW9uKY74anj/zb
 0m6gtelr7vJfXUyrzggsZ1+gtvWuFDcjQ+Oz3iuBB8Lt77rxu1+L7Jn8rzBEQkMx8MExkcX68pr
 vOQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- 'signaled' -> 'signalled'

- 'a implicit' -> 'an implicit'

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index e4a55f6c..500dc671 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -156,7 +156,7 @@ ID.
 
 .TP
 .BR signal
-The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
+The endpoint will be announced/signalled to each peer via an MPTCP ADD_ADDR
 sub-option. Typically, a server would be responsible for this. Upon reception of
 an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
@@ -207,7 +207,7 @@ is then optional.
 .BR implicit
 In some scenarios, an MPTCP
 .BR subflow
-can use a local address mapped by a implicit endpoint created by the
+can use a local address mapped by an implicit endpoint created by the
 in-kernel path manager. Once set, the implicit flag cannot be removed, but
 other flags can be added to the endpoint. Implicit endpoints cannot be
 created from user-space.

-- 
2.51.0


