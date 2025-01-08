Return-Path: <netdev+bounces-156319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28036A060D9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E243A87B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13F61FFC70;
	Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck0O639G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33D1FFC62
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351568; cv=none; b=BQDIN7g5ivJHJSL8cx7Pk6E11v8GNVQFOcfIM3CpKRsFTHxD52aFe/H8NZfbblH/EAg1wAIm/yc1jxVnbkUTQ/GJkgpGyE0xv9Ec8RLy6J6ewo69VPmXqvxsIG2ykyeHFh930vIAz3++pPOg45gIFQ05aVGNobp/nLXn5QbtVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351568; c=relaxed/simple;
	bh=bujFBxaNJkUkpB1CND42R0nAFEVKwQ3RyZ1vwvaLu04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8hWD0UNoVGhZ9TKHCm8aRmjhBzgCxPIJlV6Q695bz43BYT/PTCBG1pQ3duxTj/wm4SyhNQHxq4S/g1em0nnwR6MUJXJsSTIxhgUg9ed5YrAm+0qjB5thMhcTdlBfyrgR3wWV9iTtrvJy/WMB2yl/fR48q9qavdIS5dcux6bd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck0O639G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA9C4CEEA;
	Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351568;
	bh=bujFBxaNJkUkpB1CND42R0nAFEVKwQ3RyZ1vwvaLu04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ck0O639GHK6AiufgspjDO6ECrfQEi+CbiS9cb+0efbLuQdDLyVDhmajCOxZq6Wu9k
	 8MHksBMzjVHolfgZy3WFdKP6l/XMIUTLL4hze5pyF6/odcoqZbx2GHmR68l5LkRECG
	 iLhlDcbc2ZUSaJ/ztLqD2PuoG2sbq382UlFZ4rOakM/Btfx9EJQx9Ha45IwwG51MhY
	 PmU41IRsXtZtoUvjWsIAwSHWJX7FfJ5TwxHKF6xoitg3IhXI4Z+2jGJRYvOY0c5M/i
	 389lnvyaFqHlkCHPzf26513ar5pOcmjPGEWI96kSlWigI+Uu+aDWWDQNl8S+LrOv9Z
	 moOSaHrY/zaBw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jmaloy@redhat.com,
	ying.xue@windriver.com
Subject: [PATCH net v2 6/8] MAINTAINERS: remove Ying Xue from TIPC
Date: Wed,  8 Jan 2025 07:52:40 -0800
Message-ID: <20250108155242.2575530-7-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
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
index 3490a78a8718..c01db3666861 100644
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


