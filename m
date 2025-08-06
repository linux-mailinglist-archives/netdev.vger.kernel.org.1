Return-Path: <netdev+bounces-211874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D2B1C22A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982C3186B95
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18716221FD2;
	Wed,  6 Aug 2025 08:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4F218ACC;
	Wed,  6 Aug 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468983; cv=fail; b=p2MumEeRFpbiSICGKMqcpHorI0SmqNIR31DbtH9p5hzAEcXfpDy8uYHBD7Ss6OkbWu+6yrAApyeTA9UO906QrtOG0zNxVu4jZ/e/eluAdz397wQ3KCakMDSwoAurOMZIu5vqrvlC87fBcSp7H61Gp5mY4nam2Rlp/KAGI8YEK4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468983; c=relaxed/simple;
	bh=+6y2TQUrqunnBTz1RH9Nx0ouqVI2OvnMSvGOjsIsREA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RvM6bUhnLyTEitXb7D1C9W4yvHaCIt/I/GONm20yHNCvb4mIQEljxITXPQS59YX5jCwZriPvWffpqVV2KrS44Z0uP723EKebqOAauMjsduEhWP+96oduTFAKyBOtP91HtAr+rvMLki3NE0SljKLR1WTj4u2heQi+FGJCdRg5GjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5764g66n2103462;
	Wed, 6 Aug 2025 08:29:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48bpyf8p4s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 08:29:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6Rde34kPaHo7ZHL+D/7Cn1nWwIl217Oj/kocg+9uyZnzh9/344aZewQATsjhkyGV4jjwuZoUY0oUCZ7tq6/B7uA16lm0uY3Ba34PKA+aXrW7tFwXXGlR9543ZRZG4ciLxA9YLGwnV9kpe3PZaIVnm1yUnSUPU8xxwO8k9QImBY7coMR7mybg3z8RODVR5Te2iwm5+HoBUzG7I6gKhAN9iQjyHHYhvJqAikV/Z9gScHbzEISId5cIUXHxSbsAjrAw3E/4+fpykD2W9FXeF5aHyH55A85AOBioZvRUcmzqqAh1U6RRIKuzAQxK4dnMkZRIuFDIdnIWVsPw17IbE3kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz2wSCsFugENAr135t7F2MaDNZzWeLlfUXfcnQcQnF4=;
 b=yck7Zw3AYhUaHWfvpzxvUIZKvHNPmikV0lzcVpDB5Wx/l6Jok/NiYTihGy0QdNyyGNHA94NFVzM8yR+aRGqEYsJsAqlMsBfTbnnRAzaGmw9/Oa5UU1Q2aClU8wupnCPmCshr3oetJwmUk7YCnvWI0mxCVQS3uRVymL5WuYkaFuK7c420+UtExLQ1MQMo/NniRMZpGTI32aOrMhhQjAPdFB3ItsKO/v+XjdkckXOi2a0mMAGlpMPaQ1pscjNpVmwTU5PkD74owPHEYDDcC4UXJtqcuDgaIfkn65TL8c0fcFh6hsrEPxd8TyUerP3Aa1Bn000qNppMHC21w0PFfmvgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 08:29:35 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::813a:3211:c8fd:1f86]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::813a:3211:c8fd:1f86%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:29:34 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Lion Ackermann <nnamrec@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ovs-discuss@openvswitch.org" <ovs-discuss@openvswitch.org>
