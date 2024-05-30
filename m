Return-Path: <netdev+bounces-99425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F056B8D4D7C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE912833C6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A579186E50;
	Thu, 30 May 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcIxdJr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B189186E39;
	Thu, 30 May 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078083; cv=none; b=HMiN+jV7QieWAs7bksVexOiQnKwGGFyQf2NdU0+GVoSsE+XZ2kNexm//vLwqnR93zV7cfarbSFC+RX3gMXReNXuB67kGOzwUHabS6QRj/QC9AxR9vBiakLJbtQNTGwxclEKPUKt9L/VBmN73W0nW8dy04nDz6PBxCRIoKQ6eA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078083; c=relaxed/simple;
	bh=nCLxw0SHqx1x703rvJNq+CGCwDIzdOix84z/8W/NPq0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BTbN/aVpDJ/KQuXQlb18AOyCnr8IPeXpHXUbISwut4jt9rLxV4cXl9/Ekcc9xz3FMA4Y19xG6zTfGwVs/dmZcWWvANdk2bWM7oemG8T2Kczew2Q/kG17KwoWjYuKcfnqxJTSoZ0HsQMQ0k+alaFWAlqDgn3qYULV6Xwv/0NvNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcIxdJr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109AC2BBFC;
	Thu, 30 May 2024 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717078082;
	bh=nCLxw0SHqx1x703rvJNq+CGCwDIzdOix84z/8W/NPq0=;
	h=From:Subject:Date:To:Cc:From;
	b=AcIxdJr8pBj6BSAwOKTo+BahWxvvCYGL6MlLuHBi0rHRStmDLKSBvdWYcfs6Jr/fd
	 rhnpV2e4EXshXZYGqvZuwKanU5Lmz4DGtkiWSBhgD8nFDddscqL66LEww00Bnvlbo6
	 7d+astys8Bt2I6vHowdgvCkrcOXX+bNk4KFPbDhwLnKnYZamuqpAT/wbROMia/bQWw
	 7jZH1SfO+fEc3nMYXzMxrv8cd4QUKrUMNlfOlTus4pMAIf4gWpGtTGGkx6aGpR2QJ5
	 lnPiYSoLncU15qwivJoFGLrsC8G6RCCzTBZABRJLxS/JFXiI6B6BlzjdRohZJtreuW
	 pG/6X8F2WPUsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v3 0/3] doc: mptcp: new general doc and fixes
Date: Thu, 30 May 2024 16:07:29 +0200
Message-Id: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGIWGYC/43NQQ6CMBAF0KuQWVtTpiWgK+9hXJQyQKO0pK0EQ
 7i7lYXRlS7//Mz7CwTyhgIcswU8TSYYZ1MQuwx0r2xHzDQpA3KUvEDO7mOIntTALEX2vg5j1CN
 rnGZUlEoLRJJKQ1JGT62Zt4UzvH4szREuqelNiM4/tukp3/q/V6accUZCNXiQokJdn67kLd32z
 ncbPuEnWP0GMYGybLEpao3Uii9wXdcn671j/ioBAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nCLxw0SHqx1x703rvJNq+CGCwDIzdOix84z/8W/NPq0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmWIg+9hiNPQi3hS/j24txtVKA0c4i4n3/uiOir
 Bid2uW9l46JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZliIPgAKCRD2t4JPQmmg
 c11PD/4kRSW5fUs+Gs392EvMInGG/OuwY5HH3GtpgZcmLydVHZa0HGRtg1d6oA+y9YQNaVnDOf6
 bZ0WcmJQcyRZFHAaXs7ormxFjbsvAI3eu72cT8PWZJZ/0eELU1RbRzmlqAu3xJqcF8L7NNYn/CW
 u4cvTun5M2pov/y1bNfbIbo+NzMoj/QGGCsQnCMI6QpHfMmMpvcSwJrq4Ah8LLBrmZgCSusAcca
 XIJcuCCTZ8kkQbTjCxfYQ7OeTX36g/kVH/+uzv0SIPbzIp8wXMo41ynaHS+ZMG7mhJfIwVLcQSR
 EV5mOMyNScKRUBwNovCwC/NCwIGgelP59xmzWUIQSkjTTAHbtwW2jygoJNu35fTW7TuC5OSaYVZ
 X1rZK7FY/Mwb+4OyPj/Qrk4eFQiVmarm4pKa5goE0PTnt1FOr3+yL0EmaqJy2hI7WtDm8XP/owY
 ZJ568QJ93VpV4RIwdXmEdYr0p33Y36sl2/QuEpwczriBMS9/v5y2pr+JbTm6dL5FnDBaNt17ONH
 TEHP2TFls1JmDMCMdlEzAS9PzmZlu31ZnG6BkkkUaorzWHdgykbcg3xZ113B0+AuPv0i7b48K4s
 VPUlKLG+etZs6Mc1sUBxE9iJiOYXLZ82JRLVPegaPppWydnc40fU19PVZR8RTtbIrrA3GqKHbF2
 vNNPrQ9eg347Zsg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A general documentation about MPTCP was missing since its introduction
in v5.6. The last patch adds a new 'mptcp' page in the 'networking'
documentation.

The first patch is a fix for a missing sysctl entry introduced in v6.10
rc0, and the second one reorder the sysctl entries.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Patch 3/3: Fix a few run-on sentences (Randy)
- Link to v2: https://lore.kernel.org/r/20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org

Changes in v2:
- Patch 3/3: fixed mptcp.dev link syntax.
- Rebased on top of net-next (Paolo).
- Link to v1: https://lore.kernel.org/r/20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org

---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'

 Documentation/networking/index.rst        |   1 +
 Documentation/networking/mptcp-sysctl.rst |  74 +++++++-------
 Documentation/networking/mptcp.rst        | 156 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 4 files changed, 197 insertions(+), 36 deletions(-)
---
base-commit: c53a46b16ce2605181688ea6af5f6c8d7fb3c9c1
change-id: 20240520-upstream-net-20240520-mptcp-doc-e57ac322e4ac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


