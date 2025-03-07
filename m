Return-Path: <netdev+bounces-172891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1CA5668B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD593B31D7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DB219316;
	Fri,  7 Mar 2025 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6lYpmum"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84F21930B;
	Fri,  7 Mar 2025 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346530; cv=none; b=eJdTZwoiWcmtMnycnrwgkhdOzuEWHu/x5p/2z24IV/kbr137AsCdhW/z1lWkM6ihoG3+/1eXwCK2O3Fc0/we/hquYJcFvgAbXzRKNAlgLgnnLnrEQAeZjwNdoVoF7I6Gxmisl6fl04U5OMvg4N2fMcDtJcExAfh/AAppzVGS0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346530; c=relaxed/simple;
	bh=hp5HO/k93TNcBn0W0JwQW6l87gCmq5xgPkSiG2J/g1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwC8+xu8A+kAhPAnmhEJO78HjeoTg/z6pt1VwujS0lm8xirsUJUd+0LbpmpKsjCZFJeceZ9LaNft2xv/J/A+WNRHTr4gBtcwN84DsQYSUgnYwnNBHfsHcbKeivtsb40whXIUb59xtQ+/pJMw8pITX7rCQRJoZFDI5qe1ABdAMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6lYpmum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD65C4CEF2;
	Fri,  7 Mar 2025 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346530;
	bh=hp5HO/k93TNcBn0W0JwQW6l87gCmq5xgPkSiG2J/g1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u6lYpmumacqiMBz9KSxeX1VqS2G7rS2RnT+cGx6orHRgL3VkJanfCEO/Fh9v/DeUm
	 tgSpS5PiLX+tO/KWgzNnJJuBtDjirpm5KshBMg77nf8YEH/3gTMH+FkmAFa+KAxnA+
	 Nv8XwV8vuDtbQGWfbUSKLVtW0FsV9V9Tl3TQo6qObFj0Spw7MuHCnCl7re7zNagMPZ
	 tvoy7hS9EMN2H1//3Sqzx/4MJeJFdBIeDGLlYU+2mWCh5ua+ufbQtS315ScZ+5vGAK
	 +09QVLKlbA9A4zmCwQLi/XewrlsBW691urqCcVU+witOpzsR5EY6MPwDTiqkkbxDyd
	 bDvJc2s1Y4qvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:49 +0100
Subject: [PATCH net-next 05/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_rm_addr_received
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-5-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5468; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hp5HO/k93TNcBn0W0JwQW6l87gCmq5xgPkSiG2J/g1c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRy79kMP8pXprzsfeK3YwpHdD9OY0Oxb8wz
 FQQioQQHZmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c6NeEADf/8Ne8/KuOTnI2Z8Oml9ydQf4wyR2pC2psFE+3EwR7CzH93rh+ywJctTPfZss4Th3lPw
 FoEBYeIHJDKYI5Q3KqxZHBmFnLpt/x5iiMjMkia/tu3EG1v4dYrTgSidVR7Ts2COw6cTPSyLZkq
 LQhAJDRdSzROLOQMz2VO39xror9BY97EbNdPGI6SvJQtAaRDvRrDD0egrCtATFKymlAn23KhBWx
 4LWLWXqI3gWW4qna5ykSkzuzx+C5NhiSjtrRT9JeTNcrTLCm0J7UeoxuwEgb5LXKQvgDeTq0OSX
 DJPDPFxP8njYSko4ed4m1CRjbMyix+EBJZ+nfyAJQ+ePJRnl6VelMsgxCi6gqpoUwMW12/h4H7l
 FolIihs2R1FIJOBmbTAsSyM8KbnGpXzw2c4fPHU51eeXOhq+Fewc/4d5ZqDFPXdUejvAPhD6pe6
 lHY7wZKf5XElAAm6OWSGd2t8bqBm0it7mu6ePw8aDKgeJf99yLDjcdrwY8dafeuOiYwGSTUjn5v
 PaWSLkiUwnfJC4FX6YdroX1Mad3Jcx+jRWUfS5j5V7YXBGGCOIxwaLMKkjItXUpQAflKdmYqjli
 dm1velwozjRUOmI7f+Cb3mKgjS666eE0liumPo3RrfxLpHIucKxyGFAAm37DTFSrN/ymkGx0275
 F2s57IZ5xLP2aBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_rm_addr_received' is not specific
to this PM: it is called from the PM worker, and used by both the
in-kernel and userspace PMs. The helper has been renamed to
'mptcp_pm_rm_addr_recv' instead of '_received' to avoid confusions with
the one from pm.c.

mptcp_pm_nl_rm_addr_or_subflow', and 'mptcp_pm_nl_rm_subflow_received'
have been updated too for the same reason.

To avoid confusions, the '_nl' bit has been removed from the name.

While at it, the in-kernel PM specific code has been move from
mptcp_pm_rm_addr_or_subflow to a new dedicated helper, clearer.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 55 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f6f7ea25640b7f0f71fc6cc3217ea278e15a4c13..09ef3aa025e7094392badfcc24a964c0a530ca5d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,9 +838,20 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
-					   const struct mptcp_rm_list *rm_list,
-					   enum linux_mptcp_mib_field rm_type)
+static void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
+{
+	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+		/* Note: if the subflow has been closed before, this
+		 * add_addr_accepted counter will not be decremented.
+		 */
+		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+			WRITE_ONCE(msk->pm.accept_addr, true);
+	}
+}
+
+static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
+					const struct mptcp_rm_list *rm_list,
+					enum linux_mptcp_mib_field rm_type)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -893,35 +904,23 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 
-		if (rm_type == MPTCP_MIB_RMADDR)
+		if (rm_type == MPTCP_MIB_RMADDR) {
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-
-		if (!removed)
-			continue;
-
-		if (!mptcp_pm_is_kernel(msk))
-			continue;
-
-		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
-		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-			/* Note: if the subflow has been closed before, this
-			 * add_addr_accepted counter will not be decremented.
-			 */
-			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
-				WRITE_ONCE(msk->pm.accept_addr, true);
+			if (removed && mptcp_pm_is_kernel(msk))
+				mptcp_pm_nl_rm_addr(msk, rm_id);
 		}
 	}
 }
 
-static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-					    const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
+	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
 void mptcp_pm_worker(struct mptcp_sock *msk)
@@ -946,7 +945,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_nl_rm_addr_received(msk);
+		mptcp_pm_rm_addr_recv(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
@@ -1538,7 +1537,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			mptcp_pm_rm_subflow(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1583,7 +1582,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
@@ -1670,7 +1669,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 	}
 	if (slist.nr)
-		mptcp_pm_nl_rm_subflow_received(msk, &slist);
+		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
@@ -1910,7 +1909,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_rm_subflow(msk, &list);
 	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);

-- 
2.48.1


