Return-Path: <netdev+bounces-50318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B37F55D5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734FBB20D55
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED31385;
	Thu, 23 Nov 2023 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jwEQjE84"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB80C1;
	Wed, 22 Nov 2023 17:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1700702622; bh=F6SICOwiOdCw8V9TNw2o3NQCJI2dHWQEF9vynTnhsQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwEQjE84DA6DvtzMI3icACvoYgj787OI+Byi4LrcyrUfL3Lnk/oILP8xlvSSKiZS+
	 tkqZ95q17/24nRcBRu5J0Y4OTWk3e9Ij5GeDohzzYZKO02yzDO0MJHUtGF+yO/mYxE
	 M5po6uv9hRyqZseWH6BgLgZV0iSTQ3pfYlVcLTnk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5E62C8A4; Thu, 23 Nov 2023 09:23:38 +0800
X-QQ-mid: xmsmtpt1700702618t3s2vy8y9
Message-ID: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqus7sQ2lVdnF45OPYvA3a8yP8AoW8g5sJv3tB/wl66VgCbnSDkd
	 0X6k4HNpl54FP/Eujdu5PG8f6rhwOgAmfSX0ksjc50njvUFLJqB3tf/8zBzlSzsson0wMNTV57L9
	 7J3Tkf8z+GV6FjoFf+4cKtwJS2T+OxOqo4PDIYTWsyTn3mUeAw7rmhOE+BmnSvgGiqoUqYLk3JGt
	 9II3evY8bnUpykZvlfHVn2/1ua4V0wEwWThoS1vGtMJMe0MIRJEMEMZpS0oulNnaJmhabzlyDFhn
	 n0dtOzgBTCqCwljToFpYo2T721HZNG2xyzdodtVCV5+PSZuD32+5Mr+BCk4/gbRA94ExWyGWntgO
	 /bGny+SZzD5zJEVvYAvtu5BMXg0eMrOGympNF7rj1gzPzA0u7oK2wmMVC0EP/+LIYKitP9l/ujTA
	 Vk1NavBxPCd908HZGlUTyRKVZiWELstWrUrUzjutghVjfk3egx8KZEN85SaoR8OA9Poncy1mEpuw
	 6zP/XDYSe3Iy9qpVkDk7ZqddfycebIBjFyr8ZK1lir9y5txI8/uB13dllvu9XVYQg2FUUdk6O1wS
	 AgZhKsyvGXU4XBmiV+6QeaBW85axKNAHMaLZggXWI885M2IyVYAQ/j6+OecPWy3rbvgfaNLCj9xc
	 Wbgbwhr6NZmmG+4s7JZ3ath/EFsOWc+ckEMqAd/asWlC3ufCSC8OrjthlTOFO9Lhn8/HcysJ53PK
	 Lm8h9PzT7ZTxvv/LSQqsUpcocoRc8BHBjJS3ysHzzBmN2rxWvK1bAxmgGMdrNrAG/Xw8bqF3Duw3
	 83qnhEMWtBC6Mw/7AAbWSl+zfQxP8NFgX03UBZFzyFdLu2PxYpGHJUjPqEJdndfZ6D9PSYlSVeu/
	 JEat/XC/HeupR4k6vSWhDvY5n5/dC70/X7wiF4pzhMBAMbbmpJmE9nyB6fePr5c0ahwdZ15el9
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matthieu.baerts@tessares.net,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
Date: Thu, 23 Nov 2023 09:23:39 +0800
X-OQ-MSGID: <20231123012338.1001052-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000545a26060abf943b@google.com>
References: <000000000000545a26060abf943b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

Added initialization use_ack to mptcp_parse_option().

Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd15ec73073e..c53914012d01 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.25.1


