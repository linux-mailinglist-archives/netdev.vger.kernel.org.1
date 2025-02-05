Return-Path: <netdev+bounces-162955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B620BA28A23
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CD3A932A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271422C328;
	Wed,  5 Feb 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXISmh1d"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916A22B8B7
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758018; cv=none; b=X+F63AvC+FYxp7E1CbeUJVaReG+jzQZo9LswJcnZblefV2swKBAnRYUl3nQq4HMzhw2ss4aMmdrpmjAWdXi2LVGg51gOcDCxtfqCsSNwUVXr0HtwXvS5wLReacqlPWtEgtdFx+E4mqE3ipfND0GoJdXo9W0c4RMb2qiXCyPgn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758018; c=relaxed/simple;
	bh=fIKA0KUi1WjPw8cIAAOXDtHY572tq11kBzia1j+0wyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ9KYwYO/+/s05M2zAv/jqP05WdJ7E06ltD82DHK9y8KVYn5aQ19+fzC7OgIlK/f5n9EqVcigL5J+v0m5bwwSuu8tPJkodJHC3WMxYk9jyG6X02MYqDC+wXuazY30AlOe54tjqLr9pez7FkDq5OS3qYMEZPQlj01MaPnW7+aR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HXISmh1d; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c417b93-773b-432b-89f6-fe380ca4878f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738758007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFm7L7L3Q+cgtCouxQpWzWBv58lxiZS6iU7cHNopeFs=;
	b=HXISmh1dCqsj9sbh8ny127fyT4MUYQkdDucyPj3jOdc17zYnBrOV/8c7NCNvEcV8D4hTmu
	9pQsFTUJ5ZuxtG94kNv8zsgnVvQscgSxHb+Ba5TgsXHLAhp33IDWJIIWLr4sUgLMmyrV/S
	z4OpwaAorhLZKIl16EimtOpqFCJ2ajQ=
Date: Wed, 5 Feb 2025 12:20:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
To: Danielle Ratson <danieller@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 Amit Cohen <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183427.1b261882@kernel.org>
 <2ca4e13a-c260-40dc-b403-5cc73e664e02@linux.dev>
 <DM6PR12MB451696EDF6DF09074926E8F3D8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM6PR12MB451696EDF6DF09074926E8F3D8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05/02/2025 12:13, Danielle Ratson wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Sent: Wednesday, 5 February 2025 12:48
>> To: Jakub Kicinski <kuba@kernel.org>; Danielle Ratson <danieller@nvidia.com>
>> Cc: netdev@vger.kernel.org; mkubecek@suse.cz; matt@traverse.com.au;
>> daniel.zahka@gmail.com; Amit Cohen <amcohen@nvidia.com>; NBU-mlxsw
>> <nbu-mlxsw@exchange.nvidia.com>
>> Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling
>> to --module-info in SFF8636 modules
>>
>> On 05/02/2025 02:34, Jakub Kicinski wrote:
>>> On Tue, 4 Feb 2025 15:39:51 +0200 Danielle Ratson wrote:
>>>> +#define YESNO(x) (((x) != 0) ? "Yes" : "No") #define ONOFF(x) (((x)
>>>> +!= 0) ? "On" : "Off")
>>>
>>> Are these needed ? It appears we have them defined twice after this
>>> series:
>>>
>>> $ git grep 'define YES'
>>> cmis.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")
>>> module-common.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")
>>
>> Are we strict on capital first letter here? If not then maybe try to use
>> str_yes_no() and remove this definition completely?
> 
> I only moved it to a different file, I didn’t find a reason to change it right now.
> I can add a separate patch to change all the YESNO and ONOFF uses, and remove those definitions, do you want me to do that?
> To be honest, I don’t know if there is a justification to do it in that patchset, considering it is a pretty long anyway.

Well, I do really know that pure refactoring to str_yes_no() and
str_on_off() are not appreciated in netdev. I thought that we may
combine these changes, but no strong feeling. We may keep it as is.

