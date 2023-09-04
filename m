Return-Path: <netdev+bounces-31949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9817791A5C
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35989281016
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79172C144;
	Mon,  4 Sep 2023 15:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFE3C20
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 15:13:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F20BD
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:13:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384Aow5H026785;
	Mon, 4 Sep 2023 15:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aUCXAKHNw3Yzb5rXZt/s+jf63lB7NvhuYz8/bpoL2KU=;
 b=UYjpqXCKxXqeduB36rnuESCk7O3nDy4iBUnZfO8/uVogNBdMrYZWAFFmD3HEE/K6hyWX
 chh3w7h49Di05vD+Z1rruFt/kmWZiSKjKobRd9CuPWeTFTwsCtFKLNyJBrTzcfDsbbxZ
 Q3srX1Rr3lDInl4d3WUeI6bQ766XLoHQK18Y7taqDBecWf6QStdjZSRjLzUWumCOjImQ
 mUzAubocGAcpT9M4btnxMZ3snLk/l5rXlN/HO1JLvKv7lkLOHQmL6dCtEtMCZFmrA9qK
 YPVFyVqmp/UUeWZQGqQit/e7tyABuFlJm8plGGaV1MEH7UFkBWDKVQ4mNpMUzsal0fOL XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suvxakenk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Sep 2023 15:13:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 384Ex29T029162;
	Mon, 4 Sep 2023 15:13:27 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug3sdw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Sep 2023 15:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfbVYgKJqkEuquSclxCQ4zrRMnobI+x9BRanvXOGXvnF5tmwZ61hQZMFr7pCwA6Q3cwRSvnHG8YRlEKwvMlrT4hgNR1XqSYEvvX0b9/98pdq7JtVti13XiJRNWm3jXLD0Ngi5vTMNqwsV2nkqe/WrlTFKXRt999ltTcLYIGP1BL1LDmnhVDkYj+4EKgBYKva0A7oPYcmKoYucSNSybimSvfTwqzK30jXFQz92t/3ciLm0aW9aogczppA0KLS30oziTdz6vR3/QKmZN/6Fsxyn18rw+SkNiZdT5QKrLM9XxZ+WcwhOjrwM1C6c0CGJG/wfYjY1eYqLHqztFsz7E9LwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUCXAKHNw3Yzb5rXZt/s+jf63lB7NvhuYz8/bpoL2KU=;
 b=J3bX4IQyN0aouyu90Y1WJR4mN2OBIp/rbSDXw49iv/WO9PqmV29PpiFAQKo9EywFsiwWODEfrEpLOLFZsc1+uRh9omIdSQNUwV83vEVwmD+eZf5rzBGzlJXTd1m8n0H3Y7BvR0A7vKeVx8buQe2nrP8eLeOrV4ttxGuewOhO84jife1vOAt8KcM7mnx9S6gE26HslBRt/P26yMeBhmzNgHf0giu2reBalgKAAfEFbzcY03y4IbrI5iBKaI2cPqsJ6DreAhabcftjSguGM5ypUYOMMjRJrSU4PDAk4k11W3Go3nm7+sIqYjHAXXOv8OicHY7QmFY34ZWck1y4h4RqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUCXAKHNw3Yzb5rXZt/s+jf63lB7NvhuYz8/bpoL2KU=;
 b=gyvz9k2u4D2Rwh9GOihU34r78e+Q7xA1KGtzAazwdn0OV3YH9giJDJxz8TxrSLW/TTdwgID2ntutGJeGX5WmPPAOWn9l98HeAS3z0NAkPUuS6m+QHJQzPgWKM1BigPv7KHYIZ75NvgzLZijMi7mAZKGaALjOXf33/JW8ReB5Lt4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7857.namprd10.prod.outlook.com (2603:10b6:a03:56f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 15:13:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:13:25 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?TW9yaXR6IFdhbnplbmLDtmNr?= <moritz.wanzenboeck@linbit.com>
CC: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        "open
 list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: low pending handshake limit
Thread-Topic: low pending handshake limit
Thread-Index: AQHZ3yzylkMTSfpik0OmWz5F7eKIqLAKxk2A
Date: Mon, 4 Sep 2023 15:13:25 +0000
Message-ID: <90B2279F-F69B-43D2-B809-006519825D62@oracle.com>
References: <IIOG0S.DV0B3MDEVDQF1@linbit.com>
In-Reply-To: <IIOG0S.DV0B3MDEVDQF1@linbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7857:EE_
x-ms-office365-filtering-correlation-id: 213821d8-6995-4b77-cd1b-08dbad597c7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ChqfF+79HEQSdCXZdiGzHhoTezQKT1Ox+eQKkV9KEBOtQgzvWW3W8f6DOjJvN9re5/OOPxTDscF/B3FB3jAAzDNTw5Vxm3F4ANtO9aNPY/rE1V9WqkMwzaEYqLisq+E/A5x9QZNoN2QOu9iC1vZ9V0mtx/DmbJHRrbTqbNeC3VZkKl2V7ZziSo+X5vZBTu+oUNiB3Jd4gEihdLJ9FqWBlzVr819ltwiDKinnceJBSZptIcEr8gfwEM0yhE9MsRnSNRA2Dj++lhmLhusBL4Gcj9JHycBqvpbHNniH9BN0LtEpH6I+xm21lofV0I2R171fz+JWR4GKfFaB6yn6WCZeDNu1O6uhbnEZBORNj+olNeIQjWPfB1V4veuu5hP0MEJbWkfsUeOUMtVz+zlW/jRRB83XsFXOm5mzDjsXWQGHetVxYncH6kIFMcIqPAjKnKFbN4ow/kd8QS7s/U639iPW21gpKUEQ+19pbQYj7wfrivb0xIWP8ED/JDPa8fnzp/xeoDvlX+YrYVy4rsRlT14tnnjui7I+Ywq6xjX5eVvuyA0t6ec87nlgXsERfRUeg6MVEXuW+3NN/lCppRS2WmlAdJ8IiVHXgFTIuSmuxFAJYYWXNy+9I3W5XeY7P/T71Jon4ScL3I3uh9C/dkxn91bsLw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199024)(186009)(1800799009)(3480700007)(122000001)(38100700002)(33656002)(38070700005)(83380400001)(41300700001)(5660300002)(36756003)(86362001)(66574015)(66476007)(66556008)(66446008)(76116006)(66946007)(26005)(64756008)(478600001)(2616005)(91956017)(71200400001)(8676002)(8936002)(53546011)(4326008)(6916009)(316002)(6512007)(54906003)(2906002)(6506007)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a3ZUMFdBK0RkWjNXRDFVT3UzSW5SYXZQZFF3NGNLUlVqdW1xeWw4ZFRVZnNE?=
 =?utf-8?B?RWJoMDE5aVRhZzgxY2FidjVEUzJtSlFpTTlYVUsrd1dYdllFZm9IVXA3a0d5?=
 =?utf-8?B?ZE1uRHpIdFM2Um14bXBGWHZJWkVxRUs4RGs1T0tmWHFzeXZma2hKaEhET3dr?=
 =?utf-8?B?dktPcWJvOHdZai96L1F5bDNRbk5aNEVLVDNFM2lSMU5wZ3FVci9YQWJudWZ0?=
 =?utf-8?B?RUNqZUt3YkRHTjBUVno4SUpmS3gxWUM1d012MmRyRWNCdVFxdmM1cXVxd0dv?=
 =?utf-8?B?WEhsYkRQaTdLeUlmeDdHOHNZL2luNEg3Y0lEc1hDZVB6Y0hqMk5sc0xKKzZt?=
 =?utf-8?B?Z243NkJ4czNNeTd0UktQK21TcHlNRjcraW9la2M0UW8zYjlMTEg5Rmp6anVH?=
 =?utf-8?B?RlYvL2RIRVA5dXRVbEFzcE1HTnV5NUViU0VYNXU4L2o1NHJzQ0o1U3RPeUcx?=
 =?utf-8?B?U29UazNOek5HaUNaODJHdnJwOVJsUklyekk4Umh5V05DeW1HNklyWGNkMTFW?=
 =?utf-8?B?VTQ3bnJtb0J1N2NGLzBRbXgvd0l5bGZSQ0RpV3J1Y3p2OXI1ZXNTVko2TGZO?=
 =?utf-8?B?bDlDOWlBMXZvS1djWlJ2WHM3UzRQVGNXWEErRlBnWGZDVzJTNytkZEpNTFVa?=
 =?utf-8?B?S3BmUk1nZEpaMHRHWVQ1czZibHl3VHpMK01TSkQ1b0puN3FHeDFmalloQWQ0?=
 =?utf-8?B?RldpT0hpdnd0dzBWTldZRjQrbVpoUjZSRGdXaWVoajFJWjZpczlGVUk4aGRE?=
 =?utf-8?B?c01aUVJUWE9IT0lMYXZmYlNuY1ZBYzJreFpGVUJVUTF5T2NKMStLRklFNGto?=
 =?utf-8?B?SzE4bmxVRXZuMXNWazlLd29WWCtwMUZuOFhvbmExejZueG94RjMxU1NFMVBv?=
 =?utf-8?B?bko3TkVOczRBVHNHS2xXaEZpVGlTeWV4eEpzbFd2MlhPQWdBZFZqcnUxaEpy?=
 =?utf-8?B?TkVFZHBYMkp5b0JMNHFQOENaSnNUS00rWVVENk5XQ1VFTG5URkZXc2MrZ2k1?=
 =?utf-8?B?ZnpyV1VCNDdFRHdDbyttLytDdGE0Szc4RS9mUnlpRUFUdVgxbldCSXN1Rmc4?=
 =?utf-8?B?d1QvUjhVNU5FQjArNDhqNU9mMnZJVWg5NWlnZHZtVStVV0ZIc3RSaVhWeWh2?=
 =?utf-8?B?QkRyWFVXUjJwUkozV09lOU92aHB2MEprSVBNTW5DdlJFcGJvUGpFVThLemZL?=
 =?utf-8?B?SFNQWUNUK1ZFcWlpWjFsTU9vcFAzbGJuYWRHRjJKdGhLZ2lUM3NSMzcwdjRt?=
 =?utf-8?B?VGIrc0lWWDAzYXBrb0R2b1hCUWRGN1BoRDkvNjVVZEtyWE03SXMycWp4WENR?=
 =?utf-8?B?OHV6Y1drVDQ1eW8wUzhMNFR4THdNdjN0dmFTVUtSS3hNcE5uZXlHZWpmU1dP?=
 =?utf-8?B?V3B5aXRzNUorSURNWUVKV2h0dzFWWThFL0NGR0RRazRJMjZCWThGdlozcnBG?=
 =?utf-8?B?TjFjZzd2V2FzamtSL2NxUGoxN2VNUkE5MU9WRjZDOHhRL0V2RDFhL2lVMlRC?=
 =?utf-8?B?YVZqRytRVlMyZGtJaFZOUk45ZFFoTFdCOWRMSUNxRlhaK2ZuRmhFdUtzWkdH?=
 =?utf-8?B?Rk9uanN1czNDLzFreVFoeGIxWXVxQVRtVFZLeTFmTnY3bkJEUTlxdmRXQ0Vj?=
 =?utf-8?B?R1J5dklNOFhhVmVYQXNyMlVYVlh5UmdVNW85dlRaTFIyM2JMYmhtS2luVHgz?=
 =?utf-8?B?TTFuL284NTNsUTA3SGMyYjFZanhXYXdzZm41N1h0U3h2MEhYZGpiSDU1SHFQ?=
 =?utf-8?B?MmVmY2U4SDFvd2JRaFVNU0NRUVNtdm1FWnFNSUxQWnBEN250YjdzbnBQYjky?=
 =?utf-8?B?eHRmbC9BRlBhbHZBN0VzM0pYUENaejZ1Y3F3WWJVMHVkUmk3N25nU3VSYlR0?=
 =?utf-8?B?Tk5RejhWTTEwdzJ0cnVCcWR4TVRRZFpzdXcyTlNmMzg2QWlLb2M2c3hDd2Rr?=
 =?utf-8?B?NDFXVjg1YjE4ZUZMWDY4ck4wZUJ0MGs3bDAySnRqcWVZUTFBN1FiVzRCQXBT?=
 =?utf-8?B?QUFiYmlRQXAvTzQwZGRIbmFZRzNJRHFNbS9pdWx6MzkvakJTdnU2VXlZL2lD?=
 =?utf-8?B?OWtZRTNOZjh6ZklTWmcrN3o4Wko0Sjd0V2RyQ3VYblY5NnpEak9aeXlOa1Rt?=
 =?utf-8?B?Y0Z5SkpuNTVHcGhCeTJSR2JyUm1PMTltNjB6SkgvSW5GYzdVK3J2SUxoNm9n?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2301E87ED4E2674289AFC0D3C042C40B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T6v5S5OGwq0QQlA1p6maOZD1VE3fFSptOwbc0PJ+AcxY7Z/NJ59KXaPBE57W+khd0YrQbP+KJuP+AldpYGMDgmPRfEtThL659RLI9bEjZrU3XA6JulBmLmlzpRA/YGOgMRhQiznGjMyepMk9IVofmlTQRE01FPYD+HL+/Wku/oHItebfRMo78nempoA4f8xZ4U9LmI9zx3Ub6DbHvfKd9oURSBoHWiVvXay7rALSWVTfCsr08G1vXYbyaJmrpvfVljg7PRh1EoZR5+j6VSYtbvjxgTcx37yWq8jiZh6avKkx/o8uiYvOEP+A7bzZXJSO6Lxim8fkJnLQqg622FfEc2KqszgwP5bAt0U9q/OuEXMyHuZ9kq5sV0MyjcpEYAjIZLVquSYkgxUiAvELmDJ0YXVAR49Ktr8TR0sJhJ14zS/PyHkezMnpsWa/dBC4LPxCB0osyQLlwV0nyrelWrtCeluoyKFhFD8TsVg4FRdF1LhmnD8xumW+P63UTAF8MFBlLxWyepWijDX2D86mas102WektFShvjqXebhTsgNtHWO/yXjtsRS+thQo7jWqN+NAUyQ8BcLYNyfGXDjaLIvQC/z/uqlaGYzdxKj6DXJRuBZgf7c89vB9aD2pTHN8nBpOoe4VNWR5c7V24Y25G8Hl6Z4oiaLzsxsEsAeAInpH+CCPLgnGlZbN+C/t+VmEoj6R0DpWAMIquR7mEu3R4bcLKiUvPcBScImnKttZCOf2uuBF5KNf7qdFEPnTy60AGkTOp3KYJPv+jWJpovjPUFoHPl+lp4bKfO9wT3h3O8HOaBc9l0JSfLbH95y8wAivG8xZPAhgu38MdNQrZ8Hiw6qsiepEO40UGHsW38k40t713So=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213821d8-6995-4b77-cd1b-08dbad597c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 15:13:25.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyNGkCJyKo4e/tBMRe7JeKKFMdbDi7mOc1HzvNhO0RZvchYOQq6ZN4OTUbZC0RGLepPFDHFjY11XBrDDkmZ6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040136
