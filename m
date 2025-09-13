Return-Path: <netdev+bounces-222793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75479B56121
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FF189CD65
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58CF2F0C62;
	Sat, 13 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuzLVs/R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862142F0C50;
	Sat, 13 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770218; cv=none; b=CtsUWznx3+rMLigyoQIl1hrFpn5TvZF0jcGMgl3I1wdh/OuRt2AcmAXaK+vdw1/R4ekbKxefmStn7td0TGrdX/I1uKdWBq5ib0cjw8OTc+oDuh0zuFw2jrdgfkt0TpCczMBzaVEvUPR0JEFVccS7ClpyIBhPxNmOGqyXssvrCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770218; c=relaxed/simple;
	bh=6w0qCDRgz45SxsXbtSej0TJN7KYIGhaBHNHkeRvpfTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhtDppJp8W/6nKfreUcagwERqRVM02MtBx/PkaqT/2YWK0TDrfWQaWiGXeJjWZh67uMRuIp0hGzekU6TNp4ddnOmZH39VQG9l+XLqi4NuUeODvHP6/zJOFE3JCuYG/kIY47RkuMVkH2AQfMWk+YRpZ4oIZ+TjorPAoklWW/8J9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuzLVs/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B13C4CEF9;
	Sat, 13 Sep 2025 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770218;
	bh=6w0qCDRgz45SxsXbtSej0TJN7KYIGhaBHNHkeRvpfTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HuzLVs/RzEL2HkcbyhF0KtplHTAHXbEvMIgmkFbpJc2xu8J67Cdy64ASRAX5dgjhE
	 Ta8BvRjQH9Hep2rRuSwy3UWy0ZVHCOOulgXv2mQG/ca4/rR3d4gm6Am94J4T5FQvOs
	 cQqt1WqfQCR6yUk2GYNPo9+4ZdGRoK/qtw7MDkCRoDZdN6cP0e0/MsrI6wvwuYoTly
	 x88YgwCJoMt+y4dAxPJp/Ld2zzyte2AptaqxXoAu5/D49MUfPh180Nhcu8A65XKG/d
	 EKgdRyzlybNlFgd3i5sjgjkWQL6WRw6FEjOUROkNCY7DEXJwk4gXo5I7l4a23vn2qP
	 e1btBjcbogb2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 13 Sep 2025 15:29:52 +0200
Subject: [PATCH net-next v3 2/3] netlink: specs: team: avoid mangling
 multilines doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-net-next-ynl-attr-doc-rst-v3-2-4f06420d87db@kernel.org>
References: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
In-Reply-To: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6w0qCDRgz45SxsXbtSej0TJN7KYIGhaBHNHkeRvpfTc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOFj6QKbaJfdL5on5m8Q3mX2yX7olIih5967DYLanji
 uPl8H6JjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm0lDP84Svkv8O2ZZ2EtpTF
 y9r3jD/WGLJGxWhVnvjD8v5evZpaPiPD7flu/xwWywuJKcxT2Ho6ZfGf7DzFd/xbbt28s2zRsRW
 KnAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, strings defined in YAML at the next line are folded:
newlines are replaced by spaces. Here, the newlines are there for a
reason, and should be kept in the output.

This can be fixed by adding the '|' symbol to use the "literal" style.
This issue was introduced by commit 387724cbf415 ("Documentation:
netlink: add a YAML spec for team"), but visible in the doc only since
the parent commit.

To avoid warnings when generating the HTML output, and to look better,
the code layout is now in a dedicated code block, which requires '::'
and a new blank line. Just for a question of uniformity, a new blank
line is also added after the code block.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: code block and new blank lines (NIPA / Jakub)
---
 Documentation/netlink/specs/team.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index cf02d47d12a458aaa7d45875a0a54af0093d80a8..83a275b44c825f9ba6f6660813d25b8efc20267b 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -25,8 +25,9 @@ definitions:
 attribute-sets:
   -
     name: team
-    doc:
-      The team nested layout of get/set msg looks like
+    doc: |
+      The team nested layout of get/set msg looks like::
+
           [TEAM_ATTR_LIST_OPTION]
               [TEAM_ATTR_ITEM_OPTION]
                   [TEAM_ATTR_OPTION_*], ...
@@ -39,6 +40,7 @@ attribute-sets:
               [TEAM_ATTR_ITEM_PORT]
                   [TEAM_ATTR_PORT_*], ...
               ...
+
     name-prefix: team-attr-
     attributes:
       -

-- 
2.51.0


