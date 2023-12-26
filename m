Return-Path: <netdev+bounces-60296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34481E77B
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 13:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11801F21D4E
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3684EB24;
	Tue, 26 Dec 2023 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgU2RWsM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F44E60B
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSV/qBLNJQEKhXs09AgS8KPu9B41vya1t28NoSZ8H/mfrvdWdcoJSMhl/JvHI1ZBxGgf3JCrqK7fp6z2GtZlneXWPf2u1LE7AHlVrUlvs9eFaxhteE8u6/jicnRvj/k0dftDHVtUZEhk7SxiIU70E82K0vsMSO1h5y2HgfF6WagEVQZqnGzvavPexZCjomCT/8ZpyqpJ349vmjPEM2Gn7jj9pS+LPV0D2UCnnTMEtO89PrxLGJxnsG9vohEdI8EXJ0TLVJ9YjVKhdQADBEIyNpdGz7TfZosDIt82djlrIRLXchflncuzflb3KShs+Iz3vmubtSe8CTA5jMBRdBI+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IOAhfc9Iht6vG4YsCEHQZeJo3Rscdz+sfku0yfaaf8=;
 b=dPaz74SucYXqqItHp6bRajol+GKaFH7e/+/+Eb1UxYh6RhxWU+SBWMqgXfSdymvDYvDQ6ytMPEVB9KJ3+TrC/sxqZyoi1AnvcXNNI30J6Vbt0xeemUGHYPUJIwYRvua/IvmwyRNS1fvFGawafa1J9cSDQABjif3KRim5DCQJrG69612dUF/dSREsIKUJQt6BpTZQAhpG63QUbZGNjwIdNlVBb1zUBhirAUzvLjq8NfnaiNTw+pM7BDOUANLE2VCkm7wTW3GGULLajwv0pH09ZsKe6LTMjm7vFxSYDz+qjMUmmeDVQZF39jEQvRpZDh8GSLbd+o9vGHTmUpnLXx2vzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IOAhfc9Iht6vG4YsCEHQZeJo3Rscdz+sfku0yfaaf8=;
 b=AgU2RWsMT5+jj4YasBuPTrg6EuGROGTibMcvZel/tcU0IEAHcfihK74XhTNczq/oq7pWkSCujSKipmQma05cV9owfwhNmLcKIyb4qd9lOLbGNmJGCbu24eFjO11vVE+stLYaZDtmFt0R4p/iQpP32GLa+H2RkNSstIJ2q455jpjfXbX5nKENcQrq3snWMbVdvt2zIEVtE2QN9c6JLmB+TCRd9JaxfBangrMC9rJNVToG3R5aPcIH9AMeobjdU8Ste2uQDrDogv89o0WAnVm6Lo+3JW8wdHNgvo5T2rf2da0jvNRTYqlSnUiHiyFM9X7MwQpT5Vgu56K7GmBLDR5RBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 12:58:34 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.026; Tue, 26 Dec 2023
 12:58:34 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 16/20] net/mlx5e: NVMEoTCP, queue init/teardown
In-Reply-To: <20231223174845.GJ201037@kernel.org>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-17-aaptel@nvidia.com>
 <20231223174845.GJ201037@kernel.org>
