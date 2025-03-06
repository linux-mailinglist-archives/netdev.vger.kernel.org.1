Return-Path: <netdev+bounces-172624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A7A5590D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8283B307B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F52702B8;
	Thu,  6 Mar 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxYeI3hk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0320764E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297601; cv=none; b=I+TCKT8tp3xiyZFlBISq2AzKZ7H0vuY0r/L5doD2ueWgOlN/ifjYhLOFBSWE7xfP8kcJAWwUrYwY+EP9heFpxHY1nNKAldXgNw/TaCNaJEeftmbsAJ+M9HyIhvEcCFmvaucdishobQpUeEIH2+jtruz8c/K7TU4DH4bLMC+yIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297601; c=relaxed/simple;
	bh=eUeYN3cF+grGOhOxoZEc85rrNa0gntdXdJRsdbURvp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/tgiYZEh9pyTl3dkIe//af99+xjfbN4sWrSDJ3+E3eSL5da7NCCEvuqee8FGRhRhhYQWIGIeZ+B2r+jLvTVmnZhPFHvHFa/8XAjvvj67OFZf8DW6oBwYd4LuwzIQi4SLc4S//ZtF+Twy/ktDgeVStwRLnM68DA6QdFeDt9Zxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxYeI3hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F7C4CEE8;
	Thu,  6 Mar 2025 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297599;
	bh=eUeYN3cF+grGOhOxoZEc85rrNa0gntdXdJRsdbURvp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XxYeI3hk2meM8eXZvbvzGUiWYyCxWIe3wP7kLNrvjW0gcoF8EN9XVTIoCd9Ycn+Li
	 f8PPn2XuXhVW1hjesDLSEdKpolpD8ox8tU0THFFQ9kzt74SXJF9M0HoKBRf6PG5N4j
	 jTeq8ZR+seCgEIoCAxerCHCjLgvt1dNfzEu4nsmV1xX21f8S3fkYWhdyj9BtYT/pB2
	 hS/ev9c8IggKtzvYtZC3JfadX+yK73nh82k0+jF2UKnZKn2eTa2Wzz/EFNY8xaU9cP
	 sfKg4IqAkHcdWlN4ngzmoGq5avLywfu3rh7A7t+bswHx2BTFnHUgxFkD9T0i2re3M/
	 473Yh2wck6Aaw==
Date: Thu, 6 Mar 2025 13:46:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306134638.3b4f234e@kernel.org>
In-Reply-To: <6ae56b95-8736-405b-b090-2ecd2e247988@gmail.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
	<20250306113914.036e75ea@kernel.org>
	<3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
	<20250306123448.189615da@kernel.org>
	<6ae56b95-8736-405b-b090-2ecd2e247988@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 23:13:33 +0200 Tariq Toukan wrote:
> >> So no less than two working days for any subsystem.
> >> Okay, now this makes more sense.  
> > 
> > Could you explain to me why this is a problem for you?  
> 
> Nothing special about "me" here.
> 
> I thought it's obvious. As patches are coming asynchronously, it is not 
> rare to won't be able to respond within a single working day.
> 
> This becomes significantly rarer with two consecutive working days.

On one thread Saeed is claiming that nVidia is a major netdev
contributor, and pillar of the community.

On another thread it's too hard for the main mlx5 maintainer
to open their inbox once a day to look at patches for their
own driver, that they were CCed on.

