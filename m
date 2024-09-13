Return-Path: <netdev+bounces-128050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56272977AED
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906B51C25BEC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420AC1D6C4C;
	Fri, 13 Sep 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bApFRuI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C61D67BF
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216002; cv=none; b=XTZ/h0T5zxltuC8ZIHat4y0qsg1k6bZakjpkKwe/ZD5toEyTPB+aNy02cAEv11ThTIEuivF7ZsV88iQzp51UA7kWtlBk8PZI7VkfdpQAx5r+j04LChePmglP7R/CbKJg2zoUx49xqGjUUZC5LxL8rIi/RCMhprkxOve2KcV2UZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216002; c=relaxed/simple;
	bh=JLdfytEtHIe7P5Eqx/WTDXAAcTdEgV0X98t4QtCf8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUNdKsqcQ9H0kP6Nt2JJD20Jey5cG0KuTSqdhGbw/x6pO7+DgiDOVAowVQTStMbyI5HpcYlTy7WVGBOqS/+U/C77fLLvVWZQSpiS4GLeMz0ZW0jLN+SGBRNEU5jWtnZkDe3mQJBDQvqoQSknFJa6gil7wLP5No5GGx96pbuEsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bApFRuI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CACC4CEC0;
	Fri, 13 Sep 2024 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726216001;
	bh=JLdfytEtHIe7P5Eqx/WTDXAAcTdEgV0X98t4QtCf8fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bApFRuI78POd8ENVe2tghcXufOWgF8kaQdNXXZJ29xPDgJlTwnzIEBoaBKkJ15/Sd
	 pDFUG5JWkGHnQeX5JIuXFoCyKu3MyXTy6EZ9hPm0xCaMllTY2kFEBn6ebFDIUa221A
	 98jJOJjiaS0+jXq20+erE7AzH+YlKfWvSLTdhhGkqy6tHeLt1dD75XSPAPi3zyq2Pm
	 akyZiRsIkP782Z6bQZfDRCuSI0TgKGutj393AvUJ9vXA4vHHYwZLjAIYKvCMsxayYv
	 gJqFnXDMW8k5X3AtWasgts7zUoATp5bbB8FleP71eeQLBec9wHclijGSNJGWQ8dTNX
	 GXQte38ywqp6A==
Date: Fri, 13 Sep 2024 09:26:37 +0100
From: Simon Horman <horms@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: davem@davemloft.net, xiexiuqi@huawei.com, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: hsr: convert to use new timer API
Message-ID: <20240913082637.GS572255@kernel.org>
References: <20240912033912.1019563-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912033912.1019563-1-liaoyu15@huawei.com>

On Thu, Sep 12, 2024 at 11:39:12AM +0800, Yu Liao wrote:
> del_timer_sync() has been renamed to timer_delete_sync(). Inconsistent
> API usage makes the code a bit confusing, so replace with the new API.
> 
> No functional changes intended.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Thanks, I agree that it is currently inconsistent.
And that this patch addresses all relevant calls in this function.

Reviewed-by: Simon Horman <horms@kernel.org>

