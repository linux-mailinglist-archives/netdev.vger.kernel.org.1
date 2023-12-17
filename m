Return-Path: <netdev+bounces-58372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A898160A5
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 18:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E71C20FAE
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6D45954;
	Sun, 17 Dec 2023 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8UvSaLO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74444C9B
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDU+/AoKFaaV7MSGwAB7fNYpCxRO/B+Z1EIIGwvddaERisHuZ1aUyK/YSqv2a7uEhmmtrAGlAXTG82hNKWYik1rGiirnSDsIdoXqrAHY524afiSembdLPO3/siRzPVf5EVFqj4uS06Z8MnEKwCbHZ4fqM/qAjCAy7wSxjuVYiJHqwsoPRJAKGy7lUt2vFRQmImFNTNTnJZZ3HIqgxDCM7JV0/dWdN3gkyb06fISfQ1r9XN3SPgsb2aYx3gmeGupRP4pae5LWkZl57cenxEaAtyDfbaRkGXmzFFLpWUL3MBH0LTCrjUNQYzdzNPIfid6j1y7z9rlGGXt0qUuZSq8PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnsYDd4sLPEqUcsiMS6O2Cqu3U6vxjLlOk/tWT5OadQ=;
 b=gYENCJCZVLhdQmc3Fhgc45kef67uApPqTOSsK8Aal4jm4doc652ML0pEPPkTEeVGQ289YJPd5QhJG5ytiMvfLEPRy4/r6hkaiVdyy4x2LDsNLUNqkTjhh0L1nOlXEkTGGF42oOsrQ/Z3ANjC3ISpIO99um2ElYL3HAsxyypYGHLHiUx5BGr8GeTgzMpLNYXYYsptzwpL875Hyzj68aCX6GeAOpe1yYUtKBPiezPbBOJb0O3//RQ9o/nUTDHN7AJaB1E7fBEGabwVL04StIUH+heimPGKrh/L8lwYz71mbml80Gq7qXQXELJf/if0mGyKgX7AT7XpTKQSUzT6fI1FQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnsYDd4sLPEqUcsiMS6O2Cqu3U6vxjLlOk/tWT5OadQ=;
 b=G8UvSaLOFHd/Pwo4KANM+6qKNlSdZv5T5Oy6xKjawDdrJP0ACBPY1h5mWiyjeJtHFUtuDcqABnX+CvEQhqCUtwD9WKtuZHt5O+92Gsxjs7O12RYNNrVv2AwJS4fVNwIjSRM1ImRqgDcXf3mCwAVfdQdDQfMwGAvkuoUNI8DMGf//dEPAci793T1zXsEBZO+MJiULiY/JuNYjPq9q2XUGW1Xo7OCT0H0mwBCcHFrQTrvC4A4c4HFTFuEpDgcARHuI7NKFWic/ZcS5Z2lwg3fPEzccOCdKuV5bBZRYNxC9p68sht2U1MfxO40BiZ26w4JGqnuzRnqnwOLZvRiUfCea0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Sun, 17 Dec 2023 17:06:23 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 17:06:23 +0000
