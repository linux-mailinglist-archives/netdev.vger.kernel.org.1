Return-Path: <netdev+bounces-135104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47899C420
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF1C22709
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7515990E;
	Mon, 14 Oct 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCPooX2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BB156C5F;
	Mon, 14 Oct 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895959; cv=none; b=kEXGLhKm9Idv14295k+4tL03Ghng3BG6ugWqIuCWvHV+9IXVhEFqfUK084uyCCz4ZslEEkXsN46mWwy5fRzKMZW/D5VYsjOrxXdcazjr6QxN0J6Ua82UVE0Tcc05aBOvnnRC0tEua6ULV64qoE+cbqGItgloH2nsinHQ8EWxpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895959; c=relaxed/simple;
	bh=3XMChqUk8p9xN3e3V3TIITrB6Da+CGbGZaKpJzpAmIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEjcbx1U8NHciBzTXhebgpn7cXX3BrpUJKElNYrJo91H03ky+2p7Aj7bAXPdSX3BYE50rtiS0NMra8vW3DLOPqfXffSnxIvtZqd9ncM551bXSDnVfSSfDVWNi10LF0vGnxySrM+4IkmdPhGgEjMxBkm8X4nfpJuDAvvpSy4o57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCPooX2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A12CC4CEC7;
	Mon, 14 Oct 2024 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728895958;
	bh=3XMChqUk8p9xN3e3V3TIITrB6Da+CGbGZaKpJzpAmIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCPooX2WLLO2zlzh81zErlzEgxHtaXmUBViCaNDP3/nu7mBP5tB5W2M/HGRaFmSH1
	 zHHFAYGHbn2RVwWofXCao4prLUIHxUqyMh8qaFf00MsFexiYZ8VZ4nHrhR9ohsJYcI
	 HETJr2/cRx3ObjNr1LKxNorjlCqHkDnBzpvj/8wM+6ObTUoxSYORmRDoDd4cKmkcpQ
	 k0cF46I3K1NnbjVBjdFhZ2pwushzI0csSHd6L+NXi6vPi7K9XaZ/llGt+yK4w3x+h8
	 Mr+vC51lKe1BxQL48xKUAgva5FhMGJCoAmxGLV52q9YTe+0rybEjNr8L4P7iBrChoY
	 cdp1Ckx+hMwfw==
From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Oct 2024 09:52:26 +0100
Subject: [PATCH net-next v2 2/2] net: txgbe: Pass string literal as format
 argument of alloc_workqueue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-string-thing-v2-2-b9b29625060a@kernel.org>
References: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
In-Reply-To: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bill Wendling <morbo@google.com>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, Justin Stitt <justinstitt@google.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Recently I noticed that both gcc-14 and clang-18 report that passing
a non-string literal as the format argument of clkdev_create()
is potentially insecure.

E.g. clang-18 says:

.../txgbe_phy.c:582:35: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
  581 |         clock = clkdev_create(clk, NULL, clk_name);
      |                                          ^~~~~~~~
.../txgbe_phy.c:582:35: note: treat the string as an argument to avoid this
  581 |         clock = clkdev_create(clk, NULL, clk_name);
      |                                          ^
      |                                          "%s",

It is always the case where the contents of clk_name is safe to pass as the
format argument. That is, in my understanding, it never contains any
format escape sequences.

However, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue as suggested by
clang-18.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
--
v2
- No changes
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 3dd89dafe7c7..a0e4920b4761 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -578,7 +578,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	clock = clkdev_create(clk, NULL, clk_name);
+	clock = clkdev_create(clk, NULL, "%s", clk_name);
 	if (!clock) {
 		clk_unregister(clk);
 		return -ENOMEM;

-- 
2.45.2


