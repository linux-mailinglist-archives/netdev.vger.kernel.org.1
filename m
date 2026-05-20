Return-Path: <netdev+bounces-290116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAPVN49DDmrV9QUAu9opvQ
	(envelope-from <netdev+bounces-290116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:28:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9DF59CBE5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18382329175C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1437DE99;
	Wed, 20 May 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="9Q+dFY5O"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021078.outbound.protection.outlook.com [52.101.62.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F42C11CF;
	Wed, 20 May 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313562; cv=fail; b=mQSRIeQbR9wkxu7/VZa3cBqI9l3HiPgz1pb3L6Sl9AqM+KGQQZb2ro6431i5XvZe0B/Gmiu+u+jh8L8leXOxNGx19736Jq+0f/Z3E2y/jzUE/UWtUiIe1XpDPRdMaRSgqjRKUmiByh6RkSib3v9MZxPHkJj8oOPq4OKqWnN0P6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313562; c=relaxed/simple;
	bh=CkH//6l80PUDb3HM/DZWv3BJH4ZM7QYfo97q98Lj/wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQAyqN6aCPHtgn+yEHsrAs0MiHP740PkWnClXu1YfjkKL4bxhWWZUY21OhvNYRTBSZYfLdgnmB1XwZbU+VpMEfD2O4B8xmHIeQu/6c/B4o3fPkxYlurMVQ41RIoeQmbiQ8MbSZNv+tYJQJ5yza3wbVQYVNRIfcnTA0hgfw0S9J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=9Q+dFY5O reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avetQPlU7teYuWtST6NAYxCq/Byaro4q/8FlsE/W1MsAVDj5gCKyj9dbaQCmiAQKpR/2pyU/QRjIXm6as2JTNsXZkYd+xP1Nh620IAvsXUsm6D2tPTGpvZBZYKgnTpprjsn4iUvubWlc11iSxxkKF7wCOBCXK3kH63LWSzcIrxZ6fbvy9yJVrKuJEtlCH9SuQsXshWlEMmY3agLMdTglv8gnpjnhGpTUxI5n5l0Ci8gZSjGztavmEWRICo2uqQYrpjP+oXJoiTsp3H/NsH6+BqEuHLvrt+50gxW3mtOyn4aabLIlN3NJWQW0jZM2RrrhJoKlqF8aXDRkfLPPWdQYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4V6ljtUGOl0vxAfleGiZUMXhSRP4OZJ/tdUzJLyE+8=;
 b=GtCIFcWkhGt5OhB5HvEa34UdzPWYrsjJvJx8cVIrN1aEjyErT246TH592QoY3vvZgKpfqS0yZqiYOm8IVl4QCSp8S7PsdEsVZLxAnm7UlBo110hVCqAXSXO5ErIzDXn3VwpISrhuNe2vE9fGLz0edfudYXh6H8uq6H1ImQnsCdXsgRsEgL3Gx8hQXGLoEbNuvguxM53nFGqR1O1jDAeH2ny3GfMQjcbBunAZUaR0dMthszdGmcEI4oSXYcf9rxT8/BDOEfbPSRtkeftjgxd6/vMQ46pFnqht6MDvOTdhVFryahAKIjl8Vzu33E/uwTQnALUtv1nlhmmaSyFKFpStHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4V6ljtUGOl0vxAfleGiZUMXhSRP4OZJ/tdUzJLyE+8=;
 b=9Q+dFY5Oozne1ZJdpviirlYSQ6PCuhDvno2diSpnLf8W00NGVlPbehoYO6NpYTIUxJETe9OlcQ7XpDSqXBPHqZ/xDc1/zHkdt0+aWZ+fSLA4glto+zKSs7m4tFMvfUQq1tEoo/MjBWFABySev7phJJY8gWyclWZMytXpA5lSfZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB8108.prod.exchangelabs.com (2603:10b6:a03:4e1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 21:45:56 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.023; Wed, 20 May 2026
 21:45:56 +0000
Message-ID: <95d9f30c-7637-43c1-878c-dee7aead9bd8@amperemail.onmicrosoft.com>
Date: Wed, 20 May 2026 17:45:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v42] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matt Johnston <matt@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260518203900.30720-1-admiyo@os.amperecomputing.com>
 <bca423e86899791f96c626b10f816ac1bff8059e.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <bca423e86899791f96c626b10f816ac1bff8059e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2cb254-d37d-4d90-9995-08deb6b92c60
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003|11063799006|22082099003|18002099003|921020|55112099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	of2Hk9jmqm/6mHj6kLO84pVBuYC1qw+Fy+hT71SdeDlNkYK2WHwlM2abI47BlSZpmKXPTeOO5I4FgYmVSJKSl3GDwiqsnTvIYrbv9p0wPNhDdXyULTU4O2iDzgwnayMFzekOgJYzWsTcUbmD8KQO9sUlKxjnWxwlYtsISBh5ovvn/bNodnY2XGJ/krsfLrIqP/zQZibbP4RlJIDE7pPm6hRy96ehM9FLVHY4zWQUGAGfKQD/ftkjh1s+hq/xum0MAGQvLAF1z9spxhWE+5rwsZsc8kJReC8XrEWuHOAv/wRIkTrNi+rJ5gQCWvXV9SIa0R/px2UeagtLsPrGD9P/Ry/WHWWDRkZMoaTgRt5ysvCnk51KotLofOiCUrd8Jtww5/V5pS3v4dIpFUnTgRQRVqEAXlJ8do2Mv3V+G45ib8+zDslIV4iPujzgkXudr/cXpX4Pmt1GOg26HGy9JOvpgdeUhY57PfTojS3+GqFwlRYVkjYsTWJPVsQTI/MtUAjTYqCCV0JQGSAoOSGWXjcCWT7Q2MIlhjc7iCRsCVKMAyheH/+LmYlxzCelWdcbPka9YIQs3Il7Epj59fuI80ds6BQbvOpG+eV7QfnavzzD0r08KDdC7AfYE06aQ+K1guia8iwVUYIhGsXX8aHczh4C7nkoX+M6cjwi5y9E3k9T9oPfxJkjaoNgJf9NbXV4c0tiMiJ82NhDiPzJbore8y/OrVuFMZhNLxu1KguoK8+CU64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(11063799006)(22082099003)(18002099003)(921020)(55112099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	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/7n?=
X-MS-Exchange-AntiSpam-MessageData-1: uJyzbP9O7PyR+g==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2cb254-d37d-4d90-9995-08deb6b92c60
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:45:56.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0Py5x5PxLWEFj4vyolxoPZ/OPEYQWNXhq9DLIv1TnrKOvsMzVZelhBVwysyU2iUkDNlkyH8CCoReoZdkkrJsnfKTR1UI1afSo19OMNOQAbCdiGMPn+6oGy/vzgfW2zM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8108
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290116-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.493];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D9DF59CBE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I had just hit reesend on the older version of the patch when this came 
in.  Apologies for the churn.

On 5/19/26 00:06, Jeremy Kerr wrote:
> Hi Adam,
>
>> diff --git a/drivers/net/ethernet/intel/stYNFrCT b/drivers/net/ethernet/intel/stYNFrCT
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..9b01d1e909f20fe037eea685116d344a2165db52
>> GIT binary patch
>> literal 564073
> [1255 lines of b85 data]
>
> I think something leaked into your commit?

Yeah, and I did post that I was going to resubmit without that file 
included.  I guess we got into a real-world race condition. Sorry about 
the churn.



>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       u32 header_length;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>> +
>> +       // The message must at least have the PCC command indicating it is an MCTP
>> +       // message followed by the MCTP header, or we have a malformed message.
>> +       // This may be run on big endian system, but the data in the buffer is
>> +       // explicitly little endian.
>> +       header_length = le32_to_cpu(pcc_header.length);
> Is this still OK with pcc_header.length being a u32 (and not a __le32?)
I will remove.  No longer doing any endian conversions.
>
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
>> +       struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +       int len = skb->len;
>> +
>> +       if (skb_cow_head(skb, sizeof(*pcc_header)))
>> +               goto error;
>> +
>> +       pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +       pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +       pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +       memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +       pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> You're doing the endian conversion on read, but not on write. What was
> the decision on whether you need it or not?

The conversion needs to go.  The way the acpica imported headers are 
written they assume machine architecture only.  Hence enforcing little 
endianess in the config.  I thought I had gotten rid of all the 
conversions.  I missed this one.


>
>> +
>> +       if (skb->len > mpnd->outbox.chan->shmem_size)
>> +               goto error;
>> +
>> +       if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
>> +               netif_stop_queue(ndev);
>> +               /*
>> +                * There is a possibility that the mailbox was cleared on
>> +                * another thread between the failed send attempt and
>> +                * stopping the queue.  If that is the case, and we don't restart
>> +                * the queue, it will remain permanently stopped.  To test,
>> +                * try submitting the message again. If successful, restart the
>> +                * queue.
>> +                */
>> +               if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
>> +                       netif_wake_queue(ndev);
> The retry is a bit odd; you can simplify this race handling by doing the
> stop_queue pessimistically, and the re-starting the queue on success:
>
>      netif_stop_queue();
>      if (mbox_send_message(...) >= 0) {
>          netif_start_queue();
>      }
>
> I don't think you need a wake (vs start), since you're running in the
> same softirq context as the stop.

I like that.  It is a better approach.  I will incorporate into the next 
version.


>
> Cheers,
>
>
> Jeremy

