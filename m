Return-Path: <netdev+bounces-39600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA07C0043
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B021C20AEF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054BA47374;
	Tue, 10 Oct 2023 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fse0NxUJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B421364
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4550EC433C8;
	Tue, 10 Oct 2023 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696951184;
	bh=7jQQMifr+Go217T5d/AsqG55iRv8grrj68bn1uTAOUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fse0NxUJruhuRP/9HVS7j4oNWQ9VWIzRTXdWCpjwYWuK0zsxIdBTn1RIyydlKOt1T
	 zHK8rbLnOp1Tcsb/N+k4VDoNFDLd5BSzOuE7nPSzVfgL41IyEM6lWMGS6Z7L4phQGU
	 HTi7D8P/RgfuzFLI5I4+07AB4OvBjo9GdZaKMDS8AXc6HrAxUZu6fFEZseo5ETF7ji
	 UKJ/DeZkJqYrgxv1RlZOBFW5t4SG2mIIXBOCtf2+NPLoK/J7HHiegsR60x2cOz48ii
	 XNbPUswt8Li0wRdXzCcEKj36DRYgcopJ3h3psWg1Ii+6rSX6PWIDqsv3RCjrO46YsB
	 3RHLsZWeZDc4Q==
Message-ID: <2403fd80-e32c-4e5b-a215-55c7bb88df8d@kernel.org>
Date: Tue, 10 Oct 2023 17:19:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: try to encourage (netdev?) reviewers
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 andrew@lunn.ch, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au, przemyslaw.kitszel@intel.com, f.fainelli@gmail.com,
 jiri@resnulli.us, ecree.xilinx@gmail.com
References: <20231009225637.3785359-1-kuba@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <20231009225637.3785359-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 10/10/2023 00:56, Jakub Kicinski wrote:
> Add a section to netdev maintainer doc encouraging reviewers
> to chime in on the mailing list.
> 
> The questions about "when is it okay to share feedback"
> keep coming up (most recently at netconf) and the answer
> is "pretty much always".
> 
> Extend the section of 7.AdvancedTopics.rst which deals
> with reviews a little bit to add stuff we had been recommending
> locally.

Good idea to encourage everybody to review, even the less experimented
ones. That might push me to send more reviews, even when I don't know
well the area that is being modified, thanks! :)

(...)

> diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation/process/7.AdvancedTopics.rst
> index bf7cbfb4caa5..415749feed17 100644
> --- a/Documentation/process/7.AdvancedTopics.rst
> +++ b/Documentation/process/7.AdvancedTopics.rst
> @@ -146,6 +146,7 @@ pull.  The git request-pull command can be helpful in this regard; it will
>  format the request as other developers expect, and will also check to be
>  sure that you have remembered to push those changes to the public server.
>  
> +.. _development_advancedtopics_reviews:
>  
>  Reviewing patches
>  -----------------
> @@ -167,6 +168,12 @@ comments as questions rather than criticisms.  Asking "how does the lock
>  get released in this path?" will always work better than stating "the
>  locking here is wrong."

The paragraph just above ("it is OK to question the code") is very nice!
When I'm cced on some patches modifying some code I'm not familiar with
and there are some parts that look "strange" to me, I sometimes feel
like I only have two possibilities: either I spend quite some time
understanding that part or I give up if I don't have such time. I often
feel like I cannot say "I don't know well this part, but this looks
strange to me: are you sure it is OK to do that in such conditions?",
especially when the audience is large and/or the author of the patch is
an experienced developer.

> +Another technique useful in case of a disagreement is to ask for others
> +to chime in. If a discussion reaches a stalemate after a few exchanges,
> +calling for opinions of other reviewers or maintainers. Often those in
> +agreement with a reviewer remain silent unless called upon.
> +Opinion of multiple people carries exponentially more weight.
> +
>  Different developers will review code from different points of view.  Some
>  are mostly concerned with coding style and whether code lines have trailing
>  white space.  Others will focus primarily on whether the change implemented
> @@ -176,3 +183,14 @@ security issues, duplication of code found elsewhere, adequate
>  documentation, adverse effects on performance, user-space ABI changes, etc.
>  All types of review, if they lead to better code going into the kernel, are
>  welcome and worthwhile.
> +
> +There is no strict requirement to use specific tags like ``Reviewed-by``.
> +In fact reviews in plain English are more informative and encouraged
> +even when a tag is provided (e.g. "I looked at aspects A, B and C of this
> +submission and it looks good to me.")

That's a very good point, good idea to insist on that!

Small nit: if I'm not mistaken, in reStructuredText, if there is no
blank line in between the lines, the text will be merged in the rendered
output and the previous line is not ending with a dot :)

Also, personally, I would have removed the parentheses, but I'm not sure
what are the rules about that in English:

  In fact <...> when a tag is provided, e.g. "I looked at <...>".

> +Some form of a review message / reply is obviously necessary otherwise
> +maintainers will not know that the reviewer has looked at the patch at all!
> +
> +Last but not least patch review may become a negative process, focused
> +on pointing out problems. Please throw in a compliment once in a while,
> +particularly for newbies!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

