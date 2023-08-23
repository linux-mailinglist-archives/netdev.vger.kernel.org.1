Return-Path: <netdev+bounces-29943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262097854D1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD41C20C62
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE2AD41;
	Wed, 23 Aug 2023 10:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C926947B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:04:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2121.outbound.protection.outlook.com [40.107.7.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BBBEE
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9n4i0d2oxCaq5xrXI1ZpmFakH7furSZl8B93m5tITixa7k6QFdw+pM5LAdrME7FCyO05CtPrdq/IzjqXhcLybLntsa0+SQkuenmYfYjh7BWGgQk8bkLi+Vysnw155L1KtS4xm/T41cyFS+hEiPbwR9f8+ecnZ4OiVpmvTbK7ydPGKntrqYc6UuFlJKSx1BA53cZbQaU6D9MMRvAvb0gM91uNkCVr9MinkMQ6os43BvfcphnSriTEla2wKtcFqSH4uEGQJMpzzdSuzX4gaXWJ4uE4oH22JXZYu+949ee1ALBYhtZKT0IA1Pzy5CD1PAH/lS6jLpYvhJ+elzuQTqNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBiqbqOeDQgUkLX5tbN69NoCi1/nowfhSxjE5sIxJsQ=;
 b=nKjnFV/z3B2FSDNhDVwg6Uc/T9PTmOo2QH5HgBopNV6siyY5o1cCEpeZZsJsr1kJJYUbTehSNdZUheByaIIurJmVNKjhJUVSLlaFyNIR3fq5oaRNBMkBnqwAbhc04HrWX5WmdES242mhAyn+Y8OoxmRJa0RvDabZRWtM3OWgoASG63CZ9rp3P71KJC7qb0EzUctT2u7jRy9hiCHcC8/eqmJWHYXXVrViW2T3323/5yaoEoGOGCZVAPnbw8fDR6sBtjnH7ro4XkhRuRNOEImU3guI4NfSCXp+BT3zAkTRW25GlqUQuVgATOwuP7TTGtVv85yIm9IbHdHf+ClkisugJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBiqbqOeDQgUkLX5tbN69NoCi1/nowfhSxjE5sIxJsQ=;
 b=JWGvJiF23PhfADjHR9AV3j/UgAUkWA/34/tcksMTSVW/JtChk9zqYmLg1b415f04X5QPwr3384JD50Skit6jKutdCx9399L2n/1fzDpBUmzlDQ+IOionxF63EK4uv6wns63W5h8CLk5+XFlEOvm5mw+CVEQf/K8N9KDUAOgH1OzG+wU/5NvoS+vrw2zCS5o2eiDykoCC7vexeu43M0o3PkssknjNQEzc3YFu/OGMAfkDvvO7lzSw/SfRsKl+azdUCgE6Yzdxo/NFD306m0Vnbpc42Q+vdSl9pmK+ye8TvAHGtl25TIzYMFbv0shEHWttAHetIOfrfQ4nlFGx+VJJFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAWPR03MB9668.eurprd03.prod.outlook.com (2603:10a6:102:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 10:04:19 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 10:04:19 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH v2 iproute2-next 0/2] tc: support the netem seed parameter for loss and corruption events
Date: Wed, 23 Aug 2023 12:01:08 +0200
Message-ID: <20230823100128.54451-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAWPR03MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 84767899-ac92-40d0-aa25-08dba3c050f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NUdaMpyd/alXZhtbzgEMf9k+cHEAb809NM9aDZAbhGfMuWsWNMaPAMO5hfYCabgD6yy1euM19WIDOoz4MDPMn5wtQTDUHnfQ/dD84dVZrokQTGjeln8fnYIwax6Q5XsVZ1k4vTnWYEWWRwEldZE+RchOZnr9JZPHE/crigwozpjH5kN6BLwZ64pKciYzP2tgCassmyqzM65LuosZXu5LqkIPMOeLlCMWrAdPnDdPOok4hsXETPvwSkdblgoaAF6genUTsd4+v0L0kNOKsXGvnfZ/2cVBWuO73qP3BrscjnPqsfe4Y4gFXerw23HnebrEIrib5+6f1IC8DUDZVDA08bYHnOW6yQBPbyd2eh78J94OOz/hQuQXircPlio09eunWU15/NZ1k4MDLGVqgAwhrRYsFaMev0SAWLstmYAYRkvfAmuh57CTlCBPDNrWxv4NM0Wcfa37VYYjrWEdRdUTlkWvjYr4i0sBgGoEAMxsTqUl1xCrUMLUMFRTGt5BRUycj8civ2HFJxvwvE5aNlF1LEb5BKLxot2CXMI6D1WTpw0dQBmm4QNH4KCIcS8cPC2HSiNwWilu0bHQhiU18bCNpbnlXhzewngjXyf2JExzKXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(109986022)(786003)(66476007)(66556008)(66946007)(6512007)(9686003)(316002)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6506007)(6486002)(83380400001)(4744005)(66574015)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk12Yi8yODBOdSsra01kaUlHWkJJcEgyQnhmZjkyVW1Fc3k0ejlkQWhkTHN0?=
 =?utf-8?B?RHB6aDRvQjlhYkxsbVJWV0dQblBsSitMK0FWdmkzTk1HWWROWTVQcGJyQ0pS?=
 =?utf-8?B?Rm1RRWxnTWorSDJHOFg2T2k5KzFXMGxMNFV0bHpHV1lKQ3ZSU2pvRGpBRTBz?=
 =?utf-8?B?SFNCVFoxM1VqZGFQbjVibkFMSnh4Wkdtd3UzUWR6Zkk5aWdibzlKcDVZTjdX?=
 =?utf-8?B?cGIzMzl1bXZzNlpIZFkxbEdRT1ZtUWlCN2g4YWVGbGZFaFhQbXJndE9kelov?=
 =?utf-8?B?MGMzb1ZDRzBnU3BpeW12K2FnN09tMDZQdE1oYlNUNUxqRWVIejJjSkF6cE9j?=
 =?utf-8?B?OHFFZWJqaVd2dzYrT1E2dmFHdUcyRGFoM0RmTHBlTkp1NXZYUVE2WDM0ZWVE?=
 =?utf-8?B?cVZ3UjA2eC9SY1Q3ZXJRZFhwWWlJOFB6enArYUFtR2F5TTBJaWFac2tRL1NI?=
 =?utf-8?B?SmdsM2lDNkVnN2ZFVVRHV1JteTJhdjl3R2hSMnNNaEc2azZUcm5aWXkzOEZY?=
 =?utf-8?B?c3RJWnd4MUltR20veDJCR1NxRVdHS3kveHZMUG9rNVU4YjNkcklyOUErYzBv?=
 =?utf-8?B?NExMbnJPMXJyV0lscEhlK3A5OEViL2dxVmExSTJ6MDkxRHMwS016MEkyc0Z3?=
 =?utf-8?B?MFRGN3NyenR4ODA3allrMWhEcXhKSU9mbGFEQ3JKY3Iybk1pTGNaUDJmTDAx?=
 =?utf-8?B?cE9pT2dkWXVoNll6YitwdkJCdDUxbmJRd0xRSEFQaWJ0ZlFHekM5aTZrRVF0?=
 =?utf-8?B?YmVrV3g4cmlEQXNvZlVGNERTczFHTzlCSTB2OG90dXFwZm41OUY0cEdra1lu?=
 =?utf-8?B?Wk9FUnV2Z3JXNzkyL3ZhVzhvQkJ4QU83V1RENTdmLzlrVWVWekEyc1hHN1FN?=
 =?utf-8?B?SE5zTldwdXp3eUVOUFhsaWtqN0hFeThFc1BHNTJVNXFCYzhiOVlYVldjcVdP?=
 =?utf-8?B?akt0eGl0MFR4cjdTNkNNUTF4NEVDaXpBUDNYeTB3UExvcHlCNTBaeTJINHdm?=
 =?utf-8?B?NUNsQ0U2bHRWbnVkcmsvS3VFRHBUSCtWTkU1c2d3WUxNVndjQ0lueVhTQ2l3?=
 =?utf-8?B?ZW5hdjBJSDJnR2VLcHgyWmxqUW9COW9MSEdsMk1JOXN1dUtydktPcmNiTGNG?=
 =?utf-8?B?cEZwK3RBalNOdHA2TmhpR0l1a0orNUVaK1pmak5pakJPK292My9JeVI5ZmFt?=
 =?utf-8?B?VFA2Tk5qdHg3cys5VUtDMDNCdkVWVmdvNTRFR092bFV4UTlqb0tjZ3o4Z1BB?=
 =?utf-8?B?UDFPbUgxRjZmeVlQRVI4bEZDYWtHWG13S3hUblBpc2F3S2NwSXFWUUpVOTVs?=
 =?utf-8?B?UDRCY1BDVXlIMFJIakx5L2JYWEFOT0NpbktManJuaDhEeXZKRW5qbDZZRzNU?=
 =?utf-8?B?YmY3MHZPNFR4RENWMHRzYUh5clY0dEZGSUc0QkoveFd3eG5sc2V6dnFwYXNK?=
 =?utf-8?B?NmU3eWVZOGtYME0vYjdXQi9CMUNWUXJFSVBrdG1kUTlQdkd0Z1hYYy9LdDJw?=
 =?utf-8?B?eVZ0SUZKQjBOQmcxVTVBZDBKTWpZM0k1cjBrM3ZVeFJxQ0FqUkJzRVVORHVL?=
 =?utf-8?B?NGs0dCtKV2RjRG9NcmhSVmlXdmVJNG9ZclNKcHhrV2h0Qzk3MkMzNHc3V3ho?=
 =?utf-8?B?VU5BZDRuL2RxYU1iUmw4QURFUExoWkJVSWlmZzN5UEVWVVJoV1BtTDBldnlS?=
 =?utf-8?B?d3VCV2NRaGc3S3ByOXQrZmxQRFFjcUc4clVnUDBIb2xsWHJzdnRHSzBUQldh?=
 =?utf-8?B?aXowWWFLcU1ISzRFQy9qbm5sNlJYVnpCbHkwVFM5a3BSNmRsM1ZqQ3pGZkJs?=
 =?utf-8?B?M3NyanFjWHZhV0J3VGxoMlFDZFYreU1pWFFHWU83RUVyQnE3dlZvUGM0T1pJ?=
 =?utf-8?B?S3FxSXFwSWdZM2ozM003VWZwbGtwWWsvUHpaSU15WmZZUlkyNlVNQUhQemtI?=
 =?utf-8?B?OW8vcW5KNnJ5b1RNT3kvejRialdWdWxtWXIrZnBzTFV2dHo3ZXZzY25jbkox?=
 =?utf-8?B?TkJqL2hKZEhrVmtUNjROaitlNE1IUG9tcFFsTGRMUjFhYWJ0V09iM05IYXcv?=
 =?utf-8?B?a2x2dDBuU2lIL1BiSGZCR3FjYmpqUENXYXVTLzFhRURNTHJla3hxUmNlTmRN?=
 =?utf-8?B?Q1FXejFtNnZ4SlpCQmRYRnoyZkN1SHkxSGZsUm9hRUxoT1NIRE1EcSt4TEh3?=
 =?utf-8?Q?rPuPhaaMTfCAy8aHrlCMvQbIwNGj81oJFgpzY+wSjXVO?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 84767899-ac92-40d0-aa25-08dba3c050f5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 10:04:19.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFSnN6GzZVPzCtEo9M92iiTo1QxWQ9piWydD6WlV3kCgwRoJZ2tkAZt2G1X1186qXnDiWfGsfO34bpz+Rf/pKgx88RR9F2ddNAAkMVXj9gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Linux now features a seed parameter to guide and reproduce
the loss and corruption events. This patch integrates these
results in the tc CLI.

For instance, setting the seed 42424242 on the loopback
with a loss rate of 10% will systematically drop the 5th,
12th and 24th packet when sending 25 packets.

v1 -> v2: Address comments and output the seed value
*after* slot information in netem_print_opt().

François Michel (2):
  tc: support the netem seed parameter for loss and corruption events
  man: tc-netem: add section for specifying the netem seed

 include/uapi/linux/pkt_sched.h |  1 +
 man/man8/tc-netem.8            | 11 ++++++++++-
 tc/q_netem.c                   | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)


base-commit: ce67bbcccb237f837c0ec2b5d4c85a4fd11ef1b5
-- 
2.41.0


