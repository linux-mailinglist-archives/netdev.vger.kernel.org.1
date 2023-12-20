Return-Path: <netdev+bounces-59234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A3819FE5
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0747F286A55
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2725548;
	Wed, 20 Dec 2023 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvu8j17O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E334540
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4qHnN8bcUabR//elN5RMkNBP//0ofo2tdZo4ETeSPo0BNfJgk7gj8MjFUQS92OF3ws4iMGnPNNy5WW5AqIcmByVv3e+g9NRLAKQxIUO5ztGjMuUtcRbMXtdlX66dqxMvQAJtSOQwVWw8ig+Pq8l884NjjCo2l53HAW2LxqeDfgMdynxQ2g2pfh1gtinMNMQkTY21UXVsZFaB7v3SjvxZAUVJ5YEvan24/dd/f2mK8Zr6D6ZxQa1YR1WLaQfyfiuNYIFm6jyAF00mavGUAcd+v7M2NN7kb4JR1OokiH7z26zAdL/o4joonvbURPuGRifqPjR5JqVWLHclf38g8S2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB1BLYuUQLIii5KzDsN96O+uIyeDmXDOn/llyW78ic4=;
 b=ZynJ8qCG03OyX/l4aexMfNZhVUlg89L6pscyxqH6R39uWTzCId62RUOwpDveMAEsH4fvBmVao3XieYzwORRsCB6cnhr5Qa/KnWks1VEaO/F3ScUW9tGp+f9jVMhQl3FN0CiYx54XIqFstsILUTb/5LrFAEs9FhwD1YD5iB4VFHJvYZYLmnyUgaKKM5gtjDPHW1acRYaJjQY5I69NPsV6eWSkF65Q7GGBX6QeRHHLrsQFclnCHGAGMe9mowFYsG5MlirTI16vFlS53VDUUUZn7+3y3+0Y/hRsiqVLXnKtF57fz+caCMs+c1ZYySzWmI84XpZMR7kMLLNAxTSHXheMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB1BLYuUQLIii5KzDsN96O+uIyeDmXDOn/llyW78ic4=;
 b=jvu8j17OnbItnLIlbvNqNJF4yhtdvcnAVnIzJsvEuZtS1nfdtnPXJpf0Jc4EctUyJUnlPrwNFpflPcONbzGvKkR6eToawX8Yn7mxeQt+uIXQdKZT/h47YmkFWsMQiQyyzBDIKODMwX+WvWBRprzTGrt7zUg5YgiJTWKQl+M6uL9MeVWiGHy3CaawG9QdQgesTc+w1CXwfC/wievHtapJYWvIOeRbQFGj9lxxxSQN7RMy6DK9xgCP6W64vM1bDBE0M6J2Xe8h4y50b6mAgdtxeRw+D5DClHF5iK+MvEkFJaum1zsQvFChMJYshhtgLNOIaiF9r4YeafmzXZsRuBLTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 13:35:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 13:35:28 +0000
