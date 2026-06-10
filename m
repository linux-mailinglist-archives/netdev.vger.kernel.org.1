Return-Path: <netdev+bounces-297630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WSd6DKtEKWphTQMAu9opvQ
	(envelope-from <netdev+bounces-297630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C76688EE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:04:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=selector1 header.b=cViDYbTg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297630-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297630-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EC1A307B4F3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819440243B;
	Wed, 10 Jun 2026 10:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0A402447;
	Wed, 10 Jun 2026 10:57:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089064; cv=fail; b=ss/6JZ5cA+kF+BJ9XbmRkijKy3UHbOcvqnsCnIJleqheuoESxgyAuJGd/F/slIrRQEnSncPESU6HxmmcISOWATq/P4X28rgnAXpzt5VAX7/UgO5OQsAyv352o1Zzd6GoAn/PQwVadDSEisSeILu8Pewi/GPukExtnizfvOG7tMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089064; c=relaxed/simple;
	bh=G0JlZeDUy53hIso0l84fcs+yjcG7Nf5TDzrIACm9GB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhpmdcJSl/okIGcMbyJLiTcexSkizHBl7sKnVyQxJgfLGG0bmz4hZFR0AK0nWc5bVOGqVUrp2KJ7JdCaskWxU9YlX5FbZOfjW4Xy8EdFHwkuUEeQEBNeIQCLENci5dSW2nSFfmHhgDWMfxOJLvtPUQGkxEGG71J7V8rzG1fbPKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=cViDYbTg; arc=fail smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7kWxD3564327;
	Wed, 10 Jun 2026 03:57:26 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqpdp18-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA/S5oYnG9DqG8AZhpon2e1bCBSmL3nE4aKedm3Ng2k451ZMexORSeXsCw3fVWNDmy+013eck2yoyNXwHb361Uprs4pHhSApznOHVTO2WbUzZHT3Rl32O3pH3nJhwQjMy/onaFq0SnsDbCzSZjgI29gIDCJBiVNRULInTWVHH2a+41m4WAs+4K9s2O9Vr/mwan9wPAzNOpNXFRj9aEasiWVpToL4j8MI9fIgjMbOBGDSra7ZoRQG2yPh4QneRlEsrI8l3886AITKpp83KtjOeytG4xNRBoNcupwsIyIY02jFbHas7BdaKBte6zf9gn2oMKLejwjsUm1TsoLZYWSBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fNplW/+AZtpxvgmE6OfC6Ka7ftTZJFCR5Zh5bjkoRw=;
 b=WlVzrmvLKKhVxRLbFLiXRdQdx9i4Drm7zl3WGpr8FwSNxR5yQTLZ/mb5Kn8lPDj4FpPo+us06MSQrku7t5Bq/ILnxhuleV+ktceTETttn5V5zoI0zLfZdtmYog9iA1FHzUbfe+FlBD2d2AQLVYkD7gvvCQ+V/gIMSn3Pj/oQC6oCw2+//sypcgItEllpWsvd0rZLHxnp+goJOOrR7nLIrM5IkPNiZw0+NiYYSAV3/WpwIVOsb6selE32haB0T4pardDAZdu/u9pUVseLHfyDNOgAKhDhpVLObX0Wa5uEFGSg3b0AiuQEY4am9IAJ8Ah8iZf+Pngyjlgx3Bd+Jmwbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fNplW/+AZtpxvgmE6OfC6Ka7ftTZJFCR5Zh5bjkoRw=;
 b=cViDYbTghbR9VOXjBxZt4N40qVYG2AfmlaMFlxFj+Qxz2fVOohOjWoiQ5SKXVBVNoKN9/CyceMIyLRb8JQ9SAPztE0xXEMOelENMFrSYPuc1xXV5/WEJavBnYduEigbEL+kjn750SYd2eSewpq8OGdkumC7wrekm/InOfA2/faw=
Received: from CO1PR18MB4603.namprd18.prod.outlook.com (2603:10b6:303:e2::19)
 by IA6PR18MB041337.namprd18.prod.outlook.com (2603:10b6:208:5eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 10:57:24 +0000
Received: from CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35]) by CO1PR18MB4603.namprd18.prod.outlook.com
 ([fe80::cb22:ffae:1f3a:af35%2]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 10:57:24 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 6/12] net: atlantic: fix AQC113
 HW init: ART, L2 filter slot, MAC address
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 6/12] net: atlantic: fix
 AQC113 HW init: ART, L2 filter slot, MAC address
Thread-Index: AQHc8peQWpQ+eSycgkCGGNSZs6WmarYvQ5uAgAbHdoA=
Date: Wed, 10 Jun 2026 10:57:23 +0000
Message-ID:
 <CO1PR18MB46039B05BE8B6821167B7EA8BA1A2@CO1PR18MB4603.namprd18.prod.outlook.com>
