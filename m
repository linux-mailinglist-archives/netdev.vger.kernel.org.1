Return-Path: <netdev+bounces-241137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3186CC802C5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20C2E344193
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF82FD7B3;
	Mon, 24 Nov 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzTKGFRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731020468E;
	Mon, 24 Nov 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983184; cv=none; b=Rpudi3EdARtKFwJyv6hOh+oFbj4pWUtmnIIFJzujjw76WT27hSi8NypPWLdXyIfnZiVShRP+RJYI8tv8oGVK0jndEDxB0Wh2RfrkpiuPiF/ThYeBl4k6cCMywPXMF4koMu9omDfUYDB4PcY/6fJ+dz+TXgG7h3yo87OYZ6SBYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983184; c=relaxed/simple;
	bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeAKzek5yH5Z7ckoQXst7+TH0F8qEAUFLRDrDbSLBaNqk7cRjRZX+44lUmTrr7E9w4Aww2Fu4tSqQfJX8J7gVxyT5D7QVbGwsAHnKj19nzhoxp8wLYy58kc+eJLj53CP3rnoMaBsfzsOA9VKXzGeuVQMOpjURXNkNFsOsmh/3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzTKGFRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3501C4CEFB;
	Mon, 24 Nov 2025 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983183;
	bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EzTKGFReFpvF6R5Rt/GoaEVt7D6DbRG0CZ5Ak84YEgpPh9e9ZJTRD/GGlqwSuAKHU
	 o1+OME07IpyS707nRbtSxKi+bAczEEutwpdOUzjPiIXizgdwCSsvl0oQDY5i59ub4E
	 fv8mzSjScui+9ZzGBzoG3StQL8AjDb/oEgnqmuW9EALMV5BmqRSHn/Qf4XSEiyhEri
	 Fy8kywTF+cqxUUB3JiBUlZMynOaQhpwwQZ4Cgk0uGXBLFr5ABrNIqo14BrbR6QiZnl
	 sWIDuNjJItdQbbCX2P+fSpiaW+D2/UYfLh49BBTWxSWVV/u2okMZfN0Ez7zVgCA1NV
	 oQNcGBHV2BW6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:21 +0100
Subject: [PATCH iproute2-net 1/6] MAINTAINERS: add entry for mptcp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-1-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7D3iVOMse+JEFjSevHs0/RsT0yZb8/6HsYviBB9kN
 /p+UfvcUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBEBG0aGri7d/llGQfON049+
 m+uvdWH3q58KvEa9oVqMh4Ib6y40MTLsfHYo33qnUN+W19w7z/Mv8l0qG7r/Fc+GenfpQwpLXlX
 zAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Add Matthieu as main maintainer, but also the MPTCP Linux mailing list
to reach more people interested by MPTCP when submitting patches on this
subject.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51833ec1..2d13c752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -42,6 +42,13 @@ devlink
 M: Jiri Pirko <jiri@resnulli.us>
 F: devlink/*
 
+Multipath TCP - mptcp
+M: Matthieu Baerts <matttbe@kernel.org>
+L: mptcp@lists.linux.dev
+F: ip/ipmptcp.c
+F: man/man8/ip-mptcp.8
+K: mptcp
+
 netkit
 M: Daniel Borkmann <daniel@iogearbox.net>
 M: Nikolay Aleksandrov <razor@blackwall.org>

-- 
2.51.0


