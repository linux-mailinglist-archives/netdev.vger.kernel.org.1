Return-Path: <netdev+bounces-151870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4769F16CE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A700E1886195
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB018FC6B;
	Fri, 13 Dec 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZfrCs8G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394918027;
	Fri, 13 Dec 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119669; cv=none; b=o8OuQq45X8JgYAn87q0GRC+QiGbqUFSQNi/C20EismdxNqUwczHimg578v6VarS9Y0BqYC4lPRPlfQm07RLD+6gQpD3zs+jMFmslw0zBQI+0b6YdhnDSkA3QGpoB577ve7XtoavpSYLLYRyc3XrlsJGFFCEsJbQT5Jb0UmVfUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119669; c=relaxed/simple;
	bh=1SuCCczWgEEZPVHAwfNRApsTYS5wZY7OUO6nCzu4LLc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rfsAzSMqnKqndmiMxKBFgrE0PBrXVmut27NbVzLzIioYfUenbYQ9TQKDNbi/QlIyxEK1vx/jZRN6LRccPUNhqY55IYe9ZQ4IvMeixeOrfUdolsYlObNGLw61uUIkD1vQlDinQbzaCqq07+aZBiuIZQvFalqRm30iuEDfQ5EFlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZfrCs8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D256DC4CED0;
	Fri, 13 Dec 2024 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119668;
	bh=1SuCCczWgEEZPVHAwfNRApsTYS5wZY7OUO6nCzu4LLc=;
	h=From:Subject:Date:To:Cc:From;
	b=RZfrCs8GfBm7Vp+KkrxEc0Ifk+T5Kv7IfJhVx4+OXjc/FV6z0olv57E7MFf7gWVVq
	 EzmxrwyzapA63/nIM8szWZWgtgdcPFv1DxRGhvNweNkJ09NgT06nKFUpQdHaV8AGk8
	 i5127ICo/4/SqTqCctx6Yq9irl8Vw/Y6sW05jHlyY7rkqq0JNjeRlQqRNA+QkhT5sJ
	 VwSnevorynNH1WLcJuXkghpTOXOGJpsZYi6QepYsBkJdw2sY3XYP8R/QCfN+FMXa6F
	 YtARWNgaKXGZfpovh+2gdmO6yJj8PiyTMufnfwT6TCH9DKkfW0pbItapd21czZ17pQ
	 Qv4lEXBFPNGsw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/7] mptcp: pm: userspace: misc cleanups
Date: Fri, 13 Dec 2024 20:52:51 +0100
Message-Id: <20241213-net-next-mptcp-pm-misc-cleanup-v1-0-ddb6d00109a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOQXGcC/zWNQQqDMBBFryKzdsBEa8GrFBfpONaBJg5JLIJ4d
 0PBxVu8xfv/gMRROMFQHRD5J0nWUMTUFdDiwodRpuJgG9sZa1oMnAt7Rq+ZFNWjl0RIX3ZhU7Q
 9tQ/n3s+OeygjGnmW/X/wgruF8TwvdPju9HoAAAA=
X-Change-ID: 20241213-net-next-mptcp-pm-misc-cleanup-26c35aab74e6
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1SuCCczWgEEZPVHAwfNRApsTYS5wZY7OUO6nCzu4LLc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnXJDxqkRJPFt42+cynphJw8LIFCeCpke6RvE+f
 yKn3p9o42SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ1yQ8QAKCRD2t4JPQmmg
 c0ETD/9UtNP0gtkaIb4NaZc4AfjMAtMoliJI2+B9purXNdxXXsXpMJlVXgOrmGWHUSCCBVI3R9F
 cT4SnsTpjQi7AmXf21G+5EfVQP8IuwBYragiQSRNu5wXJPlVkIT9+sg1vcbwHkl5Or9iBjEn1WK
 mPVdo5D7/hz0wKc8CiokzwAyjLIAwHcZK1oiAG4WSGjYDX6vgbxGVFwXRLRysejq8VjicE0cVRN
 87jFhWBpGC1/hSbysqjkZFfoQQAM1bHTqSkU8zOQW/O9thumZZ2qdR7ySvlLCIA8jDyZ2ZZg/4N
 7oX49y68Iu9tDsCWmednyOyH0fsuxOcPJI9pewfkFba6zr3gs3irtpzPatYgkwVjujFjuvIGWex
 9i2/frTcRMRAhBjFeTHMJHOFGThBoX6wvaEQ2UcKtwVmdd/8jra/xPvhnu8ntNOrWI4s1eHcfCv
 K29w7baY/5gX95w8HvW7O+w+QIXMQEvvZ3ZdDew9Y4ckCEsWUJN6+3j0ShP1H/HLJIib4rUSNYn
 UFE68DBtAeJawhNO58janfMeD2GfQ2trnoZUUxyIblRdF0UtM/d7DgUak8bCYDYGHsRtFmEVwA2
 AdXF/DIBM8afTnhWzlttCytR98mJElasE6UAPIiTN1vhORDksjgb35YhVH/lYgoxMu2Okvljuxh
 c5BB6HaY4UxwaJQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These cleanups lead the way to the unification of the path-manager
interfaces, and allow future extensions. The following patches are not
linked to each others, but are all related to the userspace
path-manager.

- Patch 1: add a new helper to reduce duplicated code.

- Patch 2: add a macro to iterate over the address list, clearer.

- Patch 3: reduce duplicated code to get the corresponding MPTCP socket.

- Patch 4: move userspace PM specific code out of the in-kernel one.

- Patch 5: pass an entry instead of a list with always one entry.

- Patch 6: uniform struct type used for the local addresses.

- Patch 7: simplify error handling.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (7):
      mptcp: add mptcp_userspace_pm_lookup_addr helper
      mptcp: add mptcp_for_each_userspace_pm_addr macro
      mptcp: add mptcp_userspace_pm_get_sock helper
      mptcp: move mptcp_pm_remove_addrs into pm_userspace
      mptcp: drop free_list for deleting entries
      mptcp: change local addr type of subflow_destroy
      mptcp: drop useless "err = 0" in subflow_destroy

 net/mptcp/pm_netlink.c   |  46 ++------
 net/mptcp/pm_userspace.c | 295 +++++++++++++++++++++--------------------------
 net/mptcp/protocol.h     |   7 +-
 3 files changed, 146 insertions(+), 202 deletions(-)
---
base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
change-id: 20241213-net-next-mptcp-pm-misc-cleanup-26c35aab74e6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


