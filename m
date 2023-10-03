Return-Path: <netdev+bounces-37624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3767B65FA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8515E2815E0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6A11CB0;
	Tue,  3 Oct 2023 10:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A3EEDF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:01:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F691
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHBqFmgOnS6weSW8LTY8exhwkpzZgAiUX/iGd+DXzPKRjfYf1PhCpKjJDzh7+CLyd1aKrqbqp1B/zqlplftmODbveWkJQmjYcsQwlF5eJqhjJdUdrR4M+PhQMPh8+TzrcHpvV/uEfLq1HArX2o5sqWVOjDOgdPZHbS975ERzQSeXWVL4nhOy5c2sHdFmMS2uFPrLOm+X1I/MsqWCSYjdlw9ABaP+D/pdttnQSQFSMwy1BQsFCT2WS6i3R8T28dImq/GWp9syWPzo28A/qBxy2ObSRHAsw1FpWn76FSOmfRvn3pNyH3xrERXcw723V8Nlj14fjAp8WD+6pjo0u6PZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjUsgPn6JxN06jNqrsv+qYHz+FJtlsX9ovZeL3s77T4=;
 b=JnbQiN59kSeaN8CGJNIoBM8IA9XvCnSLfod0ZikEvnim2oK4TMgrtUI05N37v6W4P/2cfliX4cT4XUhsn3Uq13stzN76857El0ZUTkMZnW98g0SGoToXFh55bmJ5uu3xu5JWfccg5T0+XfYI2zXgHc3WjV9ibq6nfIE5TmqpGbWfskXe2q65tbApqoOdWdUAVqAQbA+/aHIVLEpQodL/26lu/WfvGYRKF0o8pvzH32qNrmJe0xXAL2AHg5b2GoEcPYKdN6BgIN/RwycaFapKyzHAW1VGkhZMpI24YSWplb9bFp1tGhRYAk//rhnkKYKYtTXBFRNpzwfbIGhRWSug4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjUsgPn6JxN06jNqrsv+qYHz+FJtlsX9ovZeL3s77T4=;
 b=UyUV4CeJf2uxYKr+85uXDQ1h0GHxfkg4OfsKLE4/eqSluzvq9ajAxE9tT27+7VQ2EXEgQc31m2S6aq+73jil8yQLcVGWgWF5W2tgT3QWofC9Ze3GQaskywSJiLfLtAYmK7h4U7mMy+9Y59oVq6PsXrkVixT7UjCC71dL21RyJWdl45YPDAS2N8neNef71N7D5eQ9EDPjglG1qixVNs1mZRrcEfV+jNAaJR/eTHwOO26XLpOMdkX9AIe7snsqNiFgrJQHzbABW6ZSw8bFxvD3L8WjyhIAaxeb2KeyCNDTh1pPy/NDopMzij9cuDzuPMA/ufNrizuywM5oZesO3SgGnA==
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Tue, 3 Oct
 2023 10:00:58 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::3) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 10:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 10:00:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 03:00:40 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 03:00:38 -0700
