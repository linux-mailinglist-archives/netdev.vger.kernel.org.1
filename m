Return-Path: <netdev+bounces-38074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4467B8E29
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A0A2B1C2084B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE02101D8;
	Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhCZJsNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04F568B;
	Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131DBC433C7;
	Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696451902;
	bh=QfFTBi9KEdkLlgzoc5JzYXAlZ6hSq3LJtQETAQwzrDQ=;
	h=From:Subject:Date:To:Cc:From;
	b=PhCZJsNgjRFjHgA6y0xPEznwTA5TvFKpcL1iQyMRaP8vIS0rEVKMjEg8Q9Hzhgka3
	 rRr4XB8JbUJBLLX22WALJBI5vZzcxoRgkC3tAAwy9Dl9QjxuQA/uZmoIvrvt0oRD9/
	 Raxs+dulx5vfv+f/YCYPuTBVki2gEj/+oog2mDQFkmCcVz4XCD/VNQorfZ5sYwhezP
	 41c5RPBW9AuF4+DkrHMh9BVgc2z/WGAYDuR4DSv0rBwdDahuKqPexuY9vEqu5QY3hJ
	 Ds+pkivdgU0Vt88h7KoTzk0JxVI++qO9MJHmbNqacQ70t1820NspbEz10uH/9zNVxO
	 F1I4cPFFZVo7w==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/3] mptcp: Fixes and maintainer email update for v6.6
Date: Wed, 04 Oct 2023 13:38:10 -0700
Message-Id: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLNHWUC/z2MQQqAIBREryJ/naAmBF0lWkSO9Te/0IhAvHvSo
 uUb3rxCGYmRaVSFEm7OfEgD2yla90U2aA6NyRnXW2O8zpCgBZf+lwHWO4cQojfUfmdC5OdrTtR
 Mmmt9Aa+jY0doAAAA
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Kishen Maloor <kishen.maloor@intel.com>, Florian Westphal <fw@strlen.de>, 
 Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.3

Patch 1 addresses a race condition in MPTCP "delegated actions"
infrastructure. Affects v5.19 and later.

Patch 2 removes an unnecessary restriction that did not allow additional
outgoing subflows using the local address of the initial MPTCP subflow.
v5.16 and later.

Patch 3 updates Matthieu's email address.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Matthieu Baerts (1):
      MAINTAINERS: update Matthieu's email address

Paolo Abeni (1):
      mptcp: fix delegated action races

 .mailmap                 |  1 +
 MAINTAINERS              |  2 +-
 net/mptcp/pm_userspace.c |  6 ------
 net/mptcp/protocol.c     | 28 ++++++++++++++--------------
 net/mptcp/protocol.h     | 35 ++++++++++++-----------------------
 net/mptcp/subflow.c      | 10 ++++++++--
 6 files changed, 36 insertions(+), 46 deletions(-)
---
base-commit: 0add5c597f3253a9c6108a0a81d57f44ab0d9d30
change-id: 20231004-send-net-20231004-7e1422eddf40

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


