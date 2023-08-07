Return-Path: <netdev+bounces-24964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C5772584
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBA2811F0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AE1079D;
	Mon,  7 Aug 2023 13:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAF101C9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A9C433C8;
	Mon,  7 Aug 2023 13:24:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FsZ+SLx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1691414662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZOYaSREXK4Be+PXshGUAvd5TJdyR6dMjLlqekTJmEx8=;
	b=FsZ+SLx2oGN8oVMLZtlmC2FkrAtO04MwSxag8amAgxdHXHDeVmRNORBQvCJypAO7aeMj8U
	0V7tGptyMeVN4+CtdhhYkxDUVrF/ZA1iH8FKBMTIbTOgBE03tc2K27MrMebqmVVWHUX0Lk
	fqceUtMeXKUsM0Cop6b5AD2s2fSAg5A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aab24fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Aug 2023 13:24:21 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/1] wireguard fixes for 6.5-rc6
Date: Mon,  7 Aug 2023 15:21:26 +0200
Message-ID: <20230807132146.2191597-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Davkub,

Just one patch this time, somewhat late in the cycle:

1) Fix an off-by-one calculation for the maximum node depth size in the
   allowedips trie data structure, and also adjust the self-tests to hit
   this case so it doesn't regress again in the future.

This is marked for stable@ and has a fixes tag as well.

Thanks,
Jason

Jason A. Donenfeld (1):
  wireguard: allowedips: expand maximum node depth

 drivers/net/wireguard/allowedips.c          |  8 ++++----
 drivers/net/wireguard/selftest/allowedips.c | 16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.41.0


