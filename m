Return-Path: <netdev+bounces-133176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4099537A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD041C24CB0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB718C327;
	Tue,  8 Oct 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwU+2M7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2443B182
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401840; cv=none; b=Vhz2AukkC69Injzsh/vSCADlhLxUIe+nn6bFAjY0LlR55D1H14FMgYhgERcMe+xqadTlw5riNvNtgV8QI0Q98SeXHX6fqXLyil8tcT4D3EtPkbcYj0H1htgYGqsNptuIJ1C0MixLOF9K81QgAN0dLhz+Xl7LCWJC/oAKrPpPNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401840; c=relaxed/simple;
	bh=/4681f8Dj1sF/J44wHOESOOI+3iDokqhncOC9KUJEVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4QhZGCqUaY3G0Tg/06XxdMwlAuaKMqSfQqhpZ5Z0fKmQMBqJdjwFq7ldEkKNuJUqd6Knu3vVIQQ2XPTa15Xs35ImqtIuNQaSKzaugd33/dLdlyK6vuJe01yKw5h3VCyWdgk7h0YSbipxUTRCnizQlg9lUQbC6+U7AZhkI2W7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwU+2M7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67EBC4CEC7;
	Tue,  8 Oct 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728401840;
	bh=/4681f8Dj1sF/J44wHOESOOI+3iDokqhncOC9KUJEVg=;
	h=From:To:Cc:Subject:Date:From;
	b=rwU+2M7i0oCrvaK0WKe4si8Cs+p9Q+2K3ljB71TmJ2EFvC2S7IoEUqahaAJ/e4vVY
	 PA+sJzYhLLvCexxH7GayD+c5AqEHra+NliN5E7YR1W3wDQ7d9DSFYa8pMD/c53p6Tp
	 tAwp+6RmWBEfA6+PBkfjGEE8rzv75W3y+nP9SvpXpmkibS/HJIbz612oPpg2IY/3C1
	 PqK3WdJkIxgBISITFtd0inqCqA8eQ/dVO7D5TXC3KOOH5IVnEfogYeRzKMGOF4wEbP
	 vIh4I6NwSR4tKmcHLtjgzv6Kt++vo2ejGbsQpE4MkBJ2+wsy1zfshqvgwiTSX6HsoI
	 DIvn4m4tmKa2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	konstantin@linuxfoundation.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: remove Yisen Zhuang from HISILICON NETWORK drivers
Date: Tue,  8 Oct 2024 08:37:11 -0700
Message-ID: <20241008153711.1444085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Konstantin reported that the email address bounces.
Delete it, git logs show a single contribution from this person.

Link: https://lore.kernel.org/20240924-muscular-wise-stingray-dce77b@lemur
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af635dc60cfe..e5311fc990c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10267,7 +10267,6 @@ F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
-M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
 M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
@@ -10276,7 +10275,6 @@ W:	http://www.hisilicon.com
 F:	drivers/net/ethernet/hisilicon/hns3/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
-M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.46.2


