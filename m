Return-Path: <netdev+bounces-23705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D176D382
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8AE1C212D8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2091D515;
	Wed,  2 Aug 2023 16:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95601D505
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095DCC433C8;
	Wed,  2 Aug 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690993105;
	bh=OBZ2S0BZ6YXa9tkeU3TFk69fvw9o1bG9Wm700GwdNvE=;
	h=From:To:Cc:Subject:Date:From;
	b=XKJEuoYzjjy/lZwVhjO2nfSsFo6Jwl2elRZTIqmV5Q+dwTXDaz+oKpnDzDIBQsQma
	 JAxJAb20O6VxdEkHSoUWVRHOzAT6/53PA6tzSC3JXRZ/5tam1shBR/S2Sazf4sFn+O
	 H1OvfuQgPa7/Tz+3ONPL1afJ4qUjn7xvGA/5xHeMnX75DhFPVnf9WL+/BG18l7xe4K
	 6+3PeVxiw/J1ZAFRC3lWLflgbMyjIcacC8vmPtaljcOGsY1IvUdw3zohFzJJLoo5d7
	 UhEA6BBssSFlvjngVVUoEJu6oZhyDhadYWR1BlFnniOJQmPvpf2QnEsFGwAmnAtZZQ
	 TpuA6wCb9xKXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] docs: net: page_pool: sync dev and kdoc
Date: Wed,  2 Aug 2023 09:18:19 -0700
Message-ID: <20230802161821.3621985-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document PP_FLAG_DMA_SYNC_DEV based on recent conversation.
Use kdoc to document structs and functions, to avoid duplication.

Olek, this will conflict with your work, but I think that trying
to make progress in parallel is the best course of action...
Retargetting at net-next to make it a little less bad.

Jakub Kicinski (2):
  docs: net: page_pool: document PP_FLAG_DMA_SYNC_DEV parameters
  docs: net: page_pool: use kdoc to avoid duplicating the information

 Documentation/networking/page_pool.rst | 110 +++++++++-----------
 include/net/page_pool.h                | 134 +++++++++++++++++++------
 net/core/page_pool.c                   |  31 +++++-
 3 files changed, 181 insertions(+), 94 deletions(-)

-- 
2.41.0


