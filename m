Return-Path: <netdev+bounces-93590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33E8BC5F4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6E31F21868
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4337142;
	Mon,  6 May 2024 02:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917D42ABD;
	Mon,  6 May 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964174; cv=none; b=QVAOrwNzJPv5owou1mxkS9+1xyR6wGeGylNMNG7MY81lmKrPlYPg9ph1rAjZy6SKKXOIvPrpuCOl3kLlZGs84v2bxiD/lQlVQf6hkwbwLMJcyhDe+dt0qjivzZvfJlc+52pwhv249iOfjUkuvAu+jlK1Fu0v8l9sQZ7QfieUTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964174; c=relaxed/simple;
	bh=IUIbpi7ix4TzYARZZKNK5542gg7NQvvcwHIWGyWVGcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLjunreDAix33YgwGbac58Tg7/xS0435PSkPAhUMSZa3Ket0nLnkvxJ3NHcfvZsxjKWRJl9UHDJCsO/69yEzEestXd49iF5M1TgK3FfX0fzGeQcdTt8JvbK7jX83AZNJe9wPdHiPB/xZ98fykEAxENVSgjdy7FqwmziO9NzHA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4462tlJU31826131, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4462tlJU31826131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 10:55:47 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:55:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:55:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 6 May 2024 10:55:42 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v17 00/13] Add Realtek automotive PCIe driver
Thread-Topic: [PATCH net-next v17 00/13] Add Realtek automotive PCIe driver
Thread-Index: AQHanHHFWpGAxsmDX0SrcePdJ8GwxrGDNosAgAZR+rA=
Date: Mon, 6 May 2024 02:55:42 +0000
Message-ID: <9053d6fbeb57411684e898ff6a831c49@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502102328.GK2821784@kernel.org>
In-Reply-To: <20240502102328.GK2821784@kernel.org>
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

> On Thu, May 02, 2024 at 05:18:34PM +0800, Justin Lai wrote:
> > This series includes adding realtek automotive ethernet driver and
> > adding rtase ethernet driver entry in MAINTAINERS file.
> >
> > This ethernet device driver for the PCIe interface of Realtek
> > Automotive Ethernet Switch,applicable to RTL9054, RTL9068, RTL9072,
> > RTL9075, RTL9068, RTL9071.
>=20
> Hi Justin,
>=20
> Unfortunately this patch-set does not seem to apply cleanly to net-next.
> Please rebase and repost.

Thanks for the reminder, I will do it.
>=20
> Please wait the standard 24h before reposting.
> Link: https://docs.kernel.org/process/maintainer-netdev.html
>=20
> --
> pw-bot: changes-requested

