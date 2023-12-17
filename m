Return-Path: <netdev+bounces-58310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF414815CC3
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 01:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267551F229D4
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AE15B3;
	Sun, 17 Dec 2023 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IKyAKAd2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BE1396
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6T+yUEJj7HYwMSm6uB9N3jMW2SBtDM95QDGAlfyI/sKYQcLAw65k5fP5kDq5nGu8qZx77T1BWaa5P1VAVSBQpFSV2vYwsu3z/7tLFfv+n8aTVShjflNv2lZjKGp1wZwlJPMwL/bQNrgp1853b5noCs1KY/1zIH0EVcViGdSqXarveS88csNkcIHUyEd/KAeveszOg5EYboL/YbnSwQJJcUr8WwxaMjYMv0/DBiJU2hXX/eLcOIolwC2+3Vp2tyMYv2tUVzZq04H1HuPoa4d9l+6u/h3zagDVILfaWwXVI5rlgJ0tUIBiPNq7/54lUzSMrjU5OBow7VB9i8rhvfTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j363C6/xFipmpYMGfNXmb6VOPerJs/YjZuHMQvyBooE=;
 b=QqY3NeqwLUQFiyB+//yExMeRVTYKOcuukFH/fIbw4VjgST1EOJ91mS0QC5G87WYcUWMFXq/P+WOHU/9cnDvQFdKQEFn6OaycIQE3Wh1GVKGCrD+nCd+BVXbp1V/IxEhWASJDH35ltdPLCgUaSUPOJNID8+Ff2KO5nXAugl+Rjm911zRsdricI8N4x6DxorD3csHvl5GDMAWtZexsKqcqNAzO0toGkWHuV1CgPNz8PqivnY4zW7mHRApgYrAZzUoSVwOapFfjjXXkhVbLfgzRoD6EDrmqUq4SDv300l/ZTLOrgaMD9F4foWPNmgoB2wEa66uc0KdgG4MthfAtmZwuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j363C6/xFipmpYMGfNXmb6VOPerJs/YjZuHMQvyBooE=;
 b=IKyAKAd20qbf+p7EQN5rmGDiDU3SW+hIR3xQa6XL1fwdwvZ9K717So+VS9kNaMJ3sx5DReUp22CwThsy5yXop5TPzzMLgwOOKd8kXm5RIaBZChFEpvFnpWBQGREw/eXKYn9GDcM0Jv5Ox9WMgn1SJDWkVHjjKa5pyfR/TUmQgGYI6jwjhDKBhYP45bRROFSW6e+HeCOxCfmqake+K+kE1QsvIib6wpFvGrBIC7KLB0C0IGV6ivz+oCKkvcUEgvP5rTtJXqZJj8ImMxXqYm1x31NYl2+tj38Rm4xXO4wxmfK20omPKPKMCslTBHZUeMaBMvrpzR3d+rCSqon7qaWA1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Sun, 17 Dec
 2023 00:18:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 00:18:29 +0000
