Return-Path: <netdev+bounces-96232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1178C4ACF
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BE41C2137D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706F125B2;
	Tue, 14 May 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6vK+T8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95B111A8;
	Tue, 14 May 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649224; cv=none; b=YIlT7NhAl64oky3qTJiYKcZI5lGcKNtfJLYt1tnrEyhNwUUyG0iRsBR3otICJ4HxknD8FS3gW6WoS5J1w1YNqv0X8Tt7sO3DJAr1QkN/sn38v9zmSvVPsFJcpn0A9kCjkq/J0Mi2z18qIlhFYuazwMEmQsivOdGjVcbk1mbP45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649224; c=relaxed/simple;
	bh=Ct/2fDVBOpgHX6ViSh82CQRY4rG3MD+taLck/RW657c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw58Vr/H4BWrSpDqEFvRie4TH82h21WjtF5OeN+KFPYfc9XMxby2OFvshNGttjmkAAUAwy96xmifstxz60zfOhKEtGzJezu6am7Q8zAzEl3a9BZ+Ei/NIIubAOY8wpOaqUWM/KhAvPG9QZ3lbKScf1TYYqDYBaGLsB8jxK72FDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6vK+T8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06F2C4AF08;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649224;
	bh=Ct/2fDVBOpgHX6ViSh82CQRY4rG3MD+taLck/RW657c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6vK+T8v21VuYurIZSTxAUe4FTPUTyitfl9VtAk8xKrpFBSQdYXyLndrivXdyUpV2
	 aTUzSMN0ttvjm7FH3hfmSbkftKBsMRWyaLXSKn4B/OPaoITWLGraKYRI/M7pG0htQ2
	 3amu5Irzi4+JILkHYWowY3Q0zd9SRhnnr0J2CiQGGgl4uACJq/sZKIKUL8CER3j+vy
	 Mo8P40WAcOTjD3RFPYJIHyb2JzZGs5PZaT2AiQPcp4+y/6S104oo0zM+bUXtlj6mZi
	 wkbOK7HF50ZQwHtXy8iOEHW0Sdw6YdVXJrGbYfbPMt7ueu65wtRHSeWEb+OX+5K152
	 fFBe1XOIoY8hQ==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 8/8] mptcp: include inet_common in mib.h
Date: Mon, 13 May 2024 18:13:32 -0700
Message-ID: <20240514011335.176158-9-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

So this file is now self-contained: it can be compiled alone with
analytic tools.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/mib.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index dd7fd1f246b5..2704afd0dfe4 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
+#include <net/inet_common.h>
+
 enum linux_mptcp_mib_field {
 	MPTCP_MIB_NUM = 0,
 	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
-- 
2.45.0


