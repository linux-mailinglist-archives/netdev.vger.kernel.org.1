Return-Path: <netdev+bounces-13235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38973AE96
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F9E28169F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB91389;
	Fri, 23 Jun 2023 02:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A9384
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACA4C433C8;
	Fri, 23 Jun 2023 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687487146;
	bh=nEfoTPduxWRK8EMlyPvOVXDkzpi0w+SX3jrUXeY8ev8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqugcWB2OkFFklDlOHlAjVzzDIW7RSFxfoGOFEqQkv+D+6ErcPGw+EbJx32E06WYC
	 wtD7FuquAnntvaoKWikQMHWrzcDbZBb3noOQyuZ2xZQ9AK89DfoBPgp+wp6HaWlYeQ
	 oVVYXqrlhjGIvTAhTqawBRqURwD0mc8RUmk5xGVZUCyP+f4LoHsM8n4330N5SzlQ61
	 jJYe9g+LTX00a3mBwoe4epmgJ/ogdeerdHmIGi5Vm43+lZ07T367xkjvPyrEqy9NOt
	 qePVYkUVJ7mmztJJltuo05jfZKZkTXHacOWYBOxK9BwhhgCK2am4lAyKt4kugdg5ck
	 4DfICXI0ITG6g==
Date: Thu, 22 Jun 2023 19:25:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ngbe: add Wake on Lan support
Message-ID: <20230622192528.7bef1fa3@kicinski-fedora-PC1C0HJN>
In-Reply-To: <D021CF8344C66466+20230621094744.74032-1-mengyuanlou@net-swift.com>
References: <D021CF8344C66466+20230621094744.74032-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 17:47:44 +0800 Mengyuan Lou wrote:
> +	if (wol->wolopts & WAKE_MAGIC)
> +		return -EOPNOTSUPP;
> +
> +	wx->wol = 0;
> +	if (wol->wolopts & WAKE_MAGIC)

Maybe my eyes deceive me but it looks like you're rejecting all
configurations with WAKE_MAGIC set and then only supporting WAKE_MAGIC.
Did you mean to negate the first check?

How did you test this change?
-- 
pw-bot: cr

