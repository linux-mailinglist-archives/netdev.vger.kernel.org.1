Return-Path: <netdev+bounces-133836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E09972D0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3B21C21EC6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016E1E1C3E;
	Wed,  9 Oct 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Q/T7vc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FD1DF726;
	Wed,  9 Oct 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493993; cv=none; b=Wcrn8JLb9ysAKmkCCU3LnlqCaQapo+qP2KdHsEc9WFCS2pk/l/8gcVblnxsFa41VyemoRZRwQxsSmQWJoyyvrxdqdafeS2Vgiwf69UH/DkzxeVBeP8+kKv+RFEAnCCXc/SrFYTvLWZshMuSOWtvhZyt8SNBG15fUz9UkMUFaYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493993; c=relaxed/simple;
	bh=89jta2fvzrpDXpfWZlFL3OvXWnIwmmKUrmSeNzkTpZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUfR1Jm+D2sqqMgoHrqrW9Sw2KmJhKRc38lPeeEmhpRlygUfXVMGCnV1tWGACG7XWU3T7LXjPcjuLF3MVh+Q0AtxEHhRXUnyM+VlqI6Vk+9Q8ekaHgW3qo+yh5Pe441isCcxdRe05FYQVsiTQjm/GbyKSzp0VeyjgSQ6tN0j+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5Q/T7vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25496C4CEE5;
	Wed,  9 Oct 2024 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728493993;
	bh=89jta2fvzrpDXpfWZlFL3OvXWnIwmmKUrmSeNzkTpZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5Q/T7vcXRwBllk8ztqkzIbhDLhTpoONH66OGyY2g1SEec5+Bu9r40COKHCckqq+6
	 QcrssDSk5g10if/H3N3MN60Fd1bfIDA9QP2SbN/jjRhlekwqOWIvzDRAtUXutwvSBa
	 Je2WLNeAajUUa/Q7/kndB0cb1x2hxYHI+PgDxqR/dVNm4WTCQ8aMt3luAXaqpAfmvU
	 CleoXgzPPgliUXvdqxMOEYMoeJMf36SMRYaVkKYE1gADvFBQyCJTHJdNcD+Sfvy/ax
	 +0b57YXgRr/Qn2CyGsLSkNjbAD4UrtUZEdILaGOs7TnVMSAyOSN7z+ATsknUpOfX1V
	 lM9H42AxPTy5w==
Date: Wed, 9 Oct 2024 10:13:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shannon
 Nelson <shannon.nelson@amd.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] netdevsim: better ipsec output format.
Message-ID: <20241009101312.120f8919@kernel.org>
In-Reply-To: <20241008122134.4343-1-liuhangbin@gmail.com>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2024 12:21:32 +0000 Hangbin Liu wrote:
> These 2 patches improve the netdevsim ipsec debug output with better
> format.

Hi! looks like you need to adjust the rtnetlink.sh test for the new
output format.
-- 
pw-bot: cr

