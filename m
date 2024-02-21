Return-Path: <netdev+bounces-73631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99485D665
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367E01F234D9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEC3C493;
	Wed, 21 Feb 2024 11:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A73F9FC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513388; cv=none; b=s1IqBCy1Xi55MLnO4BKfIF5F4jVLn9V9yeEIRIeirXGtNMkyP9YQ7dn4AJipYpxldlQHKC654tGCmh3UKFFRUtJgE3Cr+M5gaWxQgCovMf6B7FAM6a/Syjf6xXy5JKvBvE5bg8IO6ZqBknBU/H4Wvp7sch8ivDk/KksqBvFdz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513388; c=relaxed/simple;
	bh=hzKpJNmqdYB6rJp/PVbzorPoAgTGtcePE9lYF2JzCfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzoZmV/NMj1oWArqTBKL2uc2Twbep0zJvrKNII6m3zknL0BKw10IB75v2bLaYo3v63sjCUciNbNwMo8EhIsjdnF0qjdXfFMiKSR7n7Ck5dgxO1tc9Prp0ngTp9KP9GGzDqoyJc2J5E71qJNHDStiY18TI+kFmhWUnBjGIIJiMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5CC8D61E5FE01;
	Wed, 21 Feb 2024 12:02:08 +0100 (CET)
Message-ID: <ed0d4411-e120-4366-8640-145e6f66684d@molgen.mpg.de>
Date: Wed, 21 Feb 2024 12:02:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: simplify pci ops
 declaration
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Alan Brady <alan.brady@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
 <20240210220109.3179408-2-jesse.brandeburg@intel.com>
 <20240219091542.GS40273@kernel.org>
 <823fdfe2-7c8c-4440-bc6a-3896c542f0e4@intel.com>
 <20240221103525.GC352018@kernel.org>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240221103525.GC352018@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jesse, dear Simon,


Am 21.02.24 um 11:35 schrieb Simon Horman:
> On Tue, Feb 20, 2024 at 08:48:28AM -0800, Jesse Brandeburg wrote:
>> On 2/19/2024 1:15 AM, Simon Horman wrote:
>>> On Sat, Feb 10, 2024 at 02:01:08PM -0800, Jesse Brandeburg wrote:
>>>> The igb driver was pre-declaring tons of functions just so that it could
>>>> have an early declaration of the pci_driver struct.
>>>>
>>>> Delete a bunch of the declarations and move the struct to the bottom of the
>>>> file, after all the functions are declared.
>>>>
>>>> Reviewed-by: Alan Brady <alan.brady@intel.com>
>>>> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>>>> -	.probe    = igb_probe,
>>>> -	.remove   = igb_remove,
>>>> -#ifdef CONFIG_PM
>>>> -	.driver.pm = &igb_pm_ops,
>>>> -#endif
>>>> -	.shutdown = igb_shutdown,
>>
>>
>>>> +	.probe    = igb_probe,
>>>> +	.remove   = igb_remove,
>>>> +	.driver.pm = &igb_pm_ops,

>>> the line above causes a build failure if CONFIG_PM is not set.

>> Yeah I missed that, but do we care since patch 2/2 then fixes it?
> 
> Right. TBH I wrote the above before noticing 2/2.
> And I guess it is not a big deal either way.

In my opinion, to ease bisecting, each commit should build, so if a 
build failure can be avoided, it’d be great if you could fix this before 
committing.


Kind regards,

Paul

