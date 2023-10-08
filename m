Return-Path: <netdev+bounces-38895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AA7BCEA9
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C97281765
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844CFC8E0;
	Sun,  8 Oct 2023 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA70vUo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A38BF3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D4C433C8;
	Sun,  8 Oct 2023 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696773581;
	bh=2XNEcD+UIoF1P8CQWuQPztAhTTNKspPsD1DJEKJBTUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA70vUo6tC88H+DsBix5t/sO1Xmyu92IEy+oVfv+BolOrqgFZ3eS87hWrCt5gZ2g4
	 zFyiQYedsx5YlW4TD6IEWNYRIXHm+azKUlFTUJA3i9SCgMh9wzJ3vZoYjetMPIqZB4
	 D6CZj4lLN8Lkd5698WfIkC5XE1VykLiDQRY1kTb4ILVMBsxIsNioSteie50z4kwFS7
	 6Ei0Drq1wQmkyLMxneSBkOzZNuY/7gamewifa/bebrdg5FxkjP1b5FZh/mTTrZkjPE
	 a+snJ0Vlp2JhE1Psj8FSRy+O4lKY7rzQHElWZi2AouxLB94vA/tHZupOyvnCLM8ab/
	 ahAG4YJu7kXPQ==
Date: Sun, 8 Oct 2023 15:59:37 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 0/2] mlxsw: Fix -Wformat-truncation warnings
Message-ID: <20231008135937.GH831234@kernel.org>
References: <cover.1696600763.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696600763.git.petrm@nvidia.com>

On Fri, Oct 06, 2023 at 04:43:15PM +0200, Petr Machata wrote:
> Ido Schimmel writes:
> 
> Commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow
> warnings in W=1") enabled format warnings as part of W=1 builds,
> resulting in two new warnings in mlxsw. Fix both and target at net-next
> as the warnings are not indicative of actual bugs.
> 
> Ido Schimmel (2):
>   mlxsw: core_thermal: Fix -Wformat-truncation warning
>   mlxsw: spectrum_ethtool: Fix -Wformat-truncation warning

For series,

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


