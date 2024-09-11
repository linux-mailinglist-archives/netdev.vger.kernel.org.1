Return-Path: <netdev+bounces-127235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BE974B3B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15C1C232A7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C613A265;
	Wed, 11 Sep 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC/Dvpcg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD81311AC;
	Wed, 11 Sep 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039661; cv=none; b=KdxSWHV6kTheXuh0sOexe5DQfC2ihMlaTZ/Lh4nQt7cH5tdpbYqb3ai+CSmxeGmtWpC65aEBt79Af6JstF+EpZgZcgIk1M7gGSBvJ4fvA1MxWi2RG8wv9DIOtN1m+nIIBky+ucgFZGNOamCridtwYG4uQwfF250ffWYSslBZXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039661; c=relaxed/simple;
	bh=e5OE9kPUXgrJ/pbe4LFDZOSG2Naco5KeO8Srcmx0UjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJX4blFgnbwCO9xihK1EHMqzOTbgh9IIbQc+VeNhjOIB+lgsi7X2osGq0eo0aHbhyvGWLEFf4O5VQPyljrbFRxpyg8Z8qH4wwdOJHj4hciuulQdIJbVO+LLSEbV3ohgxlCSOvtejvDuocoI+4Yu96hhcr+othSDMoPC6UQDepDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC/Dvpcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C946C4CEC5;
	Wed, 11 Sep 2024 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726039660;
	bh=e5OE9kPUXgrJ/pbe4LFDZOSG2Naco5KeO8Srcmx0UjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC/DvpcgLOeFKrOi8EBGN7QgrKwmB3hmXP5BXdjVh+XzZOtaBArZ6HhGfH4gxDaVM
	 evOBf6y9MuIxvk8wrJAK2EY5IJExTXeiIIGkqrJCJHsuorqT3Ru6gQU8USSAlGcLhD
	 HXVH1SJfe5o4Vhiifipa0ruXa0hkHQE0fAEI3xJf1DKXy5jo0EPpAE1EQVohasRVlJ
	 2liSk2/GrUYHocjQxtTSBz9XcXUxutDNEVTnQ1ipSww82YSQaPiz6y25HTdUsgb5Qe
	 9k/lUgcQMRG3t00ON1flXUHglT1F1FPuzp07uDPiiYqpI2aCsZIAi+76hjglHKbG87
	 qjsH0y+U3Xw4w==
Date: Wed, 11 Sep 2024 08:27:36 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next] net: ethtool: Enhance error messages sent to
 user space
Message-ID: <20240911072736.GI572255@kernel.org>
References: <20240910091044.3044568-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910091044.3044568-1-danieller@nvidia.com>

On Tue, Sep 10, 2024 at 12:10:44PM +0300, Danielle Ratson wrote:
> During the firmware flashing process, notifications are sent to user
> space to provide progress updates. When an error occurs, an error
> message is sent to indicate what went wrong.
> 
> In some cases, appropriate error messages are missing.
> 
> Add relevant error messages where applicable, allowing user space to better
> understand the issues encountered.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


