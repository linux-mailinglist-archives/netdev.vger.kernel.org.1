Return-Path: <netdev+bounces-156318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F95A060D8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D137B7A6519
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C431FFC68;
	Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk03NUMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBC1FFC61
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351568; cv=none; b=twIVRKmIfbshm5U3i4WbMflMJ97jlAe9qThgXx87iPd/mVcDzNtLt5UewOhXgXZw5Qk+cjDUUQfy7XeJO0ptvkLYjH3rOizfRnPUCDulCnQUQgxP+MAYQ4uZ9SvmY4WyPmsTg5J5fgnYa2pq+xNCr3KVd/nmUQgfXWJAkHY6dX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351568; c=relaxed/simple;
	bh=jmmqYskVDpReIey4LPQA6HbMr4v1wUKpMfdbGYcy0Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQCBOItMgO6Ty/Q5r7Mts1VLm/P33aXPqVWlSBDElQfZ6mrIv3lPoRRYH1RkjElKfbgIx+PIjIVTCFJsslUxYh50LI9FHF0eE7yk95t31F1yc3H86pwbIcRJSIeFxstNjB4fQ3ViCSnWE022z9bnfrf+agB1S8rt1qeimL2JGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk03NUMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D455DC4CED3;
	Wed,  8 Jan 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351568;
	bh=jmmqYskVDpReIey4LPQA6HbMr4v1wUKpMfdbGYcy0Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fk03NUMeLms7E7KU5y1jPtIR0HbKYQRpV5SKs5gl13mbd4YIAsA5vjk1CY9X032p7
	 iTzL6KZY+gPcNXZK1LLPs/5kDl6gxdZ6qwO+6cF58zKanMoBPzeXMOJWgrJkSC6XxS
	 uNaIa8q4PK4KfkcrONOCUTpBbYMtG2duZZzBV8/f8GEBfcXtJFlNOA1D+qTREIOEXQ
	 qqHkwAwwAbOJTQ1KFgn3AuCPWlmp7nemUl8nXRtnIzjh7Gl17mY6eO1U7NGRdV29kZ
	 +GZrbWDS6nIDaTE8ynsSZ7lfMhnnv03eHjfyFgGOqELRqTA21QdTQlQLvIf2wZKsPN
	 d2TO1mTVjB6tg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	Mark-MC.Lee@mediatek.com
Subject: [PATCH net v2 5/8] MAINTAINERS: remove Mark Lee from MediaTek Ethernet
Date: Wed,  8 Jan 2025 07:52:39 -0800
Message-ID: <20250108155242.2575530-6-kuba@kernel.org>
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

The mailing lists have seen no email from Mark Lee in the last 4 years.

gitdm missingmaints says:

Subsystem MEDIATEK ETHERNET DRIVER
  Changes 103 / 400 (25%)
  Last activity: 2024-12-19
  Felix Fietkau <nbd@nbd.name>:
    Author 88806efc034a 2024-10-17 00:00:00 44
    Tags 88806efc034a 2024-10-17 00:00:00 51
  Sean Wang <sean.wang@mediatek.com>:
    Tags a5d75538295b 2020-04-07 00:00:00 1
  Mark Lee <Mark-MC.Lee@mediatek.com>:
  Lorenzo Bianconi <lorenzo@kernel.org>:
    Author 0c7469ee718e 2024-12-19 00:00:00 123
    Tags 0c7469ee718e 2024-12-19 00:00:00 139
  Top reviewers:
    [32]: horms@kernel.org
    [15]: leonro@nvidia.com
    [9]: andrew@lunn.ch
  INACTIVE MAINTAINER Mark Lee <Mark-MC.Lee@mediatek.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nbd@nbd.name
CC: sean.wang@mediatek.com
CC: lorenzo@kernel.org
CC: Mark-MC.Lee@mediatek.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b81ed230848..3490a78a8718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14573,7 +14573,6 @@ F:	drivers/dma/mediatek/
 MEDIATEK ETHERNET DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Sean Wang <sean.wang@mediatek.com>
-M:	Mark Lee <Mark-MC.Lee@mediatek.com>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.47.1


