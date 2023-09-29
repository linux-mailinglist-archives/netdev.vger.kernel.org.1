Return-Path: <netdev+bounces-37107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E07B3A5B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C57651C2099E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03799513A8;
	Fri, 29 Sep 2023 19:04:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD342C15;
	Fri, 29 Sep 2023 19:04:07 +0000 (UTC)
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 12:04:04 PDT
Received: from sjdc-mailout3.udc.trendmicro.com (sjdcvmout06.udc.trendmicro.com [66.180.82.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE0193;
	Fri, 29 Sep 2023 12:04:04 -0700 (PDT)
Received: from sjdc-mailout3.udc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 78CB65E36F4;
	Fri, 29 Sep 2023 19:01:00 +0000 (UTC)
Received: from sjdc-mailout3.udc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 60FC55E2F14;
	Fri, 29 Sep 2023 19:01:00 +0000 (UTC)
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Unused
Received: from SJDC-EXCH02.eu.trendnet.org (unknown [10.45.168.5])
	by sjdc-mailout3.udc.trendmicro.com (Postfix) with ESMTP;
	Fri, 29 Sep 2023 19:01:00 +0000 (UTC)
Received: from SJDC-EXCH02.eu.trendnet.org (10.45.168.5) by
 SJDC-EXCH02.eu.trendnet.org (10.45.168.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 29 Sep 2023 19:00:57 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by exhybridnabu.trendmicro.com (10.45.168.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27 via Frontend Transport; Fri, 29 Sep 2023 19:00:57 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com (2603:10b6:4:a1::19) by
 CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Fri, 29 Sep 2023 19:00:55 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::453d:552b:ff09:c945]) by DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::453d:552b:ff09:c945%4]) with mapi id 15.20.6813.035; Fri, 29 Sep 2023
 19:00:55 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "oneukum@suse.com" <oneukum@suse.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: ZDI-CAN-22166: New Vulnerability Report
