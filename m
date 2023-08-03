Return-Path: <netdev+bounces-23874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C439376DED9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 05:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D94281F04
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40A79C0;
	Thu,  3 Aug 2023 03:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A38882B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10F2119;
	Wed,  2 Aug 2023 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=G/icn/UEr7mTwEtFSWbDRmT4eriYxtTJ9pPcu1g0aAg=; b=jv1mBXan50vglcJQVDNp1B4Frm
	rDdsxKrLf1T5zncMwh9/BZ8oVDu+UmJsPAb4w50bmS5WUApKJdabmkn7Le5hy4S3tSADTtM+NNxDI
	LlSBVAoOTXyINdJB+qcJ46wyHCiSBBy1/rWyIuP95y08Nm+BRwkDzTmHIomkyCrvNpCE191wr4Las
	ixICWSlKcq6/TUJzfd20oFNiCKFTyMmqiimoA8U0p22/DFVtvbZx5wRNe1YDylkDQHLIf8QZk+k4q
	LR9B8omdjf1nvW/Qo6R8AKfdu7bSh9F854450eq2a1lO/HQj7+Q+FuvyuoaR0RiZTzMT8+fw/p5tt
	8VxoOXGQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qROq5-006XFj-2B;
	Thu, 03 Aug 2023 03:17:25 +0000
Message-ID: <738565a2-4415-b67e-8955-32909cdbae83@infradead.org>
Date: Wed, 2 Aug 2023 20:17:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 2/2] docs: net: page_pool: use kdoc to avoid
 duplicating the information
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 aleksander.lobakin@intel.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 corbet@lwn.net, linux-doc@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20230802161821.3621985-1-kuba@kernel.org>
 <20230802161821.3621985-3-kuba@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230802161821.3621985-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 09:18, Jakub Kicinski wrote:
> All struct members of the driver-facing APIs are documented twice,
> in the code and under Documentation. This is a bit tedious.
> 

so easier to maintain...

> I also get the feeling that a lot of developers will read the header
> when coding, rather than the doc. Bring the two a little closer
> together by using kdoc for structs and functions.

Ack that.

> 
> Using kdoc also gives us links (mentioning a function or struct
> in the text gets replaced by a link to its doc).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> --
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  Documentation/networking/page_pool.rst |  86 ++++------------
>  include/net/page_pool.h                | 134 +++++++++++++++++++------
>  net/core/page_pool.c                   |  31 +++++-
>  3 files changed, 152 insertions(+), 99 deletions(-)
> 


-- 
~Randy

