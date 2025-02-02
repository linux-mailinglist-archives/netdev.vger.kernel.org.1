Return-Path: <netdev+bounces-161948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6FA24C50
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0413A5ACA
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB300A936;
	Sun,  2 Feb 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzSD1anG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FC035979
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457427; cv=none; b=FpefMquFvTWIXUNrwkY+s90tx8i57gMSwPyRFzoGkGQ1Tj3M+eCPup6/stweDBgOYDtgO4pdcCW2Dat966d+huk+36j70T+AZrXVah0j1z0KVR2SD3tAtEu8AOjEQK19s7fRZ7rDCTedCUgm+1IFNFk19uV6xpWRAaRW2bKXqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457427; c=relaxed/simple;
	bh=uY6auwW+bVqOt3GgOBw0kZF8+4GH870C3tCP5GQKIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEpPUNGm+Zhq9aoBIjn6BuEnFsKshgGbnQaeLk2hklGvnghbqcsWEYLDPhBKqf4GI6BJgtFIGSJIfXJMVCwKoHZRy95cFQidGQHSv+XBQnN03pxnBMsPF/YEg3MyGxibAHGKEnbOnBlskPRIIiXY4yNZQlJZeU6+M9W8BJ0EyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzSD1anG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A33C4CED3;
	Sun,  2 Feb 2025 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738457427;
	bh=uY6auwW+bVqOt3GgOBw0kZF8+4GH870C3tCP5GQKIzE=;
	h=From:To:Cc:Subject:Date:From;
	b=tzSD1anGJSymwF8WI/GD/RoIexKzduUabQ6do7a9BkHfFlR3GGWwiMmdKD55BSdvk
	 ob2lWe5SNYz8wG8kzUIHWzJ1HKI4GI26r/PaGd2yMRHTekMvduHq8eaSn80poeldCO
	 yXWGGuD/4zCAzHhdHLACiA3pcn4NchEyT0GmtAPBpiZF12AW3CaY0Xr8htUomlxG9C
	 6OjuCbaoQf78GqL/qlGuOLzlaolnht0RQo4TDAnDR4OOd3Hmq3awIUdXuwGRD9za2V
	 EIId0uKrPgffoNACpNBl9YrYQinkgBBMrsOwGW7JQJDrYlsvJusX6HGTQZL57zkljz
	 g9rqy4a4iE3fA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	pshelar@ovn.org,
	dev@openvswitch.org
Subject: [PATCH net] MAINTAINERS: list openvswitch docs under its entry
Date: Sat,  1 Feb 2025 16:50:24 -0800
Message-ID: <20250202005024.964262-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submissions to the docs seem to not get properly CCed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: pshelar@ovn.org
CC: dev@openvswitch.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d7ac4dcf489..80df771df15a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17708,6 +17708,7 @@ L:	netdev@vger.kernel.org
 L:	dev@openvswitch.org
 S:	Maintained
 W:	http://openvswitch.org
+F:	Documentation/networking/openvswitch.rst
 F:	include/uapi/linux/openvswitch.h
 F:	net/openvswitch/
 F:	tools/testing/selftests/net/openvswitch/
-- 
2.48.1


