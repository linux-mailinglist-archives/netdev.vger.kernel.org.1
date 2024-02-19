Return-Path: <netdev+bounces-72969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE585A722
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C922B1F21392
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684E38396;
	Mon, 19 Feb 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUsanN4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD338384
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355627; cv=none; b=cfBsIZdQuM0DBMBC1NSiQ+iAUKv7F1ukBL7FLDoKkS9yaaiHr+Ny5DF8QlYNCDpEU+BwKZlIxbfL40lVXH+/wZ7ChTLjsiI18yZ5Xft4yGoWabet96lLjCe1qIVEWG6M7cVxtbUE2gquhfMCbXD3L7qfIqQgd7kLKl7fKXVm1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355627; c=relaxed/simple;
	bh=mr1Fq8VNnq1VArTEap7T4LO/GJYjJ37FCNwtTTv/Ync=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKDbPzdVmTuzi95zri3lAVnFTH9++eL//SCPB6ZcLqUheRXLo3+SR8GDk6Yd3UdWYuP1idCeSicV3JzkLhklEgdzumrSNwY2HEM7OhvxP0XYVlbcMCdVOQ0w8OYwVNUQLtZH1eNSmVHUuV/2877Q9oD4RJdzWiiqK+UDHEtUHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUsanN4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093CC433C7;
	Mon, 19 Feb 2024 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355626;
	bh=mr1Fq8VNnq1VArTEap7T4LO/GJYjJ37FCNwtTTv/Ync=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUsanN4yBrsUwekBi2YIKsBjdXZ0ygDsiT3ECA3rjLw2+Y2qc8J/LAdlStJJVhAvc
	 fOBgySDpa7FSzCSIjZgxnwsLKHjmHVrcXoh8lyAblIoMrzmjmwYzFCMrZASmsIhGmD
	 kkTiA36GwIa+FHi9RLeCVLQlwCo7TgZiwQycwjoEXWnqH2IRAuC4XLwscUWK7qyk9R
	 Q5bstaee68AeA814RmUa/7WdfBizLyiN+2wkU7pZF6S359MqwY4QsnGjBo3V7xNTq5
	 fpTav6C8FXpvR7I5oikPrXDc3BHCabKu8shIJv1ratLiM6iR5iXDB5C3s7AGHHKnlM
	 cEQKt3NnfGEYg==
Date: Mon, 19 Feb 2024 15:13:43 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next] devlink: fix port dump cmd type
Message-ID: <20240219151343.GC40273@kernel.org>
References: <20240216113147.50797-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216113147.50797-1-jiri@resnulli.us>

On Fri, Feb 16, 2024 at 12:31:47PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Unlike other commands, due to a c&p error, port dump fills-up cmd with
> wrong value, different from port-get request cmd, port-get doit reply
> and port notification.
> 
> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
> 
> Skimmed through devlink userspace implementations, none of them cares
> about this cmd value. Only ynl, for which, this is actually a fix, as it
> expects doit and dumpit ops rsp_value to be the same.

I guess that in theory unknown implementations could exist.
But, ok :)

> 
> Omit the fixes tag, even thought this is fix, better to target this for
> next release.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

