Return-Path: <netdev+bounces-54538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E148C8076AC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE131F210F3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD66A005;
	Wed,  6 Dec 2023 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd5xgApd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8B364B2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440ADC433C7;
	Wed,  6 Dec 2023 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884101;
	bh=l6uc1UENCSeZGc8bYRiceTUZSVKdPJe0fsQ9QeaY7IE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hd5xgApdfvAuj5tM31R7hVfrywxhW9+Yny5BGw/8VEAWCZDD0KzMbKxTkxf7eOZ6v
	 XprD4Pn5KglgdfBDqZx5hokxMgZs53IswH57V/12pRf9DzgEfincz/Snc6PTtSTkEO
	 lg5is/uOX5cR9OkT4l5mN1Tj0IqmMGtjz3wEr63jWuzHkCjeARinRIZ9OZdL0B4LNG
	 q7YjPYFjDxYUaO+csN6ZPc31VWyYRrTZ4zF4wi6r7kYyowrX0ZZQOZhtwOlcAW5jph
	 AeITXs/iNNh9XvKMx/N0o/yLPaf74ppVjOIFkwEsc/XMD0YJfef3CO5jvQoc7cS3zm
	 XOX7lP28OG4NA==
Date: Wed, 6 Dec 2023 09:35:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 6/7] net: wangxun: add ethtool_ops for
 channel number
Message-ID: <20231206093500.7e71fbcf@kernel.org>
In-Reply-To: <20231206095355.1220086-7-jiawenwu@trustnetic.com>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
	<20231206095355.1220086-7-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 17:53:54 +0800 Jiawen Wu wrote:
> +	/* verify they are not requesting separate vectors */
> +	if (!count || ch->rx_count || ch->tx_count)
> +		return -EOPNOTSUPP;

Doesn't core already check this? You leave the max_ values as 0

