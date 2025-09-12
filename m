Return-Path: <netdev+bounces-222602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D570B54F5D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102C3A0304D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3730F551;
	Fri, 12 Sep 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2IwOVAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F1308F2D;
	Fri, 12 Sep 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683392; cv=none; b=h82m6Z7u8SQCGt6B0MDoawf3uIAVxVwh+zYa9RZaBty30hVgfw2DNSZLtdpVaIwWYFWdOUaVAUgvDb82K3D+Farolok+unJqNhh5svSBwpLZio34aeZ+HILVCQ/zbLM+vkOCAKyFoB/oUef0HJ3S8dJiJEDXwpd+nHrrPwtrOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683392; c=relaxed/simple;
	bh=P3nDH813s3kZpLneMxR22lFxhvMPUeFpT115QbR4EhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VAelTRTHpF87Ve6SaoHU1JnUdu2LeytJnqgy+JNmL9NZlr+3sQMmdCtt+M/F1iNYNq9ztjNcFEQO4mLjepYZGPQbk85m7AZOuZvTf3tqx7xlMMMqKY9hSYzVO3yipYC5M3E7sP/meYDbdKhF9XnnMOGtjsS4/uopyeUU6L1tKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2IwOVAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB7C4CEF4;
	Fri, 12 Sep 2025 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683391;
	bh=P3nDH813s3kZpLneMxR22lFxhvMPUeFpT115QbR4EhY=;
	h=From:Subject:Date:To:Cc:From;
	b=N2IwOVAIq196fLIINuT5bHNHjn8bd2OyJOvzQFu58qbPx40jx/s6kW/zrkO5XmTpc
	 bM5sIy2qzNqvk2YsKBszbWSpaEes5R79QsJCIi9tK5WfSLtAQJ/94l0fIU2vvHWVtb
	 dJUdJ2JCNIdUaCyfXqlHS3ENXJGdwTjAtsxtluuzPBVdnqNQBcfmXDE2KTSUMm5JOn
	 mPyXn5EJe/fcaZ+tJf9YRj+4tJfQ2crjHQbYxuA9/o8mTgHGBNnT6dALEvcsnHlkkm
	 yzv7PwjMPCcqVcjaV4D6/qGX6Bh4YEvcJXx+pwW/H3evurkBcU2ZxX4mvUqLXQWk/d
	 ksfZZ5CqILb8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/3] tools: ynl: rst: display attribute-set doc
Date: Fri, 12 Sep 2025 15:22:58 +0200
Message-Id: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIexGgC/42NzQqDMBCEX0X23C3Z+Nf21PcoHoxuNVQS2QRRx
 HdvEHrvYQ7Dx3yzQ2CxHOCR7SC82GC9S0VfMujG1g2Mtk8dtNKlupNCxzFljbi5CdsYBXvfoYS
 IpqIy11Ve6KKEtJ+F33Y93S/4zaBJZLQhetnO04VO/od/ISRUxnR1faOK6uL5YXE8Xb0M0BzH8
 QUw36DmzQAAAA==
X-Change-ID: 20250910-net-next-ynl-attr-doc-rst-b61532634245
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=P3nDH813s3kZpLneMxR22lFxhvMPUeFpT115QbR4EhY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOyO34pfTg+XmfloifRbINLJl/fQ7eCX62aapG4jbx7
 +WCK/ZGd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk/kGGfwo1ZQLfw6+cZ5+Q
 PcmFe7ek85FdCW+uXNC3lmN/JztfdDsjw6xXt1/Jc61ivSo56emPaQX6PnOaXQu1I6aevKLMPee
 0HwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some attribute-set have a documentation (doc:), but they are not
displayed in the RST / HTML version. This series adds the missing
parsing of these 'doc' fields.

While at it, it also fixes how the 'doc' fields are declared on multiple
lines.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 2 & 3: new
- Link to v1: https://lore.kernel.org/r/20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org

---
Matthieu Baerts (NGI0) (3):
      tools: ynl: rst: display attribute-set doc
      netlink: specs: team: avoid mangling multilines doc
      netlink: specs: explicitly declare block scalar strings

 Documentation/netlink/specs/conntrack.yaml    |  2 +-
 Documentation/netlink/specs/netdev.yaml       | 22 +++++++++++-----------
 Documentation/netlink/specs/nftables.yaml     |  2 +-
 Documentation/netlink/specs/nl80211.yaml      |  2 +-
 Documentation/netlink/specs/ovs_datapath.yaml |  2 +-
 Documentation/netlink/specs/ovs_flow.yaml     |  2 +-
 Documentation/netlink/specs/ovs_vport.yaml    |  2 +-
 Documentation/netlink/specs/rt-addr.yaml      |  2 +-
 Documentation/netlink/specs/rt-link.yaml      |  2 +-
 Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
 Documentation/netlink/specs/rt-route.yaml     |  2 +-
 Documentation/netlink/specs/rt-rule.yaml      |  2 +-
 Documentation/netlink/specs/tc.yaml           |  2 +-
 Documentation/netlink/specs/team.yaml         |  2 +-
 tools/net/ynl/pyynl/lib/doc_generator.py      |  4 ++++
 15 files changed, 28 insertions(+), 24 deletions(-)
---
base-commit: dc2f650f7e6857bf384069c1a56b2937a1ee370d
change-id: 20250910-net-next-ynl-attr-doc-rst-b61532634245

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