References: <20260602135452.516-7-sukhdeeps@marvell.com>
 <20260605023831.3629095-1-kuba@kernel.org>
In-Reply-To: <20260605023831.3629095-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4603:EE_|IA6PR18MB041337:EE_
x-ms-office365-filtering-correlation-id: bef3a5b1-b5bb-4a00-55b4-08dec6df0d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 R70wYTcYJL+LNMOXEBP3JroJJhRspxzL92bhjxl3Z7KvAiOp+QS+Si0/UL5plVxSNEsTkDEbp3adL8/gv7apaGLrQI2GXRGfN4AJ59K+jVzhiHm9tjgTKWpoDXA/2gNt513v+WAW+8z+VeKVhTIUZRAh4A31K2dJj8h0iue82H6W/RPjg3ATFV9JBTERTg0TBpnhqhoI6tg9LYm1mNusaw6rztu445ZPEw3+eMI/YRjnFVoh+5a9x3/y9zzyehKA68RlvVpc8H0Dh7E5j6bWxp6TGYnADB+cjG9ZOW+YfmZ9qXW4zpPh2Wg3SBlmYgIc4ENFGFmXEXUgXvDRBdXqz0Y0b+HDjvQ1uDpJmcWagcHbiadfY5LwqKBvdjUzqj6UALDpCIvF7dvQQF1N3QQc0NWfgPEG0eLsasNjwT9G0YybErf2wf/okcLbWHM/iMWGNnvXhMA2VDRACdq73kzZzjlYIZ/llnSj0CixE2Zhzwg4NLg3j1ad1bmYumhiECCC/0lHU///H/D18YfKTg25bDSH8DW36v8/7jyLBeZmU3k9vWFZeW6eeDqeLpOcnq9HczBiMkPsGKyt75wyIDPI72S9vQsHdzViKPSSCChTfy1b4N/6TUreTa9J8jfqE5Y3Ux6eMJDNXMyW+h3AaPa94W/lNbvSnYGav8GsvqNRRsyuvGdPk8WfeLx7JqeTDUpKMWuxI+wa8+SOJkUFzOiOwGfRm9OzvV9G0PfgOx6j84jZNX1/VwD7YiIeSy64oYq6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4603.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3UbVSsE3xZuiZxyeG1Z63d4HiRFunSXyK+oQtNpskqZI7vwQ7H2xFREAJX+u?=
 =?us-ascii?Q?68FmyBPLao+RZumT3Jx26TmgpxKxj/QZA+szX0K0qjpYBPQGoU4baVcpJJcM?=
 =?us-ascii?Q?SQmAAqCodCi9g6s1BYLRGBg45BZSkrr27yorjMUabWFoEo+f91rat4QqxGXl?=
 =?us-ascii?Q?6ZcvXhNaYfSaexOWk22kHiz+nGaUBtYCD0fYIwV8OGpRrfct8ubSmZMlGvBm?=
 =?us-ascii?Q?LNz6C6xTblqU6sq7uVEWujdpisL7tUP5aGz1yP+SGyNQvSH2q1tPvx7hGlmr?=
 =?us-ascii?Q?kBExte+yKWbn6crpi4r1ulKJSi3WTEtXRAH12AsJbEQmGWD/MHRfx0EpieYH?=
 =?us-ascii?Q?ReOSqNNmueljh2XUSgsyeSZfmFzWD6nHN+TDrtdbw/tZlsX4YOzAeJE5qdSX?=
 =?us-ascii?Q?jabR7JBQ34ZIbbk9zupkyayKnLvap2+obz3VHw2LQ8Iweq0clUnKnSWEvNWp?=
 =?us-ascii?Q?IipaQIumYQa0i8IB2hXudK9deouNHDV2tkaXyjzuh0yL0TSb7ldPqW80MU2u?=
 =?us-ascii?Q?gMfWZwsAQiElXGMGv/8vDxZRfk3uCb1OEnVFeWLQ/CtuVEhoE2lplPhwXvKq?=
 =?us-ascii?Q?W+c5OwIe1b+ksy6Cc1eJxyC8505KjU81Ow+QlweEG7/bZ9VhBIj1028gfDoP?=
 =?us-ascii?Q?Hu8bquFQzmoPr0dxpqttS2AqbnWu1t1RLkV1N61Nm/wOJbyaFRMAbWmcCEy+?=
 =?us-ascii?Q?A8vzmbX5R3NUy3OGvJC7YdzYAbUAKW+nwjJwAG3lvOEadDwJTWpLAOKni2sf?=
 =?us-ascii?Q?Wapry+xsWnVz1SzrOfLuWGPOcllYGuGqt/0n/y95D4LWYQBZBd068dkUn6DK?=
 =?us-ascii?Q?KwuDNrd031e3dZ5ICObgVkFMX1e0MUvuLgKX1q5/9H2INW2txwDbotVzjY2X?=
 =?us-ascii?Q?Jm4J5kWUJ/7sLRlZO6ptWSAMhH9WD9ZYs8mh1BZe6TFXfA4jzS5g2XK2US6N?=
 =?us-ascii?Q?HsDgIHS1qmkizJazJhkPm3oAt5MAN8jGYUjUV+xj/4alced35NTm9WmL3rO+?=
 =?us-ascii?Q?vTKJGdvqs2JJTi5EgGCuykx7hdx3hLHrkh1nObSinJPxxaOx2yvhDTsYJxOO?=
 =?us-ascii?Q?SmfAO+pDOuxNerLdT8wp1LQRQlXF7Gvp06E2Sd3L8tccZvRomrPaiKLn6BgY?=
 =?us-ascii?Q?7cqp1Bgh++kikyJxxiZlddq9gk8IJh8uqoSPNaCE4/pPZuZC1WZnP/h3BPU/?=
 =?us-ascii?Q?1YQ4x8Q99sU9x6/k4b/tRhStx8G2ubLAQF7PcAkbVRQVrRlExm0tZBz4EI+W?=
 =?us-ascii?Q?1cjzfXLHLWU9ijl5QxwZ+GlHMfqYQg8HOq8AmfvbcgFo1xppsmTbJE87A2PM?=
 =?us-ascii?Q?afgRSguxmdzSwN7eY6kNLFvAWN5bKt74EK2mMjVeyrxQdQYKOHC+boFKAhgc?=
 =?us-ascii?Q?FihvMLuNc6DH0HIugKHihuq+GkO4zLWulMR2DB/Y9Y/ik5HhAP6/mQy+GQZE?=
 =?us-ascii?Q?WtZTjZ960YByFem/ORThfV/oTBQlm1wESSM1sSX7zjNx+bFi66/KTcq7ShQB?=
 =?us-ascii?Q?o+kucq1YWF6cFzoQycPSrKIbFRJjareZsQf4ec+vdF//wZMtp3bYxZcaRWqL?=
 =?us-ascii?Q?9qhjC7sq3fU7DtqVdWhaLIb3KOujK3NdFeqr8lXN332hzlXdMVaY1ssnNKlY?=
 =?us-ascii?Q?g9yg5A3HHnaIml84f73Fq6lvoxKuyLS/2Vbim/nC4+antpZ5h4ruw+gXpYlY?=
 =?us-ascii?Q?6/esq3QVBxlRlkJ8Dbp1DJBvwatPD+zRBH/zNxijWjrNIC7z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eir095IemLcbzdp0ivAGRMWP1I4h6h8Od7hnjnuQ7f32qHx0w2fZLUgrJn69c6AtkZMZcvIGeCAf8Oy+Ki8XlLF78uUsaNymgHEtWDveRn40Wf3qMNwHVuFUOSeYMkQUA8KWG+twmptBrwntyjvoJuzyyZMaCr9b7YSs93sZWYOT4g+qEYCWXxA4l5/ZqHymzueK7XRuQMWf76OQROqQsWALBH9M9Nru5CRTzRiTDY9n5Bc9sKjfKgMUZUKKTw+KAKS6mJ2e1NCuEKa4uio6zqQVvm4/RjkqtduWhxPzA/zZEXm2zUugfIFDuNsd/o4v8BT/SNkzlXw2UqbecT/ITg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4603.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef3a5b1-b5bb-4a00-55b4-08dec6df0d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:57:23.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GcyEevyOvPC9koJ8L7iv+SVRt1PfNKAqrHKZ1oFMlHkm2np1WNeQSUegVw+FQN1nNbbPgROEsfEk+O5Vfzvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR18MB041337
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNCBTYWx0ZWRfXxz0oHaEgqtE5
 Z04VaOBP0+c+nRI+YR4TvP9nSN/MVbY4yzgi2XfXI5TMM+9k1cFQPi8VI4/PhZjt8fgMvK2c6yB
 9B1HVJdq6CQw0lBQZ+Sy+T97HT5R3UB8nqjXS4uT5MoSiy7aNdMrUIIScl9NOvn6QaABWKbc+7E
 rez/qXHmtTNXgqHpcbQXxwONcAc3P2eJxMrItHnDyINebBc/KBFARypneE7htYPkKMA+MMuBzw2
 KefzxJpV6YHC5WpPepoLCta9bodUN/MQqvVVQKe+IzN4c62NDCQ/f5nu1e/vj7sKV/Nfs2oGI/d
 l88ZgsRDCmAK7vY23wI8IFVIAkIN/XJCaJycjhY7f+vsdlPY5mmd3o4n4UynzyLoctw1qxIJhKp
 CHloRvdgMMQT35NSinVeyWNH4AFdlUqKAqytQE1nMpITaMSdOubKOOdA38yl/NitUJjnGp6eHhZ
 UDjWDH80Z9AKa20/kww==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a294315 cx=c_pps
 a=S0nsQJN0x0NZxitFF6bqdA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=m_A1PZZpFIdZS4kjFE8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Vg3b_1KjTGhe-9VTMQ2urLVZvHGbFgsg
