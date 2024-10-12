Return-Path: <netdev+bounces-134853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B139B99B572
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D737B1C210A8
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D9194124;
	Sat, 12 Oct 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fuNp9oMw"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA5193439;
	Sat, 12 Oct 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742603; cv=none; b=epWbHGbckvNjOdEThMTYEVc12EiZ4mz7hwJoq6zfGlB8L2cFEub2Wv8swK6HYoEzAazHDGy5pgMr7tWmcO3KIDfjzQckbjdOkrTHYjbJDW3eMq/tZl29eRNg3s85PEx1R7UPynTnny+PgugUhhYUMBGXbaqAaXoGOstwg3Dn/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742603; c=relaxed/simple;
	bh=hnjqJAicNpi1ppzn2fCTsk0vmq+3hV5cnMIY8X713jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5n9qCDtlNowRXgtuapsLxpCH26320559c13h1EmGOkzDYFe5V+H3N2MbHXogoviSRRk3+x39ha9VUSsB37kbziDiw9QHHvelPjYUq1AvY6ZRviueCwYynsVAuvEbwlfVj1xxzHMYBN+j/EigPi2YJI7h8KHHXuqhjdpJlRJimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fuNp9oMw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=24tjo+rrRkBg2Z20Lxo6DBsmtNmJsyIj1nNDj4+ZmG0=;
	b=fuNp9oMwlZ2QZrIqqrzWkofbhGW2rfFqrQT24XixgfG0QmA0E+hKZrfQQHJs4t
	tn/VmUmbs8DWAFBSOHklnso6ZSN7B8tQAM/lSfHUe2IMdc3FYdpBh8HlzR0GagGs
	9PAf8Tb6fKWwUMv8ecb/M9ArmFktkBGB3eKBSb4NBKKU8=
Received: from localhost (unknown [58.243.42.186])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgAHOnGKhApnaRqWAA--.26891S2;
	Sat, 12 Oct 2024 22:15:38 +0800 (CST)
Date: Sat, 12 Oct 2024 22:15:38 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, krzk@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet (3)
Message-ID: <ZwqEijEvP7tGGZtW@fedora>
References: <000000000000dbc80e061b01a34f@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000dbc80e061b01a34f@google.com>
X-CM-TRANSID:sCgvCgAHOnGKhApnaRqWAA--.26891S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8Q6JUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRB2amcKfY1iugAAsM

#syz test

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 6b89d596ba9a..31da26287327 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
 	struct virtual_nci_dev *vdev = file->private_data;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(count, GFP_KERNEL);
+	skb = alloc_skb(count, GFP_KERNEL | __GFP_ZERO);
 	if (!skb)
 		return -ENOMEM;
 
-- 
Best,
Qianqiang Liu


