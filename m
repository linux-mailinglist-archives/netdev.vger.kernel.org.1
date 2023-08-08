Return-Path: <netdev+bounces-25554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C252774AE0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F628184A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494CE14017;
	Tue,  8 Aug 2023 20:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3141B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3DCC433C7;
	Tue,  8 Aug 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691527047;
	bh=RTzwEHM/nduzOMykf2hSBeVUj4UnjGAti0tMedWR3GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlnPj2z56Tm6tm7vK4bO0Z3mOqi+9BoUfcZSVKDXavgjhXCaEOW8u6lwGYLOHorRW
	 9sRN0rgNsDg2G7XFaBvuZTOEok9awWcO9at2w0PNjzTJrC9pG7o1qKuJIYkPF7ZJam
	 r+cQv9k/3lneVEgCTAlc8xsJc1vX8OEWBaXMMQIKpUVA2h0BW3xVnW3wffeSvxXjgs
	 7nh2F702o3Xmcf/k773Gfm4ZviJcSZ6x8Ha2ii/qhO3EUv8/ATqviTnk/CrCBBf860
	 yvddUZU5oepzYEwPZRh0nrOmqAEAo5UJ5++TTRpIYLF8reWUQAVx7OiPm8nNkkfs+0
	 qj5RmNgKSiEPg==
Date: Tue, 8 Aug 2023 22:37:24 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mhi: Remove redundant initialization owner
 in mhi_net_driver
Message-ID: <ZNKnhBkkc7M+A/FC@vergenet.net>
References: <20230808021238.2975585-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808021238.2975585-1-lizetao1@huawei.com>

On Tue, Aug 08, 2023 at 10:12:38AM +0800, Li Zetao wrote:
> The module_mhi_driver() will set "THIS_MODULE" to driver.owner when
> register a mhi_driver driver, so it is redundant initialization to set
> driver.owner in the statement. Remove it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

