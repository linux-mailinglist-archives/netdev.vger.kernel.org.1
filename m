Return-Path: <netdev+bounces-185858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A902BA9BE76
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D34F3AF70F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974F22B8C6;
	Fri, 25 Apr 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t6hTzkXB"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322822B8B1;
	Fri, 25 Apr 2025 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561414; cv=none; b=ppUMOrLlBS7dCnqQ5I+Cv45NbIInYD0MW7qlj//sU+7n8X62WSWe2CMkYMuJHs1Ug4NCFqZ9SZX2wCdYBDQsWoFNDKGcHn/7Tup2EhKn1tF53WsuJ/p8LwqgeRyvMBjkNUs9vxXT0A9sgbww8aXdD0qoE7pTU8XRX6ZPw5Qw4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561414; c=relaxed/simple;
	bh=BUnsvoavvzAmvAEgmO562oO5W3/QRPXWnGXzP+mHAys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4FK5LgIsliOLwtxJM8YRLFNl/XfSdSt4GwJsbS1ig14sxlF8tn3xyc+8+1+oRECpo6ev8TMZNv4uPdnHhHK5h0gIbeocMzNwQXF6uf1jAPENFWXO64W1lGaUc0WIgTqBCWYnOdfp6RelPI3ybiPGzGRpmuDus2qhktMAJtzG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t6hTzkXB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53P69moZ62339069, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745561388; bh=BUnsvoavvzAmvAEgmO562oO5W3/QRPXWnGXzP+mHAys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=t6hTzkXBr/kpu6fY3jltLLVFoOKG0qMWczWYDHiwW1iB//yZLQvj6PzrhZh9euBST
	 ux3Cw/LOhufyKHmFW0rk7kEcECjB9zbP/o6BMkUUfy4UUz+AGdrLFEzD5rHHwMLnLZ
	 o6dctQNRn0pDwWiprZZJhg+XjFpumVep2Qb2hwY8k52h8gt7zBxBZHX85TSizuuK+W
	 9Je/fJFogbli6dNZMY2fBmdomdZWXn8TKim2TgKCUevMtKuUkGwSGtWQl39TNqDypA
	 RzAjErKi//yKLZbyvOj99F+JyjR/BWIgZm2jkdprS6AwXYz/6np+Ck4fu8BnibMz19
	 p6SycJKPT9+jA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53P69moZ62339069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:09:48 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Apr 2025 14:09:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 25 Apr 2025 14:09:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 25 Apr 2025 14:09:48 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Joe Damato <jdamato@fastly.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next] rtase: Use min() instead of min_t()
Thread-Topic: [PATCH net-next] rtase: Use min() instead of min_t()
Thread-Index: AQHbtOErwwFcM4UyBUiUN6IZ9ebfrbOyhFiAgACRcoCAANAWgA==
Date: Fri, 25 Apr 2025 06:09:47 +0000
Message-ID: <43edc83bf3a5499092d6780ff7a13dc8@realtek.com>
References: <20250424062145.9185-1-justinlai0215@realtek.com>
	<aApttwNRkiMP6xMJ@LQ3V64L9R2> <20250424183905.5de1f149@kernel.org>
In-Reply-To: <20250424183905.5de1f149@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Thu, 24 Apr 2025 09:58:31 -0700 Joe Damato wrote:
> > This looks fine to me and the patch is against net-next according to
> > the subject line (I think?).
>=20
> Agreed, Justin please repost this and the next patch without the Fixes ta=
gs. The
> fixes tag is used for backporting in the stable tree.
> This commit will not be backported.
> --
> pw-bot: cr

Hi Jakub, Joe,

Thank you for your reply. I will remove the Fixes tag from both patches
and repost them.

Thanks,
Justin

