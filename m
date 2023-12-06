Return-Path: <netdev+bounces-54343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050D806B28
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A496B20CE8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9A1DDF6;
	Wed,  6 Dec 2023 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWGuJ5Y2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD3C3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 01:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBEDBjlhjOJTZvE1fS1j8F26BrM1rGn4EK4mm5aH8qCCx2nofDFnihbIdn4cIVXxol30rbMhf7qpvNhOXgyAW4lZqyk2cZhptoWlfhDR6dftRAcb7u90NM0Etu27kXdWfkdP97CxhTSqO6Hp/XKW6wXV16vRJrBB7D+3UHmkteqPjar5Le5u6oXVZ7WA3zbfE0BcFwxuh/GhsCsWz11WTPNTcqDD8SGJnQ65IMVTNQk5XVUY+en5KOu4AIEMeWWUr7VUthUMMuKXQKqja1ogw/qPNaVk2ZqGTcXopxyplHLmCNPohE4Lh4QpM9j8CkUWil7FizYfk5Q/PpnXZn0I+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcbjO8V8lyeLU90SCNdxJ+ry+JqWvK0W+t/z+vphXBE=;
 b=YVtCNcKwUqXt+ycqcRs5mGbzl2VCpRKfHpQEKG7p4rplwW+x8GO2ogpAI7h8hoRqCLoBvLFwUQCHhD5ps5X+4/nzBVZarqq4vNoRH8EBYP3uTPtmB1IAmpDGTiFuD+f7KlG/0thHxOVRYpMKz+LcJq1EGrRVIX1OX/Qy7PTHqyXR8+VROu5UokzII1BPRjqM00Ynlr6hk/CKQIbxWFj49KKP8f47JyjSQo/aTv5tuOesP0CdrgBvVX8gSDaulIKJcz+T1qK5iOwC30zjgAzSZ00bBiSYDcw1uMQ4LILExo4EgxSHIo2wyLa6giy9JyyNMgckBJv/drvqUV9S3QQRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcbjO8V8lyeLU90SCNdxJ+ry+JqWvK0W+t/z+vphXBE=;
 b=XWGuJ5Y2ojSKi9OBHUFA7M/gn+GNW0lN/912sdQ37Abk/7bApvD8gXTDV5x4TLXfxVE3zH42OXzi+MC3Y7+cUWGEPh1N5cLhODvSOEfxGPcBmC7M0NJ7RSruh2afWvaTKjVX7+MSwYowINJN/eYF/1XKzRHZJfKvRB65aR7AYyz3JrpE0AIMSqQXes8ExvtKayk+Ui38zaIzt0TaN7rCY/USah1EBBbPnMhtY2X1p9FWqh1C7RyiqtlhnbVuMeAVMEZufU+tWsGHtlzfrzJ/XU2PfmUCkx2LKUT28MRWzxqTWMIL35v1Fh+1F1OY602yAY2WETSMJYLpLvchooCvHQ==
