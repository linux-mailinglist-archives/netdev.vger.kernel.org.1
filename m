Return-Path: <netdev+bounces-44323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 286FD7D78B8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF7AB21347
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280463A267;
	Wed, 25 Oct 2023 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cid/1eiA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B639934;
	Wed, 25 Oct 2023 23:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279FCC43397;
	Wed, 25 Oct 2023 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277034;
	bh=nSuFbYfmMcnG6/Bus3aZEFgms4N+Cgbmq5LGxxuZa4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cid/1eiAMHlvPTb6FGwNJxYtiZzPmudpFyNN3LW7+W82j80i3E+R4tdr7gOh3XTpE
	 XaTeStiySMhXc5VjIhfQwKJwl38818WT90cI51OMdf8A3gnVCJcwfwvsvAmxJWyPxW
	 ZCRO3Hy3VTz0jBgK9+aG2Q3Z6or/f7c7OjRN+t9A+lH7qK/lkejLc8nGNn8qBEk0Jo
	 xEOZqyzGkwTlmmC57f5XF34I8b+0itd10ynp6Tx9iBtNFKC7TUAa0nGrXQRH9MwZSr
	 /mXNFAJGUrq0jfbuGRYd+WSMSw/TTBq6S9nmjksKzrXX2ztYNLlNaX0tn3wvHK4w2O
	 sHjZI7sPjsCzg==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 25 Oct 2023 16:37:10 -0700
Subject: [PATCH net-next 09/10] selftests: mptcp: sockopt: drop
 mptcp_connect var
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-send-net-next-20231025-v1-9-db8f25f798eb@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

Global var mptcp_connect defined at the front of mptcp_sockopt.sh is
duplicate with local var mptcp_connect defined in do_transfer(), drop
this useless global one.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8c8694f21e7d..a817af6616ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -11,7 +11,6 @@ cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
 iptables="iptables"
 ip6tables="ip6tables"
 

-- 
2.41.0


