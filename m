Return-Path: <netdev+bounces-190477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA1AB6E92
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11E17B6987
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A818B464;
	Wed, 14 May 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKRnJVaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911B8488
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234328; cv=none; b=RAcA6QeyRh6G/kPJ4fuH769vkdcjhWSduwJqBNVy3gTK+s8GwW6tAbYk5ygauQyGvfQLbKaUyPzIDdfwtRnx+Is2pjXM64qOC3gVQQKhJrcZeyAJLzOK06q9sK8gf0MmIpwc6GjGr74RyZhuJXC+xkyNgiMpFfnrJ7M3FAfUjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234328; c=relaxed/simple;
	bh=rquebaTipzbEAVvhn3xYdguNP5Xj7zROGM2RVkYnSMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbQ8RJ0dZZNfyMe7SQzDfNO6feXg/ANg3BldIqNiG0Y9Fmd1b3+7WWM9e3j2jt75I/t9kPcnV5NbfpxSxeHuJa0opb4HxVlzTsNWG+mqAdhRysxLiLerrJbGeZMY7piy8vXk96ofDb8vzYZbsmqL4FKL92vECJvmMPUKEaJg2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKRnJVaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05BEC4CEE3;
	Wed, 14 May 2025 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234328;
	bh=rquebaTipzbEAVvhn3xYdguNP5Xj7zROGM2RVkYnSMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKRnJVaPKWo4iQI7giw2pqPnGWQX+qTquuDGMcGqvAnTiCvznQfNfAmSjgJUspGPG
	 GzB4HUxCdKHpXPlBATcDb32b5AYeajGT+LP9NKHjyBRTsSJWLOlnJyGVCM6yI8YPwS
	 FM/gV3EAEBCFL+fPHQp2DT2OJhuEIK8m0fq15aJ+k/ZQq30aMxh43aue8qpcLeyvj1
	 I1sYHlJTW+U3nzMOD+8aJnnd5JJJqXFCVLev6Y8YdMb4v1ipe4LqvrUiU2GysSaRLZ
	 RGdrYAJggFwZ76CO1evbJTGuTruhhiteGbF3/iQ7VGKhPdJ9/5O85NHcaeHUoKWsw9
	 WnEsq2QXcZBJg==
Date: Wed, 14 May 2025 07:52:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250514075206.0035347a@kernel.org>
In-Reply-To: <da372ddc-bc00-4e14-bcd8-4e9c607cc1d8@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
	<20250428111909.16dd7488@kernel.org>
	<507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
	<20250501173922.6d797778@kernel.org>
	<d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
	<20250505115512.0fa2e186@kernel.org>
	<c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
	<20250506082032.1ab8f397@kernel.org>
	<aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
	<20250507174308.3ec23816@kernel.org>
	<bee1e240-cc6a-4c30-a2ae-6f7974627053@nvidia.com>
	<da372ddc-bc00-4e14-bcd8-4e9c607cc1d8@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 15:01:40 +0300 Mark Bloch wrote:
> Just checking in, have you had a chance to review my earlier email?
> Would appreciate your thoughts or guidance on the right path forward.

Based on your previous reply I'm afraid you don't have sufficient
understanding of real life deployments to be extending this uAPI.
Or you're not telling me something, but I'll go with Hanlon's razor.

