Return-Path: <netdev+bounces-24052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D776E9F8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EBB1C211D3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED51F176;
	Thu,  3 Aug 2023 13:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AA1E528
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:22:06 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFEDFE46;
	Thu,  3 Aug 2023 06:22:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 373DLOonC021118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 373DLOonC021118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Thu, 3 Aug 2023 21:21:24 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 3 Aug 2023 21:20:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Aug 2023 21:20:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 3 Aug 2023 21:20:46 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jiri Pirko <jiri@resnulli.us>
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
Thread-Index: AQHZxeQMA/4O5CExTkOPXZ48NozVXK/XvyuAgADLZRA=
Date: Thu, 3 Aug 2023 13:20:46 +0000
Message-ID: <14e094a861204bf0a744848cb30db635@realtek.com>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho>
In-Reply-To: <ZMtr+WbURFaynK15@nanopsycho>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.21.210.185]
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Jiri Pirko

Our device is multi-function, one of which is netdev and the other is chara=
cter device. For character devices, we have some custom functions that must=
 use copy_from_user or copy_to_user to pass data.

-----Original Message-----
From: Jiri Pirko <jiri@resnulli.us>=20
Sent: Thursday, August 3, 2023 4:57 PM
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com; pabeni@redha=
t.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driv=
er


External mail.



Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
>This patch is to add the ethernet device driver for the PCIe interface=20
>of Realtek Automotive Ethernet Switch, applicable to RTL9054, RTL9068, RTL=
9072, RTL9075, RTL9068, RTL9071.
>
>Signed-off-by: justinlai0215 <justinlai0215@realtek.com>

[...]


>+
>+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd,=20
>+unsigned long arg)

There are *MANY* thing wrong in this patch spotted just during 5 minutes sk=
imming over the code, but this definitelly tops all of them.
I didn't see so obvious kernel bypass attempt for a long time. Ugh, you can=
't be serious :/

I suggest to you take couple of rounds of consulting the patch with some sk=
illed upstream developer internaly before you make another submission in or=
der not not to waste time of reviewers.


>+{
>+      long rc =3D 0;
>+      struct rtase_swc_cmd_t sw_cmd;
>+
>+      (void)p_file;
>+
>+      if (rtase_swc_device.init_flag =3D=3D 1u) {
>+              rc =3D -ENXIO;
>+              goto out;
>+      }
>+
>+      rc =3D (s64)(copy_from_user(&sw_cmd, (void *)arg, sizeof(struct=20
>+ rtase_swc_cmd_t)));
>+
>+      if (rc !=3D 0) {
>+              SWC_DRIVER_INFO("rtase_swc copy_from_user failed.");
>+      } else {
>+              switch (cmd) {
>+              case SWC_CMD_REG_GET:
>+                      rtase_swc_reg_get(&sw_cmd);
>+                      rc =3D (s64)(copy_to_user((void *)arg, &sw_cmd,
>+                                              sizeof(struct rtase_swc_cmd=
_t)));
>+                      break;
>+
>+              case SWC_CMD_REG_SET:
>+                      rtase_swc_reg_set(&sw_cmd);
>+                      rc =3D (s64)(copy_to_user((void *)arg, &sw_cmd,
>+                                              sizeof(struct rtase_swc_cmd=
_t)));
>+                      break;
>+
>+              default:
>+                      rc =3D -ENOTTY;
>+                      break;
>+              }
>+      }
>+
>+out:
>+      return rc;
>+}

[...]

------Please consider the environment before printing this e-mail.

