Return-Path: <netdev+bounces-96213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E88C4A7D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41611C22DBF
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64F7EF;
	Tue, 14 May 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKX9uw4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F21365;
	Tue, 14 May 2024 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646796; cv=none; b=mV5RlYsMu/gqHrQ4Ajp2iA9cyIYhhYJ+Icwnjz8AEdumbqt7NRtyY9rfnXRYjMGZKlbFO37OxEN/olHbo2mPKL7jLDvYSKrT6urVAw8AjHbIbxKr2EspSrbTedGomXbOFTMES7hTQC+F9BRtUUona9hxM1eZNzW7TJ0PhLAt8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646796; c=relaxed/simple;
	bh=lx8yZjJS6r5vrZlyzYsfq4bdwT/KN7OYEyGeSe3S9PE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B1A5W9L9+6lQOkVDc1WngqbmwDKXCt/sPqKkiq+kh2V6auVQsMd85yrXcaMekDXqM/NG3DQwSRCJZLKGpOpogVrLlb/BKinsFEIjyoqj5G+0r5ILJL2/OgQ66kdfPdhfSQIR+cKE7Lb4Xtk1DjgQ+tv+2PS8GUm13+QxvjBP01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKX9uw4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B433C113CC;
	Tue, 14 May 2024 00:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715646795;
	bh=lx8yZjJS6r5vrZlyzYsfq4bdwT/KN7OYEyGeSe3S9PE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TKX9uw4Y5lW8JGWhx5LP5UTypDsdGKUNTiP/EPqytsyYUpf5piSwxwc8JdAeKVCQB
	 1/fCobKgYS3Pd/8+I6i0cLYNiiy5WPoM5Yv23fuWA0g+L8xedYGRTRCcQUJFR4TYR9
	 gB5HIDEPSGFl6zvYOxkXqUI6GFhrRdXC48sYR+IupE6v44+uuvm1wcOvgbF0ZPimAk
	 16uaZXtqrVf2qCBwcUEbzNKpTA6D1y7EssjDzVrDyOKLDBy3T1c0pkq0bWQL1TkXBw
	 aN1teOX+eYkutA+T/1BP9Cm+9epqt8zRZNo414bwYQN4kdiCKu+p7Wc2QtESlb3qAe
	 RW8+b1+Oy2Shw==
Date: Mon, 13 May 2024 17:33:14 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
    Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Gregory Detal <gregory.detal@gmail.com>
Subject: Re: [PATCH net-next 0/8] mptcp: small improvements, fix and
 clean-ups
In-Reply-To: <20240513172941.290cc5cd@kernel.org>
Message-ID: <8829dfe5-d05a-4103-34af-90f0434ef390@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org> <20240513160630.545c3024@kernel.org> <f60cac35-5a2b-16cf-4706-b2e41acfacae@kernel.org> <20240513172941.290cc5cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 13 May 2024, Jakub Kicinski wrote:

> On Mon, 13 May 2024 17:24:08 -0700 (PDT) Mat Martineau wrote:
>> The conflict here is purely in the diff context, patch 2 of this series
>> and "tcp: socket option to check for MPTCP fallback to TCP" add cases to
>> the same switch statement and have a couple of unmodified lines between
>> their additions.
>>
>> "git am -3" handles it cleanly in this case, if you have time and
>> inclination for a second attempt. But I realize you're working through a
>> backlog and net-next is now closed, so that time might not be available.
>> We'll try again when net-next reopens if needed.
>
> Your -3 must be more powerful somehow, or my scripts are broken because
> it isn't enough on my end.
>
> If you can do a quick resend there's still a chance. The patches look
> quite simple.


Thanks Jakub! Spinning a quick v2 right now.


- Mat