Message-ID: <1b0b08f9-3e1a-106e-15ec-46cfe07b1e28@nvidia.com>
Date: Sun, 17 Dec 2023 19:06:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v21 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-7-aaptel@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231214132623.119227-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1342c0-d3a5-4dbb-ad6b-08dbff227f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	itv5Xq1MKYifDTIdMsPkSQ0Rxc4RnHv5dv9Iscjfqo0Gn/Ks2knSVEf+4XymkZJrYmoV0CtRk1f5hVgKT7mcZ7tFebth7+tQZbs43hFRULiPVgu6JlJokrksrFal+6cQ0x+Lkm5D+v4NzSJNzCTgoKUaxDWmQ5Aw72VCJHHjJZiioo2lk31FB5hr2BxOkgQQ3A021GyfEN7/31iPLFls8YO3kbBW1sTQJ5tL1UBsAwMudWF9PGaUYX9J2a5jE4hcmZtzaDX2AksHCgdUwMZxbZhbwtzBkTDNRnILlmtDq8Czgm+kGUNbaeVPbiC8wtWKKhDEd1iuQxyl28DtsH0hFbM1CxMWtXhmzYhkib+ZDEnQvEEhAGgcG5/69q6Re4L+NXTz2LBGWIZ9RgbOGLfF6aELT13LHem6ULTS32o2CdqqtzMCHe8/V9oYWDR95SCwLSlsQh15Td72CHWnTTUd+QdX38NfsD4m+FN9fthNfD5K5wChqUFm9MewSQ6rFMNtZ7I1eliYXjibhc8yvWPqZ2D2ErLn4qwwekUVgNzVUGZ5L6VJgsGqYl1UD7rmnWE/xCeNKHmaoSFvpnWLjYRYldDKi2jy9tI8T0LmKtt4VX1qW1v/YJVXFsTajC2/1wXAww/AoUqvkneD17s/hOtuWr8fOUWw6zwA1kJSSWU/+gA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(921008)(5660300002)(26005)(7416002)(36756003)(83380400001)(2906002)(31686004)(41300700001)(316002)(31696002)(6512007)(6506007)(6666004)(66476007)(66946007)(66556008)(8936002)(53546011)(478600001)(8676002)(107886003)(86362001)(38100700002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em44WDhiUmRtM2xNOGdxZmkxQTlybGpXc09nUEx5d0xmeHlFV21FeGF6bG9E?=
 =?utf-8?B?ZTMyUjFPTHQ0SmEwK0RVNDlxRngzU0J2NU9oaWN5b1Z5UEJhL3Y3dHA1V3Ez?=
 =?utf-8?B?S3owZnNDVkJLeC8zTnl1K0VsNkQxdjFCaEFDMFp6WGNReENubnMvd3VvQ3VW?=
 =?utf-8?B?WE1LcU9zcHp0a0tDQzljUVhnbGY2cG1UUEZJMnJ1N2FybHIwalEyUXc1bHV6?=
 =?utf-8?B?VTZMenJNeDBhZXBYRkY0VVI1MFo1d3BSeW9FWGpmNDlKazJYZ1BtbGZoeS9w?=
 =?utf-8?B?QVVYbzRBMTN2QXhGbTFFQy8xK1lDMHlYMmxYL0dRS0NkMUdsMG5aUTg3OTUr?=
 =?utf-8?B?bUpNNzhVYmRlcW5ZTFBQaGJSOUVKZXdxOW1od3lmR3llaGtPYTdSTEFON1Za?=
 =?utf-8?B?c3FHTDRmOElTTVI5Ui9OTFhoQmhuQy9sK1ZaREZmc2dhMkZIZVJ2Rk9GWkI5?=
 =?utf-8?B?c3FuTGRQWUh1SjFNMHEzTHdERGZXRldBdlQ4aVJFeFV1Mi9HM0FURU9UT2lq?=
 =?utf-8?B?VFkvTmhSNUxQSGlJdmVrbDRONmlWNmszc0ZRK3BabGNUaEgwcEFneUljUmRO?=
 =?utf-8?B?dVgrYmtOaVlLcjYyQ1RKUDhFWk1Za2g3elROM1VjVERuN09SL2NseW5TS3A4?=
 =?utf-8?B?NGh6TElmeEQrUTVyUUgraDVJREQyMnQwclExK3NuZy93KzJWWFVENnk0MkFP?=
 =?utf-8?B?QTRJZWNkU1VDQkNkTEhjVGdIempObEFhWjR6OTJCSm5PbGZJaXcwV3hFN2k5?=
 =?utf-8?B?TW1SRDVycTIrb2FiNFhiV0hHb3hmamRqVmlOc3hQTnRIWW9CMzMvdG1kTGdh?=
 =?utf-8?B?Nk11OG1haXJyUFFFU3lDUDliVnB4c2xrenZDNkREN1ZsOE9PZ2lxUUx2NFd4?=
 =?utf-8?B?MnFENWVFaEZ0NFlObUZwNzk4MG9DYWc1VkxZL3BWbmZrQkxkZGlOWnR3a0VU?=
 =?utf-8?B?aWNEU0F6Z1VFWXFhRW1ob016VlVmSkRueFV0RmFUa3cyQXlKYmdLcmJUK2Mx?=
 =?utf-8?B?QUttcmdaWFpNdFF2akRuaytzMUpWcEdhS1RGUnhwT1IwS0thSXBYcGhUVGNH?=
 =?utf-8?B?dkVVamhIQU1heHNOT2JHblVEbFFnNXZPbEhyQmZqWWZWZ2xZQnVGYzk3d3Fq?=
 =?utf-8?B?M0t5a0lZZVUzV3ZKTElGWWZ6dmlWZTRGZ2tKMzFtRE1admRLUEVJTEtoT25J?=
 =?utf-8?B?a1pUcWJpSXJCY1cvbmFIR29OWGNPeENPMWt2ZURkWXlkazBFa0JBSldFdmRR?=
 =?utf-8?B?ek0wODlwdjFNamw2QmZNaEJOK1dFZHRDWWptajVYRCs2cGwvQ3UzaVdNcXd3?=
 =?utf-8?B?R0lqVVdJUmZKdXZVMkRkTTdTbjF5YW42Y1NEWTN4N2h0RGRRWlMwV2o3cUp1?=
 =?utf-8?B?dytWVVVNak42eU9Kb01ObGN6WWo5ZUlKMU9nd08vMklhbVBCSnNqd2t2ZU9D?=
 =?utf-8?B?bU1yYWE4Rm5qYm0rWlFGakV2MmsrT0NYckZ3YkZlQ2RuRjZ6L21GNEJLcGxr?=
 =?utf-8?B?Z1EzUGZGd09FbGs5azl2eEsxUkYybFlHK3hiaUFpeFlReFZBVzVnV2xsaUpU?=
 =?utf-8?B?QkNTWG5jbDVOYzBHYmNwb2hQZmdkTDBSbVpZMStpVWUrcUR6STV3Vyt0dXll?=
 =?utf-8?B?Q3FxUS8rYVRSQTNLY25oTlFuakNnUFZ2NGRQeS9icWZxSVRBZzNBMERFaS94?=
 =?utf-8?B?KzFtQ0tYeGVTL3BiOTVJdGh5YTZIZnd3aW9kZlk1VXE0QW96OHUvQWE5SnZo?=
 =?utf-8?B?Tk41dzlYUjVHWDZIT2FiY0ozbmMwNEMrK2k5dmVrd1l0SytVWWY4MlFNWCti?=
 =?utf-8?B?QnFLT0hjbEpwaEpnNytHUkFZNnlKSXZ5VUJ4M3BlZXJVYU5teVNQaVlzWCt4?=
 =?utf-8?B?T3FSaHp5Y1hiUHl0dTdUczM2NEJONjN1TVpMekx5M0tnaXFGTGprL2o5cUM4?=
 =?utf-8?B?QWpQN1Faam9HMW92VVQvLzRORFJzbERLeDlSRUc4M2E5T1k3RVNxRm03Tmpr?=
 =?utf-8?B?d09pdHZSakVoWk5oSWVqV3JCUjVrcTVEMlpWSzRybmtXdHV2Q09CMm9pMUhC?=
 =?utf-8?B?azBIeXZwOFord3YxMkdCazhzTGl5RERNdkhyd3ZYSEhKTnVEWHZjN1ZMOStT?=
 =?utf-8?Q?e7Z7s6RpNoVrmVa7bMpmrUL5i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1342c0-d3a5-4dbb-ad6b-08dbff227f16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 17:06:23.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUbR7Zw/Lj1o/lJDtIgiSc7B+cFx2lKTUmUjVizquzbU1G74cF5wxqiJVTC4BySPpJaaNs13jqOirdV/o17YUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469



On 14/12/2023 15:26, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> Introduce the NVMe-TCP DDP data-path offload.
> Using this interface, the NIC hardware will scatter TCP payload directly
> to the BIO pages according to the command_id in the PDU.
> To maintain the correctness of the network stack, the driver is expected
> to construct SKBs that point to the BIO pages.
> 
> The data-path interface contains two routines: setup/teardown.
> The setup provides the mapping from command_id to the request buffers,
> while the teardown removes this mapping.
> 
> For efficiency, we introduce an asynchronous nvme completion, which is
> split between NVMe-TCP and the NIC driver as follows:
> NVMe-TCP performs the specific completion, while NIC driver performs the
> generic mq_blk completion.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 125 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 120 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 52b129401c78..09ffa8ba7e72 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -120,6 +120,10 @@ struct nvme_tcp_request {
>   	struct llist_node	lentry;
>   	__le32			ddgst;
>   
> +	/* ddp async completion */
> +	__le16			nvme_status;
> +	union nvme_result	result;
> +
>   	struct bio		*curr_bio;
>   	struct iov_iter		iter;
>   
> @@ -127,6 +131,11 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +#ifdef CONFIG_ULP_DDP
> +	bool			offloaded;
> +	struct ulp_ddp_io	ddp;
> +#endif
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -332,6 +341,11 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   
>   #ifdef CONFIG_ULP_DDP
>   
> +static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
> +{
> +	return req->offloaded;
> +}
> +
>   static struct net_device *
>   nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   {
> @@ -365,10 +379,72 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   }
>   
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>   	.resync_request		= nvme_tcp_resync_request,
> +	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
>   };
>   
> +static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				  struct request *rq)
> +{
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	ulp_ddp_teardown(netdev, queue->sock->sk, &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, req->nvme_status, req->result))
> +		nvme_complete_rq(rq);
> +}
> +
> +static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +			       struct request *rq)
> +{
> +	struct net_device *netdev = queue->ctrl->ddp_netdev;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	int ret;
> +
> +	if (rq_data_dir(rq) != READ ||
> +	    queue->ctrl->ddp_threshold > blk_rq_payload_bytes(rq))
> +		return;
> +
> +	/*
> +	 * DDP offload is best-effort, errors are ignored.
> +	 */
> +
> +	req->ddp.command_id = nvme_cid(rq);
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table,
> +				     blk_rq_nr_phys_segments(rq),
> +				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	if (ret)
> +		goto err;
> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> +
> +	ret = ulp_ddp_setup(netdev, queue->sock->sk, &req->ddp);
> +	if (ret) {
> +		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +		goto err;
> +	}
> +
> +	/* if successful, sg table is freed in nvme_tcp_teardown_ddp() */
> +	req->offloaded = true;
> +
> +	return;
> +err:
> +	WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
> +		  nvme_tcp_queue_id(queue),
> +		  nvme_cid(rq),
> +		  ret);
> +}
> +
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> @@ -472,6 +548,11 @@ static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>   
>   #else
>   
> +static bool nvme_tcp_is_ddp_offloaded(const struct nvme_tcp_request *req)
> +{
> +	return false;
> +}
> +
>   static struct net_device *
>   nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   {
> @@ -489,6 +570,14 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   {}
>   
> +static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +			       struct request *rq)
> +{}
> +
> +static void nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +				  struct request *rq)
> +{}
> +
>   static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>   				     struct sk_buff *skb, unsigned int offset)
>   {}
> @@ -764,6 +853,24 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>   }
>   
> +static void nvme_tcp_complete_request(struct request *rq,
> +				      __le16 status,
> +				      union nvme_result result,
> +				      __u16 command_id)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (nvme_tcp_is_ddp_offloaded(req)) {

Same optimization here:

if (IS_ENABLED(CONFIG_ULP_DDP) && nvme_tcp_is_ddp_offloaded(req)) {

> +		req->nvme_status = status;
> +		req->result = result;
> +		nvme_tcp_teardown_ddp(req->queue, rq);
> +		return;
> +	}
> +
> +	if (!nvme_try_complete_req(rq, status, result))
> +		nvme_complete_rq(rq);
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -783,10 +890,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
>   		req->status = cqe->status;
>   
> -	if (!nvme_try_complete_req(rq, req->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, req->status, cqe->result,
> +				  cqe->command_id);
>   	queue->nr_cqe++;
> -
>   	return 0;
>   }
>   
> @@ -984,10 +1090,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
> +				  pdu->command_id);
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -2727,6 +2836,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   	if (ret)
>   		return ret;
>   
> +#ifdef CONFIG_ULP_DDP
> +	req->offloaded = false;
> +#endif
>   	req->state = NVME_TCP_SEND_CMD_PDU;
>   	req->status = cpu_to_le16(NVME_SC_SUCCESS);
>   	req->offset = 0;
> @@ -2765,6 +2877,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   		return ret;
>   	}
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))

and here

if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP, 
&queue->flags))

> +		nvme_tcp_setup_ddp(queue, rq);
> +
>   	return 0;
>   }
>   

