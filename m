Return-Path: <netdev+bounces-40726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816967C8823
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340CF282C9F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327615ACB;
	Fri, 13 Oct 2023 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOU3wriQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD51134DC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:58:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DF95
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 07:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g23ROS7/zYgBHnZnoLBGenxuSK2yIRSm2+f32rJdPGmaf1hGCjJzfbdcrVX65s70z12S570mGQE9unWscMsW29FRsGxojkxUIAvJ6AKHayg5iODXwp5K71TlrA/dbCfkKsUW1BbLAFzFxt3a3Eocn5ZL5hSBWLw7COJDcKRfd4RW0gi9TrXhjqBswe8TyoMnDoq5F3LeTdRCkagcnOdREzDgCJOY+fibovc+UqY/uOckOIQ48mVs033KveOp9q79SSID693OchwJ0BnKdr7P7QUqkLb5e1milpBIAn8FBWPx4KfTGw2IdUuaj1ugYuFdiNXX48VjgiweXJxlFIccPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EP7JNCqStGiEZixwEMIhKaRzx5CEQ8nxhUPqxd1VLo=;
 b=ONVBZrYRBpBNBKkcJSlvkRYBOMqMJ70dvI6/uYaaow3PSURTdEKvE8aPbVy8YeGkLLzCb+epbvqlxasnNgK1uIAAw13QIiR8Hkz86w1kVZVofFzv+hRX1uo5Wh3YfjSuLUqls2g/ARcB8udLtgA/gXUSOv7/WoywHPljs6VRLxuWtpMMxCSmI9ADUMen2mO8bHw6RI+UOIB/d0vX8muvY0rZq+uV0IPh6NBwTgL0Et6/QQgleRe6TOlQFEoe486QgDR25cM0efgbYrEVDDbjmgjNokUKP0TozPAK+DHGpT1AYu0deuz5MzZHwCLm0fQBlE+AgyMtjj1Y4MwmOwjzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EP7JNCqStGiEZixwEMIhKaRzx5CEQ8nxhUPqxd1VLo=;
 b=LOU3wriQrKVEORzbCxOMYJQn+V29MhzrJRX8btfoZLtKgpz3fcgk9OJW1X4/PyiKIUeyRDgSk1/qP8ATJVVOlxh5HWrPifrofErC6xSPJNhFYcDCpoZs7SL6GldeBoaCDbQVt5b31Z5obxiZseYkGa8FnReDlRHvbBoPAI0RNFj4bEhQ/f6JYMsTvbEeoeRllMQ1OcfO5iI83NeuI/g3gAbVffwgLnnY9c6s6GVIGqbMVJYbDt3jRsCe4hOFgWa9LURo0OFG48kf8kVJqG+4/J4w+04bDW0x+a/MeK9LvY5SJ9hae9ElGN1yevOKfk80GV/AZHnxC35xJjV7CsyTjA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 14:58:23 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 14:58:22 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZ7XtbKQBMq7gXmU2r8HgR2iQihLAnHeiAgCDSUDA=
Date: Fri, 13 Oct 2023 14:58:22 +0000
Message-ID:
 <CH2PR12MB3895A1CB1D3E148E6707BE2DD7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-2-asmaa@nvidia.com>
 <64a2b71c-f3ee-4a95-a2d4-79d2258a70e8@gmail.com>
