Return-Path: <netdev+bounces-141520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB69BB384
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B71284451
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C501B394D;
	Mon,  4 Nov 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IF4ar2z8"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95C1B395D;
	Mon,  4 Nov 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720003; cv=none; b=IfY5DStjtN4Kvei2BYUsw8yqtOPETKv3xgMT3iEw9z/U3zaQMw2KA/jWhXLTbRUkQQk0jA1M5dZuGZw7hb1WpT1B+d37HR5fRIWKHmAYEjqD+RfGUSKeGv6ZrFEFwQoZQKmB+/9n/OVu67+OXw2qgfngVYP26MMrLrjbsvJNoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720003; c=relaxed/simple;
	bh=UJODazVPcj9ulQdRw7qCL6k6lq/obUPC1HuFiRatleA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZ3XLDBxER+o4VjNOrPhDedAKtEyizfefkYWK7PO77rQYtaqn+J8sdw6KzCtMbTyeg6jhFVII2htio6SG322cATfrtvQuAXR7ZSE+9+O0s7cTNk0DM2CGk9Es+2/jv2e3kVUAgMODxsJUffQmbehjN735NFPtckVmCrXDU8WrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IF4ar2z8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UJODa
	zVPcj9ulQdRw7qCL6k6lq/obUPC1HuFiRatleA=; b=IF4ar2z8GoksaeJybUaw2
	5/HjOlOZBP2EwqMkwWdYlqUS1oPdyyRSChWP1bCA5razy+BNO2sfBVg80vox7rmE
	jSaXMFUsrVoFWHEdnL/qhbvGwX9YHtE7xNldaiFGr4lMMZg/Q+iMQtxpf+jxsBVx
	ebMdbgNf5+cuzYjzsN46+k=
Received: from H00576042-PD8FB.china.huawei.com (unknown [223.104.150.4])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB3eknlsChnBcbjFA--.13181S2;
	Mon, 04 Nov 2024 19:32:55 +0800 (CST)
From: huyizhen2024@163.com
To: j.vosburgh@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tbogendoerfer@suse.de,
	chengyechun1@huawei.com,
	kuba@kernel.org,
	andy@greyhouse.net
Subject: [Discuss]Why enable individual port in bonding 8023ad?
Date: Mon,  4 Nov 2024 19:32:53 +0800
Message-Id: <20241104113253.2537-1-huyizhen2024@163.com>
X-Mailer: git-send-email 2.29.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wB3eknlsChnBcbjFA--.13181S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1UKr4DKw4kGr4DXr4DXFb_yoWrCF4xpF
	4kJ3ZrGr9F9r1Fq3y7Cw4DWws7ursaqayDJryUG3yUZayDJw1FkrsY9rZ09a9rX3ykC347
	Xrs3KF12qF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7eOJUUUUU=
X-CM-SenderInfo: pkx1x6hkhqjiisu6il2tof0z/1tbiox2Np2coq3tIKAAAsr

Why is individual aggregator's port enabled in function ad_agg_selection_lo=
gic ? I have found no basis for this in the IEEE 802.3ad standard.=0D
=0D
In fact, I had the same problem as chengyechun <chengyechun1@huawei.com> an=
d Thomas Bogendoerfer <tbogendoerfer@suse.de>.=0D
https://lore.kernel.org/netdev/c464627d07434469b363134ad10e3b4c@huawei.com/=
=0D
https://lore.kernel.org/netdev/20240404114908.134034-1-tbogendoerfer@suse.d=
e/T/=0D
=0D
I use port 1 and port 2 form a bond interface and use nftables to discard L=
ACP packets received by port 1. =0D
=0D
The bond configuration is as follows:=0D
BONDING_OPTS=3D'mode=3D4 miimon=3D100 lacp_rate=3Dfast xmit_hash_policy=3Dl=
ayer3+4'=0D
TYPE=3DBond=0D
BONDING_MASTER=3Dyes=0D
BOOTPROTO=3Dstatic=0D
NM_CONTROLLED=3Dno=0D
IPV4_FAILURE_FATAL=3Dno=0D
IPV6INIT=3Dyes=0D
IPV6_AUTOCONF=3Dyes=0D
IPV6_DEFROUTE=3Dyes=0D
IPV6_FAILURE_FATAL=3Dno=0D
IPV6_ADDR_GEN_MODE=3Dstable-privacy=0D
NAME=3Dbond0=0D
DEVICE=3Dbond0=0D
ONBOOT=3Dyes=0D
IPADDR=3D1.1.1.38=0D
NETMASK=3D255.255.0.0=0D
IPV6ADDR=3D1:1:1::39/64=0D
=0D
The slave configuration is as follows: and I have four similar slaves enp13=
s0=0D
NAME=3Denp12s0=0D
DEVICE=3Denp12s0=0D
BOOTPROTO=3Dnone=0D
ONBOOT=3Dyes=0D
USERCTL=3Dno=0D
NM_CONTROLLED=3Dno=0D
MASTER=3Dbond0=0D
SLAVE=3Dyes=0D
IPV6INIT=3Dyes=0D
IPV6_AUTOCONF=3Dyes=0D
IPV6_DEFROUTE=3Dyes=0D
IPV6_FAILURE_FATAL=3Dno=0D
=0D
The nftables configuration is as follows:=0D
# cat /etc/nftables.conf=0D
table netdev filter {=0D
chain ingress {=0D
type filter hook ingress device enp13s0 priority 0; policy accept;=0D
meta protocol 0x8809 drop=0D
}=0D
}=0D
Then nft -f /etc/nftables.conf to apply this conf.=0D
=0D
During aggregation, the time sequence is as follows:=0D
1. When bond0 receives the NETDEV_PRE_UP event, port 1 chooses as the activ=
e LAG. Since port 1 has not received the LACPDU, port 1 is considered as an=
 individual port and is enabled by __enable_port in function ad_agg_selecti=
