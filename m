Return-Path: <netdev+bounces-222791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB3B56119
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AFD587B9A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5CF2EFD95;
	Sat, 13 Sep 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBqdVuoO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8E2ED14E;
	Sat, 13 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770214; cv=none; b=YpBkfKiW5oLHaX0zcardxqdL3PFswqDUwVFystCWqaE8+T2vgyMdTykWfdDBSYpx2CKCJ5ei2CGqkd5hilEQmLkT7LGwtSzrI0QAIuCpGnEUHN4Xyqa+hkts9Df+UwGK1CiPTJO6VUfzqTbCb2LUSqd1Be9k33WVdGPvac8oE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770214; c=relaxed/simple;
	bh=Sk3/Ex3CfjAqmKLrPTL+C3goL3sU1nQzJXY0qb2Z+Cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=toEMsysCC/zD5JOOVR6ctPOSLnAUCEWgKToq6z/vbEWRcHwmvNaskV7c7UwQpPJCbhVHEc1TX5InkcAMvEOFsL53w5XEZnOWHt5l7lyf8JvtHe34Jd+l02xYQpH4pC3EGCnpvCl4JJysc3lUWqww5studEgLLyoX4IcgK10Mzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBqdVuoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C1C4CEEB;
	Sat, 13 Sep 2025 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770213;
	bh=Sk3/Ex3CfjAqmKLrPTL+C3goL3sU1nQzJXY0qb2Z+Cg=;
	h=From:Subject:Date:To:Cc:From;
	b=iBqdVuoO7/bOibm9/RB0sd7G5l5AuVacAirFyJ7uwU9SCAfCX4pW45HkzqldNTgul
	 9jaFUTwnAr4NzEv3Zd2Cdiy41OkvZFajqSep59588+Ghn7MhUk19ZWZuqoWkB5k75P
	 7rFhY/Tpu85W09Iip7VC/+gzUdbz20WlhkXtWNildoJK+RPWiBbpHuvQXEdNGsQl2J
	 61qa5RpSHUDnhlyjb+IP79rk+pI2prSTsoCMPJFB5A7pXPzgLsq7zCGKyADs1hnHO1
	 +mtuhNvm5UvwUAPF0tu3IWg+Pd17q3gq81ukQNcSUoNTnSEwH6xCm56fGTsemUMFsT
	 EANYSrboNg3hw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v3 0/3] tools: ynl: rst: display attribute-set doc
Date: Sat, 13 Sep 2025 15:29:50 +0200
Message-Id: <20250913-net-next-ynl-attr-doc-rst-v3-0-4f06420d87db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5xxWgC/43NTQrCMBAF4KuUWTuSv6bWlfcQF20a22BJJAmhp
 fTuhoCgG3FgFsPjfbNB0N7oAOdqA6+TCcbZfPBDBWrq7KjRDPkGRlhNWkrQ6ph3ibjaGbsYPQ5
 OoQ8Re0lrziQXTNSQ+0+v72Yp9hXeNbjlZDIhOr+Wp4mW/A8/UaRI+l41zYlK2ojLQ3ur56PzY
 2ET+6TYL4ohQSXEwGXX5mFf1L7vL86BgeIYAQAA
X-Change-ID: 20250910-net-next-ynl-attr-doc-rst-b61532634245
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Florian Westphal <fw@strlen.de>, 
 Ido Schimmel <idosch@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Sk3/Ex3CfjAqmKLrPTL+C3goL3sU1nQzJXY0qb2Z+Cg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOFt7959x10c3MWaBF51VD36+dWjmmnFWWU09M7jsxy
 /c+x8vlHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZy8rIcK9hUnhoZWGHSr9c
 3uqY7GN8fOJ581ge8X62PWcoG3tckpFhc+CUiYmnP91N3NVnP9+tla80ZqnKTJmt4VaP2m76hD9
 mBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some attribute-set have a documentation (doc:), but they are not
displayed in the RST / HTML version. This series adds the missing
parsing of these 'doc' fields.

While at it, it also fixes how the 'doc' fields are declared on multiple
lines.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- patch 2: avoid warnings reported by the CI (NIPA/Jakub)
- Link to v2: https://lore.kernel.org/r/20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org

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
 Documentation/netlink/specs/team.yaml         |  6 ++++--
 tools/net/ynl/pyynl/lib/doc_generator.py      |  4 ++++
 15 files changed, 31 insertions(+), 25 deletions(-)
---
base-commit: fc006f5478fcf07d79b35e9dcdc51ecd11a6bf82
change-id: 20250910-net-next-ynl-attr-doc-rst-b61532634245

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


