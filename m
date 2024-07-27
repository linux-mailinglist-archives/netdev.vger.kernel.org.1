Return-Path: <netdev+bounces-113367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91393DEB0
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0831C213EE
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855D6F2E5;
	Sat, 27 Jul 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwslFaZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153A537F5;
	Sat, 27 Jul 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075150; cv=none; b=kX58Fym2TSjE+gd9mI9k/4Va4qFc66oOxP0dpGz23scOm81Yc8Yf3HOlYibi6uf0FEwI0fgAsVS3ZmEwcp7R5p5l+zznuGnu9v9hQtjo/pLRH+xYZllVP93dUmldOFzrxQ6dLBP6lg0AaP/iqrnFW8FlzQFYKezLH/EFHbjlRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075150; c=relaxed/simple;
	bh=cCLFaVdPcQbvfOFyb6WEE2nqQ88R0B1vxmSWl3J/yac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r47voU2dqYkobchw8bKeJR0dQWVR56z4zbi5jkncrKhIQGcbBawJsSFP3EAV23m+JZhJCVNsrO7IoUpmxp8G0afU1n1wG8rFGhEJGFmCh9kesCbMcVH1BN1Du/l+5u2gXtreTGh9BjaVN+gP6TVyj4j4IxZuijyuh8ZTk7p7KFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwslFaZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC48C4AF09;
	Sat, 27 Jul 2024 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722075150;
	bh=cCLFaVdPcQbvfOFyb6WEE2nqQ88R0B1vxmSWl3J/yac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DwslFaZD38mcBaSsI2KY8l/52pdMuKd4utfHjTtjgEefdigFwDYjVooFBjI4zHyv3
	 Do7/dWfRHhwTzX5ntvN17pH3Q0nKg//hXcC0EScu4R7DT5zIzgiYoqRPXB5Jp5nXqf
	 k+pYuGK96KmFAu9YvzD3/eZvvpLPNh+w03SqmddaBvKvU8TQ0BwErQBERJzO2Xxw6i
	 av+ABoXBSEHbyjgbWdqWBjkowLao3n6Ysxvce1gS9fyzP5rCpElC9t1NwwrhSRTScz
	 cT8kUOjMvRXBSHA+c13h6HuZSFWP+Nz9+ivKSS/N45RIJajdgAaLS8K4ko1TgoAYV6
	 cqSv+2UEVONDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:10:35 +0200
Subject: [PATCH iproute2-net 6/7] man: mptcp: clarify the 'ID' parameter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-6-c6398c2014ea@kernel.org>
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cCLFaVdPcQbvfOFyb6WEE2nqQ88R0B1vxmSWl3J/yac=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMgAzKelMinQhdZVzeDELlFRgzoiCxP5QsUdj
 xF0HcuYU0qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTIAAAKCRD2t4JPQmmg
 c1qDEADT2096Z1+roQdEKI5MjBCqUMAtbql7EYuQFyWPvmNsTlb4dtKkxQUhUBv6plKx/YSJ3R0
 TZJjFgb+0Go9XeoqrW2/m9FwVBN4ocQcPP/zH90ffMAvRSKH3/vcuOGKEpaUeKPVewHNsapphPj
 yrODnxhj+SaV0TynWgIXwcBCxCpmQAX9ZvV+iPOLzkZvZr2+iZVnCzrCPm3pZ/62Ah+yoDssTdU
 FcDfeMqLJlenbd8lNRHMScx5sURinNhtDeZ6s2mLIgVUzq5IVSxEMbIWOFa+ieOie6m7mnmpDE3
 pRxhptH5N9yyHQ7q/BjwZnRCLUTsZ/KxL8Xipl6mi7X6AFDk1r1XjRsVpnc/NoA0GuQyyXQtDzq
 tvuRgHAxg4HsM/wLa+ljNeLkd1zFJy2KOJ/gn4rFVExkGUYFQ5giX/3RNszuXtBmL90fiEbCq46
 SmyOW/Ws5UlCu53CMQ4u89jhze+jOf7BJ40g9Ep5YC0JjplwwKU+vQ28w42oLG+Y0etbL5z8gqL
 F9FPCSavj6npAYwEpc4cOffSQg4Qiw1T15xCM2y/nYEWfVIbYE4lEY/4iNxJlg+vy9los+IYBul
 l0kkOhXCK+AOD+sZDvgVXfwGZd7pFZ/YsXKD7d5Uta8PgVWCM7SQZE8tYnYA0tSxn8lv6UN6NT2
 8qebVZxwIvPXPcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Explain the range (u8), and the special case for ID 0.

The endpoints here are for all the connections, while the ID 0 is a
special case per connection, depending on the source address used by the
initial subflow. This ID 0 can then not be used for the global
endpoints.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 4c1161fe..e4a55f6c 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -148,7 +148,11 @@ expected behavior.
 
 .TP
 .IR ID
-is a unique numeric identifier for the given endpoint
+is a unique numeric identifier, between 0 and 255, for the given endpoint. It is
+not possible to add endpoints with ID 0, because this special ID is reserved for
+the initial subflow. For rules linked to the initial subflow, the path-manager
+will look at endpoints matching the same address, and port if set, ignoring the
+ID.
 
 .TP
 .BR signal

-- 
2.45.2


