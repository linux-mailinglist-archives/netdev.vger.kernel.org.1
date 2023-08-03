Return-Path: <netdev+bounces-23896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FAF76E0C6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B0281466
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77F8F72;
	Thu,  3 Aug 2023 07:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCE8F6B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A5C433C8;
	Thu,  3 Aug 2023 07:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691046283;
	bh=2kto4InC6Iq51GEQ4G8zOyR+554dyqwej3nLgoOdS1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZokVQq/AhvebfAfowrVjpRNECfm2YzrOAwDaqKPZyYReoujSetdtN5UZPDoWNy63C
	 teg+oKX+hlIm+9SYoAqE8T1DlxVCG40Pb1htGwBCvrIgUt8jL9Szm/TYbCcmT+ScIs
	 YdHHkSo1CpGmffBSVE232i9DS8Y5XCxwXwcrHlZFAYqtSCKLB2lgWpedkiV5CYW2Xl
	 i0uzvUDaZuhs/pdCTdF7dJlk24i2MDyohYtgx1sBFnPMAD4nv85ClpMlYhseQ/ksLo
	 MWhZ34/bPpp+772v9gBfWwmpTOQnKvYngvX+91zjlqVOaXMiAU7CIHiN+MjXbjAGAY
	 4NBGiVb1t1I/g==
Message-ID: <5d7f0fcc-be07-822c-4803-1124e4bfaf16@kernel.org>
Date: Thu, 3 Aug 2023 09:04:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 1/2] docs: net: page_pool: document
 PP_FLAG_DMA_SYNC_DEV parameters
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20230802161821.3621985-1-kuba@kernel.org>
 <20230802161821.3621985-2-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230802161821.3621985-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/08/2023 18.18, Jakub Kicinski wrote:
> Using PP_FLAG_DMA_SYNC_DEV is a bit confusing. It was perhaps
> more obvious when it was introduced but the page pool use
> has grown beyond XDP and beyond packet-per-page so now
> making the heads and tails out of this feature is not
> trivial.
> 
> Obviously making the API more user friendly would be
> a better fix, but until someone steps up to do that
> let's at least document what the parameters are.
> 
> Relevant discussion in the first Link.
> 
> Link: https://lore.kernel.org/all/20230731114427.0da1f73b@kernel.org/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Thanks for updating the documentation much appreciated.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

