Return-Path: <netdev+bounces-155535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F5A02E5D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2F1886B75
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D561DEFD0;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAU08LKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D561DED77
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182469; cv=none; b=bvBuphs1x30TRXFfDSNlZC9ecZmSvh13ma/aXu8wNs8dz6HsRox0uq0ZquTUvt9UzSlqUHuuRKP/TTdY/XfpJLbslVeoYkrlHWg2saFO8JjkMsYBTLV4C0OKpLbhjT9nFHiOSlPFLsmJQJwNjCSWgyOmbuFSXAwSrJ7Qe1Khx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182469; c=relaxed/simple;
	bh=0K8nkZkkUAwNQvcici+/jFPvANpplDfTRnndty25nwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNPA/huIEwbDvYklLFYyHZ+41EaWiraSExeQezIZDodMT2274ww6esSFTDuyz7YwsKQ53AzB7uEqiFjfw3qsUwzdQm4HEcmz87Dz8vdId8stHKxhkkXqUMxmFZLxaaRvCWc4hCp5h5NbnEEALyaVzSrwGtAj/qRmO3b1w1gSvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAU08LKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A70C4CEE5;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182469;
	bh=0K8nkZkkUAwNQvcici+/jFPvANpplDfTRnndty25nwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAU08LKy674wF6d+AqylN/l1adq9sdeQruFTTWHsrJtpUfrXKy7HP7Q6Ghs2XOUUF
	 12ZswcCij1vVZ59IhLS+zbE6I2oWr5ZbpPjJ9sNmX/eoDBLEjn9+zVXc7G9fEXz9JL
	 0jfB8J1Ox7hjQIbfE+OD8FyI0yojyTKU+13g2sdJOglK2Mxk1Kjox2uVhXfb46ehQj
	 +Gp7LDr1GRYnUY4cSUjmXbLl4OkQnpJHDrOKabAg02ulVTW70vmVAngm7bw3NqU4wE
	 RYTZCvYDiIAajIYfog/z7H9Vcyh/RT/jnWyew4IfDPD3pXiuNAnXsbkfebrkokiXDI
	 PmV/xwtLIG/+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com
Subject: [PATCH net 7/8] MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
Date: Mon,  6 Jan 2025 08:54:03 -0800
Message-ID: <20250106165404.1832481-8-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Noam Dagan was added to ENA reviewers in 2021, we have not seen
a single email from this person to any list, ever (according to lore).
Git history mentions the name in 2 SoB tags from 2020.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shayagr@amazon.com
CC: akiyano@amazon.com
CC: darinzon@amazon.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c092c27fcd5f..009630fe014c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -949,7 +949,6 @@ AMAZON ETHERNET DRIVERS
 M:	Shay Agroskin <shayagr@amazon.com>
 M:	Arthur Kiyanovski <akiyano@amazon.com>
 R:	David Arinzon <darinzon@amazon.com>
-R:	Noam Dagan <ndagan@amazon.com>
 R:	Saeed Bishara <saeedb@amazon.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.47.1


