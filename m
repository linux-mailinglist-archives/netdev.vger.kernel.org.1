Return-Path: <netdev+bounces-248608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1ADD0C47E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88CF3302178E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2633D6EB;
	Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8PsB92I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F733D6D2
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993504; cv=none; b=kiyTjh8kz1KRxlVJqzzw1SVR8dc0nIhdEzVh0dQY/gJtUwxMVzsU04iGRIJRiNtXYXlB1XumDhGJdakgow32jtzxTFsymqx+wJgu70IZ7mbOX131brrhm/4ZlLsxcKxC/MvNJ7wEU+VI5UT4e5wGVUeanAHWq8KhHOv/ZTSS+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993504; c=relaxed/simple;
	bh=sapKKAHGaJAA/f0p4oT5X/HqrFDJz/ZFLRDKlYCMcXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz1UQqMthHyp0PNM7s9IC5AuUdhctVYueg7idDGEMqX61tGvkvDb+ChB2FOf7iIwza6KnCuPQsClLIkeUmuRtJVQk6iuHV128vO5SQftmSn5CsWx7/YMEO78FFwmZskIkbJlrgtwMhZfQjvZvpDd9/LoQ28VLlYdKIoW2IIX+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8PsB92I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85523C19423;
	Fri,  9 Jan 2026 21:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993503;
	bh=sapKKAHGaJAA/f0p4oT5X/HqrFDJz/ZFLRDKlYCMcXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8PsB92I+USy5YHuttF4hpHotboZKL8NjbRYUBJQmRQHmnKGWDDNs5/aBipmh8QI9
	 xIxS9Eziu02yig87VBLMVcZIr5WIzX/zAeA/vG7q7WlK0iw8N6YRZePg3TVqWVmjYV
	 o1wu9Zzax7ltv9lYE/VsvV8S3CY55ATUPDT0eK2qUxKUYqt1U5Qg4KF/HTCp/O42nS
	 2KO24eS7BLjRy60WHYttLVtjBJACotiDntdDkHq6yp1xkdFYxYHE94KWHqei3yBsrW
	 KPCtGOb6BaOjjZvzSvqodWOVNq+OokwnDckU/PleWgFHn/YlnedMOt2kbHEuBxKEbn
	 ep80Okq4ybp7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/7] tools: ynl: cli: add --doc as alias to --list-attrs
Date: Fri,  9 Jan 2026 13:17:53 -0800
Message-ID: <20260109211756.3342477-5-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109211756.3342477-1-kuba@kernel.org>
References: <20260109211756.3342477-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--list-attrs also provides information about the operation itself.
So --doc seems more appropriate. Add an alias.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 6ddb3dac08bc..88e9fbe4ac5b 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -182,7 +182,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
                      help="List available --do and --dump operations")
     ops.add_argument('--list-msgs', action='store_true',
                      help="List all messages of the family (incl. notifications)")
-    ops.add_argument('--list-attrs', dest='list_attrs', metavar='MSG',
+    ops.add_argument('--list-attrs', '--doc', dest='list_attrs', metavar='MSG',
                      type=str, help='List attributes for a message / operation')
     ops.add_argument('--validate', action='store_true',
                      help="Validate the spec against schema and exit")
-- 
2.52.0


