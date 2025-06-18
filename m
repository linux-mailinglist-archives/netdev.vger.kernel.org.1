Return-Path: <netdev+bounces-198996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4979ADE9D2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DF17B54E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57863298CA6;
	Wed, 18 Jun 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvVYQCcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC42857C2;
	Wed, 18 Jun 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245640; cv=none; b=n8q0khMyPs9rDrEoT9LnW2zbeTUh0M8o88xpZt4DOEffSXqHhgYr/GKIMRBy9DaEQkTLOTYel/mfGVL8UQo8Ujs6tptOZsAq8fIEP+B4/+RVxIKWRRav/CZKZCs9WKQ4lrZeBfM+BWmHmZDQ0lasU1sezw8Y+awj+OMCu4ibOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245640; c=relaxed/simple;
	bh=oyl2TlLtbM84WquwhiDpUOOTBxx8O4A2cwquy+FB9Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejl08eKkpUc+S6n3B3Dr+koNB225QFNTIXhuDfcT+hWswimkfpLHrxDh2fHde1i+/q4OOzmqVkgLYKdV2OQOTA2F2lx22lOWxHtyDxwfSYD5F/Nq0+PqLhp4GoLwDR8HGkivvMH0M+1kYdfsJdQab621dJl6GlwOjKefuIQPKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvVYQCcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3345C4CEE7;
	Wed, 18 Jun 2025 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750245639;
	bh=oyl2TlLtbM84WquwhiDpUOOTBxx8O4A2cwquy+FB9Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvVYQCcKCjy+1AcrJIcDYtCax67JJ7KB1wwwCSscnJaEusKrLQUIF0yDrJwE8Rqd9
	 hPyMAmMe4ual+fCXnHFzSWMV02j92zmQ+dRRXdbf61tYXfouvL60BgYsuaqQQUibkY
	 7ICa7aFAy5ycM94CvKz7WnGMDZy8tzTdUymlWsGE1cW3KveoJEqT4uZ7zJShAulMtt
	 ydCnkNVkBbByP0fP0FpJ4vPGtme6JJ2gs6a9RrYfhCk3W7f4HG+LWdM1XYwvOVjQP9
	 Sj2noYFHIR1Fz7HwkV3zWRfza7DBO8hWpUMurBv6KvMt1xgD9/6hwM/yZ15SViut6t
	 ZLSIIkAE3+8Rg==
Date: Wed, 18 Jun 2025 12:20:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 6/8] net: hns3: delete redundant address
 before the array
Message-ID: <20250618112034.GJ1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-7-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:53AM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> Address before the array is redundant, this patch delete it.
> 
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


