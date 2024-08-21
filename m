Return-Path: <netdev+bounces-120473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B69597EF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291E51F22A23
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B241B3B39;
	Wed, 21 Aug 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TibkXgn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6301531F3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230021; cv=none; b=S9sUB/yBxOnU66WPepmELGimMLBE/SKEfvIV3qKtsawMgqjZ/RSnemK6OtW6MB8Tiu1/1YmZCHwWqZvBZc1oMzq2fo2Jd1qxX587B5LnN4T7wuj5Y8Kwj12ZYOw0mGrdyapqkxQZoNK+kzdxY3MN/L2/fyOp2VeXXlKmquiSvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230021; c=relaxed/simple;
	bh=H2TDaiqZYzOyYCq0VSiQLOb/ZMsbpZg32lxy9IBwK9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsKGf63LUCR/t1utjF7HQjk+De6qUyuCQC4lQXaYYiap/p/ghR+NEiJDoc0wfGE2Qaj1EI18Lj0kQGo12RjLLSc2H7vw+gIruMVcjCKfJg/RduT7P2TsV1xyh4XoNFBqn7KxU49raJjdyUBFKpCLbn2ARnmNGt4RIPg0Nm1L768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TibkXgn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8EC32782;
	Wed, 21 Aug 2024 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230021;
	bh=H2TDaiqZYzOyYCq0VSiQLOb/ZMsbpZg32lxy9IBwK9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TibkXgn8h2L9eP3eB/cMA4f5VumZU282OG5YCYzo1oLC17c66DjMKU+qKJT9gBA0k
	 XdHdYwrFWsQry7qRgBQCp+j2aUURpUcu7t9LwHf4HF5QEaHAAMm5b5b172MwipJ6Vj
	 ovayQry6NRWi7wkhFjSjuE2aFoEkbm/r7rMKehpkLLnrubDtysaB95xMZPmwclWrzg
	 +rioVmMsp2F1lwVCe35CWivL0yZOTE79O8uobuA0DWSU9pE7EVLadC5y0s2GlvzBYX
	 Wz98XoJSDwuS3CwH6AmwQ02B6+7uP/XaUmwttv2Lj649NvTNuf0KDEYHrrXKQhtOoI
	 UKDYEPHvEkGqg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 09:46:46 +0100
Subject: [PATCH net v2 3/5] MAINTAINERS: Add limited globs for Networking
 headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-net-mnt-v2-3-59a5af38e69d@kernel.org>
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
In-Reply-To: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This aims to add limited globs to improve the coverage of header files
in the NETWORKING DRIVERS and NETWORKING [GENERAL] sections.

It is done so in a minimal way to exclude overlap with other sections.
And so as not to require "X" entries to exclude files otherwise
matched by these new globs.

While imperfect, due to it's limited nature, this does extend coverage
of header files by these sections. And aims to automatically cover
new files that seem very likely belong to these sections.

The include/linux/netdev* glob (both sections)
+ Subsumes the entries for:
  - include/linux/netdevice.h
+ Extends the sections to cover
  - include/linux/netdevice_xmit.h
  - include/linux/netdev_features.h

The include/uapi/linux/netdev* globs: (both sections)
+ Subsumes the entries for:
  - include/linux/netdevice.h
+ Extends the sections to cover
  - include/linux/netdev.h

The include/linux/skbuff* glob (NETWORKING [GENERAL] section only):
+ Subsumes the entry for:
  - include/linux/skbuff.h
+ Extends the section to cover
  - include/linux/skbuff_ref.h

A include/uapi/linux/net_* glob was not added to the NETWORKING [GENERAL]
section. Although it would subsume the entry for
include/uapi/linux/net_namespace.h, which is fine, it would also extend
coverage to:
- include/uapi/linux/net_dropmon.h, which belongs to the
   NETWORK DROP MONITOR section
- include/uapi/linux/net_tstamp.h which, as per an earlier patch in this
  series, belongs to the SOCKET TIMESTAMPING section

Signed-off-by: Simon Horman <horms@kernel.org>
---
v2:
* New patch
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b9a4d9bc21..03d571b131eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15884,10 +15884,10 @@ F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
-F:	include/linux/netdevice.h
+F:	include/linux/netdev*
 F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
-F:	include/uapi/linux/netdevice.h
+F:	include/uapi/linux/netdev*
 F:	tools/testing/selftests/drivers/net/
 X:	drivers/net/wireless/
 
@@ -15940,13 +15940,13 @@ F:	include/linux/framer/framer.h
 F:	include/linux/in.h
 F:	include/linux/indirect_call_wrapper.h
 F:	include/linux/net.h
-F:	include/linux/netdevice.h
-F:	include/linux/skbuff.h
+F:	include/linux/netdev*
+F:	include/linux/skbuff*
 F:	include/net/
 F:	include/uapi/linux/in.h
 F:	include/uapi/linux/net.h
 F:	include/uapi/linux/net_namespace.h
-F:	include/uapi/linux/netdevice.h
+F:	include/uapi/linux/netdev*
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/

-- 
2.43.0


