Return-Path: <netdev+bounces-263427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJNL51Up2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0521F7A0F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D0D3304C17E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1B4F797B;
	Tue,  3 Mar 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V4aKEUDd"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004F4DA535;
	Tue,  3 Mar 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573831; cv=fail; b=Q/DascuywYpft7fRc5Q66E+7zwEMsYVCJbjtvnLAYZpjuh3Zm3O2BFLTM148J7ZQpn9rFWUVRJi6sVZjxDYvvQLMm4eYIULR40pGiZ0qwJZFM1qiCGUn/MW9hZe+lx+ajuSQwlVoVLfjpTkXSBHpPLmBH/Bsn8ag44yt0UKahKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573831; c=relaxed/simple;
	bh=S4jnRYaUiPwgotwBbPyWc9LuGBLOAe39+qTZEI5WQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/2FRoy5dMeRp/EdjOfjFRApHg6JutsLEOUc1xSzfvSS5Qcc/YKocD3wJp9AxYZZDtTYws+EXWGXWKT/+inHGEz/TWWbQGrCNLUyvGPfXM5lC2pVar0rjIoraz+rqnBiD8QVQ9FI0g05W7eFpUM6NqM6sUdaRFLeKwfLSOK5Nb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V4aKEUDd; arc=fail smtp.client-ip=52.101.193.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7zZCPfDsgcN68gfS1Kxfx7/Wlb0XkNEXKq1lblViPm+hWDaWYaEXyd0UIOEzU+NIEUJtOqj0ye0wwtJjah12rqewpQZrWWf9XJhiMJcDrobT0UQj94pokY/LhcmtUgruQK+iBQGRMe+kLFuTbe+9wwiHRBU8lufU58SNpU0gfRX3yJBKngJ7IDydv+2a8tUktQh0LK+h3w4UkZcyx/eo9F9rcAwqHYCvvuz351XIRQefgU6ypJplMans+HQ09KW1+3So6y5V/0QeIRcw129YPrurJar3/YLlJSVDbKBvNtAU7krVAfAVe7Jb/PS543f5OA1jU9P4OEs4uqgkgYvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWfHDE9i3qQbjbuD6cpNJFQQEXtuczteLVNRSzlCGbo=;
 b=VobbonT/3v9JjCqdYwsQch5KgVd73tmX4Baf5+9poa3G3U4QEo9pewPHt2/gYWSqHI1p9byXL5Zx6G3h9ud+DnH7RivZyA4uGa21mrVkZ1mtbT2uCr1ZrrZXPFWc6r62zr+aaJtxIpKNfuBfrVhyd/L8SghMdiKFs0kFIoQ9rPQbjZ82EjFT7W4f3A204uPpCDxqSo8j1Hn5rC0n2n443lhPPSsno12hKiLUELDG3AZncL9b9GAzVPVYBCrVQpVlDFtth+HKTab4aWWIeiK6gJ9l49yoj06kvoi65jTheAc6XqtRzPKyDW6HWjWd6GO4WFGQhGtMvy4Ve0hHa0xZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWfHDE9i3qQbjbuD6cpNJFQQEXtuczteLVNRSzlCGbo=;
 b=V4aKEUDdSJyePD2jPMPvajaedsrYbwH6MQVWgnBZ59dwaqui1qwWIN8zanFqbn6L8u2/gsZecpHdRXdOS7MLSSHd/Hx2BUjtrRBlRNOP9KNGeqxtdnOqGCn9BfzLoGnlSQMCVVcd6aTm/NRqVJhQF21zOfOEIQmzCMxIYmesuwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB8916.prod.exchangelabs.com (2603:10b6:303:26f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 21:37:05 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 21:37:05 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v32 2/2] mctp pcc: Implement MCTP over PCC Transport
