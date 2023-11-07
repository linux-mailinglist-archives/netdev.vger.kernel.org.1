Return-Path: <netdev+bounces-46365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B497D7E3627
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984FA1C2093D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF3CA75;
	Tue,  7 Nov 2023 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QgJ6PrhS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B77CA6E
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:00:47 +0000 (UTC)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895E122;
	Tue,  7 Nov 2023 00:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699344042; bh=Y13edSMPHSTeEjO4Q2T9XMLjGfxpFO+4U5U506LRl6w=;
	h=From:To:Cc:Subject:Date;
	b=QgJ6PrhSIkxp2QSK9llo4k4rBfFqW5XsjbZlNQbyFAM/UyZ/MZoq0vJvYc2i/7kHz
	 siCdnYr0xXbd3qCpSP0/H0O3bG0IyWtQEq+AMe08/Q31FMyzTUH15aVtHL43cTTOZZ
	 0Yv7rlug7iNtvDP3Gs3nhabykPL3IGYB1hTQJgiM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 278C277; Tue, 07 Nov 2023 16:00:39 +0800
X-QQ-mid: xmsmtpt1699344039tpv5sb9xv
Message-ID: <tencent_18747D76F1675A3C633772960237544AAA09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8tFugrFYQ+3Wix8FlP2Gsy0h2yucQcoYwN2n0NKVSDpBhqJXEWD
	 V/Y2cmflXS2EzCnHedqj4pMynetU3KC5j0gkJ2h5z9iQ2MU0gA36QLYJrdik28SoQg92tfPBFqK7
	 YoNYWJ5uRiSYDy9bcnyDsjivDJK54mhukxQ723NjLgZdCoS6czS6hIE1AB1mU0NJn2cXuZ3Jm6qQ
	 adsAJqDI6zoLzKxM1zpuec3PqbNgwa2lHd7MXrWyj7vsQ6vhngGibMCJsp2l71bBPAZ6gjQyPxLW
	 zhtthg6+QEghKoNBGAz+l/n9OTV1oUo/8iGkcRW4QS7RZrNIdmxuoT5OsHudbMaC6OYVjX+qId/R
	 wEM+h3ZX3nPZEOwWaOBt1ek4gssKLjDhWQySXU9hIUfUEndJXvPqK6FxEm3isrmL/ClkHILG5Rm3
	 ZUW0/LqDpxvJ5MVvhG/FmpQDqENgTgzKJCGxaJ0a1GYhTgr+DEFT4KojlpriUFWyG7fOxNjgaPGk
	 JgxiX8pO83/0It6wm2dfase5mFUvwK2MMLTJP4G9hLJv34NN0PHKpCBoOO3dlJqT1UkDH3JWEjNO
	 8LWj1F0L+UEAHse1B+m2T1iMhelaJUcccbjQ47s/46JE0Po7Q1bOSrZbiXEP0LwoWtcjGkTzrQRO
	 Tqn2MkPfkF7oca3TkfgFpyrULHyqYWgbUd5mg0B8JLpK4xMAvHBf5d2KBS19q+EVKz8rJNpM0nHk
	 QR1j/5j3WsQgXokxGyPW8LpgnpWA+xjXmgih2yhqVcGv1AWJlzANBcRKxpW1ifTMZdD43GHr7nXp
	 4kWyR7zCyw49Z5QxbdG5WGq5Icsxa9OJAJGoESQDDSJowboX0S6y2Y5nqMFtdHDm5uVjpAAKiiRN
	 3eupL3B2Qx2xO/fstgkQfIzhn7o+xz4pnC/FA6UIkOviz/EV8t776zQ3GgTt+xqJQVRxgkr8qRxG
	 COMVNkS2I=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net V9 1/2] ptp: ptp_read should not release queue
Date: Tue,  7 Nov 2023 16:00:40 +0800
X-OQ-MSGID: <20231107080039.436253-3-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly, queue is not the memory allocated in ptp_read;
Secondly, other processes may block at ptp_read and wait for conditions to be
met to perform read operations.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 473b6d992507..3f7a74788802 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -588,7 +588,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1


