Return-Path: <netdev+bounces-48284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D687EDF30
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CC7B20947
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B072D786;
	Thu, 16 Nov 2023 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nESFa4bF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DB2524F
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 11:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89199C433C9;
	Thu, 16 Nov 2023 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700132979;
	bh=AQ38LoocJGoRF+gIiYEf6xsuX4n1NAqE6Sh/zFnSIo0=;
	h=From:To:Cc:Subject:Date:From;
	b=nESFa4bF3BGTqlqH/tn28UCpGTS/ogaOhDk0t5Cue62Jb5rEKEHFr7iMwarfC9QqR
	 g/JsU8DYR+jrYziT8RoPtx9on3NKhjooYRlLeJRBpPKQ+c+VlM2JCmp7ra5md/w2mZ
	 2OIF8s61d4Oal/5+rPzxxg1IMswi3QK2UFPHUPiHyZOmHr/pb9oUUyQuN1lQHxhOvw
	 2Sfg0GINXxojJo5cnIyyZ/0t+cjvnZZFj+imv/SFc8EANhAA2G/iC1iyfYo2yjlnOI
	 FDFMYthsKWByznxaMfJKx4vi//xtBK5KqFQTIvi08I1Y8mkG3FKJ2FJUmtTk9MxGUi
	 4Fq7VKS0+UuVQ==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net 0/2] net: ti: am65-cpsw-nuss: module removal fixes for v6.7-rc
Date: Thu, 16 Nov 2023 13:09:28 +0200
Message-Id: <20231116110930.36244-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes warnings during module removal.

cheers,
-roger

Roger Quadros (2):
  net: ti: am65-cpsw-nuss: Fix devlink warning on module removal
  net: ti: am65-cpsw-nuss: Fix NULL pointer dereference at module
    removal

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.34.1


