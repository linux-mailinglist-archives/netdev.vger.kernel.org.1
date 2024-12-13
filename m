Return-Path: <netdev+bounces-151741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120F9F0C11
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A404168525
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394F1DE3BB;
	Fri, 13 Dec 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKXZSweb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0951BBBDC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092340; cv=none; b=rdXe0+as5v4yEmnJZfrqV2+2zcIzkP5p+vcqmfhvK6znaIczIWIgOvaZKenTMnW3SbItZET6ERP4HOdB6JUNZPk5UTwPirlX7Zjdjg0VmahNEDIfTyIfgQgP9WCTU3nfat9yoy9BQAslggO87GK4RuW2yZ6KeAW5g+mYWl+XNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092340; c=relaxed/simple;
	bh=+yhfA3n9/a0VuE9nzR3+PlHnLAGF7VWQOReVN9pHryY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX3M1JYRZ0s0EzP3gCT+uEewyjWB1Lzdki2Bpt/ko/dy/fYhaYgl6IPJa7Dpilu611BtspKTsuaZpay6BUBDl6hRCsJIHEUuvWC0KdmGf6JgrDt/2dOGHEts3gXVuhYcBmaZ18RS/xlpuXcv8e3FDWRCw3eNQiiYPpO7A6+lmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKXZSweb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73E0C4CED0;
	Fri, 13 Dec 2024 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734092338;
	bh=+yhfA3n9/a0VuE9nzR3+PlHnLAGF7VWQOReVN9pHryY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKXZSwebku2CnG4C3OffKExCmz7dj/uxhLJuEGmb8JCbYpfek1kqZQaM0X1KkzwrP
	 /3pJEq81fzwQ44SmlTOBgmRbhwEPt9G3XpTvZnmUVy1wy1GlKcRg6QyYTz35jRz9/z
	 KZ8Wx6QvetzSxw7L/+lHKUiu638eWjx5H9N/dKLQ8Ty6Yuth0tU6uw61Al+9vAhoiZ
	 OgW9afvqO+9/6SFStYEU2srPddGLlJjtRcRg+C5gxR91cb9oDKmMowBazRpw8bKTht
	 PZ4LIDApmXbPjHXQRk4ZgG6xUmDFhKVSSEKScXLCrjPSpVxX+QlkQ/qwrJXY11RJfZ
	 WU9wHThgtHPXw==
Date: Fri, 13 Dec 2024 12:18:55 +0000
From: Simon Horman <horms@kernel.org>
To: Maximilian =?utf-8?Q?G=C3=BCntner?= <code@mguentner.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ipv4: output metric as unsigned int
Message-ID: <20241213121855.GU2110@kernel.org>
References: <20241212161911.51598-1-code@mguentner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212161911.51598-1-code@mguentner.de>

On Thu, Dec 12, 2024 at 05:19:11PM +0100, Maximilian Güntner wrote:
> adding a route metric greater than 0x7fff_ffff leads to an
> unintended wrap when printing the underlying u32 as an
> unsigned int (`%d`) thus incorrectly rendering the metric
> as negative.  Formatting using `%u` corrects the issue.
> 
> Signed-off-by: Maximilian Güntner <code@mguentner.de>

Reviewed-by: Simon Horman <horms@kernel.org>


