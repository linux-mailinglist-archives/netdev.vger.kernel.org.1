Return-Path: <netdev+bounces-19057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFF759728
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BA0281936
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0C1400E;
	Wed, 19 Jul 2023 13:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908313FF2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:36:33 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437F199D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:36:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JCwmpw004144;
	Wed, 19 Jul 2023 13:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3+qSiUtiod17JE/ameIbTu6eZc2ZSavDt17/peab6g4=;
 b=gtXLp0Iq/mHdwGjMZQ8FhwdCTZiRH6BTsTWEx+MrGvdwzDQFzlhJ5o+pmZgQTZXmBo+K
 k3IC3svKtuUTy/6rzgwXnQhUd91VFuxUZJiVRxfzpX7Dec/hWw4bu0aj8oSofluLaKTi
 B3kJ4ClmmJelkmi7PpP3C3n3F+ZFLe7QIRCRvdqir5fgZko0dovtk6BzKrpgvdRWAGbP
 N4Y3hrXQwtoso+76sF/AJ/bcRNNN3czUNTrnyGsfmbzycEtc5q3izJ7SrnoFyQNoCj/7
 VDqPj1P0CR+sHaRFzpQjkdPm2dUTkFOf2syFlgs/wd+0huDIBH++kV392Ps2Dmwo6a7G 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run787c6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 13:36:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBjfJF023917;
	Wed, 19 Jul 2023 13:36:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw73y5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 13:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiWFoXIwWpNk6DImhWW1pyoe8WrOPagl+43aw3pj+s/cOir2O9ktB7AyCp5tcWkd7LEP5It1Tn2H/li7DMqH5MUSlX+vkekRd4UqtmsJA/jmnrTFYaFzmscKeRHnDuawxwCdXMyUBlZPPGIh4db5zHVtv9ToDxdjRlKcHez+fSSOaG0d9mmf6EBTyvRBnQVxUzZ5md1GgWmBpQC1HFNVdJUMr4wh92kIsCu8v5HCPQDcLMsmZkCGcF1pBwVrtCmWdACuFRXqTLAccNzBuAp+ATWAjUzvEehRqdPfAcfFqgkGcS480riupbm+5M/1GNwlo3Qzkc2CTL3Xh1ZVAAsbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+qSiUtiod17JE/ameIbTu6eZc2ZSavDt17/peab6g4=;
 b=DesAyfb+kU0eCr5H+DGahLyCkDair/ZIsc0WJb5AVUyxXfjMwEjdNdD7WiuXLwYJ2DCkOg1C415ks//2+sWK9k+CrxrXeOelk+5ynORynYZw3YtwImhroFNQUvn94I84BPuDtucqlxMpdHDW+xYUZ/GbkhOggo7rGBd6WtpjmKmJb4TTgNP4NNiH6uce6WgAFycI/W2xqUY63ijf8Xzbf5kb0GsPlNOczwE/fmaBUlyhzeSm3QC2J0e0CicYsclauCtjTtyJNumONgRXvK8z96HmxPKOTr9C+d7U4OMiskqp5s2rcstGqhz8ZBotuGenZQ2z/OO4b/DVIvsBZ8zvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+qSiUtiod17JE/ameIbTu6eZc2ZSavDt17/peab6g4=;
 b=XA0g3tfloj4pME+0zz9KkRPY36ZQNLaZ43SnLUnOh+Klzxs/VXHRDMoDZSAlmyYmXseRVJR+ykzAX0vrNQadmrLsMRc/L0g6JiG2TqfBb6Uzpfhqv04Rw7AJHkN1HGOIgReExQUx8WSa+cB2D4naGL8nsx3oEd1n4pozpaEmSho=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 13:36:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:36:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Chuck Lever <cel@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
Thread-Topic: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
Thread-Index: Adm6RfruiaTFLIv8iUiY2M/pv53Q1w==
Date: Wed, 19 Jul 2023 13:36:10 +0000
Message-ID: <74209F42-2099-4682-9478-54040B1BCC1A@oracle.com>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970685465.5330.12951636644707988195.stgit@oracle-102.nfsv4bat.org>
 <8c9399d8-1f2e-5da0-28c2-722f382a5a08@suse.de>
