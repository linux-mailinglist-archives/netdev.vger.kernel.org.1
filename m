Return-Path: <netdev+bounces-127422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0E7975566
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8E51F279D6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2719F122;
	Wed, 11 Sep 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aav5yp/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCC19F103;
	Wed, 11 Sep 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065014; cv=none; b=pWhJ1hXXYOQUcOIb+uXUkg7yQz9tHVtzUTnukpc7evYXQ3ruyOglHGVHCAeZSy2jKcTaujfjMC4HRLk97U+Z5FFnzm+LTRk5EdseYbrVeH8iH1OfUFgOO13HVMAo556ZLWbMJjNN3uO7cnPRv904lt+4KCXwP0ZSrP/qOFAXjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065014; c=relaxed/simple;
	bh=6LiCSAIZv03QojzXf4p7TyaubdkXIBUyuQTIEZdAj4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN2DZkbZ1L0H2AQm261IXmo+oIfptFbN1Sqkisg7FjkF3Cjnm5n32cN9NhlranzrJ8DEGzkOnOBmQf1eE/j4ED+NxvFGzBFLPHH2c22rUh4AvC/9Mo8VPi/F8wcX0j4scYSrKvkBKBxh15WSdzTsMzXcti8tXcpuCyJHDidlXNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aav5yp/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DDDC4CEC0;
	Wed, 11 Sep 2024 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065013;
	bh=6LiCSAIZv03QojzXf4p7TyaubdkXIBUyuQTIEZdAj4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aav5yp/zlgyeuVZac5JtafGdmaLYLOIbxPesqS6hC+SQ9Cn5389MUvsJJdl//1JwL
	 8/f/LlPdb5ZY4TyZM2UqEdaExMTUIXpFD8k+Ve+f2uQSIOq1lV/c61JJghsO6UCv96
	 mOXizQekNePUISX717Z/SEU/9FGq5gd5AQ7ngsgi/RB+wzkNTwVBl2Aj30Iz2JvlNw
	 N97EgolHmVT1KgQWXNbNezCrQH9P/s3hu7LQ95pClY8pozXDW+bHaF1w5KVuAcr9bd
	 5ir9yr3Q/o23++KspfKBTdPOIWIi+EVWhpWSqUJ35dqOFP9nrU8H26lo5yEpfK3REw
	 ZJoBTxKK4/MVg==
Date: Wed, 11 Sep 2024 15:30:09 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCHv2 net-next] net: gianfar: fix NVMEM mac address
Message-ID: <20240911143009.GA572255@kernel.org>
References: <20240910220913.14101-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910220913.14101-1-rosenp@gmail.com>

On Tue, Sep 10, 2024 at 03:09:13PM -0700, Rosen Penev wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>  v2: use goto instead of return

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

