Return-Path: <netdev+bounces-94714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D818C054A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799EC1F22665
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF91130A64;
	Wed,  8 May 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGMGbJ3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B338DF2
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198136; cv=none; b=ugoamCaAOZ364JtRG77G3vaV2TyqepgqaRmqY5iBKqG6Ka1Aa8n9kXm/wkmv7fvyuRsGCNB/7hGc8WV9eahjEGjcjoN5qg/3igNUKdlWMZmLaFyuRTIZYZb3HTm2SgRh1r+YYlWorOu7r3rH1b+mJDia2yw81eAFMBx2s+B0I8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198136; c=relaxed/simple;
	bh=HqpGS+JOndachOGlFftx2AIMZIuv9uWeH/DA9u9Y/bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/lAXAnfxeq7DRAMRqSHBSiypIc1v+YR5JfL6S/qOUcGs09YdS4lhs4qCF+A6MCuMCPr0EDSutJ2QLSX1bKQS6hK64LOl53maEB0qzV2/hKavKI5+4jgSI5NWex62YyVRaYU4UuR8pp+88Erm+OQaXus5GXBR97kOTG2LzcJkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGMGbJ3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B34C113CC;
	Wed,  8 May 2024 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715198136;
	bh=HqpGS+JOndachOGlFftx2AIMZIuv9uWeH/DA9u9Y/bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGMGbJ3a7KYbRO3B4DJTfpChzOfeNGlsnJPCj141pQJujoFFsQBXmgBeVeXohaDfO
	 LIpQtaxkqF/7ZYQECW8az7n60doEv7xWTDrFab8uYp6P/hrIDkyMjfC7T0NGzXmiMR
	 rOZOOFHqqcsMOWXS6TeDuIRjtxgMgT23TvM57u1rHESH4Fosrm86kpr5vX5xYrMMob
	 XTDwfRDV7xO9U2eZfpmwtEmKK1Xk/r4e5M7J2PoyTtcuhPc9WRrfGW1KjoQvIPqGS2
	 tUTRDru8vGiBGPJ5/yyhhaa98TB3wm4IsVyd9fQ+iIFfCVDSIIAjm46hUSrHfz0A+C
	 VI1AfNXzEy3dw==
Date: Wed, 8 May 2024 20:55:32 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: annotate data-races around dev->if_port
Message-ID: <20240508195532.GI1736038@kernel.org>
References: <20240507184144.1230469-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507184144.1230469-1-edumazet@google.com>

On Tue, May 07, 2024 at 06:41:44PM +0000, Eric Dumazet wrote:
> Various ndo_set_config() methods can change dev->if_port
> 
> dev->if_port is going to be read locklessly from
> rtnl_fill_link_ifmap().
> 
> Add corresponding WRITE_ONCE() on writer sides.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


