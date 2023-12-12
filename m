Return-Path: <netdev+bounces-56356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4F80E96F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A9B1F21517
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD35C904;
	Tue, 12 Dec 2023 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIRJzqaI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5CD5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702377943; x=1733913943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HXd03fEJqfvTiVmmxtoxQAHRCUpDA2Lseuz0XldyLdk=;
  b=aIRJzqaIQDGADvV7j/LvCOTQ4d266+d+yz2Kv6u20HrCYFn5nAvpb3H2
   rpbDjXs5jrcH5qzmbJfE8Strn1XJmzmK1lVRuxHHG5i9ZKQN9QRjWVx4k
   kxoqP5Hfro3oIEySixMktRPuQWMld+c080Wh34iF5EEcU+Js4YPrjR67x
   FWyirzRtMRbWaOuObW3aVxf1jhJLY1SlI/wp0SekAc3dJoH6wn++6oKR7
   N64ru8am+najS+IMdjMGVbfRiXCioYboMZ719n5tu3Lutq/h5qy610M7t
   1qKEszioMk+3K8KH7quKKFilR/Nwbh+BB8rH7QxVB+cfPF+hlCGh6feJy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="398631031"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="398631031"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766778116"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="766778116"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.160]) ([10.237.140.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:45:39 -0800
Message-ID: <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
Date: Tue, 12 Dec 2023 11:45:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
Content-Language: en-US
To: kuba@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: andy@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 idosch@nvidia.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 simon.horman@corigine.com, jiri@resnulli.us, pabeni@redhat.com,
 davem@davemloft.net
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11.12.2023 22:23, Tony Nguyen wrote:
> 
> 
> On 12/11/2023 4:38 AM, Alexander Lobakin wrote:
>> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Date: Fri, 8 Dec 2023 13:34:10 -0800
>>
>>>
>>>
>>> On 12/7/2023 8:49 AM, Marcin Szycik wrote:
>>>> Add support for creating PFCP filters in switchdev mode. Add pfcp module
>>>> that allows to create a PFCP-type netdev. The netdev then can be
>>>> passed to
>>>> tc when creating a filter to indicate that PFCP filter should be created.
>>>>
>>>> To add a PFCP filter, a special netdev must be created and passed to tc
>>>> command:
>>>>
>>>>     ip link add pfcp0 type pfcp
>>>>     tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
>>>>       1:12ab/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
>>>>       dev pfcp0
>>>>
>>>> Changes in iproute2 [1] are required to use pfcp_opts in tc.
>>>>
>>>> ICE COMMS package is required as it contains PFCP profiles.
>>>>
>>>> Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
>>>> stored in a __be16. All possible values have already been used, making it
>>>> impossible to add new ones.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
>>>> ---
>>>> This patchset should be applied on top of the "boys" tree [2], as it
>>>> depends on recent bitmap changes.
>>>
>>> Is this for comment only (RFC)? This doesn't seem to apply to iwl-next
>>> and if this based on, and has dependencies from, another tree, I can't
>>> apply them here.
>>
>> It's not an RFC.
>> The series contains generic code changes and must go directly through
>> net-next. 
> 
> Should this be marked for 'net-next' rather than 'iwl-next' then?

My bad, sorry.
This series should go directly to net-next.

Thanks,
Marcin

> 
> Thanks,
> Tony
> 
>> The dependency on the bitmap tree was discussed with Jakub and
>> Yury and we agreed that the netdev guys will pull it before applying
>> this one.
>>
>> Thanks,
>> Olek
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