X-Proofpoint-GUID: 3PVicIinmvKwvCNGf0XHgNDo8kZUeul9
X-Proofpoint-ORIG-GUID: 3PVicIinmvKwvCNGf0XHgNDo8kZUeul9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGktDQoNCj4gT24gU2VwIDQsIDIwMjMsIGF0IDg6MzkgQU0sIE1vcml0eiBXYW56ZW5iw7ZjayA8
bW9yaXR6LndhbnplbmJvZWNrQGxpbmJpdC5jb20+IHdyb3RlOg0KPiANCj4gSGkgYWxsLA0KPiAN
Cj4gSSdtIGN1cnJlbnRseSB3b3JraW5nIG9uIGVuYWJsaW5nIFRMUyBzdXBwb3J0IGZvciBEUkJE
LCBzbyBJJ20gdmVyeSBrZWVuIHRvIHVzZSB0aGUgaGFuZHNoYWtlIGluZnJhc3RydWN0dXJlLg0K
DQpJJ20gaGFwcHkgdG8gc2VlIHRoZSBoYW5kc2hha2UgaW5mcmFzdHJ1Y3R1cmUgZ2V0IG1vcmUg
dXNhZ2UuDQoNCg0KPiBEdXJpbmcgdGVzdGluZyBJIG5vdGljZWQgdGhhdCB0aGUgYWxsb3dlZCBu
dW1iZXIgb2YgcGVuZGluZyBoYW5kc2hha2VzIGlzIHF1aXRlIGxvdy4gVGhpcyBzZWVtcyB0byBz
dGVtIGZyb20gdGhlIGZvbGxvd2luZyBjYWxjdWxhdGlvbjoNCj4gDQo+IC8qDQo+ICogQXJiaXRy
YXJ5IGxpbWl0IHRvIHByZXZlbnQgaGFuZHNoYWtlcyB0aGF0IGRvIG5vdCBtYWtlDQo+ICogcHJv
Z3Jlc3MgZnJvbSBjbG9nZ2luZyB1cCB0aGUgc3lzdGVtLiBUaGUgY2FwIHNjYWxlcyB1cA0KPiAq
IHdpdGggdGhlIGFtb3VudCBvZiBwaHlzaWNhbCBtZW1vcnkgb24gdGhlIHN5c3RlbS4NCj4gKi8N
Cj4gc2lfbWVtaW5mbygmc2kpOw0KPiB0bXAgPSBzaS50b3RhbHJhbSAvICgyNSAqIHNpLm1lbV91
bml0KTsNCj4gaG4tPmhuX3BlbmRpbmdfbWF4ID0gY2xhbXAodG1wLCAzVUwsIDUwVUwpOw0KPiAN
Cj4gV2hpY2gsIGZvciB0aGUgdHlwaWNhbCBWTXMgSSB1c2UgZm9yIHRlc3RpbmcgKDFHaSBSQU0p
LCBlbmRzIHVwIGJlaW5nIGp1c3QgMyBoYW5kc2hha2VzLiBUaGUgbGltaXRzIGluIGdlbmVyYWwg
c2VlbSB0b28gbG93IGFsc28gaW4gdGhlIGJlc3QgY2FzZS4gSWYgYSBub2RlIGp1c3QgYm9vdGVk
LCBhbmQgd291bGQgc3RhcnQgY29ubmVjdGluZyB0byBhbGwgY29uZmlndXJlZCBEUkJEIGRldmlj
ZXMsIHdlIGNvdWxkIGVhc2lseSBoaXQgZXZlbiB0aGUgdXBwZXIgbGltaXQgb2YgNTAuDQo+IA0K
PiBBbHNvIHRoZSBjYWxjdWxhdGlvbiB1c2VkIGRvZXNuJ3Qgc2VlbSB0byBtYWtlIHRvbyBtdWNo
IHNlbnNlIHRvIG1lLiBJdCBhbGxvd3MgbW9yZSBoYW5kc2hha2VzIHdoZW4gdXNpbmcgYSBzbWFs
bGVyIHBhZ2Ugc2l6ZT8NCj4gDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGluY3JlYXNlIHRo
ZSBudW1iZXIgb2YgcGVuZGluZyBoYW5kc2hha2VzPw0KDQpJSVJDIEkgYWRkZWQgdGhlIGR5bmFt
aWMgY29tcHV0YXRpb24gaW4gcmVzcG9uc2UgdG8gYSByZXZpZXcNCmNvbW1lbnQgZnJvbSBQYW9s
byAoY2MnZCkuIEkgdGhpbmsgdGhlIGxpbWl0IHZhbHVlcyBhcmUgYXJiaXRyYXJ5LA0Kd2UganVz
dCB3YW50IGEgc2Vuc2libGUgY2FwIG9uIHRoZSBudW1iZXIgb2YgcGVuZGluZyBoYW5kc2hha2Vz
LA0KYW5kIG9uIHNtYWxsZXIgc3lzdGVtcywgdGhhdCBsaW1pdCBzaG91bGQgYmUgYSBzbWFsbGVy
IHZhbHVlLg0KDQpJdCdzIHRydWUgdGhhdCBhIGhhbmRzaGFrZSBjYW4gZmFpbCBpZiB0aGF0IGxp
bWl0IGlzIGhpdCwgYnV0DQp0aGUgY29uc3VtZXIgb3VnaHQgdG8gYmUgYWJsZSB0byByZXRyeSBh
ZnRlciBhIGJyaWVmIGRlbGF5IGluDQp0aGF0IGNhc2UuDQoNCkkgYW0gb3BlbiB0byBkaXNjdXNz
aW5nIGNoYW5nZXMgaWYgcmV0cnlpbmcgcHJvdmVzIHRvIGJlIGENCmNoYWxsZW5nZS4NCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

