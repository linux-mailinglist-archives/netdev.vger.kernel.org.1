Return-Path: <netdev+bounces-37814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1787B743E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5BD9928135B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDC3E48B;
	Tue,  3 Oct 2023 22:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944A224E8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:47:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89312AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:47:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4NZY004045;
	Tue, 3 Oct 2023 22:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GPKxRK5FaBiiqtfSJc0Eb6lBgJVEASBpxGh5TfAfpvI=;
 b=eSLfRXGJeJw1ReRKadj+U63xDAn49wosPY0tHxy7UWuMC6kA+zQIgg7MtCHRpAp8Tj4S
 Bo5lvTB+HXSNWoXe6OOpofN7LkNLkZZK5+NzxH7BGnor9b4h+7IR0T5bKiM/hdgtSeqo
 csJfZK6arltjIdKx0XzTERxVVq4Gi/Yw7BbuEtvKYUwncfXtfTKqU1txf/9o15IBChad
 5O10TrVNZYz2KO0dBpynNpvXHfP85EuUcNW6An0ES8+5hgyk16NQsNE8SYhe4IdgVFWc
 6bAtXdX6axK40NBPrytjsAnvlYYAPwluRXXz3/KWUVGmcvJFNwY70QVdhB8U34NFOkGa Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9udv79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Oct 2023 22:47:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393M8fA6033645;
	Tue, 3 Oct 2023 22:47:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46xbpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Oct 2023 22:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWEZChcoyeAu+HWB4hDzeRIsuc5jI2L0CMy5Gr0NPhXFll1Gx8hsyxH81nQilIkBocqUJzF8v2X26J2gcb/AVV00HdmTQG27DaX20OfJYS5qEqtfgPn7Oc9+lHBBfDedvDKOT06yWcHmzmPzieZ4BTc+QgQv0hVhSFBOVQQcQt5HTeauljeYfUNpWRyc3AOrtmoOUBUJongS/bKrf9MlNxjplf1meCAJt6RjX9qnLr6GGY9IrC6DkCO5gYKQ0QD2Kav/hhvXUyrsAMBtCuaU7qK+PXT11CLV5BfJ2gUbcdtFrrnbxg2SKi5G3GD2hh72S/CVnxeZVMPe8KqCOXQm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPKxRK5FaBiiqtfSJc0Eb6lBgJVEASBpxGh5TfAfpvI=;
 b=Ve97T833s8Sc1uyZqKVdeFso3DBDEMZssv4JPJuHftFET70sBJZhl4IVf2aGanuWSdyRo2qODZ2DlPWOyiqF0HBgjAy8KyPd6gjghPfH8FEUaB7hNicJDCZhnzHHVTzYZ3zKk823KjWTRZE061mGfESzT0wRM806YZnfQrBGB22/5UW7MkR+xfN1/kTBsMeOkbjDxdi8SAHv9V9oLHUZAP+ZtphgnkDNv82rrlnsRBb+ryXT5NYHDHublIfADYOo1Kwx4Xw8sO31nc/SjYl+X5uRUp85xNkkMeeIOoUIdNNBhJRx9iG/0STIepY2p6ICGZOEdQdbibl8oObyioOLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPKxRK5FaBiiqtfSJc0Eb6lBgJVEASBpxGh5TfAfpvI=;
 b=qvOGAGBFctXyoI4TPQaYBv+EeosxfgDTlVcx0xHTSQ1T7mD8T2T2Bnoy7+IiStoNBTIDLJxBD5YexCtwNHjNmd9SnvE9fSo8H6ZlK13aef/xNHfYsxeo70uuc1CUqPF9KYSMpAzXgB/+1VHW/VOLpn7qR8PjXtBMzNLfrMaCsm0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4854.namprd10.prod.outlook.com (2603:10b6:408:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 22:47:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 22:47:42 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: uapi-header: doesn't update header include guard macros
Thread-Topic: uapi-header: doesn't update header include guard macros
Thread-Index: AQHZ5/OMp7l6zQGDK0+DbgOoc1SNM7A4td+AgAAA1YCAABCUgA==
Date: Tue, 3 Oct 2023 22:47:42 +0000
Message-ID: <DC3E6ED5-513E-43F2-857A-95E489771D66@oracle.com>
References: <5AD3137D-F5F9-42E7-984C-4C82D2DB3C65@oracle.com>
 <20231003144513.1d6ed0e2@kernel.org> <20231003144811.2101e5d7@kernel.org>
In-Reply-To: <20231003144811.2101e5d7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4854:EE_
x-ms-office365-filtering-correlation-id: 3e4ececf-9c44-446e-3eb7-08dbc462c0e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ub3nNWD6pQIgqRQ7WDW7Q/CHdaogaHBM5YkdNhUd5Yg7UdF5nlZKM6LpZXT+LKDqdRjZQqBIwk+lKx8qM7jEuHg2bxI3D/VjVlV/k9V0MRqdaKRcD/sbZWm8BvFuY6KvsjU257eB2lqw8uv/pqbWtBiAC9S9IFL0BXnwKXUDRtPBwm95ZdOPe3nBMqLsRovcmUx9OdzOZmyAwnpoeqnTQ/XC3Dfv7nF4DUuikTIqa6TptIj2V4Edlho8gGZSJmoi1hv0SRGkG1eESiJDCcU5h4fXJNdKZygB9BTLJPr6hUxJd8aRV/8X1FXLUNyhtfDaE314EekoWLqYEInR6HtCM4WQmQunzmNlH4agOVNAjnjtffpTHGpTzwP7JaNaS1olrm+YeeOdV/lPthSeAuJokpyLvWLrrCXaAu/rJNpXol/mvsjYVZ3uD9L7gytadMhIbrgHfRVA4+oiQ+hIMKJdz7qC0GFICoyRrkYyD8QXYzcKjnWV3+9RKK5wfR3GZyIhTbxtNoXH0Vrhs/WrK3S0ec6HlipDzWERYIiK3iBcfrlqFsGezyzTdF4NFZRls+mkRh1StkyEwuBDV4nQ1tdq0w/mPx/bD3sYaRUlodE8y2qNMZ/jZlXwNSNtppAhbnqGS1v23zozOJfk6fpqFoBU/g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(5660300002)(2906002)(15650500001)(38070700005)(71200400001)(38100700002)(6512007)(6506007)(122000001)(53546011)(478600001)(86362001)(6486002)(33656002)(36756003)(26005)(8676002)(8936002)(4326008)(76116006)(66446008)(66476007)(91956017)(66946007)(6916009)(66556008)(64756008)(316002)(2616005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WzGpvWo+OE36JhI8+THNinTRV3zvLhO8aZ4pcVwDscOKvriKTeNqLyjEfV+x?=
 =?us-ascii?Q?uQJoTXYAogNlJ8Qa0k20vKtNf5dC0FBX11eZCh/clnqrv7tfNZ0qMVKzbsaq?=
 =?us-ascii?Q?SUKSWAT2CDW9ixMtJyLOGukzfRy15ZZ8uxN1C3BDkXJNnEAJyZ831UikOCt7?=
 =?us-ascii?Q?va51iEtnSJy5KHyptXfePZVVQTuCxOPQbGd3TqFHd6g+J2lMby64VD3HLZLR?=
 =?us-ascii?Q?AOQ9e3FYVNYeaoOEFJG0YIyh+XRcwRK++O8Bw2c0jV+PiVte5qtGBWtF+7kr?=
 =?us-ascii?Q?7ClQ0SCL10yfq+0qWtBvz23yJayNgr9RnhNRbCWBwIGDTfCXZA5Od18hVxY9?=
 =?us-ascii?Q?3OEo0X9C/RtsDDQPQGYsGCnn1YUQkooVvzahdzwCa9HMa8if/G4TxgoZsg8i?=
 =?us-ascii?Q?3EpJYVoeWR4Q1VT8FuJ7Ct72T/cH4gFy7vgbtbjLnjY9l+BetoVr434bdiR9?=
 =?us-ascii?Q?TZc5KmuxKeOIWOzFFVS9EqmQ36K72ELhr01vhZObXmdkIvpGxSTgNUslogGS?=
 =?us-ascii?Q?twNlRjQoWnj9snAhjMw08LNPsb6PzcfODo8dqjzEzJGdG8rjM5wrv8Zx/wz4?=
 =?us-ascii?Q?5EteBKcp/osGRZGveUj3SDup8TF46TjMYiNcLBA+VH1kJH6g/HbtS7/85IWr?=
 =?us-ascii?Q?OvaC8/s22X7NmhZGUkKH44+yC0CaZv02A2dXhklreYvGLGTSDDlcmky8FBdm?=
 =?us-ascii?Q?1WGoTCGntZYIoiLONtYyqcw9vSFIcLtdcHdlwDQrn1YgojvyxDgRv/ugutVp?=
 =?us-ascii?Q?8crpN9ZIr7Bok4PxuW81pMD3fz85UcGwJPciH9npzFnGquro4qS1KFGBXiS9?=
 =?us-ascii?Q?Hq/riPx4JotSsy1zuDOldcYn4vbFfMaQkwgGD+UV5USFmlanKa6XJkjzkjH1?=
 =?us-ascii?Q?cELPu3QOqGsPVHg2Kx+5ySWnZN5k2KYvgmPVpIY6udm+wKc6xMhFIpFKFwL2?=
 =?us-ascii?Q?N7FPOfSNrA9rCdo2FLC/KZ9RvSWpyUigUVigEfgCEep0ll5uIfJgx9ymnO48?=
 =?us-ascii?Q?MDxi48Kz3r4SWV9HD/4iPvGpa8dt2CUfmigo0IwOaOXIzEsKqi0Y19mjdqHy?=
 =?us-ascii?Q?WvauSU7S9pRfh03ayUYjdH47wXc4fPivIjOne1sLSPSCrzvVFCV4nVz45vu1?=
 =?us-ascii?Q?/+8zbuuTg/YD0UlTJiWZz0SPb+GC4RXfDbPrb2MQpRJ/ufLzxjVJIB4fvlF9?=
 =?us-ascii?Q?xbxVKWSEXpbQpKPbZi75sy9YucRogOOn2oZDT5s+IUNdeUdNWMDh0sa8kaGS?=
 =?us-ascii?Q?3Fqv8Q0xaTkmLOtcwtqu2v8mEhO5e66mNG6sx9lMs47/RCj3+rWiq+4TYLMf?=
 =?us-ascii?Q?Trg20o9rhuIfsZRVOWTlCwsaNckBT3IuEe8jes6r59+vxCw4+hRw5JE1jUAO?=
 =?us-ascii?Q?SAM783tPm0sRJfUjJlWTaNrxVhfPM+FN0l3t0BXKJZvJCXk8W2MQ8SsYNZip?=
 =?us-ascii?Q?BKFSKDhUTjfuSBUAS9ACGZ6ivz7znYspTBQbAq0aYDS38oRpN8zu2hU366K9?=
 =?us-ascii?Q?C2vWwXc0QApJC3Z0r4+Iz+hrP55OAngrfOCa8+ksEiWrepDRPgVh7wKbB3oP?=
 =?us-ascii?Q?BbIkaiXC0Fh8Xg+Gv9vk32iYv7CAPdjdCiRqgwPZopqR3cus3zxYVSX34n8e?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <268FE88290D5EC4582F390FC0DE51A87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1pCHqfwoAJndy5+Eha4uwBkkAvQs6Q3ZzsAZZI0sb1aT3CDqCrgKcEJKtmkqHzhLWy9+rOtUsf2rkAba8pyb2dyQGkmfw++i6QfiRF2inBXXPPM/BJZhQ3jy547Y0SZGR8mwcyw7xffiKFAWWqq1Lv8plHdbT1BaOeIon2jj/f4d6Lee7nYkOBxpyB6jYa5t8Li668+VDdhWAXT8vwAQB2OfxDR7MsuMeXso9/gLllaiHTutj+8KHPawXljky1Ry/7p62QIO1lCVnMXhEKQFdUiOWLjlgcAl2G0t0smJxaDODdZZ5RDEbZi23Hjs7ZtrtC1b0dzF/AVMTyyO4K3+ST+774i2tH5ynRZVrGTsdHNEXvOl9/soNyBeEzOeyNpsvS5/Qjf6An3JsVONBxXPP/QDPwXwIz8iDnYpG4os3MQq9XFF4rsXvmN6VDgjxDhcvtSH4RwLeVfLPW5ufcJGb8P2b16M2Nv5NSDFCdluMCHqIKKrWyI3LpiXtopPv5LUefZFIOyw7av8zXAmKL56Z10c008hKyC6VM8M6eAv472pncL4rMwamu+bgnHyi7M7OqkSRDcsNC+8nxN/2TQ0jXqIOOCfR3KRwqvLF1Ipu+SPwgJMp6Rv6PRkLq5BQK3Hp62Ojn9pofO1K0S9IbGHHNgxG5kawHs8fL6w/Un4nfxSy3+7od3UQMfv3GzdjYqpe6T8ESRK6srT4/TXvpqGwCl/BXpwpVncvF2Og0LunE3u8xZZzeepWaXy7ggu9UBNGku5/weGN8Ss/7ny2+mCwELaKg4UxlHyrsOEXi9EQFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4ececf-9c44-446e-3eb7-08dbc462c0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 22:47:42.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfCzXaa+w7xcOoQDq+xb4GaJVYs7alUauxYfnB0ERHoH5b2C6lKC8tGo2hkaFSgz8k9djEIP07GtVL0OPBx9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030172
X-Proofpoint-ORIG-GUID: HjL_ICFb3iEsliz7RiQP3zPUr6Me5ER8
X-Proofpoint-GUID: HjL_ICFb3iEsliz7RiQP3zPUr6Me5ER8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 3, 2023, at 5:48 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 3 Oct 2023 14:45:13 -0700 Jakub Kicinski wrote:
>> Fair point, perhaps we can do something like the patch below.
>> LMK if it's good enough.
>>=20
>> We don't have any family of this nature in the networking tree.
>> Would you need this for 6.7 i.e. the next merge window already?
>> I can put it on top of an -rc tag when applying, so you can merge..
>=20
> Sorry I had it half-committed, this should apply more cleanly:

fwiw -- Tested-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@=
oracle.com>>

I don't see any impending guard name conflicts, so merge this
whenever is convenient for you. Once this is committed, the
next time the nfsd spec changes, include/uapi/linux/nfsd_netlink.h
will get updated.


> ----->8---------
>=20
> tools: ynl-gen: use uapi header name for the header guard
>=20
> Chuck points out that we should use the uapi-header property
> when generating the guard. Otherwise we may generate the same
> guard as another file in the tree.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> tools/net/ynl/ynl-gen-c.py | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 897af958cee8..168fe612b029 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -805,6 +805,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, S=
pecOperation, SpecEnumSet, S
>             self.uapi_header =3D self.yaml['uapi-header']
>         else:
>             self.uapi_header =3D f"linux/{self.name}.h"
> +        if self.uapi_header.startswith("linux/") and self.uapi_header.en=
dswith('.h'):
> +            self.uapi_header_name =3D self.uapi_header[6:-2]
> +        else:
> +            self.uapi_header_name =3D self.name
>=20
>     def resolve(self):
>         self.resolve_up(super())
> @@ -2124,7 +2128,7 @@ _C_KW =3D {
>=20
>=20
> def render_uapi(family, cw):
> -    hdr_prot =3D f"_UAPI_LINUX_{family.name.upper()}_H"
> +    hdr_prot =3D f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
>     cw.p('#ifndef ' + hdr_prot)
>     cw.p('#define ' + hdr_prot)
>     cw.nl()
> --=20
> 2.41.0
>=20
>=20

--
Chuck Lever



