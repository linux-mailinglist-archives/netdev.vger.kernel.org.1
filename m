Return-Path: <netdev+bounces-44616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1827D8C7D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C09282089
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750A193;
	Fri, 27 Oct 2023 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1GL3PvU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F44179
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:10:45 +0000 (UTC)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734BC2;
	Thu, 26 Oct 2023 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698365440; bh=dvIPUIssHk0TkL1LRSlpPOoqG4opkQMneKjYYtEG8xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w1GL3PvUxbbh/280u6Egf+dtQeAhIXcsFFvOgx45kscTKjyw5NOgb1E5yxUdnD5p8
	 5wvbIoj9HaV8FUxb1tfkVWFc2bn/sNVf4YPH2VMJ2KEINyzPRRw5MKRZcJPyLqqbzI
	 kIARcNUbnl4GjezqEYwCuslcSJL3PUMsOCEe0tZw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id CD2406F; Fri, 27 Oct 2023 08:03:13 +0800
X-QQ-mid: xmsmtpt1698364993tihswe20d
Message-ID: <tencent_541B3D2565BACCBBD133319E441B774B6C08@qq.com>
X-QQ-XMAILINFO: MK5U7QanZrCwtOxbSub+N5zKks7NPU6Qn0dDvkn/LhQdD2W3fSqRCdxUO7YnXi
	 39DUmxEeSZyqtlo3mIJLBZifa4fCyOUwRPr/smalNWc0VCP9o8rhl4eG3yFJKlwaSKNdXfLJtkgs
	 lOjSPvJJm0XtjT7tNTO5jiKfY6DazEm/jRZe7OM8R0Eg3FhdcnDqtAzeXCO8KdzR29SlTk5ZTH8w
	 SafbirKL2O8cY0PYy1g6UWx81vEQnujFoSU1700kHMKbl0BUO9G2ucnSG3wEfEBeCnc8gC+IhLcJ
	 OyXqbw73Npy6KSmy0EdORlXVs/9XHHWuGgCZFRIFSncuw4l49Cq7REvwh0w/BwH3/0fN2TL5xqfs
	 y/zm8yQcWOswMY5aNEepdu8PSC9K8rjusYJaVmiGkfYrDOPzUyaXLMTDMqYu2lfXWU2Fe/Gbd40P
	 GQ1+nizNz9KcMM06KQl0gjVmfXgSAz9xwmzJAWGGqw2UOzdx1sV4QsY5DcdJeneMQvhqewuiRucO
	 wXmaWvFxgQGH6RshF4P5wQwgNK6B2JUW4hJs3LYNYAG09DY0J5/dmBC5VCN1ALWjmcLGekQ1laMU
	 NwyFhhLhl5hWD9gIBuLeEDCIoWyXrT/chM660i6AsenNBYmz+ggFUGj95jgEbmeOFV5UQ/umfKBK
	 +Ijp04vZhP95I0EY6gCN8RRbGi9V2qw4RJFvcn00vUDhDzs8leekDMUmUQbPgM8UXANGjAXtQHfo
	 CwzO1XuCNW7Cz3OzklIba3+FxMJGWvyHJUtyfEWfy+kkVO1jMtBJq5ffUmwB85nXpNGo/zq9oEgW
	 /GxW76hQx+l0MRcItD29hU9wcNIU5VSiLsmgoDfDpkcS8u15S5u+rLpQulnb3oexVIydTC3Yk1vh
	 eNMe6zzoV1YZbwoy37kRf3UFrpE5IEgTiEEAM1ls19
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam davis <eadavis@qq.com>
To: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next] ptp: ptp_read should not release queue
Date: Fri, 27 Oct 2023 08:03:13 +0800
X-OQ-MSGID: <20231027000313.3603803-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000910ad106089f45eb@google.com>
References: <000000000000910ad106089f45eb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

Firstly, queue is not the memory allocated in ptp_read;
Secondly, other processes may block at ptp_read and wait for conditions to be 
met to perform read operations.

Reported-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
-- 
2.25.1