In-Reply-To: <8c9399d8-1f2e-5da0-28c2-722f382a5a08@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB7075:EE_
x-ms-office365-filtering-correlation-id: 6d131593-2db3-49d9-296c-08db885d1d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 muPKCq4Ox4xB5EJfgWb8WZTQxRgZXORictcgoVm5MoFaAyvITbCDceRAqtGGhDjdNr/gKIiq5o3yL5B8ZmAaxB396aanWvpxqJTzYWlJlq8F4tj9qhEaThyDFBXd0Qr/iJJm/mL4pw9J2JSxBTqr1hNLXF1bSUP+ae0EJ2sDrPlfhWyro8u47dEUb40MC1Pg5W/y4e9rxCF19faCFOU/NcNBYyDCX4vHit09uI6YybHOxgJlnTikEYsCw+hTCz0eFyokkAqV15uy9wuXFUoQ5D5ySy0uYbWXiHESYEN/4sRyTqt9UVURvoqGEzW//yBJ48Pr9P/9Dh4ToU7ZLlW0PEWVi6rGmscLyfuNuf9sBiWlP+Ms/SfkxB8EH5eRKmFXq1I0aT+dLH2ePifmM4Ymo7dm1qrHWCO6amZ3FcvFPyWmEuQM+fVdisTza1Uhe2BSG5j3BSaeQd0BLt5vYoAjfIMfRXoEEeALATjZOO/p+Yt0+MfQKpuKazCBY/FyX5m7J6Bju7IWKV+qnSGKAXoGIAZzasP+qobQ0GkIUw7y1NV2eJ7TXHCvk/b5P4dIh/h8hYbyuAg8Em9cOQomhvTPRLVDFsycoAfYtQGb15R2+7/H7LEbkdQXoEADW9WFji2NeQPZBpk5UcahbArcTPrXIA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(41300700001)(54906003)(86362001)(478600001)(316002)(38070700005)(91956017)(66946007)(4326008)(6916009)(76116006)(66476007)(66556008)(64756008)(66446008)(2906002)(8676002)(8936002)(33656002)(5660300002)(122000001)(15650500001)(36756003)(26005)(53546011)(6506007)(186003)(38100700002)(6512007)(2616005)(83380400001)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3JSZS83CZu5X9xnDngd134sEds6Jh27M0fc9wD+zWe7HffaX8mu2wNw8j88K?=
 =?us-ascii?Q?dlPRWOfU+gXO90NMnbUphqUyEs5o9wqntQqvhBnj55wR7I1lYz83vfh5zbl4?=
 =?us-ascii?Q?XsfSaJe6nWJOpozuyTAbMUZELp9BfpiQe+SNtZNz+bZ+KXiY37u1zPjvwW48?=
 =?us-ascii?Q?QArKIGc2ZlNom46xq36TDzISjC5siB0XK2sdRQ/9DXmb18sDhyqI32ecX9hY?=
 =?us-ascii?Q?8OYDYpgo5eUVMTSAY9IyQNYtAE//bBholYlhRESRGsMjCWbncxs5iOhW1Xcp?=
 =?us-ascii?Q?g9Z93CkYxAbZlX6umDCsn0fOTDdW0Zad503wLHxaVPlLBp8uxPbv9FQdJ2qg?=
 =?us-ascii?Q?Ca6bZOKaZBSLKyr7+ljvX3BQXmQG6u7NHray3T1MKW9mBa0+ZI5uHrfVWAj2?=
 =?us-ascii?Q?g3BwuJQejVBSUF3faswuYBWVHARgpivFxXxkE4po1kWNis2J2+v3WeAFq7tv?=
 =?us-ascii?Q?L8muxS9AO4Mzi/OtJKkx7CK4OxWRHgXQUM1sY7wtut1zqyFkWVqqQATFpK6h?=
 =?us-ascii?Q?4K2qTEY7bBctLfgBqILjA7sxahNoL9p1KnlWNFgXj1+w/maR9kisrj83KFNI?=
 =?us-ascii?Q?J0VXTbom20pkiutArly7yy/9+yTVRe4kPOxLDojSVGvpMSvHO19ropUi958e?=
 =?us-ascii?Q?nRhWUdcgXN1UFG6AEzeY5WqnAgF6DVpuOAW5xAlSt6B7GFTfoVejGT88oLZU?=
 =?us-ascii?Q?iDkklnx+aYoY7XWDNjq0I1b+/SiYKQqXoLkU9Um08DFDsv7ettoUvUgj5S8r?=
 =?us-ascii?Q?SeFlcYkVmv/wJIna2ch5Ss8pTSOuVv8vyfc04XIylbaAyPKHX3dT7Kss222V?=
 =?us-ascii?Q?iW8CMs3t77xnFURZb6o5vVqLCfUkEU4lbuReKod5uILHrhRg3qBppv0vWQuq?=
 =?us-ascii?Q?pzjhD12yzbEof7PzEZhTeOljWPGmYdmnBV8NA2a/OVUlAGq7d6YtNrz8XAiy?=
 =?us-ascii?Q?xtGW2B1hExe91+izlUMWXYtPUX8ETWY9PIg4+IwdI1TFhKSaRKmOfkhmgn1I?=
 =?us-ascii?Q?QytEIFgLE80VJN6NPoZx+g02/LHDlbc0xIEaKjLoNuUwzg4EaxN/w6IOA8ub?=
 =?us-ascii?Q?XbxUN62EOidfJ+n12cY+PJFd3ec/kq3jty/W6/deiFFdMqWHdTA1KCWEZJ90?=
 =?us-ascii?Q?+lF8tY0q+0DpOlBKNEnYfv4b57vyBxy+2V7LH/OVmPnbqfjkWLNSDPUtY0vK?=
 =?us-ascii?Q?ZsYuFKAlyr98FMDloFOjrcx0ZTdtc+LTKw4dgsekfYzkI4UoLcEcIRjjnGl8?=
 =?us-ascii?Q?40nlhyjxq9huYPY/UOa04pc96bCDcLpGqR47kIk7/dHMwTt2ZwMhhQ4fQYo0?=
 =?us-ascii?Q?bAxLwrJ97QllToiUEuuZ6nNzUm+u2WTQDLf/ONujL9YI1e3EZXI0pLxxGNgo?=
 =?us-ascii?Q?FvEOaiqWVjHnlR5SMZ/CQjmfQHRcvylCAV+Xa/n4rSOugZjNdknw7DM3XCVB?=
 =?us-ascii?Q?18tHEIjpmnf8MFTQk3wBa2AXxbMt36Wp144S6j1GxPFFRxPUnfSlfJj9txvn?=
 =?us-ascii?Q?7FfKOsZdVMCUrebxgjsz3h9KOMo8S37BHDW2XbLGuEfj68R8cYqILIXmYi9t?=
 =?us-ascii?Q?Nm0iySR+D7nXouwDrPPVQ+AVtr0iOq6bkxf+2IS7UsQYWXCRz3Vdbc8kXK2z?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D750952F4A4B0A48A085193BCF7A84BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?BrzbJ416alVvF5OAOgTgcvGShVsEBxU5P7/p5EHfycE4IwcZn6/Iv35IPhGx?=
 =?us-ascii?Q?JvPd8FTwPJgizOTueCNVAhSqTp9Yof/M77pYDxuf5GTeJrhxJkqWecnyPBXH?=
 =?us-ascii?Q?EaIAJrM439z8ci/tMtY2hiI2VjBC5Ib99FMlHGOADyeA6l13M6nn6RTf4kE4?=
 =?us-ascii?Q?2ZuCcqPd5XNDKmLr/enLGXNYCpKA8aBn4ecrgYT4JUC86ibofgl3hYxpJ7te?=
 =?us-ascii?Q?tx+l9fSmBqhA4FqFXKCYJX5gSL7qANmDv0T4BsDdjsp1zwY/749Cc4vaRQzs?=
 =?us-ascii?Q?7vfyW3vRwhvCg5IME8qJK4Lpjez+qIvRiEyAeS+P6ZQ1y4Ycw+MIywTm6OjC?=
 =?us-ascii?Q?2vQtn58gRuCDTho/ZEPBGq+619BRBTh6n78wHry0qokIzaeTarBK4Jd0Uk/j?=
 =?us-ascii?Q?k2bZrrtzMTM0A/NX/cpfD10dZ6qcWM+867IBzp9mL/zWiS0TJlgpDYrHtb+6?=
 =?us-ascii?Q?i/NSDIniFCzyWpNYELhyhWaSmSGN86JMmBq7ucQWRjTyN7rhn1Px6sEi8rXP?=
 =?us-ascii?Q?Hl06wB6W5FG7zr8IDs2pWJT3JAc5bUPg0eXitPjHJ5Aw4qZTX5gXLChJlnMd?=
 =?us-ascii?Q?PeKxHHsL/FdqCurgB3PenO+bZGgQTumtarRX0aLob6DDsMi1CNw8wwazk4xg?=
 =?us-ascii?Q?YmSQC7rqTVah4gJWu0ij9QS8QT0BjCAV+IC5YxabLI1nspGKZ3cJWT2oI/jl?=
 =?us-ascii?Q?CImZHRk5QEIygz4s+usssJmCp6XA5BkW5ZnLt6yZfpuk2WCdbKK2qUPcVGI7?=
 =?us-ascii?Q?Muiz22jfehX3M4SEYkl2qtmSbJqak+aRlzSefMW3gJGSwrMtvbww3t5XuyVQ?=
 =?us-ascii?Q?4sxWP8A3mF2SbK9c94gY9wduEi3iT77DuOSArR+ENWZR4JaeBXYLFpKCXXue?=
 =?us-ascii?Q?W2Kkp+XSz6jMY/MC4nuyKl+8T0ArUVWZXEzFYBakPGyyR2HF+PyeOUAWvf5y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d131593-2db3-49d9-296c-08db885d1d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:36:10.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qaEnMSIz8ZMVRbJK89O4w2gmAhJhG5WnoV8w5isI+cqmNioGS8RhrBVcyaJfo842oWJ4p1szFjzWHcgsJovIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190122
