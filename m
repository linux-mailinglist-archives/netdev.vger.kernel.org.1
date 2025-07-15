Return-Path: <netdev+bounces-207209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C459AB063F7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28022581B4F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82808258CE7;
	Tue, 15 Jul 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="C751+lZk";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b="O2xWbEb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail179-35.suw41.mandrillapp.com (mail179-35.suw41.mandrillapp.com [198.2.179.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82725393E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.179.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595892; cv=none; b=RAbGf0juJxPJKkQjnF8V2dv3uuHm6fzMnaNUp3Cq26y/KQHLa/YQiq496c15u/Ga7eRUuLo5Pnw7Sb+cwsCTrGDSZI5L5Rk5UGsv60aZPwu4X9pQtdz9jh702GQdHNOSbeLO/AAOZKqehn8mcFLtT5Bd0BV03cJfhigIWHu+tvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595892; c=relaxed/simple;
	bh=rzCkxuJTpYyqmKH/3E89X3yVoUJAQGAPO5hwaR34Hjc=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=UKjKbbCwUVyTRzZ53zHauoVZ+iHAT7izuff4FYPD5bS0AOL4/wC/5lV+snwHoVVX5jRWsEGawM2xIqVKuqRDs8PPsAm58vaw8LLxHeQiCRdzbh2zv8qqQZPnxwdVEDwtD3Ah7uljOe9/g9flnx2BvFJVtcyXJdl6zqySsyYE3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=C751+lZk; dkim=pass (2048-bit key) header.d=vates.tech header.i=anthoine.bourgeois@vates.tech header.b=O2xWbEb1; arc=none smtp.client-ip=198.2.179.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1752595889; x=1752865889;
	bh=ES5jwX9dQor6Si9bkkhIPkIUgo1wrvr/KsnR/l+M9QM=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=C751+lZk86imdeILVZHpZWGn7iyDDHxefCjlvGBsGIl8TpsmQIFL6XUD1ZH8vfp4a
	 e0VTaEzldARMOhvcjfkNisUFfgYnYwpp/5RZoEvADjDBhsmOOME6BHOp7w1DFQHWDG
	 cCGF4jNukFfgkc+DcJG+7EMw/mSweNSkmGVNChnLfcvUDRxbl3S0MQ4wtU8dMwrZ/4
	 2dA7xTgEgcB04Tvl4QxiJpxgmaOTapgAuFRaJ7/keO61Jmbg4UPa2ZK2PJhX1xvlpb
	 +izaDzX75Dg+XncTJQ6EMIyDfxjHdIbdLIRp9NcvJO7+fLP6DfSkOn2/V1eSYFEO8Z
	 fr/GMLBVnJ5CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1752595889; x=1752856389; i=anthoine.bourgeois@vates.tech;
	bh=ES5jwX9dQor6Si9bkkhIPkIUgo1wrvr/KsnR/l+M9QM=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=O2xWbEb1hZf11p4VITgku8JweODo0KIQqkDBVvsEvnWdi6pT9673K9QtSbz38uqIW
	 HdL7gr1X6LfU7IzqIYt5sZxBzt7WNfy+sKmKYH+zFYKp0moYubdnNFhN5x3YMyg5qR
	 GVNzi5+Ley8cNgj6SGpXeHmIiJ1Sw+UwU6FdKm6/9KeuVPF/3wm/zYkf/LGpkQrGwd
	 iVnHBVA3kLVAVORfdfQApB/GymVGuR0x5g0rC3fLpY/y3a57NujvsVPqEir63IpcfE
	 xN+/Ne0O0cFzRk3rCIhfVuCQS8OzMVgQZMMa4LvOU6Le7+Vl1DRvtSfXzv+VbPUUx4
	 FNMh1/HSrZmPw==
Received: from pmta12.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail179-35.suw41.mandrillapp.com (Mailchimp) with ESMTP id 4bhPM56VwwzDRHx9X
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:11:29 +0000 (GMT)
From: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>
Subject: =?utf-8?Q?[PATCH=20v2]=20xen/netfront:=20Fix=20TX=20response=20spurious=20interrupts?=
Received: from [37.26.189.201] by mandrillapp.com id 93957a0ecec14f458e0b0b36067cfba2; Tue, 15 Jul 2025 16:11:29 +0000
X-Mailer: git-send-email 2.49.1
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1752595888301
To: "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Wei Liu" <wei.liu@kernel.org>, "Paul Durrant" <paul@xen.org>, xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Cc: "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>, "Elliott Mitchell" <ehem+xen@m5p.com>
Message-Id: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.93957a0ecec14f458e0b0b36067cfba2?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250715:md
Date: Tue, 15 Jul 2025 16:11:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

We found at Vates that there are lot of spurious interrupts when
benchmarking the PV drivers of Xen. This issue appeared with a patch
that addresses security issue XSA-391 (see Fixes below). On an iperf
benchmark, spurious interrupts can represent up to 50% of the
interrupts.

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
the responses. This approch removes spurious interrupts (<0.05%) and
also has the benefit of freeing up cycles in the request path, allowing
it to process more work, which improves performance compared to masking
the spurious interrupt one way or another.

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
- add tags
- resend with the maintainers in the recipients list

Fixes: b27d47950e48 ("xen/netfront: harden netfront against event channel storms")
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


