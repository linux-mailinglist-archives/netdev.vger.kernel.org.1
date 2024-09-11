Return-Path: <netdev+bounces-127171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9B974749
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC6E1C25AC8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D2184D;
	Wed, 11 Sep 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE11Ss27"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397754C69
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014107; cv=none; b=Q3+QVh0GAH6SOKQI3v+TbMHCGjC/oHFD8VmK1Jvc7Iis9hRYUn74QLnHeBUvtaim1/ZXg3OK0evu0nAWFX1HmriySl86zs5DUokCxZlH9szdhhxI0JAKOtbgcHve7WTDN9j2xiAT0XurAKO2v24+4udb5vXSzeCERmF8VBkavbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014107; c=relaxed/simple;
	bh=OQMzhfYO9EIc5pS6MDvSzKFg3Y4PSyY9n0nAbYTO3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nklxI33etfGvakHBMmwvQSQto4IQbhjASorq6QKlzNdToXwYOoOE3WR9LmqKPhalYVXMR7MyLqAfqZetHZ5UcaeZ/AP08tZAPr7BuPRRIVLTszp8SQrpQI+tJiI6G+7wJyqAInDajC0FgbWMm56ke7abQUXVUqDuZz2RqV0b1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE11Ss27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB81FC4CEC3;
	Wed, 11 Sep 2024 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014107;
	bh=OQMzhfYO9EIc5pS6MDvSzKFg3Y4PSyY9n0nAbYTO3J8=;
	h=From:To:Cc:Subject:Date:From;
	b=PE11Ss272dvLRHdcT0Z8dgwKUk0slMR/2jkN7cOBZcrC0cQ/tmQrkQMnNmP+SEMaD
	 0bot5zbYOgDyYpB9CKkuNHS7W/CZYIsFZPQ+u68lxJoJnfg3z6Qio6HCXaApNwEzej
	 QuHmOCgU2BW71cHdgdtM7NJTZijRzm8wX1GKy3KoPO4oniPkGVWq4sPkkeIMojDxk3
	 juAI38FnJNkxaHOPbeyFHG0xtG7NFNbWEqVadYZl3juPL36WQ/b9I57p4f5ixOiIBZ
	 i+4ge2ztAF0yxWSW7zQpURZBn+iEJSl9Dnj9MWwXMGm3JUiyYU0k53RCtdmrH7YDqw
	 1cbpYSrlmGMAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] uapi: libc-compat: remove ipx leftovers
Date: Tue, 10 Sep 2024 17:21:42 -0700
Message-ID: <20240911002142.1508694-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uAPI headers for IPX were deleted 3 years ago in
commit 6c9b40844751 ("net: Remove net/ipx.h and uapi/linux/ipx.h header files")
Delete the leftover defines from libc-compat.h

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/libc-compat.h | 36 --------------------------------
 1 file changed, 36 deletions(-)

diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 8254c937c9f4..0eca95ccb41e 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -140,25 +140,6 @@
 
 #endif /* _NETINET_IN_H */
 
-/* Coordinate with glibc netipx/ipx.h header. */
-#if defined(__NETIPX_IPX_H)
-
-#define __UAPI_DEF_SOCKADDR_IPX			0
-#define __UAPI_DEF_IPX_ROUTE_DEFINITION		0
-#define __UAPI_DEF_IPX_INTERFACE_DEFINITION	0
-#define __UAPI_DEF_IPX_CONFIG_DATA		0
-#define __UAPI_DEF_IPX_ROUTE_DEF		0
-
-#else /* defined(__NETIPX_IPX_H) */
-
-#define __UAPI_DEF_SOCKADDR_IPX			1
-#define __UAPI_DEF_IPX_ROUTE_DEFINITION		1
-#define __UAPI_DEF_IPX_INTERFACE_DEFINITION	1
-#define __UAPI_DEF_IPX_CONFIG_DATA		1
-#define __UAPI_DEF_IPX_ROUTE_DEF		1
-
-#endif /* defined(__NETIPX_IPX_H) */
-
 /* Definitions for xattr.h */
 #if defined(_SYS_XATTR_H)
 #define __UAPI_DEF_XATTR		0
@@ -240,23 +221,6 @@
 #define __UAPI_DEF_IP6_MTUINFO		1
 #endif
 
-/* Definitions for ipx.h */
-#ifndef __UAPI_DEF_SOCKADDR_IPX
-#define __UAPI_DEF_SOCKADDR_IPX			1
-#endif
-#ifndef __UAPI_DEF_IPX_ROUTE_DEFINITION
-#define __UAPI_DEF_IPX_ROUTE_DEFINITION		1
-#endif
-#ifndef __UAPI_DEF_IPX_INTERFACE_DEFINITION
-#define __UAPI_DEF_IPX_INTERFACE_DEFINITION	1
-#endif
-#ifndef __UAPI_DEF_IPX_CONFIG_DATA
-#define __UAPI_DEF_IPX_CONFIG_DATA		1
-#endif
-#ifndef __UAPI_DEF_IPX_ROUTE_DEF
-#define __UAPI_DEF_IPX_ROUTE_DEF		1
-#endif
-
 /* Definitions for xattr.h */
 #ifndef __UAPI_DEF_XATTR
 #define __UAPI_DEF_XATTR		1
-- 
2.46.0


