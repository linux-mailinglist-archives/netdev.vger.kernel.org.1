Return-Path: <netdev+bounces-79779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDCD87B5B7
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D11C2233D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9DEDE;
	Thu, 14 Mar 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW/IA9dC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288907F;
	Thu, 14 Mar 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375386; cv=none; b=Hsbu/Yg/ZdrQVl+Ll3ayqf9FIb0medf0nASAHABR551gPRB/gFOwlXZf0em4d1fmWOlaghtvJBQR47QVEFa7CD/XTYnWpWYjTzaX+ymCAsYbemUV06u2J2uTIsCMOaCoqDv53QjeXNOBmigSvKB2ArBILSIfz337cbYnygMSaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375386; c=relaxed/simple;
	bh=dOxJUDT9zNDA5U3eYyRohlYG5yAhqtjT6we4qhx17Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxLgnAvUO776+YjvrRqZrxa0gzd5YHJJTwsC4V4vMo6YTEF4/VzbuO4CkQsUtBHqcdiHUWtvDUtKT5QBD6fME7JgmMypg7XFebd2S0+oVhke2aR3QXoNaVTgT6XNdVLk2AI+tE/LGHr7wiQOOghWK7IXKJVWoVomWWUuIFcJO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW/IA9dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE1C433C7;
	Thu, 14 Mar 2024 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710375385;
	bh=dOxJUDT9zNDA5U3eYyRohlYG5yAhqtjT6we4qhx17Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JW/IA9dC/DlU5BhnKX4jtX2dcw5bjcs9eY8jvqoAb8A4BrcOu+b8t7c+ockNsd3J0
	 LkCBJ/f6yfSK8n3zwDeZE3qBl03dohR/30wr0K4jva4ewHE57s71XS9dPB/iHtcWOo
	 /rV7KqvcZotGP3B79k00hYMbSaxJyq9/vPzLufKQ2r3NFhahjwQ90WkjmzW8gz0KpO
	 f/GmNyUHzR6cHjLkl2TwbhYwajKfdge59jm0AvqPizJKHa048cjLMS+i1Cgd5Di1Al
	 RHtq2xmr+0EqLsZEUqEnXXbR/CKEJN97QVb0eKgCeX8an/UZjZ8UhHj7MVQf6evd6l
	 3nfFr5f0WzAnQ==
Date: Wed, 13 Mar 2024 17:16:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Halaney
 <ahalaney@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel@quicinc.com
Subject: Re: [PATCH net-next v1] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
Message-ID: <20240313171623.51ebb7bd@kernel.org>
In-Reply-To: <20240313235003.1354814-1-quic_abchauha@quicinc.com>
References: <20240313235003.1354814-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 16:50:03 -0700 Abhishek Chauhan wrote:
> Subject: [PATCH net-next v1] Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"
> Date: Wed, 13 Mar 2024 16:50:03 -0700
> X-Mailer: git-send-email 2.25.1
> 
> This reverts commit 30bb896b98fce7d823a96fc02cd69be30384a5cc.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Reason for revert - 
> https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/

> 1. Fallback to design proposed in version 1 to have a seperate user_delivery_time
> bit 
> 2. Keep mono_delivery_time as ease
> 3. Add user_delivery_time as a new bitfield will be a seperate patch 
> 4. do not reset the time if either mono_delivery_time or user_delivery_time is set
> 5. we will need a user_delivery_time bit and use that to look at sk_clockid

Could you please spell this out a bit more in the commit message and
add the link as a:

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/

in the commit message rather than the "throw away notes" ?

(feel free to repost asap, without usual netdev's 24h)
-- 
pw-bot: cr

