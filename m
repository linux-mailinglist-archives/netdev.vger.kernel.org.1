Return-Path: <netdev+bounces-160248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03CA18FB3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F418881C0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7667211269;
	Wed, 22 Jan 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="ZMhh//Xk";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="HmCd8O4d"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay113-hz1.antispameurope.com (mx-relay113-hz1.antispameurope.com [94.100.132.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B620F970
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.105
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541688; cv=fail; b=k2Ail4mz43kMYn+cCMahfLRYtpDkY0vuXegmvXkbpN/iu1Dc4HGl7Uc/Y/T9TfmiPW7yEsP45tYbqYIQmHZj1VGyf38KJKcxpO8nYqog2L0LCGSIsrqCTkbFoq9AOtfYuNSLcvg7guHerpHJAjGebDUEErHp/RmwGfTNhENHCBo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541688; c=relaxed/simple;
	bh=FamCMUzQZI7okdPgdQT6QnVKBTlMuqbocn/OepdnxXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=leUTJhm6PIosELihk6K6eOAAysUuJzadi4ROwXpvGzTWtPy341GBu8rjCRpf86qXIMZ1KC2HaJFxC5Hmb05hyW+oETjChlkSqGjdIDqG+qi3kjbMlQdRtmp9PM7+AHLAR0De9TXXephdLulyNgl8u+gGpriskUceDsIdAx+TR+o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=ZMhh//Xk reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=HmCd8O4d; arc=fail smtp.client-ip=94.100.132.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate113-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=104.47.18.104, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=eur05-am6-obe.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=FEkVXpeHjLOGg/JOwuAtVhPsDspsBqFgR2W3oSqPvOg=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1737541645;
 b=Bo+lgVrMaq9GvI+30/nKek95HvRBYJ1709ojha4me/yBkrgdngjsW3jE/1oYQ0cTkftlpwCE
 t/mNut75tOgfWGQ51GWW8OiptlW4zzyB4DAGgWy9xIZjUMjIG71ic1L13NHs0eMZSDhf6DUJlko
 1IjTGOTBe/OETT5frZCbH9YrgbWJFk/ARcpV9/xwwElduMdDvpD2c1N9MNhnjo5MWNQUYfknT3v
 8X5iKuRapqVWAfeRq+OK9+UA4IunnHlUM04m1UIswekrsiKKIc3My6P42jhnWSE9SjmgmQcJNjp
 X6uLmG6NKW9sUFTpucpd8ClVVsbmFiTsaiDeGQZNYtN6g==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1737541645;
 b=ni57Y3bZbn01aGojP1cICq8HvZuf/fZYmilGjRW3jMaK9D2N9EpJxTaAb6KUy6XSbx7IJz1f
 qGpGfhpO2oBbC/NatVOXW+1O+kjK/+NHsOINY3JvsaZAL5AyTZ3+PfcnWEuuFJIWl1jcD9oGdHp
 iMOFdMXxunxOwZls9OrAg4/HQJq0Kk0qpG9iVl1QvFxeCMcfy13NIxBp7n5yAmGHMsflK964HLN
 FabWe/Qeri00XZz9OYqsTDX/74a0t82pNa2R6UeQ5Rmd/xTfC//1CiEEtTW1GSyx/qsEeO46AS1
 FNgS1mPBERtFzfLqWhz+ZqrV1qhsIIDcsw56DDmRXrOuw==
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com ([104.47.18.104]) by mx-relay113-hz1.antispameurope.com;
 Wed, 22 Jan 2025 11:27:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxFM+9vf/5Tcy8oizjCiWQDe2iop3fsS3LyC1bADzNJODeH5hJzO+bIaPSJJ0ZKNpzqNyZjNKC74kalTDG8TvHsgzJfzMN5R+SEog2KdtEXdrdoR62MZXrpdI02BcyMtlEP5zX4SPbsXH8J3A1iQ0W7sJAUzDVlfV85FshtLu/OJKRjfGVN/KkwA+Nmkjzc+ukCHsT6tsGH48iaCicZ3iWXOGOP5Adm6oCqPQt9i3qiWEMSoRs1oYLjcmDR7zpql/0yUTlCCNpfnrS91RfhULudkE/YE+lFG1+NZ7tfnEAtuUueVkHGM90sw6Ybqo3/GpSrJUjsWbZHZmq1X+5hdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEkVXpeHjLOGg/JOwuAtVhPsDspsBqFgR2W3oSqPvOg=;
 b=lzpN06i02wG4V1DtNr9kc/ERHIGMrHlgyAA14v/HZ1VpZOtPkU3MJziBnHsFMOqyPmZcv1cDwzZj7iNiY8cKoN7cyIRwoiXrLZSdhC2qkZEG1QLpIb8DNtQeJkbUMR1s+X8nvOEKEpG/mcPuGu3b1D6yuWwHcoHbAUGOizkuGJoM2yf3o5uHThxwE9hEuXNdZpInCFcx4/GF6xO3xrBMUN2sJJ2754yM28BEF/FYVaXSBElW6YyBbZ5Vjenv2dcmx2fQJrcfBAalyWrLKbFF2wxc0pb4uQTepsFihlYcTMO5NNAZcxl4VKs0pahtgK4BQ5VvTHDcpjKjfhEwbFq3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEkVXpeHjLOGg/JOwuAtVhPsDspsBqFgR2W3oSqPvOg=;
 b=ZMhh//XkOTLmNPDjmBiWCqDAPKRAIBwouP1g6EWvz4Ibzf735Q+aW4UQO01yuKLo92SHb3sZfU/zh+1xr4Vl7/oe3ng/Zc1XF90T4cuAruAlvEqKNGQyrlEpmx2dIUhn1gt76ixPWz/jlhHCSA6P3K1myYedfzBDjruYZ8cE4/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by DB8PR10MB3578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 10:26:44 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 10:26:44 +0000
Date: Wed, 22 Jan 2025 11:26:41 +0100
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
Message-ID: <Z5DH4cIqndQOyUfX@PC-LX-SteWu>
References: <20241126144344.4177332-1-edumazet@google.com>
 <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
 <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
 <Z4370QW5kLDptEEQ@PC-LX-SteWu>
 <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
 <Z4-5zhRXZbjQ6XxE@PC-LX-SteWu>
 <CANn89iJ0+==pXHdMBcAXDd4MFDMvtFQhajKWWKj5kX7gU+NtTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ0+==pXHdMBcAXDd4MFDMvtFQhajKWWKj5kX7gU+NtTw@mail.gmail.com>
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|DB8PR10MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7532e2-8e3e-4f27-0b46-08dd3acf448c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3R5endMcjdCczVkYlE4bjlpYUNKdEJLQmMwdEtVUllPa0tEVkEzMVBUTjFL?=
 =?utf-8?B?NmxmRitKODkvNXovTFNRc1B5R2lQalFyQTlvWGxidDJzbmcxWE53a2psQzNL?=
 =?utf-8?B?dWNQczZKWnZOUEp0OFhkRjVSaE5pTXhPamVKVUhCZjZ0K294NnowVHUzN3dV?=
 =?utf-8?B?eENzNlovejFyWU1jeUJVSnR4Y2JGbmJLNGlRSUJwZFZTRklKay9wS2Nnd3N1?=
 =?utf-8?B?aUpDdUljNXg4NGtjNjZTWDFNZ1Q0SVRYM0RHWlFsS3lsOWg0cVJHQWFFLzBG?=
 =?utf-8?B?QlZmTE4xUVJUb1FiaW81RTlpRmp6WWQ0MVF6SmN1a0hodnl5MTlhVHl4d1BO?=
 =?utf-8?B?bFA5bXJnTkhxTk1OY0pBd3loZjcrUC9LQkIwcVZWeGU3Nk5WY3FTWG9YRHdL?=
 =?utf-8?B?S2ZLcGdBcURaYUdjL0hXNmNwSS82VW1VWHg3RE1Wc1lCeksvRTZhMEhGelVW?=
 =?utf-8?B?cnAvaFZCM0NwTjZZS2FGeXdmU3VrdGdKUWV4a1gyUDNzbm0yWXg2eHQ4dm5N?=
 =?utf-8?B?ZGJCNDF0S3ZYYm84dnVKLzJSYUhWWnpqRksvREFnZGVraUgxbXdMZUkwR2Fw?=
 =?utf-8?B?OGRFQnV1SjR3eFM3RGQrUG4reFFJN2o0YWFwSHpWQTRvKzVvNkVUblBPMVI3?=
 =?utf-8?B?RzJJY2FhbXFxTDhpQmlzZ3YwT0h0anZtbFBiNFBFN2lkTC91RkwvZzFSeEpy?=
 =?utf-8?B?U3hmWnhwZUI0dC9OcnJKV3pNQ0VtcDJ1amtnSG5qYlJRNUkzbVVrTi83WXRj?=
 =?utf-8?B?YWxqMXVmZlU4YmQ5aTZxeDlaTVBXZzhzM1luNkxFMmErU1BqV0FLNmpCdHMx?=
 =?utf-8?B?NWplSzdLYjRBaG41azVvNW9ubVZaQVI1UkJCM1lMc3BrYVRIRjU3eGNxRFE5?=
 =?utf-8?B?aTMvZlc4K1ZlZEtaN2pCR0hQN012bDVkUUtwTU9ialhCUXBtN3RsWDNYZ3BK?=
 =?utf-8?B?UEYyUlNWOXNySWRWK09OUHJoS0pOZE4zVDk1ZVg3bWlCNlNVZXhBWFByUFB2?=
 =?utf-8?B?QWJrNkpMYktvMEkzSmgwVlpsL3lOTGpMNytpUGxEdldCd0wvbWdacnR4c0lG?=
 =?utf-8?B?SlRNUklaWHp0WG9pSTVMeVJZdTJ4clpVQlBCVU93NFZYSkltVzY4bmlYdDI1?=
 =?utf-8?B?U1pUZEFHU2MxSHkzbDF4OERjMGhOcDFPYWJpSTdlcTdWVlZYR21oeW9YR2lQ?=
 =?utf-8?B?VWYxVUpMUXRJdHd4Q09ISXZ1YWY0OHAvdklCNUJPSHpQZWVGbHFscThaTzcy?=
 =?utf-8?B?a3hRWU04SmlodnJYVWRLTWFGcDBSUjZTeHF1S29NMVBES0RlSU5QV2RDZmNV?=
 =?utf-8?B?L2tkMVJ0Z0RUMlJVa0RSYmE2NVEvaWZ4YUpzT1QrMWJ6eHhwNDFGWnlvS3Z3?=
 =?utf-8?B?ektzbGhtd0pLWURBbGwxaTZxR1Y5aEh0aUF0OHhCN1V3NmJMR2lGOFVITFR1?=
 =?utf-8?B?c28rL1B2KytMc01OaFd5Yk10MVZyNHZGeHBuMDl0MVJUOS83NEt0em1XWmht?=
 =?utf-8?B?KzVWanJRSUFIL3l5bUlDNUF3YW1NUjc5c0R3SmNNQlpBVFdpbFhoN3ZodTdT?=
 =?utf-8?B?Q3lpNDg5QnFjbDVPanBrS0JGelY4NGlyNHY2dGhsZ1Mybm85N3Z6djNvZEVC?=
 =?utf-8?B?ZlRkeXdqT2lCWllnc3JnaTNQanh2b1d0Tkx6YUhYZnpab28zZXRsdGE3bnJB?=
 =?utf-8?B?SzBBN2hPNkJZRFd3TWVralZJeldrS2xhRlRwNnZGZWlpci9wZzBVUnBKUDAx?=
 =?utf-8?B?YkE0WWx5TlliRlhLaS9QSVo0UHZ0YTYyaFQ0TUk4Z1RBQzBvSWJ2MUI0cnZL?=
 =?utf-8?B?M3VUVUNWa2lOTmVuaTJEY1h6cXlkbDdQWnRpUGFLdWl0R1A3RWZuZTdUeUxV?=
 =?utf-8?Q?AcZy03V+tJsqL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHN1eTNLWkpld25PZHlCNXdYb1RuQUhja0xMaEtUT2ozWjZxc1hma2h3K2l3?=
 =?utf-8?B?czlaNWwvUEpSTVdOQWUwLzhVbDJEUWUxRDNocFI2M3lqVEFEcy9UcDFxbGIr?=
 =?utf-8?B?MzRKbmhPTzJEVEdnTGpLRllCVzlYSUdhL1NJSVd4dlZMY0xyNFV4enphb0pD?=
 =?utf-8?B?QXo2WE9kK1J2MUYrZlBtV0J0TmV3YWlESjl5b2oyQ3FCcGR3R1Y4dVhvVldV?=
 =?utf-8?B?ZEVURk8xUkZzQlMxUWJLc0lxYjlJblVZMzZRcjM3bUFBMXJkK2xyUDRvYXBG?=
 =?utf-8?B?Y01YMEhYcWhBWW8wdVdVMWp5OXNiZ0NOcWM3ZnRyOVZiOTBYN3pQVUhRNC9z?=
 =?utf-8?B?RndoQlNxZUJIRXlwWitGQjhzcGtUVEpndGNMa2pwTkpUelYvNm9mWXd5cUpn?=
 =?utf-8?B?K0U2bEdPTGltVTlNUGVzYUlaWHZQQXlsaVcyNFFlZFNRcnZlRDRvdUdrSlNz?=
 =?utf-8?B?UUxid21NQ083Ni9TZCtidmtFdlNERWlQMnNTSG5IL2NGYUdqUkx3d1dpQUNE?=
 =?utf-8?B?a2JoQmxSb1dVaUIrN2JWV09tSjg4WjAzczYvelF1RUhuNE9XZ0VTRkFhRHdN?=
 =?utf-8?B?ajBTWjBMTlJ6YXJxVWRLMkZsWTVTcE9SQmNnT29CNE5tN3pDV2VCWUJxUlVr?=
 =?utf-8?B?Nzk0R2RnSHJFcnR5bnBoVkM0NXNLaThSUWQ4Zzh3amtFN1lGUkZpOGMrSmRq?=
 =?utf-8?B?UlhOb1RlNEVvWDZZdU03UU8xY2wzRmFTWnJJQ0gxd3cxc1ordWhxZmt2ZWtn?=
 =?utf-8?B?VWU5WnJnWi9abzdjZlpRb2tCb0JtMjg2blZwSmhKZ2pzODY0M3AzcWZUSHFp?=
 =?utf-8?B?K2RhYi9RbjBna1JTYXRpWFBQNy9Ia21GZFNDMDNTYkJOaFVPQkJ2VThyRzZ2?=
 =?utf-8?B?aUp0WXNzMmF3b1lWMlVRR3ErVEhWckEzK0xLOVRTS1NQaEFVdXphVHpMaGFh?=
 =?utf-8?B?U2l1YzQ3b1RmSjNoWGh6Vkg5Y3JFaUJKb3NBbmx1MC82ajJTQ205Rmo4MWpP?=
 =?utf-8?B?OHZROVRUZWozbi96dTFuVU44a1locUN1RzhtU2pPVjkxbnRKc3c2WTRreFVa?=
 =?utf-8?B?c0JFbFJqemROcllaOTRGTGdQMHA0ZUY3djNOVXpHSjNKUWJERmtDM3FLU2NY?=
 =?utf-8?B?akxJcGI5SWlpODVaWFFzSnBqcG9jb2luOEFWemppRkhNSkk4MGkvZmttUXZR?=
 =?utf-8?B?ZHFHQmRldW94dzhxL2x3cVdvTENPQmpFTTA3M1QwemZRM1RCYTRwYUErMzNV?=
 =?utf-8?B?cGhodjJnL1FhS0puVzgySlBzQjlDVGxPQ1dheGszeEFxUFV2OVdRUi82Znpr?=
 =?utf-8?B?ZGdYczVXMFhxb2V3QkVYUkwzVlRGbllPc2p1VDlqTjE1T1I2RU1Eb2dHV1RB?=
 =?utf-8?B?dXRqdmdMSGRUelV5dVdpTmN1ejNkdVRYL3FPMkdaZXk2K3Exc3VHaUR1dk5r?=
 =?utf-8?B?d2pWRXhPbVhDcUJ3TGZzMkVIRUdaSE93WHRLZnh3U2ZMQmRxL1M2WkIvaCtR?=
 =?utf-8?B?dnBNSHBwOXZqc0hmTVpZU3hqZVA4eWtSS2VMQ0tzb2l2OFZ3SWdIMlJ1c1FX?=
 =?utf-8?B?L1JZTG5KSVBIZUhaZGVwdlVNZlQxYVZTbjlWNDJOZm9UOTViTGZMOVBUbi9R?=
 =?utf-8?B?aHVYWEdHQ3R5VkFQaDFjVWo5cVZmZHBBazlVbk9PanRSK0V3QW94M2NOVENB?=
 =?utf-8?B?TlE1WU1vbitzamt2MWpjZVR6ZUM2MlhZbksvSXhzRHd2T1JqSmU5cGhRUTQr?=
 =?utf-8?B?WGJFTVA1YkZzZ0QvQk1Bd0Q2ZENVMWozaHlJL1dqVzBGZmQyZnhFQVVFVFQ3?=
 =?utf-8?B?L1dPSE5tK2xVeUN5UjhGTmU1bHQ0aytQeWxVakc3eURJVkEyRTh3WlJoYlAv?=
 =?utf-8?B?bTc0OVpGK2M4Ymd0UEN1eHA2MjIyYkhOMHNnYTk5em01SFZBU1FJc1lULzFv?=
 =?utf-8?B?Y2U5V1Y5V24rWCt5SHpmTW42ZkRrQjRxTFl6eEN2RDFrWHk3KzMrZDVqNDJR?=
 =?utf-8?B?TVZSREZtSkVINHFoaVVlZTF1UjVsNXgzcXBmTERIN1FSUEJobElFeTl4c04r?=
 =?utf-8?B?KytjdFpsZWF3cVpzSWdlTHV3amF2aC93NW41a0dqSEZNU3FiTU5SaVU5b2pv?=
 =?utf-8?B?cjBUSE96MGFCM0dpWGErUFFEelFyQTdXSGRTZHF3UVF2cmNCMVkyOERNYUU2?=
 =?utf-8?B?SWtUV2IxbkhkdlhsMW5OeDl3T1labldXVndHNFFpdnhDeGsyb1czbytoVmIz?=
 =?utf-8?B?RkYweW85Ry9xRGNEcjlpa2pva0ZRPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7532e2-8e3e-4f27-0b46-08dd3acf448c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:26:44.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJe8K2N1qOr/3eTmYYO2t4uN8j0PLEs9og4tYxE+rftNstLtczaclNzni8WPbOMzBwgf+fnmRRYZCmlYgUuXoEq29gJnJYC9CIPSE52Zt2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3578
X-cloud-security-sender:stephan.wurm@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay113-hz1.antispameurope.com with 4YdKxg37hPz3ks32
X-cloud-security-connect: mail-am6eur05lp2104.outbound.protection.outlook.com[104.47.18.104], TLS=1, IP=104.47.18.104
X-cloud-security-Digest:d128e163df011e7b7e96b4b15301fef1
X-cloud-security:scantime:3.090
DKIM-Signature: a=rsa-sha256;
 bh=FEkVXpeHjLOGg/JOwuAtVhPsDspsBqFgR2W3oSqPvOg=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1737541644; v=1;
 b=HmCd8O4d5jq9bSD4MAK74Chvp56Hi0ITEsuK011OXCcItvCXG5JnT9f+6lHNtWqtRMXwWWn6
 ve/Qu17bEZvyk0/IikfNvKVzX/pLX94Y2hUHu7HfHKhXhT6ZfuHneJLGDQk+mVUOiTLme3ODOH1
 DhsDZVXJcGb4pbWNqdKRYG6r2M7OAndBkC3Khuy4Zv7dd9sWwz8sMJZ32nMf/mIRW5aEw0vjYyb
 aBb7JK8vSechDCrucpQg/5uW8zBnw8WECBpaUozeDIccpj32mwCbK6U0gi4OTv6HT3Hd91OJ60l
 XZ1pK63kxzdhVWlfLWfQQ1M5kckBSmrTL2BTkRlsBGFHg==

Am 21. Jan 16:35 hat Eric Dumazet geschrieben:
> On Tue, Jan 21, 2025 at 4:15 PM Stephan Wurm <stephan.wurm@a-eberle.de> wrote:
>
> > I did some additional experiments.
> e
> > First, I was able to get v6.13 running on the system, although it did
> > not fix my issue.
> >
> > Then I played around with VLAN interfaces.
> >
> > I created an explicit VLAN interface on top of the prp interface. In that
> > case the VLAN header gets transparently attached to the tx frames and
> > forwarding through the interface layers works as expected.
> >
> > It was even possible to get my application working on top of the vlan
> > interface, but it resulted in two VLAN headers - the inner from the
> > application, the outer from the vlan interface.
> >
> > So when sending vlan tagged frames directly from an application through
> > a prp interface the mac_len field does not get updated, even though the
> > VLAN protocol header is properly detected; when sending frames through
> > an explicit vlan interface, the mac_len seems to be properly parsed
> > into the skb.
> >
> > Now I am running out of ideas how to proceed.
> >
> > For the time being I would locally revert this fix, to make my
> > application working again.
> > But I can support in testing proposed solutions.
>
>
> If mac_len can not be used, we need yet another pskb_may_pull()
>
> I am unsure why hsr_get_node() is working, since it also uses skb->mac_len
>
> Please test the following patch :
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 87bb3a91598ee96b825f7aaff53aafb32ffe4f9..8942592130c151f2c948308e1ae16a6736822d5
> 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -700,9 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>                 frame->is_vlan = true;
>
>         if (frame->is_vlan) {
> -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
> +               if (pskb_may_pull(skb,
> +                                 skb_mac_offset(skb) +
> +                                 offsetofend(struct hsr_vlan_ethhdr, vlanhdr)))
>                         return -EINVAL;
> -               vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
> +               vlan_hdr = (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
>                 proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
>         }

Thank you very much! With this patch (slightly modified) everything works
as expected now :)

I only needed to invert the logic in the if clause, as otherwise all
proper VLAN frames were dropped from PRP.

Here is the modified version:

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87bb3a91598e..3491627bbaf4 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,9 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;

 	if (frame->is_vlan) {
-		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+		if (!pskb_may_pull(skb,
+				   skb_mac_offset(skb) +
+				   offsetofend(struct hsr_vlan_ethhdr, vlanhdr)))
 			return -EINVAL;
-		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
+		vlan_hdr = (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 	}


