Return-Path: <netdev+bounces-13501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D1273BDE7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C618A281C65
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44010965;
	Fri, 23 Jun 2023 17:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE28101F2;
	Fri, 23 Jun 2023 17:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F45C433C0;
	Fri, 23 Jun 2023 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541659;
	bh=soa/C2iIrBJik+8b5QHNWDFlga5q5rvhVTxev/CII60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mNUCTRdc50fy5FH/FSYKco77cfWcGdun4Otey0BIBIJQV1s6yNlB8fvrIUVfCaSgZ
	 i/OFvTqhh0XN9eVnGBgsVFQzlpQNp7QA5Wkd/3fzQK+hSO6xoGQOKKrts/GnRPClb+
	 R8VhE9F3T6jYMKMUFKzO7nTWEiLI8p6R0T/iqk7OqRboo6CbplfBGjKViExBD4qU8k
	 aMGTMj6eIOY96u1n4+FyovLbbp0zd4NZt1hH7BSm+B86IJ0KGwPJAumq5q0pM41I1j
	 5PmMVu7pAXG+RwbElb7PD0QlFYak7QYhDJcXoSIm59N+dGbd3+E7uPrDn36OaCetBo
	 DXl++QgkW6+hw==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 23 Jun 2023 10:34:14 -0700
Subject: [PATCH net-next 8/8] selftests: mptcp: connect: fix comment typo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-send-net-next-20230623-v1-8-a883213c8ba9@kernel.org>
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Yueh-Shun Li <shamrocklee@posteo.net>
X-Mailer: b4 0.12.2

From: Yueh-Shun Li <shamrocklee@posteo.net>

Spell "transmissions" properly.

Found by searching for keyword "tranm".

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 773dd770a567..13561e5bc0cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -809,7 +809,7 @@ run_tests_disconnect()
 
 	cat $cin $cin $cin > "$cin".disconnect
 
-	# force do_transfer to cope with the multiple tranmissions
+	# force do_transfer to cope with the multiple transmissions
 	sin="$cin.disconnect"
 	cin="$cin.disconnect"
 	cin_disconnect="$old_cin"

-- 
2.41.0


