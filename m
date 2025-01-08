Return-Path: <netdev+bounces-156316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E94FA060C7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E95C1692D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7C1FF7D2;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcTY8dJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AB1FF7C2
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351567; cv=none; b=AIRf/8pg4eXIgOqjWG7Hkw9NXWVml1BSRzD7zwrD6UUGp1w4WsvAaOhAxKH5ntaMy9RwzkYYf0m0Dzb31ujkCqmvdWRFRRSQ61deMrH1dRjkkPXy6xBCAijSzy+fxAfC52pDpI+8ivCqFtdaUzd/duqJOHmp2g6CANC9HRlgvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351567; c=relaxed/simple;
	bh=FiEeAf63dNsNuSVHpm2z98RxC5AHWNWFqSf0r32T+/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwfng85zS/H2lC+Ejby2ugEfrcd0qxCVmQvPdAvXpyPpc4VysAg3V6MV5FDNp/SmS9iCb7RNAJKcdxfUCces785NcdCXTac7dWUyatUHbXbjgu+J57iVBvBy73nqu9L+gwpnOkVypuHVxuZiyZM1w/gUxsdeVDzvCOaHzRQ81r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcTY8dJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2B6C4CEE5;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351567;
	bh=FiEeAf63dNsNuSVHpm2z98RxC5AHWNWFqSf0r32T+/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcTY8dJdDhkYxhWkNT2M40j9pLxjn87m+CjpB18gUS8/jHVB1OBrkGzfuqwh9axtm
	 DajYhA723XgUpF/mxMtmpfIO6zLigY3hmKFq8JakIV3O1yDUe7nupycugA91ZBkIwj
	 JavOzkv5ORmTpgN+fGvYzXNr0s7eQ1kUxFHBlQB5EhCZPWrN+1obGaRdDef2jIWWEz
	 JQaFgGKzBOOCUqbeR/P7QP/HVVcZSPmUPaJ1Q1GwNTX/P0lOhUBWhyr3c13dCssY9L
	 St6hQ9QD7a1jrWcRb1Zb+6w5336MQ2F4BlWb41pDnvfoXMWnAe9FPhycvfpou8oAzl
	 RcTUAQUR3fx4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	razor@blackwall.org
Subject: [PATCH net v2 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
Date: Wed,  8 Jan 2025 07:52:37 -0800
Message-ID: <20250108155242.2575530-4-kuba@kernel.org>
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

Andy does not participate much in bonding reviews, unfortunately.
Move him to CREDITS.

gitdm missingmaint says:

Subsystem BONDING DRIVER
  Changes 149 / 336 (44%)
  Last activity: 2024-09-05
  Jay Vosburgh <jv@jvosburgh.net>:
    Tags 68db604e16d5 2024-09-05 00:00:00 8
  Andy Gospodarek <andy@greyhouse.net>:
  Top reviewers:
    [65]: jay.vosburgh@canonical.com
    [23]: liuhangbin@gmail.com
    [16]: razor@blackwall.org
  INACTIVE MAINTAINER Andy Gospodarek <andy@greyhouse.net>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move to credits

CC: jv@jvosburgh.net
CC: andy@greyhouse.net
CC: razor@blackwall.org
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 7a5332907ef0..cda68f04d5f1 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1432,6 +1432,10 @@ S: 8124 Constitution Apt. 7
 S: Sterling Heights, Michigan 48313
 S: USA
 
+N: Andy Gospodarek
+E: andy@greyhouse.net
+D: Maintenance and contributions to the network interface bonding driver.
+
 N: Wolfgang Grandegger
 E: wg@grandegger.com
 D: Controller Area Network (device drivers)
diff --git a/MAINTAINERS b/MAINTAINERS
index f2cace73194e..e16a55c3dd3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4065,7 +4065,6 @@ F:	net/bluetooth/
 
 BONDING DRIVER
 M:	Jay Vosburgh <jv@jvosburgh.net>
-M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/bonding.rst
-- 
2.47.1


