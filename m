Return-Path: <netdev+bounces-29856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F2784F6C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D84E281278
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0102020F16;
	Wed, 23 Aug 2023 03:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EC20F09
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610EBC433C8;
	Wed, 23 Aug 2023 03:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692762313;
	bh=ESocJ6bsHcHNIZ7F3smHDU+FbKJm/VWMKpODPdAVEno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sx31gImVYm5qA3nYFs3Vlm/ITn2/KOJbHswQI+vX7lYNmI0smw6x9xV0bo4Hy2XMX
	 WpLqAIeyx6fezpl2LvoudEVc96EMQyfv3h/vF/DY2x8eLwT36AL0oJ9ggf9oRyCUV/
	 LdA/Xei9449GKoaI9rvJgWh78v/eMbzT+RgAhg0zg6q9tNR3Qofj5b9QpeSDDWq4tC
	 VubrR81XEWi5oNxm3hXdQCpgUym7nH64yF9/7jWHYV4Xda1gOYs2CRi/jQoDXuAXfV
	 0wFYKX7OYASQPvmxzoGfPvtlJcHMF7OJrnkmTUN5L8NLwfs9Ni92SZ5F1quHDYuU3e
	 zleZvLIOPw/1w==
Message-ID: <1f980abd-498a-8de8-2c62-0882bc1d3369@kernel.org>
Date: Tue, 22 Aug 2023 20:45:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum instead
 of erroring
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
 davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
 <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/23 9:41 PM, Alex Henrie wrote:
> Hi Paolo, thanks for the review.
> 
> On Tue, Aug 22, 2023 at 3:54 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> It looks like you are fixing 2 separate bugs, so 2 separate patches
>> would be better.
> 
> The two problems are closely related, and in the same function. But I
> will split the patch into two patches to your preference.
> 
>> You should explicitly state the target tree (in this case 'net') into
>> the patch subj.
> 
> Will fix in v2, thanks.
> 
>> You should add a suitable fixes tag to each patch.
> 
> That would be "Fixes: 76506a986dc31394fd1f2741db037d29c7e57843" and
> "Fixes: eac55bf97094f6b64116426864cf4666ef7587bc", correct?

See `git log` and search for Fixes to see examples. e.g.,

Fixes: eac55bf97094 ("IPv6: do not create temporary adresses with too
short preferred lifetime")




