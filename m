Return-Path: <netdev+bounces-267092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KP5MSXMsmlTPwAAu9opvQ
	(envelope-from <netdev+bounces-267092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF12733EA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C0CA30614C4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85F373BF3;
	Thu, 12 Mar 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGq6pr8H"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848A370D77;
	Thu, 12 Mar 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325148; cv=fail; b=n1HUCaEsMw6H/APHBDRUmuhGv3AgbYBJvW4bqNuXjsg/yOPAgTMI3nlUVhOQFljb2BH4nj1n111Y0Rq9xlexw44xIYAs4ixaINl1qwPLk2lFTGRWicVjlZjuLX7+Fs/QeL4D0W0dNQLUK3FWUZH6ecDR4WE4suunJbzNay4tnYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325148; c=relaxed/simple;
	bh=iTLbsWsBymUHhRyHZWrmSvCjSu9Ut924vnc4OCHhVKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3Wzw/6iQLrHgR5ObMJrfIw0WWh5eWt/g9J8fn7ZpS+6tCnDdBS9+glq81BNgt/529BFFEuhN1VdMlFFqzAXrGUjMv45i4Bo/Ks5KpVOYk6Q3XctlhhL1l43ezRdtGVmOrrlx8MQBgj9PQT0yIgn4YXFqTjHgT46ANa8qkQhiXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGq6pr8H; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyCj+hlKxzcrdP6dnsZzaWUzF6lnY2Dgaph9N8dK4g4BpqsG/3N/NkJcPDvIO1Jeb3Z8h58Q/Rnobi+vAqfqLWHbQoeBRQWye31yY7WjrfLDeHCDDrpPvP5F9FIVRE0/mtLq/rQYGJG+cccLPHA6bin4sWBSll9lBiz4Oth++BROVVP6vgZd6rn/VKOfruYCh/+A10kOOzc11u9XKvzt5FeoUjPrFtu7Wn4Dpk/nWjgnv17+u9bxVvsw61qi/4hzjBiM4k4klGU7NZT5089SKHdaSljJNZ91Ao0apu27o3FWxqntpFs7ti9uUMLE81fhWIt6pqMwW9e1GUFDXOxYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB1LQmA1jFhXpPmTu8aykwosQb6NaGRdKtM47OElSsk=;
 b=n32wUjHMPJ1JuTivs9lKJKf17kNwDPxwDV98ft9G/rUTFu6357f7TrWb385Sl7yHLT8vS5Gf02w8JIbYKpqJ5JuIV8W/f+xfhPADYP1mU/mdhwdDtR48Q/oJIu9LvT4TH+TAzkChgbuaLlbhrikBHXM+163Jy1KuqNppGfNIIF73uhTVEaibWWqUy6fo9uCPcMv2PyGYNoLx2exm7QWd6iCQcqg0E/zC6lpP4DL/2xW4Vat7XwV8tCy6pSAbSVviKSpW9NNlEVW2bp5/LmJDBKwdQKwyYcgOK6imudIzHxxuJJ1PEEGyx3I/XUT3J7j5Ktn/3DxsmSiqV7KBaMSMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB1LQmA1jFhXpPmTu8aykwosQb6NaGRdKtM47OElSsk=;
 b=JGq6pr8HYE+052OhqLZLaXXgmAjzGVxsSIFF+lYjWAHQobk/08B8ByoYT/4nJrT01gtSjINGgBHS5cE5R6/a2F8DTaeucDPIGvCsKuA8iiFaafHTWHedthw5pA1lYGiKvt2UlMUHu13UoZAKCDCe8YEjm2Pfwq9OuivZoDRHqxrvFxsuGMMkpJUJKTWs5umYLWZzWdXGfRsuccQZmd8XzrrCIY5AKG1H2txZOaCjik6aEfh6WCjpeCBdcTKP0t/vR7BpPuMmoxMVsx+gbr03Esa1brjRDowKR4gQnZQxZGmaW+wXJwdOBi+7A+IElh1spfbaBzGmZbsSRJ3kPz6Drg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:18:43 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:18:45 +0000
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
Subject: [PATCH net-next v2 8/9] selftests: drivers: hw: update ethtool_rmon to work with a single local interface
Date: Thu, 12 Mar 2026 16:17:39 +0200
Message-Id: <20260312141740.295353-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312141740.295353-1-ioana.ciornei@nxp.com>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e755a9c-43c4-4cff-9c50-08de80424575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	A55uSUZp5wtjE9S9pNS8VrIS0Z+WVf9svRlBafSMwChwAH5BcXXG7ING0GiWd0i0WXyUlY4StVuSNucGIwu90NuEuX+H7WT0CRSzz0W19OMdE3XQ8hFfq0Cf9e2og1K1d79t/T9Gnr+kLBJbl7GgYPW4SowSNP+EG9YhfCKUr+U5hb6F4YEMldA9lQNy1CmlU8yIuuaDeP49UWzArvrREtcbaY4sy0n15jt+4HLTVjMUHPqDoyy7pl2TYDAJcn+TpOvNX5HJ/CDPbLAGry3w5Cq3K6igdCe5a+ees1OYkzdzybacfk8RTtD58YV+ntTdrqdDsK1XfqGxlsMWiK5t+0EZOnUkb41MimNzhTO7+YNOq85T/a2BC/4NR7zX/LB5iCi1ufhVQj0Y6oBXF9UG/sUP0om+AwwyW3s+bY+Pq6wmZDsnA+cOSf35KL6C/zAXLLUtubQ/TInVbof52Dnbwm0ToKezOny4HJs2p5L3fOzSKYzEqIGJzFE3lWPoNq29r6lZxCwkm4zmjhLKKYLjRaE/tqCEBUOq2LuIirAJvsTLkmd9wGZjEpW04c2rtjoRQm34n7NqBXqeZjKqUpgkETjHO8iKuXExKJJo8sslN9+NKRioN22PXoMeAM2WbYZ/8T7Z+MbzsjHJLhQBhyj18eUEOupugpFbxYFXJG7d0GNQe8vlm7NQ4NzmeK/l2DRDNWTn7Vm+L9Qg7fccLOxEr3DRqi0Eg9C8f7Txga6JfYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGRURj/9CavggsTBe7YdmRV4K51ijK2+4lwLYHAQmD3yIhBXRhkcVS7F4noH?=
 =?us-ascii?Q?ovrWqxwFu9oL4nFjjCkqSgohP/5bDoaJDRb6xpMQkdeA7laBZRIacm/0mxJu?=
 =?us-ascii?Q?N5BLT+iHzk+Kpd8+wKjPCbSk42RW5agVaTl8H/eoslshdv9JdqK7tpL58Kke?=
 =?us-ascii?Q?Fr86AfCJTWArWz7RHgCb5SK83xPiKKn0TCtqLMjOW7A/H7bjHaxoJ+YsodzE?=
 =?us-ascii?Q?7MfQwIZM/2VI35ecOf9O57OM8UkQLyz7QDYX2KS844PCMeth6qxE8zHAhHDT?=
 =?us-ascii?Q?wXM6Ut+B5GeodTBOhVqgXJUR/D6c+AhXmJmacia/c6FnvHxMURD1NQ5XOZR0?=
 =?us-ascii?Q?xHE6dlhlNczK7v1jeoZv4UTbevp8Gbr0YcdTpGxSc5QrP5x5nhI7JsNNOU6b?=
 =?us-ascii?Q?c6uMCyp2npNe1UAP7cg4unoh6kqOpuI+CbpeNvsjPVcACi4arA8tV03EBTFi?=
 =?us-ascii?Q?6r7zUqVRi/UBdgKmndeJrEJudH71oCctzB2244EdQBIXeBIuSW5pwSie2x44?=
 =?us-ascii?Q?RR1GH9VYLErt7ztGvJUgqemgnj3vW8hFpVra4B5zfp7RLnR53rOy6cM0PWEl?=
 =?us-ascii?Q?hCBZNLhsLt9MORdINRjjaNpTaBN5awdbjXyWM2/EuN3WZ+4bD2eSHvj92T5n?=
 =?us-ascii?Q?AUs5pAZSviQ7lTYA7kS6i7PPZi2f6d+C3ukWWWUtSni10qhSCnhStm7eJbss?=
 =?us-ascii?Q?upsoQ8igK2hmWuOaG/Expnsykq1n3lQVcE0J5GWInu8TdWJ/N9zSz+9AMcK7?=
 =?us-ascii?Q?JgmaHWlWzF/WGYmdgFQa2Eo11pxaQGOvCLXG71NNhsgpTDyKWpQlqFcuH/qv?=
 =?us-ascii?Q?bKUyOS3NjOIu+FldCZvZkbR8dX98XdSv7J+hj3yu2A9CU5Qtsw9bA2BXsqoy?=
 =?us-ascii?Q?f1S4sjdp1ngsPdue5AP3d8dxl3NJV0lYhqCNLQN9DVbUjMj0M9XVMfozFMb4?=
 =?us-ascii?Q?8lGLATuDQIu36hrEHmZK7bVQ5g9zj5qFp0S8iWpb1TH62F+Jj+to8vl/bh6T?=
 =?us-ascii?Q?avq+eQlyXb+9DkqbrURKEHVnBFrj3Pp6m5z3mJ9V8g8pRWZjUQr4IL62NC7C?=
 =?us-ascii?Q?eOJTz/5x32WGlF4YlohxTLeeHqXr2iof+F/lfC4N/V43G+kUhFMElDnFWlLB?=
 =?us-ascii?Q?WnF/nwa5OmXeaDJoc37R19zQn9J/jlMObKi8HkfbZ5VB/fUh1b6m1nH3Cuwx?=
 =?us-ascii?Q?t1VUIuZCaAxdTg8H9UIMbWxGsE9wfKg6xfI88Q9CURb2zf6kibrvgDeoocUs?=
 =?us-ascii?Q?/M/mQ0Fu1dZAGch78GCR24HWRMKQ5nQkn8HzrJ4UqvOtKShjacLEOgMyEmVP?=
 =?us-ascii?Q?9DjjN5qZrvGyXPiU7mLrGVlBgWHuj6zZK8FuUfOh8VzDD+/GkvJJy9Sk+kFs?=
 =?us-ascii?Q?hRx6rvrnSxysSH0bEbpnsZAld3b+0YP0+OTZnUXN3AQbI3VBX/oWMSUHVObR?=
 =?us-ascii?Q?8pGe6Gc9TGioZqpuBRv/kyiM4c2JKFN002AMWKTlkOyZUx55Lg9CTtQYVkii?=
 =?us-ascii?Q?pUZpbe+eWvbAkDrrdLFI3zPVn/OE4zQy4lbR74ldrTJ08Ctj2AnKVEdNAcVi?=
 =?us-ascii?Q?TFUD8gpZKa5MFBWfwECwKa3OfMMBYzh5kP6bVfecaYmI7DFrk3YApN7MH/0v?=
 =?us-ascii?Q?gn8+zxPboZcQUq4JSDuIX6nVZEwD9+Xt3B5mGxpHk5Y6NgXvFX3aN1iF4ECg?=
 =?us-ascii?Q?M2y3b9a2l5B14m3avTYvVjTwgwoly5IlY8cbCVr4S0dLT6ds+/lnSTPc/RaM?=
 =?us-ascii?Q?woJq0uC4yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e755a9c-43c4-4cff-9c50-08de80424575
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:18:45.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTDbBmLoUR9yJjvYPpIhhJrR+HuFcAgSaKwi87HbzNQNpSnJkLLaTeM4uKeGGiD4fb0BurZn0fa88E8Ut8s/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267092-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,ethtool_rmon.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56CF12733EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch finalizes the transition to work with a single local
interface for the ethtool_rmon.sh test. Each 'ip link' and 'ethtool'
command used by the test is annotated with the necessary run_on in
order to be executed on the necessary target system, be it local, in
another network namespace or through ssh.

Since we need NETIF up and running also for control traffic, we now
expect that the interfaces are up and running and do not touch bring
them up or down at the end of the test. This is also documented in the
drivers/net/README.rst.

The ethtool_rmon.sh script can still be used in the older fashion by
passing two interfaces as command line arguments, the only restriction
is that those interfaces need to be already up.

As part of the kselftest infrastructure, this test can be run in the
following manner:

 $ make -C tools/testing/selftests/ TARGETS="drivers/net drivers/net/hw" \
 install INSTALL_PATH=/tmp/ksft-net-drv
 $ cd /tmp/ksft-net-drv/
 $ cat > ./drivers/net/net.config <<EOF
 NETIF=endpmac17
 LOCAL_V4=17.0.0.1
 REMOTE_V4=17.0.0.2
 REMOTE_TYPE=ssh
 REMOTE_ARGS=root@192.168.5.200
 EOF

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_rmon.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_rmon.sh
 # TEST: rx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: rx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: rx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: rx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: rx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: rx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: rx-pkts1519to10240 on endpmac17                               [ OK ]
 # TEST: tx-pkts64to64 on endpmac17                                    [ OK ]
 # TEST: tx-pkts65to127 on endpmac17                                   [ OK ]
 # TEST: tx-pkts128to255 on endpmac17                                  [ OK ]
 # TEST: tx-pkts256to511 on endpmac17                                  [ OK ]
 # TEST: tx-pkts512to1023 on endpmac17                                 [ OK ]
 # TEST: tx-pkts1024to1518 on endpmac17                                [ OK ]
 # TEST: tx-pkts1519to10240 on endpmac17                               [ OK ]
 ok 1 selftests: drivers/net/hw: ethtool_rmon.sh

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- patch is new

 .../selftests/drivers/net/hw/ethtool_rmon.sh  | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 1baaaab3c3a4..5e5fc80867a0 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -25,9 +25,9 @@ ensure_mtu()
 	local required=$((len - ETH_HLEN - ETH_FCS_LEN))
 	local current
 
-	current=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
+	current=$(run_on "$iface" ip -j link show dev "$iface" | jq -r '.[0].mtu')
 	if [ "$current" -lt "$required" ]; then
-		ip link set dev "$iface" mtu "$required" || return 1
+		run_on "$iface" ip link set dev "$iface" mtu "$required" || return 1
 	fi
 }
 