Thread-Topic: ZDI-CAN-22166: New Vulnerability Report
Thread-Index: AdnzByhzvGJymnxIS4eK4BnIHYqWhw==
Content-Class:
Date: Fri, 29 Sep 2023 19:00:54 +0000
Message-ID: <DM5PR0102MB3477C75A38D67E275032FADB80C0A@DM5PR0102MB3477.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=b758cbd5-fa76-406d-a606-421ddd7b921e;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2023-09-29T18:59:06Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0102MB3477:EE_|CH0PR01MB7153:EE_
x-ms-office365-filtering-correlation-id: 8628e14e-5e1c-4e1e-8b8a-08dbc11e688a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TYIbQTNLxfLyWWjuTlNNrQnnzLrWSp6s29DzegL/AHTHubb6YRpdty4ORTRr5HzUmjMQ3mCfBumbZEXx4v1hLDqeqjBD7H6VMCnlKxmOhR6tvGhwGCpfY9vYBQdW1MMIsJYoYWH5uRTDA7CyZ3kMGYXfUQafoyFiP8MtNYlPZYlHOuYOJbMq7NbFLOjh9VYVmVfSWuiklfTenmm5XYMcM3H5qfSHnAXV/wKMFPVNkHSKW/97MRtZRG2qiUe1aISXcCLRsnHaqzM08/m16rvUi4LW2IrOKmZ+BT4xyNjxTA1BnwJMJm8kgjVCH7y5d6/MfM83qne2lEswhLJrpmdpfRdlyjt73KX8pFKJw00SFqirF695z6FZqrSt0pCnT+fhLpUP0nbY5pehMNy0+KVOAYyhOlzD3M/R/a5Xv54daW6TTOTt99/zgD0xb/JKqBYKTBDIs2cremDePxx1D5TAkM8YDt9JNnQeBuH0Ptth3fbK4TjJ9f2Ygp3Y9PFlTu+2u0HGI/k5poW16kemwuU81vMxVIGC9t2x+1ecPLT9ehO//Yqi40h3vlunh8RHQr5vB5N44iVndL+KU+wSoA/SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3477.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(83380400001)(99936003)(2906002)(6916009)(41300700001)(52536014)(30864003)(5660300002)(316002)(66446008)(8936002)(4326008)(8676002)(66556008)(54906003)(33656002)(76116006)(64756008)(26005)(86362001)(82960400001)(966005)(7696005)(6506007)(9686003)(71200400001)(38070700005)(66476007)(38100700002)(66946007)(122000001)(478600001)(574254001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fNvJ7gcLrkFs8/yzOiAOs6X8zSVgWyYqft99f04Fd6384/qPNGbAhZH1/0bv?=
 =?us-ascii?Q?l48hIKfllwKiCSxjY5S/28zW36nej5g5M1jdS9CmP7nhsGNRFac1JG7uhbKK?=
 =?us-ascii?Q?qNuhj9zT4C5II8gW1XEFuK42QKyAbjPSXz/ni2FiC8TkUvoin64jS+GUAxfU?=
 =?us-ascii?Q?+zdD91Oo57bo9KKFpthy54Vi6X0pPYsZ6ByU1JyXsACn1YLa8yvZxez0YKKq?=
 =?us-ascii?Q?HTF4KNnQk2LsWkwUeW+QFTtvtLhey8GMm5naz69Gv/Hqee22Lj1iQhJcumU3?=
 =?us-ascii?Q?rY+NCZGzrlx0SrXV1ccUL1yYmU61N/x6YLPhKNtUY5bnwzhSD6r5CgJFJtt8?=
 =?us-ascii?Q?UcG0SI+gypmhB1pY+Eb0UkpYbYivSWdWfiI6yV1SS9l+gh0DodC/3lgrXpal?=
 =?us-ascii?Q?yJkmSxdZajEv2ixvj+VnKwamvBbAi62YuePPjHsORgRDDu3Db6CjplnxCxrr?=
 =?us-ascii?Q?dCwrIvD3QbdoCiAha4I+GN5MztUSL9kH5AyF/NYjLDCbXGH7RSB6Zn8Lk9Zy?=
 =?us-ascii?Q?fNYenClO1+noh/+d/J9eoehVd8mOnUs8gvK/sysusaa/pvizs04rTdWTODMs?=
 =?us-ascii?Q?gnQG0pcOhLUZayrJFoDhlC0RzvZjT+ufs0hEK2mhL6W8Hf/7y/44e6umXRsV?=
 =?us-ascii?Q?KvelqAue7/o04as9OxzCwVfOO/Cb0L5OA9NMQ+lJEaZPLWYfUVWGRQ4AmbtQ?=
 =?us-ascii?Q?HrwW+I8mjMhExMvsKUAdrrYOrEXXzLVtF0NPIvvtYqvuNgv1cn4gUcHbd0qy?=
 =?us-ascii?Q?tuCc1uMmQ9v9ADd+woIkjY895OocmRTKoUqx7BG2PGvTiRPLwl6f30YEdbps?=
 =?us-ascii?Q?jsxnsX8+8OcAtxUjkK3lUtBgKPEy+7jB19IOtf7u+wzKogH7WyJj+ugjWZJM?=
 =?us-ascii?Q?hTZjlzSvbrD4MigmFWkiKvIDsEffvSUyO0kD5XMzD0cyuN0Sf2gdUO8R1DLg?=
 =?us-ascii?Q?zt5e2kwmH926scgh9/Yn0yAccAPT55l0bK1p8PD0z8l4vQTiLHCEbmmLCEI1?=
 =?us-ascii?Q?sO3zJHrjSB9HerM/8h7g5Aqv30Of29T+6NBAgfPG899zZmXVn/YKDQ+EASrs?=
 =?us-ascii?Q?Y7//nWEY3a96czmCRYeNatOJQidamg17ldDB7uI/K1A4I24Kz1Qlfv6kYQor?=
 =?us-ascii?Q?4RWx9pr3X1rK7iomPo8CjJYIwrWjE31nYtbtZyFSnY9KLIxbQTyD6KQzVGFC?=
 =?us-ascii?Q?VYyuiJE1g9oOWAYxSZjGUCoRHfPj+fVUIFQwYjOYxlS3k5jJCV3YQ3/pg14R?=
 =?us-ascii?Q?0BI9N7ASzDly/QCqTiQN4V2sL1BwMrzTREGQagWFgSJDEpYUQrekh5Xh6+lO?=
 =?us-ascii?Q?YNp34MV14tJjZpAsdGuCPHs2IjoGd1NXsq7+SdYypa6Uk41pr02JvetQ6R+B?=
 =?us-ascii?Q?zneOVms2+BGXDTt9PKKaJKN7UcPhiF69KgICAQ1lT2EGAFXHZA32K4iBVm0p?=
 =?us-ascii?Q?8ExlMBe9cSu5KBLf0qnYOHh9QVZ+iCrUC3QZY73Dtq7fzOxjCVnWjyJ9BAWN?=
 =?us-ascii?Q?5CO7oP8t1D6fwa8VJQSfli99ZQYyZvIaPTJU7yflQgjeyoUfmK+Xd7+G3cok?=
 =?us-ascii?Q?OJ18nKPJREyQytQ734ZgSix4Av3mBgrNLNnhQjt28BHI1aUpcggFon9hvFVg?=
 =?us-ascii?Q?TnbQ1pXXycWrJ8GbbN5aaK8=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzNx6ClwDFj0gws6eBek3B2Z5PChKVUIucExZiYsg1TDMEnt2O3pPd75ZJ8F+RJY8s21gA0+iU1VaQUBrKun2xkl8d5DGzTW8qYiQiS/ILAjV6+TiWfgyywyTOFpyCKVR/dLH7IX7ZWeqdOt7dlKirommPuil4NVku3n865Ou2BZlKRjtJIW9cUAajQ2EHycxpbYYVSEiYia8xOz9N3cZ0KdquowDqOmdSiEVbz8k2TRkqsAyFzBQgPH6xA3wdG9xl929y4UXaQWt9bRaytkJrI8oD+IyVs1BBxsyiDVnPOFmnvvJF+RVGXmEZXi1HVj9kdvZq/79TXQDp2XNTgCJQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78WdtiZQ+tGio57gHTpWIxKDI9zbe0XW7S70xHLARFM=;
 b=GKhrtmYfflmO190hY82h7MerzxbfUgnDqgv3362J7uUjdvwCz7qnhMpWaKePW9avwHtFDtxI8/weIT8GwP1dOf2idzU1gacXfMi8U4Hw6z39rYBmxMNLQS6ESJqh/KuahSQNhppJjBfUk90bEgkpJtRig0MMk9b+ju02V0a4fBWLKmtgQcToz2I95MkaOLGyyIF+6227/DsXajwAxjdtstnmC2zqWAupME3kx90VbzfoNZ7gK7lAIaITGcbhJYta4vnqW417pHccHNYsQVAjabJO0bcEKBrhQcAGlNTAQNJbQ2ZYAYiWLz1zMxcdR5GTQwekX3b1wy8wt637O/9hdg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM5PR0102MB3477.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 8628e14e-5e1c-4e1e-8b8a-08dbc11e688a
