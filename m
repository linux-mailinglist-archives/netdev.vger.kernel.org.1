Return-Path: <netdev+bounces-256594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBsIO+rwgmmWfQMAu9opvQ
	(envelope-from <netdev+bounces-256594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:10:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D679E28AB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB72301E3FB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB435A943;
	Wed,  4 Feb 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="w25Q6ktj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF6261B96;
	Wed,  4 Feb 2026 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189031; cv=none; b=uCJpxD2t7CYRKv0mMhJBoBbBNa7fdsHokfTc70QDBBkJwH6HYnbWwCCLizpZHYHhccSoLAtAfZFKay+95FMopO39VwR1IourJ7BbTI9s1uwlL2pn7XQZuHgWc7PHKHNmZd++SmKeKel69vZ/kaNskGL6WBa2mpEFIyAACAiHw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189031; c=relaxed/simple;
	bh=i4eVoECIVUB5i06EYRcLvDDUR0F0teIfziDI2VSoKaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLqsz/u8xppCIZpe5kPSZlNV8RRqFrC3m3A/bfSsv4PmBcAPF/FllWmlNhn4wgAixfiFGJCryzd0fF1UJBbizKtZyLlJ50DKeHJK4pegMVgs0z+j9JpvMaXIpo0khu5XtVdKdkQabSa6Th2FmkTU8DrjQqVrR0Po4PmH3MFNH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=w25Q6ktj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61479tJfA2605405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1770188996;
	bh=i4eVoECIVUB5i06EYRcLvDDUR0F0teIfziDI2VSoKaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=w25Q6ktjaUOQoBdfP7rMOuiex1eYfoEANOvyOcVnXz2xU5Jc6t4IyHHHmueeH66cV
	 svCYKXGH646YehNj4i5EJb9BI+R31emK9BfX7zyV1pE6SK3/ENr0Dl2XibZv187ZqQ
	 ysv+UxW8C/3nIEpfH/9SDYP66ZoCgBptO9v8hwdzYlmNM4cX+Gpvtx/u66La0kPMqc
	 GewIRJ9AcQfG0SJGJb5s/I4luhBcjVHHmIhlCqt4PQtlQGnZcsPp8g3CzWgZcKyPwY
	 D8SpDzg590fOczBsGCvN3OWUTQSyHopUmOPhgg4YabRty7IB8kSB37+hpjyc23nk+v
	 Qm7q7aAfS3w9w==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61479tJfA2605405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Feb 2026 15:09:56 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 4 Feb 2026 15:09:56 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 4 Feb 2026 15:09:56 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125cp
Date: Wed, 4 Feb 2026 15:09:55 +0800
Message-ID: <20260204070955.1473-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <81407a61-1e6a-436c-83f3-fc403a706af6@gmail.com>
References: <81407a61-1e6a-436c-83f3-fc403a706af6@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: 1D679E28AB
X-Rspamd-Action: no action

>On 2/3/2026 8:58 AM, javen wrote:=0D
>>>> On 2/2/2026 11:58 AM, javen wrote:=0D
>>=0D
>>>> From: Javen Xu <javen_xu@realsil.com.cn>=0D
>>=0D
>>>>=0D
>>=0D
>>>> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply=
=0D
>>=0D
>>>> different and firmware for RTL8125cp.=0D
>>=0D
>>>>=0D
>>=0D
>>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>=0D
>>=0D
>>>>=0D
>>=0D
>>>> ---=0D
>>=0D
>>>> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43,=0D
>>=0D
>>>> 0x10, 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0=
x0000, 0x1001) on patch v1.=0D
>>=0D
>>>>=0D
>>=0D
>>>> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0=0D
>>=0D
>>>> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2=0D
>>=0D
>>>> means 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.=0D
>>=0D
>>>=0D
>>=0D
>>> ALDPS is disabled two lines later in rtl8125cp_hw_phy_config().=0D
>>=0D
>>> So why bother with ALDPS settings if ALDPS is disabled anyway?=0D
>>=0D
>>=0D
>>=0D
>> Bit 2 means 'ENABLE ALDPS', we prefer to treat it as a master switch tha=
t controls=0D
>>=0D
>> some sub-features like bit 1(ALDPS PLL OFF) and bit 12(ALDPS XTAL OFF), =
instead of=0D
>>=0D
>> controlling these sub-features individually. And bit 0(link speed 10m PL=
L OFF)=0D
>>=0D
>> has noting to do with aldps.=0D
>>=0D
>I see, you changed the value of a43/10 to 0x0003 in v3. Then just this que=
stion:=0D
>Few lines later ALDPS gets disabled, so is it beneficial to set bit 1 here=
?=0D
>Thanks for mentioning that bit 0 isn't related to ALDPS.=0D
>=0D
Bit 2 acts like a lock that controls bit 1. If bit 2 =3D 0, bit 1 has no ef=
fect even if set,=0D
so pre-setting bit 1 causes no side effects. The reason why we set bit 1 he=
re is that If we =0D
need to enable bit1(aldps pll off) later, just set bit 2 to enable aldps wi=
thout any additional=0D
bits write(means we do not need to set bit 1 again). =0D
Alternatively, you can view this as initialization related to aldps. if ald=
ps(bit 2) is enabled later,=0D
these related functions will be enabled at the same time(like bit 1).=0D
=0D
Thanks,=0D
Javen Xu=

