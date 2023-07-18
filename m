Return-Path: <netdev+bounces-18677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A8758425
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B71D1C2087E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0DB16406;
	Tue, 18 Jul 2023 18:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345716403
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE3CC433C7;
	Tue, 18 Jul 2023 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689703615;
	bh=88mOW/Jxt3hWqsKWEzcfOJPc4T/peV4NshcYKjzQeRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tRIRNV9xuItBjPLIPo5eYoGYUpetQN69SoaS11o/Trrpq+PNH3zu98+n12K66NRXl
	 y0Hrs1r5XJkJ0DURie+rFr/KCZKHzCFS2/e5J7JIT5eobHLVBO28Pq6Cc563b66Rfh
	 i5nZs4KbH66LYayy6xhq8lLxAalXJ4FpUIzsiKmAARnYdovH0ezvgwaJpwsS4HsgVD
	 3HlmmPQR00WxAaXPb3TBvSqfpiQ1irDh9F4spvq8yl7kOmazHllO7Hz5SbH2AYFUIa
	 BTJAKgHBoEw1NPOG7Fd5lS7oJHbJaCgegvmC1JJ2/9H4aAXpXCX4eBSnJ98ROAfJ+9
	 RRN81ukzNNhrA==
Message-ID: <8331449d-6b25-7ea0-4c28-9128ab483fba@kernel.org>
Date: Tue, 18 Jul 2023 20:06:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org
References: <20230718155814.1674087-1-kuba@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2023 17:58, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


