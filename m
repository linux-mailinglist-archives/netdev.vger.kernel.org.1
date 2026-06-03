Return-Path: <netdev+bounces-294545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0889AtuoH2oYogAAu9opvQ
	(envelope-from <netdev+bounces-294545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 06:08:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC76341BC
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 06:08:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=tis0ARqh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294545-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C55306808A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 04:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9557C3D6463;
	Wed,  3 Jun 2026 04:08:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0D25A2A2;
	Wed,  3 Jun 2026 04:08:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459736; cv=none; b=EM4WDR+4l6VWiZHNKjvbS/YAxNMJNjm+pVPCjU5TRX/50rCtJQgro9X9aTHzBL8plyc4SPhoDQ95BZjREVYIv/5LYyzfGREPHVrqj4MdgyJOvp4+ClSM3ihWpFlpLjX6mZ4v3Nq1H9WAHmsk9ubfewS4Llve2JJ/LrLu+Ju6KXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459736; c=relaxed/simple;
	bh=W+EYccN7fJsFKgpFL8gFpT4nyRR6FpUn5fBWrr3/dpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbDmvdl4IynNyKs72YL7PS3C/w+BSzfPelQ47Qv3XQKBEWg2O72hCCntUsmx9YQjkl8Twzn5/1iitsRtJQiEcegSTf12o4CtskHosIgbr+IyPnQnv81Yfmg1OhI4gCW6o1baVKsvpx2Sj3wvQKauZjpgVOAH3GtnZtCynKP4y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tis0ARqh; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65348TVO03551134, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780459709; bh=W+EYccN7fJsFKgpFL8gFpT4nyRR6FpUn5fBWrr3/dpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tis0ARqhwiD1WxK/P692+Y6fBvELRuEbsZ9ZRJTYVd4oAtnmvUC+e+NoxklrMufI+
	 MSle2Tv4b6JzHlktcokk/CYiGg3latVxC3isAt0fi2syr398+ucnJL8bmJ7NmdbGXI
	 7VXmMGmSR0TCOk44PmTbSTwhfoAmRu5dBRC4klk3bzGYE8EoVxYjkVGJCZcR4xbXp2
	 2nyyjMaNwpaE46HNJSs4sPnSo6hpusWvGd11uAtdp2VHthUKLDPgnroZXGdpM2fAS9
	 XEswzrkrDGu/iY7u9CQcLDspn35+hLIeO/pLj0e+FLIalodICtgpjS6JZ0mIpg9/Fr
	 omoj0JfCLLG2Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 65348TVO03551134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 12:08:29 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 12:08:29 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Wed, 3 Jun 2026 12:08:29 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH] rtase: Avoid sleeping in get_stats64()
Thread-Topic: [PATCH] rtase: Avoid sleeping in get_stats64()
Thread-Index: AQHc8Y9Zk86yDw9UQUiLPdmdwKAAprYpKAUAgAHvlVD///T1AIABLPiw
Date: Wed, 3 Jun 2026 04:08:29 +0000
Message-ID: <cb9ee12cd91745fd86efbd4970e8cca1@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
	<f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
	<c3ca6a679d694890828ac9e7cc2d6305@realtek.com>
 <20260602110904.47b149b6@kernel.org>
In-Reply-To: <20260602110904.47b149b6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294545-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:mid,realtek.com:from_mime,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DFC76341BC

Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 2 Jun 2026 10:50:13 +0000 Justin Lai wrote:
> > I'll add the Fixes tag and resend this patch targeting the net tree.
>=20
> You can just reply with the Fixes tag here, our tooling collects those fr=
om the
> list, like it does review tags. No need to repost.

Hi Jakub,

Thanks for the suggestion.

This patch was originally based on net-next. I will repost it against
net with a Fixes tag and Cc: stable@vger.kernel.org.

Thanks,
Justin

