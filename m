Return-Path: <netdev+bounces-23452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF076C02B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880BC1C21103
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169D275BB;
	Tue,  1 Aug 2023 22:10:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC9253CE
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7910CC433C8;
	Tue,  1 Aug 2023 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927813;
	bh=yEtQ831wM9SM6V5F9aQEzVtZ+z2IR+deM3GY/Y8qBYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qy6FQWSLQq1YQov5rbsF6aHBQbRMR4DQE/tQC/4gT/C/W2jTMr6Sc/dcS7cLj/fjp
	 s4N7+9/P3otyVxRokaHODd6wLXkvy1lmUXZ2hWFHwrzGK8s9T4j3nOn7VnhDuj95v8
	 RqvWz7JXRNsRf8fMC2zc2fJoBL16iCfbwuUABgoP73vTd+G5433p0U1HvRPl3qZiCY
	 4JQhRVrK3dchDC5Aq5kPbEJ4np/TNEGQxtm226OkA27vj86Og3KdIl0E4vNebEVpHv
	 mSd9z7Zg4C+3wNQ+vuxVUd4wdiYQlJ690j9VwOPnAy3koihYvlY+OFfTt6IZgW8/5A
	 SlUoEkxEX/Jtw==
Date: Tue, 1 Aug 2023 15:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, Michael Chan
 <michael.chan@broadcom.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net] docs: net: page_pool: document PP_FLAG_DMA_SYNC_DEV
 parameters
Message-ID: <20230801151012.3be47633@kernel.org>
In-Reply-To: <23be0fd9-9177-a8bd-e436-07f52e40e79b@infradead.org>
References: <20230801203124.980703-1-kuba@kernel.org>
	<23be0fd9-9177-a8bd-e436-07f52e40e79b@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 14:58:48 -0700 Randy Dunlap wrote:
> > +If in doubt set ``offset`` to 0, ``max_len`` to ``PAGE_SIZE`` and
> > +pass -1 as ``dma_sync_size``. That combination of arguments is always
> > +correct.  
> 
>    at the expense of more overhead?

Should be implied by the context, I hope, so no point stating it?

Thanks for all the other corrections, will fix in v2.
-- 
pw-bot: cr

