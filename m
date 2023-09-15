Return-Path: <netdev+bounces-34195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B207A2940
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07F4281E38
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CB1B28E;
	Fri, 15 Sep 2023 21:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27151B275
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 21:22:46 +0000 (UTC)
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB7B8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jLZFg0wTYm+9i33cbIFEeIjqU0brYgyIS8ny2cuhfLA=; b=lTst50xYSk6VjeeIvYs/YpXjNo
	m80tNOo7QkhvO72aOYMvznnF8awc+vwxcMb4+9IJPmamaVbQRmNR6Up8rrU7AtHsF5eTiVMy0lqTS
	jQx7yZHwfiDwI5Zx73YE37+VnNWNtcH1F5YxrpWBjT6kkgT83X1PPh52pwlCMKFwyQJA=;
Received: from [88.117.56.237] (helo=hornet.engleder.at)
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qhFwV-0006X1-2y;
	Fri, 15 Sep 2023 23:01:36 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 0/3] tsnep: Fixes based on napi.rst
Date: Fri, 15 Sep 2023 23:01:23 +0200
Message-Id: <20230915210126.74997-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Based on the documentation networking/napi.rst some fixes have been
done. tsnep driver should be in line with this new documentation after
these fixes.

Gerhard Engleder (3):
  tsnep: Fix NAPI scheduling
  tsnep: Fix ethtool channels
  tsnep: Fix NAPI polling with budget 0

 drivers/net/ethernet/engleder/tsnep_ethtool.c |  6 ++----
 drivers/net/ethernet/engleder/tsnep_main.c    | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.30.2


