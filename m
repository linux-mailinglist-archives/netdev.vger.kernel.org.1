Return-Path: <netdev+bounces-21295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E267632C6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269761C21166
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCBBE47;
	Wed, 26 Jul 2023 09:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117AA92E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:50:28 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD9DBF;
	Wed, 26 Jul 2023 02:50:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36Q9npfpF021032, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36Q9npfpF021032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Wed, 26 Jul 2023 17:49:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 26 Jul 2023 17:50:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jul 2023 17:50:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 26 Jul 2023 17:50:01 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] r8152: adjust generic_ocp_write function
Thread-Topic: [PATCH net-next v2 1/2] r8152: adjust generic_ocp_write function
Thread-Index: AQHZv253hmgza7BjuU+Y5BpmqDIk26/LM6YAgACP1oA=
Date: Wed, 26 Jul 2023 09:50:01 +0000
Message-ID: <95ecef91f1b9446f8a69280d69422b40@realtek.com>
References: <20230726030808.9093-417-nic_swsd@realtek.com>
 <20230726030808.9093-418-nic_swsd@realtek.com>
 <c63b0f24-4e6b-4df3-8783-9899d178b16e@lunn.ch>
In-Reply-To: <c63b0f24-4e6b-4df3-8783-9899d178b16e@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, July 26, 2023 4:37 PM
[...]
> How often is byte_en 0xff? Do you have some benchmark numbers to show
> it is worth the complexity?

It is usually used for writing firmware.
The firmware contains several blocks of continuous registers.

I think it is worth, even this only saves several numbers of control transf=
er.
This patch could replace 3 control transfers with 1 control transfer.
If you could do it with one step, why do you use 3 steps?
Besides, a control transfer is a complex process.
I think this could reduce the loading of both software and hardware.

Best Regards,
Hayes



