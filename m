Return-Path: <netdev+bounces-158967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92FA13FE3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CD716AEC8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7E22CA13;
	Thu, 16 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIinGWU7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680892AE96;
	Thu, 16 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046474; cv=none; b=sTTIzOMFlmFeL/USSSqB0joLsRB0Na11UykSJXuC9ydyvJSovKNzuJ7JjJq8kLsy5EC3zkuc1xTcMgFnZ6XvDmYbwvE6JDlj6epPL3eByzmV4yMGMcn7087Uvfz4/eiVHlSJdavP+MjFvCUUEmugfEPfmcs2djBV7OxccxHxwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046474; c=relaxed/simple;
	bh=Ysa8GOnOkbLdnT1XswsCi8J7b5VsNoEjaoHVXePqvYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hehWUSYVVgYWGZqB+rtTRAT+UF0M3jyYb4sk4gCtAltax++UOpKo/onlKOZg/n/VHRDaI4aYuGc3uVXJbZDdc4lPufa8TMdInymSVGKKY0ZB4NAG5Z0xp9+r5xH4s4PQdta6AJCjVmaiCx3iagifZdUf/lbBYIE3kjMLLUbSSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIinGWU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D21C4CED6;
	Thu, 16 Jan 2025 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046473;
	bh=Ysa8GOnOkbLdnT1XswsCi8J7b5VsNoEjaoHVXePqvYE=;
	h=From:Subject:Date:To:Cc:From;
	b=VIinGWU75Shk9UmFzaZP2uvwWndk4Ww/sQM/Fbl7ZI8P4D5P4Ic/c60WdenqMplpS
	 lj1fj+vs5or6g8eTdXlXPan5Qu9Cingx2YMexsTh0RZMaqffLZhBEahxvBxoREl9R9
	 BIGrN7e36ZlxU2ok2KCsfHdMB3c3SoRwF299R9EBlUlFobAWknHyfkj0CxPWzCe4uN
	 SavoukHTWGueu0m1EXpUv6MDD4b85GqxzHuT81+idtTTI2gjj7lAQsTrAs/R3YLlMV
	 d0hNuhy552XmNWrIA079ZwN0QZ2/Zd7QN2IOYGfScWcRHVvX9o5avASNdfTi/wVjec
	 DxlHHpH9hy51w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: pm: misc cleanups, part 2
Date: Thu, 16 Jan 2025 17:51:22 +0100
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAo5iWcC/zWNQQqDMBBFryKz7sAkaJFeRbqwcWIHmjgksQji3
 Q2Ci7d4i/f/DpmTcIZXs0Piv2RZYhXzaMB9xzgzylQdLNmOjHli5FLZCgYtTlEDBskO3Y/HuCp
 a/JDviL3vqW+hzmhiL9t1McBdw/s4TlIrr718AAAA
X-Change-ID: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ysa8GOnOkbLdnT1XswsCi8J7b5VsNoEjaoHVXePqvYE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnGzSBA4VNBEfzPqc+kxVT3hc3yZ/SRZ91Tg
 WPRoSRFrMKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 cyMwD/4l8nIaCJkgL0CKbaasJZNVUYY95PDkkV9Xu/LPugBIG66NtZOHvddoqtCd5EYwfk8ygCT
 uLFqweN/Wez81W0iRYWcXZF7/CuI4+ngCfqDdmevLPCSZWUCol5/Ew0LiAlIKCciYn9oN/yvFRb
 h5lKANObjU7jHRDYKGAUaKf3ushrOyXMBY/U9gmDtAdmCAYsvjraxsG//DCc7pZqj0S9nMEtX7U
 D0G4u+1MUjIYjKsST9h52hiMzHuAnPU2Sg5qtKX2wiXh8x9JbsoYRPUE9E93zWBSH2pBd+2dko7
 P6WfF0sb2FrgC/1abgCQ4uJmOvW86L262InP1RvHYl5jybLSXkkOvPPXrCtBAvnBlPSHztzS2xf
 I2sRJSDtgfjTssr6qdneRnGWcxRGfBJLQ9WuqM/U0DfYi8wCUnStH44QM5u0k7+I/jH2v9jUK9Y
 8FeEElS2C/SHRdm6Q73h0szzrqT8l0VbJHSKJducg3GmqcNtBy0CuMJ6u9R56uFzs5LnWgPGDv1
 kd6RmZRT/jGA6sEuLWIhSptD9BDfBp8wyGNI0Jo9eME1QvtSeatkqZ5zIf1D5m72Z2dixY/MMKN
 8mHxyMAl/wU3QGp1u6EG1utuW9ZBWfLwwgPsXSt7C2i8bSpka2NA+kD8z0lgzAPyllf8uefQDd4
 yXibOVCVIYjZAWQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These cleanups lead the way to the unification of the path-manager
interfaces, and allow future extensions. The following patches are not
all linked to each others, but are all related to the path-managers.

- Patch 1: drop unneeded parameter in a function helper.

- Patch 2: clearer NL error message when an NL attribute is missing.

- Patch 3: more precise NL messages by avoiding 'this or that is NOK'.

- Patch 4: improve too vague or missing NL err messages.

- Patch 5: use GENL_REQ_ATTR_CHECK to look for mandatory NL attributes.

- Patch 6: avoid overriding the error message.

- Patch 7: check all mandatory NL attributes with GENL_REQ_ATTR_CHECK.

- Patch 8: use NL_SET_ERR_MSG_ATTR instead of GENL_SET_ERR_MSG

- Patch 9: move doit callbacks used for both PM to pm.c.

- Patch 10: drop another unneeded parameter in a function helper.

- Patch 11: share the ID parsing code for the 'get_addr' callback.

- Patch 12: share sending NL code for the 'get_addr' callback.

- Patch 13: drop yet another unneeded parameter in a function helper.

- Patch 14: pick the usual structure type for the remote address.

- Patch 15: share the local addr parsing code for the 'set_flags' cb.

The behaviour when there are no errors should then not be modified.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (9):
      mptcp: pm: drop info of userspace_pm_remove_id_zero_address
      mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
      mptcp: pm: make three pm wrappers static
      mptcp: pm: drop skb parameter of get_addr
      mptcp: pm: add id parameter for get_addr
      mptcp: pm: reuse sending nlmsg code in get_addr
      mptcp: pm: drop skb parameter of set_flags
      mptcp: pm: change rem type of set_flags
      mptcp: pm: add local parameter for set_flags

Matthieu Baerts (NGI0) (6):
      mptcp: pm: userspace: flags: clearer msg if no remote addr
      mptcp: pm: more precise error messages
      mptcp: pm: improve error messages
      mptcp: pm: remove duplicated error messages
      mptcp: pm: mark missing address attributes
      mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible

 net/mptcp/pm.c           |  86 +++++++++++++++++--
 net/mptcp/pm_netlink.c   | 129 ++++++++++-------------------
 net/mptcp/pm_userspace.c | 209 +++++++++++++++++++++--------------------------
 net/mptcp/protocol.h     |  14 ++--
 4 files changed, 225 insertions(+), 213 deletions(-)
---
base-commit: b44e27b4df1a1cd3fd84cf26c82156ed0301575f
change-id: 20250116-net-next-mptcp-pm-misc-cleanup-2-b0f50eff8084

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


