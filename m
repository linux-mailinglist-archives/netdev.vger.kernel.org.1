Return-Path: <netdev+bounces-244032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6419CADEFA
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B0A304FE8E
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF21D416C;
	Mon,  8 Dec 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpFQcHXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C855883F;
	Mon,  8 Dec 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765216015; cv=none; b=XHZyBUnbzXItRV+HT9dISAmkMEeHmRA/Wai/XbmtaUJ3i3tunp451jMddwHtP2axG2iFdjzbppbFZs1uMz+lMvyjyKaIfAkmbjFg/umJZnQILIJ0cg0eiOgiNMVGEGtobWW933AsBmgvpHg4PRFG5UQJ0kRySjIfNGYmbOyA5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765216015; c=relaxed/simple;
	bh=lrtC04Hq6yc4q9JeQsBKspd5vfd81itQLGxXAafXFX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4l1ibCp/ETgBDVpw4EUuoUYElgiH6hZqZL1oLb1CwVXwInK30lZBz4ojCBa4G/TIiGhvhDYA8MB1kH0nDv+uJ4FPY63CH9WU3jDXv671WwONCR/CbdXWW0ywh8qMtUq0i1JnXDgyco9prIYOslYf0MKg9IK52oBiJuBZXeHy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpFQcHXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D48C4CEF1;
	Mon,  8 Dec 2025 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765216014;
	bh=lrtC04Hq6yc4q9JeQsBKspd5vfd81itQLGxXAafXFX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpFQcHXqCrlIE+zRIbAvx2AxM6M+lxFbKG5c4VkiRfRqw9ErJ6vI2fy1m4Z99ateP
	 RZXhoBDcVC52K3ukNluxbYY4fGF1mx65IWCmz0piMsTybjHVNFjNLsbpQhCus4Qf1x
	 XP26pvng1KtiYYisTTJobFSvAyBsYYj/tQ0WzteHPkjp13sJXp1s45T6sS6Aw8BQ4a
	 XUPVM8mv87jqJxcqj3L3cRCbNbOWNpMOjtfGkSdocNuyfSXbuodSPW1GU1QbVsiS94
	 bHA6ht+2CwJaG/k4zlWi4jmgFgFZHgOTHUA0ozmQG3lxol9d/y42aN4dH1LJpDrjl+
	 NIEVtIO0GxvJw==
Date: Mon, 8 Dec 2025 17:46:51 +0000
From: Simon Horman <horms@kernel.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH] net: atm: lec: add pre_send validation to avoid
 uninitialized
Message-ID: <aTcPC64WcM3S2SQE@horms.kernel.org>
References: <202511281159.5dd615f890ddada54057@syzkaller.appspotmail.com>
 <20251207041453.8302-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207041453.8302-1-dharanitharan725@gmail.com>

+ Edward

On Sun, Dec 07, 2025 at 04:14:53AM +0000, Dharanitharan R wrote:
> syzbot reported a KMSAN uninitialized-value crash caused by reading
> fields from struct atmlec_msg before validating that the skb contains
> enough linear data. A malformed short skb can cause lec_arp_update()
> and other handlers to access uninitialized memory.
> 
> Add a pre_send() validator that ensures the message header and optional
> TLVs are fully present. This prevents all lec message types from reading
> beyond initialized skb data.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> Tested-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com

No blank lines between tags please.

> 
> Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057

Likewise here.

> 
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>

But more importantly, this seems to duplicate another patch
that is under review:

* [PATCH net v3] net: atm: implement pre_send to check input before sending
  https://lore.kernel.org/all/tencent_4312C2065549BCEEF0EECACCA467F446F406@qq.com/

