Return-Path: <netdev+bounces-178744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFFA78A86
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C31516439B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94912343C6;
	Wed,  2 Apr 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLYwpMqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3D233D85
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584549; cv=none; b=eSvTIiIogj0jEqu1loBxnfchge6o0Njc69bNy+SqIs3W4N/92Hnt0qPxiwkrynJ3Tx2C/qkjCX7TwWk6KdYylrTC0uQEet+HTl/4EbzntPfUaTIrqJoGSgRX66znXKlzKUyBg1dpHnV33eml44xm1rDVqAVZcMnVNVU5bKKtDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584549; c=relaxed/simple;
	bh=uB6QkR1ClmeKbZIHH0aRktHZl3IBr8jrflQ6S9vSlaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV/eEkantKqhqjyLTjaDdQFGvMNvAT237zBkHBI5qUNuK8ZTEb6LuiK7yQo/z5BqMeJU95NlRypH2l1u+rtt1LgHogqrJJSWYRH8P9ySP9eNArjN8e9FjWQCqfSOemovq2Sn36DUPRCJVu02LeUQhud7pbCNRfJ2RKtsVXs0Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLYwpMqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18624C4CEDD;
	Wed,  2 Apr 2025 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743584549;
	bh=uB6QkR1ClmeKbZIHH0aRktHZl3IBr8jrflQ6S9vSlaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLYwpMqczF1FiUp4z79UoNXZkJtm6QqHe8XZSf69ugO13A/EB+S+4TvObycTUldqg
	 SFSL4M17r3ceuCXoABPfJsQugtMETIUm5jfFhn/FBk5q1wQKNmJsYaYjt79cPmxuOG
	 ipvfULQOFOOqWbm+ZxqOTE+R8JfhrFN24QscjSr5FOSrqckta50zqqDOYPdGOUgRNx
	 X0TPr9Hz050LwJRgONf+MwPrfRXL74ZsYOrcptKLpjwjBwanRYq7WNC+0nPZgNlBLt
	 DKM0itGVEqe018UvC6mjpCZuPZ+dyCQHYKtVXm4D2bqk3ipcP/QXlarB4eyW4AgARz
	 tLCuh12uuMzVA==
Date: Wed, 2 Apr 2025 10:02:26 +0100
From: Simon Horman <horms@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: Update Loic Poulain's email address
Message-ID: <20250402090226.GG214849@horms.kernel.org>
References: <20250401145344.10669-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401145344.10669-1-loic.poulain@oss.qualcomm.com>

On Tue, Apr 01, 2025 at 04:53:44PM +0200, Loic Poulain wrote:
> Update Loic Poulain's email address to @oss.qualcomm.com.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Thanks Loic,

As your Linaro address appears in Git it seems likely it will be CCed
on patches going forward. I'm wondering if you could also add a .mailmap
entry to help with that.

In any case, the MAINTAINERS change itself looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