@@ -50,13 +50,13 @@ bucket_test()
 	len=$((len - ETH_FCS_LEN))
 	len=$((len > 0 ? len : 0))
 
-	before=$(ethtool --json -S "$iface" --groups rmon | \
+	before=$(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
 
 	# Send 10k one way and 20k in the other, to detect counters
 	# mapped to the wrong direction
-	"$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
-	"$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
+	run_on "$neigh" "$MZ" "$neigh" -q -c "$num_rx" -p "$len" -a own -b bcast -d 10us
+	run_on "$iface" "$MZ" "$iface" -q -c "$num_tx" -p "$len" -a own -b bcast -d 10us
 
 	after=$(ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
@@ -94,7 +94,7 @@ rmon_histogram()
 		fi
 		log_test "$step"
 		nbuckets=$((nbuckets + 1))
-	done < <(ethtool --json -S "$iface" --groups rmon | \
+	done < <(run_on "$iface" ethtool --json -S "$iface" --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ "$nbuckets" -eq 0 ]; then
@@ -119,8 +119,8 @@ setup_prepare()
 	h2=${NETIFS[p2]}
 
 	for iface in "$h1" "$h2"; do
-		netif_mtu["$iface"]=$(ip -j link show dev "$iface" | jq -r '.[0].mtu')
-		ip link set dev "$iface" up
+		netif_mtu["$iface"]=$(run_on "$iface" ip -j link show dev "$iface" | \
+			jq -r '.[0].mtu')
 	done
 }
 
@@ -128,10 +128,10 @@ cleanup()
 {
 	pre_cleanup
 
+	# Do not bring down the interfaces, just configure the initial MTU
 	for iface in "$h2" "$h1"; do
-		ip link set dev "$iface" \
-			mtu "${netif_mtu[$iface]}" \
-			down
+		run_on "$iface" ip link set dev "$iface" \
+			mtu "${netif_mtu[$iface]}"
 	done
 }
 
-- 
2.25.1


