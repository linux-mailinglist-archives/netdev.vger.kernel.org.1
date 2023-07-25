Return-Path: <netdev+bounces-20943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C93761FAA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FCF2815FA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C724193;
	Tue, 25 Jul 2023 16:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF933C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1CC433C8;
	Tue, 25 Jul 2023 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690304269;
	bh=xKzii9Y3wXY0xeuIVkRtPbTVcYf7KRfwTosUVm60whs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlJhakcz4b/DMDr9bYwDfPp/BMnco0Owjy3mDGJMTanVw87DT4PzEOJcCEOBu+XgV
	 9LdwFAteInewwBg0HMYirxY49+W7b+ZXJtcFfRlyHmvBxg/l+bBSNi/I0JNfkEV/om
	 nJYFyCSWrX4Pepfk5FbKqHYXv60Cy8lBqueqcUJwmh3sM2vSpGsRVarXEXu4axp6Mm
	 veuFV4pNJ/2V7AtoWLYA6SaC+9pQ3zmZOYoNwqAs3YX5Yz06sM3paDqb7wUrDpk0zj
	 FBGtT2RrUmxjQa8hN3l6xK09DR5bExUxUjTNhO1MmQKM41rY2LvZ3lUcaxk/JESMqX
	 xeT5MHAAmDsSQ==
Message-ID: <22eb89c5-9c94-6498-4079-b3b732aacfe0@kernel.org>
Date: Tue, 25 Jul 2023 18:57:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: joe@perches.com, geert@linux-m68k.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
 <20230725155926.2775416-1-kuba@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230725155926.2775416-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2023 17:59, Jakub Kicinski wrote:
> We repeatedly see noobs misuse get_maintainer by running it on
> the file paths rather than the patchfile. This leads to authors
> of changes (quoted commits and commits under Fixes) not getting
> CCed. These are usually the best reviewers!
> 
> The file option should really not be used by noobs, unless
> they are just trying to find a maintainer to manually contact.
> 
> Print a warning when someone tries to use -f and remove
> the "auto-guessing" of file paths.
> 
> This script may break people's "scripts on top of get_maintainer"
> if they are using -f... but that's the point.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is what I had in mind.

"Anything that can go wrong will go wrong."
https://en.wikipedia.org/wiki/Murphy%27s_law

Therefore:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


