Return-Path: <netdev+bounces-107065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485AB919A23
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF5280ABD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173CF19308E;
	Wed, 26 Jun 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0dlHBcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC3180A7C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438837; cv=none; b=OkTHHXO0Q/Gu7hRHeObUkGBkMtraTHtPFdr0sMTxqzo0G5lLJF5g8blJvld6IZGZhPcxvJ/nUmOheGnNLyCNcF2ZcVXIe93fN0/GxYeWJq5xcCeT574iKELb9WFl4hcm5by2m6uXBw0+VQBvGT798uqhJoAiSwByNX8niFiv+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438837; c=relaxed/simple;
	bh=h+AeWvKwAryXrkyxyRsbMX1Hn/MhwmeaRrQlbtumom0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBmWcX4vP8rTn4PrIFen0hgMJzz2vqvRqmZ0IKx/U1uMn0oxlsoV242Vmgv82RlZu3Ny6Mn3DbEFRGodjF11KiJ5SqTfC+eae7hwIv+fGC/pMlBc+Uiqienv/kCRUAHhwGxZC3ohONNFu0iHNVd8NvglLAVpB7QeSoBiZjZ2T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0dlHBcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFDDC116B1;
	Wed, 26 Jun 2024 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719438836;
	bh=h+AeWvKwAryXrkyxyRsbMX1Hn/MhwmeaRrQlbtumom0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0dlHBcXvNrFf4+yrmreq9ozOehv9AVVOGUtn9abqU8gfpXi9R44TJcBDHofuCzN7
	 +CgBYqXe8kCkvKkYpO9mrPcawoCDAn4MLKVdQV5zYfb2ndEktSb25YZfKe0QXuwmCY
	 /KQ13W57z2SrB17nAi6Rfq/ISFMuoi8RGOQyAK3DNJ08T8yp4zW4f3LtpyT9mGKaAq
	 5YKb+f5qkf9WoMsZ7az4pkpmnnKlqCaJd0pD+TUXtTk6Ryw2F/a+y383z2opvPGqzM
	 rCx7JMbBECsyz1jeGOB1DJekoj9NNPsn/tU1ZTpeZJQIZiMGT7OxPkxisjpQNviG8p
	 ob2TPNoexcEgA==
Date: Wed, 26 Jun 2024 14:53:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen
 <amcohen@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <20240626145355.5db060ad@kernel.org>
In-Reply-To: <20240626075156.2565966-1-liuhangbin@gmail.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 15:51:56 +0800 Hangbin Liu wrote:
> Currently, administrators need to retrieve LACP mux state changes from
> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
> this process, let's send the ifinfo notification whenever the mux state
> changes. This will enable users to directly access and monitor this
> information using the ip monitor command.

Hits:

RTNL: assertion failed at net/core/rtnetlink.c (1823)

On two selftests. Please run the selftests on a debug kernel..
-- 
pw-bot: cr

