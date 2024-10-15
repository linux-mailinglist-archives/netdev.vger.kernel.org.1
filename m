Return-Path: <netdev+bounces-135716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4199F01E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78B228121E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5321C4A0C;
	Tue, 15 Oct 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VaG53/dM"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68541FC7EC
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003853; cv=none; b=bIF/MZlq54PDHP06HTy1hq3WhjxSb1dQXj/978ES+6ojAL2JgkG0FuYIzi10rEGd95idpRclnF4wgZmj/3+LdqQdP1S0gIwviZOuEHFa/svGOjOegNJGgYysA70nlg2+WAvlKoHd7qXqaGOpaUoaMHxC+fc6pNkY5PQh+rMX+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003853; c=relaxed/simple;
	bh=b6F6HTbAK3k27jEF5hs4VdapSaS6BeVeKSt7AY8Mb2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kelW3uAGlS22yyAcbWXwkADxl5vkOcCmpFSIDl9amqx8GiRNDsPBQhhjWSjrdjgjuB13KDkFtAvtAOJRyZJgYVFAfXUlu8TP7OvMBqiG+eDKku3e3P80Xe8zhJOwpYVpfhYKgWaTbC8wnHDiAuj6ncp56QM9GomIUpoPCMCGacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VaG53/dM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ec44c11-8387-4c38-97f4-a1fbcb5e1a4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729003848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFvlDlqDsNKF7C/Lz/vpUsIFwUvMLwmRA1uoFF8DY7E=;
	b=VaG53/dMPxQl7ShsOD54bS8aa/2XZtteNE9GWBuypF3UuLtBvU2Dom6E1uTn1UaMLF7339
	HPh6YBSlTjFraNEESeWRQDHIBxe7KPUEY/MCJH33HJ3jmMngZP2IBaweKPWV7jJ9wstAT7
	jUoDanXjLj84U0Ojrf20lksTLCqggwY=
Date: Tue, 15 Oct 2024 15:50:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-2-jiri@resnulli.us>
 <20241015072638.764fb0da@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241015072638.764fb0da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2024 15:26, Jakub Kicinski wrote:
> On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
>> +    type: enum
>> +    name: clock-quality-level
>> +    doc: |
>> +      level of quality of a clock device. This mainly applies when
>> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
>> +      The current list is defined according to the table 11-7 contained
>> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
>> +      by other ITU-T defined clock qualities, or different ones defined
>> +      by another standardization body (for those, please use
>> +      different prefix).
> 
> uAPI extensibility aside - doesn't this belong to clock info?
> I'm slightly worried we're stuffing this attr into DPLL because
> we have netlink for DPLL but no good way to extend clock info.

There is a work going on by Maciek Machnikowski about extending clock
info. But the progress is kinda slow..

>> +    entries:
>> +      -
>> +        name: itu-opt1-prc
>> +        value: 1
>> +      -
>> +        name: itu-opt1-ssu-a
>> +      -
>> +        name: itu-opt1-ssu-b
>> +      -
>> +        name: itu-opt1-eec1
>> +      -
>> +        name: itu-opt1-prtc
>> +      -
>> +        name: itu-opt1-eprtc
>> +      -
>> +        name: itu-opt1-eeec
>> +      -
>> +        name: itu-opt1-eprc
>> +    render-max: true
> 
> Why render max? Just to align with other unnecessary max defines in
> the file?


