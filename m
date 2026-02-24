Return-Path: <netdev+bounces-260670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM0/DBkwnmk/UAQAu9opvQ
	(envelope-from <netdev+bounces-260670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:11:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5747818E172
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AECEB3033E27
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B0353EE3;
	Tue, 24 Feb 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AvbFVnLx"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023105.outbound.protection.outlook.com [40.107.201.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7234B18F;
	Tue, 24 Feb 2026 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974674; cv=fail; b=gktYp8EWQSFXFp6Rm1ELu/bdxMg1iCuK5WfYmrE4jmE06aYGxvrCTMbqAvGf67yNaURoPiZ+3RGRXPZzQSs73OsZ/YapcWs6hnI6FHvqrU5wqsRFHhrJOfku9bUs8DzX49zP6kqeo2pAvMb2EmyXc4W0xgJckbovLXHCm+z9Szs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974674; c=relaxed/simple;
	bh=44Z3LEvu+77/ob4V1mYzmBKiYIZAmAzGZHf/nLtT2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQuaBTCehwAa42doE+LOEV3GSs+Gt025ji5+qzSlhigVdnTiL4IPrL8bcOvUxLfArS1tbO2rkhLk/P4MYCMeAci5HrsCc3glXicU+mq0iq99TPqdhtsrdkrtYG9uD5Lblk+1yN2A2NMPro0thFbG+76kb7/p7vtwNWX+dF2bHyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AvbFVnLx; arc=fail smtp.client-ip=40.107.201.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5N29j2wvHxdIvbvo/CqwTGPke5OaoBMQf8EQL2hDyNVJZhkSfwEl5HCfVaUZA4IWfnCho6sdiRf1aw/z5OmV+RVPYQLaWquCy0D6JmFKmR1PgduACgagOqIT4PIwBVf2tcHVYeprd7HQI/Lr4aHH4RflWEV1uzlc+JNlrPJSfxXVBReUUmMCCQt+8A+jVDVuQHZ1tC/hGrdgbc06qdOp2z3tuIC0iNWkXdmQWGHyR2s1NG3H21n1ZCc1Jtp/j6Q1ZShlJ+sLL9f+5M5LQuhX4fvYJz+hFgT/JFN7krDRFVutT7UEJ8ccUd/h2FF/oX8/BQXmSyX+vPpuv7pDM6xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51pfuFUG1X8DJ0IZdCPlMaMFyaHq8cUze8aUARdMP9w=;
 b=m3GM5G7R88jG9L2XtJuP7eU5YuhREiimaU7biLZGstrgBAyhgvcTwcavqwX+jkb7Wi//mti/09HQW5ucP+Ku8ynsNlcM852rsf3Jiko6lWZl0hU52LlcP3WBRZM69FFACrFxHi0fIseYsLSvYj4IzalitINEUS4t59bORbold1ciAsagSZnw+1qCwVf8YNrOzYy+0qztnmY0SW88mAtpXQ6cQVp5r44UsNKKQtlmkHyoaF+/eBzoCPV6q1ITUhxOJe/1vQfq+kN/gAqbO736TjcgQ7cZFgHF8wW/8tuKlnJxfru5Wy9yz8UW3+x6GB9tx9a1ekQGOJ6Uk0tfHTwEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51pfuFUG1X8DJ0IZdCPlMaMFyaHq8cUze8aUARdMP9w=;
 b=AvbFVnLxGK95TM3yhX40ne0zaqCT8W+0hp2wAGhMNxtMm5jF9x3otxh3oGkUz7uVt6tHfZZ43Y9Kdu+pMWZE106i8g70uIWIsfUkQkrNc+K/TPh3zvb/pT0QSEuxDub9UrlqtOhMjFj/HiY6nisGlOFCiLoUI117BN9dEFHNVoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8567.prod.exchangelabs.com (2603:10b6:930:c2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 23:11:07 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:11:07 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v31 1/2] mailbox: pcc: functions for reading and writing PCC extended data
Date: Tue, 24 Feb 2026 18:10:51 -0500
Message-ID: <20260224231055.393329-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:930:3::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3cabed-fab2-4f89-6e11-08de73f9fd77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZiK/LNX6VmqT5/6/NwX7t7Z43IeZfy3ZXNkAnWd9oydOVLnIHsellrkpcg2m?=
 =?us-ascii?Q?FcxdglgH1MQilmJPjiFjipMC8gEyTYXQeAfn8yoKmU1bp+QY+P6UIr860w29?=
 =?us-ascii?Q?iffSEgutuXnwCyP7y3CD8nkUKkLJ6d0xgYHXhdc2OyZ7UgMnvL6Iw9GCw3g5?=
 =?us-ascii?Q?kViM5q6W61INZ5j2Z2ElH60v2fHMo+W0XwHRrDNUJxOm6d+/TsEWZ3ria24p?=
 =?us-ascii?Q?2KvuZxEk01UeNQqUTFZCMyS/ykll1JzyjqHgXO3m5kufTJchfsYy8YRDmIx7?=
 =?us-ascii?Q?SB2lNb2gJEugg4uZXJDvgJxzN2TiLllu+lBtEMW8a7SYw1DeX+3Q2i1TjqmA?=
 =?us-ascii?Q?tS9ar2j3bTVoSRodoBlCmbzcTr0g+zQzVx5flaGYZoa6hpZpg751jnV5fpZK?=
 =?us-ascii?Q?7+cz4YNkDo/jqieYDt8ZrMhWN5M0WVxxP3ldjOSCA0RoHlnAUE7UwCnaftBm?=
 =?us-ascii?Q?WwHSJ/lqVDZ/O3OiHruw2GG61aDT0SW96v1ZzqQG+JxCSG7+Rw/4EY5BfyDv?=
 =?us-ascii?Q?mhSyWd4FZrgopz4TnLbykxjQlzW2tzX3iymxG+azezgvYE9IBujYriY7L0R7?=
 =?us-ascii?Q?XeuaNQK5T+EY9nFqDoK72qvDZv+mhR8lZs4C1T0613TIIlnWV9EHPkFSB4mw?=
 =?us-ascii?Q?0OsR79bsJRKGjQSWPlfk+TP9FCh8+I3N5YiGBkflxQQfYTaMI62r1Sl54FPx?=
 =?us-ascii?Q?Gc33+aLlxoaBTFXwFVzuCRB5S8HbPrDcj8+mAITxjr3HautYu5IhLMf5/ppY?=
 =?us-ascii?Q?XVJJia5FDokHLHXrGQ0XXB9UXrCYWAz3E2Li7lrgeQtSye8/mg1qxg1yuExr?=
 =?us-ascii?Q?/D9yzGZhkD/h+XRlrZNzgNdfJwbD1Nix7pTHGtVOAKUne2eHLJD97C6WIu/3?=
 =?us-ascii?Q?gymX0ROf7JhduC9B2rAhZkWmXuRWcGffZn+q7GgMkzvJ/qTPHFsTGLj9E9K7?=
 =?us-ascii?Q?V6egaXGARuXYkTCiptHjyUweY1tkxLEDnMsKhImqr1Mhg3A3W9gc+vzlzDB9?=
 =?us-ascii?Q?vGWVPNFBlu0oxGd7xP8qmsG+topxBvNTJC4lwqFMfWzHEuHOqOEp+BWOmBCJ?=
 =?us-ascii?Q?nP7Fx/9laIS0mf4OBELHZ2kXKNMVk1Zm55h6oEPBHIzVAQFMOkvf6wfuELBp?=
 =?us-ascii?Q?YWyHBtWvUXVqUvM70l4eRAavzQDIbopKf3teRciVkHb8DxqUsgEbRpYILoEU?=
 =?us-ascii?Q?z6ZvFrdULO6loSYAwBMG4eF9tAPNHuyDIw6kve/ozrk7T6VVM8l2K73BCIAn?=
 =?us-ascii?Q?C4C8ss/q5/CbKyBDjY31DF6NU61nfNVqAKIyDhmZsh3SMSoZA9vWPE9S6hvt?=
 =?us-ascii?Q?kJe1h04tdd7s0KHYxKSuLZWN7y+QotOtUm39QfzwC38xW8db0tbQ/v1V31qR?=
 =?us-ascii?Q?c0pq/Jd7z18kDJwj5Z0quZNg1KCr2TBz3/t3f4mF+vSPOBf1LDVkiXdKdwmx?=
 =?us-ascii?Q?blDatFv8mLlDqWB0ipzc8HP02YkVBnoN2OxfjlegeeSOa0y/+NxGoUxmQ1/a?=
 =?us-ascii?Q?EDTQZteqQyr8oM/oM+mYdu8edSdNq9HcJyfQ+AGySZ6OoyY4iDTOPGk8avC1?=
 =?us-ascii?Q?tfPOpEf6G1+hmm/pe+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1D4s/i/gOVMJgwo2dyRirBUM+XPWSnmKUoaC4zhp7yUDEYv4hB3mxGx2erR?=
 =?us-ascii?Q?8JAj94b6/azGFyoS2g7W0LdTI7InP0RujQIF5KQFSNXozhIL+fwgs/kSihzq?=
 =?us-ascii?Q?Oi6++7HvJR1iIZg1pR6JsNVbEqQ0FWezRywzUEXr6H7VXSdj+FG8Mx1NIgtX?=
 =?us-ascii?Q?xtv9jyYebGhmeoy9OBiFUa13zhzkcEy0GyQfDNlPZowaiG+6pAg3bIj8Wb2b?=
 =?us-ascii?Q?Rt1XBWj8IowsCV13PsJT5XZ3eKc15mKzTg146aE9HqIgrQele/g8AjPFSLrq?=
 =?us-ascii?Q?BVjaapTe2HKNrLO+ghnZTQ5QN2LJEf7jb+q1BU0ruOYir6Ev5jsvXYHfsIXb?=
 =?us-ascii?Q?BSpbKheGft/H9LtJ7yMUHIlNtiuNHqQmc72XVQ2EoeahZ58Qieej2wB8sLCn?=
 =?us-ascii?Q?UXwOJ2tlSYiRv66V0rZ6/qxA/8INHqHTN5RYx7OV1l38105gjcThQebFuz3B?=
 =?us-ascii?Q?FHb2R0UPDj8lYZP1eoOH/Z/bkvNk0AsYNn56nspLUNHIh097PhMK5BBLnCkW?=
 =?us-ascii?Q?Aci1hn6UkozC7EU5T4r6pB5K+COzT0/pwRnNaj1TD+L/4WpDsqvyRvAOFQNH?=
 =?us-ascii?Q?JdaDfke2UWrlBK9D+Soqe3NZuG01iE5y/gwjedn6INbfZ5jBa8S35dKqN4Ht?=
 =?us-ascii?Q?MphlNqzvGwYW9yW8Fuk+lpOKjuPautAXmrzxhDeVpc8ULdqOVt7Sbr0X4gsY?=
 =?us-ascii?Q?N37ot1bfNXdZJLHBKP2RlDEwhjP6WWNmzrxrMUMLsNU2WPxsHqyulRNeQB3h?=
 =?us-ascii?Q?JAYkA46ay0GfQy+JHv5vxC4vcdjZjVZEEEyqB84hEm2VnbtoSSgusUdzNz5F?=
 =?us-ascii?Q?ha/fXerm5JAkhhFkaySUiS8YnRPIp+NVndXfDoX8MzW54dviGWCVz1bLqkic?=
 =?us-ascii?Q?SwcPAlmNxCX8aLiJZgp6cZh9i3w2XC8EoTxN4EmleaKgKd+v5Sr7DwfNlQKf?=
 =?us-ascii?Q?w6pPARBZNd7X9WnlITfWkIloeG1rtdyW1oprjl7Sk3USInQE2Tei3ZaIY55c?=
 =?us-ascii?Q?E+Qa9hcoYe2K5bF3lk40OSbEI/+g3XfTjGWaWT/eq6DogoCufBCmHumoW0TS?=
 =?us-ascii?Q?40YPds7KlrUe3kgpVGopkwI+3tT6xtI2RNVtokNnl9nihEKF6+rOqLgTEH/x?=
 =?us-ascii?Q?H+IL/0BtwVGSA8iYP+HVo85XE/ZYIw221wuzs21+8neQGLZoAbXex5KkYbhr?=
 =?us-ascii?Q?SNiNvM4F1JqX7hjes5DMcsSpZbholpcIz/vcQ7igsDFbAcd1QcPgsNOxIxnc?=
 =?us-ascii?Q?PRxa6AZuz8ESvFBr3c/ihz7Yii3YTO3fOozyY8daAkGWcs7SSW4ogXT1Xz/Z?=
 =?us-ascii?Q?x4QTJwKQIMDOtYDVaII6JTVIPURfZckQW19htptN16ZlmAkb7oa03/NJ2pym?=
 =?us-ascii?Q?0rqapavJuq58johQi3t6pyELaNvgqecv9lCeypDaaRlYtwEpLrl3Lpqee3w+?=
 =?us-ascii?Q?G6GChCGz8wDIOroGlzFLEFkC+ZxbDJrZNsZPSOxLlh0JuBPPRak6wJe+WBXV?=
 =?us-ascii?Q?HeZY26mhdo0twb09AsTUZ/ay00cvJdp539pN2EohswgElk1tQP8WmYFwIKeO?=
 =?us-ascii?Q?IMTFX6krDXddlja8jcexfjCOqQfdwqOOwrn3HZ8+arGNGSFmfZOmwJM5lldp?=
 =?us-ascii?Q?QpWH+ZbkJrSnUB0SpYdPoM+tUBmiEyMLyLR4rHJrYMK+KSGgbl0yGzUR0Zgb?=
 =?us-ascii?Q?U1CCnrxnXZ19KWZrscNpfrPWto3OVEm0aeRjr+AJrtRg/eqlsC+dFHxM+1B4?=
 =?us-ascii?Q?i4zV2bEC5oW+mL9Pfor5G3aSunKg+JzdM5LioUp3lXQyGIhkzifj57FBjAcO?=
X-MS-Exchange-AntiSpam-MessageData-1:
	2INTxaqDU1i09Vy5N+iCyzy7Hgky4d172hpF2knLug7FWJxQ9FbkWIrE
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3cabed-fab2-4f89-6e11-08de73f9fd77
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:11:07.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mZCLlj8KlcWBow5hMd/3A/uWEf7rmWAuBJA5TPM6fUNGgbTulzZMKzfkeLfLsVEifO8eiGhB7tfbzeNGNwuetpvDFRHqHItWplH02xqlqt/j8cKz/wvaNFAAVBjA6rL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260670-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5747818E172
X-Rspamd-Action: no action

Adds functions that aid in compliance with the PCC protocol by
checking the command complete flag status.

Adds a function that exposes the size of the shared buffer without
activating the channel.

Adds a function that allows a client to query the number of bytes
avaialbel to read in order to preallocate buffers for reading.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h    | 22 +++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 22e70af1ae5d..8ccce401fcce 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -419,6 +419,92 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+/**
+ * pcc_mbox_query_bytes_available
+ *
+ * @pchan pointer to channel associated with buffer
+ * Return: the number of bytes available to read from the shared buffer
+ */
+int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
+	int data_len;
+	u64 val;
+
+	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
+	if (val) {
+		pr_info("%s Buffer not enabled for reading", __func__);
+		return -1;
+	}
+	memcpy_fromio(&pcc_header, pchan->shmem,
+		      sizeof(pcc_header));
+	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
+	return data_len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
+
+/**
+ * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
+ *
+ * @pchan - channel associated with the shared buffer
+ * @len - number of bytes to read
+ * @data - pointer to memory in which to write the data from the
+ *         shared buffer
+ *
+ * Return: number of bytes read and written into daa
+ */
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
+	int data_len;
+	u64 val;
+
+	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
+	if (val) {
+		pr_info("%s buffer not enabled for reading", __func__);
+		return -1;
+	}
+	data_len  = pcc_mbox_query_bytes_available(pchan);
+	if (len < data_len)
+		data_len = len;
+	memcpy_fromio(data, pchan->shmem, len);
+	return len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
+
+/**
+ * pcc_mbox_write_to_buffer, copy the contents of the data
+ * pointer to the shared buffer.  Confirms that the command
+ * flag has been set prior to writing.  Data should be a
+ * properly formatted extended data buffer.
+ * pcc_mbox_write_to_buffer
+ * @pchan: channel
+ * @len: Length of the overall buffer passed in, including the
+ *       Entire header. The length value in the shared buffer header
+ *       Will be calculated from len.
+ * @data: Client specific data to be written to the shared buffer.
+ * Return: number of bytes written to the buffer.
+ */
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
+	/*
+	 * The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
+
+	if (len > pchan->shmem_size)
+		return 0;
+
+	memcpy_toio(pchan->shmem,  data, len);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
+
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 840bfc95bae3..9be1ae358056 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -37,6 +37,14 @@ struct pcc_mbox_chan {
 extern struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
 extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
+extern
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data);
+extern
+int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
+extern
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
+			      void *data);
+
 #else
 static inline struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
@@ -44,6 +52,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	return ERR_PTR(-ENODEV);
 }
 static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
+static inline
+int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	return 0;
+}
+static inline int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
+{
+	return 0;
+}
+static inline
+int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	return 0;
+}
 #endif
 
 #endif /* _PCC_H */
-- 
2.43.0


