Return-Path: <netdev+bounces-271710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G4WMuY6xGnkxQQAu9opvQ
	(envelope-from <netdev+bounces-271710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:43:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E232B696
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D6B73039722
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A135DA5D;
	Wed, 25 Mar 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LY8Fq/tR"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020142.outbound.protection.outlook.com [52.101.61.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC5238C0D;
	Wed, 25 Mar 2026 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467733; cv=fail; b=ibo2wc5ZtmOObKUU6J7XR/e2JrN/SSHTrfrFh6ZEKxDRKIwg3RKQOBGtSaNQRK0S3196OpliGWnmst+JRYcE8Rd1BgMXGdcuhX4jhE00NokZvb4vUKDHkSshmKv3UQc1sYmOWqaOrlNJgRdZJd28M54L6mfXhDouhWFiX2r4W4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467733; c=relaxed/simple;
	bh=gl/w7prvBR54y0O2BPwQD/nQcU3LRx+DpbLDdfhsZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mSxxCGNGfYk2aHNqQQRNBM+Q//8w8z8Cz6KIMzftdGnlKMGPCVtAVn7loZe4k7IqnbqrT1ipxQWVgZCTTW5nweuIOQODiNA8dqGn/IYVfC77dIlFxqKnk8tZV5GvsqDBhzpa0g66Li32YGCQ/rpkXP1qYGvody4HiD9VGAVch2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LY8Fq/tR; arc=fail smtp.client-ip=52.101.61.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iprkJiNrDjFKgtfiWhbdZnltxsCAkSff6cQhMAsk4ze//N/W7x9VRzyXFA9TbB8qfBoQnm/pjnA5p0U6ttUb44EUCZD8PabdWloKl6+SWSb9ezjSnVGVaWIsF0rJ06yfauW+O+1DSYde3aYMHn9c9VhzpOH4+Dw9EUuOARnvjFZO1OLVN8x8W8BX69rJQ307Bvo0KYGZX4B3bYxFr+WiACmlgJ3r8QT7pqWfk0F+l9iHIDvft8Wyt9pTBY/L0mi5xb1H6Dcy3dFB0grYroekhqeTgJOJFXma+rnB8HvAvOxCL+s4SXDfBZni3BwOt1fOgjATd+PoMknNCzEMDbCmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOtyKd4iEw6zpDAddZxdE1M4daQGufy1QEQugcHUe5Q=;
 b=dJ2jGgDNEo5wtw4z4KqD4eoc8mUf6dVkzVZ62DRg7kmv8P6gOON0ScIHldMxRAo5u3jFJULQ6VREeQ/VuK0BcsVzXuVHGawbrVGmGkxKbSXUW6w3hszvdlsL8ahbLgzP6WHRk4X9mDJSJ5Nm7/Xq7ok77EGOAajq8CIxWeof5VhtdihTNCBaLGnow2UxDEN9tB+DgSi56rgeQfxJy02AR/0KEAbXxVxnRq45HRo1+RSn4pDXoid9qEPp4IpuKCKcCgDaSDI4gIRcLuLqmMs9nFezdCxVG+hhOGqR+MrX01CNjxpPjkEs5pjDD1bfAJvVvvBFPncWacTnm4dp1RcpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOtyKd4iEw6zpDAddZxdE1M4daQGufy1QEQugcHUe5Q=;
 b=LY8Fq/tRtHVdv98MW4soSc3c81iskDAvFPv0EFHbyZs2BGyzNb3nEv8zuvNon1LeOsXU3xGRh/c7cO9of9Dymffe3/l10KzOBCJROXZpyWmScKREROgTrHLm1JFLpkpJW6edK8d68B6TjkiU3zxNoXWhB4cidYR7Z/HTDIyAv90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO6PR01MB7419.prod.exchangelabs.com (2603:10b6:303:136::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 19:42:05 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 19:42:05 +0000
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
Subject: [net-next v35] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 25 Mar 2026 15:41:59 -0400
Message-ID: <20260325194200.988788-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0101.namprd15.prod.outlook.com
 (2603:10b6:930:7::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO6PR01MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c69dce9-f524-461c-47ba-08de8aa69794
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|13003099007|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KrGX4TExXm0VIhWTqcJOvhyCQz2qkrTmBZydooytzkF6bmAXpKGoRK6l/v7W8QD1vrx3Ku8N/epe2LNje/7M2RvSFo3W7v01dLaCVouVvDBv2QNJo7mVoYz6gHQVnQ3avNxCiyBq+rTo3Ha7p9nrd5i9WUXNtXDSyQSPihQ2nFRr2DagLuigUYpHvzRCejPIu5mIsDi/X22o/DRhHPG9a/3vKOKsm7o84k97AS09mBR5p0tm3nKtrwtGAWC3yjiQ5Ugm2pNAQQFdPJ9Ge1D2kNJuFCxxLbO0WEoci2gLVhvc9N4eH8GaAkkX/IKFkkHzrdIuqxshhR1HX/G/KE+dR3EXglIE/Qj96tnIKt03zAgsu+r/bNXecxaxC+n2HoEqoD8zSza1ytaK0lM7w7psPn+D+YlZyuG/Q2CrARm6rbJZHyzb1LEjR9pKTacTzEK4RJFYl1Q8cqEo6wVviSgbOdeXvZzZpZ4xsfQfzl5Wbdcdy0i4SQ0QgDbTaz5NEEciqVsxfrT0lTMe+52qeToh/KKLBpmS2DeitQ1gZDxI3T9nPZGXnAMbWqBHnxPFRrwcmM7sEeD1ydXVt4dKbgJtcSHH0Pc7Mxe79OPrUDKnRDPrpl5KVpGh1Kn+Jc4pg2gIKzBOOMYmZ3BJEBwW8v8Dyn27a8x8ywBVrEC3wRRqR6PF0xELPhv5HzAVUz+HuduU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(13003099007)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3X808iuioRwlVb2B6v8kcbzK+macGGpCVV+kB9MEoZ6CdoZHkVI3MLFL/PXK?=
 =?us-ascii?Q?uR/ZgAXicazet4XQPoBO8RoJ+tcWslOyRSvD4faj9JxC2rZYdVGgFuumB4dG?=
 =?us-ascii?Q?epJewSL4v/f/CS3QSR1GxNd6D7PiWPb5Gahf3Nl1jOmD1jMrcCxX8LiLiQlh?=
 =?us-ascii?Q?LqtwXaNMyPDdJI+SnYYPUozFK0jGPY8hzpOsUWofqHiIoZAJVJjOGYXtIIA/?=
 =?us-ascii?Q?oiEZqqfZX6aNUnC+jPPqHeG8CtTz0XzUkrh+7fgKe0K4sQ/MUgbNqY2DXRu5?=
 =?us-ascii?Q?eXrEJI+CKfObTzrRdLlQFF53Y36T1QIwqkr+xuQ/IXZ+vXE0FZ6n39XZG03z?=
 =?us-ascii?Q?epB+2n3jyNWW0ty9MEfSMcLfFz38kPZIb/bJ8lHt+lpxAOZdsag00eh4GIq4?=
 =?us-ascii?Q?Uv4HniKiqRf7/V9eZT/NBzy4DCelDtbbI1dSP1JwC4WWrzcLgXg7PNIw/eqf?=
 =?us-ascii?Q?mwI8mCQoGJvwkxXE+ZWB4cvGIiZUeoSMpw43u1CJhtbcIMBfMeCAv9daXK7x?=
 =?us-ascii?Q?GrdtBjwzBwz4Vt8a+YtfL/CZDt1PJ82hV1Rn6naXai3PNYcoNlltPpW5gWiy?=
 =?us-ascii?Q?ixNO4X6Zuc+ND35ADFOqrVzXOa0HZtD2IPbAIWdyf4GUsEJtMQOEJ4OWOZC1?=
 =?us-ascii?Q?4QuhkL/SnwaMHGTjrdqaWBy0hEcYLIDYhaxJIZGwIgRIlp5EC39bTAXBpo3E?=
 =?us-ascii?Q?haXliknn65fkIFu1x7bEtAnRWmjSOlibxWzHM+n7kLVkFZWz/BtfG6lM/hhE?=
 =?us-ascii?Q?5ICsHllTNnRF6vgFMSKA7Ilredug+S9tQtDrhVA+cAylIn/UyRpjOMHbIeZX?=
 =?us-ascii?Q?enLyjqUWmfC+OdhxtM8DC9X7XOI7u7jknbvyg/290v/AZ7J8lPfEU1WNsepw?=
 =?us-ascii?Q?dMxGbFK8jItMwy32J2pKWui30z+MzU4BTxFOpJajxTQQNMY6Y9Aq1461yiFm?=
 =?us-ascii?Q?H1nOPIImXRfZCer1gKVpTEXDfmV3L/7Kje9Ufv8XHZBqE6blY26AugtAtiFa?=
 =?us-ascii?Q?klzIyYcp1MpgokWbh9lRMUt2dDaCpOy4kDdFXgbsEuww5HTvDVvAF8hwarHy?=
 =?us-ascii?Q?8Wf1tymOsr0RMrBlmOxA8KIoY5hPNLwZe42KoUDdqqcieq7dg4yPdO6dq+Zh?=
 =?us-ascii?Q?B/dkyuBoBurAQibozjuIOxSOzUJQbfu256wwlPkWBt7tKK54KucAdmw72yVW?=
 =?us-ascii?Q?qs1MRR/pP3nceioT1OvZg6puqiuHJC4O4YtkrLknEfr7Iyf2RKgtnIEoqGKL?=
 =?us-ascii?Q?n5g0UQgZuigkTFxuAxG2lNb9Sg6a29jF5PpeuT+QZEE2Vc0JQOxpJur3ZaR6?=
 =?us-ascii?Q?n+ZWxDPBys0y910KkrPLmKStJeI4vDWxT06IJSeq6QKbxLuDcTki+Eqhl7xM?=
 =?us-ascii?Q?UM+xDMLhDRhDY4CpegcSZXtZTUHj82g/URgyBkyyGBHg4zZJRs6bYMvF70Uz?=
 =?us-ascii?Q?4kE8v54pwWBKRM1Gwz1dEFQOuIvuWGY03cy0IRXr9i8JFC/Y+b8YfknAfxUS?=
 =?us-ascii?Q?rdUnpxBd1200vwhJyPr5nozwwr1xoJTqlaitcgKqiVLl8/XN9PIz7WRu4MjM?=
 =?us-ascii?Q?KWhIVkaSxLbetN+eAXBvO/VBVltclXIZ8YBfJrUionH8Nys/nE7ObwzTeghR?=
 =?us-ascii?Q?OmOLzVNpPINIYF4mE0LtlmCKdl9QFbduGv2clx9ScCzzgQuLIO3JDKejcERH?=
 =?us-ascii?Q?fh7MlTtidH3Jg81fpaGDAL9li2K8tcy6PTF5a1JiFCdzkg/fubb0pshyF6ep?=
 =?us-ascii?Q?3bpm8h5zC0vpnDs2xSmJcSHIKn5C2/o9XSGr3HWzLbXTwUWPgqvv19cL/jW6?=
X-MS-Exchange-AntiSpam-MessageData-1:
	tHSvoo+7jm7FDDaRwf9yp5UlRFcfE1yLhuXMt8c4KYJC9yLYMbC678pq
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c69dce9-f524-461c-47ba-08de8aa69794
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:42:05.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xvZZi0jBz0iCh6nF9z0ien76FJcAKI+9kFgR5hpAkvNfXGOVLyWo2Qje4kOQ8d+Sv505Lpi3Eo8Za+q5HbKmkzuMxml6Y0Ix6Yz9v548g58u9oOhmzgiUzKSFS5a1jr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7419
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271710-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,uefi.org:url]
X-Rspamd-Queue-Id: 659E232B696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are cached in the
mailbox ringbuffer.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. If the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hardware that does
support PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 334 ++++++++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a09bf30a057d..2e57ca4d61b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15286,6 +15286,11 @@ F:	include/net/mctpdevice.h
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
index 000000000000..fe08fd041d9c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
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
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	if (pcc_header.length <= 0)  {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem, size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_mac_header(skb);
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
+		//Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
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


