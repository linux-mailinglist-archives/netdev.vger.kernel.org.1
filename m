Return-Path: <netdev+bounces-175536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE13A66553
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119C217BE4A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96DA197A8E;
	Tue, 18 Mar 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ihrb2a48"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F5175D47
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262069; cv=none; b=a9gKlQG/k5PgqM8QQffMyjIU8giMtXgUs8+VIzIPvb6hnAJHh2K1ISunHgSr8TfX7fWScoN8lnakvmv6ela0FUHgMjnCW/7u3KiYQpfOh5/1rVUQBS6PxZP186/nGukCjekQAGF5/48NJl4pJQpCcvfF6NnDveQSjMhJrwSNrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262069; c=relaxed/simple;
	bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqXLEpScis7v/VRFvmcGi5Lk5pLRdJFNVIVnuB+G5P0OnCAF3O3juJEsUogZhKP7Jogc2JxuCD5Q5l7IaemZN37VYBJ4W7x6ud0VqhiTYY4OBGpyBzoYudZVQHBvvabVMuMVzXc3+OPK3kIOsTu4qz7+8UqDgFvl1zhrfKehcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ihrb2a48; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390fdaf2897so4721495f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262065; x=1742866865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=Ihrb2a48NGteG0Of2cXK80V0THfsDrqwQ8S7TgnA6Qd7FqCq/L0RwX4EJmT2n3Me9Y
         xPY31qkruLVLojFQL1y1vS5IVqo6OnboWfmiozcREwK7CeuiRceUQa1GIxg1yX26za9p
         YqNvDBHQ/Bl/KDfsxLkOLDtbHz6Y7xkyU5llIHOJ/rPu75LsIKc+v/MZyLw9eBG1X/JL
         7z4+sZGWQJlUlld8p+mUmHSEoQZrB1+Hq/P2toW6WkXv+hkXniPyIhNi9sZjXSwjKB6O
         v2MwiptLQvb3Dh3Tk/IYg8xKg3+5mTwdLWx0yjoyxxkwFUcHizADeMgaISjsBDP3Hq1b
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262065; x=1742866865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXngeC+tXo23/X0d6ycLIiWXJIi25bwb8m4uszQOeoc=;
        b=whIkdOZ1EWUXzqQQm7kJGZCLTNEobqjChB/bFpBxS5LLGXziq+uAuEdqs6zJ4kZ02U
         oVJQ3Ggdn+OEC0kV3vJoe7q8bTWK/IvovgRVpwuR4rABtw7sfis0pwgVVrfQNhvxZhjv
         rGu72SapBhI9uZdYFTrwGNWyNMhZ3StxQKWhrwug9QoeMK/3XpQ6idoIi1uHBrNCBTa2
         HU11DjCEAFjRXUUNbrIHfjWnJoLyLeshs2iU7K+V2oiEzkqyKtqhWUuwry8r7bfcDCYK
         xVr0Z5ii/V1MFlb/QeZy4cavrilL/Vxj6hXFeLxsfll7/BqJxGaI5+08bVLi6hBtfmMm
         PF6Q==
X-Gm-Message-State: AOJu0YxvhpyDyvgu7yteioPDRQxXkeyTJq9KCTbFbw1rQUjBYoCnWScu
	fKNfO/OoAahYHXBL1u/t4QZqeL6bfkPPIOhlrc6YPIH5Jg69gpF7aTfC1HZRyoEPqI0lRqFnyXB
	EdSdZWLZh6yyseszVOsar6AbcS6JUuL01bLCU+H4uK2BEwsQ=
X-Gm-Gg: ASbGncupVCAC7INYsiXU3XAUDBiGzlYZrn2OsnW4aTknvacdCoEcw4VIC/mSuxuLjaw
	N+zV6ElDRTnFJQcNVGjgtpKnYqxJp883EhvPk5nsyUF6DIv4EeHXdfAmMuCNZjk9LIt74zeVOA1
	BA6iPmIvOkMJRGxOVxDcyeI0aFKA3g7KbVMLR4mH+WM+xJOJbhJRtXw7HDW7p3GnC6Np1NWrzhj
	L/xafgi67mM9k0oRBEn5/T7lhFQAv0gO2uLgI5hANnN+gXI4qMlzHUvekKYyEBoP7oMumq4eDAv
	jo6iEMeCY2+oTCXcIxEyffyPXY8l9E5oSaxmbi3h1w==
X-Google-Smtp-Source: AGHT+IGPV96tVaakTrMyHpMtxyYA5qx1H34HcVZaOckFeaODwHUP6905nL8TnMaH8rYevbGhVEGPTA==
X-Received: by 2002:a5d:584b:0:b0:38f:577f:2f6d with SMTP id ffacd0b85a97d-3971ddd4b07mr16061612f8f.2.1742262065663;
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:39 +0100
Subject: [PATCH net-next v24 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-4-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=F7vNJswYuDrJOUluc+iKV+B1IKtUBw6UmYPNXP+K7Ko=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGfYzymirIzQuk8H74N4mh1CgwsPz8MeddaklCb468hrTOUt4
 4kBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn2M8pAAoJEAtw5TqgONWHc2QH/j+y
 zNppsiM7jdqhypjIPvZ7xdfmivRXMpc3lLTcFv3pwZvxrmbxvGgtGF+C3JdCaKINm1RGQRblsEq
 qrMmJanRAyEtc6twQMKtnKdZljzXyuNkeVxKPXiMeVSa6NPosHEROHIk5WxgvnLctN/XDeRIrjU
 zikbJIQfUX36ILsq6TuMOkVD0cLzvghbjQlPd9n4MBN9WuhdjdjSePnQSG/h/PDic6EGfqkBeCN
 H4uL4ykVMoVlY+BTiW7WSdxMlHTbwfEf6h+lo6LJyYKmyGo3SzfdaBraU8vNwghqQQt/rVQ14r8
 u08z/5vTQ7GGTdEiH79WJMJ50mVaZWi+bJqUBfM=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index b19f1406d87d5a1ed45b00133d642b1ad9f4f6f7..15802dfd26fcbcad42c387d42f665b8b47604e8a 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -21,7 +21,22 @@
 #include "io.h"
 #include "proto.h"
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 

-- 
2.48.1


