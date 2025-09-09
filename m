Return-Path: <netdev+bounces-221358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA98B504A2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8907D163BB9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFD3314DC;
	Tue,  9 Sep 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR8HvAUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDC24BCF5;
	Tue,  9 Sep 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439986; cv=none; b=LFhJflPg1XBUIKvFsyvidaLzBWDuqdYkHlesQeoyb5DCuf59JpT2bR9Y25ZePSyJs5xqY6AcD2eGlNHggQPaGQDyizu6sSWmOpXRO53195RosXNm5UFH5JmhaSVs/vDuhwaaLPZabjx0kjtbtD5pgvoeOpNhB4pVnbNeNDF4c80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439986; c=relaxed/simple;
	bh=v9xXxmxDXQYkaEAJAX0BRW6tnDjxk8gf8Bml2n9XIwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iaE2ad41yZCrR1YIijHGfjf01AESzACq8W6pN/qS/g6W6b1hdWRAHjKtJPwtRgOkOrTpzAAO6q3ldMa1lj8VIxL5sdeDjtmAe1X/hkM+iCpVmuxjkbWSlSudgPztaulB4MKwqCEdh5DLJUgOU6eWFnijjvOw692GuXVsr+VFGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR8HvAUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA78C4CEF4;
	Tue,  9 Sep 2025 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757439985;
	bh=v9xXxmxDXQYkaEAJAX0BRW6tnDjxk8gf8Bml2n9XIwU=;
	h=From:Date:Subject:To:Cc:From;
	b=XR8HvAUpgEDsG9LXQ9uxZ8OQ1r9prbNDn2ztFSkEc4KFfBw74wAJ0pIePPg2qQN0s
	 woZ5IeJG+LZdriZ3t7J9Zu1QdTYLTigVXU8eFLHY6VLIH0ykTRVmWmfZzKGifp6LoI
	 iUyfo8zAksWUHtmusejt/nfOaTgiDr/mOjbcWOzhJsAuLbpkOAGf5v3lzzahdlQv5z
	 wR+29EBCUIVHbMTWSYGY+MKB2ogQ1ZjGvMcUACxlCwwhHvKjy3cbTY2alOtKArrH+d
	 C3kaMd24u3y60Q9cBBT6dCQb4ewFCwDkvBEmTRV3GJ0zye0zlpxMXyIj4btuao8Dx7
	 Yu38G9ikfwHLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 19:46:09 +0200
Subject: [PATCH net-next] doc: mptcp: fix Netlink specs link
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOBnwGgC/zWMQQqAIBAAvxJ7bsGUsPpKdAjbaqlMVCII/54EH
 eYwh5kHAnmmAF3xgKeLA582S1UWYNbRLoQ8ZQcpZC1a0aKlmLkjHi4ah+7Ane2GlW5qpScj1aw
 gx87TzPc37uFvYEjpBUW7yF9yAAAA
X-Change-ID: 20250909-net-next-mptcp-pm-link-178537dc23f3
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v9xXxmxDXQYkaEAJAX0BRW6tnDjxk8gf8Bml2n9XIwU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOpL/jilp9PqFN5nsLa5Jtyk+1y3PyzJf3HDzuHl60K
 uzBysAzHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZ6M7wP/lFn8YUI4sHpe//
 R9v/PqNgd7GOm+106o9Xc+/c7dbZk8/wP/PwzON7Sn/266yfOGvX2envjxkw3wheeS2GdeqlW/+
 zJrEBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The Netlink specs RST files are no longer generated inside the source
tree.

In other words, the path to mptcp_pm.rst has changed, and needs to be
updated to the new location.

Fixes: 1ce4da3dd99e ("docs: use parser_yaml extension to handle Netlink specs")
Reported-by: Kory Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/20250828185037.07873d04@kmaincent-XPS-13-7390
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
index 17f2bab611644727e19c3969fa08fa974c702d92..fdc7bfd5d5c5f7a6be089e23fb3d97da294e4c88 100644
--- a/Documentation/networking/mptcp.rst
+++ b/Documentation/networking/mptcp.rst
@@ -66,7 +66,7 @@ same rules are applied for all the connections (see: ``ip mptcp``) ; and the
 userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
 <https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
 connection. The path managers can be controlled via a Netlink API; see
-netlink_spec/mptcp_pm.rst.
+../netlink/specs/mptcp_pm.rst.
 
 To be able to use multiple IP addresses on a host to create multiple *subflows*
 (paths), the default in-kernel MPTCP path-manager needs to know which IP

---
base-commit: 3b4296f5893d3a4e19edfc3800cb79381095e55f
change-id: 20250909-net-next-mptcp-pm-link-178537dc23f3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


