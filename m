Return-Path: <netdev+bounces-42295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87AD7CE18E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B236B20F59
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791B37167;
	Wed, 18 Oct 2023 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guz6BzNG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A081A278;
	Wed, 18 Oct 2023 15:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF875C433C8;
	Wed, 18 Oct 2023 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644026;
	bh=J6mlesei88Ro9YdTYZGFbmMGEcYaRDXJ6SfXTBc3BZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Guz6BzNG2qTGyiCv4jfsNLFpK8zDU5/HE4prKf8QoTZUBVK/3Zc30fJmpt/WlP8lv
	 ohocXjrEHIVp/dk6Ro6m+8XuvJhoFvjD6UNI9zKsXC6QlyiPsK+f8SBfVnE2bfZLA7
	 Qveal9Jo5heP8Yhx4zgrtQhUxaprNQH22E8crMMqLQfEPrK3g1tfhJJrJiNNrPS4QB
	 UjR8siRt3lHGKmzgQwT9fGPjBoYcJnp2yog2aeCOKbr8hpKC7005d1v9NflLgTvnXC
	 DIkkY+QhthofpS9dzJfZQVvNbqv/mwm1s+HjR2RI2a855mbI85jj4RwJBjtXrJNfgD
	 3US2tGgy6kVIA==
Date: Wed, 18 Oct 2023 17:47:02 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, ecree.xilinx@gmail.com, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: networking: document multi-RSS context
Message-ID: <20231018154702.GR1940501@kernel.org>
References: <20231018010758.2382742-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018010758.2382742-1-kuba@kernel.org>

On Tue, Oct 17, 2023 at 06:07:58PM -0700, Jakub Kicinski wrote:
> There seems to be no docs for the concept of multiple RSS
> contexts and how to configure it. I had to explain it three
> times recently, the last one being the charm, document it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good :)

Reviewed-by: Simon Horman <horms@kernel.org>