Subject: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
Thread-Topic: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
Thread-Index: AQHcBqwnVxttHlrD2k2Y5Jexvx5xmw==
Date: Wed, 6 Aug 2025 08:29:34 +0000
Message-ID:
 <CO6PR11MB5586DF80BE9D06569A79ECB2CD2DA@CO6PR11MB5586.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-06T08:29:24.300Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: 0e91176b-035d-4afa-fa0d-08ddd4c35fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jcasYoG5Jr1079/wJxXYCYOzVnU+VaZ66oR9iz+Ipw5iqxBGFlBRUZsc84?=
 =?iso-8859-1?Q?2ZjnP4rDJGBBJkT33fALx6pjstgd5ae8hi4p/jnGd3OpY+l5m37C6GT3MS?=
 =?iso-8859-1?Q?kBBjUnxTlxz1HrAd+tgMO6/cHTN0k4W6/jXP8l4CDDs3sMMnNMn3YByyok?=
 =?iso-8859-1?Q?C8RJ979vTsQZ1YAfPpd3j/2maKw85N/gBGKCpHw+0NksLrJTJpWVOBNa5n?=
 =?iso-8859-1?Q?3DwOPIIPz9D+fO2pTa769P76eYKAp1m0Q0vdDpsGm8qybrqdpdCSzhSRo0?=
 =?iso-8859-1?Q?xiUaK1h0Lh3rDXB80IQcWssd2/6Ef0skxTg84LhrBSzrExLr6gul+Jtb3l?=
 =?iso-8859-1?Q?/joGlWfHfY4vQ+B66+wNK+F7vKfx1/mYVJpVWMUgcUnFEvp2qR1eryw736?=
 =?iso-8859-1?Q?v4o+TZ9x7Ehso0gu9AYn5/0Zz/Uicrw233GfxHlDia0tQbYiWN1Xvk2o0t?=
 =?iso-8859-1?Q?kWFJoERcvQ4HYL50jQYWH2mQQbIxEAJL6d54YB261TvX36BAyv/I7RZGpt?=
 =?iso-8859-1?Q?ff6/qGMytJ0g7CqRo6pY2nAllAn2diNM4oW+pVn2XIFAgKo3IiqjT4LFmy?=
 =?iso-8859-1?Q?RCHPWkrm+wzMWuL+6HNzGQH2vjez8RoufC2ALCnHL1AIlgaBxlM3/x0T0l?=
 =?iso-8859-1?Q?6t75mxPTOMkplZL7Opdvvioa7E6IgV0gi079VBQGqtyGVZ9cvqNrE4Gbtm?=
 =?iso-8859-1?Q?OOq7tuVExboquSYXHZkLUF695YqPCdUTX9Q4lY0LBsMS4MSYY86rvTgc/H?=
 =?iso-8859-1?Q?HI0GmxmS+piaoKo4XQmnGnOAcY9DGPHbH4LcFD4bAbn/qQwyB6CbAQGOFq?=
 =?iso-8859-1?Q?OTPMHXw4GJErAX9YGn5Dd4FEi7lIicSxxYrvZd4zlWDW0kL6rxQ6jVs6kN?=
 =?iso-8859-1?Q?h12KIyk6MUpz9fvVCORvfE7AZnIZ/MoQxpk8Qm+lVAZaTo1bIqq3DHqn6J?=
 =?iso-8859-1?Q?JD1Zgq1bfYMqwpbIdWAxlGDagtx1bzb71H5NFIDFDIoZoGMYtdYhDDTHUR?=
 =?iso-8859-1?Q?4cTBw2vNxZGvTid5stJtRVs/9AKOvxDTfMhuNHB3YCdS5jiqCx99jzTfIn?=
 =?iso-8859-1?Q?ow78WrqcdkcL14JlpkrMIK//YSv1rKEf21SX+NibmkC77BHcHYvQ97UDPJ?=
 =?iso-8859-1?Q?2lbEFAakWWZUt2NLrNJ2ffnKkXsDC0k1CvqFEoayxsRQrEhiwbc1oL7yi/?=
 =?iso-8859-1?Q?PFQEGMF8rQ+sv1JnNSNrDouT/KlNVCinWehrnvPb94j6qLMqq5YkhpLeUS?=
 =?iso-8859-1?Q?VoZD38yCsyssEQkIJ1X3R02Ob5eNnoGTy+yIpN8Bq4UWtcnIRrHuLBRxEt?=
 =?iso-8859-1?Q?D1fyjPefDLfSZZBPucMiumGAwYcqoLZB4cQQ4aUd/+yk650gf87DGKUPIZ?=
 =?iso-8859-1?Q?sspCNq/1MXLfBVis2ZZp8X0VNIhd+wG1/+TSO2m70epjWQotIM4VIFFUSs?=
 =?iso-8859-1?Q?vBUlZkUjn+qZcmABqGrgEPg9scIzfFtWI/FMMS/dG81LhDRUA1zUh58cul?=
 =?iso-8859-1?Q?MQ9KUvQVHZ0b2WNxZy7pwwG/eqSsgqg5ykAg3xOtsNtQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IrvFREaMRg3uWy8gxAevmSIrxibDT/dL8aBGt+SMnISdFzNjxYM1Me517Z?=
 =?iso-8859-1?Q?RWkkPFzfjRsxjFhzmfu5ngY50Aldh/jRBo3dhelhNL863UsEtAQiYZLlq8?=
 =?iso-8859-1?Q?f5fu+BPVSiKP/tdFt99Fa9FQxMVmtvjkADU5AtzB/V1dPgvZAD3EQevcQZ?=
 =?iso-8859-1?Q?RHgUxKzAGP0eZNWbMBPg6OiEb2Cr20f6iZ2CPlafnXnfY4/xOqlM7I7uWp?=
 =?iso-8859-1?Q?EyANnN+1d74TYSeayDuGigGLd73AwccDlad6lztBGRPVwoKGjzp6TxLPHB?=
 =?iso-8859-1?Q?3ps5qoJZvFnDHFdvK6UTAuX2RzHJrjIS86tW3am/FU83phW5RdEqA2f7LJ?=
 =?iso-8859-1?Q?eCUOAvfYSXtp4EXrTe9az979ERB8jfmJKMk4jymHo7BXbsqVO664FqHcWm?=
 =?iso-8859-1?Q?3MghUn1xYYgBb0nE6ikuyQmk1OOk5T5SkYUU+xNAbCTkCdcc4T/nuv0Zpq?=
 =?iso-8859-1?Q?bQ9aDlRbJvgPVGkfVh0O5qXyxPRzdvasa2yu5rp/DL+KwrEwJwfNRu8D4n?=
 =?iso-8859-1?Q?69pwhero6cY5njriBfvufryeQk8+G3D7jHGjyvcIyvXu2W0i2rjSroQ/x6?=
 =?iso-8859-1?Q?9QUa7Op0V/93m1zOd/ngWjdX/+HQn6CVfpYYuSdvPADL+zL7V88xWiHd0z?=
 =?iso-8859-1?Q?pvDu+TR/v/FCW4NCabN/t5C2ItQhy/YWsDVoaPPkEUSicaasOemwVFyiLK?=
 =?iso-8859-1?Q?8hNiFmKdd7LghAdVJ9aMSnDcETv3dFmdDFeLuRsv3zPQ4aNftA5+jLdRUv?=
 =?iso-8859-1?Q?HFJOK4ZQzg5a78Tzs6q2RDEwJ5Y1hYnXszanwr9IaYB69OJWa5DbR8Pogp?=
 =?iso-8859-1?Q?yO50DAp785jP2ZFfaJOuDx/EPoo9I93zT8dvrxdzsl8PxS62PXCh90YdIT?=
 =?iso-8859-1?Q?F3BxB6zdMUAhZnd1nLciSqvoICdJepOZfxfTlnYOwtjarCaqffmKcHNEqf?=
 =?iso-8859-1?Q?7EZW2VQq3H2Bp5emIErFG04NFrqLuvbr071HYDAXfvpg0qwOa8b3BaDZOa?=
 =?iso-8859-1?Q?TpHYoHYHyRPkrHhIVG5KlHGaJeUXZ6emVCV7TB6k99XrctA+XQXh7d9MY7?=
 =?iso-8859-1?Q?SRumuXjv24KqolQplX2sHNvASSVwDJIgG/e5axTjohCtYhQ3vLEKhIdBsu?=
 =?iso-8859-1?Q?uXXPnywk0agwTGX7fflSchr5rJuuExEKdGhydQQOJCnHigBNA7MEFDs26V?=
 =?iso-8859-1?Q?FcdLrzqvMbvliGyn05Ub2uRvPAB64ODiF1BJ+ApqJunmsZbXuMRiy6GfBy?=
 =?iso-8859-1?Q?tKTmKagiisTR3n5r1LKWvHUBtotmB24dl7PVe73mQS4qu4P0TzokaUuiZG?=
 =?iso-8859-1?Q?fEDzHnNRzqLml4DOe/ykKZYAzIiNAlkXk94Hl+TfABX7TAGKtRF0zkS8nr?=
 =?iso-8859-1?Q?urbQYPvOL77j13iq2I1Fi+xKPCM51s9Z3iy5zI5BMrHzWuRY2mwjHDpDg0?=
 =?iso-8859-1?Q?opsl89u8kHxRlBXTQeDj3k4bdGQ6Fu8OHxi7Q9Ope/pYXpzZA96S7Nd7rK?=
 =?iso-8859-1?Q?EniYNPfYwnDKDne/wsrkIer7sHObuTC7qB58kPD8aKzog39+JaHKUIUEqj?=
 =?iso-8859-1?Q?fUy5nLhdSnO6Pf7GUfG1hX/TRUKPUlT+aAqdqltKHvRvIFZ19yxPidFTbB?=
 =?iso-8859-1?Q?jhhNHOjipOs7SfiPdJamsOkq7z6h0geSu2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e91176b-035d-4afa-fa0d-08ddd4c35fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 08:29:34.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHDCn8BBqmD7GK0deQeZPFotUeuUCWGGddy3sRSJZNoZ6FkRFEDr2O22xL2TxzB1F+fBJE8W5hzZ/gt3jLN3ylPL9rYtQxiwRwlq2dMLvIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-Proofpoint-GUID: M-ITIJP2Gan-SD-krgPGKeJ_jXTzp3S1
