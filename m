Return-Path: <netdev+bounces-18516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32FD75774E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310071C20C7F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF1C8C4;
	Tue, 18 Jul 2023 09:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C1C2E2
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:01:57 +0000 (UTC)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A5198C
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:01:47 -0700 (PDT)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I8VEM3018836;
	Tue, 18 Jul 2023 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=dsjeRVZqkgL0BEYE5V1Be1QtfOoBCcdsvxXtS0WDY98=;
 b=psGHEZ3aW5JkrB98SRZSlO1sPraxnjCro3ol2MEzh9Oj7/fFY1y9daA/8UE4GYQuYWhp
 vkJWwYHleCutmDYdjFX55V5nqPr9WTGfqdPdsoPkMfT2RY+08rb82FhCS/ESuaVOJUKo
 JJZHKYEp2QfsammgCUUMgh60VFJWt83kF1ytVGxp2Jvi1zN7qgGY4KdQkDUfVv9y14hI
 VZz8eAucf7NonMHKqsV3XMzaIHaFbv2IIEJuLCxucNOIXHF1lffOhItX5bAPS3oN9N/B
 gAFnyHUxllN2XGtoFhYl3pAvnmAOx+Xqvm/wc+xgP8puh/10Vs/v43+BLH6rbtn6I4ip rg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3ruvk09r5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 05:01:37 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I8gQqA029746;
	Tue, 18 Jul 2023 05:01:37 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3rv8prsghc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jul 2023 05:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcY0qz4c+KYGk1gehu9Kql9T5j926r9BO33HjHNeCtAvMHpWbW0I2AZWcnI0OinCrRGD/1VBiEVk7UCi8T82ssNpHYqs73V8SEj/HG0GkmXAocXeQUdU/mj4g9nzfF7nc+P95p84GuoVOaguD7gYuhXfEaJcngN1kw5fVg7o52jeRaMf4+1/bfA4cI5RsDZckiSXIgtL4ag4NVf2kJgcLJ+Clswb6tNnpoxQ7F6ZRnHfWrqsPrZj8PcQ5obYZwyNRQAOB2rg10g1NJWeZiAwJPMuM9fMZpot/MsI91O8aOyvNXtguYoToSBLGqb8N8Dt2uapTzoMEhTbS+DvSTpVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsjeRVZqkgL0BEYE5V1Be1QtfOoBCcdsvxXtS0WDY98=;
 b=V4pRXIGrNEaqDZMnTCLBNy7XSxBsbf0RN45+e4TJbatzfVguxI4Li4Wox5+EXawZmRTFANE18syHni6FgZ39SYhbUlafr01so0yBixI0JfUbOrUT3lclelX1kVak/LdZE/H+KjYxL7oceuWDP20lFSvbIplCOJe0d3ewoD/KzR30nXRUownC1I1WE8D+ggfbribprk9AJJPph6Qot700BPOao96vP/MTspE2LOv0seF93FWmUksY9v2eLH4KbLOwcg0Y/tukD+TieKkpbMIt7QV4idTgIrqQ9NkT/lg0fhTbeN5KwEEPMSEfTjv9SPYch9ob99wp2I7p0BebzpEMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BN0PR19MB5310.namprd19.prod.outlook.com (2603:10b6:408:155::10)
 by SA1PR19MB8146.namprd19.prod.outlook.com (2603:10b6:806:252::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:01:33 +0000
Received: from BN0PR19MB5310.namprd19.prod.outlook.com
 ([fe80::1db7:ad70:fbb:371f]) by BN0PR19MB5310.namprd19.prod.outlook.com
 ([fe80::1db7:ad70:fbb:371f%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:01:33 +0000
From: "Zekri, Ishay" <Ishay.Zekri@dell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "Panina, Alexandra" <Alexandra.Panina@dell.com>,
        "Barcinski, Bartosz" <Bartosz.Barcinski@dell.com>
Subject: RE: MCVLAN device do not honor smaller mtu than physical device
Thread-Topic: MCVLAN device do not honor smaller mtu than physical device
Thread-Index: Adm0nnOW/GY+fujYQUOSxkfA6dMMTgAgeaMAAQ15WsA=
Date: Tue, 18 Jul 2023 09:01:32 +0000
Message-ID: 
 <BN0PR19MB5310E984E53F00A146F74E269F38A@BN0PR19MB5310.namprd19.prod.outlook.com>
References: 
 <BN0PR19MB5310720D5344A0EBDFC66D9D9F36A@BN0PR19MB5310.namprd19.prod.outlook.com>
 <20230712172414.54ef3ca8@kernel.org>
In-Reply-To: <20230712172414.54ef3ca8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-07-18T09:01:30Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=9e40bcd9-faa1-4d50-bad7-dd9fef0b13fa;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR19MB5310:EE_|SA1PR19MB8146:EE_
x-ms-office365-filtering-correlation-id: 140f65e3-2208-41c5-ac59-08db876d954f
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YfFEdSnSI1wwBze4l4umjvtl82Pid3Kw8Uaz8EM0Nn+6gS99RCqUTmkMwTvYYAonPgCqVnUmIeOnhs0aWSRb6xaEKXb/pGZiMCzMzvIKVvHpWEdJxORlyBGfs9v8n5zQrD2eiVwRE6Y+vpA8JWbAopzyXru9okBdrWtpYEggO7HK44kIk3YC+4hsSjCv+YBheUBx1iNG+I+dbUkUnjgMMSKBiPZNyNuHRsQfnA/d2i+MQFscOIQ0/gXGj6k7c2dsLy9nYqoIBbjtHHwC1nT+TbhQEkCyqz37gAUrlfFInW1iAGrIuSHopZ1wydGQx3jgxhBtsnjgfvGlO4mEvR+vNFsOzrwmk02LeotMP9T5SlP2sJIvB/1FBjouJPHpB+0bcrS87wkIjQ5bkgkfK5+lk4MTdyM6UQEAHrloKfdEsAgig3JxwW6TW/UO+YlZcS35U7L0fTFxFDy3/lEwKvHDO4Pa2h+Ru1ttHG9ZdTMxM6nNavVw929DZVYfKCPXIT1YfLHd+Est+oeqdHZTKsmuKGr9FyF/okComgSd9tSvK1Gy6KhSUaUOa76z3jTf9LwldtbzeYpof85iEysnNeX1QSyk+kY4GDcU5tVMTZIP/bwRwx+D02e8wkljw2Bg7uy0K/G98X0EuH3rkaxMc3vDgQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR19MB5310.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(71200400001)(478600001)(7696005)(54906003)(186003)(9686003)(53546011)(6506007)(26005)(107886003)(76116006)(2906002)(786003)(5660300002)(64756008)(66446008)(66476007)(4326008)(6916009)(66946007)(41300700001)(316002)(8936002)(52536014)(8676002)(66556008)(38100700002)(82960400001)(122000001)(966005)(86362001)(38070700005)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0X+//TfACAVQ7aZo674Tuq/n7Xt9Mp5nD6GNAJwiVcMfKjwxdiqRQw2xKRN5?=
 =?us-ascii?Q?RtPrun7QytHrxMyZBVxlKRBOvr2yGM7egZ4N6Lclb9E20JP+q7Drf78SmFD1?=
 =?us-ascii?Q?YNFX6kjnxlj3GTtgrd/KO/9RPzXTDsEzIohsLeMApKikOW/DqpxPsfft1RXt?=
 =?us-ascii?Q?ihtJ50YVofaGfyV+XnlO1Da0i+srjkWpNT0LKBccapFTF7FVcJ6T4EwuQtLF?=
 =?us-ascii?Q?B71nkJslXB+hAOE+FoekjHBAX5zqNCvPzqLMVh4ktrRsq350hz6I5D1u4ciF?=
 =?us-ascii?Q?RwbCqpYh2EnOtrXM1M9Gk6WW29lWa8jG9blCCfver0gZMKdTDTX+9WZzerVW?=
 =?us-ascii?Q?Gn6HNiF16vwREPW6DudvQvGq5GtyUFrGzqVHv1Z1ADuGkqGq+6jEoqrK3eOt?=
 =?us-ascii?Q?RyV62QrtpCObNL4HoOaF9Bica20TJiavUWJ4ZPZIo9uylR89rD+xcrrUkEB4?=
 =?us-ascii?Q?W+Rs/ZV/z+N4dihNhQw5xZJ+7elcBONt4jvsJ+DFGnSXOGFZTqULPB6ntmL5?=
 =?us-ascii?Q?8uhUzQlYdsGtaKE9u4hIKqlH/tKWVZEgseqfkrveCjI72CpXzEkDTgBl+2uQ?=
 =?us-ascii?Q?d0rHlEr+WV6eqD6CZy5SSfuqxHX3lTc7lw2H/jaMQtIMMmngl3Yogun3f/pr?=
 =?us-ascii?Q?2O5KKhXC/rWMzzAVXAcUU8txf3If0bKTBX596XFxv4agiixlb5aC6FJv41Uh?=
 =?us-ascii?Q?gK/j/AW9qdGwk7cPkDff8YeRruOpffFz57TXH29zWl/9IeeaUt1jJDuRAWS1?=
 =?us-ascii?Q?634BtO7y3NdfH9VvGGGWkutl+1qrnEkJpzVDaXXyZt6fDmxAJn+lEyU6mYsw?=
 =?us-ascii?Q?nb5BgSKghZGUAQUQUl4p1vOaLkHWQviTyafHmrWOg0ZrhKOdMi3dFdsMvSCW?=
 =?us-ascii?Q?tN82kEE225A5yQmxRsECxdLwNtTNK1qS6geg/V122mQGAn57UwQ5hC04oYGj?=
 =?us-ascii?Q?uUVad3Wv9GbkQLcfLEYxzbQgkTuQ0z4AE6WzZZlgsFxk/0O6U6skMWh2HPyA?=
 =?us-ascii?Q?ye0lVAoxbp+XQKSlOdgak/kdof5cYe6ysAFeInaw/FH0LZ3Y0um/YjXMYkRn?=
 =?us-ascii?Q?kodZj9cgiYAwEqmHyL+m4FlPtoHWmxpdI7F5xVW8fQo1tbiEkfDhhAp3zRyu?=
 =?us-ascii?Q?lxv9svmUxhO7q3uxVP8rUt/ZBHDxmlw5gjnIulXsVExZ/H+YZWES1i3pH9z8?=
 =?us-ascii?Q?XE0eOqqB5LBJQwhYsFzCJ51d0hx9HjcnPwxzqDzxLAQcAXUuitJgDaJKwmfO?=
 =?us-ascii?Q?ck78FDLNI43a8OtTjziLJq8qOdCKvq7MvYUyw3q5ODSleYUjcfugmXqFSm1m?=
 =?us-ascii?Q?K7Qn2axpH6Tsqw8TgfdYOAO76q1GTmKgCB+PTTn35FGOsDg1fTsnKlVLRujZ?=
 =?us-ascii?Q?uU46LdXKwYZ/PQXpSy4BknynNHwpG4qzT5U+/GzOUdzFQwHa99X5jJgjZEto?=
 =?us-ascii?Q?M7OqHq3XQ6qjPnA32j58o1/RO4S55zCmgBOwqqQc3mJvcpiT6pb5xUThNUVb?=
 =?us-ascii?Q?OtS67E6zeRf4cwc8IcztKdGZ6i0cgpTm6MYli/45o2VZC23FAnrsmT8gOz1C?=
 =?us-ascii?Q?tB2qbQkna+Wg66So3gpuqb5JeJ1pGtwEdlxWRqgh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR19MB5310.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140f65e3-2208-41c5-ac59-08db876d954f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 09:01:32.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Loy8qbKRDJC6zWhs8Q8+VZM4mONvNc+uNoHEB7xCDHuHroMzBmyaQGZD/lhvvcY5dmZ4hp01eoxbz9bzofmLpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=680 impostorscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180081
X-Proofpoint-GUID: wBt1Td35Azj-SRtMrrofEJHBlPLzWFAP
X-Proofpoint-ORIG-GUID: wBt1Td35Azj-SRtMrrofEJHBlPLzWFAP
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=758 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I gave this post as an example to the issue we are seeing.
We tried to ping from host outside of the server.


Internal Use - Confidential

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Thursday, July 13, 2023 3:24 AM
To: Zekri, Ishay
Cc: netdev@vger.kernel.org; edumazet@google.com; Panina, Alexandra; Barcins=
ki, Bartosz
Subject: Re: MCVLAN device do not honor smaller mtu than physical device


[EXTERNAL EMAIL]=20

On Wed, 12 Jul 2023 09:06:20 +0000 Zekri, Ishay wrote:
> Hi,
>=20
> We experiencing an issue in which MACVLAN MTU does not limit the frame=20
> size, i.e. the limitation is coming from the physical device MTU.
> Kernel version: 5.3.18
>=20
> As described in the case below:
> https://urldefense.com/v3/__https://unix.stackexchange.com/questions/7
> 08638/macvlan-device-do-not-honor-smaller-mtu-than-physical-device__;!
> !LpKI!iFTSU67fNksfVLQ4yxAk3ggSMZPw-qM4PlkTINcLKkuCbWWhnSYQV3YxsBjFDTc1
> hIIiWqVFlWFH$ [unix[.]stackexchange[.]com]
>=20
> it seems like this issue might have a fix.
>=20
> If there was a known kernel issue that was fixed, I really apricate if yo=
u can provide to me the commit in which it was fixed.

In the post above you seem to be pinging the local IP address.

129: K9AT9i1G2x@eth6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqu=
eue state UP group default qlen 1000
    link/ether ba:c7:36:3f:9a:76 brd ff:ff:ff:ff:ff:ff
    inet 192.168.15.40/21 scope global K9AT9i1G2x
         ^^^^^^^^^^^^^
 # ping -c 3 -M do -s 8972 192.168.15.40
                           ^^^^^^^^^^^^^

Local traffic gets routed thru the loopback interface which has the default=
 MTU of 64k. Did you try to ping something outside of the host?

