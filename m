Return-Path: <netdev+bounces-177682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A4A712DE
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFD03B5076
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00EA1A3BA1;
	Wed, 26 Mar 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="KyCrqoNk";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="h2goKGQl"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33E1A23A9
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978440; cv=none; b=A8e3u0atMkKx/sRvJXZHzk52ZiYEeKfbpyizcDGKS1G6M0yaAMSqwEiv8A63ytDQ9SqMDp1Exv25y/A/ACYFN0LYf+BCTLMM+HwGSPPacvoPrMeY4CvE+75UdURduEjxDsVaimbvNYAMUPlR3W2L7VDtKCbGBlQCp66i0BXJlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978440; c=relaxed/simple;
	bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PBwBvjgInHfSjFFoGFO6EyCXByAg8zs9AUvKmy9In2/07VWFqwACaKn6r79O6KSsJyH3lF//BdQlsgG0E0DCKJbk1zXcNnEbaFdw/jommuOVtW5ApowW0dtBOqTbwVuTB3TjLE36lDxA2w7Z8hbtBBIlwDSD3e61C6adqt2PEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=KyCrqoNk; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=h2goKGQl; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1742977962;
	bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
	h=From:Date:Subject:To:Cc:From;
	b=KyCrqoNkC/Ia0M/HbiXwWcLsxM8OrshBP9wjlnNgcWcxZj5PwXtNIoAj2w+CM2TLq
	 1oTpVat0ToFbCoGNSzJmTW9ZOdZrdhKd4GP2C4+ieuVlFL1FSonDLrGqv+e9fMTo/L
	 UZP7ToyIt0LggI+GOIMGc9EL866E3OOj/rH9/qMMzqB/buhKcOwsv7oV0cULSqGN8e
	 hcwcPuIlxQTiez3Ygo2GsBL3ef4d1TJg87loQ222xei3n2IKQrtwe1DolOv0ExumMa
	 X+h9je/nTKdEc+ICXNqjNq/V2LIRXRwI0Y1TOIwskr2IFLa/de1EM9HDcOFubQ2Gzx
	 DtviG9Evqls/w==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id BEDA6A41
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:32:42 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=h2goKGQl;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 3682DA41
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:32:41 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254bdd4982so166596235ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742977960; x=1743582760; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5X6bjgAmnqJeE1zDjlF2ZnFDYz5C8T4cY+6ErJYvhHI=;
        b=h2goKGQld0eoGhF77+DQSgRmo3kWimf+unycQe/Bdn17nVOWYEmD0tvB6pwJTmlp3i
         jfKhfGjCXlx+EjdZuV3Iq3ixmJgRr2FUj4TunOt4NXH5Ddk+6aX9tTT4otStGETiON/l
         i1QQLi6IuyfN4ZHs55vqvU11mjMxYHM8Ncmn4oAiUeYIhWRc90X1aebbujkjnAe638r6
         iEPfHzk9rGETDzXyhgIEg8wRj2UDCOv6q3odsKZ+8bXEvEhsnMrKbblGEvslCXXrsxPQ
         qBC1DUUE0S6U+IBLX5bg/BBQUw5tfvE6E/KU9YDqAjD3wtpf7MwYM88XQbhusLd8v9od
         Hnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977960; x=1743582760;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X6bjgAmnqJeE1zDjlF2ZnFDYz5C8T4cY+6ErJYvhHI=;
        b=AwMp7Tkpm3evk0WJ236kMZwvWE+5xuuDVY6M7N4hXHtTZi1mR/6j0zt7GE2xFcNymq
         809BqLGRFnFNI9Z1g5oCGvAtXiRzyp2ezcKMDWXbF2sXphKvPRtao6mdhq3qsYhVwHv9
         VCVVF/FWLgYAN1z2bK50NCaFjaOqMA/V+X1OZSNFDUfrZ61TeECqv88GM5wzvxbS5r8/
         ftwb7jEYSUMk4J8lSJbAw5s/lNLQX1ip06CIHJ3WwYrvwNY5qy/8yN1HToSTZ7tk9XOk
         GPLzIHYz4rsJzeFa5UnaXlEotenPxfSp/bJ7wbImOz6qCSJCZ/78yPck6M0k3s87TVOS
         Vgzw==
X-Gm-Message-State: AOJu0Yy+U1BlohBn8GWlcuKG/SqPeRyl86JY/N6W9huehBTrKLwSFnSQ
	hOmUgOT7JUNzo4AfWwErPuQwZTq3X7LarbgrPbVuYLf8mPsnKnNGoMl5jyBqGZ6mXfyL13UknXc
	pbtaAxKIurbz5PQUy+fg3o16qg3ZuwYU4cH0fERIFhbOz9uZ5gBlEkjk=
