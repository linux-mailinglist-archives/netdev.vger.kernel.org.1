Return-Path: <netdev+bounces-133128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1729950E6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9D81C212DD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1B1DFD9F;
	Tue,  8 Oct 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8dVngP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083D1DF97B;
	Tue,  8 Oct 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396060; cv=none; b=TVVgSRYvCedYMA4c1EY9ULhZTcEMouhJTwZQMPo2zswe0Zhm1eh0S1oN3Jb0wUItegz40k7cyG2TMFryeZLkDrtq6WgqcjWGiWcKbs5mWQRw5FXLBqJlnZPu6o9sGbFVphZWU1R/6SvwI9mmFefqD/Z85BStKPHtC7ZmatgALf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396060; c=relaxed/simple;
	bh=oUlvETPIslBMfpGeiPFduR8Vch9o4vI/LRvTHSRnclA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoW79Q1WkzuTG4yJb5OKcZpuR1XaExUxfYX0hhKdMqmdREPqLiWhYv9y0g6FIgsDo2EETmDct0Z3WE9gceHONnMXlA+Qp0UZoB8/xxghdPTfqwc8Fz33UvspdCPBTIkLPjnQdrcqu9OyOhduj3a8OLkFc0XamwC6RWxZODI1lBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8dVngP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FFDC4CECD;
	Tue,  8 Oct 2024 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728396060;
	bh=oUlvETPIslBMfpGeiPFduR8Vch9o4vI/LRvTHSRnclA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8dVngP0TMC2JMaeJ+i7Sew52E2W16OClMM7os5ABEDuBWb4Aa5xIzE3kKNpxMxIY
	 rlZJYClwbhXYHaeecYLqQhkXhkCcXEFflQIaacuqb8nS6tBA/DVpzupYw4mZKlRyDC
	 9wSBp8buFaUk0m8P+dxmJJoipkEtYRUSDw1oVWKDY/cRYRVqiAQZt3sWJWTpYYJu5g
	 3Lky+E+SDV56Uo4t8UHIorAqAu2RpN4ss65YOpHk855e0Dd1MgjDREItKlkCZf4Xnj
	 UjvwslMGjA0D3g3ww04wU8uMsoAJ3MhCufBGAghaDpmHj+z1BPQPyLH+Vcgsquj91A
	 EtoBf4DEokZZQ==
Date: Tue, 8 Oct 2024 07:00:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3] doc: net: Fix .rst rendering of
 net_cachelines pages
Message-ID: <20241008070059.67a47ade@kernel.org>
In-Reply-To: <20241006113536.96717-1-donald.hunter@gmail.com>
References: <20241006113536.96717-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Oct 2024 12:35:36 +0100 Donald Hunter wrote:
> The doc pages under /networking/net_cachelines are unreadable because
> they lack .rst formatting for the tabular text.
> 
> Add simple table markup and tidy up the table contents:
> 
> - remove dashes that represent empty cells because they render
>   as bullets and are not needed
> - replace 'struct_*' with 'struct *' in the first column so that
>   sphinx can render links for any structs that appear in the docs

I'm sorry to report that we got another race with a change to these
files. Thir^W Fourth time is the charm?
-- 
pw-bot: cr