Message-ID: <51446197-3791-dc89-5772-1496b768cd4d@nvidia.com>
Date: Sun, 17 Dec 2023 02:18:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v21 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-6-aaptel@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231214132623.119227-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: b364cab6-15d3-4a77-0090-08dbfe95b1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mrc4mU5O5OYbhfNgqIAwYUdV8/wnEuk2Kb74Fbh92P3XdVYiI9oynt8+PIRQJz4xEpdFgWFUaKuqHAznzAYWcQCntnNYTcD+E3QS7+/u8qKLpexsJURT1DPZLnRCzJa5/YwsNVzlOdoDNSINpl5zpMpSlxUaN6TsANWRKDOv99uBBTQ19RA4TRYktPVJocCthglByOY9ADEf6ZSPjR9Qrl08s1YaohTyeIuuqx9xm1ucjoI7KpNhWASOy21JKhpBHI1OdQIplCtSUvVb3rvNRV6JefoXZ4s11aYSKdcZNvRoLoDzUPGDk98xnKJrHFjG7BsQNix228s5+A1hQAUndnDl2PcTHk0DnOCWImQvCnFzXrRTrNY522F/UUKtBRLgrA1MlzUIPz+nr8gPulhKgi1/XW3QSPPyby+t0wq/7Yy4nVgbE42Dbcu3CnEPDoR5cmEVuAr48U5VcR3vmSTfSNX+6XNikZlJP/NkLxP9Y/QLPcLo4WbWwTonSnY9ngdCSxOmsHl0dR965y58yIE9lzIHKhgG1PSXo9qq8LJgOomWqj9WBP19Cf0RVrjD0PvIE9VSUQw0cdlGjVOkUxjh38kCFR//wN24o+hU4/RhBE1kDbF0DreOUS0ooKdTZtrQKuldb/q6hjkYfI/qF66VxpzD1n29r8XqHHxJSiVNPPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(53546011)(2616005)(26005)(38100700002)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(41300700001)(7416002)(30864003)(2906002)(478600001)(6486002)(6506007)(6512007)(6666004)(66476007)(66556008)(36756003)(31696002)(86362001)(921008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnM0Nm9DVXpDNjJsZXVvNTRQOEZsaW9nSkFBUmlhd0ROMThJaXg4TWxMeGNt?=
 =?utf-8?B?RGxNUDdpTmoraFRrUWoxUjk4NTYyeDJUd3RoS25sU2MzSGt1MG9QdXNjbGJG?=
 =?utf-8?B?WlNYeDNtcHVaUXpCbDlmbEhmRzB2cTUxb25YS2dkYk9aV1JBYk1pd0Q4WEtv?=
 =?utf-8?B?UUNmYTIwRm85bVNCdVppVWNKL3YwKzVNcUthY01EYTU4SFBJWTZuUElYTFN3?=
 =?utf-8?B?RWZBazQ0QkRrNVFqS1QxQ2xYRHg3RnJzNStmNUpvRytoNmllanRLZXJqU052?=
 =?utf-8?B?UmFORFEzdUNwY0RIUzRuV1RCS2E2N1drU0tHQlZ0OU45MlNyR3lZWnA4ang3?=
 =?utf-8?B?aTJrdXpjaXB2WHRHTnlOa3VRczkwb1FqR05HcTNmYmM1YXB2Y3oxU21tdWdT?=
 =?utf-8?B?aDJBTGJ5SWJZVXBVaWNHdEVQakZhem5RQ0JkdjA1ZTRFMXEvbmcvOC8xRGVu?=
 =?utf-8?B?Rk9rZzFRcEdyUXVNUzdiZVRSL1krTERZNERYZmZFYnVXRmcvaFNETUx5dXN3?=
 =?utf-8?B?VWExZURpZkNZOGU2VFBQMkdESVRqOTY0QnhNSXUxQWorTWdyQ29lSGtlQ1J3?=
 =?utf-8?B?cXR1eGR1N1JtbTJLb1Y3Qm9Pb2hJTmxxc0I2b3grem13NEFpZVhnNHVML0Nh?=
 =?utf-8?B?WTFHOHFtK2lWNGNDb2ZXYTc1czZWN1J0YnhZblhxelluVzFkeG1lQ2dhUWZw?=
 =?utf-8?B?N3ZndnRsdWp0ejdaT0VDSFpseTV2QnU1YnVJTEpQUmpkSmt1bWhQakxBRUlJ?=
 =?utf-8?B?dmtwV09PcVVJWHd4bG1WWUIyRWhMUEZpNmVwclU5NVJReUZKQ2tiWnN6MWJF?=
 =?utf-8?B?R1o5MmRQT2d5N3hKMW9EWmRTUU5zbnZ4ejlMdG1Kdll2V1NPb0dOM2c1T2RB?=
 =?utf-8?B?RmFqZHZORTBESDk0Ry9WQm5Xejd6dUdlUkZTaDVIeTFTSnRobEIydkplbGdM?=
 =?utf-8?B?T2dROCt1eEZpZ2VsYXprTWFGVnh0M2pBbnVxbHNZQURxM0RQMkVPT2pLWlBD?=
 =?utf-8?B?MnI5cm0yTGxnYmVGSEJWclRVK0MzZUZ0cmFtSFRLTHdZSldhTEl4V2dIOHlu?=
 =?utf-8?B?NHFxQ3NzTzNYZFd1bDhGUUFmODYvUDI0NndKQzJTRjJIR0dnaVl1bndRSGVp?=
 =?utf-8?B?bDZtdk5zSGYydHNtaC9tTUF5eU9mbkZTa29XZDZ1dTQxR1d4RjJ4MGdzT3dL?=
 =?utf-8?B?ek5SWDh4WUpQaDZVM0V3QUR4NFRvRksrb2NKM3A3UkNicGxKdjIxQkNjTmtD?=
 =?utf-8?B?MlNHZi8rQnlWU3NRemNBb2p5UW1Oc05OWUxBbkZmQXdTMmxvaWFSUmZKOXhK?=
 =?utf-8?B?MGNzbjE2dXd2YmlQTnFGbjVFNCtHYmFIbXVQZ1dseUJ4L1JsSU52d3BZcXFn?=
 =?utf-8?B?ekJ2SVhaOTc4QnpqM2V5STBQUHhvWjJacG1QeTRxQWdqdVdOSGp4a2I2Y0FS?=
 =?utf-8?B?VUNtRXQ4eVVJMGZsalAzanBmWGhVblZaUXFJVHdJMXVGSUtOOTFSOTRycmwx?=
 =?utf-8?B?SURJZSttcVFIUlRaRWlyU2UwajlWeFE4a2Q0eWYvcDQ4M3hROXlyZHdQRkE4?=
 =?utf-8?B?Y3VEcS85dFlZUnJqUjUvS0FBOEhSTHNtUk5TSGVhRnpxTkZmcEZIT2Jkc2xD?=
 =?utf-8?B?aUdCZEpOdjVFdmtGczVEMzBXZVhqSTRwRkplSGFBbXBER3J5VlVPYWptSzRQ?=
 =?utf-8?B?NjdUeUt0T3ZnZGQyOU1XZ2MvZ2VZS3Q5YWN6aTZZUndocUFjVnBQeU85VTg2?=
 =?utf-8?B?OGpNYjVXUVpvVEVmYUZ4TTlOK0RvcHRHaUxqQU5pSkVOeGg5K2N2VlJCVkxu?=
 =?utf-8?B?Q0hFRnN6OGtIam44WmJieUxjNUVYTUpRNVV3Njd3Uis3VWZLVnhzcEord2NO?=
 =?utf-8?B?ckxzaVRORmpJWVgzVUppQ1RhWTZabUFlUmVCSndtcHRvTHVRSndRN0xkN1g4?=
 =?utf-8?B?VHI1MkxRV2pSTFpYZGYxTXBaNzgvK3cxU2VxcHpVcUQrWDhiZW80L2dsMWJY?=
 =?utf-8?B?aEpiaksxdGY2SmZIMkJyc0E1aWMxQ1VoeDNPQXgxbG1KVWEwcWdWQjdBeUNl?=
 =?utf-8?B?VmJTV3ZsNGlySDF4aVpNemRtbnJGRld6MXJqLzhZZkEzamRkQ1FYei9zcUVD?=
 =?utf-8?Q?ySey9gVordIBDF1EfTh4DHHUS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b364cab6-15d3-4a77-0090-08dbfe95b1b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 00:18:29.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZyin8rDDGndGcDWc8bM61KGFZY4uwePzLN+TT1ZIKYBxQksVYG7zmYZuybqMeeiG/7IEBgjqjD0uDk3MeeQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646



