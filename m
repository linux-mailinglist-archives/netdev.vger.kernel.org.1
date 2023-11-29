Return-Path: <netdev+bounces-52250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8E7FE058
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630B51C20A2F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E515E0D0;
	Wed, 29 Nov 2023 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDc1qzfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255B5DF18
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FF8C433C8;
	Wed, 29 Nov 2023 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286586;
	bh=cBOP6hhZRVsX+adSHxMm9gDVLIXfV4tYlC29wjHtisg=;
	h=From:To:Cc:Subject:Date:From;
	b=CDc1qzfK82IaxQWNF9OZLZC/lK8mkrTNwZAvXEXUy+nttMyLVWEF0x9YI1Z0i7oQn
	 792NEbORDBviqQajMbEBCkWShjMIKGdbvyv5IQHRHi0KgpmfYp9mDNVPto2TNfwlgG
	 6fzULEONfB3z+/p/Rf+13oVkI6ybMkF1lCDWaEjlIdT+u/6S8cDaE5DNyQjt0ENtYE
	 VHjeaGY13XxvOEXubhCpRBa9enKWAvhb8PQICBisj00shgx+EAKZ+DQE1EwcJ6oTo0
	 BUQpb4e4GxmBxrQg+VTvNvGiF9jvRj4HkZ06LLd3A4uYrnXUTBUPb0tqRsSsTgYL4X
	 +LNZPNOhMDRZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] tools: ynl: fixes for the page-pool sample and the generation process
Date: Wed, 29 Nov 2023 11:36:18 -0800
Message-ID: <20231129193622.2912353-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Minor fixes to the new sample and the Makefiles.

Jakub Kicinski (4):
  tools: ynl: fix build of the page-pool sample
  tools: ynl: make sure we use local headers for page-pool
  tools: ynl: order building samples after generated code
  tools: ynl: don't skip regeneration from make targets

 tools/net/ynl/Makefile            |  2 ++
 tools/net/ynl/samples/Makefile    |  2 ++
 tools/net/ynl/samples/page-pool.c |  2 +-
 tools/net/ynl/ynl-gen-c.py        | 12 ++++++++----
 tools/net/ynl/ynl-regen.sh        |  4 ++--
 5 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.43.0


