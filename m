Return-Path: <netdev+bounces-76763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BAF86ED15
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EE01C21510
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1343B5F487;
	Fri,  1 Mar 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drtk9AnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99845F47D
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337373; cv=none; b=oOYk0vj9TZAR8Ix0f7MNc6KPR0nZQpdMa/UXU+p22tH+lE9O0I6vPkuPWSlA1/D/l815w9y0SYho0oZuO4qUrkd3Jxa1Uy2+J9nLSDrkb8mKquZvgzV0xpF+fvki3Ze59zW50EG4zkFp9hzgaSXkrOtMkZ0RUaMjQHwtKtGqCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337373; c=relaxed/simple;
	bh=VhCuvNgY32vudBzzsVbSXhjkNzOu0bkIdAkCDzcZ0jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYc2u1HsBVtRkK3ZiHRICO2P7MUhZGeoVVu7XpCAilOE2pDgcsgJLzsEQc3h070+2cQNN9mTPoVyfLkrWiIGcBuMxcWGzH/o614qBYydyVgDeNBqeWG07YzYgIJt5Z7b7iqmQOnS+oj8606JYsy/129dTvygvOIvIdQDuh8hb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drtk9AnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A2C433B2;
	Fri,  1 Mar 2024 23:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709337373;
	bh=VhCuvNgY32vudBzzsVbSXhjkNzOu0bkIdAkCDzcZ0jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Drtk9AnFuJ+dFdJ7xZx1Rmx1M8dv0qYDhF5BzJjtXwyK3zwqUzILGrCzI0M+czD1t
	 4G7uAsGZZbPlEiCQLkW9kDr0T1yB65eD5CaLkCYTbZaxQ9+ibPn+orezSmMsOM5Dpq
	 lxZtfFO1tAgs7cxKgS3ZeR0qSSkSjxo+6df0JmKXQw/nPwc3FqLySYJprTS/fAf4kq
	 EhbK7LAx+irWxhSiMYKZlhK6h/IbwxSCBQg8qES1yvV1oH7JKJ4FkKVvSKJ3ARzZsm
	 aPn0vHdAqHsBHon7NnvGUflM9CebOwQ7DT04sepi2bwc1Tuf1EJiBeqt3WK9mq1Ymj
	 ///Bx3vOchaeA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] tools: ynl: remove __pycache__ during clean
Date: Fri,  1 Mar 2024 15:56:09 -0800
Message-ID: <20240301235609.147572-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301235609.147572-1-kuba@kernel.org>
References: <20240301235609.147572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build process uses python to generate the user space code.
Remove __pycache__ on make clean.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 2201dafc62b3..bdd6e132e58c 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -17,6 +17,7 @@ ynl.a: $(OBJS)
 	ar rcs $@ $(OBJS)
 clean:
 	rm -f *.o *.d *~
+	rm -rf __pycache__
 
 distclean: clean
 	rm -f *.a
-- 
2.44.0