In-Reply-To: <64a2b71c-f3ee-4a95-a2d4-79d2258a70e8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MW3PR12MB4540:EE_
x-ms-office365-filtering-correlation-id: d5954834-e835-460a-22a1-08dbcbfcd862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kgyfpSicDrMkugqCW0oKvLsPnbXrqc+XYhXZPKEu6BxrYFTAjnSLHvDjyOnkbak/iXu6DwjtDZdAvj2uBMpEelpL44vTo731EMgFe/N+pKbf3BP/hVntktyMDdT79DYDZP3WWkY01zB1ib1su0zwQc7YE/8lPsglEIC+R1TDX/cDSj+FJ/WnRfaf0BG5vvarLulqvAchzoaOWOh2Px4dhe/19rXSpwnLMPd7TVQ5CIZdzME9dQnSdQhZbdQXj3vmA+BW6iQKOniRtFI56TKxZvNP1QHSfXvWNOVQVtP8R2Mdw+y1a+pciD4nq1mhnF7gnCc+GMtwiuD+/Lw1l9rXxJl5IWN6dP5WzO+D5QsxZI7Uh0r1xamVFMpAa/yJ9fvgWKDu5z8PXVnUu1E3LAwuxHWkBbPIdfUU+6yU6Gbh4MZvnT354aS7LBJQ2fVO3V8ZiMePvNI1pDj2JkWDIIRCAQIFyzE3P6vsTG4DAW1VQ4Pu4Pe2fY6anPfrhHw5fUncLQfGFxM+W7Rno2sC0igH2zqmJGPq+mV/Z2eMWP9GJJsVM78dpgEdCshNng8Hcgz7M9JIPLDMGmN47gzNnqg6xDZ36UBZkU/dFWfJrjsaNnuzIfzZLY83iBohHpfzhRDI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(86362001)(55016003)(38100700002)(64756008)(66946007)(66476007)(66556008)(76116006)(54906003)(110136005)(8936002)(8676002)(4326008)(52536014)(5660300002)(316002)(41300700001)(66446008)(26005)(71200400001)(107886003)(478600001)(9686003)(7696005)(6506007)(2906002)(558084003)(122000001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U25UbmVhNjM4d2VtOE5PeEZvQTVMWDNSczFUcWIrY1hIcnIrYkFGY0t5QnB1?=
 =?utf-8?B?YmdLUFJWQmdqQnZSM2NxckNISHViUlNNYnYxRks4Qy9rdVFMbzBha0NoTlVR?=
 =?utf-8?B?MGtRRmg4cHVqNzVmNmtBbnR1NjNxRFlQVkF5STNQdVFNd28vc0NmaCtUTGNq?=
 =?utf-8?B?aTdieDdnaWdGRW1vZFNjcmtTVFZYdmRkWmVSNTdmWndPK0VBUFJITGdWVXZ3?=
 =?utf-8?B?eGFNRVpJRThWWUdYekFIam1BK1Q4MEdIL1Z5aTNoYVRsRzAva2s0djJmaFNw?=
 =?utf-8?B?dGp6K1RWVEFoVVh0dVZjQXlQdFY0UTlrZ1Nqd1JYLzRmaDF2YlVGdUZzRmJK?=
 =?utf-8?B?Tk5mVzFnUitNY2lpbStYMnczTFBtV253VnczRFpQN2Q2aTgwNjJQOTFkR2ZT?=
 =?utf-8?B?RVBMR1RzRUFaVXhqeFJGV2lrMG5LNkJxc1NGeWVrQ0k5c2xNSDFmMGFLMjVO?=
 =?utf-8?B?RVJueG04a3hCOUZGL3pxWGJrd3BNUm05SWRoamFvaDhnWDJ4S2tNRWR5dlZQ?=
 =?utf-8?B?dElGbnBUQlZDSXdJb0tFWjFzRlFkVUxsamxkSkpkSCtHSTNOcWNKRUdaQlN6?=
 =?utf-8?B?RHcyRUxudmJHSGlpZHNUSWRnWWxNV2VSU0l0a3JKWThKaHR1ZHV6TWE5bGdH?=
 =?utf-8?B?dnQvOUhPdDhMZUtKV1J2NjBBVGNzWDk4Z1Nwcyt5UVdjeFVLNkQ3VFU0WTJj?=
 =?utf-8?B?eS9iNVdsRlhpNHdHQlA4dllnakR3R2VUTWQ4L3c3UU82VUNCYzJjbXNoR0FX?=
 =?utf-8?B?Zi8weHc0NDNSUVduVkEyRThQWmZadDRxd0VkZ0JBZ2NkMkVaYUFlQXlMaXdM?=
 =?utf-8?B?a2YwZUpsSkkxeWZWdmtqOVV5V1lKQVlrYUs3SmpjeUpwTVo0S1VkQWxEN0Rz?=
 =?utf-8?B?UFRCVkJ3RkxVMTlPLzRkMTBhVVpSd2dZU2srN1dvVk93TWc0VE5mTzF3RVBR?=
 =?utf-8?B?ZytTUUxRMUVUYnZFMGd2M0NML0FiaG5RdTQ2MHV0REtVNk5iQ0x3bjhWTENq?=
 =?utf-8?B?TWs5dkdYZjIwTHdDTzZhZ3QxRUd1a3lobjZkeEs4SjN4YjhCN3cwblFkK3Qx?=
 =?utf-8?B?S3d3MjhZN2tuOEYrWWlaa1ZHK1FRem81SUt5Q1FqT0lNVEd5TnpjSTJlQkZs?=
 =?utf-8?B?WklxYUp3enJjMS80dlJ3cmQwaWYyeVBFY0REbWptand5TjdIcFNRdm1ZcEE4?=
 =?utf-8?B?UE9kZXdHOXhaejRrQmpObmdIV2VCNndpaGozN0hnbmY3OWhzbWpxdEtRbEdR?=
 =?utf-8?B?bEZiK0w4Y3FXR3Y1VFZBRzk4TVlEaFE4T1NURTd2Z2VZQWtnV1B4ckFrWkZH?=
 =?utf-8?B?YnJBeDVtT0ZUd0tMeFVEUy9HZEsxRzcrdTVuM016VHJxMWMxVC9YdlpvcGZQ?=
 =?utf-8?B?S05KODQ1dHVYeFNmemNwMExmRnJQMEUydmlSb1RlRFVyTVZCcjJZVURYYW5u?=
 =?utf-8?B?dnRrZk1SK3lVT2xuR1FvVDU4aXlGdnUyck54TWpPcnFDa01qZG4xTzRBMkdy?=
 =?utf-8?B?NFFDWEVXQitTakxBc3NmbU1KNCtnS2VVd3lSUmhqb084ZW5pNnF3cHJ2K3Jl?=
 =?utf-8?B?WjZ3TGlvYWVRZ3dzbVpUcE1IMTBsZWpPSHFyZlc2NDdmOXlkbzlLR0tTaXhU?=
 =?utf-8?B?NkZPeVptVVhIdndwUTc5NkNSQmx0TVI4T3EvN0R3V0N5SWZnQUh0U3ZJVStD?=
 =?utf-8?B?WjRUZlZSNVRXYnpydTMzU3dEK0xyTXlSVFJIa3pyTGpIR1V5T25YTDYwTENJ?=
 =?utf-8?B?ckJLbnV3dEJnUUFDZk4rVGlDS3hXQldOcEYrWTl2WVhrcGcwZGxtMEJTbVl2?=
 =?utf-8?B?NCtiMVR4R05iR0I3M3BkYmtpQlRhalVROHN1Vk1LRkU1UzBzdnhMRVhsZWg1?=
 =?utf-8?B?NzNmSW5tc2NUMWU3VEl4TEk5RG1Mc2tsMHZrOFNPQzdSbWxSeWt0QVk5Wnkr?=
 =?utf-8?B?RFNENUlRTDAwYVBDUTIrYVBOckRldFVtLzFyOEFiUkozL2k2UUd6QjhpczIy?=
 =?utf-8?B?ckFGeHJ6eUVTd3lycVMyRENyRGNIN21mQ3lpbTY3TGw0UWVNSFAzWWxaQTFl?=
 =?utf-8?B?M3lpL1lMRnNNRzZ4SENpam5ZOUQ2cUovU0JtUHlQUjFrYmpiR2hjRCt2UEtD?=
 =?utf-8?Q?aC5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5954834-e835-460a-22a1-08dbcbfcd862
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 14:58:22.5084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0oOOEf3m2TmgTJnYBt00f9ZLpKaa4+ujrec8Zu1HaO0BwyjRo2RjXUByMkxevDKaDd2VckwkxzDpcRKVkfyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+ICAgCXByaXYgPSBjb250YWluZXJfb2YobmFwaSwgc3RydWN0IG1seGJmX2dpZ2UsIG5hcGkp
Ow0KPiA+DQo+ID4gKwlpZiAoIXByaXYpDQo+ID4gKwkJcmV0dXJuIDA7DQo+IA0KPiBEbyB5b3Ug
c3RpbGwgbmVlZCB0aGlzIHRlc3QgZXZlbiBhZnRlciB5b3UgdW5yZWdpc3RlcmVkIHRoZSBuZXR3
b3JrIGRldmljZSBpbg0KPiB5b3VyIHNodXRkb3duIHJvdXRpbmU/DQoNCmFsd2F5cyBnb29kIHRv
IGNoZWNrIHZhcmlhYmxlcyBidXQgaWYgd2FudCBtZSB0byByZW1vdmUgaXQgSSBjYW4uDQo=

