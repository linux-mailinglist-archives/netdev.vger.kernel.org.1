Return-Path: <netdev+bounces-77075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25318700E5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6047EB22414
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93A3B780;
	Mon,  4 Mar 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="0flbXOWE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="I2KqydAD"
X-Original-To: netdev@vger.kernel.org
Received: from e234-1.smtp-out.ap-northeast-1.amazonses.com (e234-1.smtp-out.ap-northeast-1.amazonses.com [23.251.234.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE3C1AADF
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553727; cv=none; b=AnCvJTlmCHSaWstwGEjiJi4g6oEfDOfiiQelRA2BdcK7vOsfSAKLx5uAVkFKCaXYZ/ee+Ct4LRiU190wdDH2LIiR4ikoZ6YDY3Gy+PrYpzDP5XCaUwV8FsCyiNPuKZ/9R04qLwLZUVIS/5bvltuZeu17mconHFQGao/HgucDfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553727; c=relaxed/simple;
	bh=QepRHYFJdc06URVTMOi5P5ff9iw0ruMHtF/wjMk2ey8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMyQfufIhzZ1Gi4LdB3tP8PLsU3dUFcEivDSC+HE/17ilM6fpJGxl9vTJTR5LYDfAwFmGWAg2SzHnoJPS4SwZ1IL731h/5KOhYmXhmLxzKkyndDppKAWkXOp77fBWvCKboW/CtQL4JK+eZrBEfCETCl+LPQFNoUuSJw6q7JjA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=0flbXOWE; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=I2KqydAD; arc=none smtp.client-ip=23.251.234.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1709553724;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=QepRHYFJdc06URVTMOi5P5ff9iw0ruMHtF/wjMk2ey8=;
	b=0flbXOWEByGVK6trtxJ89+R/lYk6HvD3lo5Y4iDTsjNWcOeHFdfFLhQ5nA076e4z
	cri/Kw2c6Ex+P2AG82aOzG16tMkq7w0YScGKRVkFLvUtqp33nTPyoGsuBNlcScRhYKZ
	QAHkAMkYdU+R+bJZm2px6cZ/sqz6jojMFV9sjMBMdNDYkA/MIhgz7ZAdEirJF94TgAo
	3wXcZindKQOs999ktFLJRXbByFyNF6++tEwOhMlKcxFATvQrjzhgO3mdqMb5zdva0Sm
	aVMP6sda1nnsjhRWQFgWT5skNyV1ECvE+Wml34hhfeYluUrbB/VxU+bnbRVFC+GXgw6
	NAwesixIZg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1709553724;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=QepRHYFJdc06URVTMOi5P5ff9iw0ruMHtF/wjMk2ey8=;
	b=I2KqydADU4ERpADh8VrcLQihQu6yaKdDXtz51CG6rGPd5ZjXkmNqk2Tx06RqbKJZ
	aC6VxIba7x4burnXlQrX1AU9QYpOOnKD7CuXHqzVNRa4Eex4WjxHCT/i/hpY5+2s04F
	wB/16WRkj8dk2g4TlBuVb+Y2+2UZ69QQ/RAa3Oyo=
From: Takanori Hirano <me@hrntknr.net>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH] tc: Fix json output for f_u32
Date: Mon, 4 Mar 2024 12:02:04 +0000
Message-ID: <0106018e0957ab86-fb96e2a2-08a2-4e7d-b23c-e2ccff627d0c-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.03.04-23.251.234.1

Signed-off-by: Takanori Hirano <me@hrntknr.net>
---
 tc/f_u32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index 8a241310..59aa4e3a 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -1342,7 +1342,7 @@ static int u32_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
 
 		if (sel->flags & (TC_U32_VAROFFSET | TC_U32_OFFSET)) {
 			print_nl();
-			print_string(PRINT_ANY, NULL, "%s", "    offset ");
+			print_string(PRINT_FP, NULL, "    offset ", NULL);
 			if (sel->flags & TC_U32_VAROFFSET) {
 				print_hex(PRINT_ANY, "offset_mask", "%04x", ntohs(sel->offmask));
 				print_int(PRINT_ANY, "offset_shift", ">>%d ", sel->offshift);
-- 
2.34.1


