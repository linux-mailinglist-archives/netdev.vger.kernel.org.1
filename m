Return-Path: <netdev+bounces-238151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0FC54BCC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 23:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 711BA34748B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED591F8AC8;
	Wed, 12 Nov 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K21S2iSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2E13E41A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987572; cv=none; b=I7rGyBpHfALE60kRNArZZ9yNoWEbspKDHYhbtWQ+kheFRK6DwTfY+PCRsQz9I/dEVs3lLIOEGcr0+AhAsCdjb34KoijV1x758u2Nb3MOBuoGZWAJIq3OIQmz96YlBGHGR2EHvZEVn5z1I8lZS+VFkrvttlzLxJYkWtxElbeGDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987572; c=relaxed/simple;
	bh=1Dx1q6q6TYxI5nemNh5EqZTGVMmloVhaF9hzV+iKPGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbWohawNK+eHw4PT6Li3USknOTK9Ef7qxn0pZYlzWEAr4HUJkzh4VVacd2vEjKxrXJra1qoplYmPwWSYz2M70ablMdBk2S4lquS9S9Dz2oL3qxUBB5MXQxskrJ77QaEj1JRWERcP/0HurdJyamcZMQgUt5hXtd33pEVl6TeKkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K21S2iSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DDFC4CEF7;
	Wed, 12 Nov 2025 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987571;
	bh=1Dx1q6q6TYxI5nemNh5EqZTGVMmloVhaF9hzV+iKPGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K21S2iSETEHlEioKQ/n3sw7dVQcIblQ69tGc+Oot4hNez4i+kKw38mDdoXarJKPKP
	 CBZWgoWtaWftP32LaM1bzHOZSgMRyDpzLfRGDrfADYFeUmF8q6g/Ht0sJFHXuGHVCD
	 pn60+DAkKNyO4t0v7RkgXQVhmTZsg51WYtTNF8EFkS4/a48vDWCPf8b/442+yZC9a4
	 qHg5uF3VSnbY7Z1WHXIRId36DVpeeJl4RrJmv3xR8ruzcmL6HJueeDoNru+qSkyVry
	 CxAgdVeMJ7awj53dvwtNPlM3sKzw71bLA96NBmGq4XVSgXw/qdnF32I78TRgTSPWRD
	 hxApIgQVJPVHA==
Date: Wed, 12 Nov 2025 14:46:10 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH iproute2] devlink: Support
 DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE
Message-ID: <aRUOMli4cW7XlLFY@x130>
References: <20251107001435.160260-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251107001435.160260-1-saeed@kernel.org>

On 06 Nov 16:14, Saeed Mahameed wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>Add support for the new inactive switchdev mode [1].
>
>A user can start the eswitch in switchdev or switchdev_inactive mode.
>
>Active: Traffic is enabled on this eswitch FDB.
>Inactive: Traffic is ignored/dropped on this eswitch FDB.
>
>An example use case:
>$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev_inactive
>Setup FDB pipeline and netdev representors
>...
>Once ready to start receiving traffic
>$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev
>
>[1] https://lore.kernel.org/all/20251107000831.157375-1-saeed@kernel.org/
>

Hi, this was supposed to be marked for -next, do you want me to repost ?

The kernel part was applied to net-next:
https://lore.kernel.org/all/176286361051.3417146.8495442358677824245.git-patchwork-notify@kernel.org/



