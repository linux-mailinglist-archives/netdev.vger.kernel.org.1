Return-Path: <netdev+bounces-166640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9FA36BB1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EA7171FE3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A3155308;
	Sat, 15 Feb 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kahJJOUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDE76BB5B;
	Sat, 15 Feb 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739590671; cv=none; b=eVAEgqvJ9kLVJiLXeqnxoar66uu1honVeCS1pMWYMW+9IblXbwKIv/7hmFI9NT15ICjJ1iMNaD6Vw5B1bH9cM03wwXlNYogemT1m7pXjAZqwBwvL2eN3SVl5ruGhZXf+LcQxEHu2WrbBPBjfLNYMzhQ+JD8ChA+NZL4BUapGShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739590671; c=relaxed/simple;
	bh=RvrLFNrlUCc6p6/LkxPXn6kksPdr9Va9IlSL9IB1AI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogd5MfLtAQEyQqFOg9ZUquJUOEPB5anZmGYyjb9HKKm4+AaoagAJDSxJ4Z47aSlXoritjKJsSozLajoRhfCaCkI8hcVtQnHyzefuqiYtWRvPpZXmCXFijjpLJycGX83FbvqApbqFtoou/nTvFiGseem7LxgtDBppdRjycc9/M94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kahJJOUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F3EC4CEE4;
	Sat, 15 Feb 2025 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739590671;
	bh=RvrLFNrlUCc6p6/LkxPXn6kksPdr9Va9IlSL9IB1AI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kahJJOUpkw0sx8omngA7pyvqrRLN2N7923tF/A6CUXAfxufTKe5ODBP3LNwzhCWWL
	 FLItzy0jGpu9qB9lBjHd96irETiYu5Ahqy4bvz4yI7kOaVuHYpSLP5Cb88cSfuYu27
	 4WAVMcaAtAtmp/XOhVTJnnnULhMS6GYiNw8yblfI+DkAwbpA/rrEySOo+jvvs8PumD
	 Ml4HzJbnB0JCmmRsRktW5rHuuwsh2WsPmh9+emCzCnWE9xItDPuRaXTJcAOzvyLv2p
	 7RhgvDAn4GbQH6Vr+a8wJhEUg+rzj55NP8LuBjvGIWzmsRaZQ1EKnMOjp6AWPeZ7NJ
	 6OUhIAxcZ9Jtg==
Date: Fri, 14 Feb 2025 19:37:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next v2 1/2] usb: Add base USB MCTP definitions
Message-ID: <20250214193749.1dc57618@kernel.org>
In-Reply-To: <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
	<20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 10:46:50 +0800 Jeremy Kerr wrote:
> +	__u8	rsvd;
> +	__u8	len;

Since this is not a uAPI header u8 is preferred to __u8

