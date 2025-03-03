Return-Path: <netdev+bounces-171767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2AA4EA63
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC458C76C0
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE729617D;
	Tue,  4 Mar 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="CYcVlL/P"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D52284B5F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107158; cv=fail; b=Uoi84oDmMX2FyyuTkHdSFem7N1zgctNUht9cykmzNGSwNmgSu93ZnWo83nqaRAeQZFTC+IFDQtqQPew2nMEyFMW7HwX6nXoNjpcNgBkmDhZXVQ7Q03FJ+vWF0knXtsKOFXzWi3ufW4FhIcu5o/wWYRlmeqN2VhNjHEEx58vq4y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107158; c=relaxed/simple;
	bh=Bw4mDZD4c08//3HY8Hc0y6Y1tAw+C3RLp34KKdro+XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJMU8/3wCh79QP/vf8y0HvXQZ42CN1VGhohgxAu41/0ycy4JvWRE/QEPWVUlG3CeflfaoqnBaRFmfXLRvSWs8xC1prveP+sehBj4Rwu/4hij6UkSIwBlwyVBO1gftE54MrKoKLnH+N3Jr77GnxQjzU3WAcfGf9FKx80pSDiu7DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=siemens.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CYcVlL/P reason="signature verification failed"; arc=none smtp.client-ip=185.136.64.227; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id B1EB440D1F40
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:52:33 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hL81w11zG3jH
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:42:24 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 09D0242736; Tue,  4 Mar 2025 19:42:06 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CYcVlL/P
X-Envelope-From: <linux-kernel+bounces-541102-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CYcVlL/P
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id EA17641C3C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:47:38 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id C40032DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:47:38 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DB71891C46
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E28A1EE019;
	Mon,  3 Mar 2025 07:47:21 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228441E9B1B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988038; cv=none; b=iV7h2Vu+BuZRM4jft5wB2J6Ta7/0Kd9WwhlHKJPPxR3k/pMM4pZXZzeqGUkGXI8FkbLUxOr9mSITAhPr/1NcQXz4i8iHthM2p8EFyq7k3hmXkwlR0IHFFwfTrlR1KWWbJSg8HKArFYGsLTDpbBE6FYuNndmqJKHPr2J+gNOvGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988038; c=relaxed/simple;
	bh=dZjutVIqRkydhliHBlHKI06qmvIDPbtRY2hMGF3LUjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfUf2VQO2CXzcoZ2Rz/09WfIC+1Qq7POx1BGOe0vPZKnbYBhG9wHcpunH3r9pbLmAiBFyGyhgqpWtXsue0P8xDlhJWHOO9JcJM2YGTo7YEVi+gSej6FvwJ5DC1CZr9metFH7FzhP0zF1eqKf8jafWb2gD2Ho1wrsPqNRXnMsGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CYcVlL/P; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250303074707015f5e560fc291725f
        for <linux-kernel@vger.kernel.org>;
        Mon, 03 Mar 2025 08:47:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zrUY1LdFYD+ZIm9007t+7YM/d7JBcqpKOI6aIegZ2eU=;
 b=CYcVlL/PjL68bJNlRASUCQFR3d/gIjvM8s4AWiorZd6ei35cbjWVNs6MczurZckPUN1Rcs
 iHZ5t/HOJYIxhnroa7iKaNK1OChsV3p0HcM/IK+AJlqz/Bh0kPTHIBJ69rCl3Fe5g7U4F2JF
 pIXIbZVy081/oEQpulGIusFY+b7+6j+EuKJfie3f2YKeQCiyaScowPbnyR6APxUWfNP7ES0z
 MQuc2WdhLii8ZsqxFztRSOL+PjlwH2s2r6+Pcf4FCquunpcwJydjFZ+MhpDWQD2yNesOcYzP
 ZTikariIq1dGzkrS1XGfgIM1tAB3A+rsx4vlwGVyua8NZ0jD3tVlUg0w==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2] net: ethernet: ti: cpsw_new: populate netdev of_node
Date: Mon,  3 Mar 2025 08:46:57 +0100
Message-ID: <20250303074703.1758297-1-alexander.sverdlin@siemens.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hL81w11zG3jH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711828.42369@PFUf2fu9N4l1zLjgpDKBHA
X-ITU-MailScanner-SpamCheck: not spam

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

So that of_find_net_device_by_node() can find CPSW ports and other DSA
switches can be stacked downstream. Tested in conjunction with KSZ8873.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2: cpsw-nuss (am6x or K3 naming) -> CPSW (am33x naming) in commit messag=
e

 drivers/net/ethernet/ti/cpsw_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
index cec0a90659d94..66713bc931741 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1418,6 +1418,7 @@ static int cpsw_create_ports(struct cpsw_common *cp=
sw)
 		ndev->netdev_ops =3D &cpsw_netdev_ops;
 		ndev->ethtool_ops =3D &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node =3D slave_data->slave_node;
=20
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
--=20
2.48.1



