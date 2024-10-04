Return-Path: <netdev+bounces-132308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D769991311
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F4B234AA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB691514F8;
	Fri,  4 Oct 2024 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw12MuJh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517313B7B3;
	Fri,  4 Oct 2024 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084875; cv=none; b=HtDSZqXjnDYjTNrziRBsckDngA9wccH24qPN+GGco79KbKotVokmUsUT0X8kBF0rK6eekvt39yB+dzdZgo9hYp+HOTXAdsSdM2Xgj7u2H1dfrB9tU4L0QXm9dSRGtO1Y8vmjD9LEUrEoAcSdjJ4eAyEphFVjw70k2260en0UOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084875; c=relaxed/simple;
	bh=Sqa43m+nbGZLCCsNqAhGNtYG2Q/CG2DqLjJ082+uqaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpFzu5mibVf7IBNYrU9XkDSjkt7r5ZepeHqfpTiSK7jSp9EPn1dSrSCMTVMtyK+EHN1GHezjWB8jv/2uJsE5OcTbYWf4S4AUtc0YV+Nr2O2GMoJ0hZKzHy1+IS2vKrQ84mlnbHQVg5jhkfqhshAMcATXZ/Zn5JHmnncjLu9BvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw12MuJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81BC4CEC6;
	Fri,  4 Oct 2024 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084874;
	bh=Sqa43m+nbGZLCCsNqAhGNtYG2Q/CG2DqLjJ082+uqaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dw12MuJhJwzd05wqyP7DQ+XmYWod5ivGm36l7tkkxur0xlgQ5sv3LnppyYrukaFnI
	 sggRQcDMig0Jg0L/OUJ2n6bJ45oJLk1q2kCo1kRejWBWG+eeC41Qq17O4oYXGu+MNg
	 XPH4Gd7O8BuiEucEkoWXhHlXUJPqph5lAowQz7pl0jzAn3DgXNN+IiJqLZRNAbBVvV
	 qX/sRQOHf+k85wB/OanMllrrNb5mBuob3eaHu+K08R+tFGJ3tI7meYK9xgAAIbrhMC
	 K2UBNh/eoJGl+rgQAGVla19sfUWrgFprtlNxA6JZRBtuMUs4pFU3/VOlWhKkzIU1pE
	 BuUrS4p8vUmtg==
Date: Fri, 4 Oct 2024 16:34:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 06/17] net: ibm: emac: remove bootlist
 support
Message-ID: <20241004163433.79ca882c@kernel.org>
In-Reply-To: <20241003021135.1952928-7-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-7-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:24 -0700 Rosen Penev wrote:
> This seems to be mainly used for deterministic interfaces. systemd
> already does this in userspace.

I guess.. but what gives you the confidence this is not going to cause
a regression for people? There's certainly plenty of machines with
"stable naming" disabled. Whether that's wise or not is a separate
question..