On 14/12/2023 15:26, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake using the sk_add/del NDOs.
> 
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
> 
> 1. TCP OOO causes the NIC HW to stop the offload
> 
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then finding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
> 
> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
> it with the PDU header TCP sequence, and report the result to the
> NIC driver (resync), which will update the HW, and resume offload
> when all is successful.
> 
> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
> for queue of size N) where the linux nvme driver uses part of the 16
> bit CCID for generation counter. To address that, we use the existing
> quirk in the nvme layer when the HW driver advertises if the device is
> not supports the full 16 bit CCID range.
> 
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments via ulp_ddp_limits.
> 
> A follow-up patch introduces the data-path changes required for this
> offload.
> 
> Socket operations need a netdev reference. This reference is
> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
> a follow-up patch.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 264 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 251 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d79811cfa0ce..52b129401c78 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -21,6 +21,10 @@
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
>   
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp.h>
> +#endif
> +
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -46,6 +50,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ddp_offload;
> +module_param(ddp_offload, bool, 0644);
> +MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -119,6 +133,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -146,6 +161,18 @@ struct nvme_tcp_queue {
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
>   
> +#ifdef CONFIG_ULP_DDP
> +	/*
> +	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
> +	 * an additional flag in the lower 32 bits) that the HW send to
> +	 * the SW, for the SW to verify.
> +	 * - The 32 high bits store the seq number
> +	 * - The 32 low bits are used as a flag to know if a request
> +	 *   is pending (ULP_DDP_RESYNC_PENDING).
> +	 */
> +	atomic64_t		resync_tcp_seq;
> +#endif
> +
>   	/* send state */
>   	struct nvme_tcp_request *request;
>   
> @@ -186,6 +213,12 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device	*ddp_netdev;
> +	u32			ddp_threshold;
> +#ifdef CONFIG_ULP_DDP
> +	struct ulp_ddp_limits	ddp_limits;
> +#endif
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -297,6 +330,171 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_ULP_DDP
> +
> +static struct net_device *
> +nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	struct net_device *netdev;
> +	int ret;
> +
> +	if (!ddp_offload)
> +		return NULL;
> +
> +	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
> +	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk);
> +	if (!netdev) {
> +		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
> +		return NULL;
> +	}
> +
> +	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
> +		goto err;
> +
> +	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
> +	if (ret)
> +		goto err;
> +
> +	if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
> +		goto err;
> +
> +	return netdev;
> +err:
> +	dev_put(netdev);
> +	return NULL;
> +}
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	int ret;
> +
> +	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> +	config.nvmeotcp.cpda = 0;
> +	config.nvmeotcp.dgst =
> +		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.dgst |=
> +		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
> +	config.nvmeotcp.queue_id = nvme_tcp_queue_id(queue);
> +
> +	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
> +			     queue->sock->sk,
> +			     &config,
> +			     &nvme_tcp_ddp_ulp_ops);
> +	if (ret)
> +		return ret;
> +
> +	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +
> +	return 0;
> +}
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
> +}
> +
> +static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
> +	ctrl->ctrl.max_hw_sectors =
> +		ctrl->ddp_limits.max_ddp_sgl_len << (ilog2(SZ_4K) - SECTOR_SHIFT);
> +	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
> +
> +	/* offloading HW doesn't support full ccid range, apply the quirk */
> +	ctrl->ctrl.quirks |=
> +		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
> +}
> +
> +/* In presence of packet drops or network packet reordering, the device may lose
> + * synchronization between the TCP stream and the L5P framing, and require a
> + * resync with the kernel's TCP stack.
> + *
> + * - NIC HW identifies a PDU header at some TCP sequence number,
> + *   and asks NVMe-TCP to confirm it.
> + * - When NVMe-TCP observes the requested TCP sequence, it will compare
> + *   it with the PDU header TCP sequence, and report the result to the
> + *   NIC driver
> + */
> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +				     struct sk_buff *skb, unsigned int offset)
> +{
> +	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
> +	u64 resync_val;
> +	u32 resync_seq;
> +
> +	resync_val = atomic64_read(&queue->resync_tcp_seq);
> +	/* Lower 32 bit flags. Check validity of the request */
> +	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
> +		return;
> +
> +	/*
> +	 * Obtain and check requested sequence number: is this PDU header
> +	 * before the request?
> +	 */
> +	resync_seq = resync_val >> 32;
> +	if (before(pdu_seq, resync_seq))
> +		return;
> +
> +	/*
> +	 * The atomic operation guarantees that we don't miss any NIC driver
> +	 * resync requests submitted after the above checks.
> +	 */
> +	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
> +			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
> +			     atomic64_read(&queue->resync_tcp_seq))
> +		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
> +}
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
> +{
> +	struct nvme_tcp_queue *queue = sk->sk_user_data;
> +
> +	/*
> +	 * "seq" (TCP seq number) is what the HW assumes is the
> +	 * beginning of a PDU.  The nvme-tcp layer needs to store the
> +	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
> +	 * indicate that a request is pending.
> +	 */
> +	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
> +
> +	return true;
> +}
> +
> +#else
> +
> +static struct net_device *
> +nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
> +{
> +	return NULL;
> +}
> +
> +static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
> +{}
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	return 0;
> +}
> +
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{}
> +
> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +				     struct sk_buff *skb, unsigned int offset)
> +{}
> +
> +#endif
> +
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>   		unsigned int dir)
>   {
> @@ -739,6 +937,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_resync_response(queue, skb, *offset);

lets try to optimize the fast path with:

if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP, 
&queue->flags))
     nvme_tcp_resync_response(queue, skb, *offset);


