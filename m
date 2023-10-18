Return-Path: <netdev+bounces-42310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86907CE2FA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6159C2812B2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C83AC07;
	Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Ji5+h2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD037148
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B326C433C7;
	Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697647162;
	bh=RHtazj7/pDnXSZbQIWffV+jxrFQnFgwxA1196GpucUA=;
	h=From:To:Cc:Subject:Date:From;
	b=o3Ji5+h26IQwwl58xoZfMIveb5jMZ225MvxPqtSTjSfmtEtmEih28XlIk8RjE2YAM
	 jxNwOb/P3+n/6q1DtaaArOt9HFxa4L6ZHFVoqc4TJ1duCxnhWn5sr8uhPI3IDv47Qr
	 oNNtqSNhRhFVfyQBMGGIwGPDot54phxxk1wyaDvlt+Ly+t6UfI3rFPnCYFu24A166s
	 sPzCCrn8ygvA9u6ibHJLlp7ZhHhZtY5S+qUzBelQCp3/M8qwQ5dFjYrT7Zs8VjjcIe
	 WPQcjIwczUss6FhwRG7D4v3ri7lwujVMOrF3vWiFgZylecvoiwMPkEqjPaqIQ+9/hy
	 q7/Lvq9wE4O8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dcaratti@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tools: ynl-gen: support full range of min/max checks
Date: Wed, 18 Oct 2023 09:39:14 -0700
Message-ID: <20231018163917.2514503-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YNL code gen currently supports only very simple range checks
within the range of s16. Add support for full range of u64 / s64
which is good to have, and will be even more important with uint / sint.

Jakub Kicinski (3):
  tools: ynl-gen: track attribute use
  tools: ynl-gen: support full range of min/max checks for integer
    values
  tools: ynl-gen: support limit names

 Documentation/netlink/genetlink-c.yaml      |  10 +-
 Documentation/netlink/genetlink-legacy.yaml |  10 +-
 Documentation/netlink/genetlink.yaml        |  10 +-
 tools/net/ynl/ynl-gen-c.py                  | 115 ++++++++++++++++++--
 4 files changed, 132 insertions(+), 13 deletions(-)

-- 
2.41.0


