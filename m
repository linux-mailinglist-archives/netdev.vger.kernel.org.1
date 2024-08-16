Return-Path: <netdev+bounces-119193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CB9548E0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8060C28576B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C71B5801;
	Fri, 16 Aug 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/kYvW20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7416F839
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811911; cv=none; b=m0DwsSez4r1f1w7qX2OfGlpsElY60ISpkOLVt+Yo0d6r9YBea55t6F9rcFvNUHIZfmGngwAk8U4v3s0Hch2ExcbflACKrMXFf1bzkDqjRYRtTYkM6e8zU49b6de2GUIZuZHN6RWaQz0Zb6ZRCF/bFvIqlI9Dysq+B57n2LVU22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811911; c=relaxed/simple;
	bh=/bX9xVJA0zmeNOu9xyBVtiAr4NvJ9P78zOVokgKQgac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnX1DnwwnZkzeEmU4Roc1DhXKyneQbZoO16o+YONFz2dQ3cuCCpuNKaU26nzHwEDDLj6YIOqa0xn5ehyFe0587WA+ha3HtjEA16p4TQBO1BwXRYXFkzZ/Y5NgR2XlnoBOxFFVDU5g8rGwK45Y2Pw5oJQjjPXKBvuCjaBuaIc0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/kYvW20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F9C4AF0C;
	Fri, 16 Aug 2024 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811911;
	bh=/bX9xVJA0zmeNOu9xyBVtiAr4NvJ9P78zOVokgKQgac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r/kYvW20tWghzXlYJkjfu0vyer664ldoLknq/vjAJvptrZU2g1zMe1OgztWPcUN6J
	 zWiyEHbnTfhe0kODsH6UHeGBebLzYyYOk5AO2C0/9HE+jiEb6l7fx/h/LMJW8M81wi
	 0lR0dcpDIqSXwJBSRD/iwpTYUyb8l09+SaO4sDYvR6Sg2P7a0cPHN6yXfh4UOw4PqM
	 YieM/xC9zsvx+dkcF8eluaI+lgQ1oz9CdcIDcn6Jyuv8LFErpSERoyPyNqvVJonheK
	 Yn2yMBgRsEIlg3yIsj7hdMKDxtTlmzD67w8mSqPRpV87/JVUWRqzuf7a97JWo4cLxe
	 IFXHtodZLCwjA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 16 Aug 2024 13:38:01 +0100
Subject: [PATCH net 2/4] MAINTAINERS: Add net_tstamp.h to PTP HARDWARE
 CLOCK SUPPORT section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-net-mnt-v1-2-ef946b47ced4@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
In-Reply-To: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" in
their name.

As it relates to hardware timestamping, it seems that PTP HARDWARE CLOCK
SUPPORT is the most suitable section for net_tstamp.h.

Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c682203915a2..28a67b93cef1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18403,6 +18403,7 @@ F:	Documentation/ABI/testing/sysfs-ptp
 F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
 F:	drivers/ptp/*
+F:	include/linux/net_tstamp.h
 F:	include/linux/ptp_cl*
 K:	(?:\b|_)ptp(?:\b|_)
 

-- 
2.43.0


