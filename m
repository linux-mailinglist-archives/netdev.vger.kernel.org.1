Return-Path: <netdev+bounces-208531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2AB0C062
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B578D179926
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90DA28AB0B;
	Mon, 21 Jul 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="UKaXS/Gx";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b="WIghZZxQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail13.wdc04.mandrillapp.com (mail13.wdc04.mandrillapp.com [205.201.139.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28828BAAC
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.201.139.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090497; cv=none; b=otKL5GLHhRCJnjYk1Cmb81JPi0bQbpC0n88YKq1nbiGeSrc1gNdEfCwlWnTawQjzcMNqp53UZAt8HnOwUpEZnTtNd35KtIJeZZezEUCl4A1FgzU9L4GvNLTMakZCYPZt90tP6iEAHdzYYFPThEPcozw09xdFGt7huPEM17dQYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090497; c=relaxed/simple;
	bh=CIwa1F1Fs5Xlpv6F48It1eEM/yAEFpRKwc5iQ52Sf50=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=c1f1DilAEm9o+NG7/9LfNVXGTK+AE9WzM47lzkllg01Ts15xFRNs3lhK8sV3IIJ2uv4fADpYmARS3iw4wBWNFu89jjbnWsxpJgwk3TGcCrkQZ1ppr+88BCoX+0RIMid2S1VWdD8ywt0iVuTABdq9adyvJWVy4miHG+hsJL1uEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=UKaXS/Gx; dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b=WIghZZxQ; arc=none smtp.client-ip=205.201.139.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1753090494; x=1753360494;
	bh=pzhiMITcrf85hN71FsV2AGWriyLD4v+u3soCymoWcEw=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=UKaXS/GxHa2u1yL/yYflHC7mRWyyoz29FHFn0qLrx044WxwVyV9Ijy256Ha4g5MjT
	 L8hDgDUA1MwerYxRkDT25Cl/Vg4bx1mIlFlc8sCP64UtW71/vS1J13qQw1J906hn7F
	 dOeejB634HM8fMekjsh1FyNI5pmBa3dWYGO753CTxcg75lai9HyB+lH3ircaJQk8jW
	 jDWV++D2prEwNijh4CYAtwLGbL90RY4UgYtyL6AnL8v5igPiGQG22sEL35TQJ6PXO9
	 CegVAGya890u4l7ccod7EOtXG04OLnLYYq54mCQ9+GCicXK3nhmtoyzhpB0rQza2zz
	 rFds5cfsHiMTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1753090494; x=1753350994; i=anthoine.bourgeois@vates.tech;
	bh=pzhiMITcrf85hN71FsV2AGWriyLD4v+u3soCymoWcEw=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=WIghZZxQr4UIoSLkl2yYnjQkpHAs5k685c+/3gAysrnInvcohVmZOth6SphBBzmGB
	 FPZ0Ro3b3a2/u5vl38Ad9knxat5K6eifHVPgoGdi5DeAqwM1jIOwiJ4TOKdmomMURu
	 4M1sZSxv9nfs44RTiksl4qbUjR4l+KRMcgF6U1NdyDtawngWfk7AnZwLUxrLm5cdBb
	 qqEpqKWG1qeUWTRtsJ6lVcvAJpjVZO1FbmFjBVuIH2juIwKT7VJoEn56GVBFzC47DN
	 3FD47Hp7mbApbDbtvyU2GTDUD2S9suoMshNEGjrC/GDqgkus4GJ3UcvUeB9PYBmUCH
	 +1r0K7dKluasg==
Received: from pmta16.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail13.wdc04.mandrillapp.com (Mailchimp) with ESMTP id 4blwGk6mgCzNCd9Hl
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:34:54 +0000 (GMT)
From: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>
Subject: =?utf-8?Q?[PATCH=20v3]=20xen/netfront:=20Fix=20TX=20response=20spurious=20interrupts?=
Received: from [37.26.189.201] by mandrillapp.com id eaba8881b64946899a0c251f1eb365f7; Mon, 21 Jul 2025 09:34:54 +0000
X-Mailer: git-send-email 2.49.1
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1753090492977
To: "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Wei Liu" <wei.liu@kernel.org>, "Paul Durrant" <paul@xen.org>, "Jakub Kicinski" <kuba@kernel.org>, xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Cc: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>, "Elliott Mitchell" <ehem+xen@m5p.com>
Message-Id: <20250721093316.23560-1-anthoine.bourgeois@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.eaba8881b64946899a0c251f1eb365f7?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250721:md
Date: Mon, 21 Jul 2025 09:34:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

We found at Vates that there are lot of spurious interrupts when
benchmarking the xen-net PV driver frontend. This issue appeared with a
patch that addresses security issue XSA-391 (b27d47950e48 "xen/netfront:
harden netfront against event channel storms"). On an iperf benchmark,
spurious interrupts can represent up to 50% of the interrupts.

Spurious interrupts are interrupts that are rised for nothing, there is
no work to do. This appends because the function that handles the
interrupts ("xennet_tx_buf_gc") is also called at the end of the request
path to garbage collect the responses received during the transmission
load.

The request path is doing the work that the interrupt handler should
have done otherwise. This is particurary true when there is more than
one vcpu and get worse linearly with the number of vcpu/queue.

Moreover, this problem is amplifyed by the penalty imposed by a spurious
interrupt. When an interrupt is found spurious the interrupt chip will
delay the EOI to slowdown the backend. This delay will allow more
responses to be handled by the request path and then there will be more
chance the next interrupt will not find any work to do, creating a new
spurious interrupt.

This causes performance issue. The solution here is to remove the calls
from the request path and let the interrupt handler do the processing of
the responses. This approch removes most of the spurious interrupts
(<0.05%) and also has the benefit of freeing up cycles in the request
path, allowing it to process more work, which improves performance
compared to masking the spurious interrupt one way or another.

This optimization changes a part of the code that is present since the
net frontend driver was upstreamed. There is no similar pattern in the
other xen PV drivers. Since the first commit of xen-netfront is a blob
that doesn't explain all the design choices I can only guess why this
specific mecanism was here. This could have been introduce to compensate
a slow backend at the time (maybe the backend was fixed or optimize
later) or a small queue. In 18 years, both frontend and backend gain lot
of features and optimizations that could have obsolete the feature of
reaping completions from the TX path.

Some vif throughput performance figures from a 8 vCPUs, 4GB of RAM HVM
guest(s):

Without this patch on the :
vm -> dom0: 4.5Gb/s
vm -> vm:   7.0Gb/s

Without XSA-391 patch (revert of b27d47950e48):
vm -> dom0: 8.3Gb/s
vm -> vm:   8.7Gb/s

With XSA-391 and this patch:
vm -> dom0: 11.5Gb/s
vm -> vm:   12.6Gb/s

v2:
- add revewed and tested by tags
- resend with the maintainers in the recipients list

v3:
- remove Fixes tag but keep the commit ref in the explanation
- add a paragraph on why this code was here

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@vates.tech>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
---
 drivers/net/xen-netfront.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 9bac50963477..a11a0e949400 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -638,8 +638,6 @@ static int xennet_xdp_xmit_one(struct net_device *dev,
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	xennet_tx_buf_gc(queue);
-
 	return 0;
 }
 
@@ -849,9 +847,6 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
-	xennet_tx_buf_gc(queue);
-
 	if (!netfront_tx_slot_available(queue))
 		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));
 
-- 
2.49.1



Anthoine Bourgeois | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