Date: Tue, 26 Dec 2023 14:58:30 +0200
Message-ID: <25334vpi0i1.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL0PR12MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: 82917bca-4df4-45d2-4109-08dc06125e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rDk69XpnLaxY9w8+VpDg5mGGVPiXhQENye2a9GfrfnSWgvm6JF5P6w5IachTMx+iqbWusZF2SZUhLM6lox3bL7Hi8b1/RpunR4C5p5rfZM/jz0l2ZmgI9o8VzUlw34yfH0LEJ9q4SmCR3DZoxLJFoICob6ILDwVrQaZUtNROxcrCM46ssHYbMoOyBCUPski8EmEP+1xgBef5eyneXE5Y+q48hWRuCcxX9PEyGc21mpkGD1RnFSlcF+zcvU94UcqOCvhTs1VLZpUDYVyKxzwWheLwioJoWcHB3pU17M6EgS79C+LLw0FvPJGbBOlRpAMvr6LzrD/FZUuc5BWz9ZVQxcw5cCfmB0kMGB5ITiq9nKDNs3YsmouCa4Zor3aeVcIFzPDJrj8ijUkupCfzhwqY4BT7o6SUiYWJAWqcLjhWYFuZckMtkzbyUe8JnzEWlddoMLsDo6PdIBg1WNqH/t//ADes5IXz6c27lHrynyyD00upmnAWDCJQCClt/KrefA4zaAmbdQcJ5/w3KPu8qSCn46ToiaVB6xMoMjbaPf1tV8Y4zYQUXL2GUnQ/jrIzALgH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(7416002)(2906002)(478600001)(26005)(2616005)(107886003)(38100700002)(6486002)(41300700001)(86362001)(558084003)(36756003)(316002)(66476007)(66556008)(66946007)(6916009)(6512007)(6506007)(6666004)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?soW01WwfiFgY3419lwLk3YslhWLzVLgGeyjQhySFA282scLNzFGDPHlktY6p?=
 =?us-ascii?Q?r4jnvVHUp/qiRAkEzArhm+UV/OYwKlYsNBZCSg0ifSaZ8dF0AYq/UC2MWRkR?=
 =?us-ascii?Q?e1d45WdrXVc/6xtYrQzVNdJJFCcobDewAC0PAdxbUQC/DZ/1J/50lUUvgmTC?=
 =?us-ascii?Q?pLAtkRUuFFcQa+SRhoSkZ0xr+ZhQlQwMStIXL715bBFjMHu6gmEqyJBI+s6S?=
 =?us-ascii?Q?na3OOUSjTr7tDyIDzdkCGG8PpHaRNNTv3wEKvxohvAmpXsiNm9YaJFYQoAha?=
 =?us-ascii?Q?Sjixkvuv5aBOW6cHimkqvSkYduEDfAk+QtUXZtZmLFRoD8OVYaL9u/M4GzlT?=
 =?us-ascii?Q?dvTWLSuTzzx/NHYtOz6LvD3oB+yrlohimrmIDRWE5QdaSbRTSqzi2q0ovCH5?=
 =?us-ascii?Q?tA5BVn1gXew7D3336spzky1aex3Q330W91JMMuO9aYPekkAlm4IZ2cJlB6uJ?=
 =?us-ascii?Q?pBn/3vuNHd62uJ10LvukMMMW1TyWS0JKOPmGQHa6M1BRVYTnr+ipv6snCjYe?=
 =?us-ascii?Q?nBHVwVwqr+bnJMqir3HVzVHJT/5PUWTcNP09T+EStACapWUkCm8yXeQLmqeE?=
 =?us-ascii?Q?guVGaLKygDVOa4VIKdVdaa3M7669Q2MLABM8J6P3FE+uL0PyCue4wtj+61Ub?=
 =?us-ascii?Q?tIN+R0ckMFdNsjkqt7xoriS5I6qP+EXuBPxaYEzNEIsAOnXVao8xwCMhPSKj?=
 =?us-ascii?Q?nnszEP3PqZ3Dfroq709DnKw0FwPVKVkUVPBCq7H1CoOGwmS7xTiczfB8KAmH?=
 =?us-ascii?Q?gWJfoT8pppJvQUgMU5yrJ0tGTq07lnBQ+U7fXpUiBTD/MY1aXNC85+O4c28o?=
 =?us-ascii?Q?Jl+qOFInW1j8Re4HQe2X7+gn5u7QFSxm40VHyY8khOy0WxoPv0PLPWriA4WA?=
 =?us-ascii?Q?3alhBbBhSZIW9I5gkICfCOT5CVkgGQwHdijNpFDGHtHTwAnhwR/hTGDnQENK?=
 =?us-ascii?Q?9a3I0G3AReCgxcLfhvXVd4b6B0Tg5jc5jnbM4HoXgXfR9cKvQu+54umayi3q?=
 =?us-ascii?Q?i/vnSPZtgrEnHTwTvBQ4iIARevX3GypFEgnTMkCG4UpcmgFeHK+oe4zsxfaf?=
 =?us-ascii?Q?wkfDdTumgR3lCdTM6g4SghEkn5n661ZdOvEsACnlA+HguMsc8FrMSbZckXXW?=
 =?us-ascii?Q?ptkuW1KY73agNzCEBaLnMX7ti8zL+uU8jaU8YvThCJTpE0bags1wlCHO1BwT?=
 =?us-ascii?Q?pwdeXl58H/E3zqB/ECfENC60ObhXxw520wWdY+NM95mZcgi+J/0UWOEpOA1C?=
 =?us-ascii?Q?dzK5TK5H3UJNIUN+N3PWmRkX8uKiqM+rthyKWXJYSk2hmgVHOYMIMlAH1tsb?=
 =?us-ascii?Q?GUWFwlK0vjp3rIVCct6bo6RYrYxMy5huBAPJ4srcRj0Ynldm6aKelkXC51PO?=
 =?us-ascii?Q?cxdQOAb9SewDszGLliLJ2cV+Skf0Kk39ydKP+W2IbOIhgTjsK6gdGiKR0LFp?=
 =?us-ascii?Q?9YlLXscYmIrOpQ3yg51kwQhMOwkZFMdjEpyS5VSeJo281qH5rt6OkvVLQO9o?=
 =?us-ascii?Q?3jcbVvRQ6oWnplN7UQtb9qjD8E4cWkJ4LUWpItogJzIUNKPMG+XHmp3v4SWJ?=
 =?us-ascii?Q?BhmdY4yl100qXPlqYBMsTuOp63usQb82DOAyFpih?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82917bca-4df4-45d2-4109-08dc06125e61
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 12:58:34.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv5phfsvyK133NsHwe1XQIa8MuN+/s9WiWsaaVcofMuaS5R3G9yXbjcm985gY4eo3dJSk3E4dChTL08harrAJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850

Hi Simon,

Simon Horman <horms@kernel.org> writes:
> This doesn't seem to compile with gcc-13 with allmodconfig on x86_64:

The latest pull of mlx5 changes in netdev broke our patches. We will
rebase and resubmit in the next merge window.

Thanks

