Return-Path: <netdev+bounces-37639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3D97B66AA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 72B9F281732
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59F1A286;
	Tue,  3 Oct 2023 10:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39EFBFF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7026CC433CA;
	Tue,  3 Oct 2023 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696329913;
	bh=JtcTWQxKGWwZqgm+l2lYgbyA83rSYz+5KPoIJRXClqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQk5DIi8st3IxeEoWswm+LZCDSJ1umvNGVAkWJDdNFUEjdE5B4Kejz/vXEoYDEoSc
	 0BgkVJx4ZdD9nmn481cjzkD4gsWUb+w7Ec/Ywiur2aabCOi0k2RykuiOH3ipz6YsWD
	 7hq9dEGEmCiV0+8he9Xar6k+PrxtIY49JRP7TmDmifVG12Iv+8WXun32SkqKRdmvd4
	 G0mJ8QGb+2PVSV6LerHokZUK9Jhw4mD9crcmCttr/EELnb0xHigjja/ee4o1e6zWNw
	 TxHBnjJDMQRA39KygOx9hwrenCopAGtslqyDSEKrqAwQKH1TilbSH79xc+scE8cpa+
	 RGehgD5Bx9nQQ==
Date: Tue, 3 Oct 2023 12:45:08 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] page_pool: fix documentation typos
Message-ID: <ZRvwtGG7hZSda3AM@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>

On Sat, Sep 30, 2023 at 05:38:45PM -0700, Randy Dunlap wrote:
> Correct grammar for better readability.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