Date: Tue,  3 Mar 2026 16:36:46 -0500
Message-ID: <20260303213649.237851-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
References: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:930:17::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: eb81c2bc-d01b-4f2c-0b4b-08de796d03be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	f5Qhzf0BhDC5biiDsLn8/odM7fc72cb52BXAy8mToPytMUNqgmfBRqvapst4cBiquou/0aPFE7BPJqiXJl68NMyVORgpp3V6QHz2yq8SdsZ0hZuPk/yKGdAAi8xC6RNAjt3Wfrxjut4/PweowWaJOO6t/mur68Zne5sN0/wuP0HEjIwoS9fCcj185MERD3THzDmdZaw3GJ5pYhIlR/R6/IYxhm7nGFj36OR8lZFrE4WOlh59OJ4K9OZz5wUyOr88WC29AMQAA/dIswbSTZJgtPCbLBM3lsN14cxtnGQ6ccJs2EoyACJLCPxV6lxqXBvQ1X2aQNbbdhLVIXK+Q0cnAI9AhmaR1ncaNeWbrRj/yvkTKZJXtfqO/C6WbHMJlzUojq4WPA2wtsM6j5LHfIiyd94DQ4Ne8rSJzXu0SChJIUX4GMI6WTWk1bXeiMAy39UfFRshjKPi1r6z+PrTy3WRCMCuNFIli1+BosdXcSbWXRnRmcxcBJoaWZdE8gtuP9/5qGbHiAFIvAo8gC1jjqgy+7C9tp06YhL4cWVb8lETwCh0wD0hI6ykidtySDFEGQbwNC7CNUTpUuLPCnwIZoaiueWjcWBzV4IGdygR4ob3syt1BOL89l70E/YBwT3+1NaH9Db3kddLgY4Uxmzd/EsdcH+Ck+N22sLu1OFnIfg42PbO3cUBLum/ZjrBHXTcFd/f30oP5uGWEq+9YZZjsYP0NmVCJi1S9sVHYuRyf4GnmdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(52116014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6Ixdw31ntivZWtBqskm5hjA8Mhxalo40jVt8JlJJgHSYlNubhV2f1mfDX1T?=
 =?us-ascii?Q?o8WDXqhPpYj00Tlyn5Iawn7yMxdG0JnHw9407OjCoeG8u9VKtXkJeRk+ya+Y?=
 =?us-ascii?Q?dM5ZfhVtgZjN+aql6NZ26HxB/JDIjFgVJgxAdXaLG6WBrD5+y2Dj16awBbMF?=
 =?us-ascii?Q?JkJP7xCis9lbPkVrOeYnppxSsSejznztv6Q7QFwmqa7LYI/ZEXuN4Ee2LFvA?=
 =?us-ascii?Q?VOFGlvNjI/eVgorhAdafOeddXwidkDSVysbmcFNBF6XLdk6j9ENO99SSQsxu?=
 =?us-ascii?Q?4TLuRcpy0ruGISA5CVXknMSE6o7XoMTOCApu/lRQeIS+UhJtH3sRQab1kE05?=
 =?us-ascii?Q?ImK9zwSZJ7XZO/fvUNFfEF+npLywjiAMbDTLXVm7pB/3m2pZH3xn/yxwYuiZ?=
 =?us-ascii?Q?EbVWIiGw5Kk4H+zyDsK0GGhHmlBtImok1PBRmcK4qfch737qceAbRDbWI2mH?=
 =?us-ascii?Q?nlJ32qa26WwPg3LZ5DZq8XoNIO5zxQmQMh3k88W6U3ZhQg44hQim+jBwjnSz?=
 =?us-ascii?Q?08zBOrJv7HAaRLgLk1KBdfpmFskdqmI+y1ZQHemSzi6oqUx3/IC/0dkc+sSY?=
 =?us-ascii?Q?od8PdvuyY9/H/TXLdsbavljpR+PjQIo1iP9eOXLqJ9oWWyk4EEiQ39TW1E3z?=
 =?us-ascii?Q?OCh6lAv7aayd/nmjFePsCCXCPIybmZtJZFvUcZV/xTiPkaB+MqK8/uRJasrQ?=
 =?us-ascii?Q?IPIXKRK2AswGtnXx1HJs4XrvCzmaBM4ma+3HPqrP7n5qGKUjmdjD19HuTxMY?=
 =?us-ascii?Q?NMo9b84MBImgfEWcZSgc/AOQHnSGJBaWkn3GVhuI2j58yaPNgwi22VzlYZhh?=
 =?us-ascii?Q?DJ4VYJXlQphc9A0B/IusXIw13N7pf8lsXiRjFQUOj3YLheP8fKO7t83PpuF1?=
 =?us-ascii?Q?eTzgHtNRLwupbLLn0KmIIKod+Y7cCBYhJuPaHlR/plv3v54faxYRnA0tEwed?=
 =?us-ascii?Q?sW/mpqkMvm3mfKQ2kzBkRVZYS/ZLNI0Z07w/HrLl+1ep/Kx6fg0d7icLMcbf?=
 =?us-ascii?Q?aa29zlmBG0gbIyYbiQyIrYjQsNOxVFYBcjkBS66/M8nZ+FaRBXs2S9fYXZRw?=
 =?us-ascii?Q?6290HNNLtaO2ASlPe7NGAo9vglYpG2KvRoHRoJrPnd9xNoEiXCpELsaFh2M+?=
 =?us-ascii?Q?nn7TNTenOzTtPar5xYLpaYEB7n68NaaRorB8630dxrGB2vHti/BPyyq9XcPI?=
 =?us-ascii?Q?ddBs7ugt/5sU4IXDsBwW5C+cCh/zfxT7MeWlry+IIUoZMtFEkZg7LE8xAP3z?=
 =?us-ascii?Q?z3TyQzSWwH5QKeUsmI/RNFGK1jpZ0om2PHGEYU6ZZNcQwwl+4K7C6cCMqCCY?=
 =?us-ascii?Q?K0Ar9JuaKWA8iYkGhEwm7UG9gPOx5dGjXOKm9EJFV1omSJ8+55OKR225a/lA?=
 =?us-ascii?Q?sL5lt2hlrC2jrz404ZUwb/ymQey/8vJia9iMWRHMWqFf/k/xHWZyt5ChTgRP?=
 =?us-ascii?Q?++ptcEIct7rYSoU1Kre/93iandWkl0EDT6lNGzI5QSyoKrdObVCMaTYPGYRu?=
 =?us-ascii?Q?l1eINhZZqYqjqiVHD9hD0x3/kzYAKekVRtTNr0dcgxR+QZuit00236sV6BHP?=
 =?us-ascii?Q?Y7AlvjXRH12ldGcZBBhG9Fus5jbKL34FV8Klx7aHShvGwmk1RxXasbWgSAGQ?=
 =?us-ascii?Q?RrYN6O3VKBaJnRYwI5Sc9P8bhNTlXhyvWld4HxdvP/KHAfXTVyAPqkRNUkvl?=
 =?us-ascii?Q?RCGbvQpvQGqUnfadNtQEyCTsWcVPKUkIghYLCfn+4/Yk+tG5onC9GEGSvM+b?=
 =?us-ascii?Q?HUcvDQWzgBA40Y/DEzW0JJT3BGWDbnVJrodFpcdPRLCqXHdquMLoSQm4yFpb?=
X-MS-Exchange-AntiSpam-MessageData-1:
	V6H+8NLtI//WQzhU6C7EKOYVJgHMYxIJd5mZf//OM5c2hcKYqoeBEKUp
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb81c2bc-d01b-4f2c-0b4b-08de796d03be
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:37:05.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+tuHfeNpwkFTIel1nxWuH3Wo99ypk0fdj3HQcEnTcLgGx/DkytVKG/CrIPYIuZASkE071JrY1FENLlgD629alg1nmJ+qjYcDHwF886tLGraYsdNcip1hK3wrMx0M4pL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8916
X-Rspamd-Queue-Id: 5A0521F7A0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263427-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SSDT and reference channels specified
in the PCCT. Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

This driver takes advantage of PCC mailbox shared functions
management. Unlike the existing Type 2 drivers, the mssg
parameter is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox,
already properly formatted as a PCC exctended message.

The driver makes use of the pcc mailbox buffer management helpers.
These allow the network driver to use common code for the reading and
wrting from the shared memory buffer to the mailbox driver,
attempting to get a single implementation of the PCC protocol for
Type3/4.

If the mailbox ring buffer is full, the driver stops the
incoming packet queues until a message has been sent,
freeing space in the ring buffer.

When the Type 3 channel outbox receives a txdone response
interrupt, it consumes the outgoing sk_buff, allowing
it to be freed.

Bringing up an interface creates the channel between the
network driver and the mailbox driver. This enables
communication with the remote endpoint, to include the
receipt of new messages. Bringing down an interface
removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are
cached in the mailbox ringbuffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 322 ++++++++++++++++++++++++++++++++++++
 4 files changed, 341 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..16610b0fa58d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15292,6 +15292,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..77cd4091050c 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..d0e7699ebe82
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2025, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	size = pcc_mbox_query_bytes_available(inbox->chan);
+	if (size == 0)
+		return;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+	if (rc < 0) {
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	dev_dstats_tx_add(ndev, len);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+	int len_sent;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	len_sent = pcc_mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		netdev_info(mctp_pcc_ndev->ndev,  "packet dropped");
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_mtu;
+
+	mctp_pcc_mtu = MCTP_MIN_MTU;
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return -1;
+
+	mctp_pcc_mtu = pchan->shmem_size;
+	pcc_mbox_free_channel(pchan);
+
+	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	rc = initialize_MTU(ndev);
+	if (rc)
+		goto free_netdev;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


