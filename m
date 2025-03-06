Return-Path: <netdev+bounces-172644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B6A559BD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B44918961B3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24327C17D;
	Thu,  6 Mar 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdoyj8Ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A90276052
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299989; cv=none; b=inGK2mHlofPufMETjJIJE4ti+dRKbwNJy1l6Q2K5rNzQa4Jxl9aRKSwLxmsy7qDDDzJlkG9JzgOEpVMzsGzI28TG7U7hRmhB3FCZZEZOwMNnn6e4raruAFIX5+tnnj5wqxmsXGiIq2cIztu4DJ0M47uaQomayrwnjkEKVoJlnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299989; c=relaxed/simple;
	bh=wSv06lSOtj1dEbcrs1DvqZ914MfJi+pVpmfJrxEAfEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R91LqS5qPHdH58QQmMTQuZcgfllSAlkH93JXemOwAGy8sYgV5eb/jTwxXJS2aphumfuj7pjiHRwLrD60/G974qW8ULe8jL6wccnFEaKgZL8CI3KzQtbtEOuQa3X90yHO+TYd4SqWeocFaisrT1npjlFHle+H4wD/iPilnuXB3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdoyj8Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD72BC4CEE0;
	Thu,  6 Mar 2025 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299988;
	bh=wSv06lSOtj1dEbcrs1DvqZ914MfJi+pVpmfJrxEAfEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdoyj8EyXf4t2QE6N9y0YCL9Cy76c9P9NVjCUAMwwLdArBAGF22GBmjlOvLiSs1Q8
	 n04p88AhAZeVXK+vMA+E2ifNnmrN7X1YF1Evuw3G9tO4IXM+XbUAXmCFqVakwxEeEu
	 FBx4LjUDLG8jo3XqJhH5zHA6IqOMuN64+BhOx2k5KgPPRBlulCCvQGE6BfvJ63aszW
	 ywrycEgU/2Ntxsp877y2lvdT9Z9DWMkh3wYv03CuARQLOQeENq9271TkF4pO9poG5v
	 wcJSTalryKXOh7iX7JtIcxg6+A0Q1KwrrA218xjbL4thikQDx0ZTHOATNH+314dPN1
	 JO9xgxuJyG12w==
Date: Thu, 6 Mar 2025 14:26:27 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, andrew+netdev@lunn.ch,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <Z8ohE4FuLBUf6NvX@x130>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306113914.036e75ea@kernel.org>
 <3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
 <20250306123448.189615da@kernel.org>
 <6ae56b95-8736-405b-b090-2ecd2e247988@gmail.com>
 <20250306134638.3b4f234e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306134638.3b4f234e@kernel.org>

On 06 Mar 13:46, Jakub Kicinski wrote:
>On Thu, 6 Mar 2025 23:13:33 +0200 Tariq Toukan wrote:
>> >> So no less than two working days for any subsystem.
>> >> Okay, now this makes more sense.
>> >
>> > Could you explain to me why this is a problem for you?
>>
>> Nothing special about "me" here.
>>
>> I thought it's obvious. As patches are coming asynchronously, it is not
>> rare to won't be able to respond within a single working day.
>>
>> This becomes significantly rarer with two consecutive working days.
>
>On one thread Saeed is claiming that nVidia is a major netdev
>contributor, and pillar of the community.
>
>On another thread it's too hard for the main mlx5 maintainer
>to open their inbox once a day to look at patches for their
>own driver, that they were CCed on.
>

People have personal circumstances and constraints it has nothing to do
with the employer or the fact that they are a maintainer or a major
contributor.
24hr is a bit too tight for some people which is understandable,
48hr response time works well for everyone.


