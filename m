Return-Path: <netdev+bounces-67310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CA842B85
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C201C21699
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDA157039;
	Tue, 30 Jan 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5NPn6JQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BB155301
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638465; cv=none; b=FijpzgflDye2mGI1teVsi0BScDFleLf/0tJjqu9d89LY2/dNj/cBIPPTUwscKd1c+62Fu+Ha/wHU95GT/KG/5xaUZ7Y+hO9JPKs5xXOaQZcYUX+xaI+J9njK0jI32JKQ0tIsYkMKyk+dGjT8BBkQ4EdPQ9s6XW+NLpXGJqEYzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638465; c=relaxed/simple;
	bh=QmksvwCbuPYPOR50xYuWthfMcn659oC5po7QPV0xwiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQxZZ+1VdLdHxacLDm13yLcHDyz5U69io2iOT/7Vr5cWZYglN0wZDGnrCRORL2Pw5g+zabMDR742OTvN1tePv5A3QLqMQo9SG+uvRMUr8b5OLEMUUr4VRI9VGpjd4AfZz4aIba/UpIiazdbs2pv3DJU4miZJSFqb3oRPlZ5uUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5NPn6JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36910C433F1;
	Tue, 30 Jan 2024 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706638464;
	bh=QmksvwCbuPYPOR50xYuWthfMcn659oC5po7QPV0xwiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5NPn6JQnOe2eXHLwIUJRdJeTGxOtUw/tKl0BZm3RTH4NR0W5/kdZYq5rPL4K7XAz
	 8RktAo3Aoy+82l0pBzQJ5q6Ia3PqQ440FbWIMdnNsrJQxHJhz5F0wcqlsjPSa46bLV
	 oYfoj3lhGe9fqayd9aJj5M59pJNAYUs612GOqTNGNBlxjFRUh6lKMnAHuasdzHDaP9
	 ooonDrRNXtwXZe5urDRKNcaNRImJup4lPhbCyrGDIvvH7alUDBBiGrm3ErQmH5A30j
	 YC6O/sCWRIm3IfHFtoq3xuq6X4DJBoc30O7iLV5o8tAZjtduzMf0DVqJd9ugkma8ho
	 Pc2TJDf5pxqfQ==
Date: Tue, 30 Jan 2024 10:14:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Ido Schimmel
 <idosch@idosch.org>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing config
 entries
Message-ID: <20240130101423.45b0e1c1@kernel.org>
In-Reply-To: <ZbkIFrruZO5DXODm@nanopsycho>
References: <025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com>
	<ZbkIFrruZO5DXODm@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 15:30:46 +0100 Jiri Pirko wrote:
> For me, all tests end up with:
> SKIP: Cannot create interface. Name not specified
> 
> Do I miss some config file? If yes, can't we have some default testing
> ifnames in case the config is not there?

Thanks for bringing this up... I forgot to

  cp forwarding.config.sample forwarding.config

an embarrassing number of times. +1 for printing a warning and using
the sample if forwarding.config does not exist.

