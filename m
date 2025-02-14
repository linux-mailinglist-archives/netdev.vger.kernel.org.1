Return-Path: <netdev+bounces-166597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5ABA368A6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34673173753
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A561FCCE2;
	Fri, 14 Feb 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCxLcCYV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369F1FC7F7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573023; cv=none; b=rTXKXfHR/nIyADwD3FyfUI1FA6BD1Tk9QmnGaKZdFktXH4aO0H8R0ivejreR3ZwYPnZlGCPcH2KvWfOt62XESka+Xrmb0p3MJ2PDlzblrSqKrBZB3sDSRbOnUHExWKfsdc2uLv2WkOFyeQIo9g6wX51w2QUoePag4bl7DwBRfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573023; c=relaxed/simple;
	bh=2BC36gQDXDCoKHBgpS5CCTZf1quFF3B8ruY7MYYR0mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYOTRgn4E/JLstSlpKZPMsvT/vqSGvIbLWJ7Q1/mQpBcWcrBbOTv+U8lPWJ6H0GJ0DF5fH/jv8UmdI1PU9Yo1BDxXvPABrGjy2Bs3IUurx1e8hLDnSW6jh5QzBTKMNFa6HGg58cXbJC0uO3r6630y48BkRiilZAv7p9H9gvMBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCxLcCYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19677C4CED1;
	Fri, 14 Feb 2025 22:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739573022;
	bh=2BC36gQDXDCoKHBgpS5CCTZf1quFF3B8ruY7MYYR0mI=;
	h=From:To:Cc:Subject:Date:From;
	b=hCxLcCYV4fWSeDUsDKmfS2ncN0AT9Dt6X/rppT0Vmbig71aDHg0jxJwoh64Xjr/+9
	 OXAmLtPfiejSsjJ/p9RMR/huHaefOZ1c3n/ybohciq3xF6zN3D00JTx2sY2qI6gPXa
	 szE9oFbUQIoOlyntgalaD81GDX3uPERoM1/1CTkYh3Mh6PuIezki4dTf0VRV5aYgte
	 o/yA1YZ+KaVcCwHyyC1Ke5M0ni2tutKGuL/jA0Hpv4UiLMsXmnn+FXxApVlFI5EZyD
	 7FRCUJRe+RX3TeYsgg37QRIUjEDgvhd3O8N4m01TYquwhM/yRm0g6iqeWVqxZUjPES
	 PWyYcTNI2JHCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	andrew@lunn.ch,
	ecree.xilinx@gmail.com
Subject: [PATCH net-next] net: move stale comment about ntuple validation
Date: Fri, 14 Feb 2025 14:43:40 -0800
Message-ID: <20250214224340.2268691-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gal points out that the comment now belongs further down, since
the original if condition was split into two in
commit de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")

Link: https://lore.kernel.org/de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Gal Pressman <gal@nvidia.com>
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 net/ethtool/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 98b7dcea207a..271c7cef9ef3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -992,8 +992,10 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
-	/* Nonzero ring with RSS only makes sense if NIC adds them together */
 	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
+		/* Nonzero ring with RSS only makes sense
+		 * if NIC adds them together
+		 */
 		if (!ops->cap_rss_rxnfc_adds &&
 		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 			return -EINVAL;
-- 
2.48.1


