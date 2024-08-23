Return-Path: <netdev+bounces-121445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F400995D324
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B178928AA33
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047C18A6A9;
	Fri, 23 Aug 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEGXHzpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFE1898F3
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430108; cv=none; b=dfJf+Yfi9xfUFrfmTI+gwsOU0O6vukJpr28kKBnHb8BvyxyvynX+LyvJ3n0cMxL4BtZ8Rf0PLyoAWgQQynZV7RMs1iIBbUboQnhKKP8LXFEFQ+N85EyRdT08A9mj+Usi99jgH88W6AHl9/BLUducwpqwA7ZrzBbvbE6s229jEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430108; c=relaxed/simple;
	bh=Y3lVqPQKIvbsNzqtWZFUAyrmaXb+CblKYtqmwj91HEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtZJ4oI0BPV2FhGvxu/5bx8ix0CtA8EkCRX0ja8LdUqN81oY6FzLVlSARRy75WAeAMk7+qXy9RbmVijO+j7uyZpxvpOWc9aMyqH9264wecAg8rQ57XQ5yMK8OivTu7v7b0FK9wZ8gK13IY7BpIlAH0jO44RKbipV6QXiZQKRm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEGXHzpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27A2C32786;
	Fri, 23 Aug 2024 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430108;
	bh=Y3lVqPQKIvbsNzqtWZFUAyrmaXb+CblKYtqmwj91HEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEGXHzppCvMFs/vlm8w2QAXUqpIGYv0R7QnGXOY95zg1nX0F9ka0AyCWOjKSXSsZR
	 rhe9QRDJNjLrQAOr4skvoWFabOdZSOWZT/HbfKeH1Z3veQaN5aeEFOwa5kZQHV+hMC
	 PNG2giZpPCmLs0bTvzHnzTP0fv47zOL53GdI6+KdgDTOVTUQZkVR6/CQ0iP0hp7+5Q
	 d4Ywhaj3pjnnMnj0JUIWXvjcg8hlclsO43lKrru1bvO0lltGj+ZRwi2oJuPDvSoQaX
	 9QaZMMMxksuKN3xYYw4T8E5Q917ZWWt1d/k7U+JzdtHnvVKdMNSJlm6VJkEHUfgf84
	 BjFe63WlbaFFw==
Date: Fri, 23 Aug 2024 17:21:44 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next 0/2] net/ncsi: Use str_up_down to simplify the code
Message-ID: <20240823162144.GW2164@kernel.org>
References: <20240823065259.3327201-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823065259.3327201-1-lihongbo22@huawei.com>

On Fri, Aug 23, 2024 at 02:52:57PM +0800, Hongbo Li wrote:
> In commit a98ae7f045b2, str_up_down() helper is introduced to
> return "up" or "down" string literal, so we can use it to
> simplify the code and fix the coccinelle warning.

Hi Hongbo Li,

That commit hasn't propagated into net-next.
I guess these patches need to wait for that to happen.