x-ms-exchange-crosstenant-originalarrivaltime: 29 Sep 2023 19:00:54.9774 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: wf2/wl0JnO/Q6iG/J+f2TMwNbTxGYH+J9bZC9AFgFXGs9yuYgRwOhAJQyzBCiS0Eu0+2u/YngY8TDCUv2yxoOpgD+HbSAczFwrX7clFCZO9bPlf/Q0ys0sLN2FcaRpNv
x-ms-exchange-transport-crosstenantheadersstamped: CH0PR01MB7153
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27906.001
x-tm-as-result: No-10--31.584500-5.000000
x-tmase-matchedrid: 2rB+w6GmFBQ2eFTDBkQySqzGfgakLdjavhbU5J9dplIXjbCEtErbdLtS
	UsE9MLDydjJZ7dbAVkmGUgpA+K6TNsc9PPPpWod0sWltH2OCDLg4++cnkPOIrNRGf5c57+FF1a9
	Gw6X1fIjtPd/gfdfSIcLLQE2dzCJpL/tBTZzO5Q0D2WXLXdz+AVK6+0HOVoSoWH7Bxw4ADCMWor
	zH4yfEatToWqSVetNhcWsSYyeVwqaw1nLnnWhzt3V7tdtvoibaW+HVwTKSJIbONhUMZJakH5LRO
	SOJB8UT1unoHyvxPpj940kgQo94B2JHJG/db0P+JmbrB1j4XwppkBMYDn8FeEekR3VSvOYVSmNw
	OLpHJ8rccFJDe/0a0tarP8T/Z0X5FkFfh5pOmefX3j/lf1V8LARryDXHx6oXEUEOJBao4yQDSol
	kLUzaFC/S37ZIh2W4y9oZZaYQK51UP7Ek5cDANaoXHZz/dXlxtOtXYgbXjddYC5LPd7BvbZIxYR
	CXVoEqh5aTsTj12pnXzpfPTW9YeBBAYzpZxAP8EhGH3CRdKUXxuhkRWK22GAWZr8KJIg94uHgEI
	oy46d9ThxOXdnMlj8UJPUeTzbOZkZmKVOLxy1ILwUwfdPoXvhB0ENZnw1vtmrUoPP0/hbuN1Xlb
	FhNiP+88Fcs91t4csWxuX83VRsFmvvf3V+Eb7pAMI8jB49beGEGBUNvh8GCTsyhw1KPqkDPn4yD
	W5yf3g5ortHq/YwxkAJ626kUksJdW3P+FD/5OLTHwnYOikQ109Wu/P+bbhFfgf8AdlMAq8Jgqp/
	3e7hfwYKShJdlqCcHFU143Oy/Z54o2Y013b1eJDLgwb/1K2WmRqNBHmBveii7lXaIcF/UXvQkGi
	3tjzy0k/sgAJDhbkU6UkIr/V+20QRlrBF3eZf09JVSbtE7vi6q+gYymLlRbxdUfP9y0y882aqRY
	xWSSBpAr91S/hLE=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--31.584500-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27906.001
