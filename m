Return-Path: <netdev+bounces-27474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F777C1DB
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAC28123A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E152DDB7;
	Mon, 14 Aug 2023 20:56:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6CCA5C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6096BC433C8;
	Mon, 14 Aug 2023 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692046591;
	bh=k6kSskohmYLd6oy5jpMXyKyL/rSesljGzXAqjwUDQEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QdxA7cMRdxwJwQM97CI3pr+OWmeTK6mWx4TYd5m3RBFev42cNqF4yA/ouQya5Hbjo
	 gf2vUueVRMYWwGg0spYjO/9jwoq4Gms3vXM9f8k9tLY4zyS5YXUMXkL17/ATpEiOUQ
	 TK1G4UktWHGF0nNh6MHYt6v8vxZCxhYmzN/xUYaF+Z0gvn4CHryY5N7TCaao6Yq8dq
	 nDdVlcIrrzY95/jlXpynaanqcyA0a2DlDpPgOt11Ig1OReu474/QpVqwWn969yOu3i
	 3qoVG9zAV4ktHu8dEwHA94e5dn+c5aS9fZNmS6FhsO4NMI/ZD2/QwkF29I6Lv9BqQF
	 cExKgBgyNtU4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net: warn about attempts to register negative ifindex
Date: Mon, 14 Aug 2023 13:56:24 -0700
Message-ID: <20230814205627.2914583-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up to the recently posted fix for OvS lacking input
validation:
https://lore.kernel.org/all/20230814203840.2908710-1-kuba@kernel.org/

Warn about negative ifindex more explicitly and misc YNL updates.

Jakub Kicinski (3):
  net: warn about attempts to register negative ifindex
  netlink: specs: add ovs_vport new command
  tools: ynl: add more info to KeyErrors on missing attrs

 Documentation/netlink/specs/ovs_vport.yaml | 18 ++++++++++++++++++
 net/core/dev.c                             |  5 +++++
 tools/net/ynl/lib/ynl.py                   | 15 ++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.41.0


