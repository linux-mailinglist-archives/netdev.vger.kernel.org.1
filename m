Return-Path: <netdev+bounces-57905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F26814775
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11D71C226B8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AD25555;
	Fri, 15 Dec 2023 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axLrscre"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596224B52
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA8C433C7;
	Fri, 15 Dec 2023 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641483;
	bh=1uEkGYGK2Rzk0BMok2DPoUzsUzqTiq2nKN5rv4OxEvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axLrscreyd8ByeV4TAjc0c8akQfogUp56q1Oh9/LlLGN24FtPq9fk5Y8/G7Sq6Kix
	 KVTrBS/o0Y7xiGMY/OYN0fLzvcujtkLJdc+Qm6Uu2jwX9upiiXhA2qiVV9NIJtRJpA
	 E63zOE44cZZiJLFpG8u5WxPyYXA1Cxewd+pP2VEqFFsYE378JABX0M46MtyRJzhTFv
	 1uhJDLEL2ZAwwhxBtHWSmPMxMFlWuzokJ9m5WoZJwl8GzgXrzCTDlIw7j2arHmzYkj
	 kYkZE+Eu21q+MZt2kKZP9ju1bwKO65mY3ndi1sfss6t+8+piprUvZYMA6TSfOAJ5tK
	 iucXlJEhCDU0g==
Date: Fri, 15 Dec 2023 11:57:59 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] dpaa2-switch: declare the netdev as
 IFF_LIVE_ADDR_CHANGE capable
Message-ID: <20231215115759.GE6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-3-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:05PM +0200, Ioana Ciornei wrote:
> There is no restriction around the change of the MAC address on the
> switch ports, thus declare the interface netdevs IFF_LIVE_ADDR_CHANGE
> capable.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