x-tm-snts-smtp: F887E4035C1BCD793C561C8F3215F926FB92273C44217B29AF7497E0441D80882000:7
Content-Type: multipart/mixed;
	boundary="_002_DM5PR0102MB3477C75A38D67E275032FADB80C0ADM5PR0102MB3477_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=tmoutbound; t=1696014060;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; l=0;
	h=From:To:Date;
	b=BmI+27ALO38joPKXuUcffP6+VGeMu1QMOBvA6ouHNgqUWLQXzJFU39FRl3f7SLtuj
	 IDPCRQykso3mlddPTzf9FeLMPaDkmakhAVmbSFgnfB+3KWWEr+2oA07YHoN12qsWcg
	 iZir+3W/gQMJG6xTZ2ZT3JFPNjaLR7Svwc+iqTxU=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--_002_DM5PR0102MB3477C75A38D67E275032FADB80C0ADM5PR0102MB3477_
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attachment could not be scanned for viruses because it is a password =
protected file.
ZDI-CAN-22166: Linux Kernel usbnet Driver Race Condition Privilege Escala=
tion Vulnerability

-- CVSS -----------------------------------------

7.1: AV:P/AC:H/PR:N/UI:N/S:C/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
Linux - Kernel

-- VULNERABILITY DETAILS ------------------------
* Version tested:6.6-rc1
* Installer file:-
* Platform tested:debian bullseye

---

### Analysis

