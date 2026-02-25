Return-Path: <netdev+bounces-261010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MWWLtsRn2nNYwQAu9opvQ
	(envelope-from <netdev+bounces-261010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:14:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC319956F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64319312F111
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895A3D902F;
	Wed, 25 Feb 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPAymYZA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04763BFE44;
	Wed, 25 Feb 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032066; cv=fail; b=POh0xFWSNdnV8vxNIpALANVqwqlotgzqFWroO2c8FDffpFmZJUGhcz16P1iTj3LBt9CWnFq+VziA1msf5wHm8+0Qlgj2t3fvtPua2OqT/NVZzlHo2fNI3ciXIyIsLK9r3v9WcF4ZRYHOynBlsncqTuc56oAY2XbmITxyYZ3C+yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032066; c=relaxed/simple;
	bh=PQO5vDQEqTDWvjCnVquC4Y8exfD0WSOUycvhMpBumz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DharH/47bLFvX19C9wvI4fAdP4Rg0JV6SlkbXqULRsBvF4s//13D5rKte7rRd6YhKqkl5/MhTFTQVRpWm44aJrUcw54kT/q4QlDEcR6O6PA5FWzfkJxj70RlG9Mpd6le+5cgoKSw5MeQXfsHaC+VtdnG60kV8CWaxXzKNtNivQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPAymYZA; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4RvAUff8bnuBPBVkKcC+0bHCYIy2Nc4HWRP3jYVkFlVyljPZDLQ/8lTgHGA5DtOV3CNH9p10S8jEUGPCTXpj7x++ca8YQWBZwCsX+0laP+yLWtDWAB6Ys6pP8Mx4DnNsoL7GLwub/0b8d8ZrESYiQn1SvPKbg1UvhfqEktJSwFx3SHOy8aoP1bl/X5/rEGE3P+DojI0RXKUnp7cDN7arSDWtCo92qI0LtoZ9fBm/fF/5IMwhmY5fYxEoRBAJsk1MXpkbQ4zncVbsblEspLyjlgaVl/haF9SpZ+VMBCExkBFcfGqdYWdZopW7ixaDxiLV/BsxFKcEOQ4DghikQBHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFCgxBsBYdqyHXkMaV2rU/V2QyybD6jzSItU1/Fj4Ig=;
 b=jhHNcdwJtwwSqxIHL3VZnlCn1Mh5Ky3voU8iaaJIk3JJW86RRdf2BnnS8XTM5317xpywG9aV16MuTQbTEavsewMQu20gQVUs0htOhpDjjgrpcQEJzmvDCq2bdzbAm1BDMo7k0SYGtzDJY+4NYm7LfFXHPiQXPOiwPx/DAUo7ytYfJvuN9o089NbwRvFzCViJ+d0RwKPyLWqu4cn5efmQOALD9r8vdvGaTJn5OZgKwTx4QOAeDhj8TJSLZpWyIL48AmBUqv1r/yyZsk+jYGQDZEdns21gdgk5VdHf5q061uPPbQhmPQ3BeceR/iSYwmStR06iArkbGHg9JXVjUY2zIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFCgxBsBYdqyHXkMaV2rU/V2QyybD6jzSItU1/Fj4Ig=;
 b=cPAymYZAkfJutePfIw8iMoQ9esnaRo06e9NQePupUsJQ1lUzxd/oz564NOShIy43JYltm/2pIAmsv/ESDGO4mAiQ/u8CQ2dAbzI4Z1ucd6SKD9fQnPQpRE8P0TBkoLkbHG+aRJswk8k9h6UfykCP2VR6ac7nMouu9CouwTutLmd5i28OYanpI1LDxQJdSIDV9Avx48SCEhEG47Um7Jd4qCkqgvQUrKlV43pepYCPT/Zf+FoyGKY0rGTUAeLZpS+rjqlPGQT3tCTCu2SPjqf+xsBNxcaPfBXdZKzfrqFKCEYrCRwjOVV4MHzRlJmw7ok2Upt5MiYUGpsusY8Tm3XgKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:40 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:40 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the ethtool standard counters
Date: Wed, 25 Feb 2026 17:06:48 +0200
Message-Id: <20260225150648.1542206-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 8128d41d-0f10-4136-a788-08de747f9e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	O6Oziv4q6ouAwBTKTZQhs3J9wm9iy3gTwzirt0C3+sw6Y5Dt2atos0bJO9QgzQGawZdZ44UPG8IJ4OcPhzKfCb+zmklg5i6t/leMVUGfuYY3j4I3cCe1Ggfe/DdmvTZUa7pZlfWaNp4jTYsh79FUq2UkUoRwILdXGmn3Y9c2SKLZx9vKd7mbuXL+1S4c0MSpTk+pNjDqfQgKSWj4xzojhlSWtWWnFgVEE6WI1v83cjOeuYSihbI4HCFc6WB2t2u4UYdySqsWY3cam+fTYJQvGwMNNwszhiyl0yuTNBDFXigqdzQohgsuwHwaHdBQPzpCFUcpBsAtLp5RqdFHm0vhgXgSxs2rZ75sneIwjsM6FNPhB85DCSRhTJizwSFJVUBhcIzGBv5OLEaOEYUiwHvgclSJIt9XdpDYkF/0q8Vzj4lvlwyOaTjjjf3nmtwwozCf0p3OQeVWq4yg8gOoVBIZAVHcW4vZxXZCm0Iivsbvc44bQGrwZg0p7+YIaJiHivChST0Iq5Aud5xgnyYx9H7tCcXa6LAbsZ1RrnObaRxerWdBtUYZkA5KjetbR50/jLQgq6W1l+9ySwSMC/CdCU4oeIZmFMTNAX6X45eFjK3ircqE1K1Bh0m/jy8uNHkmArkzCqDcS11u5qzYyA7y3F/+fWgkWd+joodE5Kp+eIacZsPQtrkmAvigYpNcc7WHOlsmSLqgBN9+/tHbW559S2YWX4pB6k78Gs98q6LCRhxKMRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8SX25Gr4MZAlvyF/WpDWWjIaYoy9Q5LZDmnWGixhYQC9NG16IrLb7EPpuuj?=
 =?us-ascii?Q?i2a3LvTHL6KNjvFhp7I0V2Gl2BCnUkLpUjh0s2s355dLji1ImQ2htEsePlN8?=
 =?us-ascii?Q?yDy2V8KWAq38yKV9kNEO0U6mRIKi6sIOtmQ0WfWWshr0wGpH7TkHhDtDGIzB?=
 =?us-ascii?Q?7VBcCq/xCYjATQ/aASsvV6qfS05nT8+VvknTXZTHJG3rBWH6chvwk2GKCNtv?=
 =?us-ascii?Q?dEkb8yDjtVrhqOU4wywzg8C0DCrhvgQtX22LhKg9gWv9edDB3l/EcEiStYtB?=
 =?us-ascii?Q?kZh6Rf7O6bglfTtujPEdd86YoaKnYISdbQq1eru7YCRqJddlyNWxAOV9ectg?=
 =?us-ascii?Q?x5abqCYFpXB/Di0oZL68qG+RdzhqU58K8T+0f+CkCtCl+O/LzihZdBOqnN/N?=
 =?us-ascii?Q?t2H0s2jkjtCgYbFcApgcRETmppEAYx+cimQLCOQYfhCpW80TTKG9d4mCoNfy?=
 =?us-ascii?Q?w2ckxLJXTGkaJXKpcAkq0uSegD+OLG74QNyp2hcfsAXuZonD9eYkJFub4IS8?=
 =?us-ascii?Q?haCkaw6vPOyAAAXPYE2+NR0+L9G9DS8oB00uTQIuqDk4jCymDR1RfEy/Wot7?=
 =?us-ascii?Q?HGxvA+FUQJmSHt8rPraZc/p0OfzG4dnXqwBFQfj1Kt7gCMDevHJwx1h+j1N7?=
 =?us-ascii?Q?Euwr0sekv+w4SLzYoQ8yiURbulPEZsvXXiAffuLa5u1IStaMFQ0DDVi/WATR?=
 =?us-ascii?Q?JVPkaaTEVPT3du/RfSFlcG0o0kqFRkLG6kItOAshod34280vjcAGdPPXKFC9?=
 =?us-ascii?Q?Tx2Ll4uOopw8GBwuIhCDsc8GclJiarGbPxSNh6AGGjo3DaoJh4G6pI4C4tpA?=
 =?us-ascii?Q?Iw35sIX9G1tx9jhXxDGJKsS5PMooXhcjf2jIZjxE/xEA6ERhoa2uRsuVYZ47?=
 =?us-ascii?Q?r2UigC7aoOPaaLQllPgcNZLAksZ+GL5K62PZ1LoKI1H4ObtRipNJshI31zhD?=
 =?us-ascii?Q?KSU1qjh7JiHgXKVePPLszaGvOWOeXdtndPpxv4eWe/w0zocrWSzbVICqTXkS?=
 =?us-ascii?Q?wwbVg8nPXtTN4IKFmMnx6tTSCVAGDq8O0l4M0KsBXYDyyFf+f9Z28VCb7jKC?=
 =?us-ascii?Q?lKmCIY0qjQs53riw13mx+VyeFA6R/WZT02ESfKehrP33QHL7IeQ3WCHD/9BH?=
 =?us-ascii?Q?6Lo57NltggI8JKiCodc9r/K3L8uQCJygDkyDlBpfOhLUtYyNDOgQoyOP3TO/?=
 =?us-ascii?Q?W67XZhgK5jfNVXJMfitJa5bsoTBHEBeok7KLFHiWMGyYrL5kkg4EwGYg8yN/?=
 =?us-ascii?Q?sl072WNWZkSf/IATYxFITD6qtOy32ovaL8VmQSqN8SOtK5muyYVailadK5zB?=
 =?us-ascii?Q?+vNmoXz3uUYNMsbkV/EwOeIxtGWES1KrQJqJkF39pwkHcsI7UpaX2MEbeZNh?=
 =?us-ascii?Q?NelJmiGexDyhRV8rmvPJd7DZxVDAZzBt0todS4QMmRQ89okq6e7+R3rwlrI8?=
 =?us-ascii?Q?P4hH9xobOfd0SHZdGRKKj0nziPh0RDk3aNVW0WSnKYz8qrBpvWYtDbjxmeeq?=
 =?us-ascii?Q?2dgB9LOGEc0YsyIHHMjqpTYbNyLIRQCmbuu4xTvVlRPFFig7L6YdAC2wx6Dt?=
 =?us-ascii?Q?DDZMGhuaVWIsYwuk+IP880cdgCmuSfxjDq/5EM/6OqNYCi42/crwHhmirqVD?=
 =?us-ascii?Q?HhigK8GZ+tF/AiHSzjtxNbkBGPTuKj3g8WxRCbxRdB/fFhUzN8mflVHAh8le?=
 =?us-ascii?Q?XBaoGLSM6FLuIJTe8zbi0TERXhXnXH3RBjmDBtAvl4vKtaNBs+Nl7RobGODZ?=
 =?us-ascii?Q?fsA6Mo+YKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8128d41d-0f10-4136-a788-08de747f9e87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:40.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXVtCi2IZJfkm8KjMgQeRVaLzVUMaS+leuAo33o7oijtwHaXKL+zBhQWMxMSn7mDOvGN6X/MRopeNyIAyIyzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261010-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:email,ethtool_std_stats.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42CC319956F
X-Rspamd-Action: no action

Add a new selftest - ethtool_std_stats.sh - which validates the
eth-ctrl, eth-mac and pause standard statistics exported by an
interface. Not all counters can be validated in software, especially
those that are keeping track of errors. Counters such as
SingleCollisionFrames, FrameCheckSequenceErrors etc are not tested nor
included in this new selftest.

The central part of this patch is the traffic_test() function which
gathers the 'before' counter values, sends a batch of traffic and then
interrogates again the same counters in order to determine if the delta
is on target. The function receives an array through which the caller
can request what counters to be interrogated and, for each of them, what
is their target delta value.

The output from this selftest looks as follows on a LX2160ARDB board:

$ ./ethtool_std_stats.sh eth0 eth1
TEST: eth-ctrl tx on eth0 (MACControlFramesTransmitted on eth0)     [ OK ]
TEST: eth-ctrl tx on eth0 (MACControlFramesReceived on eth1)        [ OK ]
TEST: eth-ctrl tx on eth1 (MACControlFramesTransmitted on eth1)     [ OK ]
TEST: eth-ctrl tx on eth1 (MACControlFramesReceived on eth0)        [ OK ]
TEST: eth-mac bcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac bcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
TEST: eth-mac bcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
TEST: eth-mac bcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac bcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
TEST: eth-mac bcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
TEST: eth-mac bcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
TEST: eth-mac bcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
TEST: eth-mac mcast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac mcast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
TEST: eth-mac mcast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
TEST: eth-mac mcast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac mcast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
TEST: eth-mac mcast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
TEST: eth-mac mcast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
TEST: eth-mac mcast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
TEST: eth-mac ucast tx on eth0 (BroadcastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac ucast tx on eth0 (FramesTransmittedOK on eth0)        [ OK ]
TEST: eth-mac ucast tx on eth0 (OctetsTransmittedOK on eth0)        [ OK ]
TEST: eth-mac ucast tx on eth0 (MulticastFramesXmittedOK on eth0)   [ OK ]
TEST: eth-mac ucast tx on eth0 (BroadcastFramesReceivedOK on eth1)  [ OK ]
TEST: eth-mac ucast tx on eth0 (FramesReceivedOK on eth1)           [ OK ]
TEST: eth-mac ucast tx on eth0 (OctetsReceivedOK on eth1)           [ OK ]
TEST: eth-mac ucast tx on eth0 (MulticastFramesReceivedOK on eth1)  [ OK ]
TEST: pause tx on eth0 (tx_pause_frames on eth0)                    [ OK ]
TEST: pause tx on eth0 (rx_pause_frames on eth1)                    [ OK ]
TEST: pause tx on eth1 (tx_pause_frames on eth1)                    [ OK ]
TEST: pause tx on eth1 (rx_pause_frames on eth0)                    [ OK ]

Please note that not all MACs are counting the software injected pause
frames as real Tx pause. For example, on a LS1028ARDB the selftest
output will reflect the fact that neither the ENETC MAC, nor the Felix
switch MAC are able to detect Tx pause frames injected by software.

$ ./ethtool_std_stats.sh eno0 swp0
(...)
TEST: Not all MACs detect injected pause frames                     [XFAIL]
TEST: pause tx on eno0 (rx_pause_frames on swp0)                    [ OK ]
TEST: Not all MACs detect injected pause frames                     [XFAIL]
TEST: pause tx on swp0 (rx_pause_frames on eno0)                    [ OK ]

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/ethtool_std_stats.sh       | 192 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index a64140333a46..d447813a14b2 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS = \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
 	ethtool_rmon.sh \
+	ethtool_std_stats.sh \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
 	iou-zcrx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
new file mode 100755
index 000000000000..4ce8f140a18c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
@@ -0,0 +1,192 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+
+ALL_TESTS="
+	test_eth_ctrl_stats
+	test_eth_mac_stats
+	test_pause_stats
+"
+STABLE_MAC_ADDRS=yes
+NUM_NETIFS=2
+lib_dir=$(dirname "$0")
+# shellcheck source=./../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+traffic_test()
+{
+	local iface=$1; shift
+	local neigh=$1; shift
+	local num_tx=$1; shift
+	local pkt_format="$1"; shift
+	local title="$1"; shift
+	declare -a counters=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"
+	local before after delta target_high extra
+	local int grp counter target unit
+	local num_rx=$((num_tx * 2))
+	local xfail_message
+	local src="aggregate"
+
+	for i in "${!counters[@]}"; do
+		read -r int grp counter target unit xfail_message <<< "${counters[$i]}"
+		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
+	done
+
+	# shellcheck disable=SC2086 # needs split options
+	$MZ "$iface" -q -c "$num_tx" $pkt_format
+
+	# shellcheck disable=SC2086 # needs split options
+	$MZ "$neigh" -q -c "$num_rx" $pkt_format
+
+	for i in "${!counters[@]}"; do
+		read -r int grp counter target unit xfail_message<<< "${counters[$i]}"
+
+		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$counter" "$src")
+		if [[ "${after[$i]}" == "null" ]]; then
+			log_test_skip "$int does not support $grp-$counter"
+			continue;
+		fi
+
+		delta=$((after[i] - before[i]))
+
+		# Allow an extra 1% tolerance for random packets sent by the stack
+		extra=$((num_pkts * unit / 100))
+		target_high=$((target + extra))
+
+		RET=0
+		[ "$delta" -ge "$target" ] && [ "$delta" -le "$target_high" ]
+		err="$?"
+		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
+			log_test_xfail "$xfail_message"
+			continue;
+		fi
+		check_err "$err" "$grp-$counter is not valid on $int (expected $target, got $delta)"
+		log_test "$title" "$counter on $int"
+	done
+}
+
+test_eth_ctrl_stats()
+{
+	local pkt_format="-a own -b bcast 88:08 -p 64"
+	local num_pkts=1000
+	local counters
+
+	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
+		  "$h2 eth-ctrl MACControlFramesReceived $num_pkts 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"eth-ctrl tx on $h1" \
+		"${#counters[@]}" "${counters[@]}"
+
+	counters=("$h2 eth-ctrl MACControlFramesTransmitted $num_pkts 1"
+		  "$h1 eth-ctrl MACControlFramesReceived $num_pkts 1")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"eth-ctrl tx on $h2" \
+		"${#counters[@]}" "${counters[@]}"
+}
+
+test_eth_mac_stats()
+{
+	local pkt_size=100
+	local pkt_size_fcs=$((pkt_size + 4))
+	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
+	local mcast_pkt_format="-a own -b -b 01:00:5E:00:00:01 -p $pkt_size"
+	local ucast_pkt_format="-a own -b $h2_mac -p $pkt_size"
+	local num_pkts=2000
+	local octets=$((pkt_size_fcs * num_pkts))
+	local counters
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 1"
+		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
+		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
+		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
+		  "$h2 eth-mac BroadcastFramesReceivedOK $num_pkts 1"
+		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
+		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
+		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"eth-mac bcast tx on $h1" \
+		"${#counters[@]}" "${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
+		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
+		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
+		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 1"
+		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
+		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
+		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
+		  "$h2 eth-mac MulticastFramesReceivedOK $num_pkts 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
+		"eth-mac mcast tx on $h1" \
+		"${#counters[@]}" "${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK 0 1"
+		  "$h1 eth-mac FramesTransmittedOK $num_pkts 1"
+		  "$h1 eth-mac OctetsTransmittedOK $octets $pkt_size_fcs"
+		  "$h1 eth-mac MulticastFramesXmittedOK 0 1"
+		  "$h2 eth-mac BroadcastFramesReceivedOK 0 1"
+		  "$h2 eth-mac FramesReceivedOK $num_pkts 1"
+		  "$h2 eth-mac OctetsReceivedOK $octets $pkt_size_fcs"
+		  "$h2 eth-mac MulticastFramesReceivedOK 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$ucast_pkt_format" \
+		"eth-mac ucast tx on $h1" \
+		"${#counters[@]}" "${counters[@]}"
+}
+
+test_pause_stats()
+{
+	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
+	local xfail_message="Not all MACs detect injected pause frames"
+	local num_pkts=2000
+	local counters i
+
+	# Check that there is pause frame support
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		if ! ethtool -I --json -a "${NETIFS[p$i]}" > /dev/null 2>&1; then
+			log_test_skip "No support for pause frames, skip tests"
+			exit
+		fi
+	done
+
+	counters=("$h1 pause tx_pause_frames $num_pkts 1 $xfail_message"
+		  "$h2 pause rx_pause_frames $num_pkts 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"pause tx on $h1" \
+		"${#counters[@]}" "${counters[@]}"
+
+	counters=("$h2 pause tx_pause_frames $num_pkts 1 $xfail_message"
+		  "$h1 pause rx_pause_frames $num_pkts 1")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"pause tx on $h2" \
+		"${#counters[@]}" "${counters[@]}"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	h2_mac=$(mac_get "$h2")
+
+	for iface in $h1 $h2; do
+		ip link set dev "$iface" up
+	done
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	for iface in $h2 $h1; do
+		ip link set dev "$iface" down
+	done
+}
+
+check_ethtool_counter_group_support
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.25.1