X-Gm-Gg: ASbGncslb6S/43h4QIH3w22fesFCN4IbxdrJhOLnL5sR90MO3EixvXmxyIbrET04IwI
	NFPpANsjC5moCcC7Ik5GfLy4Gy+KxdUQ5FeSpyXTepJKscrPnHb9vW77gDj5vXdxzinQvpCzGGG
	/3Jnv6M4AOAdKjj7MWyD57zJK++7um9pZq+eZiiWDWrthJc09PzxV3kTJWz2UlJvklJ+yVAOLEb
	sqf9I4qNcQFe/OGObJy2fE7l02Qw0Ljez+yLW++cyrXW/2PeTcBKVevRSSa/Ma6xQPmT4xv3+K9
	k1N+pD+XYGI/KACaDd4XZC0E2hxa1uZWZVj1upsRAxOO1wzF6Fr9YL7WH99sA0sn9g1TTtpgv7c
	=
X-Received: by 2002:a17:903:1790:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22780d7ffafmr331282025ad.22.1742977959945;
        Wed, 26 Mar 2025 01:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl/5IlHXqH0aB13xDFaYCORfVdtz8hAaULYBSzwHSWdGQtUhQFGCFwqrNs+4G3fTBWpyPAKA==
X-Received: by 2002:a17:903:1790:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22780d7ffafmr331281685ad.22.1742977959446;
        Wed, 26 Mar 2025 01:32:39 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811faae6sm104137995ad.245.2025.03.26.01.32.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Mar 2025 01:32:38 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Wed, 26 Mar 2025 17:32:36 +0900
Subject: [PATCH v2] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
X-B4-Tracking: v=1; b=H4sIAKO742cC/x3Myw6CMBCF4Vchs7akNyC68j0MMZUO0BhaMwOoI
 by7leV/kvNtwEgBGS7FBoRr4JBiDn0qoBtdHFAEnxu01JU0uhYLPyLOd8LoJhS+75VCK5vaWMi
 fF2EfPod3a3OPgedE34Nf1X/9S1ZpaZSRtmrKs7RGV0IJx5PzuPC1Sx7fhN2zTDRAu+/7DweKv
 MCmAAAA
X-Change-ID: 20250326-usbnet_rename-dff11e407634
To: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ahmed Naseef <naseefkm@gmail.com>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBn47ulGDPu0y4xObg81ZeM/RGWZMEWrb8QgxT73
 LoFtKKYgBOJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCZ+O7pQAKCRDyimB/1oxx
 By9LEACUn0d0TrNeqwWIw2qkse0TqsuERFt3yevQMkJbWUaS2XYL8ghnOPm84VKxBxllN8QBeC4
 ONXojVb5taUPBWbBaG0hQOMXDC8eEHdMAhBvYvezEHLC6DEadWg6WBHGFPT7IK9KaIx/PQ88I0Z
 bLFJ5utzVk6qi+V9NYvI82qTvv/SmDNzR1X5u9fHo94g7xz/bTDG1VXTYDqqCXjSd9Do3XFwmZr
 0PCb1OlERU0xg4udUZd24YwGT+r9A/I4jbSEkY+CdQE6MpOkxApZ6SzmAwgdM4jujAkQVZjOgR1
 YMWHXH/QkZDnbmSSX+Pb/Acsl90jDm/IZuGDS8P4PgQP0QDH8c9PnatPEm4Mi1QGt+qjfeTs1ol
 NnqeEXpl9DS0/YVKGyFgYd+D9ut5Tla1OS0uqbmW8kK5ED5YeUfCAPBNacb9beTc/didmW369iN
 oFbfaxxfoZtHCXvbNfRqLTnj571uoX45/dz64m1e2jcvIRHEaLglaUFsGpO801+9XYrIk1USY6c
 4Sjv52xgDr2miXkVcVHoXWb+d5rsz+9vrzYo9JZZ2vKVUW800CaPPYAo9tUFOc0iBDbMLZGl1dr
 dXE13tC6yobHnPrOWAFc5ruyHDXa1XhzLK8AXhQeE+JTpk+TVV5DlyuTYQkpm+5tltAa6xm2L/x
 sHz8VJHReSVsAdg==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
that local addresses always came from the kernel, but some devices hand
out local mac addresses so we ended up with point-to-point devices with
a mac set by the driver, renaming to eth%d when they used to be named
usb%d.

Userspace should not rely on device name, but for the sake of stability
restore the local mac address check portion of the naming exception:
point to point devices which either have no mac set by the driver or
have a local mac handed out by the driver will keep the usb%d name.

(some USB LTE modems are known to hand out a stable mac from the locally
administered range; that mac appears to be random (different for
mulitple devices) and can be reset with device-specific commands, so
while such devices would benefit from getting a OUI reserved, we have
to deal with these and might as well preserve the existing behavior
to avoid breaking fragile openwrt configurations and such on upgrade.)

Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
Cc: stable@vger.kernel.org
Tested-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Changes in v2:
- Added Cc stable as requested
- Fix block comment style (checkpatch warning)
- Added some more details about the local device handing out local macs
and openwrt, thank you for the reminder Ahmed.
(FWIW this commit has been in our downstream tree all this time and we've
had no obvious errors due to it)
- Link to v1: https://lore.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
---
 drivers/net/usb/usbnet.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807fc350f3d5710f0bc5f42e6414fd6e..aeab2308b15008185336f717172b090739f4f9d0 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1773,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)

---
base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
change-id: 20250326-usbnet_rename-dff11e407634

Best regards,
-- 
Dominique Martinet <dominique.martinet@atmark-techno.com>