```
race condition bug exist in usbnet driver
usbnet_disconnect() didn't flush/cancel the usbnet_deferred_kevent work q=
ueue before disconnecting
it can then trigger the UAF on struct net_device by racing bewteen usbnet=
_disconnect() and usbnet_deferred_kevent()
```


i patched the kernel to trigger it easily
```
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 2d14b0d78..4183e7e07 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
-
+#include <linux/delay.h>
 /*----------------------------------------------------------------------=
---*/

 /*
@@ -1136,7 +1136,7 @@ usbnet_deferred_kevent (struct work_struct *work)
        struct usbnet           *dev =3D
                container_of(work, struct usbnet, kevent);
        int                     status;
-
+       msleep(100);
        /* usb_clear_halt() needs a thread context */
        if (test_bit (EVENT_TX_HALT, &dev->flags)) {
                unlink_urbs (dev, &dev->txq);
```

~~~C++
static void
usbnet_deferred_kevent (struct work_struct *work)
{
        struct usbnet           *dev =3D
                container_of(work, struct usbnet, kevent);
        int                     status;

        /* usb_clear_halt() needs a thread context */
        if (test_bit (EVENT_TX_HALT, &dev->flags)) {                    /=
/ access on the freed dev
                unlink_urbs (dev, &dev->txq);
                status =3D usb_autopm_get_interface(dev->intf);
                if (status < 0)
                        goto fail_pipe;
                status =3D usb_clear_halt (dev->udev, dev->out);
                usb_autopm_put_interface(dev->intf);
                if (status < 0 &&
                    status !=3D -EPIPE &&
                    status !=3D -ESHUTDOWN) {
                        if (netif_msg_tx_err (dev))
fail_pipe:
                                netdev_err(dev->net, "can't clear tx halt=
, status %d\n",
                                           status);
                } else {
                        clear_bit (EVENT_TX_HALT, &dev->flags);
                        if (status !=3D -ESHUTDOWN)
                                netif_wake_queue (dev->net);
                }
        }
        if (test_bit (EVENT_RX_HALT, &dev->flags)) {
...
}

~~~


KASAN report
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in instrument_atomic_read /root/linux/./i=
nclude/linux/instrumented.h:68
BUG: KASAN: slab-use-after-free in _test_bit /root/linux/./include/asm-ge=
neric/bitops/instrumented-non-atomic.h:141
BUG: KASAN: slab-use-after-free in usbnet_deferred_kevent+0x35/0xde0 /roo=
t/linux/drivers/net/usb/usbnet.c:1141
Read of size 8 at addr ffff8880213291a8 by task kworker/0:2/917

CPU: 0 PID: 917 Comm: kworker/0:2 Not tainted 6.6.0-rc1-dirty #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian=
-1.16.0-5 04/01/2014
Workqueue: events usbnet_deferred_kevent
Call Trace:
 <TASK>
 __dump_stack /root/linux/lib/dump_stack.c:88
 dump_stack_lvl+0xd9/0x1b0 /root/linux/lib/dump_stack.c:106
 print_address_description /root/linux/mm/kasan/report.c:364
 print_report+0xc4/0x620 /root/linux/mm/kasan/report.c:475
 kasan_report+0xda/0x110 /root/linux/mm/kasan/report.c:588
 check_region_inline /root/linux/mm/kasan/generic.c:181
 kasan_check_range+0xef/0x190 /root/linux/mm/kasan/generic.c:187
 instrument_atomic_read /root/linux/./include/linux/instrumented.h:68
 _test_bit /root/linux/./include/asm-generic/bitops/instrumented-non-atom=
ic.h:141
 usbnet_deferred_kevent+0x35/0xde0 /root/linux/drivers/net/usb/usbnet.c:1=
141
 process_one_work+0x887/0x15d0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8bb/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33a/0x430 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 4496:
 kasan_save_stack+0x33/0x50 /root/linux/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 /root/linux/mm/kasan/common.c:52
 ____kasan_kmalloc /root/linux/mm/kasan/common.c:374
 __kasan_kmalloc+0xa3/0xb0 /root/linux/mm/kasan/common.c:383
 kasan_kmalloc /root/linux/./include/linux/kasan.h:198
 __do_kmalloc_node /root/linux/mm/slab_common.c:1023
 __kmalloc_node+0x63/0x110 /root/linux/mm/slab_common.c:1030
 kmalloc_node /root/linux/./include/linux/slab.h:619
 kvmalloc_node+0x6f/0x1a0 /root/linux/mm/util.c:607
 kvmalloc /root/linux/./include/linux/slab.h:737
 kvzalloc /root/linux/./include/linux/slab.h:745
 alloc_netdev_mqs+0x9b/0x1290 /root/linux/net/core/dev.c:10681
 usbnet_probe+0x1bc/0x2850 /root/linux/drivers/net/usb/usbnet.c:1698
 usb_probe_interface+0x307/0x930 /root/linux/drivers/usb/core/driver.c:39=
6
 call_driver_probe /root/linux/drivers/base/dd.c:579
 really_probe+0x234/0xc90 /root/linux/drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 /root/linux/drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 /root/linux/drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 /root/linux/drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 /root/linux/drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 /root/linux/drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 /root/linux/drivers/base/bus.c:532
 device_add+0x1182/0x1ac0 /root/linux/drivers/base/core.c:3622
 usb_set_configuration+0x10cb/0x1c40 /root/linux/drivers/usb/core/message=
.c:2207
 usb_generic_driver_probe+0xca/0x130 /root/linux/drivers/usb/core/generic=
.c:238
 usb_probe_device+0xda/0x2c0 /root/linux/drivers/usb/core/driver.c:293
 call_driver_probe /root/linux/drivers/base/dd.c:579
 really_probe+0x234/0xc90 /root/linux/drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 /root/linux/drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 /root/linux/drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 /root/linux/drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 /root/linux/drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 /root/linux/drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 /root/linux/drivers/base/bus.c:532
 device_add+0x1182/0x1ac0 /root/linux/drivers/base/core.c:3622
 usb_new_device+0xd8c/0x1950 /root/linux/drivers/usb/core/hub.c:2589
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5440
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x2daf/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8bb/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33a/0x430 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

Freed by task 4496:
 kasan_save_stack+0x33/0x50 /root/linux/mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 /root/linux/mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 /root/linux/mm/kasan/generic.c:522
 ____kasan_slab_free /root/linux/mm/kasan/common.c:236
 ____kasan_slab_free+0x138/0x190 /root/linux/mm/kasan/common.c:200
 kasan_slab_free /root/linux/./include/linux/kasan.h:164
 __cache_free /root/linux/mm/slab.c:3370
 __do_kmem_cache_free /root/linux/mm/slab.c:3557
 __kmem_cache_free+0xcc/0x2d0 /root/linux/mm/slab.c:3564
 kvfree+0x47/0x50 /root/linux/mm/util.c:653
 device_release+0xa1/0x240 /root/linux/drivers/base/core.c:2484
 kobject_cleanup /root/linux/lib/kobject.c:682
 kobject_release /root/linux/lib/kobject.c:716
 kref_put /root/linux/./include/linux/kref.h:65
 kobject_put+0x1d0/0x440 /root/linux/lib/kobject.c:733
 put_device+0x1f/0x30 /root/linux/drivers/base/core.c:3730
 free_netdev+0x408/0x5f0 /root/linux/net/core/dev.c:10831
 usbnet_disconnect+0x26b/0x540 /root/linux/drivers/net/usb/usbnet.c:1637
 usb_unbind_interface+0x1dd/0x8d0 /root/linux/drivers/usb/core/driver.c:4=
58
 device_remove /root/linux/drivers/base/dd.c:569
 device_remove+0x11f/0x170 /root/linux/drivers/base/dd.c:561
 __device_release_driver /root/linux/drivers/base/dd.c:1272
 device_release_driver_internal+0x44a/0x610 /root/linux/drivers/base/dd.c=
:1295
 bus_remove_device+0x22c/0x420 /root/linux/drivers/base/bus.c:574
 device_del+0x39a/0xa50 /root/linux/drivers/base/core.c:3811
 usb_disable_device+0x36c/0x7f0 /root/linux/drivers/usb/core/message.c:14=
16
 usb_disconnect+0x2e1/0x890 /root/linux/drivers/usb/core/hub.c:2252
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5280
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x1db7/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8bb/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33a/0x430 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 /root/linux/mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 /root/linux/mm/kasan/generic.c:492
 insert_work+0x38/0x230 /root/linux/kernel/workqueue.c:1647
 __queue_work+0x5d2/0x1060 /root/linux/kernel/workqueue.c:1799
 queue_work_on+0xed/0x110 /root/linux/kernel/workqueue.c:1834
 queue_work /root/linux/./include/linux/workqueue.h:554
 schedule_work /root/linux/./include/linux/workqueue.h:615
 usbnet_defer_kevent+0x7b/0x240 /root/linux/drivers/net/usb/usbnet.c:470
 usbnet_link_change /root/linux/drivers/net/usb/usbnet.c:2000
 usbnet_probe+0x1a4b/0x2850 /root/linux/drivers/net/usb/usbnet.c:1845
 usb_probe_interface+0x307/0x930 /root/linux/drivers/usb/core/driver.c:39=
6
 call_driver_probe /root/linux/drivers/base/dd.c:579
 really_probe+0x234/0xc90 /root/linux/drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 /root/linux/drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 /root/linux/drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 /root/linux/drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 /root/linux/drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 /root/linux/drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 /root/linux/drivers/base/bus.c:532
 device_add+0x1182/0x1ac0 /root/linux/drivers/base/core.c:3622
 usb_set_configuration+0x10cb/0x1c40 /root/linux/drivers/usb/core/message=
.c:2207
 usb_generic_driver_probe+0xca/0x130 /root/linux/drivers/usb/core/generic=
.c:238
 usb_probe_device+0xda/0x2c0 /root/linux/drivers/usb/core/driver.c:293
 call_driver_probe /root/linux/drivers/base/dd.c:579
 really_probe+0x234/0xc90 /root/linux/drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 /root/linux/drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 /root/linux/drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 /root/linux/drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 /root/linux/drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 /root/linux/drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 /root/linux/drivers/base/bus.c:532
 device_add+0x1182/0x1ac0 /root/linux/drivers/base/core.c:3622
 usb_new_device+0xd8c/0x1950 /root/linux/drivers/usb/core/hub.c:2589
 hub_port_connect /root/linux/drivers/usb/core/hub.c:5440
 hub_port_connect_change /root/linux/drivers/usb/core/hub.c:5580
 port_event /root/linux/drivers/usb/core/hub.c:5740
 hub_event+0x2daf/0x4e00 /root/linux/drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8bb/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33a/0x430 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888021328000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 4520 bytes inside of
 freed 8192-byte region [ffff888021328000, ffff88802132a000)

The buggy address belongs to the physical page:
page:ffffea000084ca00 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x21328
head:ffffea000084ca00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
memcg:ffff8880172b3201
flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0x1()
raw: 00fff00000000840 ffff888012c4db00 ffffea00006ebd10 ffff888012c4cc50
raw: 0000000000000000 ffff888021328000 0000000100000001 ffff8880172b3201
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x2460c0=
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_THIS=
NODE), pid 4496, tgid 4496 (kworker/0:4), ts 173334243118, free_ts9
 set_page_owner /root/linux/./include/linux/page_owner.h:31
 post_alloc_hook+0x2cf/0x340 /root/linux/mm/page_alloc.c:1536
 prep_new_page /root/linux/mm/page_alloc.c:1543
 get_page_from_freelist+0xee0/0x2f20 /root/linux/mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 /root/linux/mm/page_alloc.c:4426
 __alloc_pages_node /root/linux/./include/linux/gfp.h:237
 kmem_getpages /root/linux/mm/slab.c:1356
 cache_grow_begin+0x99/0x3a0 /root/linux/mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 /root/linux/mm/slab.c:2923
 ____cache_alloc /root/linux/mm/slab.c:2999
 ____cache_alloc /root/linux/mm/slab.c:2982
 __do_cache_alloc /root/linux/mm/slab.c:3182
 slab_alloc_node /root/linux/mm/slab.c:3230
 __kmem_cache_alloc_node+0x3c9/0x470 /root/linux/mm/slab.c:3521
 __do_kmalloc_node /root/linux/mm/slab_common.c:1022
 __kmalloc_node+0x52/0x110 /root/linux/mm/slab_common.c:1030
 kmalloc_node /root/linux/./include/linux/slab.h:619
 kvmalloc_node+0x6f/0x1a0 /root/linux/mm/util.c:607
 kvmalloc /root/linux/./include/linux/slab.h:737
 kvzalloc /root/linux/./include/linux/slab.h:745
 alloc_netdev_mqs+0x9b/0x1290 /root/linux/net/core/dev.c:10681
 usbnet_probe+0x1bc/0x2850 /root/linux/drivers/net/usb/usbnet.c:1698
 usb_probe_interface+0x307/0x930 /root/linux/drivers/usb/core/driver.c:39=
