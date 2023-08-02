Return-Path: <netdev+bounces-23576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945676C8E7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024A1281D01
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D94567F;
	Wed,  2 Aug 2023 09:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537C2F51
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0BC433C7;
	Wed,  2 Aug 2023 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690966853;
	bh=S/vkfxkWrnp88I3Ppmf/4fzyKWNmnJ5WJw/ak8C1jw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl15IMYFF0oFYh85fPyA5v1L0x8yFKz9jdYxXpjiH9AMPKOxvpYyPUN6LQEmR1CxV
	 4xoyEJ4v9+Bg/+O0WG7a3oxji71vgm7mfYbZ5bRymmi7QAxUsjnv/CLyRtoOI+gdfE
	 Ermb/xnIeytyj9rK4p7qqRF6VfDUGye8q0jkSu8ONvFMj61p+WpU1xw7wnbMK4OZfa
	 YrJmEXvBhDnQDgy4pgCxJliKDTKDXgIPcdw5f0yZzi/LhhYXzjVDwTr/pdovwXKRmO
	 BiJbsM1WgEwH94pU7yMJjIRcMUn01/YMCgYKsEJDjRY9VtOpkj359/uUcPlMi6/89N
	 bgCHJzMSZ/Apg==
Date: Wed, 2 Aug 2023 11:00:49 +0200
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sean.anderson@seco.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next v2] net: fman: Remove duplicated include in mac.c
Message-ID: <ZMobQezYzNWI+9ps@kernel.org>
References: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802005639.88395-1-yang.lee@linux.alibaba.com>

On Wed, Aug 02, 2023 at 08:56:39AM +0800, Yang Li wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> change in v2:
> --According to Simon's suggestion, make a slightly better prefix: net: fman: ...

Thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

