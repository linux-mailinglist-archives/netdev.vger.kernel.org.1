Return-Path: <netdev+bounces-46203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EE7E25D7
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DB328116C
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BD2376C;
	Mon,  6 Nov 2023 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cNPUcOj2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526101A71D
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 13:41:43 +0000 (UTC)
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D1ED8;
	Mon,  6 Nov 2023 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699278098; bh=cDDdtF+lljV7pn/L6PPw2wWs1zIAvruOvia18LhrCpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNPUcOj2zX5heTW8tYrxbcUPuK5tPE/myS/nvnK5xHbHO8NTnuNPYM88q+sPd2p7t
	 ixWS0iQ0C+5zdLrrhuDFey1L3AO9RdUv4y98786L9iYKFgAlFt3b1isQoHkPoJgJrK
	 XJ2+K8cNhvUkX8/AEk/2nRrAce2VDLCNQta4diYk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id A6233279; Mon, 06 Nov 2023 21:41:34 +0800
X-QQ-mid: xmsmtpt1699278096t58dqzev6
Message-ID: <tencent_013600970237A84AFC740377F167F03D2109@qq.com>
X-QQ-XMAILINFO: MiPTq5wGoKOmgKwMic1eu/LYMJO9JiRPxRgOUHmuCPLKX4Topaga83rM6lqIZS
	 8Cont9d8/jn3djbp/TrCyi7nBHJp8x+KytQC9+BhvDNCnESqEZ/Zn2TMtfjrJZlMhngUjs95OoL9
	 Qrz/2z0zxSLrDB93CCRl5Pr28ZFzudbof49LsGeKfctNCuMZqR4aYeUnwycJBp9m6HPzvWTCBQZU
	 OKa2SpTLpFxMh1SVGvndjG9D36wQXfWVOMrucSRQqK+cHJZvmsL7Cfj7EYntoVRMlIoO6aRBtXFq
	 Z6D+hfHxANzV3tr+hRv0j79adVyoqjOF+5O57sSOiy5vJpm3lhHX6K7KkHAWeRWs1yU4undxHWRJ
	 o+luZ11shxDC+bpjPXZx1WrLHRCx0Amw/dNvO8xFKdEw8TE5wI1ufRp8qJHTcZ8RhxugjlscK78R
	 YI7dH8/ijMiYKzTfnf9jSIv1EtSIe0URSADDLffEvT/dRkm2P3uMAiNWPm66LqMx2Jy8QRwQxero
	 CW0k7FMRXJaUp7nEe2Dxc+H1NnwB2ujqMl14qubeHNmZivTbFz4U6c9fGX6uy8cIkFCMHS4sYdwB
	 DuMskGWDwlHjWK1EKCkv5ObcoNdreQp5PVy0ZFOfW6opaoX+7YBX9cFmxoQTXbyk3ncf2nULj1jK
	 J5lfVz455FZXLeU1WTFPsAAEHw5Z9EONfaIrrEw88Xj/cQjAIsPqdFrcmIOEQHmjg8A7IrKbYyWJ
	 +NhKQK/+IylclrDEPRtjmVOnumVTOMR96A5rK1S3I3e5BXMvIQdY1h6yyV0fU3O7GKhrWFvGTQ2O
	 9f42afWN5M7b/wgd2iccs1zYBzZigWShPxhSvc3Ml6miL1jsNw1YgvNhddBtiMKHMGzVnK0TgEbY
	 fUBWgmzQPt8YvhTiIHdCLq4SV95/YCDY+Txjs8IhCAA81oyj1qrBqU2LyZmIHRAdg64E45wJyp2n
	 00D1VF8qeF70rbdGGtMiicuCiLTrfdJyaUg8BEL2k=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH net-next V7 2/2] ptp: ptp_read should not release queue
Date: Mon,  6 Nov 2023 21:41:35 +0800
X-OQ-MSGID: <20231106134133.3882778-4-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106134133.3882778-3-eadavis@qq.com>
References: <20231106134133.3882778-3-eadavis@qq.com>
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


