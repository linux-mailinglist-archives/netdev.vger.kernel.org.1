Return-Path: <netdev+bounces-121447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9A95D347
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE981C23783
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8A18A6DD;
	Fri, 23 Aug 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPSg+Cl+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17718A6DA
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430435; cv=none; b=qRTNiuyGHmMPMOUh02uOzGnVRtOJw9HXYgIIkz9TLFevMay8t7BwjsqBd5B4/2kmngt5GRBD1liNDC/87D5FBV228OZaxTcXPVxPWIlZnUNrNAm50bxCcirGkvrKzAa1jmuHCphdRe5nj2Ff5Yqucy6Py4jzdMT+87b8ssD4ZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430435; c=relaxed/simple;
	bh=ztJfvV+mOqAx5wYZ7mEZn/19XBQ/4zfjwIWo4MgbAtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY1mc69DHdS3yBYJ/isFw0FUm7ijIgESYe/PjhsSYk6QLFrzMS9Li8AP6WQnAGKS8IidfOPFOQ36ef5xPoZwiA0P4bvPRSSrPCKy9G4CzAgnFKy4/GAlv0CGLHKUlRdGOCcCe0SwSmQzYWxEdYfCED/2IO15BOG7mpgWrMgXrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPSg+Cl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD47CC4AF0B;
	Fri, 23 Aug 2024 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430435;
	bh=ztJfvV+mOqAx5wYZ7mEZn/19XBQ/4zfjwIWo4MgbAtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPSg+Cl+IPtIPzfc0QIek3E7vWXlzZbdRQugI+O/5b5OtVNNnukrrknkt1nphXf7Y
	 c/CIAsKa9A9ZxDN5IxRPcfwUeBxJckntOBAOQW6jXzAIUDBlPsPZVUE8auxPMOcFMu
	 FMpkgx5hjFoVn5OmRVKI7iL+QDBSpjPet3seoffR2PNa5fY7ib55Q/VNyFyMFrR4H8
	 d5ZEwy8V4CQs4mc/L+anbN/yA36/6/LP9wumz/JdPZCQPAvPcQUnNUpP4f4c8oFgjN
	 3oEPvBJmRYW44qY8IcTZWWZwFl9cneZd90G+AwGs67R0J4Ba1vyE8u0IwTatOotY3A
	 9RWmV6WLp5Izg==
Date: Fri, 23 Aug 2024 17:27:11 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next 1/2] net/ipv4: fix macro definition
 sk_for_each_bound_bhash
Message-ID: <20240823162711.GY2164@kernel.org>
References: <20240823070042.3327342-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070042.3327342-1-lihongbo22@huawei.com>

On Fri, Aug 23, 2024 at 03:00:42PM +0800, Hongbo Li wrote:
> The macro sk_for_each_bound_bhash accepts a parameter
> __sk, but it was not used, rather the sk2 is directly
> used, so we replace the sk2 with __sk in macro.

Thanks.

I checked and there is only one user of this macro,
a little further down in the same file in inet_csk_bind_conflict().
It's usage matches the change you have made - it passes sk2 as __sk.

Reviewed-by: Simon Horman <horms@kernel.org>

