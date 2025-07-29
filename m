Return-Path: <netdev+bounces-210764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25309B14B7D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419F63A7A1C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262842882CF;
	Tue, 29 Jul 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="F5c+iDCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2012877EF
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782048; cv=none; b=RTANrhfi5PnyO6S1gApc5Z9HHHn1AdeCaNOymyuNmwOOsMPvbVlgkbBpn13720Hum7llladYPk3rGKriwJL7gcYeK3qGT8iXMkrEprJNz+IuLRWlrkV7Ynxc4V8huG6hfChnBQSol9iJeHCu+P7Ygt1L/ltlou5+1MqJ51rrvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782048; c=relaxed/simple;
	bh=au5WEonjqTgr0PvNyzvOD7dGTB47ejJTcJwgOxXaMCA=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=kovWfTHrdNOpyNmT8XsfRTXv8kK0PhEGgjuZkDNzcyUFleFgZ2WHtOuiu/CayhzHpkn85cgAHEd8M1oFIAF+r+EOoY5iYZT56ae5HuZ30SIZY/70R/Mf+dBYmgFppWTxecQeCdRM/oTauFqK98peMjSASM4pABuuRcm/Zn9E03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=F5c+iDCQ; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753782030; x=1754041230;
	bh=iaJNS9filcErt3DEjzrU11upXuoKLw+pnJcBEW0iONg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=F5c+iDCQOJ7cqJmANB3g7Y+DMhSrzI2Ku6Te48zigw1wyhE+EGkn6wfe/d4WRAaXZ
	 SAFGQPXCV4IqzgmsQEiWHTE9YrYXofCy2G1ghSKvCRpCgKNFF6Q9KAisU0Z39Y+uzo
	 nvo5KUvPxD0iAtDhTo7cxMT9fWMe6F9quy1RJ99tcXXH5dPuSko+EcNvEDPUHrA9+Q
	 DeV6m//YC8KtvenpPJtoa+dNKWkgQdLkWRVl94NuoWSYPGzc0jeLP0MFr/EJ2/R/OZ
	 r0immciwhbseBGSceO5Myt/dVlBv1yITeFpT0Tf1XAys5PBPojOq2hU7NcgcTMoYte
	 Etfx5LMPsk/MA==
Date: Tue, 29 Jul 2025 09:40:24 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: gwoodstccd <gwoodstccd@protonmail.com>
Subject: xilinx xgmiitorgmii couldn't find phydev
Message-ID: <i9eEFizCsfRsZPSDz9HqVDN_YZuGmNadYIE44uhLWQJzUDE2qmO5P4Rco5MYwcipDQT-FsEchEvKUZsWIZhk8j9zQFIBri_yxNHFBgoKX2Y=@protonmail.com>
Feedback-ID: 11860072:user:proton
X-Pm-Message-ID: a60483628c994340c15e04e2822882d1a53f1a34
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm newbie for netdev.

Xilinx's ZynqMP GEM2 uses EMIO and gmii2rgmiii converter for PHY connection=
s. Hardware guys confirmed it can work under bare metal mode.
But GEM2 is reported 'xgmiitorgmii Couldn't find phydev' error during kerne=
l boot, and ping command failed.

Could some nice guy help me to fix this issue? Thanks in advance.

the kerner version is 6.12, the kernel is from=20
https://github.com/Xilinx/linux-xlnx/releases/tag/xilinx-v2025.1

[    7.285666] xgmiitorgmii ff0d0000.ethernet-ffffffff:08: Couldn't find ph=
ydev
[    7.292490] macb ff0d0000.ethernet eth2: Cadence GEM rev 0x50070106 at 0=
xff0d0000 irq 47 (00:0a:35:00:01:22)
[   33.315143] macb ff0d0000.ethernet eth2: unable to generate target frequ=
ency: 25000000 Hz

device tree is=20

&gem2 {
    phy-handle =3D <&extphy0>;
    xlnx,has-mdio =3D <0x1>;
    local-mac-address =3D [00 0a 35 00 01 22];
    status=3D"okay";
    phy-mode =3D "gmii";
    fixed-link {
        speed =3D <100>;
        full-duplex;
    };
    psu_ethernet_0_mdio: mdio {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        extphy0: phy@3 {
            device_type =3D "ethernet-phy";
            reg =3D <3>;
            phy-mode =3D "rgmii";
            phy-reset-active-high;
    =09};
    =09gmii_to_rgmii_0: gmii_to_rgmii_0@8 {
    =09=09phy-handle =3D <&extphy0>;
    =09=09reg =3D <8>;
    =09=09compatible =3D "xlnx,gmii-to-rgmii-1.0";
    =09};
    };
};

BR,
Gavin


