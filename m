Return-Path: <netdev+bounces-254118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMB5GH+yeWkOygEAu9opvQ
	(envelope-from <netdev+bounces-254118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:53:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931769D890
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D723012CC8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBB2FFDEB;
	Wed, 28 Jan 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="bwvxl5Cq"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BD25782D;
	Wed, 28 Jan 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583225; cv=none; b=le9PXOVpWETc7LEg75l5U3q7fVyUNuTpFebLRb6y1fYuHxe0v/DZjta7PeSBi4/hrwiu0I1xAhC6bLWrORMIV3UGrFINaX3IBWjREIyuGe81S6PgJTF9zGsNN0SwG2Aa8Lj/zU+9rjWURiuDp2nfRRW7nyZ8SuNpWqmaHsy9Ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583225; c=relaxed/simple;
	bh=RhIB2UOkdFShxDb2YdhlO0pU0A+bNIEoVa4dL3JONv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8NYeSuDH4WVDVnZoVluFlWduWatHkZ1zOI+FAwQI+zvtFJPKMSjUDMVHUjYjGagSXxe423HGF1f66NNb8989Xmn3u/p/vjaNnnFN7qt5vGQEDHUV7pbT1HRHsE9tTrTsBo5xvYzTT6f/h2FC3nhNLLR7pImZobhcJ9IBIh5wE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=bwvxl5Cq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60S6r9odD419075, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769583189;
	bh=cotDTHDvsg7hUeOBoFSRMX89+nSGhMyqdzHb6uUqnZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bwvxl5CqvtRYHkZagTsLjUSPAslAwOG5VwiDC9PdqGjB5vkFDyufpZJol3F6Fezau
	 SNl0/4DSk1liIVQS+9LjMs6ZsIJ0RgZxEnELbO6suO3lIjzmbPxuiX9Aqeh6LNyscy
	 Q2LK2zR9ftI+V2ay+Clae6a5gfBpOy7KSbn1/UCB+tV1w1QE7KAwH5au43Am/U0lbn
	 9Eg76uhVXshZVMjRPmyLeZA/bRiRi0buCdZXEP16qaJM6yx37lLnwFr4uIrCCQ5GRc
	 aZ87LbIjx0UoieFIcbQkuj7ZBbSXYAZl1CXkvZ38Mrgy9dDYNfaH5YQ9Lu2lMWbfKV
	 CjOA7wILGKVPw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60S6r9odD419075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Jan 2026 14:53:09 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 28 Jan 2026 14:53:09 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 28 Jan 2026 14:53:09 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: RE: [PATCH net-next v1 0/3] r816e: Add r816e driver in Realtek
Date: Wed, 28 Jan 2026 14:53:09 +0800
Message-ID: <20260128065309.556-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <640c373b-09d9-4b54-9113-782df41aa152@gmail.com>
References: <640c373b-09d9-4b54-9113-782df41aa152@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 931769D890
X-Rspamd-Action: no action

>On 1/27/2026 12:34 PM, javen wrote:=0D
>> From: Javen Xu <javen_xu@realsil.com.cn>=0D
>>=0D
>> This series patch add a fake driver r816e to ensure the kernel could =0D
>> set the correct power state for #fun through r816e driver when suspendin=
g.=0D
>>=0D
>=0D
> I think a better approach would be to contribute to adding phylink/sfp su=
pport=0D
> to r8169, so that the SFP NIC versions (incl. RTL8116AF) can be properly=
=0D
> supported. This would have to include making the SFP I2C bus accessible b=
y=0D
> the kernel (instead of firmware only).=0D
>=0D
=0D
RTL8116af is a multi-function device. fun0 is a BMC virtual driver and fun1=
 is=0D
the nic driver. The BMC virtual driver(fun0) is used for power management,=
=0D
while fun1 provides the actual network functionality.=0D
=0D
Thanks,=0D
Javen Xu=0D
>> Javen Xu (3):=0D
>>   r816e: add a fake driver r816e for RTL8116af=0D
>>   r816e: Add a Makefile in the r816e folder=0D
>>   realtek: Update Makefile and Kconfig=0D
>>=0D
>>  drivers/net/ethernet/realtek/Kconfig        |  7 ++=0D
>>  drivers/net/ethernet/realtek/Makefile       |  1 +=0D
>>  drivers/net/ethernet/realtek/r816e/Makefile |  8 +++  =0D
>> drivers/net/ethernet/realtek/r816e/r816e.c  | 75 +++++++++++++++++++++=0D
>>  4 files changed, 91 insertions(+)=0D
>>  create mode 100644 drivers/net/ethernet/realtek/r816e/Makefile=0D
>>  create mode 100644 drivers/net/ethernet/realtek/r816e/r816e.c=0D
>>=0D

