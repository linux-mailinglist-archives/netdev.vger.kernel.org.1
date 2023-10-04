Return-Path: <netdev+bounces-38026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA887B871A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 086B5281CBA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302C1D546;
	Wed,  4 Oct 2023 18:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24F1D68D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC1C433C8;
	Wed,  4 Oct 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696442432;
	bh=Kl3qkuDXwVsPtemGj5YLfWsZgo/fk06VDeK+hdq5JiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j0kwz0zqiLuwTdWFK4Xp5H0+qrsMOkaOOoLenoaD7ZiM72mZsYQNoWYF0eLPbKcB+
	 nWoyQvPBeaxY0d/KoZj6wCeNVdSlC/vqzojUGHojMwWtuVO4QU67NXI+0dMiMNzuaf
	 9RK68AGbS1L71+qzsQuILJXwK5U1D4+PYrLsCfbW334BZwjvBDttkvmoFoO7oUpZ3m
	 P7rUkpU0d0aXnQOUKqjzDvZPMS9Zb59mtI45fBXyFXrDlD9eksA555ibq4Pg7XagAz
	 fRtaj5ixqSNW+4F7sqVaQh81rJcDD/SDxtdFQn+Y6UfhkpFvQ3sCEZXg4dittX7ShG
	 yue9UaFDGxiVg==
Date: Wed, 4 Oct 2023 11:00:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bryan.whitehead@microchip.com>, <unglinuxdriver@microchip.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: microchip: lan743x: improve throughput
 with rx timestamp config
Message-ID: <20231004110031.7e9c32e8@kernel.org>
In-Reply-To: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
References: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 21:26:58 +0530 Vishvambar Panth S wrote:
> +			netif_warn(adapter, drv, adapter->netdev,
> +				   "rx timestamp = %d is not supported\n",
> +				   rx_filter);

I addition to Jake's comments please also drop this warning.

> +			return -EINVAL;

And make sure this is the correct return code.
I thought -ERANGE was more appropriate here, but I could be wrong.

