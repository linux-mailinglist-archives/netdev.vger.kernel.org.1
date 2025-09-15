Return-Path: <netdev+bounces-223259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA87B58865
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D633B335D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291C2D238A;
	Mon, 15 Sep 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPnF2ef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD472DAFAA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979778; cv=none; b=HITcmvfE98HUtWwqHwym2p1Rqr7vwtgPHOPPShovScGF2sUZooetK1npp9U2IYaCgKGUiRuv+eqtsVoFuepu1yMsVFSs47PH/jgUer/Bz9Tt5ez1f36GNRN2NMeaDSgHIiHNJZyiadyhuC0DaIUPjb5qLY5t8eb4ghLV6aJgaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979778; c=relaxed/simple;
	bh=ARNiHd3whMI4T+4IYKlqRhQ/DL9+UClvdDO+h/804Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arbXTUyB+VeuZiSrKEOe79iDDk8MOqiyJ7UyZ0ZTk0fTsqArloF8hG1wCEDF9HdY6SNmiQq4xlGPHSh+DRernvyV1UKIJF4i7Em2DmimES//r4fA4B3ecVpcFmLLDhrxhSYLNfjgLWOfYI7Em3W7lKeywzARCD3BdxBxiKTHtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPnF2ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D84C4CEF1;
	Mon, 15 Sep 2025 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757979778;
	bh=ARNiHd3whMI4T+4IYKlqRhQ/DL9+UClvdDO+h/804Dk=;
	h=From:To:Cc:Subject:Date:From;
	b=KhPnF2efZc7cBtDK9iZwL+ZmWMqQkHUNni64ZYuQsF2LQQYqFvkyyiR+l0YpWuX6S
	 PFW1hQ6vE9YOOzcMyvKZsR8/cI41o4mJwRrNcfG9al3uNWUbmisstmhPCvCZjYIb2N
	 5l3JNZy5Y2ERex15xPFd1HzwVh2yMqsn8DgpxbLsjMTr6WyRSrMmn7/xN5v9GGT6tG
	 kJf5Z76ISxHq64LSj+lb9WhfTqTRgTDSBMzByU9cwTDWp4K08eySH4Z91srFTvIHES
	 COCYxNqT9C5SWqPw4QP6/dWNfLHQgqt9C4MyQVxtFhasRzwld+GyiWC6HJx4Y37pFc
	 ncHT7N474oQLw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us
Subject: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
Date: Mon, 15 Sep 2025 16:42:55 -0700
Message-ID: <20250915234255.1306612-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPLL maintainers should probably be CCed on driver patches, too.
Remove the *, which makes the pattern only match files directly
under drivers/dpll but not its sub-directories.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vadim.fedorenko@linux.dev
CC: arkadiusz.kubalewski@intel.com
CC: jiri@resnulli.us
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47bc35743f22..4b2ef595c764 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7431,7 +7431,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
 F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
-F:	drivers/dpll/*
+F:	drivers/dpll/
 F:	include/linux/dpll.h
 F:	include/uapi/linux/dpll.h
 
-- 
2.51.0