X-Proofpoint-ORIG-GUID: M-ITIJP2Gan-SD-krgPGKeJ_jXTzp3S1
X-Authority-Analysis: v=2.4 cv=ZpHtK87G c=1 sm=1 tr=0 ts=68931272 cx=c_pps
 a=nbz8heNEc1OWkMMTQbiTjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=nDheTM7S33XvDziRkTYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA1MCBTYWx0ZWRfX/c0gLwCO3l1l
 VbuEuQ+WW/ih2wyeK0YLMNDtM3KpxCRNMzTIiJJXydz9cgnrqrMEgXyAm8A53gH9JzPTDpTJiP4
 OifmvSbBgfFsDfM+jr3hCRZ6Tv4NGKoISAIj3LRN9A/tgabDt+NazRI1B1INt/SCD+WjScrKnRF
 RzMlV6s5Kns0tGDYKGZpqCeOaVUasvSkmIIXIxhwUHlqoFNTsmX/HdibuY7mAqJvhBbiU19CHR+
 oOPgv4CEFzgu9k/fDgv7ZD5YQvwT2ZEnejFhFdm7n8y2aBcVXaoLer6PpcDvemoxbj1LtKnm0ev
 nOu2wao20Unus2p3K3psc5leGt0ZBd7gZp+TfM5CzkXFNClUFBej289q18g9co=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Dear netdev maintainers and community,=0A=
