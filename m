Return-Path: <netdev+bounces-166668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FFDA36E9E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E213A8BF6
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D71A9B34;
	Sat, 15 Feb 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVm5+qQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDA2AD2D;
	Sat, 15 Feb 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739627152; cv=none; b=YbuXvY1BgSl+P281PZd4GZgi64lUg9Z1bHt09H30QvXn4JSkIP1SmAbmelwq4skX/HJ1RbvDuc62W5ZbuZlcqZVFXL8/u5jbn6HpgTRq9XGxElrJQyP07tCd1q6a+/NpercHUBz2qHCCVSvaaWehVydmFGktFfiZ6jN5wUG71+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739627152; c=relaxed/simple;
	bh=0Cp85opGUTYUQPYzVDYxs88/wuDX9jLBEm7IyEJZHzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c61aLMK0SD6VBcxGFNCcUW+aDaZpb6ysvmGoAztTZJkYgoQeNWXul8RJsu/rsibTQxf1mC6X7tI938O2RzQRRWJH4p7dvKykt//GiGebeBffmx5gV1rRtwPBuesmMY1RM4iCVW4forWhU4p8Z2r+1JX9lhWS9HbUK+0s0NDljC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVm5+qQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04BC4CEDF;
	Sat, 15 Feb 2025 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739627151;
	bh=0Cp85opGUTYUQPYzVDYxs88/wuDX9jLBEm7IyEJZHzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVm5+qQpnyY9gu3Za6y8iYpfV2/4Wl7AOthCA2kdoFr6kpo+NdsbfRO4us4ZvyBLj
	 lKlN57+Ie4VdtdbVzDAQ8cGkLrxCKegw+go1XvL6pc4NSL0oFAwtdFmVsZ3+h1Saql
	 P0RALecyk7Cc1kVHrYOSuRyXVsdjzCO6WJpTDptfm10mTFlMVHkC9+/A218wLQ0Nzb
	 ijRLJeBLVK19UvayzX0kJ3XdbZhcIdJ0tPpa3tdFzbMwt/vAzhgh6cxiKLGJ9vaM+2
	 /NPQvuIVtsa+la76yEZRwwJ7NMELAzVRczRwD148uyCwqa8XTYxnmR/u3Iii9IEKr3
	 Lf51k3MpYgyDw==
Date: Sat, 15 Feb 2025 13:45:48 +0000
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net-next] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
Message-ID: <20250215134548.GN1615191@kernel.org>
References: <20250213152612.4434-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213152612.4434-1-pranav.tyagi03@gmail.com>

On Thu, Feb 13, 2025 at 08:56:11PM +0530, Pranav Tyagi wrote:
> This patch fixes a grammatical error in a test log message in
> reuseaddr_ports_exhausted.c for better clarity as a part of lfx
> application tasks
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Thanks Pranav,

This change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


A note on process to keep in mind for next time:

This patch seems to have been posted to netdev twice, about 20 hours apart.
Please don't do that as it can be quite confusing to reviewers.

If you need to update a patch, please version it (e.g. [PATCH v2 net-next).
If you need to repost a patch, say because there has been no response for a
long time, please label it accordingly (e.g. [PATCH REPOST net-next]) and
include some explanation of why it is being reposted, e.g. below the
scissors ("---").

And regardless, when posting a patch to netdev, please don't post it more
than once every 24h.

