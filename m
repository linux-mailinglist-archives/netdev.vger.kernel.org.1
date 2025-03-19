Return-Path: <netdev+bounces-176234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B2A696CF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6FA19C6803
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB76207E0E;
	Wed, 19 Mar 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw+JJ9PD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6431205E16
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406349; cv=none; b=t5VwXeHc/TifW2o5uxe/aJ9ANtD8JyhTHCkrQ950PtSmK0EkC8k2VlKMUOU1zpwU7xXP0lv2VOz5gpZ6WSKg2sSsgBONQVGqEFHaaxbPINClHGsqXd+NUx4jOxJvM4XUm7fLI0kq8zU9xJQ5HVDZLHjLReuc3xnROvfiPxYz9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406349; c=relaxed/simple;
	bh=Q6agDqs+NIrqn+WH4YgDDiq2PIZZ7JYuMC3j0ZkYR6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb28kKZ6WufAR1aDFA35lEU+taVgz6hZeJIsbjjni2oQS3cNJfNNsokBO/QrhkreMjBITMMk0HGKNJQ5KqZOpgx7hD8fwnL9sAaQ3ZRn7gTvCM9qohddAfXJ+LdLk+tdLi/9LkkX5z4dsiwBy+qwmBa4MMz5kFFZtwZZOZlvdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw+JJ9PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2310EC4CEE4;
	Wed, 19 Mar 2025 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742406349;
	bh=Q6agDqs+NIrqn+WH4YgDDiq2PIZZ7JYuMC3j0ZkYR6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dw+JJ9PDkfJgOScqGTNb/vHa0DoWB940nJQ6jtuoBYwmiBz0eYj984SsyQ8LjFy38
	 WE0EHNEL6FGGKQDRWNcOiSoVX6NEuX9AwjYSVC+GNhYZjvJJVIykAS0VoeaDjFTQ1M
	 TROsMmLmWxzlQb9OJVcycHLAjwQsDkUxQO3jTGrUF5x35FmnRoF3WC85k+RftR//ee
	 VDragzVwNKQg49j9VZwI+MThi6zqRwniDmjIPGmTWk6u8/kZU36qBHkYTQ8WljS9qk
	 ttpYvcjF3HuWJwABquOxxl8vWDwRMBz7YF+6mSOhj8Ch+uJ7OwljxIyxK1S367a/IB
	 +cjQackuaxBBw==
Message-ID: <8644149c-bce7-4e62-9107-d04fe6aceb97@kernel.org>
Date: Wed, 19 Mar 2025 11:45:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a maintainer
 of SRv6
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20250312092212.46299-1-dsahern@kernel.org>
 <a9c961ab-a90c-46ee-b2e7-0f160ecae99e@redhat.com>
 <20250319184142.35ba847797499aaee8ffc148@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319184142.35ba847797499aaee8ffc148@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:41 AM, Andrea Mayer wrote:
> On Tue, 18 Mar 2025 15:58:17 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>>
>>
>> On 3/12/25 10:22 AM, David Ahern wrote:
>>> Andrea has made significant contributions to SRv6 support in Linux.
>>> Acknowledge the work and on-going interest in Srv6 support with a
>>> maintainers entry for these files so hopefully he is included
>>> on patches going forward.
>>>
>>> v2
>>> - add non-uapi header files
>>
>> FTR, the changelog should come after the '---' separator. Yep this is a
>> somewhat 'recent' process change WRT the past. No need to repost I can
>> fix it while applying the patch.
>>
>> @Andrea: we need your explicit ack here, as this is basically putting
>> some obligations on you ;)
>>
>> /P
>>
> 
> Hi,
> 
> It is a pleasure for me accept this role (just sent an Acked-by).
> Thank you all for considering the work I have done on SRv6 over the years.
> 
> I'm glad to continue working on this topic, to be included in future patches,
> and to contribute to the SRv6 subsystem as much as I can.
> 

Also, I think it is good to have an explicit listing for this files
given that seg6 code is at 5000 lines with 10 selftests at 7000 lines.
Having someone who knows the details be included on patch submissions is
needed.

