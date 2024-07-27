Return-Path: <netdev+bounces-113365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B993DEAE
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B6F1F225BA
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC8558203;
	Sat, 27 Jul 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOBdDx0Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC51C2D;
	Sat, 27 Jul 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075146; cv=none; b=lwwW/1Fs1j1bj4/cYjynKh31rc/Sd1F+FZvGVUz6OOqONKIYfWfvu6NLy8jcsBipDaoEUYVIofcxoxaYZuZcirb1o6m/iYkKfbRvvPKOQyU2Ka1n4NL+tkSwLhcxm6wB91vjL4a35F3m6dXn1dBq401L46tsevtb3T8/Gn7sVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075146; c=relaxed/simple;
	bh=m8/YsWwUAxDtOWWk0+Nmfe8UX/0337jnAlbMwnQqOPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psx+HJ59k//fKToXyzHiNlm/G6WrwlKiBzRccTSjjj2pxOuhCl8RqC6/HRFUjbvY6FC+umIT6G3Z/h0j7PQe+uf4rnBI1Gsm5CRrfzGKud7pQ2rIyS5Og50PvPhcy8Cn4WaM332T5zttJKGbxh/Twq7Xh/TkbBe1hnNi4oVh+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOBdDx0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C69C32781;
	Sat, 27 Jul 2024 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075146;
	bh=m8/YsWwUAxDtOWWk0+Nmfe8UX/0337jnAlbMwnQqOPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dOBdDx0ZmfqLgBtBS8Rr+1HFP+Z8lceqVaEa8VJACt0B9ksDT8KM8mWcvF8bdxSt+
	 U11iwr4DUyxEWMKCkUM6oeroJMquHY7aA/jvdxbqxVcX9qPnDbAHrVoEpgY7dvSL7j
	 WFozx7RNVwTueLs7C/5fFUZEPK3XyjuNkF+ul9SDVwfNUt+AHmAZ+a1LFItJ1dY2S+
	 n9G7fWCGWLQZEdWqjJdE69aboewQBoUmEuD4LbJAmGSxn9QoETKKHyDkY/bbfhD9F9
	 1AlbB6wStNHpjKWxPWbxcfJHjFcduROY48U54ffufGz9zt7BuDtR0QOokawf853/FU
	 ahCvo0CyPn7AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:33 +0200
Subject: [PATCH iproute2-net 4/7] man: mptcp: 'backup' flag also affects
 outgoing data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-4-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m8/YsWwUAxDtOWWk0+Nmfe8UX/0337jnAlbMwnQqOPE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgATtUmo+tqHIdsuGh49PdI9IYuDsIrdsWUy
 rgWaWPm2wyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 cx97D/9gRtNusXHJuU+CXV+zkc/JDsmTp08L5ztt+U6nj3y3Z7zAq11J7WeZ6bkTbqsuD6iV9x7
 JWktt5cvsUglQ8QRDrp8EC+zdNUFKQZFqudmJb0pdMVplhU+JTu3A2r4GfPT4Rbu7BGlAw7Xp1X
 DPLuHmuu6F8Fheop/H5gf2K5Nxn16yVq3j+cOX4QG6ynO5uzTRatXTWO/5bLLyg211JSY3EBPzq
 axC3haW1FNf8Env9mPJNCmAZH5BUkkWHlZ8nToofZeQZEbhHoPMw1ipmtdadTdvewff0V7bj+GE
 1gzfwF35UQ0oOiFa8giRrNvXZWDvMN4fWbCftx/lraPE5AYiS/QPguwxxa5ft/86vhlHItfFi6t
 t/gAAnqANUtAi/5VihjcPA2CDV/cyQ5R0Jm1O635n28QB6BjpIb7sncb5TRDFff3fqSV///ZXXc
 4EK2Qy0uhkG8iujAtzind8iVN3YqjarFDOHSk2tRUojI8J3mmllYVvEaMoezP72Z5eXksXBhgzu
 BzzH4goVAIpOeTHTpQzxw4uWzZiEkPIsu4CYE5Dr88M0Qmmn/rsYr7W/yPI9iRKNWpvBAV/DgDg
 IHHDX4PtLdwDM8/MVaxpIk6IYTrAFf0eeairW+5z0QdM/C+zmcPioj49akgISHGzGCPHfr8cMHI
 n58/N1RiwMWm/UA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's the behaviour with the default packet scheduler.

In some early design, the default scheduler was supposed to take into
account only the received backup flags, but it ended up not being the
case, and setting the flag would also affect outgoing data.

Suggested-by: Mat Martineau <martineau@kernel.org>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 11df43ce..f3d09bab 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -170,10 +170,12 @@ typically do this.
 If this is a
 .BR subflow
 endpoint, the subflows created using this endpoint will have the backup
-flag set during the connection process. This flag instructs the peer to
-only send data on a given subflow when all non-backup subflows are
-unavailable. This does not affect outgoing data, where subflow priority
-is determined by the backup/non-backup flag received from the peer
+flag set during the connection process. This flag instructs the remote
+peer to only send data on a given subflow when all non-backup subflows
+are unavailable. When using the default packet scheduler with a 'backup'
+endpoint, outgoing data from the local peer is also affected: packets
+will only be sent from this endpoint when all non-backup subflows are
+unavailable.
 
 .TP
 .BR fullmesh

-- 
2.45.2


