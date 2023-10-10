Return-Path: <netdev+bounces-39618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5675F7C0234
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CC8281797
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480182FE38;
	Tue, 10 Oct 2023 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2QiKjmR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289032FE35
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6DEC433CA;
	Tue, 10 Oct 2023 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696957586;
	bh=1i6ExLplNYAM/G8lsKYitfhalJFntqMdBelAXa5244Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t2QiKjmRMeFIXc76/f/4STeK1I/eg8ArMKZuH1SXF53b7Urd/aNlj7G8X5ygJ+koB
	 5CppGaaQ082VK4z+VHCVeNvnzwF+xhIzFx7n6Y+v9LDcUBR6/DskHPhkLbrIhep7vD
	 FWhLX5bXSZvluwGkZGGnGc/4OvO4FL9jnoO1858dNgrbBRSJ9J3sETU5dPckHudb4m
	 dJbzEuvKTMn6xYJrjF7hAcZ1+XDcChXpJ7siddeyXfT1CL6FibcaBqcwbHV0H4jB2A
	 a4K+grljr3BrYuzJFsZYokosbf29vYvId0HfrvzZxO6OOs3r+sRJH8vu6M+Ya1nCb7
	 Wt4MgMSerujTQ==
Message-ID: <5dae1994-cc61-4c4e-bbb0-55511e2fc5dd@kernel.org>
Date: Tue, 10 Oct 2023 19:06:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: try to encourage (netdev?) reviewers
Content-Language: en-GB, fr-BE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 andrew@lunn.ch, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au, przemyslaw.kitszel@intel.com, f.fainelli@gmail.com,
 jiri@resnulli.us, ecree.xilinx@gmail.com
References: <20231009225637.3785359-1-kuba@kernel.org>
 <2403fd80-e32c-4e5b-a215-55c7bb88df8d@kernel.org>
 <CAMuHMdXXO3jHWkry6NNuvF_nQkvfb87b_Ca8E_so=1LWghrV9w@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <CAMuHMdXXO3jHWkry6NNuvF_nQkvfb87b_Ca8E_so=1LWghrV9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 10/10/2023 17:52, Geert Uytterhoeven wrote:
> Hi Matt,
> 
> On Tue, Oct 10, 2023 at 5:19 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>> On 10/10/2023 00:56, Jakub Kicinski wrote:
>>> Add a section to netdev maintainer doc encouraging reviewers
>>> to chime in on the mailing list.
>>>
>>> The questions about "when is it okay to share feedback"
>>> keep coming up (most recently at netconf) and the answer
>>> is "pretty much always".
>>>
>>> Extend the section of 7.AdvancedTopics.rst which deals
>>> with reviews a little bit to add stuff we had been recommending
>>> locally.
>>
>> Good idea to encourage everybody to review, even the less experimented
>> ones. That might push me to send more reviews, even when I don't know
>> well the area that is being modified, thanks! :)
>>
>> (...)
>>
>>> diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation/process/7.AdvancedTopics.rst
>>> index bf7cbfb4caa5..415749feed17 100644
>>> --- a/Documentation/process/7.AdvancedTopics.rst
>>> +++ b/Documentation/process/7.AdvancedTopics.rst
>>> @@ -146,6 +146,7 @@ pull.  The git request-pull command can be helpful in this regard; it will
>>>  format the request as other developers expect, and will also check to be
>>>  sure that you have remembered to push those changes to the public server.
>>>
>>> +.. _development_advancedtopics_reviews:
>>>
>>>  Reviewing patches
>>>  -----------------
>>> @@ -167,6 +168,12 @@ comments as questions rather than criticisms.  Asking "how does the lock
>>>  get released in this path?" will always work better than stating "the
>>>  locking here is wrong."
>>
>> The paragraph just above ("it is OK to question the code") is very nice!
>> When I'm cced on some patches modifying some code I'm not familiar with
>> and there are some parts that look "strange" to me, I sometimes feel
>> like I only have two possibilities: either I spend quite some time
>> understanding that part or I give up if I don't have such time. I often
>> feel like I cannot say "I don't know well this part, but this looks
>> strange to me: are you sure it is OK to do that in such conditions?",
>> especially when the audience is large and/or the author of the patch is
>> an experienced developer.
> 
> Yes you can (even experienced developers can make mistakes ;-)!

Thank you for your reply!

> If it is not obvious that something is safe, it is better to point it
> out, so the submitter (or someone else) can give it a (second) thought.
> In case it is safe, and you didn't miss the ball completely, it probably
> warrants a comment in the code, or an improved patch description.

Indeed, good point!

It is good then to have that written in the doc -- I only discovered it
recently -- because, at least for me, it is easy to think that
experienced developers never make mistakes ( ;) ) and questioning their
code can only be done if we have double or triple checked that there is
likely an issue :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

