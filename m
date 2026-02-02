Return-Path: <netdev+bounces-255831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EWhMs+BgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A27CB397
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AA830265A7
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3CF35771C;
	Mon,  2 Feb 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Wp3a58tK"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623025F98A;
	Mon,  2 Feb 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029135; cv=none; b=tmxOis4JLNHxrcysqAxhKw4DbBE1YdNJ6XZjBDaVIKHXrf24Ee93AvkytpikIjk1pSQopiDna7ZvN+Xc/b5h36PObChVlgPwpgd+WKxKAHXgNq3YEBI+Uem0fKZZNqF6hVfisnNxrzlWzOuqhfw2HOB8LKz3ByOrWK70CH+pzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029135; c=relaxed/simple;
	bh=NGwOtrEaM2qbxy0QTRUGMMmoU7IkNxMn9ipFNaYir2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkkzdrP8Gq5hgvsehgcAX9o5WgpsEbZmH5TgF25pjpnAI849Ovsrm9PZJ43edfARptLN1uWGOVhhPCEOk+KqNxpmXw+c0QhnhGrMyF+puHoTtmuUaovZJscGVbZlQUsqlg/KmvgjFqnwwSI5OXf4TGAt1D7Ni/a8gLr+bHxbVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Wp3a58tK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 612Aj0Fc92733577, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1770029100;
	bh=NGwOtrEaM2qbxy0QTRUGMMmoU7IkNxMn9ipFNaYir2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Wp3a58tK2NjAlzjscZwwlFkhna/2rqOq7FnF2VBsvmA5Ruzinx2vESKYJOpr7j/as
	 /dTCfxmNHCgjyVmJJ9zGHqSxI3w79jS3QjpPDF23zKiiMkYf+xtMVX0pTaaK0HXYdA
	 FvBADKn5OA5G+hiLLSGOM//PmZwxxX5HTlT5u3lRdDzHrgHeSCBTjw8X6qfscMvf1q
	 TvDtBq2CumMVRF1LTY4WvannGcTnMoVS9L8IS7m8OCubH0wawylatIuQLmszu3Lw5G
	 8ZpMcdzUN7KnL7SDddYHLql8H0sJKOvOdWBe281bTBQrhadfGddmUEZ4t3blVXHYXx
	 A3yYRQtsex2eg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 612Aj0Fc92733577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 18:45:00 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 2 Feb 2026 18:45:00 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 2 Feb 2026 18:45:00 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: RE: [PATCH net-next v2] r8169: add support for RTL8125cp
Date: Mon, 2 Feb 2026 18:44:59 +0800
Message-ID: <20260202104459.433-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <415271ac-f37b-4efa-97ad-f6da68353e54@gmail.com>
References: <415271ac-f37b-4efa-97ad-f6da68353e54@gmail.com>
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
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-255831-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 26A27CB397
X-Rspamd-Action: no action

>On 2/2/2026 3:18 AM, javen wrote:=0D
>> From: Javen Xu <javen_xu@realsil.com.cn>=0D
>> =0D
>> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply=0D
>> different and firmware for RTL8125cp.=0D
>> =0D
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>=0D
>> =0D
>> ---=0D
>> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,=
=0D
>> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0=
x1001) on patch v1.=0D
>> =0D
>0xa43/0x10 is PHYCR1 (at least on RTL8221). There bit 12 is "ALDPS XTAL-OF=
F", and valid only=0D
>if bit 2 is set too. And bits 0 and 1 are marked as reserved, to be 0 alwa=
ys.=0D
>What PHY is RTL8125cp using, and has register 0xa43/0x10 a different meani=
ng there?=0D
=0D
Register 0xa43/0x10 BIT(0) means 'link speed 10m PLL OFF', BIT(1) means 'AL=
DPS PLL OFF',=0D
BIT(2) means 'ENABLE ALDPS', BIT(12) meas 'ALDPS XTAL OFF'. We recommend se=
t BIT(0) and BIT(1),=0D
clear BIT(12). So i will resubmit a new patch. =0D
=0D
Thanks,=0D
Javen Xu=

