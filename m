Return-Path: <netdev+bounces-289263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ERrDkreC2qPPgUAu9opvQ
	(envelope-from <netdev+bounces-289263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:51:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C430577068
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16945300D359
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4942765D7;
	Tue, 19 May 2026 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="iRO4eWdQ"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020128.outbound.protection.outlook.com [52.101.56.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09023D7F4;
	Tue, 19 May 2026 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162693; cv=fail; b=HGDPnB/taoF+bDDm42+0U0v5smswjqRA52PvYo8U8Tk2tk30r1eA+JRlfbI2rC+NLuXtenDG1SjCKBLxI1Jops3Z/6R8/657Ymjnwh887h1DDWPfbktEK5PtJ1+XlHmRF8DPfaIqAIQil7dSKeGGpwrEx4VNdcviVz4Ff7Ks03M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162693; c=relaxed/simple;
	bh=mNqTPWYg3tNy5KzYi7IsUgAargxrGOaw4lEBee28q+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dxCb2zNKdIi9pDE1M47/jwdu6pFh1+fw+Dx9e8fbccAw4zgggfVn+sJ5O89f+kat8u6cdEuAOoxBMn/tLWAeceoLiMta14rh4jLYPVHw85bAI7WJdVrKJLWXfr4xJ1pfiq/bvmBvUy71NbnnucVhaOuwFXQYQ1ETHv6Lt2llHHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=iRO4eWdQ reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.56.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l165qk/QQy4peLptiF3oeByXOJyWhVO7Q9RuO1WvQQMiKSv3UL5ZgVxpWWicodZ3MNxFeErX3Br4o/N7Cv7bGPnLUoRUGJIwDN9Ssh0KLanq0H+tiDP7L7hWkTxsGwh2/KsDwnXQzNUL2C8DDhNNoo3BvLjy4mij4w/VcPwvVPcQa4aP1TVeUsVRfNH9KwAZTtFmABz5wcvjJdnLnRCmtGoGDYChwV0hwlmSP8Ct2+w/tdYP/EPUvStD4XwiI/kloekQAVIj4uCpfKtJ8241ZjJhsYBO1EjYjOl2V5CDys06DOvG+kFsb3YGFtbCUrWArmncftNeORhzHLHZ496qIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C+LaJD+SCZpaVp3rWzDtg1dq+hwwmwXcfi4KuKApsg=;
 b=yqRngJ0WmUF5az+tu1UXeOBlqX5glGgIWDswtNHAW0UHYmp3eF5lBlh8X+3PixQWXdY0DoRiBTVADHCtEGQ3Nr7gLY95S7c7XfLjDN+RILTWydg4eT+EvA6a8t+aTdAXyXIQ5SPZrKZKj5IYS0F2IAxbYTNBxZQbWi94sCwSQSjApQ5WqeRXBG32rZRHKcMpIlQKsVjX0HnTB5dfgaHXwEr2z8qJZvBzd0MtnOrrBzNAno6Tn7UbWWgQMJ+XEA5+V3k2cb8hpWynrfhft6Njnsh86yl0owl9/U91E/n6Qq3o5HWkuJGTpjfocHDLcfiEsu6mmHxMUeh5+ZO67i/9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C+LaJD+SCZpaVp3rWzDtg1dq+hwwmwXcfi4KuKApsg=;
 b=iRO4eWdQeIgeLA03nFWO4MdC89ObkzwKkcY5kWddvio+tXyS0f0BJlveu7dJQsM94m7OlGahPtE8lxMKSN/PkLNyxct9wi/1yYEDu84qViKT6aYsg4WbZ19aRuEaZtKARcL8sTELfaMS6xB3qfbl30AGWpQPy27j/hbL9Z6QMEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS9PR01MB994435.prod.exchangelabs.com (2603:10b6:8:35d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.15; Tue, 19 May 2026 03:51:23 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:51:22 +0000
Message-ID: <558b4f4d-be3c-4a0e-9398-4f1f673d49f3@amperemail.onmicrosoft.com>
Date: Mon, 18 May 2026 23:51:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v42] mctp pcc: Implement MCTP over PCC Transport
To: Adam Young <admiyo@os.amperecomputing.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:930:10::27) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS9PR01MB994435:EE_
X-MS-Office365-Filtering-Correlation-Id: e255e63e-4923-4bdf-a9e2-08deb559e496
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|22082099003|56012099003|18002099003|4133799003|3023799003|11063799003|55112099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	F3oulhbMdKOnC9KeQA5btbXWgdLzh16xgBy6f3qoB4Ps+4nu6zRSDs6/snPVztKsLr8eEAjB9mj7ACfDTarozVOziolZStD/hR2tc4a8XWbSIElRxamBUs1tQOvkM5H36Trtgy8fC/+TgzYWFvm/XQ36d0PEWzdiKujj0RuQGVCPyytH0h49t1Faa81b1H11NRd0/5Ngr+n0TZKBOacoAwL1m6Md56TEb25rakAq71uo/PcvOUPn/LiFaPvR9Oxn8VMN84g9+Cmf+23UMy8+xOl9i9KQIxwjXbz6Z+VA0JRVTAetbKTpNP0m+4stxTUlb0VW1GTTncOLboPztekboGtjsqKVjD/CH+pay0bn40f94ZyBi2ZdyyHoguEnxiI3nl8KtfoC8aL/vsD8qgSAUbUQ856bV6ZF6f8DtF3nkpt+qqQX/rVq/mbKoEZ86ntOArtvyd7Tg+U/U3yd3PIem7ptY7J5Y0L4Z12fqMfXij34P4iyQT+PvUEknCb00cKRHbtUlH83YxzHyhwB7sR6Kl3dYznzm3Bjau95KZj53GKS9afPmRaVa2PMNW868zRaSxTwS31bO7cnx2S8/YZW/1DajW49G7aEHrNSH4vdt2lfS96fcss6GoHnloriPMITFp8IQr7qorrKNNgkErN5XDus8FWxGqoSX14G/bczEieVyGkvDX1T6/+ngBo4LeNDCAOk3U2EcVs8JQJoFynCJ11Xg/9I9p5EYFrckSMYBsstvd2m2aurSQgQ3kG1BWBy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(22082099003)(56012099003)(18002099003)(4133799003)(3023799003)(11063799003)(55112099003)(921020)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	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
 =?utf-8?Q?einp4iZGj3bd/LHnrXK2HJ06BbQ/B3qVAp+DkVwKDShuX?=
X-MS-Exchange-AntiSpam-MessageData-1:
	iZ4ge2US6Y0RX3wyctlpm9F7VtrPwfOHun3jHjtfMDs5TmHoG8OuL/vV
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e255e63e-4923-4bdf-a9e2-08deb559e496
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:51:22.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0RU1WsBzeajKibTsWxmgmEJSxlJNnaeLWtSljV9BhGz+tQgcjCW8/Xim0Ja5dn4nOjrnK0l1pFwHvylWgps47aVebZMeVzJcYzl/SEGKJ69EN9LVxi8NYSW2GmrVKxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS9PR01MB994435
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289263-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C430577068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I am going to resend this but without the binary that somehow sneaked in 
to the patch.

On 5/18/26 16:38, Adam Young wrote:
> Implementation of network driver for
> Management Component Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
>
> DMTF DSP:0292
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>
> The transport mechanism is called Platform Communication Channels (PCC)
> is part of the ACPI spec:
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
>
> The PCC mechanism is managed via a mailbox implemented at
> drivers/mailbox/pcc.c
>
> MCTP devices are specified via ACPI by entries in DSDT/SSDT and
> reference channels specified in the PCCT. Messages are sent on a type
> 3 and received on a type 4 channel.  Communication with other devices
> use the PCC based doorbell mechanism; a shared memory segment with a
> corresponding interrupt and a memory register used to trigger remote
> interrupts.
>
> The shared buffer must be at least 68 bytes long as that is the minimum
> MTU as defined by the MCTP specification.
>
> Unlike the existing PCC Type 2 based drivers, the mssg parameter to
> mbox_send_msg is actively used. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox, already
> properly formatted as a PCC exctended message.
>
> If the mailbox ring buffer is full, the driver stops the incoming
> packet queues until a message has been sent, freeing space in the
> ring buffer.
>
> When the Type 3 channel outbox receives a txdone response interrupt,
> it consumes the outgoing sk_buff, allowing it to be freed.
>
> Bringing up an interface creates the channel between the network driver
> and the mailbox driver. This enables communication with the remote
> endpoint, to include the receipt of new messages. Bringing down an
> interface removes the channel, and no new messages can be delivered.
> Stopping the interface will leave any packets that are cached in the
> mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
> attempts to deliver them and has removed them from the ring buffer.
>
> PCC is based on a shared buffer and a set of I/O mapped memory locations
> that the Spec calls registers.  This mechanism exists regardless of the
> existence of the driver. If the user has the ability to map these
> physical location to virtual locations, they have the ability to drive the
> hardware.  Thus, there is a security aspect to this mechanism that extends
> beyond the responsibilities of the operating system.
>
> If the hardware does not expose the PCC in the ACPI table, this device
> will never be enabled. Thus it is only an issue on hardware that does
> support PCC. In that case, it is up to the remote controller to sanitize
> communication; MCTP will be exposed as a socket interface, and userland
> can send any crafted packet it wants. It would also be incumbent on
> the hardware manufacturer to allow the end user to disable MCTP over PCC
> communication if they did not want to expose it.
>
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>
> ---
>
> Previous Version:
> https://lore.kernel.org/lkml/20260510163228.443778-1-admiyo@os.amperecomputing.com/
>
> Changes from Previous version
>
> Remove call to skb_linearize(skb)
> Spacing changes after gotos
> move final check of packet length to tx function
> use irq safe stats update in tx_done for sent and dropped
> mctp-pcc retry send_message to avoid permanent network stall
> ---
>   MAINTAINERS                         |   5 +
>   drivers/net/ethernet/intel/stYNFrCT | Bin 0 -> 564073 bytes
>   drivers/net/mctp/Kconfig            |  16 ++
>   drivers/net/mctp/Makefile           |   1 +
>   drivers/net/mctp/mctp-pcc.c         | 426 ++++++++++++++++++++++++++++
>   5 files changed, 448 insertions(+)
>   create mode 100644 drivers/net/ethernet/intel/stYNFrCT
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bbbbde6b907..252c77b24791 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15403,6 +15403,11 @@ F:	include/net/mctpdevice.h
>   F:	include/net/netns/mctp.h
>   F:	net/mctp/
>   
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:	Adam Young <admiyo@os.amperecomputing.com>
> +S:	Maintained
> +F:	drivers/net/mctp/mctp-pcc.c
> +
>   MAPLE TREE
>   M:	Liam R. Howlett <liam@infradead.org>
>   R:	Alice Ryhl <aliceryhl@google.com>
> diff --git a/drivers/net/ethernet/intel/stYNFrCT b/drivers/net/ethernet/intel/stYNFrCT
> new file mode 100644
> index 0000000000000000000000000000000000000000..9b01d1e909f20fe037eea685116d344a2165db52
> GIT binary patch
> literal 564073
> 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
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> z00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY
> z0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4ea
> zAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&00JNY0w4eaAOHd&
> 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
> Jwwe{={{!iY>!bhx
>
> literal 0
> HcmV?d00001
>
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..e68d23794a80 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
>   	  A MCTP protocol network device is created for each I3C bus
>   	  having a "mctp-controller" devicetree property.
>   
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	depends on PCC
> +	depends on 64BIT
> +	depends on CPU_LITTLE_ENDIAN
> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DSDT/SSDT that matches the identifier. The Platform
> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.
> +
>   config MCTP_TRANSPORT_USB
>   	tristate "MCTP USB transport"
>   	depends on USB
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index c36006849a1e..0a591299ffa9 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,4 +1,5 @@
>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>   obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..2570cd379966
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024-2026, Ampere Computing LLC
> + *
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hrtimer.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/skbuff.h>
> +#include <linux/string.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <acpi/pcc.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_MIN_MTU            68
> +#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
> +#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
> +#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	struct net_device *ndev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *inbox;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	u32 header_length;
> +	int size;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
> +	inbox = &mctp_pcc_ndev->inbox;
> +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
> +
> +	// The message must at least have the PCC command indicating it is an MCTP
> +	// message followed by the MCTP header, or we have a malformed message.
> +	// This may be run on big endian system, but the data in the buffer is
> +	// explicitly little endian.
> +	header_length = le32_to_cpu(pcc_header.length);
> +
> +	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
> +		goto error;
> +
> +	// If the reported size is larger than the shared memory minus headers,
> +	// something is wrong and treat the buffer as corrupted data.
> +	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
> +		goto error;
> +
> +	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
> +		goto error;
> +
> +	size = header_length + PCC_EXTRA_LEN;
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb)
> +		goto error;
> +
> +	skb_put(skb, size);
> +	skb->protocol = htons(ETH_P_MCTP);
> +	memcpy_fromio(skb->data, inbox->chan->shmem, size);
> +	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
> +	skb_pull(skb, sizeof(pcc_header));
> +	skb_reset_mac_header(skb);
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +	return;
> +
> +error:
> +	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	int len = skb->len;
> +
> +	if (skb_cow_head(skb, sizeof(*pcc_header)))
> +		goto error;
> +
> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> +
> +	if (skb->len > mpnd->outbox.chan->shmem_size)
> +		goto error;
> +
> +	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
> +		netif_stop_queue(ndev);
> +		/*
> +		 * There is a possibility that the mailbox was cleared on
> +		 * another thread between the failed send attempt and
> +		 * stopping the queue.  If that is the case, and we don't restart
> +		 * the queue, it will remain permanently stopped.  To test,
> +		 * try submitting the message again. If successful, restart the
> +		 * queue.
> +		 */
> +		if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
> +			netif_wake_queue(ndev);
> +		} else {
> +			// Remove the header in case it gets sent again
> +			skb_pull(skb, sizeof(*pcc_header));
> +			return NETDEV_TX_BUSY;
> +		}
> +	}
> +	return NETDEV_TX_OK;
> +
> +error:
> +	dev_dstats_tx_dropped(ndev);
> +	kfree_skb(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct sk_buff *skb = mssg;
> +
> +	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
> +	outbox = &mctp_pcc_ndev->outbox;
> +
> +	/* The PCC Mailbox typically does not make use of the mssg pointer
> +	 * The mctp-over pcc driver is the only client that uses it.
> +	 * This value should always be non-null; it is possible
> +	 * that a change in the Mailbox level will break that assumption.
> +	 */
> +	if (!skb) {
> +		netdev_warn_once(mctp_pcc_ndev->ndev,
> +				 "%s called with null message.\n", __func__);
> +		return;
> +	}
> +	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
> +}
> +
> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int rc)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct pcpu_dstats *dstats;
> +	struct sk_buff *skb = mssg;
> +	unsigned long flags;
> +
> +	/*
> +	 * If there is a packet in flight during driver cleanup
> +	 * It may have been freed already.
> +	 */
> +	if (!mssg)
> +		return;
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
> +
> +	/* Use an IRQ safe update as this is called from HARD IRQ instead of
> +	 * dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
> +	 */
> +	dstats = this_cpu_ptr(mctp_pcc_ndev->ndev->dstats);
> +	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
> +
> +	if (rc) {
> +		u64_stats_inc(&dstats->tx_drops);
> +	} else {
> +		u64_stats_inc(&dstats->tx_packets);
> +		u64_stats_add(&dstats->tx_bytes, skb->len);
> +	}
> +	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
> +	dev_consume_skb_any(skb);
> +	netif_wake_queue(mctp_pcc_ndev->ndev);
> +}
> +
> +static int mctp_pcc_open(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox, *inbox;
> +
> +	outbox = &mctp_pcc_ndev->outbox;
> +	inbox = &mctp_pcc_ndev->inbox;
> +
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return -EINVAL;
> +	}
> +
> +	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
> +	if (IS_ERR(inbox->chan)) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return PTR_ERR(inbox->chan);
> +	}
> +	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		pcc_mbox_free_channel(inbox->chan);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int mctp_pcc_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	unsigned int count, idx;
> +	struct mbox_chan *chan;
> +	struct sk_buff *skb;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	chan = mctp_pcc_ndev->outbox.chan->mchan;
> +	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
> +	scoped_guard(spinlock_irqsave, &chan->lock) {
> +		skb = chan->active_req;
> +		chan->active_req = NULL;
> +		if (skb) {
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +		}
> +		while (chan->msg_count > 0) {
> +			count = chan->msg_count;
> +			idx = chan->msg_free;
> +			if (idx >= count)
> +				idx -= count;
> +			else
> +				idx += MBOX_TX_QUEUE_LEN - count;
> +			skb = chan->msg_data[idx];
> +			dev_dstats_tx_dropped(ndev);
> +			dev_consume_skb_any(skb);
> +			chan->msg_count--;
> +		}
> +	}
> +	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
> +	return 0;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_open = mctp_pcc_open,
> +	.ndo_stop = mctp_pcc_stop,
> +	.ndo_start_xmit = mctp_pcc_tx,
> +};
> +
> +static void mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
> +
> +struct mctp_pcc_lookup_context {
> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_ADDRESS32)
> +		return AE_OK;
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	default:
> +		return AE_ERROR;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static void mctp_cleanup_netdev(void *data)
> +{
> +	struct net_device *ndev = data;
> +
> +	mctp_unregister_netdev(ndev);
> +}
> +
> +static int initialize_mtu(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *outbox;
> +	struct pcc_mbox_chan *pchan;
> +	int mctp_pcc_max_mtu;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	outbox = &mctp_pcc_ndev->outbox;
> +	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(pchan))
> +		return PTR_ERR(pchan);
> +	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
> +		pcc_mbox_free_channel(pchan);
> +		return -EINVAL;
> +	}
> +	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
> +	pcc_mbox_free_channel(pchan);
> +
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_max_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Ensure we have exactly 2 channels: an outbox and an inbox.
> +	 */
> +	if (context.index != 2)
> +		return -EINVAL;
> +
> +	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +
> +	mctp_pcc_ndev->inbox.index = context.inbox_index;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.index = context.outbox_index;
> +	mctp_pcc_ndev->outbox.client.dev = dev;
> +
> +	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
> +	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->ndev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	rc = initialize_mtu(ndev);
> +	if (rc)
> +		goto free_netdev;
> +
> +	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001" },
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

