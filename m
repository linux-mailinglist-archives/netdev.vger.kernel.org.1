Return-Path: <netdev+bounces-53354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345C8028DF
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 00:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB25E1C2085F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 23:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304619BD1;
	Sun,  3 Dec 2023 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdU4r5v0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA412F44
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 23:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E5BC433C9;
	Sun,  3 Dec 2023 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701644560;
	bh=fhOsUemmIbNXrTHBuWXjhr0W7vN06ha4zou0HHZQi8M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RdU4r5v0XpuxgX9YQ5fo9Q/R8jBcSCpH7C2c30alhCnCARZ9mGRd0WCNnj4pBJ/ow
	 gSEhtHBq8VP/pUs/zDhKEHvGlD01XJbBiFe1iNoIOKbhXe3a+DUDRrifh6qejJLhFV
	 Gl1SplD+MHopqlpaGJUKWWxYD5NVKNoJGPjlrHtzCLnyaj6lLGVFpBZGLvE3abQVak
	 Pnf2jKfAEymXJjE+JnqVhu6oqjXVDK+8W0QEJXbGRLUtn7lWBvkVx/49KDwc+iBhW2
	 ycEQAY1PErubzo8wTiZojdi8xOIMXXoH5ox5i+wgYc291UYVY7I4/9UInCG9tDXv3m
	 UAjkmYjxOpi+A==
Message-ID: <1c0280e4-32b8-48fc-9732-fdf21e21f294@kernel.org>
Date: Sun, 3 Dec 2023 16:02:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip: require RTM_NEWLINK
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20231203182929.9559-1-stephen@networkplumber.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231203182929.9559-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/23 11:29 AM, Stephen Hemminger wrote:
> The kernel support for creating network devices was added back
> in 2007 and iproute2 has been carrying backward compatability
> support since then. After 16 years, it is enough time to
> drop the code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/iplink.c | 492 ++++------------------------------------------------
>  1 file changed, 37 insertions(+), 455 deletions(-)
> 

Agreed. I thought about removing it a couple years ago:

Reviewed-by: David Ahern <dsahern@kernel.org>