X-Proofpoint-ORIG-GUID: Vg3b_1KjTGhe-9VTMQ2urLVZvHGbFgsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297630-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,CO1PR18MB4603.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B91C76688EE

On 4 Jun 2026, Jakub Kicinski wrote:

> net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
>
> This patch updates hw_atl2 init to use firmware-reported ART and L2
> filter base indices for AQC113, adds hw_atl2_hw_mac_addr_set() that
> programs the MAC into the firmware-assigned L2 filter slot, and wires
> .hw_get_regs into hw_atl2_ops.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/d=
rivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index 0ce9caae8799..27a62fffbc29 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
>
> [ ... ]
>
> @@ -484,6 +508,7 @@ static int hw_atl2_act_rslvr_table_set(struct aq_hw_s=
 *self, u8 location,
>  static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>  {
>  	struct aq_nic_cfg_s *cfg =3D self->aq_nic_cfg;
> +	struct hw_atl2_priv *priv =3D self->priv;
>  	int i;
> =20
>  	/* Rx TC/RSS number config */
> @@ -499,7 +524,9 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *se=
lf)
> =20
>  	/* Multicast filters */
>  	for (i =3D HW_ATL2_MAC_MAX; i--;) {
> -		hw_atl_rpfl2_uc_flr_en_set(self, (i =3D=3D 0U) ? 1U : 0U, i);
> +		hw_atl_rpfl2_uc_flr_en_set(self,
> +					   (i =3D=3D priv->l2_filters_base_index) ?
> +					   1U : 0U, i);
>  		hw_atl_rpfl2unicast_flr_act_set(self, 1U, i);
>  	}
>
> [High]
>
> Can the multicast list handler now collide with the UC MAC slot?
>
> After this patch, the host MAC is programmed at slot
> priv->l2_filters_base_index (firmware-supplied, clamped by the new check
> in hw_atl2_utils_get_filter_caps() to the range [0, HW_ATL2_MAC_MAX-1]
> i.e. [0, 37]).  However, hw_atl2_hw_multicast_list_set() still iterates
> multicast entries into slots HW_ATL2_MAC_MIN + i (i.e. starting at slot
> 1):
>
>  for (cfg->mc_list_count =3D 0U;
>       cfg->mc_list_count < count;
>       ++cfg->mc_list_count) {
>      u32 i =3D cfg->mc_list_count;
>      ...
>      hw_atl_rpfl2_uc_flr_en_set(self, 0U, HW_ATL2_MAC_MIN + i);
>      hw_atl_rpfl2unicast_dest_addresslsw_set(self, l,
>                                              HW_ATL2_MAC_MIN + i);
>      hw_atl_rpfl2unicast_dest_addressmsw_set(self, h,
>                                              HW_ATL2_MAC_MIN + i);
>      hw_atl2_rpfl2_uc_flr_tag_set(self, 1, HW_ATL2_MAC_MIN + i);
>      hw_atl_rpfl2_uc_flr_en_set(self, (cfg->is_mc_list_enabled),
>                                 HW_ATL2_MAC_MIN + i);
>  }
>
> If the firmware reports any value N in [1, 37] for
> l2_filters_base_index (which is the case the patch is intended to
> support, since for N=3D0 the change vs. the old hardcoded HW_ATL2_MAC_UC=
=3D0
> is a no-op) and the multicast list contains at least N entries, the
> iteration with i =3D N - 1 writes to slot HW_ATL2_MAC_MIN + (N - 1) =3D N=
,
> which is the UC MAC filter slot.
>
> Wouldn't routine ndo_set_rx_mode invocations (for example IGMP/MLD
> group joins or link state changes) then silently overwrite the host
> MAC's UC filter with a multicast address, causing the NIC to stop
> accepting unicast frames for the host?
>
> Should hw_atl2_hw_multicast_list_set() also be updated to skip or
> offset around priv->l2_filters_base_index, in the same way
> hw_atl2_hw_init_rx_path() and hw_atl2_hw_mac_addr_set() were?

The collision you describe will be handled in v5. hw_atl2_hw_multicast_list=
_set()
introduces base_location =3D priv->l2_filters_base_index + 1 and replaces a=
ll
HW_ATL2_MAC_MIN + i slot references with base_location + i, placing multica=
st entries
immediately after the UC MAC slot. So if firmware reports l2_filters_base_i=
ndex =3D N,
the UC MAC occupies slot N and multicast entries start at slot N+1 - no col=
lision is possible.


