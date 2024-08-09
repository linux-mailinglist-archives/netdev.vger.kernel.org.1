Return-Path: <netdev+bounces-117056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3871B94C89E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EAF2866D7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5B179AA;
	Fri,  9 Aug 2024 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqkSXhSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188712E7E;
	Fri,  9 Aug 2024 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723171617; cv=none; b=OtxgS+bXL6ATI7w28Gt0ZqABD2MzP3shSbiTiTO1UMRiWnXADr2uLBFb+LaSTS9h7AQfTW+p7j/RJQLwiZyofT+jZJGAcgZ1lmOYN8ZaLF2TG2Jw7DDzpLwMYwL/83c0P8YbTVf2VfHdvl2i6LWjusjG71IwR11v2vwbBSS2eG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723171617; c=relaxed/simple;
	bh=7OYiaFX3f2hew8PTXVyqkX4SBRUHmw6Rjqmyg8KCDNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiK8MuVlKZo2C4EPBZ/GkBYKwC+Ejzc+io/EU8P3hMWi0ZPDpFdWB9xA8FL7kQcY8SGiByiSKuDUz6Ul33vni8MiKJeJI7fFMMtAh4tsW837h1k5Nq+Z0tRRfVGqxxSlG6vZ2Fa5KxL+FaLEZh9qsAOBZju88ujWcJnw3StCvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqkSXhSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59122C32782;
	Fri,  9 Aug 2024 02:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723171616;
	bh=7OYiaFX3f2hew8PTXVyqkX4SBRUHmw6Rjqmyg8KCDNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqkSXhSQwTXSk7Dvech93FF71dr7e0yCLJiOntr1XDmPHykG9gbJh8daVhhgqrAE5
	 ff8+rY8ES3KkIp/df/uOmEKes5GsGWKjQ5+ZUjjXVBBctHGBYoTeG5hthHx0ra6VFF
	 pbcRScwGkYvMdgE1YxY4FKj274rKbT3wYgzoJggzfEPAGOZ4qcrn0boIxFuxo5helW
	 xmeTdFnlxMuLE2g0kwKd9S/tbxwIaJWNPOS5TFYIPzkqz3fAQuz35/Y777f5aF98hR
	 WgwT/bJdlMXtW312K7F5IxU9ZiVBUspk3gO/nS0w9m8NGhiAwh4lamd3zC4+iAwP93
	 l4CI/IG4QXqXg==
Date: Thu, 8 Aug 2024 19:46:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] sched: act_ct: avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240808194655.6bd39d2e@kernel.org>
In-Reply-To: <ZrDxUhm5bqCKU9a9@cute>
References: <ZrDxUhm5bqCKU9a9@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 09:35:46 -0600 Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct zones_ht_key` is a flexible structure --a structure that
> contains a flexible-array member.

I think the flex member is there purely to mark the end of the struct.
You can use offsetofend(zone) instead of offsetof(pad), and delete pad.
-- 
pw-bot: cr

