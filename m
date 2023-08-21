Return-Path: <netdev+bounces-29446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CA7834EF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23831C20299
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64C125CC;
	Mon, 21 Aug 2023 21:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D1F9C1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 21:37:57 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626910E
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:37:55 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LLTOgH015690
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:37:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=PePbpFRH89xu40uEr2TzC+LPB2X2ylZ0asuX8vvIiVs=;
 b=PZZ3YYKbOVGkdWSwS3oS5hmpzLqjUuQj+2cx/s3s7UR9Y64RIcj8WdG1EE3V157nWXse
 5YY7cfeJ9g/qXqu2EPIiU3Wf92bcA9yC4VY4x4G5jaw1xjuXe1NX8w1N3NkQ/0V4Z9xP
 pUmwGyzxi1vsdboNRnqOT+dlc5GvvnUXgYEXbaZAJWsCiDTm2mxxZCXwpJx3Vp1KYxfK
 ypGQWjrI4mF1i8szPHzLv4j6CMta3SqJ0TgeRFarzOnHAYVgJlY23dNle5DpKehh6mvN
 VM2p5aUTmokYvq6J3UJxvMMuuAPblX0ofm3ydgic64pJ6x5DkJgbiXdq+qVW9HQWEyhA jg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sju947et2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCH+UoXlCufABRsQw/sS81xxLyIzgOv1dF4UUeKmBRH1tgQJAh4mv68yD1VISB+5Mw4fv1O2w4XHK7AElV3Iex39zau1xfWI15xnA0fJQKmbk5jmPAEQ6BGy5ExDg1YBqerrrV48DR7NmKoVJuEAnJ/IHx2HwZ+2u/LiJtFdN38dIv6SKmjczxMX50XoAptvviv0vEMArOBMjpLNGHE/c6O6holyWZfjJLhXj2MTd13TUFuElmZymDMqqzCAXR5wxBTEGaDKqEpqjHeoWKMisKp3AY1OLGxISztQYlbgdkpiwfQ6zhlNMdK6FhjX142toylQccikLjJyxLgEMhqdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/TUlVgdYxj0RJAO/9uPu4iwog8F/fQIxNP3N5mz/YM=;
 b=MYlG2beZPBckl2jq2LMeBt0DqdsqfzzrefKkUHtPduhywsPO6+0BO0iXO3ts3c4ZDWFn4oN7sQApwJcEOUMR+PMxDv40FCrIIP3fmlPhh/D4SM7OY9WVguXuK94ZATqNkcaZgcMcPOOMG73KlQVyb6nrGxT9xz0lunbmGWZZEba/Ob6u/bqCaWWINxZBwTMd8Q47exsjAYjvoImPUj+DIbbRe38GABnSuQM7GKpKEjUxUa5ul9BGQ0TFoOLM5vdTlNahjNtUGYxv6aTpPOhNEeOjqeaXwfGrsj4OCRkh1kX3YzDkvbQ7nSgO+4DhQfW14DCK3F3Ec5AyQGkKm6bSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3874.namprd15.prod.outlook.com (2603:10b6:208:272::10)
 by DM4PR15MB5963.namprd15.prod.outlook.com (2603:10b6:8:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 21:37:52 +0000
Received: from BLAPR15MB3874.namprd15.prod.outlook.com
 ([fe80::79f4:8f99:dff0:ca4b]) by BLAPR15MB3874.namprd15.prod.outlook.com
 ([fe80::79f4:8f99:dff0:ca4b%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 21:37:52 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>,
        Rahul Rameshbabu
	<rrameshbabu@nvidia.com>,
        Gal Pressman <gal@nvidia.com>, Bar Shapira
	<bshapira@nvidia.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Richard
 Cochran <richardcochran@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value to
 improve ptp free running mode precision"
Thread-Topic: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value to
 improve ptp free running mode precision"
Thread-Index: AQHZ0LPjHNimFEXRyUqREpVAZe4gpa/usMQAgAaczyE=
Date: Mon, 21 Aug 2023 21:37:51 +0000
Message-ID: 
 <BLAPR15MB3874DB4725CD5B5139DAA868BC1EA@BLAPR15MB3874.namprd15.prod.outlook.com>
References: <20230815151507.3028503-1-vadfed@meta.com>
 <20230816193822.1a0c2b0c@kernel.org> <ZN5Mvh9c+joFcJbb@x130>
In-Reply-To: <ZN5Mvh9c+joFcJbb@x130>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB3874:EE_|DM4PR15MB5963:EE_
x-ms-office365-filtering-correlation-id: 5898ceac-9410-4298-324e-08dba28edf69
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UMU7svHDB//OyX3YpKpYgJeeQf2p1V4IU5rwnW9Mnd/MUzQvY18+meKtjTk9104o+9sdt3KXmOAV83FXd+GGyq0vAyrwvBtPVZys04SW4RmjLiYgIuBYT9ptNL1RZqb2MPOgodk4DgDIGC37lSXh+QmvS+pbU5H69HBTohvZAftZfDjwGhlimTgWMfVYhtzSQf0GqVUzekhu3UIdx02L6zfX7IfMmTkwwibxa9T+qqa+vySvbnPfDJi+bH4TgUtyR8jzPHhuYHAk1QjxYY3QsnUB+7nyrSMbGNh+teCxb3NODuoPLtGLFtK/Tol2u3h4SBgyfN/Ekx5Fp6cH4gTYCc+YOWyFnHjgKsm+kTYRCfv6Li7qfDjLJyw/9MzUPBcBQCv2RdoGwuNSNTkQX2gGCpCJSXbwG7w7dLwX/Qgciou34HukYoCPui1018OUZj0fMK9UmGZ7L0X5EoMgpT2ziYJ9k7F+/LKjb9gGj8RKHFjVbyvwfbZ7CZcr/QL5Dws3Pdx/ZCH/dSpi6vPNjeXQL5ysG/26Av619FuWd1p2SseUaJQcCfUXaXdwWq2YJTMKvvkhtv5nKfWgVrPhvOeGKV3ohUCKYAsQyQwRf252O18QYGNQD4VTWN9FvROt3PEr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3874.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66446008)(66556008)(66476007)(54906003)(76116006)(64756008)(66946007)(316002)(9686003)(91956017)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(38100700002)(53546011)(6506007)(83380400001)(15650500001)(2906002)(86362001)(7696005)(5660300002)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+VOon85GkLfjcbcFmzpPIhvBi57p0Pdyf8UEpOOcGXD5HwyYVYEsdOZbNtUb?=
 =?us-ascii?Q?rZpmwL7N3uUaeb/PWAV0UPL5lKlwoKi+YDdcxPFopWoXqMyaVavTxroSrDCs?=
 =?us-ascii?Q?Ro2oT8cjpWHkcWpvp6MvMdE7UirzpwDCVvAnWeMP0ek7rNp1Q8GVkWbbmKlb?=
 =?us-ascii?Q?nuvEV/puUfbGBaFlg+KCYHvn3gNNhgk9tdogyPRNv1xtsh4Zmr0XWsRlyTTA?=
 =?us-ascii?Q?2eIM/Nmaf4WPR1d2Qpb1tr6j9QENrRH49CZg2T7BBLaOmFlCD+2G7bgm9TIf?=
 =?us-ascii?Q?vbCv6J/5wMB1OaecpTYjLeTjmLvH5ku13ae6lWwdaKMZoAhJXrWzYO6nyL9I?=
 =?us-ascii?Q?SnyoLmZu9f2osJgfV2ivl8ARA300F7BkPEQ467x1xnLu2lDGwk6qSx44v1qP?=
 =?us-ascii?Q?L6AWc+6N2vd/kaauZN/d8qpO10KzWs46iPryr8yKXZ+Ehxz9U1QttOZREjBZ?=
 =?us-ascii?Q?Qud9o1amG6l/0WjOyfN3nKhsq6/6d/+oJQ3Lv5VBqklXomty23ksEFiaSj+Z?=
 =?us-ascii?Q?yXGpQK95VGb9zbxSeC3Mz8c3hoFk4SNwdnpi/2EYg+jwudhyMCZEgQBiN5pd?=
 =?us-ascii?Q?LBEeoWAvreqdx2/suCuYcAuRn6M4Ccrn09Khr0IiGq9Ysyfpl7JyylhFSMS6?=
 =?us-ascii?Q?ReikjaF6GxpjYkCfjjGfFCEe2IeQfpBdQ6srdBQRQSTjWPZqXktAJT9W5bzT?=
 =?us-ascii?Q?DHQGSMd1vplWIRekVr+OnzjOGnUCG1Hrnd/YihIqXIcV4CcaHbb47z7ZUZox?=
 =?us-ascii?Q?BHieZuSCcyk9bGOnSqDEbHs5CQGXHF5WPO66XHHm/HhQjWuqAihbSxhs7eQ9?=
 =?us-ascii?Q?3rcgrHa3VD9sjtzns+bQ6vpNK4LmNB5Dvh9Qvypsn3BtU3t9etfmTepdqr5t?=
 =?us-ascii?Q?MP2wTDo5B7C1KfZqx8EIxyVYxp2NV4DA0Kn9R5aKu4BfBdEARMEtdQnLT143?=
 =?us-ascii?Q?uQ6OeZdC3zt7vJephUbONUJYZDe9L0ZjwuzXxMGoPY9ZYujTt1UyWfrtSNAF?=
 =?us-ascii?Q?EdbRixFO1WFIRaZ9XbWWkHDlpzSQBnmQtCKKH+bKDvwB8aCCGDzHpGOZazxW?=
 =?us-ascii?Q?02XquUyo9kkQd8nq/7Q0BngL2YbdOGIeuSAqq+tBAFuBhG6/1926uCAL08Wu?=
 =?us-ascii?Q?2PfgwAM+MJZr/bi4yk0QNHgnpoB/ZAu74xgnbL2oq/vNYmwFPlSNd1K/usxr?=
 =?us-ascii?Q?YiaryLjhuiyzVhQGXBuSDp0aeesZ3AMjM0keDMV9M766qsMlPdZFN/K9dp7m?=
 =?us-ascii?Q?9F8JxlflfTX6GxgqOdfC177E3xW/Dqb5YqpvVWJyiVztyB5EGElgArbWmMR9?=
 =?us-ascii?Q?cUYvXRj9Yfc0TBJF7m9nJs1DKzR1EXUl3wyIQ5wy25NTUJNl9pi5noNLHNZs?=
 =?us-ascii?Q?/76O5fjmQnXOl907teP833snqFJyqn4ZIbNJNsTRXSuPx+1ZupF0/U3dn7CK?=
 =?us-ascii?Q?XfMJyYPU6JTPBPKOIx2rMV8L/x7JsJs1llstcmT4ZgmS2Gxe06lIkxcVVH6c?=
 =?us-ascii?Q?gLKk7KnzF0SDuo1nWCbSvLPIomX7Z0QrVwoIFAizRnwQE5sroZuPvi+bICkG?=
 =?us-ascii?Q?gjRMpGWuniEONJvHTLSG3ivClgFzJWk3PgFPv1KM?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3874.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5898ceac-9410-4298-324e-08dba28edf69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 21:37:51.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO9E0MHWodCXC/ZV5aLcFbfydJZrt47lzpUyaW/ave1KwNCPppKue3bguH+9NpiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5963
X-Proofpoint-ORIG-GUID: BxjOr7TY_LYLGZkMZItJkRESJtRou6Z1
X-Proofpoint-GUID: BxjOr7TY_LYLGZkMZItJkRESJtRou6Z1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!

I have tested the diff, looks like it works on both CX4 and CX6 cards I hav=
e right now. Wasn't able to find CX5 to test it, but I think it's ok to pub=
lish it and wait for some other users of CX5 to test.

Best,
Vadim

________________________________________
From: Saeed Mahameed <saeed@kernel.org>
Sent: 17 August 2023 17:37
To: Jakub Kicinski
Cc: Saeed Mahameed; Vadim Fedorenko; Rahul Rameshbabu; Gal Pressman; Bar Sh=
apira; Vadim Fedorenko; Richard Cochran; netdev@vger.kernel.org
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value =
to improve ptp free running mode precision"

On 16 Aug 19:38, Jakub Kicinski wrote:
>On Tue, 15 Aug 2023 08:15:07 -0700 Vadim Fedorenko wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
>>
>> There was an assumption in the original commit that all the devices
>> supported by mlx5 advertise 1GHz as an internal timer frequency.
>> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
>> as an internal frequency and the original commit breaks PTP
>> synchronization on these cards.
>
>Hi Saeed, any preference here? Given we're past -rc6 and the small
>size of the revert it seems like a tempting solution?

Rahul's solution is also very small and already passed review, we will be
conducting some tests, share the patch with Vadim for testing and I will be
submitting it early next week.

>

