Return-Path: <netdev+bounces-30167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C678643F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8886E281405
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBF17F9;
	Thu, 24 Aug 2023 00:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD217F2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A071C433C7;
	Thu, 24 Aug 2023 00:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837063;
	bh=VMmlax7Excwowq1QUS30g79arpxXQalQDoiV4/IqYQY=;
	h=From:To:Cc:Subject:Date:From;
	b=gTYPSoFTeRMTop9Skl5uOtCkERNpz4cnySKVCIx3nM3nwDhYKOADblZJapUAopgDv
	 H/yTCcn80FXZpyCKGRol/STiqPcyKwwNcM4mV8/CYcQHwLjhTYvX+onTLSHN6OJj+O
	 aT+ixipB9OXcr/j0rst19ZaGjH1fzHwA1dumVaf2FwsfqMgji4EayTEEaqMsdeXYV6
	 Siaqf+mTR21OQgRHtVP7psgrHhZQf5+53i2fp2KtzhGYnMSErhiK8kS/nGrs1s5UnC
	 wlDoaPNxW2/2JeI/jxwtmp6DkOdJnPoq9x0aFuCdei9XkmVIzsa6LIdwSIwCRhAhjn
	 PILqsOYiyNZ1Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tools: ynl: handful of forward looking updates
Date: Wed, 23 Aug 2023 17:30:51 -0700
Message-ID: <20230824003056.1436637-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small YNL improvements, mostly for work-in-progress families.

Jakub Kicinski (5):
  tools: ynl: allow passing binary data
  tools: ynl-gen: set length of binary fields
  tools: ynl-gen: fix collecting global policy attrs
  tools: ynl-gen: support empty attribute lists
  netlink: specs: fix indent in fou

 Documentation/netlink/specs/fou.yaml   | 18 +++++++++---------
 tools/net/ynl/generated/ethtool-user.h |  4 ++++
 tools/net/ynl/generated/fou-user.h     |  6 ++++++
 tools/net/ynl/lib/ynl.py               |  7 ++++++-
 tools/net/ynl/ynl-gen-c.py             | 16 +++++++++++++---
 5 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.41.0