> +
>   	ret = skb_copy_bits(skb, *offset,
>   		&pdu[queue->pdu_offset], rcv_len);
>   	if (unlikely(ret))
> @@ -1804,6 +2005,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_unoffload_socket(queue);
>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1820,6 +2023,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   	mutex_unlock(&queue->queue_lock);
>   }
>   
> +static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
> +{
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +
> +	nvme_tcp_stop_queue(nctrl, 0);
> +
> +	/*
> +	 * We are called twice by nvme_tcp_teardown_admin_queue()
> +	 * Set ddp_netdev to NULL to avoid putting it twice
> +	 */
> +	dev_put(ctrl->ddp_netdev);
> +	ctrl->ddp_netdev = NULL;
> +}
> +
>   static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
>   {
>   	write_lock_bh(&queue->sock->sk->sk_callback_lock);
> @@ -1846,19 +2063,37 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	nvme_tcp_init_recv_ctx(queue);
>   	nvme_tcp_setup_sock_ops(queue);
>   
> -	if (idx)
> +	if (idx) {
>   		ret = nvmf_connect_io_queue(nctrl, idx);
> -	else
> +		if (ret)
> +			goto err;
> +
> +		if (ctrl->ddp_netdev) {
> +			ret = nvme_tcp_offload_socket(queue);
> +			if (ret) {
> +				dev_info(nctrl->device,
> +					 "failed to setup offload on queue %d ret=%d\n",
> +					 idx, ret);
> +			}
> +		}
> +	} else {
>   		ret = nvmf_connect_admin_queue(nctrl);
> +		if (ret)
> +			goto err;
> +
> +		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
> +		if (ctrl->ddp_netdev)
> +			nvme_tcp_ddp_apply_limits(ctrl);
>   
> -	if (!ret) {
> -		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> -	} else {
> -		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> -			__nvme_tcp_stop_queue(queue);
> -		dev_err(nctrl->device,
> -			"failed to connect queue: %d ret=%d\n", idx, ret);
>   	}
> +
> +	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
> +	return 0;
> +err:
> +	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> +		__nvme_tcp_stop_queue(queue);
> +	dev_err(nctrl->device,
> +		"failed to connect queue: %d ret=%d\n", idx, ret);
>   	return ret;
>   }
>   
> @@ -2070,7 +2305,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   
>   static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
>   {
> -	nvme_tcp_stop_queue(ctrl, 0);
> +	nvme_tcp_stop_admin_queue(ctrl);
>   	if (remove)
>   		nvme_remove_admin_tag_set(ctrl);
>   	nvme_tcp_free_admin_queue(ctrl);
> @@ -2113,7 +2348,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   	nvme_quiesce_admin_queue(ctrl);
>   	blk_sync_queue(ctrl->admin_q);
>   out_stop_queue:
> -	nvme_tcp_stop_queue(ctrl, 0);
> +	nvme_tcp_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
>   out_cleanup_tagset:
>   	if (new)
> @@ -2128,7 +2363,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>   {
>   	nvme_quiesce_admin_queue(ctrl);
>   	blk_sync_queue(ctrl->admin_q);
> -	nvme_tcp_stop_queue(ctrl, 0);
> +	nvme_tcp_stop_admin_queue(ctrl);
>   	nvme_cancel_admin_tagset(ctrl);
>   	if (remove)
>   		nvme_unquiesce_admin_queue(ctrl);
> @@ -2413,7 +2648,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
>   
> -	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
> +	if (nvme_tcp_admin_queue(req->queue))
> +		nvme_tcp_stop_admin_queue(ctrl);
> +	else
> +		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>   	nvmf_complete_timed_out_request(rq);
>   }
>   