Message-ID: <5c6039e6-e373-4e38-9e45-7834551be4d0@nvidia.com>
Date: Wed, 20 Dec 2023 15:35:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 07/20] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>
Cc: Yoray Zack <yorayz@nvidia.com>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 Shai Malin <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Gal Shalom <galshalom@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-8-aaptel@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231214132623.119227-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 23390da8-91ac-436e-1321-08dc016087ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	29wHAbbxNlHMpdm2aPoQwk2E6GncuyQKBGS5AyHeVHChrWjWwDvQGBGzYrXXulusS8eH31up80jUBLJRQ/9O9XaxkwtLy3/U5hnfotpgpqLvdAmj5A5dF0/vS0MGJCm06I1IWuccdMoIqsBixw6tWbQo6D7ccdI2Yv/R2L8ldrC+BofsgFmek+ThF2hoJcICNf3XCQmRT1Y+LkiQFUFi1VyoFJ8TVwaM7NQYVpJ7HrzVfJ5aPonAio5BLPhanvls4nKKwDyeELwX2n4jE4ntOlylwC2EK2vCvqGR8JHU+w86oGLJtlXuaLBIu+Qq7/cOukCoYfGmLILcEBASwvc2vkCMHaC5nM4aihwEDbb2Z/24IYPAoZjNDtpe1Z0kTQE5QtmHEGXgWGkX0rEkyWouT/e7P7RC1uMtGtXBonw4WweQK51L+9jTuq6EHeAQGuH2no6igk1yWRzUqGVIGasKeGH1284bC6nrj5n+FJivZ0/2kY7cBdMOQ9dagZJq3uDEWVoBks8jkg2Oi509A5maDAw5b9IlDUwHBS1gmN1lxWeLrSSZPAc94w1znNpJzHYuWv06/osdhd/DJLYX1XoqiiMpk1ensQ5CxdbC99i2xVAu7d+aFY9NC4RO1YS+PpXHwXWEh7p2Wf7LXgcpQcK9xT7W72ZbKWEfnfCeqyO14TU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8676002)(8936002)(4326008)(36756003)(38100700002)(41300700001)(31696002)(86362001)(921008)(2906002)(5660300002)(7416002)(26005)(2616005)(6486002)(53546011)(107886003)(6666004)(31686004)(6512007)(6506007)(478600001)(54906003)(66556008)(66946007)(66476007)(83380400001)(110136005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M056U1MwSFZMamRWUjZ3eUxlNUc0cDhNbEtsdHlZV09LeVZWWldRVnk3azJV?=
 =?utf-8?B?cDNVNHJtK0ZpTXZCV3ZPdDZmd2JUWXcwd1hGVlVWMTVTOGJvTzhYcW56U2tG?=
 =?utf-8?B?N3IwekJKaXJ1NmJ0SkRNaTFHMmk1bld2bFpKRS8rV1FnN2syYjhmSS90dDNu?=
 =?utf-8?B?bGhhQ1Baa1hQYkdIYUlWdFhhK3djUlF6eTI5Wk85RGFzbVhlWGhRYXVxSDc4?=
 =?utf-8?B?eDJQMEFzZUk5WEw2SDRiUEdHTER1S0VMRnp3WUVSbG54RkRMc1ovSW1tS3Za?=
 =?utf-8?B?UVRpNXpvLytGU0FGNzJXTjRrT21rUURyT1VlbDJabzR1RHFQankxRUxJU2U2?=
 =?utf-8?B?RysxUkI4dGtLL1dIRFFPR1FKbmhHSU43S1VtUFRBZVdjNjlFWEc2Z3o2bjlZ?=
 =?utf-8?B?dnRyM2ZkZXI3eThRNTkxMFJ3L21ES0lQd0Q3TW84NGlmaTFmZ0NFSEx1V1Vr?=
 =?utf-8?B?QWVQTXVOcURwM2YrSXhqamYxYnR6QjlEcC93S05zdlI5bnRPblE5TVFNdTZJ?=
 =?utf-8?B?U2x6ZHA4cWJPTHN4QXhiVXUwRlNvOWJXK0tiYVIrbk1paHdBc0o5WjVpMVAx?=
 =?utf-8?B?NGllU1lvQVp0VngwMUlEY0t2UEFNc0srRzVtbVhzTnJNcXI5ZE1TUGNXQXdh?=
 =?utf-8?B?Zkd4cHpBSEpXd1FqMzRORXFTUFUrSExiNmJQT3h0QTlCV2JRNkxmRGgxbjRK?=
 =?utf-8?B?MVp5cmFPYkdGTm1hTjQrTDJNOC9GZVQ2SkxZaDloNlJld0JyZ1dTekJLdnhp?=
 =?utf-8?B?T3R4eGh4LzRNVHZ2VzEweDE1SjNnbzZXdlFMUzBUTmJSOXJhdEtGL2svNzEz?=
 =?utf-8?B?NGx5ZDZ1bUJkL05kNkt5MStNUGw2bmJ3eXlSSmg2WVZuczlROUplOEJ6MkhI?=
 =?utf-8?B?TEJFYU9md0kycjhrZVJCZDB4V1AwWVhzMGVINDhodGV1TnhZMzA1RlBvUU1n?=
 =?utf-8?B?UTlqTmMwd0NaNWdycFgxMEQ3ZGh2M1dZcExHVm9hUytwRCtvdHlIL3lEQVM4?=
 =?utf-8?B?aUQwd21BUnpyNi95SVhwODlzNHdIdU9lRFlocG9rMXlJbHdlSzdQRkZlbFZr?=
 =?utf-8?B?VGY1eVplQVdQVldEZ2ZhUVlvd0hBOGMrNXQ3VUtoaEw0bENsVWpGRml2TnpD?=
 =?utf-8?B?UHppdkRVOHdNcXVxeG5LUDhJRnEyb2pvanJUUU5wUC9mbzBweU5xeEFpdm5S?=
 =?utf-8?B?VFdteUpHSG9Lak1JTXNWZ2xoVktHYThwSG5iVmFxL0JFek83QXhudHIxSWk2?=
 =?utf-8?B?b0F5MlFWQzJQQUZKSTlOeS95Z2lPa0Y1UzJGZFlUY00xdkFmYjFRV0ppcEFk?=
 =?utf-8?B?a2NpaFkyckNUbnZGVGpESDJUMllNR3pTaGtaTGJRK21tNlNJc1pVU3pmVk9Q?=
 =?utf-8?B?UEJTMFU2ekkwbTY4aFlvcmNUSytGN3Y5alo1SmMzUEFkcjVJMDFkSk1Fd09q?=
 =?utf-8?B?SDZybzAxTzhoVHBINkdiYVVVU3oyQTE5Uk5QNEtYMU9ybVZFYlVTQnlWTmZB?=
 =?utf-8?B?K3lQUTQ3MEJRUVdiNkhZM1pVQ2tvb3A0dHFtWHk1WGZZN1pFSEFZU29ZZ3h4?=
 =?utf-8?B?SEhGaFplVWRoWW40SWxxWWR1QnN3aW9tdnpEZFQ0ODd1RTNSRzBQMzFuZXZm?=
 =?utf-8?B?TERrRFdBd1dEQU5xekFEVVV5aEhIUkZrQXZpQ0lKdklONmtPZU5qM0JXdlpV?=
 =?utf-8?B?dTlxQmFaWWhTdlhsaFNsczRpclFPQUQ0M3JPd0FuVCs4VTV3bUpxMndRYktZ?=
 =?utf-8?B?WnFFZ3BPYWxSdGl0RFMrQ1FmSnIxMGdjN2hjTVcxWnRoRFIrbUJqbktBR3pB?=
 =?utf-8?B?QzNQbStrTTBsOW5JenU0MnlCVnNUdHNJWTNSM3czRlhHVDlIMW0wQXJ0ODhu?=
 =?utf-8?B?YVVDS3RQbXNxTTFSLzBybXd1RlZsMVU1SmlrSDhSWmRRenNZOTZmQ0lRSGJ2?=
 =?utf-8?B?WDhuMm5mSXNlVXltNC9wdG5KVnhhb1prRGdtOXkvSkYvdUZQamZ5RDhZMllC?=
 =?utf-8?B?Zjdlc2tCcWtuSzVhZ0Q4M0JwRStCeDIrY204L2JBbktGMmJXZVUweWVvUWhv?=
 =?utf-8?B?WFNVN0ppUENiKzlxVFFvSStPUzdnL05nbldDQjVxd3V6aG5wT1A2eXVELytD?=
 =?utf-8?B?Q1NoN0tEbHNvMmlmZ21GdUpraHlvVHMxcjhCYU5lS0IxNGQwMVRISTVmRWlY?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23390da8-91ac-436e-1321-08dc016087ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:35:28.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n7Z31oNXLrWhqdzCKG8VTgqVanTIgLTC/qhih+8/3VJ81exae7wiO3d8wX/EdgaJV4OfRLCLHR47jnpvFPmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221



On 14/12/2023 15:26, Aurelien Aptel wrote:
> From: Yoray Zack <yorayz@nvidia.com>
> 
> Enable rx side of DDGST offload when supported.
> 
> At the end of the capsule, check if all the skb bits are on, and if not
> recalculate the DDGST in SW and check it.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 81 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 09ffa8ba7e72..a7591eb90b96 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -180,6 +181,7 @@ struct nvme_tcp_queue {
>   	 *   is pending (ULP_DDP_RESYNC_PENDING).
>   	 */
>   	atomic64_t		resync_tcp_seq;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -378,6 +380,30 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   	return NULL;
>   }
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return queue->ddp_ddgst_valid;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{
> +	if (queue->ddp_ddgst_valid)
> +		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
> +}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> @@ -467,6 +493,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   		return ret;
>   
>   	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (queue->data_digest &&
> +	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
> +				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   
>   	return 0;
>   }
> @@ -474,6 +504,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   {
>   	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
>   }
>   
> @@ -582,6 +613,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>   				     struct sk_buff *skb, unsigned int offset)
>   {}
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return false;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{}
> +
>   #endif
>   
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> @@ -842,6 +887,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +#ifdef CONFIG_ULP_DDP
> +	queue->ddp_ddgst_valid = true;
> +#endif
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -1107,6 +1155,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (queue->data_digest &&
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);

I think we can only use the test_bit(NVME_TCP_Q_OFF_DDGST_RX, 
&queue->flags) in the if condition.
We dont set this bit unless queue->data_digest is true, correct ?

It is a micro optimization, but still can help.

Otherwise looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

> +
>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -1135,7 +1187,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest &&
> +		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);
>   		else
> @@ -1177,8 +1230,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct request *rq;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1189,9 +1245,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +			    pdu->command_id);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
> +		/*
> +		 * If HW successfully offloaded the digest
> +		 * verification, we can skip it
> +		 */
> +		if (nvme_tcp_ddp_ddgst_ok(queue))
> +			goto out;
> +		/*
> +		 * Otherwise we have to recalculate and verify the
> +		 * digest with the software-fallback
> +		 */
> +		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
> +					  &queue->exp_ddgst);
> +	}
> +
>   	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
> @@ -1202,9 +1274,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			le32_to_cpu(queue->exp_ddgst));
>   	}
>   
> +out:
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		nvme_tcp_end_request(rq, le16_to_cpu(req->status));

