Return-Path: <netdev+bounces-145495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E499CFAB5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2CA1F22D91
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CA1922F9;
	Fri, 15 Nov 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGLAR1nR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68214F9D9;
	Fri, 15 Nov 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711688; cv=none; b=J5uUx/5l9Idl2zRqXpuM5obi+Y1YYSKB9vFL80eyD2J4MI4XiJSucYBu2GMm9tY/cc3JUvBkBaRX0flDNiKhw0Zp83CkFKl0cfwzMtZLBPqhHYklVaDcJfrADvrOhxiVDpTIlj8j7nH747aSeNrHGNQe+hDGlcuIEdaMg0iZdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711688; c=relaxed/simple;
	bh=p/RkG74/pG6hdlrjw0YmxwjjhszMqIpeAw8p7yBufzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYJcYKRTtXu8WuDUAyMMZbynAll7MRhLpTNsAr5k9G1wQjiw0BKan6j8uZtg+QWHNeh1CvSUkk4l6F42bB3ESqy1toUUPTZEWk5wCDtDb1xoAOsteKBGtvFFn9f19wJXLlOrkP69+++b4ZXVmiytSsTjBukajkmUGuH6LDBDbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGLAR1nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96457C4CECF;
	Fri, 15 Nov 2024 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711687;
	bh=p/RkG74/pG6hdlrjw0YmxwjjhszMqIpeAw8p7yBufzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CGLAR1nRfhKDOpTAULm4nPHxY3m95yie9SR/2Dx2ykecTCwofOnxzPdqyHrVbZ2Zp
	 YtZyp2az5jBqGtdf2pvvq4uPxMlvJzvJljbsSboll2Lj5gPE/9z5ZBrndbNYgKL8VI
	 qxZigd8TsBI5WNhNvNdBAdTtyciOzaDJGDOU0I/REuIA3BZaZHrFDe2n8iyyBnZ48H
	 vSdGsS+w/+6CUKKGX7eHDlqxaLWwGFDeaVLmdS4fWH3lPLJM+M8AME8LsrwAcb1uAg
	 NFcVDV3+33FGCX3RCtxzeXOIQX8rd06qwnYB3+jc2rM/yiNvAuwe/3K/RaA8eHOyDl
	 avyOdjOhPCEHw==
Date: Fri, 15 Nov 2024 15:01:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 8/8] ethtool: regenerate uapi header from
 the spec
Message-ID: <20241115150125.77c1edf8@kernel.org>
In-Reply-To: <ZzfDnLG_U85X_pOd@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-9-sdf@fomichev.me>
	<20241115132838.1d13557c@kernel.org>
	<ZzfDnLG_U85X_pOd@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 13:56:44 -0800 Stanislav Fomichev wrote:
> > Looks like we need a doc on the enum itself here:
> > 
> > include/uapi/linux/ethtool_netlink_generated.h:23: warning: missing initial short description on line:
> >  * enum ethtool_header_flags  
> 
> "Assorted ethtool flags" as placeholder? Any better ideas? These don't seem
> to have a good common purpose :-(

"common ethtool header flags" ?

These are "ethtool level" as in they are request independent / 
do the same thing for all requests (as applicable).

