Return-Path: <netdev+bounces-22042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3008765BDF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E9E282354
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C4198A7;
	Thu, 27 Jul 2023 19:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3818049
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114A1C433C8;
	Thu, 27 Jul 2023 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484852;
	bh=5gGeiTj6gOhFvSTDnUiiFPlTneBaUWq94DotKFfr8Lk=;
	h=From:To:Cc:Subject:Date:From;
	b=aWaH/pwPBPLBT953eqTznWNvhAGKTf6Q+0pxUpUn+0XQlvjLt2eBNhufZ7FIAEqLh
	 WwjMf2KlgCY2a/tu0nUFSps44VCbpQVT1tIsC1ycvXw12yhQWEXFMX4SzeulvLbl/1
	 lsL9p2O9IqMmqKeGShM0G1ymxZOdBRkD5C2ScFLHVDKhkp6Ww/xbVvlAq3OgyMrGub
	 zxJV8o512XHfzdR+y6r2xiQoclbHGI41nKg7BzX44DulOlL/+EW/XrrKF9ab6qUt4K
	 Kh4XDuiOEKgfn1PYU5vhNSn2wRD4tu8Ezm4J6kd8MuiiuRJkHdqz2jIIz5ABHRvt1C
	 hvo1+oxr3kQ5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] eth: bnxt: fix a couple of W=1 C=1 warnings
Date: Thu, 27 Jul 2023 12:07:24 -0700
Message-ID: <20230727190726.1859515-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a couple of build warnings.

Jakub Kicinski (2):
  eth: bnxt: fix one of the W=1 warnings about fortified memcpy()
  eth: bnxt: fix warning for define in struct_group

 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.41.0


