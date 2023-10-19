Return-Path: <netdev+bounces-42623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB927CF8E2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC94282155
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E496225A5;
	Thu, 19 Oct 2023 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbwOMCSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940B224F9;
	Thu, 19 Oct 2023 12:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB288C433CA;
	Thu, 19 Oct 2023 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697718587;
	bh=MXuTYoWhiJr7Ev1aRTa8qGNL7Kx3FansRdsI17NX7Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbwOMCSdsRL2fpG8RdQEe+7eHj2ZhJPEJBlVVA97RLAGdbCJkX0Ny5+oHbSwaqIJb
	 Ajg1uXocMJzd0lS07KMgSBAQVbGKVlrozAf0ejNcTiBwKra1hrigCXUOUFvr+zfKC+
	 Qkagj6GXU2oq9gaeAF0NFWdqvg3UnsY3CrSsRREDP5N97jW7QoEyHiHbnD3Lts9JWK
	 xqZQo0n39Gp1es4Ylnwkjc0ei8fQ8RjDMI0WN8s6hq2mlxzAyRVuPXNu1obD7j1/E9
	 CswR/hnPX7mEO5DAlyYwAJ0jDcQT1rjRxSSfwSSH4093ySwxu1tXSATt0wBz+l4rru
	 5kuHqHaHWV8Dg==
Date: Thu, 19 Oct 2023 14:29:43 +0200
From: Simon Horman <horms@kernel.org>
To: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 2/2] staging: qlge: Prefer using the BIT macro
Message-ID: <20231019122943.GH2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <1bab82b0406a0206f8c85f7cc87e5ea554a9781b.1697657604.git.nandhakumar.singaram@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bab82b0406a0206f8c85f7cc87e5ea554a9781b.1697657604.git.nandhakumar.singaram@gmail.com>

On Wed, Oct 18, 2023 at 12:47:01PM -0700, Nandha Kumar Singaram wrote:
> Replace the occurrences of (1<<x) by BIT(x) in the files under qlge driver
> to get rid of checkpatch.pl "CHECK" output "Prefer using the BIT macro"
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Thanks,

These changes look correct to me.
And I do not see any other similar cases left in these files.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/staging/qlge/qlge_main.c | 8 ++++----
>  drivers/staging/qlge/qlge_mpi.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

...

