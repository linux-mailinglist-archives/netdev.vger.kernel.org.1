Return-Path: <netdev+bounces-129063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D797D480
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262F228402A
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEA13C3F6;
	Fri, 20 Sep 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cv5twCDS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199237DA76;
	Fri, 20 Sep 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830162; cv=none; b=EKkChH7BNxj4jOBa6odkuMmOW1eTZsjhqOlcfG3q4qrKUFirY2x669SBTBSMpEFD4PwV2nVRDIvwm7CpTUriceZQBv36nfnb5WNbS79Ua7k2ewqYeZdkVgddfWVyLxk5n5Emvrk02W6FaBMEPDqKwTrN0YmWzXHYSRdoF/9uIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830162; c=relaxed/simple;
	bh=zFLPkV5XjB0qkCSNYvCEWZU0VCFSWNUkhb7OzTGfOUg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kqeJTslne7p2cqJ1nqcQz8Y+64D5n7uEc+TCFzxnW5T3BnDpl9Jsex1LeVgAumIqzRgX1VCZGcINhjwzDBHTitohVC6KGo0iUU6OJcOeqHJZrrnXgox4vyFtwTGDbC8IIBciFI6bpsvf4TUEw1kEIAtTajhaXFb0XvNQksRMyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cv5twCDS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726830110; x=1727434910; i=markus.elfring@web.de;
	bh=5lLOSFSG9mhzZCxoUT9gqo2ko2jbykdEX5ZMcrTCqqA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cv5twCDSbYPidcGkWUgi7bInQ6Fxt8KoL3KQsfc7TucWyrukC64G2E1K2fPwvAeB
	 bR8OTIhXmvamJJyols/2+trVzLgswsmgiyKRZ+uOi9NG8k1J4fYBH0PNWsNnJSEA6
	 TcwKc+Wnwq0XYB/oKFfpe6oW+2/hshpdSrCm9AaEInmHUhCWoAyqBey0v3dcoSBsq
	 gUxAPjNFTnVXiWUWEvRNz+PsDZozCuUFGGoMAQkuCTehADlFg/6n6+i+hTdV9SoVN
	 bYZ0OJg6NI6MqoyJJCqHEYC7MjcuuDyVO3qoNQqMq5tTSsE2bbjS3yYnxuUMgm8ur
	 ZUgaQK7208TDb49VOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1roXaK4B7l-00xQV9; Fri, 20
 Sep 2024 13:01:50 +0200
Message-ID: <330c2b9e-9a15-4442-8288-07f66760f856@web.de>
Date: Fri, 20 Sep 2024 13:01:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Clayton Rayment <clayton.rayment@xilinx.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: xilinx: axienet: Use common error handling code in
 axienet_mdio_write()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XSLuD600Eg4etH3tvnH0Z216mHgPuhqWJhqAUwh8thyKuaNPK7b
 7hKHWQcJoMgZz25PixI9t6PfNYQv1UrER3UAwJ6KbZuU0L0Lr91Idfim20U3hyL2mmrPVs+
 uuMizDENCkPTp2KU+o2f1GuEks1LUhQggcB1QVqxjkHq0U6PoeiGPF4Vv2nE+K7nzuHb7IJ
 t5BO7XyJ4qy4V5W6u64wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hubf6ZAdFMA=;He1VW0lUejwFHQ4NrAyPLsRNwEY
 ygVjG2gIdm+zMr/WlfqNMIP9d5/vGSIuB5lNf/o3HO8OMtDhtMoclcheYq4CI7XW9QuA4CyLC
 QT4jUWdErG7p2Fr5RveylqrD0uIR7zL4ZYbOpJrYVqt2t0KWQ3UaUFiEPq57evnKC8DWp4aDw
 Iukf/aFLPjVkPnuMwaa3oQg3gnuhYQYa8tKu10j+MN7WpADrQg8w0f8nYkQdPrpAjXzZUmlEV
 ZzAMwL1+JsfiFhq9zoXQU3gK4iomGTWh+FBYQUmSW02Uj3FDKr2gDJbAPslztmYG2tDA4jdFY
 HIfPHxn5fTETb/a8jjVfMaoKzAtgB79BC1NsWGwO6SJNdd+U/bHDGI8V7gGHRmvzL8eFKUZ6o
 3FxoUIUiM16C+zUs9PEJuR5MsNexRAPnQPRiHYf0scXRmtfVLkGsNpMYi+lBN7VFvrtzip4DF
 /FukX580jzbbjwqjxHlt3GuOHAcAt1X5ffTjIGwJGPsgov0Pi/wSMv5aZ4ztBdPWVWr2zbsTH
 QkBCuHdx0x5E88CYi/I4o2Gc/D30/pEEMcLfsrohxO/kDO56MFBVtC0UnAa35qm1yQdoeJPkm
 wvjRjomnWrBc+s2Qz7IwAbICGkGeT62GTe+hFvQ10Vel6YGta0q09Cdoxzyr03xA9akbQBGWT
 RPe3wMp74rxZoQwGhHPui2q3VZwjHAmUgrkstcHxbYareIYtjAtBsKH/n3l+QNbdCQIyHogS0
 26sy2B3AWLFTUzsaMScNOeBMsFG58B8US9kZ9DP7vcLMKMYPF7faDQzDh0W7+gHhLb22AVI77
 gi3H2clcwOeL7mcRGVAnnHXQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Sep 2024 12:43:39 +0200
Subject: [PATCH] net: xilinx: axienet: Use common error handling code in a=
xienet_mdio_write()

Add a label so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/n=
et/ethernet/xilinx/xilinx_axienet_mdio.c
index 9ca2643c921e..0c7b931b2e66 100644
=2D-- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -138,10 +138,8 @@ static int axienet_mdio_write(struct mii_bus *bus, in=
t phy_id, int reg,
 	axienet_mdio_mdc_enable(lp);

 	ret =3D axienet_mdio_wait_until_ready(lp);
-	if (ret < 0) {
-		axienet_mdio_mdc_disable(lp);
-		return ret;
-	}
+	if (ret < 0)
+		goto disable_mdc;

 	axienet_iow(lp, XAE_MDIO_MWD_OFFSET, (u32)val);
 	axienet_iow(lp, XAE_MDIO_MCR_OFFSET,
@@ -153,12 +151,9 @@ static int axienet_mdio_write(struct mii_bus *bus, in=
t phy_id, int reg,
 		     XAE_MDIO_MCR_OP_WRITE_MASK));

 	ret =3D axienet_mdio_wait_until_ready(lp);
-	if (ret < 0) {
-		axienet_mdio_mdc_disable(lp);
-		return ret;
-	}
+disable_mdc:
 	axienet_mdio_mdc_disable(lp);
-	return 0;
+	return ret;
 }

 /**
=2D-
2.46.0


