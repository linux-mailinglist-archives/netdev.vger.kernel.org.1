Return-Path: <netdev+bounces-31443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A0D78DE29
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD272810AC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE2748C;
	Wed, 30 Aug 2023 19:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC892748A
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 19:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C01EC433C8;
	Wed, 30 Aug 2023 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693422016;
	bh=RhveYD8GB4CjpWQhZEEf/e2wVUoL3MIkonHeDuiSs/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IdbF51xJnE6w7wc+XwG8oThFdCSFfxzEUBhJDt36EXQytXozFgPkweAsHS/llDZKm
	 0GXJ1O5x9lCR8vKTtttqSCWlu9jsl2k1/NoQcKsu++fbvmSOnChbJcCapDmPTj/ZXd
	 g1ENagMNOxwayHgM2H4kCemr1Jzg4R2KzBbNocrjYvUpJB6gwZkQTk2bp14DFIS9VT
	 PeHTCmg0GwDR3t596lsutWu6Y2mJnm1xIlN5Svj4i+UqgYGZxmfqwitr7wFzE0cAtY
	 4JvJaIWpdSXeuJvBKlrzDAlFzi2GmaMAgqBK0C+fxeYA2Ozlj4+nUHKzTMISPoXJ/P
	 0YgrCsPpSQ5IQ==
Message-ID: <8b1f0e8d-fb9c-538c-d680-b127463daf6a@kernel.org>
Date: Wed, 30 Aug 2023 13:00:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH iproute2-next 1/1] tc: fix typo in netem's usage string
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>, francois.michel@uclouvain.be
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
 <20230830150531.44641-2-francois.michel@uclouvain.be>
 <87ledssftn.fsf@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87ledssftn.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/23 9:32 AM, Petr Machata wrote:
> ... and sorry for piling on like this, but since we are in the domain of
> fixing netem typos, if you would also fix the missing brackets on these
> two lines, that would be awesome.

yes, please and a separate patch.

