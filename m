Return-Path: <netdev+bounces-256178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGuAIMOqgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 08:58:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70282D5EAE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 08:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 378403018BF6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049537E310;
	Tue,  3 Feb 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="QriQiOPV"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D32DE1E0;
	Tue,  3 Feb 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105534; cv=none; b=Wh2lCh3GLaEpVhFhBl7T4sqac6VHKd2fag8wXdN93faUo9PixC++mwxIdHYmu+5AC/DQFXdmDRhkeMpdylFLsYZGEOJO1sU700mAz3kNQmqqifuL60UDnax7nWli5F3MvFnZysd79LGxquSVqMkBkW1+0MMSpU8/E4QZGjk5ONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105534; c=relaxed/simple;
	bh=+ja1XQ34PxaYoSbR+FZTEod3U6fPO8QQgIkTQxil2fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFW+9ZGBoM3U2OfK3ERvGqA0Glnk47nAOIdEPc+bWI3oo04IUGuLEU30WM1n8DqTzxDBCOXUhQTOO+EK6xNlfetkvEeiouzv0nyprEf5656R1EhIJRnryAFBARX6GFybeQJUMtKujmNxCf+lpP+G6XR3iqOEM5QIuKj+nq+lIsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=QriQiOPV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6137wAXI1496104, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1770105490;
	bh=+ja1XQ34PxaYoSbR+FZTEod3U6fPO8QQgIkTQxil2fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QriQiOPVdY7z2FHwflqCY12KCQNWxfbsChFdsUlu67Lno+L+BGaqRZUDE39FcRRHg
	 vgy5fPA+RpALI8eOzGphpjzLWrDdIjeaaHpApRdDhBJSlwD99kQRS6Uf3NzAuMqosI
	 mTvN3cVlt5YPwszOLBuh8Shgtd/XN79neVfvFzDCzzhk4IgYCsW+jfEQJzbfIH0tUI
	 5LRytGFX3WeIH2SzVjHmwdbbD7EbOn0nXhRUptVzAhAwrSZbUbviaSZosfmLBuWPXS
	 S+qur3T3qhKZAjcUOShpcDm9xAZPmRsZFKkMJISMCQzesmvgMt4DxZKisn46MMaNC4
	 LKMuLRuNL4jiw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6137wAXI1496104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Feb 2026 15:58:10 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 3 Feb 2026 15:58:09 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 3 Feb 2026 15:58:09 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125cp
Date: Tue, 3 Feb 2026 15:58:08 +0800
Message-ID: <20260203075808.175-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <f54e4d2a-666c-444a-a79e-0df2ddec97d9@gmail.com>
References: <f54e4d2a-666c-444a-a79e-0df2ddec97d9@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256178-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: 70282D5EAE
X-Rspamd-Action: no action

>On 2/2/2026 11:58 AM, javen wrote:=0D
>> From: Javen Xu <javen_xu@realsil.com.cn>=0D
>>=0D
>> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply =
=0D
>> different and firmware for RTL8125cp.=0D
>>=0D
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>=0D
>>=0D
>> ---=0D
>> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, =0D
>> 0x10, 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0=
000, 0x1001) on patch v1.=0D
>>=0D
>> v3: Set phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003), bit 0 =0D
>> means 'link speed 10m PLL OFF', bit 1 means 'ALDPS PLL OFF', bit 2 =0D
>> means 'ENABLE ALDPS', bit 12 means 'ALDPS XTAL OFF'.=0D
>=0D
>ALDPS is disabled two lines later in rtl8125cp_hw_phy_config().=0D
>So why bother with ALDPS settings if ALDPS is disabled anyway?=0D
=0D
Bit 2 means 'ENABLE ALDPS', we prefer to treat it as a master switch that c=
ontrols=0D
some sub-features like bit 1(ALDPS PLL OFF) and bit 12(ALDPS XTAL OFF), ins=
tead of=0D
controlling these sub-features individually. And bit 0(link speed 10m PLL O=
FF)=0D
has noting to do with aldps.=0D
=0D
Thanks,=0D
Javen Xu=