X-Proofpoint-ORIG-GUID: fQoglkPJH7CxWIz6VJwKHFFch_wYfYZH
X-Proofpoint-GUID: fQoglkPJH7CxWIz6VJwKHFFch_wYfYZH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Jul 19, 2023, at 3:52 AM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> On 7/18/23 21:00, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> Kernel TLS consumers can replace common TLS Alert parsing code with
>> these helpers.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/net/handshake.h |    4 ++++
>>  net/handshake/alert.c   |   46 ++++++++++++++++++++++++++++++++++++++++=
++++++
>>  2 files changed, 50 insertions(+)
>> diff --git a/include/net/handshake.h b/include/net/handshake.h
>> index bb88dfa6e3c9..d0fd6a3898c6 100644
>> --- a/include/net/handshake.h
>> +++ b/include/net/handshake.h
>> @@ -42,4 +42,8 @@ int tls_server_hello_psk(const struct tls_handshake_ar=
gs *args, gfp_t flags);
>>  bool tls_handshake_cancel(struct sock *sk);
>>  void tls_handshake_close(struct socket *sock);
>>  +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *msg);
>> +bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
>> +     u8 *level, u8 *description);
>> +
>>  #endif /* _NET_HANDSHAKE_H */
>> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
>> index 999d3ffaf3e3..93e05d8d599c 100644
>> --- a/net/handshake/alert.c
>> +++ b/net/handshake/alert.c
>> @@ -60,3 +60,49 @@ int tls_alert_send(struct socket *sock, u8 level, u8 =
description)
>>   ret =3D sock_sendmsg(sock, &msg);
>>   return ret < 0 ? ret : 0;
>>  }
>> +
>> +/**
>> + * tls_record_type - Look for TLS RECORD_TYPE information
>> + * @sk: socket (for IP address information)
>> + * @cmsg: incoming message to be parsed
>> + *
>> + * Returns zero or a TLS_RECORD_TYPE value.
>> + */
>> +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
>> +{
>> + u8 record_type;
>> +
>> + if (cmsg->cmsg_level !=3D SOL_TLS)
>> + return 0;
>> + if (cmsg->cmsg_type !=3D TLS_GET_RECORD_TYPE)
>> + return 0;
>> +
>> + record_type =3D *((u8 *)CMSG_DATA(cmsg));
>> + return record_type;
>> +}
>> +EXPORT_SYMBOL(tls_record_type);
>> +
> tls_process_cmsg() does nearly the same thing; why didn't you update it t=
o use your helper?

tls_process_cmsg() is looking for TLS_SET_RECORD_TYPE,
not TLS_GET_RECORD_TYPE. It looks different enough that
I didn't feel comfortable touching it.


>> +/**
>> + * tls_alert_recv - Look for TLS Alert messages
>> + * @sk: socket (for IP address information)
>> + * @msg: incoming message to be parsed
>> + * @level: OUT - TLS AlertLevel value
>> + * @description: OUT - TLS AlertDescription value
>> + *
>> + * Return values:
>> + *   %true: @msg contained a TLS Alert; @level and @description filled =
in
>> + *   %false: @msg did not contain a TLS Alert
>> + */
>> +bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
>> +     u8 *level, u8 *description)
>> +{
>> + const struct kvec *iov;
>> + u8 *data;
>> +
>> + iov =3D msg->msg_iter.kvec;
>> + data =3D iov->iov_base;
>> + *level =3D data[0];
>> + *description =3D data[1];
>> + return true;
>> +}
>> +EXPORT_SYMBOL(tls_alert_recv);
> Shouldn't we check the type of message here?

Well it looks like the return value is never used. This
function acts as more of a parser rather than a predicate.
I'll kill the boolean return value.


--
Chuck Lever



