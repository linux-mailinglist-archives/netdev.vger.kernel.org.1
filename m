Return-Path: <netdev+bounces-155811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D17A03E12
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DF61884119
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6811E47A5;
	Tue,  7 Jan 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nabm7xR3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472791E3DEB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250280; cv=none; b=lEvOTPHbSrXrnjBJM5fRXqQ3K0fsxRhZ/5ePcBAZHNnas6MU7ExPeAQR4jaLLAxMqAcyX8Hka1j9NpowfOwnoIM1Jb/BoYE/nj3IMFRay7cjqsrrNy1qrn/SuCImkiQKn7a2z/3dmD5qY3bXazD9p57AfyKhegR+bqnxj/zPBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250280; c=relaxed/simple;
	bh=cbT9u3vii/4n1iUjhHh3Lz1Zrz0+q8eXNaMxcAXj2/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKTAPVBSA6uc/B+xZ2RaIVOLiaPDubB9anYobuoRRxhS90U4i9tezWx/9IxA5VDh714gn514fXAc01vW0qhBeIvnAtN1Z7Nm+IKq+OT3nAIFZN/uS99HLw5WEbK6yEyZtxy1L+Cp3YtHpzbFydMnx0znQPZtLcRZeJLDO1bmZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nabm7xR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3C6C4CED6;
	Tue,  7 Jan 2025 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250279;
	bh=cbT9u3vii/4n1iUjhHh3Lz1Zrz0+q8eXNaMxcAXj2/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nabm7xR3ipfzxtEVaeE+FWbvJsgrgoc6OCs1LrGJJg5F0mam6++0wOh34KoUy++x9
	 v60ydJzI3TXfkbdzr/F1WeJOiq8YbhaPBhnMVj5czZKwwTbDeWTMHrlC1eGyzBkDLN
	 X62RD0uudzR7kvaqS01Ru3iHutuABm6dL/pphw3g2Eil03O2Ka2LMW5ZDqmlRiDT6G
	 ciX5Yh7tZ70pKTCoapSxMfviKiVsdyJ9t2vjgoYajzS/gWKcXi03IJHj5fM70A8jNw
	 cwTAX77VLZjjuD8uPokraYyxHYTp3RV5qKaOd5R4205fq0HwwNGgK66LMSrbaRGdF3
	 9SQlKEyUQQxJw==
Date: Tue, 7 Jan 2025 11:44:36 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] if_vlan: fix kdoc warnings
Message-ID: <20250107114436.GG33144@kernel.org>
References: <20250106174620.1855269-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106174620.1855269-1-kuba@kernel.org>

On Mon, Jan 06, 2025 at 09:46:20AM -0800, Jakub Kicinski wrote:
> While merging net to net-next I noticed that the kdoc above
> __vlan_get_protocol_offset() has the wrong function name.
> Fix that and all the other kdoc warnings in this file.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