=0A=
I have encountered a kernel warning in the HTB scheduler (`htb_qlen_notify`=
 at `net/sched/sch_htb.c:609`) when using Open vSwitch (OVS) with a linux-h=
tb QoS configuration. The issue appears related to a recent change in `qdis=
c_tree_reduce_backlog`.=0A=
=0A=
### Environment=0A=
- Kernel version: 5.15.189-rt76-yocto-preempt-rt=0A=
- Open vSwitch version: 2.17.9=0A=
- Configuration:=0A=
  - Created a veth pair (`veth0` and `veth1`), added `veth0` to an OVS brid=
ge (`br-test`).=0A=
  - Applied QoS with linux-htb type, total max-rate=3D2Mbps, two queues (qu=
eue 0: max-rate=3D1Mbps, queue 1: max-rate=3D0.5Mbps).=0A=
  - Command sequence:=0A=
    ```bash=0A=
    ip link add veth0 type veth peer name veth1=0A=
    ip link set veth0 up=0A=
    ip link set veth1 up=0A=
    ovs-vsctl add-br br-test=0A=
    ovs-vsctl add-port br-test veth0=0A=
    ip addr add 10.0.0.1/24 dev veth1=0A=
    ovs-vsctl set port veth0 qos=3D@newqos \=0A=
    -- --id=3D@newqos create qos type=3Dlinux-htb other-config:max-rate=3D2=
000000 queues=3D0=3D@q0,1=3D@q1 \=0A=
    -- --id=3D@q0 create queue other-config:min-rate=3D800000 other-config:=
max-rate=3D1000000 \=0A=
    -- --id=3D@q1 create queue other-config:min-rate=3D400000 other-config:=
max-rate=3D500000=0A=
    =0A=
    =0A=
### Issue=0A=
After applying the QoS configuration, the following warning appears in dmes=
g:=0A=
[73591.168117] WARNING: CPU: 6 PID: 61296 at net/sched/sch_htb.c:609 htb_ql=
en_notify+0x3a/0x40 [sch_htb]=0A=
=0A=
Suspected Cause=0A=
The warning seems related to a change in qdisc_tree_reduce_backlog (/net/sc=
hed/sch_api.c)=0A=
the commit is  e269f29e9395527bc00c213c6b15da04ebb35070 (5.15)=0A=
=0A=
when I revert this commit, the warning disappeared.=0A=
=0A=
I dont know if it is a known issue or have fixing ?=0A=
=0A=
git show e269f29e9395527bc00c213c6b15da04ebb35070=0A=
commit e269f29e9395527bc00c213c6b15da04ebb35070=0A=
Author: Lion Ackermann <nnamrec@gmail.com>=0A=
Date:   Mon Jun 30 15:27:30 2025 +0200=0A=
    net/sched: Always pass notifications when child class becomes empty=0A=
    [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]=0A=
    Certain classful qdiscs may invoke their classes' dequeue handler on an=
=0A=
    enqueue operation. This may unexpectedly empty the child qdisc and thus=
=0A=
    make an in-flight class passive via qlen_notify(). Most qdiscs do not=
=0A=
    expect such behaviour at this point in time and may re-activate the=0A=
    class eventually anyways which will lead to a use-after-free.=0A=
..............=0A=
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c=0A=
index d9ce273ba43d..222921b4751f 100644=0A=
--- a/net/sched/sch_api.c=0A=
+++ b/net/sched/sch_api.c=0A=
@@ -768,15 +768,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)=
=0A=
=0A=
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)=0A=
 {=0A=
-       bool qdisc_is_offloaded =3D sch->flags & TCQ_F_OFFLOADED;=0A=
        const struct Qdisc_class_ops *cops;=0A=
        unsigned long cl;=0A=
        u32 parentid;=0A=
        bool notify;=0A=
        int drops;=0A=
=0A=
-       if (n =3D=3D 0 && len =3D=3D 0)=0A=
-               return;=0A=
        drops =3D max_t(int, n, 0);=0A=
        rcu_read_lock();=0A=
        while ((parentid =3D sch->parent)) {=0A=
@@ -785,17 +782,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int =
n, int len)=0A=
=0A=
                if (sch->flags & TCQ_F_NOPARENT)=0A=
                        break;=0A=
-               /* Notify parent qdisc only if child qdisc becomes empty.=
=0A=
-                *=0A=
-                * If child was empty even before update then backlog=0A=
-                * counter is screwed and we skip notification because=0A=
-                * parent class is already passive.=0A=
-                *=0A=
-                * If the original child was offloaded then it is allowed=
=0A=
-                * to be seem as empty, so the parent is notified anyway.=
=0A=
-                */=0A=
-               notify =3D !sch->q.qlen && !WARN_ON_ONCE(!n &&=0A=
-                                                      !qdisc_is_offloaded)=
;=0A=
+               /* Notify parent qdisc only if child qdisc becomes empty. *=
/=0A=
+               notify =3D !sch->q.qlen;=0A=
                /* TODO: perform the search on a per txq basis */=0A=
                sch =3D qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));=
=0A=
                if (sch =3D=3D NULL) {=0A=
@@ -804,6 +792,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n=
, int len)=0A=
                }=0A=
                cops =3D sch->ops->cl_ops;=0A=
                if (notify && cops->qlen_notify) {=0A=
+                       /* Note that qlen_notify must be idempotent as it m=
ay get called=0A=
+                        * multiple times.=0A=
+                        */=0A=
                        cl =3D cops->find(sch, parentid);=0A=
                        cops->qlen_notify(sch, cl);=0A=
                }=0A=
=0A=
=0A=
Thanks=0A=
Guocai=0A=

