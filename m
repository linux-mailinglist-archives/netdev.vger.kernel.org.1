Return-Path: <netdev+bounces-25583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB5774D6C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B9A281350
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2558174EA;
	Tue,  8 Aug 2023 21:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2A10FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B4C433C8;
	Tue,  8 Aug 2023 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691531726;
	bh=DfGJgoICFpbwodUyconrw7br4Y/aAGzc5ytewSxQ1sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzJPPGPOV+tbgfBpKAWCXhCHqQLkYp/qSVn7Ph8ut4zwTxbqQ5Mvl8PpBVN5JGN2+
	 B53k0ySEc+F15n1+2eRyv/qDqJLvpen8L23BbGg+ArWPRMpo5c292tnFElyGhHsnQw
	 FnXm6Me5Q3G5v3Uk3/8+eHSVhs/Vs9U271Th0qrkA1aQ1mDWdVIXbXgGZrP2n/A/ST
	 0OohWs5TnIFvQnNrG34m8/9BKTetBq9Xbl3vI7mWHdGPvbX5j6Vn8QHrKY5pATDTY6
	 K2x75VlEe1Tke4++VcJT1VxMbW1yUICJz+ZEUVCuFtyFBDNWmmo541X2Mijk7OmVUw
	 33g84hDLwwEFQ==
Date: Tue, 8 Aug 2023 14:55:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rdunlap@infradead.org, benjamin.poirier@gmail.com, davem@davemloft.net,
 edumazet@google.com, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v4 1/2] netconsole: Create a allocation helper
Message-ID: <20230808145525.61840a76@kernel.org>
In-Reply-To: <20230804124322.113506-2-leitao@debian.org>
References: <20230804124322.113506-1-leitao@debian.org>
	<20230804124322.113506-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Aug 2023 05:43:20 -0700 Breno Leitao wrote:
> +	struct netconsole_target *nt = alloc_and_init();
> +	int err = -ENOMEM;
> +
> +	if (!nt)
> +		goto fail;

No complex code in the variable init, please.
Makes the code harder to read.

	struct netconsole_target *nt;
	int err;

	nt = alloc_and_init();
	if (!nt) {
		err = -ENOMEM;
		goto fail;
	}
-- 
pw-bot: cr

