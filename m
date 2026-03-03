Return-Path: <netdev+bounces-263426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDybOqhUp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E66541F7A16
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AB61303365A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422ED4CA278;
	Tue,  3 Mar 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="G1ceFZ8W"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022134.outbound.protection.outlook.com [40.93.195.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD7492536;
	Tue,  3 Mar 2026 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573829; cv=fail; b=KegK15ZcqNF82AniVpGPKokB6WT2thlW78UoDIQ9L56+wEUGUPey19GySjqEr5kx0FVS3LiM3wQUnqgQYCAE5mrDYdOiVPY5afDbRgzDdbXm3BTVhvbU4umjtvVVfjdX9GnlHR16/tjkLEymfEPwGd3bNfgldjWBusbYInVqm1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573829; c=relaxed/simple;
	bh=ceV6hjKjYL+5l6kppiEZ4s4V+GjneS1zVroZzcpTalA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGRhugTLtbWf7oF/0qAkwWCzR8NIA5cwLOrLvrNFgOnhhuBL6IG4cz67VxCJE4+UPZMjhYmd56Fmod7ewGkks+Il+NWDbSx/kMAgJW1RcTKgsoZZZVx3lj4kCC67ItO+BT0spJNIKE5L9xHf1YiTGDj2vA8wLOQegiOW3TPGygI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=G1ceFZ8W; arc=fail smtp.client-ip=40.93.195.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIdR9VLLcOWDQhslSLfcDEmER2EkLVIManTJRWrs6YNmvQ5RMpITjl1m5X4Wa0bbzrmEdE/IAMPBuOXXRFVSGmTvF70Jx9M0sJq+kgdFVjdl8Ww5WhC9mI/tENrJaV9C6TjHUH2QCj75A9xuAdwQfbathrxNkln6Q5iIMO3FJveoBtKQxpXZZzvT0w/xZvChC4atj/0xM3irdryztbtZU/cEcyH3yXFBRmLyj2uSy4SCN/CRm64eNXh/mskHBGwB3z+uyEqW6eE9I2SIPvW3zWklfPqrZCi+IgfaTaxAxu6C2cizmMkZCVIDqyQXlbYex3nDvxZej5Shj8Zc7d4nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEE6Z4QzDyMA7G8qrCVNDyCVPrrO/TKaY2u57rAHiAQ=;
 b=TJvj3O7P+CnFI65wFantkTq0oSsDmtluA9I8XBE91yOVXUWAmLywHMq76guEqIx3GYg3IpNTnNETeEc7hMEZQPKf8YVxuyuR3giFADN9hKvsFi2s2odGbZ2Yk0+LIyK7hJXMxybBFjAUytZiz/ur2ifIlKjCfWSeUASzm2QNbq2bhGJP7E4nSbbvtWySyszktKANjtMsAyfMDRn2Fbilj0z6nZPEKI9FCqNyoDubxMmv0jrdLAEz+VHkgnrJsU0dIh3G1kkqtL/7byQ7ONj+si8xWMo0MTanrqUxXV7LLgzyVznoMouLrjIZQiN2yFwq/bBxGYKkHHRnIMGUMe867A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEE6Z4QzDyMA7G8qrCVNDyCVPrrO/TKaY2u57rAHiAQ=;
 b=G1ceFZ8WdboIXufrxRq1JXYl/C08OiDef55ZlfmgkHRLHwMyLh643/KjEphYDbi9ghDHZ4IgA4RvC4luG4kStd0uGvTyZ+Dd+cp5iMd68cXpYa32XkQxJIG55R/je7cl9RB/jrc+YG3vto7sk7n0uGFD6pMIVOBUAOePzBbRV3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 IA1PR01MB9169.prod.exchangelabs.com (2603:10b6:208:592::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.21; Tue, 3 Mar 2026 21:37:01 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 21:37:01 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
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
Subject: [net-next v32 1/2] mailbox: pcc: functions for reading and writing PCC extended data
Date: Tue,  3 Mar 2026 16:36:45 -0500
Message-ID: <20260303213649.237851-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
References: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:930:17::35) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|IA1PR01MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: ae48492c-4268-4396-a9bd-08de796d00fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	XTkps2tslMJixCCQqOeDHifAIPa7Jfrbusy0t2Atv3UUGpHI8k4MJSxVQM05/rqsEB0ZuFdEu5y/VcK4cwMe4zXB9D+LsOLkJrEIqX25flGhZCD4i5/a8270JuAi7ktpSi8mMy0IX6sBPCbu3H74Va5iaBOTat6NFp9BAnAV5cAi/tSV8wjPXY1QIG0veANqnP/QuXBbqI9KEUSbyrkBlILKQE3ksdcsuP2p9RcNj+tO8kE7nRDL3VzEu5pmxKpxlNFLfTH9sB1Ghbh9LUe2A0QB0yE52j8iwdL2ot4o2zEL+dzfyMMSTOZWo85O8ZmR81MIMJhOOlZAXTEi932c7bn+xgSlZAe7O5DfHEJ7/qaCdcBN2FE6zWRJe6ovY26BFmHI5bnYiwn8PKjv68phisdigOnYHdsHBlcQm/c4y63m24XuqcwJ7HJmpkoOFWGytJNl3cwjf9c4E5tqr6HgQqmQYEuqjyi9PW4cqustcxCBPkrDUJ3mv2/zO6SMOmt3U5kDy3QRKqST8ZweE4QRaGGiW8muJNepqRlx/O5XDEqGvPn7vLtL/WT+bcdcZc1Tc1fGwcGiBVKZmZJPb2K+4GVFE68UsCqGa/96au2AJ4CIYnqoPRHKN8RXYnsRMmdPDSSCl36tvcLL0e95IhF/CCzMp9mycPR1KyrOtLfYn4aQ5LHY/iI6eyh0hln6Ci9Buq1/Cb93lNGkwSdMfyh2lfnOXHsZVMp1DTeShKggnPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(52116014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7/WKrWguMtk1SuZ6hWOk1nW/SLuAyP8GmCJySNG3JdS1EPsSoYnBqvvLUWh?=
 =?us-ascii?Q?bqM08XFLi5+BvMux2ak4x5narCl3b3xNP0ptoNRm4+LXgEB8xOUeB3o6in12?=
 =?us-ascii?Q?CUsOdDdl8BQkH3HM4OydZoCvYZ7w7GZkWim8d+0dRgSfCzHdQ3n5E0V043Ck?=
 =?us-ascii?Q?IKB0zCmtolQiDED3Xc8vfjuZQCklcTcPqtpemTE7y3DgyD45BRyIzClZqa3A?=
 =?us-ascii?Q?4D9ValKSctyWnjyH1g9eCKgAIj3Ay4qkJIAoB/7q/mdlMzTeCU3UZjpbWEHr?=
 =?us-ascii?Q?2HlHvhgaQd9DlMcKzf6qX+y23SgOv1YA/aiStaK7JiFzU+5ax2RGub2LCxf4?=
 =?us-ascii?Q?YW+7yiuvCN/BoDIaMEhYqoHNeNnsuZpHOL2I/2odheWOsNPj4LbxOOyvUTaB?=
 =?us-ascii?Q?Xr4WrgQ1+1DtmaRJLTEJy6UtcYkRvv9po50IdWyGRsBDTsPDfC1hsAOz0/kE?=
 =?us-ascii?Q?yQs/jGCuftbcRPOlnbbyougYlZt2KhCQHECtJkC/oq60NkmKxl4YWkSc0vr1?=
 =?us-ascii?Q?uDg3OaXBi4D0cXj0rPyYDlHDcgOXV6qyr4GmpLlkjJkUe89BcO6DZDwY6GZL?=
 =?us-ascii?Q?L3kQ71luIs7bYcu0CmEaAlUBwr7QNgy0jbJzEi/bu8xCYer81KoLFBz77K8u?=
 =?us-ascii?Q?QbLaRxdnhG3A+7S0O/+SfvNWrlSzZ9GHdAoiV2pW/dm1hR2ZSxcYK+7fYHak?=
 =?us-ascii?Q?xT/KiGOAtJCBrSTKZecCfXjOvptp9RyUqMtACDFdYAtsaNyXOOGgEwO6x7M8?=
 =?us-ascii?Q?7te1HPRSMWIjtUdqrjW7jgjxLRdyEeWTDoRy0wSkwZha9wz1APxp/N/HpTc7?=
 =?us-ascii?Q?QPLCb4l4DHyMJF7QEJ5VKLIvoVN+nzyAk60Ypg6j6KOJnOl/3wnbO4udECzs?=
 =?us-ascii?Q?nKJ+dFlADte+Z0oIWEfQrzdLs0C7/b+nzZGvw4XyPOOgdvMRXyJfyB3+3Zzp?=
 =?us-ascii?Q?iOM7DlaIDDqTkZtdcNYepiya1QdAzeY7JMPD6TNySU30YoVQ9vBLyY1sBEfx?=
 =?us-ascii?Q?GDCPFa2lQBG11hZLfCA/6mSwXBdDF17nQeamPTUdW9lkeIoU0iD7phG9Ok7q?=
 =?us-ascii?Q?3N/i/zriCb+jtc8OBDUXpf+lKaS5krS/pGRng6IaFtZA3hf1GxH6WfmWs9L8?=
 =?us-ascii?Q?71YVIQxH4XctNKQ6vgDd92Y0YXsnm1mXQrfInDnPjQaqIh2gDdNQUyfx83a3?=
 =?us-ascii?Q?VSqzL1InmeSx6X4ChDVwFx9fxjHvNvYj1RXV3VS8f5ZNp8wGEU+zvHpLKJVI?=
 =?us-ascii?Q?gWrqsUtVd4V5sNMZCXNUmKHpFGk/oVlC6oZdRd9qUtdbeZps7Z00omfGpouz?=
 =?us-ascii?Q?9xpqlFNGsivvKoeWnjq+PceI2duiP7r37IBhgIag7F0vzV2GYlWJu+r8Fy8O?=
 =?us-ascii?Q?vsTs5teZzzF2AMtpxWQuf8NUfylKqTsgOH6cOjwU0GbMA5JE5jgXwBqmGaXW?=
 =?us-ascii?Q?MTYiAymjiW7eayHmRNkoPVK3XzW++A4efx6BrwFAlJJWEgshLgQ2wSPLPk1c?=
 =?us-ascii?Q?+wb8JZgg1SVKrzCnugQj9QUR94bxhWgwwMVl5GvSBkh1mvZ08lKdZwNn9XMb?=
 =?us-ascii?Q?NCFPj1zG/wjFhlqxUksEAaIdb7CJrve1BcNg0eS5X8qL7Wh40MF3j0o+mMAV?=
 =?us-ascii?Q?0MXTzRTAQTPjSdkmiAscrNr3T+lN7LzJRLQKinyyM9T175cxYqlnXOIMap10?=
 =?us-ascii?Q?Zs/PyLsSwO/Ij+FCW+uF23tb2F2c1IcYbiHKk9TW2U5dpNqZHuMlS51WGg+1?=
 =?us-ascii?Q?Fs27FwEvbLIjLAB8X/woQcLaxP57pfW/3SnoDi0rAmOIYq+5mjSKlnSGCF6R?=
X-MS-Exchange-AntiSpam-MessageData-1:
	CKxZ7RhmszdI2hgyY6Mm9zJ1YzbRCnHMDUtJlkinBTXIrafhazmstl8u
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae48492c-4268-4396-a9bd-08de796d00fd
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:37:01.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJfU+jaq9yiXNFWhIYE4H1kzj9QHg1SSRAHD51TULzx7YZoJzq5LVhiMGlk9X+Sb7qg/8cjNh0d+8OYi8haqjIM4BZj7j5nX38lDmXAbBKjU/jsx/m8ErqNcusZVEGft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR01MB9169
X-Rspamd-Queue-Id: E66541F7A16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263426-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[os.amperecomputing.com:dkim,os.amperecomputing.com:mid,amperecomputing.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Adds a function that allows a client to query the number of bytes
available to read in order to preallocate buffers for reading.

Adds a function that reads from the shared buffer into memory
provided by the client.

Adds a function that writes from client memory into the shared
buffer.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h    | 22 +++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 22e70af1ae5d..a8b377a64e05 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -419,6 +419,92 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+/**
+ * pcc_mbox_query_bytes_available - count of bytes cwreadable in the shared buffer
+ *
+ * @pchan: pointer to channel associated with buffer
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
+ * @pchan: channel associated with the shared buffer
+ * @len: number of bytes to read
+ * @data: pointer to memory in which to write the data from the
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
+ * pcc_mbox_write_to_buffer - copy the contents of the data
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


