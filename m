Return-Path: <netdev+bounces-23873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAB76DED5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 05:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BA71C2141B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ACC79C0;
	Thu,  3 Aug 2023 03:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA846A7
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E732119;
	Wed,  2 Aug 2023 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LkzgZJFa+VuCNWkaR7uOwVJMazMn2RX+T+u9LlEuolY=; b=GfolCQZedu1qC9eDuksX8/zl/+
	jw+dkHIXLiWWTwMy8IGwKxsU20roi0bTriH9ijDTqs6X8PBZnxa6D+YzRgTD3DxsTMZvTkTzbJ1qx
	nmJ7fBi5cg0F5r2jyjulfEPiO0IIXI2CKuU7cqnVvtJs7vknbxqYCQ3uUU3DJ3XuzVSjzemRat3Hf
	mcjUXrNhVMQecgcRiUQWyHpR7joNINQWTCOYkgvvuAoL8AesbO+6GR6muFpFxONB0vyucIFw7i3xy
	uAPX4fu22kbMA31oa3XtBAkBiXuNt7LA9FIvpBOKO5EHwEMojTaTiTSlnMR/VidJYeP4mZcMcz86F
	hbzCUG2Q==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qROpz-006XDj-1H;
	Thu, 03 Aug 2023 03:17:19 +0000
Message-ID: <693bad7c-d978-6651-370a-26bc8baa0a71@infradead.org>
Date: Wed, 2 Aug 2023 20:17:18 -0700
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
 aleksander.lobakin@intel.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 corbet@lwn.net, linux-doc@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20230802161821.3621985-1-kuba@kernel.org>
 <20230802161821.3621985-2-kuba@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230802161821.3621985-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 09:18, Jakub Kicinski wrote:
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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2:
>  - s/sync'/sync/ and other fixes from Randy
> v1: https://lore.kernel.org/all/20230801203124.980703-1-kuba@kernel.org/
> 
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> CC: Michael Chan <michael.chan@broadcom.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/networking/page_pool.rst | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

-- 
~Randy