on_logic. =0D
[37.643701] bond0: bond_netdev_event received NETDEV_PRE_UP=0D
[37.643740] bond0: (slave enp13s0): LAG 1 chosen as the active LAG=0D
2. The MUX state machine of port 2 enters the AD_MUX_WAITING state.=0D
[37.643763] bond0: (slave enp14s0): Mux Machine: Port=3D2, Last State=3D0, =
Curr State=3D1=0D
[37.748705] bond0: (slave enp14s0): Mux Machine: Port=3D2, Last State=3D1, =
Curr State=3D2=0D
3. Port 2 receives the LACPDU, since port 2 has partner but port 1 has no p=
artner, port 2 is elected as the best aggregator by ad_agg_selection_logic,=
 then __disable_ports port 1. Port 2 is not enabled just like port 1 becaus=
e port 2 has partner. At the same time, the MUX state machine of port 2 is =
still in AD_MUX_WAITING (it takes about 2s AD_WAIT_WHILE_TIMER). At this ti=
me, the system does not have any enabled port (or usable slave).=0D
[37.960715] bond0: (slave enp14s0): LAG 2 chosen as the active LAG=0D
4. Two seconds later, the MUX state machine of port 2 enters the AD_MUX_COL=
LECTING_DISTRIBUTING state and enabled by ad_mux_machine. The system finall=
y has an enabled port.=0D
[39.976696] bond0: (slave enp14s0): Mux Machine: Port=3D2, Last State=3D2, =
Curr State=3D3=0D
[40.084710] bond0: (slave enp14s0): Mux Machine: Port=3D2, Last State=3D3, =
Curr State=3D4=0D
=0D
Within the range from [37.960715] to [40.084710], the system does not have =
any available port. The bond_xmit_3ad_xor_slave_get cannot obtain an availa=
ble slave port. The bond_3ad_xor_xmit return drop, and the bond port cannot=
 send packets.=0D
=0D
But if port 2 does not receive LACPDU, then almost all the time the bond ca=
n send packets on port 1. (except that the MUX state machine of port 1 chan=
ges from AD_MUX_ATTACHED to AD_MUX_COLLECTING_DISTRIBUTING, which is about =
100 ms)=0D
In the scenario where port 1 cannot receive LACPDUs and port 2 cannot recei=
ve LACPDUs, the behavior of the bond interface should be the same. That is,=
 whatever port 1 or port 2 cannot receive LACPDU, packets cannot be transmi=
tted within an equal time, 2s or 100ms. But Port 1 cannot receive LACPDUs l=
eads to 2s packet loss and port 2 cannot receive LACPDUs leads to 100 ms pa=
cket loss.=0D
Therefore, it is critical to understand why the individuals aggregator's po=
rt is enabled in the function ad_agg_selection_logic. The status of the MUX=
 state machine of port 1 is not verified. Actually, when port 1 is enabled,=
 the MUX state machine of port 1 is not processed. According to the IEEE 80=
2.3ad standard, the status of port 1 should be disabled.=0D


