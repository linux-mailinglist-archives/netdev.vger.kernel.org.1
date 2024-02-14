Return-Path: <netdev+bounces-71805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26368551CE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8792995C7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894E1272D3;
	Wed, 14 Feb 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLZDE35Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53A126F3B;
	Wed, 14 Feb 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934288; cv=none; b=FY6I3dltv+BIDJeB8zeDK4/lMO76zvJUQh+W1zIyPCdaFh8mwXOqSqiLkJP9AYAoiB1oQ8xlyrJsUt5o5X7y+VmCwb29gE7NmyFTgq7irRqsW/lJqP8qB4JQX2OKhqCc/DlchIlijko/kpMvetC4CbMwUJ2M8jij1Ns41NRQRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934288; c=relaxed/simple;
	bh=GuaP8Kmq3A9rbhJY9b1MVriZ9VyUEnzwnoFzYXaIvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHv5w9pR9g0Qy5zRg3fM5hhyGBJmjun2aV2UvtTUPt8/ivPKEFc257e5mmbIfEa9JN83so648i1Go1/q7srgsxj5+YpHQUimS7C/A5w3YqNAoQpTpnQ62eSji3BSL1vRIKVh/2Qyn7CcE7AEZljvWu2cKuyIjcX34O6cRP5kL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLZDE35Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9727C433F1;
	Wed, 14 Feb 2024 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934288;
	bh=GuaP8Kmq3A9rbhJY9b1MVriZ9VyUEnzwnoFzYXaIvAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLZDE35Y0DwzZetKQFdMdmg0b11Gq+Y2G3424h4bKMeRF6zlZXXziaRW40x9i1gHd
	 SVqRyUOPzpFEi2oGuuEm/xiSeGTKN3NtcZawprWU4clP2qV8YIe1cfJb69I1wHQc0r
	 D4wV+AWgomNDjxdnb5GMPzm+fNS9eYTMlII7PlvWBhJ0p2nMZrs5EJs6LMUaWrTOjc
	 kjp0Gi08wQDYVdzK0z9lVmRoHX1THexkqNIjbRj159oeP89zcSaGWO5BzQasar75hs
	 ZqdWtNn++5ZOiajAQx9gLBeE22IZsXrLDpaiBF3ZUiGWrRhmxqsLeK8JiiUpdvRMt5
	 m2MDu7IBKqujA==
Date: Wed, 14 Feb 2024 10:11:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Leon
 Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240214101126.0c3681ee@kernel.org>
In-Reply-To: <20240214175735.GG1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
	<20240214175735.GG1088888@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 13:57:35 -0400 Jason Gunthorpe wrote:
> There is a clear split in my mind between:
>  - inspection debugging
>  - invasive mutating debugging
>  - configuration

Yes there's a clear split, and how are you going to enforce it on 
an opaque interface? Put an "evil" bit in the common header?

> And maybe "invasive mutating debugging" taints the kernel or something
> like that.

