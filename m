Return-Path: <netdev+bounces-222228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8915BB539C8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239EA4822F8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0235FC35;
	Thu, 11 Sep 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmEsSBUe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799235FC29;
	Thu, 11 Sep 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609954; cv=none; b=IMw0Zo51rWMxDs8ICkRu/xVHmPq5PQBR56HofRkE5VmSy3clyRSkiTqmMNC/mliw76PGmO+ssfzDiJccJXQQmq8qPnEn4kQRLHTB9BOQE20pOmJrAH8mGTeUamQGC/AOfuEjVZoLWHI1n0Smnypq7aV6VWEQH2Gt3cALr1m0KHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609954; c=relaxed/simple;
	bh=Xlc6koJ0vm41M4SAUwgaUOtl1XLT+vpjoBqnu6zMYUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZcORU9wxM6NW7Lhf7LR+11qUKZGHhcxu/z4u9HIb7UivLyb+w6ybda/V0WQ8g0WKKrdWe61vPZ8iBxVJK56TQt+y1F96pnU4zXf/z5UXaS0qWgwM8ujtrW8baDgLhnKx/DRDleX4EnJBP1L6aH1Yengc+FNW4OSS6fpZ+CcjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmEsSBUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E585FC4CEF5;
	Thu, 11 Sep 2025 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757609954;
	bh=Xlc6koJ0vm41M4SAUwgaUOtl1XLT+vpjoBqnu6zMYUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZmEsSBUe46oKNFLs1zZshCDORSXi/vmIA/olocQ/bs1EL0jdPhHubpF9/o5rsmBiQ
	 qcAMn0p6sYL3ASP57egXTeRsBLyv5tXq8CaQ63dmYuSRhmcO+8UfEhahaJ9iN20Zgn
	 yY7EvHXs4XrNDI4p13gRncZLx/bGnHw/rmm/18FRpOWtlqUXQDELkz6Q5afLcl7UnE
	 UfVHJyp5DHvPh3Rk26y+2UMb0zSFm6/gDRB7dh+MtqA/AehTkAGeqv1Kn16ztaHU6c
	 b52mxvx24QaDyqGlYtp7W/lm/hg+3NLy0zxA1leuOfHbIB6rzuGqFDWNqWZPk3hENk
	 xlB2sGAM2fLHg==
Message-ID: <a1f55940-7115-4650-835c-2f1138c5eaa4@kernel.org>
Date: Thu, 11 Sep 2025 18:59:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tools: ynl: rst: display attribute-set doc
Content-Language: en-GB, fr-BE
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
 <m2v7lpuv2w.fsf@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <m2v7lpuv2w.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Donald,

On 11/09/2025 12:44, Donald Hunter wrote:
> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:
> 
>> Some attribute-set have a documentation (doc:), but it was not displayed
>> in the RST / HTML version. Such field can be found in ethtool, netdev,
>> tcp_metrics and team YAML files.
>>
>> Only the 'name' and 'attributes' fields from an 'attribute-set' section
>> were parsed. Now the content of the 'doc' field, if available, is added
>> as a new paragraph before listing each attribute. This is similar to
>> what is done when parsing the 'operations'.
> 
> This fix looks good, but exposes the same issue with the team
> attribute-set in team.yaml.

Good catch! I forgot to check why the output was like that before
sending this patch.

> The following patch is sufficient to generate output that sphinx doesn't
> mangle:
> 
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
> index cf02d47d12a4..fae40835386c 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -25,7 +25,7 @@ definitions:
>  attribute-sets:
>    -
>      name: team
> -    doc:
> +    doc: |
>        The team nested layout of get/set msg looks like
>            [TEAM_ATTR_LIST_OPTION]
>                [TEAM_ATTR_ITEM_OPTION]
Yes, that's enough to avoid the mangled output in .rst and .html files.

Do you plan to send this patch, or do you prefer if I send it? As part
of another series or do you prefer a v2?

Note that a few .yaml files have the doc definition starting at the next
line, but without this '|' at the end. It looks strange to me to have
the string defined at the next line like that. I was thinking about
sending patches containing modifications created by the following
command, but I see that this way of writing the string value is valid in
YAML.

  $ git grep -l "doc:$" -- Documentation/netlink/specs | \
        xargs sed -i 's/doc:$/doc: |/g'

Except the one with "team", the other ones don't have their output
mangled. So such modifications are probably not needed for the other ones.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