References: <20231002144014.40c33922@hermes.local>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>
Subject: Re: [RFC] iproute2: ipila warning
Date: Tue, 3 Oct 2023 11:35:47 +0200
In-Reply-To: <20231002144014.40c33922@hermes.local>
Message-ID: <87o7hgqb3w.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: d72572f4-b56e-40bd-34d0-08dbc3f7a3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zb6yhR44cbgxmPEqE1dDtRLQJ/zOlYE3Wr/6h5jH6mP0jV6L9zr65oOMlty5wK6sHNT5qm9a6iuRkB+DTbhEm6J73dRwyEV7Ln3cqNI87altIlFYvclU09ZwoQaQ+4NQEmK0Yj/9Fjke7V+2TJGYZnY9uUU2OMn+iLI4w5kY3gUOpGaeCXlkdcuuyjkOdOh04AFcrpvnDhKNK+lFv3t4O1AblzPN/aPt2a+tOsxV+RtDk/cfmea9KpJDd0StJZtbJSFJ5PA8odvLYRLutrps+WCgJaKb9ehFPiLvhjSKKTCP84uiY+1vTDKWJVTPqaGUrhKhjiLVaq4RJCswftas2+xcGH4Fui0cH1jjID+oT77zIjsPCiNDXcDXFNakPRIQvyaRPdLWMHhlZ9MDt1keUMSlh6Mzj7X45i/86us1MXSMzqydKgZal+FWXP5qmjn3xuspO1lqIYdubiiRSZST4v1BXwHBVBTdSHbMBlH0JViliIrvOMax8yQbGZg3jdRW9ia0UWO25xd6B8bypVCv2RAWoh9cr2A8lOBWq3q/rq2nBrdy2agGAnMvaKjBaQi0EEbacYCfZf+kpHxJgIfP43s1RgO75yqo1Wm5vZKVfaSs8q6TWf5hAt+yeUistEzm2mVszAfCICFpnL6glTD8kf97ySECQsrEfYhhhGHaKUpUafeYgs3FgGHWkIVBJcZaZCk1Mdw17a/qwEt6pBOHbPDl0eAgKrnk3kfvZLzV8+6TSVKV56fIaqugXhOE8Qtc
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(40480700001)(86362001)(36756003)(7636003)(356005)(82740400003)(36860700001)(426003)(336012)(16526019)(26005)(47076005)(2906002)(478600001)(83380400001)(6666004)(4326008)(316002)(8936002)(8676002)(41300700001)(5660300002)(70206006)(6916009)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:00:57.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72572f4-b56e-40bd-34d0-08dbc3f7a3ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> Building current code with Debian stable Gcc 12.2.0 see this warning.
>
>     CC       ipila.o
> ipila.c: In function =E2=80=98print_ila_locid=E2=80=99:
> ipila.c:57:32: warning: =E2=80=98addr=E2=80=99 may be used uninitialized =
[-Wmaybe-uninitialized]
>    57 |                 v =3D ntohs(words[i]);
>       |                                ^
> ipila.c:69:13: note: =E2=80=98addr=E2=80=99 declared here
>    69 | static void print_ila_locid(const char *tag, int attr, struct rta=
ttr *tb[])
>       |             ^~~~~~~~~~~~~~~
>
> Looks like a Gcc aliasing bug.
> Relevant snippets.
>
> static void print_addr64(__u64 addr, char *buff, size_t len)
> {
> 	__u16 *words =3D (__u16 *)&addr;
> 	__u16 v;
> 	int i, ret;
> 	size_t written =3D 0;
> 	char *sep =3D ":";
>
> 	for (i =3D 0; i < 4; i++) {
> 		v =3D ntohs(words[i]);
> ...
>
>
> static void print_ila_locid(const char *tag, int attr, struct rtattr *tb[=
])
> {
> 	char abuf[256];
>
> 	if (tb[attr])
> 		print_addr64(rta_getattr_u64(tb[attr]),
> 			     abuf, sizeof(abuf));
>
> One solution would be to use a union.
> Other would be to use some variation of no-strict aliasing.
>
> --- a/ip/ipila.c
> +++ b/ip/ipila.c
> @@ -47,14 +47,17 @@ static int genl_family =3D -1;
>=20=20
>  static void print_addr64(__u64 addr, char *buff, size_t len)
>  {
> -       __u16 *words =3D (__u16 *)&addr;
> +       union {
> +               __u64 w64;
> +               __u16 words[4];
> +       } id =3D { .w64 =3D addr };

This looks OK to me FWIW. Unions are commonly used to legalize aliasing,
so anybody looking at this will understand what's going on.

>         __u16 v;
>         int i, ret;
>         size_t written =3D 0;
>         char *sep =3D ":";
>=20=20
>         for (i =3D 0; i < 4; i++) {
> -               v =3D ntohs(words[i]);
> +               v =3D ntohs(id.words[i]);
>=20=20
>                 if (i =3D=3D 3)
>                         sep =3D "";
> ..


