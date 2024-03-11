Return-Path: <netdev+bounces-79274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86B87893F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10BA1F2169F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EF455E75;
	Mon, 11 Mar 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTzsQufX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2E52F82
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187627; cv=none; b=k0UJLwPg+eweGLA/QtKp9EqtNknE5epJq0kXWyzMqcTKjSNSaPiH4Rg7Egemd1TQyORw2ayEb6b+pJUVywIOaHIdvszwdnJR8qwjKyGVjImh/Aq3hePmXTa2XZe8RJHVP2qYnEJNdAGSgguvYqwvndBy7ZMCSX2+T5p0bn6hyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187627; c=relaxed/simple;
	bh=QVKWXgA0QWWVBfoVKKqIeGVnlJ8LxVXtsJRm9NNd4RA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qS3ABHhOnLZ5IEQNlv7YNrM2LH5UB+HMG/Va8iDaancKZYSSJSSUMU7TSZcdHNp5G1ohr4obBNM4bpjuSDcloCEUDHtNWp3/LBuPphePt3sXlvq2zzgd23EaxKP2yPYzW581VZ3c8/Z2iRjkcUKdlWKpftte9I5uP24h0LWR46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTzsQufX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B200C433C7;
	Mon, 11 Mar 2024 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187627;
	bh=QVKWXgA0QWWVBfoVKKqIeGVnlJ8LxVXtsJRm9NNd4RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTzsQufXmc/jjD3JdsGut8hICP1FiSueHvrDqnoHOu+BTRY0H60w7/DdNLs6YFA70
	 fTyc4eiBi5wmoo1fG9AmTpgFeuuYiRqAqckh7aRR7za5U8rPJZ7vEYXDfcY1D4OQ+W
	 s/C39q/R89k+KL75oRR2DLsDYIj3yuGehwfWjaU7w6BGrfGuBnEaDCy0EAb8R/mamU
	 3yenXZS4j3B3msUVGxkPEQt1sTmUX3sOna06NN0SnXHmS0q4dKvWFILrZsGZfgmn7z
	 d81NTE7oXIbP8pvJKERJo24KXzlXvhX4rwxVb3YrBtmer8WdOIHZCzJ8US5ppU3uo6
	 V9Za2Afa5NcwQ==
Date: Mon, 11 Mar 2024 13:07:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] netdevsim: replace pr_err with
 {dev,netdev,}_err wherever possible
Message-ID: <20240311130706.09f35fdd@kernel.org>
In-Reply-To: <20240310015215.4011872-1-dw@davidwei.uk>
References: <20240310015215.4011872-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Mar 2024 17:52:15 -0800 David Wei wrote:
> -		pr_err("Failed to get snapshot id\n");
> +		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to get snapshot id\n");

We seem to use dev_err(&nsim_dev->nsim_bus_dev->dev, ...
in quite a few places after this patch, how about we add a wrapper

#define nsim_err(ns_dev, args...) \
	dev_err(&(ns_dev)->nsim_bus_dev->dev(dev), ##args)
?
-- 
pw-bot: cr

