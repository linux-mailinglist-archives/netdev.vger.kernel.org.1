Return-Path: <netdev+bounces-115906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010C9484EB
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720EC1C21BA1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1416D330;
	Mon,  5 Aug 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDaV2tvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811616C692
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893757; cv=none; b=SpojvAOu1fTK6Eri2TH2xD38E0UAc+lEvSFDYSFm3aXV0PCiOdG2xG711oKHPsUumQ3RiH7pPSW8hH4jlhMOpr2XXSK/puvddZZbvXy/NMoVivc8JYheDFN956CKROMBPT90b9gggXg76ep37oisMKnmf/I3HJq8+ewWoer62MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893757; c=relaxed/simple;
	bh=9ucqGJ8ikNGhiMSV7bZ/c9yCIiIb66FCojk8KQdtYM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8L+mH2BFdwuiLDqctutvbdlgkTzk6AlUltJC67UpVv4UbPK2H3isJtA8MJxLffpmmihBBhCM24CumxwsHJhD4hBOaFuU3WDCU5CeoNAZEfp0HmRqbT6CAa3l1pXVeToQ5O/IiiM9y8NJrn4naCy148HdJdwjYZNHMiQXSZv6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDaV2tvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D6DC32782;
	Mon,  5 Aug 2024 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722893756;
	bh=9ucqGJ8ikNGhiMSV7bZ/c9yCIiIb66FCojk8KQdtYM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDaV2tvyxbaVO0Ek7PxnCGZoW6Am8sESDPOaznyteI4dwY0o3UISFBMuL5ZKVMMfI
	 vbj2VhmbgBys7vThKitZEsiS8fOY/nAqsJoJbSvhoMT7XG5/LgfVUMB2UbBKJiaz9Q
	 T5N/Uvva7kUOfJzJrQW6jgnPSqjAXFS8yyKc5cHM7AERA2+p0CGVTIakkCe/bu86RN
	 z65LnAMSwYF+eXwbgv7vGZk9GkjmzxP2bkQdRyq/yhTj5grV9TztwZVOnrlTCMHeby
	 6/Ir/R5GICtLkmloS9JO5h6PqFZrC/UWe7Fu4OOCjQqKhzDv9GdXtT1aNJyweiS7O8
	 Yr5FlubCtr4KA==
Date: Mon, 5 Aug 2024 14:35:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 01/12] selftests: drv-net: rss_ctx: add
 identifier to traffic comments
Message-ID: <20240805143555.4d59b14a@kernel.org>
In-Reply-To: <e30e3dc0-e7d5-4550-b532-d3a36a87cac7@nvidia.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<20240803042624.970352-2-kuba@kernel.org>
	<e30e3dc0-e7d5-4550-b532-d3a36a87cac7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Aug 2024 09:40:58 +0300 Gal Pressman wrote:
> > diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> > index 011508ca604b..1da6b214f4fe 100755
> > --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> > +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> > @@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
> >      ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
> >      if params.get('noise'):
> >          ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
> > -                "traffic on other queues:" + str(cnts))
> > +                f"traffic on other queues ({name})':" + str(cnts))  
> 
> You've already converted to an f-string, why not shove in the 'str(cnts)'?

For (possibly misguided) consistency, there are 2 other functions which
use the " + str(cnts)" format to append the per-queue stats to comment.

> Reviewed-by: Gal Pressman <gal@nvidia.com>

Thanks!

