Return-Path: <netdev+bounces-155534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773BA02E5E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1983A6516
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252C1DEFC8;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB1McVWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BD1DED72
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182469; cv=none; b=NK6duGE48iwyS/Pd9a8jtwBXnixfQ2N4bWR749b8sOqVJANxhF9fhIEipsVhSEMb+ptzTLmUe0z1XCFkxWg30mqGxPzwYU4oWRTt2jTCkkayEJBTQ6+UtqZ+0oQ0m1Wy94CJdzj1JDGRkVdvxC8bYnVHVEjB7vjxZM2BVS6OdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182469; c=relaxed/simple;
	bh=ZjgpNSZhFtTH5Zk8A9BInBv2x5PEt471TFNUAr2l6k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0xsP/OKlNyIhHyVodh1HbRST1CyE7ij/zjFW/KKowL4D/eO0I7BIjFeV9Kr1tmPa4s4H/1RVbg5GEJAenDED316jdJUpfZQMu0ESyWflRcobqY1dulp7uDwphj6s716JPlK5SVOxLAVTJBRRHtTa3gVA5rqxNhe0LeMgZiIYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB1McVWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A11CC4CEE8;
	Mon,  6 Jan 2025 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182469;
	bh=ZjgpNSZhFtTH5Zk8A9BInBv2x5PEt471TFNUAr2l6k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sB1McVWdUGxZsfzoWDuT4QSQ2AlHCyu1kOEn4n1c7xfo8qgLk41sjAD8AK3Wu5T6G
	 JGT2FGFkD2w2mwjOeuo/GAFM3/yFFHBHdiTXQSjMqKmj8PDghkR+TEFutB7M4UK/KG
	 9DdgP9Ewl02xEWc0Le8qqYZ4V4ZgDnv+nWeE6hR1ZQHIg258pe/jagaojJPcH+CYkh
	 LVkX9A/wZBP78on2EOhkHNKObw5TkQKwmZvgHrb/rhzIAobrXjoKYTGImNu1eeBi3l
	 prGnmm7lTNkxHSmrlwEpe1S2JCMLlZR4i68zxz/vWcLxaj+ehO9ng96w+akDrGmHRo
	 AoGfMi1uGsZAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	jmaloy@redhat.com,
	ying.xue@windriver.com
Subject: [PATCH net 6/8] MAINTAINERS: remove Ying Xue from TIPC
Date: Mon,  6 Jan 2025 08:54:02 -0800
Message-ID: <20250106165404.1832481-7-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106165404.1832481-1-kuba@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a steady stream of fixes for TIPC, even tho the development
has slowed down a lot. Over last 2 years we have merged almost 70
TIPC patches, but we haven't heard from Ying Xue once:

Subsystem TIPC NETWORK LAYER
  Changes 42 / 69 (60%)
  Last activity: 2023-10-04
  Jon Maloy <jmaloy@redhat.com>:
    Tags 08e50cf07184 2023-10-04 00:00:00 6
  Ying Xue <ying.xue@windriver.com>:
  Top reviewers:
    [9]: horms@kernel.org
    [8]: tung.q.nguyen@dektech.com.au
    [4]: jiri@nvidia.com
    [3]: tung.q.nguyen@endava.com
    [2]: kuniyu@amazon.com
  INACTIVE MAINTAINER Ying Xue <ying.xue@windriver.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jmaloy@redhat.com
CC: ying.xue@windriver.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97e3939f800b..c092c27fcd5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23650,7 +23650,6 @@ F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
 M:	Jon Maloy <jmaloy@redhat.com>
-M:	Ying Xue <ying.xue@windriver.com>
 L:	netdev@vger.kernel.org (core kernel code)
 L:	tipc-discussion@lists.sourceforge.net (user apps, general discussion)
 S:	Maintained
-- 
2.47.1


