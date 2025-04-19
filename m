Return-Path: <netdev+bounces-184272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2731EA9408F
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 02:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE24219E78E9
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55556944F;
	Sat, 19 Apr 2025 00:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6OlUFSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17538B;
	Sat, 19 Apr 2025 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745021760; cv=none; b=Mm6NhMV8EyogTpY7kyziZY7KIwwUXKmdU/W6RVgSO7W6n7/Z0l8dVZw4c0M4KAR1Lr/vbYR7yNYn4Y+1Zvzt+Kwwy9yfP9nOl1LZ4JtDvnIpxQ1U39g1CptfnwM3WbOuYqZdPnhErhAudd/QHV23NjzDZQ87qlTUVVQhn3dNSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745021760; c=relaxed/simple;
	bh=t+MaYtn1K3cQ2n8quLIpV8MGimwm8E154EU7NwUc1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1cc5WSwyfHPT9e0VRXJkVXR3rjAIZTVg+7dedJ3e50rQfAUYSBLC4m9ECO80spR141v8iUOv+U6ukqreLZx6YIQeJB3Q5KdNRzRuez79ZQvpNm1lC3dkxuYxGwetsqJJNhQTTfrnd+X9sjY9AQdxSFadyUy6yPrzlt3kZ/Kj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6OlUFSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E0DC4CEE2;
	Sat, 19 Apr 2025 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745021759;
	bh=t+MaYtn1K3cQ2n8quLIpV8MGimwm8E154EU7NwUc1ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b6OlUFSK9OOMg5TBtqx6679hmIWL/wDeyxZ4Uxxz6Mz9KTVo3nNa858eaZi6YkDfm
	 DZqA3kJA0XIkAIfGHUIO/R/0QukJlskUWv2FPbTCJHfidg++XGD6XLKy+r9Z9wJmWw
	 DNjP4XThhMmPlSERAVa7H/vZ1RL2gx3cvngSDNj/VEnrAw6YoYkPsvGDbDpmTggyLP
	 4C7JJrolKStqea1XVj5StWztkH1BbeksLyAvKvsHiCilnk/4w54N8HEKWOQDhbQPKm
	 5o/OztavMPzb2Jg0E+bQ/P1J6ynSxVZARezA1IyeMvRt8pmdhOVbJniUnhmy/nMmzZ
	 gV/VgV7ndCJ2A==
Date: Fri, 18 Apr 2025 17:15:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Mammatha Edhala
 <mammatha.edhala@emulex.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Padmanabh
 Ratnakar <padmanabh.ratnakar@emulex.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ?=
 =?UTF-8?B?0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] be2net: Remove potential access to the zero address
Message-ID: <20250418171558.14d7c10d@kernel.org>
In-Reply-To: <mfcee4wujmaj4r7mkmd3xvmtjq5xl3varvhz4sxks66jid46w7@znt2ricbegc2>
References: <20250416105542.118371-1-a.vatoropin@crpt.ru>
	<Z/+VTcHpQMJ3ioCM@mev-dev.igk.intel.com>
	<20250417195453.2f3260aa@kernel.org>
	<mfcee4wujmaj4r7mkmd3xvmtjq5xl3varvhz4sxks66jid46w7@znt2ricbegc2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 10:50:43 +0300 Fedor Pchelkin wrote:
> On Thu, 17. Apr 19:54, Jakub Kicinski wrote:
> > On Wed, 16 Apr 2025 13:32:29 +0200 Michal Swiatkowski wrote:  
> > > > At the moment of calling the function be_cmd_get_mac_from_list() with the
> > > > following parameters:
> > > > be_cmd_get_mac_from_list(adapter, mac, &pmac_valid, NULL, 
> > > > 					adapter->if_handle, 0);    
> > > 
> > > Looks like pmac_valid needs to be false to reach *pmac_id assign.  
> > 
> > Right, it is for this caller and there is a check which skip this logic
> > if pmac_id_valid is false, line 3738.  
> 
> Wait, the check you are referring to is

Ugh, I'm blind. The fix is too.. poor, tho.
Why are we in this loop at all if we masked out the only break
condition.

