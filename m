Return-Path: <netdev+bounces-113363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5693DEAC
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBE1F22577
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80A56452;
	Sat, 27 Jul 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI6qqdfy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBD55E58;
	Sat, 27 Jul 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075142; cv=none; b=lqLuNI2drOuztF9PxsaiTIQRyhpxXXVZtHF7vK5FAzuojHGHLKS/mpa4tVAeh0SqwCWuLIM/z/w1Se9n9pRMLqQPiO87H+2PFXJUV8zgVbxdN7sxukQPd0yfJeZJmH3xBC0FGJtKUYg0hKbx2RJDdkrcrR6GLEE3H96LjDtliJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075142; c=relaxed/simple;
	bh=c+fr862AGNGG8UQ/xKpCft+CWaGk6C9gagkc+WEPBJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEBlKu1b0MQrO5C5Zu+tWVAdXxoy5FtqA0HWOplOt2VJgrX6cnUXzeDXHb/H2dV+t4FHPVS6sLFuJ3tM+v2OW5cSckDSdKf8JPRMF4QgYQMV1dSekyL9UidZnU/BgvHOrD+CITMcrtMVzmZzQ4V8OjPEeY5FR1DFCgEbOFp66Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI6qqdfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B7DC4AF0A;
	Sat, 27 Jul 2024 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075142;
	bh=c+fr862AGNGG8UQ/xKpCft+CWaGk6C9gagkc+WEPBJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oI6qqdfyDR54b7/EZ7KCQZcJwzHm299xOi0RlUfuNEWiUN4btEA9wrjDXj4FXroH9
	 z9XpgAcd0D5DRb9WXMhfC4ZX9cKfv/kiaD1nwmXvZ9Ejz8NBYl3Nh6eJmXrX3uxV5/
	 CLZn6dbYXbxI1mlusQPxQMUAqFzlfFWcWXoCeW3xapU7QtWLaBdME0raO0YbUh2H4Z
	 IJWHQ1sfPUp7WzIYvKFCVLr9bMZgyrxbBB70yT4CqTnYA/2PzwkzgoAlxA1Eaj011c
	 ln9c4p+C81a98NN/YWXdZRU705O7Xh3KeXClmtI5SRBv8allDwY9SoMKzEIYgppe4m
	 pZLYVeijJLUrg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:31 +0200
Subject: [PATCH iproute2-net 2/7] man: mptcp: clarify 'signal' and
 'subflow' flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-2-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c+fr862AGNGG8UQ/xKpCft+CWaGk6C9gagkc+WEPBJc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgA900tEZBs4VqKQyj2dPfNMRPxRdJalSzp/
 aNag84jr5GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 c9T7D/kBnmTpe5cBnHSR4wZCzUV90Ky8LF1Mavg3Ri9vRXt0C11GlfEDEwaLJtM5bYYhbLAa6In
 syEoA1QWt0hw4shDbE/plEiybmWZYa9jgFgWTthAczMuNN5MBYpcba/qDXK3smxcvJq9GGZt1Q3
 EB6/BmM6lqPwVlD4ZSLdrU4dnfQHukRC7s6GNVCB4O1pGcz/cgj732rQtjaTUtPDEmnA3kdLdfI
 ulnTB6vWQw+iYlibz/oQXW418DMoltoWgQBFMsLZokf/g8Z8EWglOjfO5FHRQ/UErh6ltcQmtma
 Fjvs3rmmfXgqOyATNbq91W1IjyBGRZ+o5lOe1w8zlIWAouc/LjRbn/2fhdPLNU71hcwDIPhkWuO
 dGVQAWXB104CyBJK02o5jj4yhGzxvdcPpjXe/sweYPlgIpBJhmx2oujm6QtcMd/QRch6D9m6EOZ
 NEc2Z+aGcMm24URaQKhZaZ+eU3jN0Rhc47cxdChIh8UDgaafRkfSrzJ9JSsJrV+3e4Tt8XyDgFh
 QY2BYkZByHVg1OEbyUbFlRAgK2SjPJyACTtqDrMG6DZfNf8e10sIOw6Dczn+jz30ODEgC4iidr2
 jKZC+DedVTSV8OPB6eEvoZQh8/p525PkNtygTMrva/mRsqW5dHG+9JBQVHVs8otvi7ZRNcPjzU7
 mXVXffEnb/+ZldQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports on the MPTCP project, these options might
be a bit confusing for some.

Mentioning that the 'signal' flag is typically for a server, and the
'subflow' one is typically for a client should help the user knowing in
which context which flag should be picked.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 89fcb64f..2b693564 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -150,7 +150,8 @@ is a unique numeric identifier for the given endpoint
 .TP
 .BR signal
 The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
-sub-option. Upon reception of an ADD_ADDR sub-option, the peer can try to
+sub-option. Typically, a server would be responsible for this. Upon reception of
+an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
 .BR ADD_ADDR_ACCEPTED_NR.
 
@@ -158,7 +159,8 @@ create additional subflows, see
 .BR subflow
 If additional subflow creation is allowed by the MPTCP limits, the MPTCP
 path manager will try to create an additional subflow using this endpoint
-as the source address after the MPTCP connection is established.
+as the source address after the MPTCP connection is established. A client would
+typically do this.
 
 .TP
 .BR backup

-- 
2.45.2


