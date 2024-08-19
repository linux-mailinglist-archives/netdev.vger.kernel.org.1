Return-Path: <netdev+bounces-119792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC9956F6A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E81C22202
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8C13AD2A;
	Mon, 19 Aug 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e1Leuocs"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1071130A47;
	Mon, 19 Aug 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083083; cv=none; b=lyAyhlPOoBkISwViTyf0KQXiTC2X+H7XysPS0EU37WiAVMiCwCOEbLBeLtwTaNH6bFh9rlw5Jo64KNzik1U3cXWNYaU1eA/OaWuT3+UgRf5N3s1fKgUXMNWI+UU0Xx1XnuX9x0Sy8QJ3YV/n8ErPF+Ut5vrUp5SGaU8VKT6r1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083083; c=relaxed/simple;
	bh=9/a6j+JL/sPh/4NhU63pS/cw+OH8Y7Txq/j04AYoE5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YklL/0Etwrt9Tq2CGs4/NlVv3wW4CR7CeMcijHxauLCA6OGdSZQgLCk3KdILPEsynxCUadulZblL1NuUC7sdc08jipTunxCbZRT4n5iLY+WNEQ72Y+ozxlCd9tSAmid1L55DGKafY4QwNhXN3ARkn2Afn40RZI+xMrwQ9GH15jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e1Leuocs; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cbd668b25e4311ef8593d301e5c8a9c0-20240819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0+OIEN25NHHHr0CCl7NuFmNlsvu4aPfi+XVI+Vm7J+s=;
	b=e1Leuocss2Yp6NI/Ftq1ewrNASEPaLk78cN4lxmOcqaCK5Jx3IuNE9RlQoBPB4/RInB8PgC/MSmBkUELFY5WoHeuhYrPGWyoU2hLJsnkoppRyYrJ+dQmTTaAu8T4Cgl2XBHoEBg0lL4fYJNKa9thXd9sx2eBRHkwEiZUkzCOhT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:4e2a682a-93c6-4423-9f6c-7b2fa85bf585,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:283498be-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cbd668b25e4311ef8593d301e5c8a9c0-20240819
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 971798041; Mon, 19 Aug 2024 23:57:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Aug 2024 08:57:53 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Aug 2024 23:57:53 +0800
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislav Fomichev <sdf@fomichev.me>
CC: <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Tze-nan
 Wu <Tze-nan.Wu@mediatek.com>, Yanghui Li <yanghui.li@mediatek.com>, Cheng-Jui
 Wang <cheng-jui.wang@mediatek.com>
Subject: [PATCH v2] net/socket: Check cgroup_bpf_enabled() only once in  do_sock_getsockopt
Date: Mon, 19 Aug 2024 23:56:27 +0800
Message-ID: <20240819155627.1367-1-Tze-nan.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
`BPF_CGROUP_RUN_PROG_GETSOCKOPT`.

If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
"true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
`BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`
due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.

Scenario shown as below:

           `process A`                      `process B`
           -----------                      ------------
  BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
                                            enable CGROUP_GETSOCKOPT
  BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)

To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
result in a newly added local variable `enabled`.
Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
condition using the same `enabled` variable as the condition variable,
instead of using the return values from `cgroup_bpf_enabled` called by
themselves as the condition variable(which could yield different results).
This ensures that either both `BPF_CGROUP_*` macros pass the condition
or neither does.

Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
---

Chagnes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1-Tze-nan.Wu@mediatek.com/
  Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
  only once and cache the value in the variable `enabled`. `BPF_CGROUP_*`
  macros in do_sock_getsockopt can then both check their condition with
  the same variable, ensuring that either they both passing the condition
  or both do not.

Appreciate for reviewing this!
This patch should make cgroup_bpf_enabled() only using once,
but not sure if "BPF_CGROUP_*" is modifiable?(not familiar with code here)

If it's not, then maybe I can come up another patch like below one:
	+++ b/net/socket.c
	  	int max_optlen __maybe_unused;
	 	const struct proto_ops *ops;
	 	int err;
	+	bool enabled;
	
	 	err = security_socket_getsockopt(sock, level, optname);
	 	if (err)
	 		return err;
	
	-	if (!compat)
	+	enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);
	+   if (!compat && enabled)
			max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);

But this will cause do_sock_getsockopt calling cgroup_bpf_enabled up to
three times , Wondering which approach will be more acceptable?

---
 include/linux/bpf-cgroup.h | 13 ++++++-------
 net/socket.c               |  9 ++++++---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index fb3c3e7181e6..251632d52fa9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -390,20 +390,19 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
+#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
+	if (enabled)			       \
 		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
 	__ret;								       \
 })
 
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen,   \
-				       max_optlen, retval)		       \
+				       max_optlen, retval, enabled)		       \
 ({									       \
 	int __ret = retval;						       \
-	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
-	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
+	if (enabled && cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		    \
 		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
 		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
 					tcp_bpf_bypass_getsockopt,	       \
@@ -518,9 +517,9 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
+#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
-				       optlen, max_optlen, retval) ({ retval; })
+				       optlen, max_optlen, retval, enabled) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
 					    optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..5336a2755bb4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2365,13 +2365,16 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	int max_optlen __maybe_unused;
 	const struct proto_ops *ops;
 	int err;
+	bool enabled;
 
 	err = security_socket_getsockopt(sock, level, optname);
 	if (err)
 		return err;
 
-	if (!compat)
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	if (!compat) {
+		enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled);
+	}
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
@@ -2390,7 +2393,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (!compat)
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
-						     err);
+						     err, enabled);
 
 	return err;
 }
-- 
2.45.2


