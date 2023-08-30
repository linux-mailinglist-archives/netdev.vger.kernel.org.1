Return-Path: <netdev+bounces-31419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E231478D6C6
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5001C208BC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4316FA4;
	Wed, 30 Aug 2023 15:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D65397
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC4C433C9;
	Wed, 30 Aug 2023 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693407675;
	bh=zo90yza714kYCLXkBZoQ5PaxTE4B0CIm2YnHLkmZ1fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H2tIcdCGN2FlKjojR5IPLI5KY7UUPwpckp25nLmdr54n5Yiev+4Rs+dvAk9xCgChC
	 fmSNzPK9U6yH0eou9OTgqbU4YtqH6fVtc31RZGQBmuXpWcdOzk4N5q9e1h7GzQJCMo
	 PbjiRI4TpW9OUimYnz+iWMcM9s9cfkr7/wLo+ntUEHlT0jkMeQPYuZrey1Np9fIpXc
	 7f/MnyHvIFR8QWsWRYREUnJgg5C/9mQbqquc009AbJk6RSLvCTrGqECbgF2HekzCbM
	 7IDUG1fJR2bNsnzj6kXtdUm/4yafvvvPPi6BGlWtST1H418FeYtaDlx3gZUId0RFh5
	 F0kw/n1ZC13iQ==
Message-ID: <fd984268-efd7-e10e-8d0d-13de73c0b212@kernel.org>
Date: Wed, 30 Aug 2023 09:01:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 iproute2-next 1/2] tc: support the netem seed parameter
 for loss and corruption events
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>,
 =?UTF-8?Q?Fran=c3=a7ois_Michel?= <francois.michel@uclouvain.be>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
 <20230823100128.54451-2-francois.michel@uclouvain.be>
 <87y1hurv2f.fsf@nvidia.com>
 <172898f6-56a7-6ce3-212c-a468f4ad6262@uclouvain.be>
 <87pm34slyw.fsf@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87pm34slyw.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/30/23 7:22 AM, Petr Machata wrote:
> 
> François Michel <francois.michel@uclouvain.be> writes:
> 
>> Hi,
>>
>> Le 29/08/23 à 12:07, Petr Machata a écrit :
>>> Took me a while to fight my way through all the unreads to this, and
>>> it's already merged, but...
>>> francois.michel@uclouvain.be writes:
>>>
>>>> diff --git a/tc/q_netem.c b/tc/q_netem.c
>>>> index 8ace2b61..febddd49 100644
>>>> --- a/tc/q_netem.c
>>>> +++ b/tc/q_netem.c
>>>> @@ -31,6 +31,7 @@ static void explain(void)
>>>>   		"                 [ loss random PERCENT [CORRELATION]]\n"
>>>>   		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>>>>   		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
>>>> +		"                 [ seed SEED \n]"
>>> The newline seems misplaced.
>>
>> Sorry for that, I don't know how I could have missed that.
>> Should I send a patch to fix this ?
> 
> That would be the way to get it fixed, yes.
> 

yes, please send a patch. thanks catching it, Petr.

