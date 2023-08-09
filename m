Return-Path: <netdev+bounces-25698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38862775331
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690F51C20E33
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161F812;
	Wed,  9 Aug 2023 06:49:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF37F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:49:55 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF631BFB;
	Tue,  8 Aug 2023 23:49:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3796nDkiD014301, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3796nDkiD014301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Aug 2023 14:49:13 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 9 Aug 2023 14:49:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 9 Aug 2023 14:49:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 9 Aug 2023 14:49:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Topic: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Index: AQHZxeQMA/4O5CExTkOPXZ48NozVXK/XvyuAgABzMICACVzJQA==
Date: Wed, 9 Aug 2023 06:49:29 +0000
Message-ID: <dd9ff9e7d0524335ababccc93651cc76@realtek.com>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho> <87194ec9-476a-471b-a5b5-d70e8a2cbcd5@lunn.ch>
In-Reply-To: <87194ec9-476a-471b-a5b5-d70e8a2cbcd5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Thu, Aug 03, 2023 at 10:57:29AM +0200, Jiri Pirko wrote:
> > Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
> > >This patch is to add the ethernet device driver for the PCIe
> > >interface of Realtek Automotive Ethernet Switch, applicable to RTL9054=
,
> RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> > >
> > >Signed-off-by: justinlai0215 <justinlai0215@realtek.com>
> >
> > [...]
> >
> >
> > >+
> > >+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd,
> > >+unsigned long arg)
> >
> > There are *MANY* thing wrong in this patch spotted just during 5
> > minutes skimming over the code, but this definitelly tops all of them.
> > I didn't see so obvious kernel bypass attempt for a long time. Ugh,
> > you can't be serious :/
> >
> > I suggest to you take couple of rounds of consulting the patch with
> > some skilled upstream developer internaly before you make another
> > submission in order not not to waste time of reviewers.
>=20
> I have to agree with Jiri here. This 'vendor crap' driver has no chance o=
f being
> merged as is. You need to reach out to some experienced mainline driver
> developers to help you rewrite it to mainline quality.
>=20
>     Andrew

Thank you for your reply, I will refer to your suggestions to modify my cod=
e.

