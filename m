Return-Path: <netdev+bounces-112899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB693BB02
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59061F21369
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9111CA9;
	Thu, 25 Jul 2024 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+DV8jG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFFD2FA;
	Thu, 25 Jul 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876304; cv=none; b=s3strCT49loM6gbGkLzt9giTESleQ9kl0o+e+q50eNKP72QfB1mK/6NHl7GOib6MrdBVbj8KQYfhSSE0Cj+sFhJ1IroM2YrdrkTPiFE1cQj2u9PWmQYkRIOat10f/xlTntA8ga2cUWmxX47lZkK0lWf/6wiE9VXYXQ2AXmzs3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876304; c=relaxed/simple;
	bh=IYjllJKH2w5AnZyzP/00fcyK57E2jcldpEKpJ1pqFaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Njy5y9VK6QeSfYtyHdAWSqCJwTrBYlMiwR6Au+PAI4XVqWf5FUM0DAbhOsBkCMTu5Py1XIn0bUreksCPJXF4JFrA1CFh6YqhtSikM0bvK5ll5fC9Km8lL0s6hBy/U0hjX6T3GOIHmg4j0WS8e3KqRWC19Dg8wA6/Wqr9OPpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+DV8jG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70471C32781;
	Thu, 25 Jul 2024 02:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721876303;
	bh=IYjllJKH2w5AnZyzP/00fcyK57E2jcldpEKpJ1pqFaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+DV8jG/0PvodLQjan0/wVzqpEBKt/NGQd0U4XFqggxHPYnxzLCEaoQn9MJYRC18D
	 FWOzZI8goM71cZVaCpwwVljKKdxOZGR292StUp7BNrNH3I8GLMKTZmbdtUiG8XW90d
	 P7UxkpAv4zrnAEHNvq6GEWj53JubD/41D89XuVaNx5R/1p7XECh2rsAcziPakNUNKr
	 sQ5hmJYzDp45a09bkk/Q3+M/u9927I1Z9iTNULppOevCvfGh+JSK/UVp4gtsR2n2oZ
	 5lHEVhZgYS7oYXHgzL6oxLVU+MomCIP4GMFNMjjMHPiy2u+TjAUvR+Ny+D+fBL7jpG
	 fRLrA8N0QRxUw==
Date: Wed, 24 Jul 2024 19:58:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+90fd70a665715bd10258@syzkaller.appspotmail.com>,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in nsim_create (2)
Message-ID: <20240724195822.6f0388f1@kernel.org>
In-Reply-To: <CANn89iK3061x4Q9XA_uUHvTsfeVXSOFVpFBNh1jG8=ZSG+1eag@mail.gmail.com>
References: <00000000000027b189061e021f49@google.com>
	<CANn89iK3061x4Q9XA_uUHvTsfeVXSOFVpFBNh1jG8=ZSG+1eag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 20:28:09 +0200 Eric Dumazet wrote:
> The fact that netdevsim uses a sysfs file to add/delete netdevice
> seems unfortunate,

Let me not point fingers but agreed, and the original implementation
didn't :)

> because of the classical sysfs vs rtnl issue (see rtnl_trylock() calls
> in net/core/net-sysfs.c for reference)

Is that any different than binding a physical device via sysfs?
Modules have "bind" and "unbind" files, which lead to probe/remove
AFAIU completely inline.