6
 call_driver_probe /root/linux/drivers/base/dd.c:579
 really_probe+0x234/0xc90 /root/linux/drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 /root/linux/drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 /root/linux/drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 /root/linux/drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 /root/linux/drivers/base/bus.c:457
page last free stack trace:
 reset_page_owner /root/linux/./include/linux/page_owner.h:24
 free_pages_prepare /root/linux/mm/page_alloc.c:1136
 free_unref_page_prepare+0x476/0xa40 /root/linux/mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 /root/linux/mm/page_alloc.c:2405
 slab_destroy /root/linux/mm/slab.c:1608
 slabs_destroy+0x85/0xc0 /root/linux/mm/slab.c:1628
 drain_array+0x91/0xa0 /root/linux/mm/slab.c:3795
 cache_reap+0x164/0x330 /root/linux/mm/slab.c:3833
 process_one_work+0x887/0x15d0 /root/linux/kernel/workqueue.c:2630
 process_scheduled_works /root/linux/kernel/workqueue.c:2703
 worker_thread+0x8bb/0x1290 /root/linux/kernel/workqueue.c:2784
 kthread+0x33a/0x430 /root/linux/kernel/kthread.c:388
 ret_from_fork+0x45/0x80 /root/linux/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 /root/linux/arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888021329080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021329100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021329180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888021329200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021329280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Lucas Leong (@_wmliang_) of Trend Micro Zero Day Initiative

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidenti=
al and may be subject to copyright or other intellectual property protect=
ion. If you are not the intended recipient, you are not authorized to use=
 or disclose this information, and we request that you notify us by reply=
 mail or telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: Read privacy policy<http://www.tr=
endmicro.com/privacy>

--_002_DM5PR0102MB3477C75A38D67E275032FADB80C0ADM5PR0102MB3477_
Content-Type: application/x-zip-compressed; name="ZDI-CAN-22166.zip"
Content-Description: ZDI-CAN-22166.zip
Content-Disposition: attachment; filename="ZDI-CAN-22166.zip"; size=5505;
	creation-date="Fri, 29 Sep 2023 18:59:43 GMT";
	modification-date="Fri, 29 Sep 2023 19:00:53 GMT"
Content-Transfer-Encoding: base64

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

--_002_DM5PR0102MB3477C75A38D67E275032FADB80C0ADM5PR0102MB3477_--


