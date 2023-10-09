Return-Path: <netdev+bounces-38947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C447BD252
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 05:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B0B281477
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC18F45;
	Mon,  9 Oct 2023 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TumJ7S4I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAE4411
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB7C433C8;
	Mon,  9 Oct 2023 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696821402;
	bh=Ww61S2sJSjaAPaBDJ8w0pV1rfWZleNMyVct5tHmNsrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TumJ7S4Is1WFTUfPQkUcwShZe+lIWZNw/k/pOg59+DSN6bm8+RG6m3zGq+p4Yj8r8
	 U3F/+i51xoqvXqXs61Fp0sbZemjxxN2xSaGQUOg+1kMdfb6bITX7cl5ASkPXVcreMQ
	 PkxyqqJFvxd1wA8lOfoXiPIr78EhElVP67Z33Uar7cCNOigt3XbzfrhCHXyaHzjPnm
	 V6fGidLhuQUKFB1ojvVhbiw01hS5oroF9+H3AkbAVj6F44kveovJYTiDvwHtvtZCkT
	 p1WgaKCZU3pZ+y0fQF6x/iDO7IeLEw7JaiW8QFUnmy3Jru159n571ui/ajM9R5ZdC5
	 TPLwJM8qNGxew==
Message-ID: <97105910-1cee-e171-4d63-04c21e6b549d@kernel.org>
Date: Sun, 8 Oct 2023 21:16:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Race Condition Vulnerability in atalk_bind of appletalk module
 leading to UAF
Content-Language: en-US
To: Willy Tarreau <w@1wt.eu>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, rootlab@huawei.com
References: <20231007063512.GQ20998@1wt.eu>
 <20231007085735.1594417f@hermes.local> <20231007164227.GB26837@1wt.eu>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231007164227.GB26837@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/23 10:42 AM, Willy Tarreau wrote:
> On Sat, Oct 07, 2023 at 08:57:35AM -0700, Stephen Hemminger wrote:
>> On Sat, 7 Oct 2023 08:35:12 +0200
>> Willy Tarreau <w@1wt.eu> wrote:
>>
>>> Hello,
>>>
>>> Sili Luo of Huawei sent this to the security list. Eric and I think it
>>> does not deserve special handling from the security team and will be
>>> better addressed here.
>>>
>>> Regards,
>>> Willy
>>>
>>> PS: there are 6 reports for atalk in this series.
>>
>> Maybe time has come to kill Appletalk like DecNet was removed?

+1

> 
> This long painful series could definitely be the best argument for this,
> as I doubt anyone still relies on it so much that they're willing to
> invest several hours to fix this mess!

and if that were to happen, whoever it is can always start with a revert
of the removal patch and then fix known problems to get it added back to
the code base.

Seems like the right thing to do is remove it.