Received: from BL0PR0102CA0067.prod.exchangelabs.com (2603:10b6:208:25::44) by
 BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Wed, 6 Dec 2023 09:59:44 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::19) by BL0PR0102CA0067.outlook.office365.com
 (2603:10b6:208:25::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:59:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 01:59:27 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 01:59:23 -0800
References: <20231205153012.484687-1-pctammela@mojatatu.com>
 <20231205153012.484687-2-pctammela@mojatatu.com>
 <87jzpso53a.fsf@nvidia.com>
 <77b8d1d8-4ad9-49c7-9c42-612e9de29881@mojatatu.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Vlad Buslov <vladbu@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in
 tcf_idr_check_alloc
Date: Wed, 6 Dec 2023 11:52:45 +0200
In-Reply-To: <77b8d1d8-4ad9-49c7-9c42-612e9de29881@mojatatu.com>
Message-ID: <87fs0fodmu.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 01303fd4-097f-4264-947f-08dbf64212aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+wXDMk8mxOsuVKPJ2E/EaOT+MjhIs7/FanH0aIiqMR1APCB8W3VLtGG+zY10mDRlmdCTuR/59kNndfQr4WBNc8iOrrpqfeyrdyy6nr4MNrjAvLBSpRdELsMRaegb6WLh1hu/2BbCHQOm4SUUFlQHPBjklymbrSqJrAppB4rCpYhTbuZjZxvYu0TrZ0TL2kcvWprPVaLnUTPHhAhebDKYUEr2PJY5RHP+NyITvxi3DDFqLcfpP9xjMnGKPpT3kxXXnpeXs55izT3nCnIjVOKwglq7zrKrm6ZWMp9umf8woG60hG1Wm972RKWguD79FvTR+aTNOb22NpRhgYmurpflXfRWPAiwqW1tzNn8jKXxoBaGDAiIzxkcPUlDcmyApQii3HsgYkIeG9S50n60ZUZaOEGJxhSFGIuoQooOB1qqv11F46ZvYDzW+YpwsZAUnr6aTJ1mWjXeVu+ixk0YUqg7BdmIIgwQ+iDYtv6ROJo33KmSIVMdMDI1g19RSKmzJ1Kn5qcwFuuWF+kdXFQi6zvabPON/L//89747anFWqBoQXNgr98XzV0bM9vTNY0nDQpRpeXimZw6b4SgdtkbF3FKgOWU2dKB1Wc5n5jjJup4lWjuaRncoohMSbxOLC5y3Knfw20dKupvJEpgBAMqQIo49VgEGBVGWD5cURy6fLtfz8cLQgoZKtzLGQVeNT8iTnqpfyi6omm0Fh2IazDFu9flPtmP5ostA3nD2vkKDvpnQlUNWg6BiU2qw4S2oxZC6MAr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(4326008)(86362001)(316002)(8676002)(8936002)(6916009)(70206006)(478600001)(70586007)(41300700001)(36756003)(2906002)(5660300002)(7416002)(36860700001)(356005)(7636003)(47076005)(2616005)(26005)(6666004)(7696005)(53546011)(82740400003)(16526019)(83380400001)(426003)(336012)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:59:44.2625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01303fd4-097f-4264-947f-08dbf64212aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144

On Tue 05 Dec 2023 at 17:19, Pedro Tammela <pctammela@mojatatu.com> wrote:
> On 05/12/2023 15:34, Vlad Buslov wrote:
>> On Tue 05 Dec 2023 at 12:30, Pedro Tammela <pctammela@mojatatu.com> wrote:
>>> Instead of relying only on the idrinfo->lock mutex for
>>> bind/alloc logic, rely on a combination of rcu + mutex + atomics
>>> to better scale the case where multiple rtnl-less filters are
>>> binding to the same action object.
>>>
>>> Action binding happens when an action index is specified explicitly and
>>> an action exists which such index exists. Example:
>> Nit: the first sentence looks mangled, extra 'exists' word and probably
>> 'which' should be 'with'.
>> 
>>>    tc actions add action drop index 1
>>>    tc filter add ... matchall action drop index 1
>>>    tc filter add ... matchall action drop index 1
>>>    tc filter add ... matchall action drop index 1
>>>    tc filter ls ...
>>>       filter protocol all pref 49150 matchall chain 0 filter protocol all pref 49150 matchall chain 0 handle 0x1
>>>       not_in_hw
>>>             action order 1: gact action drop
>>>              random type none pass val 0
>>>              index 1 ref 4 bind 3
>>>
>>>     filter protocol all pref 49151 matchall chain 0 filter protocol all pref 49151 matchall chain 0 handle 0x1
>>>       not_in_hw
>>>             action order 1: gact action drop
>>>              random type none pass val 0
>>>              index 1 ref 4 bind 3
>>>
>>>     filter protocol all pref 49152 matchall chain 0 filter protocol all pref 49152 matchall chain 0 handle 0x1
>>>       not_in_hw
>>>             action order 1: gact action drop
>>>              random type none pass val 0
>>>              index 1 ref 4 bind 3
>>>
>>> When no index is specified, as before, grab the mutex and allocate
>>> in the idr the next available id. In this version, as opposed to before,
>>> it's simplified to store the -EBUSY pointer instead of the previous
>>> alloc + replace combination.
>>>
>>> When an index is specified, rely on rcu to find if there's an object in
>>> such index. If there's none, fallback to the above, serializing on the
>>> mutex and reserving the specified id. If there's one, it can be an -EBUSY
>>> pointer, in which case we just try again until it's an action, or an action.
>>> Given the rcu guarantees, the action found could be dead and therefore
>>> we need to bump the refcount if it's not 0, handling the case it's
>>> in fact 0.
>>>
>>> As bind and the action refcount are already atomics, these increments can
>>> happen without the mutex protection while many tcf_idr_check_alloc race
>>> to bind to the same action instance.
>>>
>>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>>> ---
>>>   net/sched/act_api.c | 56 +++++++++++++++++++++++++++------------------
>>>   1 file changed, 34 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>>> index abec5c45b5a4..79a044d2ae02 100644
>>> --- a/net/sched/act_api.c
>>> +++ b/net/sched/act_api.c
>>> @@ -824,43 +824,55 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>>>   	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>>>   	struct tc_action *p;
>>>   	int ret;
>>> +	u32 max;
>>>   -again:
>>> -	mutex_lock(&idrinfo->lock);
>>>   	if (*index) {
>>> +again:
>>> +		rcu_read_lock();
>>>   		p = idr_find(&idrinfo->action_idr, *index);
>>> +
>>>   		if (IS_ERR(p)) {
>>>   			/* This means that another process allocated
>>>   			 * index but did not assign the pointer yet.
>>>   			 */
>>> -			mutex_unlock(&idrinfo->lock);
>>> +			rcu_read_unlock();
>>>   			goto again;
>>>   		}
>>>   -		if (p) {
>>> -			refcount_inc(&p->tcfa_refcnt);
>>> -			if (bind)
>>> -				atomic_inc(&p->tcfa_bindcnt);
>>> -			*a = p;
>>> -			ret = 1;
>>> -		} else {
>>> -			*a = NULL;
>>> -			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
>>> -					    *index, GFP_KERNEL);
>>> -			if (!ret)
>>> -				idr_replace(&idrinfo->action_idr,
>>> -					    ERR_PTR(-EBUSY), *index);
>>> +		if (!p) {
>>> +			/* Empty slot, try to allocate it */
>>> +			max = *index;
>>> +			rcu_read_unlock();
>>> +			goto new;
>>> +		}
>>> +
>>> +		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
>>> +			/* Action was deleted in parallel */
>>> +			rcu_read_unlock();
>>> +			return -ENOENT;
>> Current version doesn't return ENOENT since it is synchronous. You are
>> now introducing basically a change to UAPI since users of this function
>> (individual actions) are not prepared to retry on ENOENT and will
>> propagate the error up the call chain. I guess you need to try to create
>> a new action with specified index instead.
>
> I see.
> So you are saying that in the case where action foo is deleted and a binding in
> parallel observes the deleted action, it should fallback into trying to allocate
> the index.

Correct.

>
> We could goto again and hope that idr_find will observe the idr index being
> freed, in which case it would fall back into action allocation if it does or
> simply go via the same path as before (jumping to 'again').
>
> I don't see much problems here, it seems to converge in this scenario
> as it eventually transforms into race for action allocation (more below) if you
> have an unfortunate delete with many bindings in flight.
>
>> 
>>>   		}
>>> +
>>> +		if (bind)
>>> +			atomic_inc(&p->tcfa_bindcnt);
>>> +		*a = p;
>>> +
>>> +		rcu_read_unlock();
>>> +
>>> +		return 1;
>>>   	} else {
>>> +		/* Find a slot */
>>>   		*index = 1;
>>> -		*a = NULL;
>>> -		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
>>> -				    UINT_MAX, GFP_KERNEL);
>>> -		if (!ret)
>>> -			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
>>> -				    *index);
>>> +		max = UINT_MAX;
>>>   	}
>>> +
>>> +new:
>>> +	*a = NULL;
>>> +
>>> +	mutex_lock(&idrinfo->lock);
>>> +	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
>>> +			    GFP_KERNEL);
>> What if multiple concurrent tasks didn't find the action by index with
>> rcu and get here, synchronizing on the idrinfo->lock? It looks like
>> after the one who got the lock first successfully allocates the index
>> everyone else will fail (also propagating ENOSPACE to the user). 
>
> Correct
>
>> I guess you need some mechanism to account for such case and retry.
>
> Ok, so if I'm binding and it's observed a free index, which means "try to
> allocate" and I get a ENOSPC after jumping to new, try again but this time
> binding into the allocated action.
>
> In this scenario when we come back to 'again' we will wait until -EBUSY is
> replaced with the real pointer. Seems like a big enough window that any race for
> allocating from binding would most probably end up in this contention loop.
>
> However I think when we have these two retry mechanisms there's a extremely
> small window for an infinite loop if an action delete is timed just right, in
> between the action pointer is found and when we grab the tcfa_refcnt.
>
> 	idr_find (pointer)
> 	tcfa_refcnt (0)  <-------|
> 	again:                   |
> 	idr_find (free index!)   |
> 	new:                     |
> 	idr_alloc_u32 (ENOSPC)   |
> 	again:                   |
> 	idr_find (EBUSY)         |
> 	again:                   |
> 	idr_find (pointer)       |
> 	<evil delete happens>    |
> 	------->>>>--------------|

I'm not sure I'm following. Why would this sequence cause infinite loop?

>
> Another potential problem, is that this will race with non binding actions. So
> if the ENOSPC was actually from another unrelated action. A practical example
> would be a race between a binding to an 'action drop index 1' and an 'action ok'
> allocation. Actually it's a general problem and not particular to this case here
> but it seems like we could be amplifying it.
>
> I'm conflicted here. If I were to choose one of the two, I would pick the action
> respawing as to me it seems to converge much quicker and removes the uapi change
> (my bad! :).
>
> As for usability, if all of a sudden there's a huge influx of ENOSPC errors
> because users are abusing 'tc filter add ... action index 1 ...' in parallel
> _before_ actually creating the action object the fix is to just:
> tc actions add action index 1 ...
> tc filter add ...
>
> As tc has always supported


