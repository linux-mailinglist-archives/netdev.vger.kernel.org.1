Return-Path: <netdev+bounces-37472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64717B57E4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9D617283E9F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64C1DA52;
	Mon,  2 Oct 2023 16:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD83199B2
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6838C433C7;
	Mon,  2 Oct 2023 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696264141;
	bh=mpquLqeo+qKd5itabn6aSuY3Uz2rGl2cDIIZ9cGXsjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWZzPVNOZctAkLSmMo0omS8U+2XcDxsTMgcnAM2hjOpSq5QnaXQDodMtkFNzwCftD
	 3wwdwTtOidr67YhK7GuPSQJGIQAvcCsVTVf36Drmjg9Mte0d4vcEQmETbehb9raWGi
	 v0mEFfqr9biFWdJN9MnGIpAIqZC8CBGADSwp2YY9LPxuvqOxDEPHm4i/C9NeyMxhI8
	 Uh8hZTtdChURccyXjovEOHyqkiFgmx1gntS/p6d7nkV2FevpxLj+zODsNN4FM/SiLQ
	 wdxuUeYjY9KPsY4g36J+nKB6Q4NAdVxohPZty29VOFmudza1eh+5INZMj51zgeYqAZ
	 FUbogPlQyk5Vw==
Date: Mon, 2 Oct 2023 18:28:57 +0200
From: Simon Horman <horms@kernel.org>
To: KaiLong Wang <wangkailong@jari.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: Clean up errors in ipv6.h
Message-ID: <20231002162857.GY92317@kernel.org>
References: <1f323424.8ac.18ad9c59948.Coremail.wangkailong@jari.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f323424.8ac.18ad9c59948.Coremail.wangkailong@jari.cn>

On Thu, Sep 28, 2023 at 11:12:00AM +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>


Hi KaiLong Wang,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

-- 
pw-bot: rejected

