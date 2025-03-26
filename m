Return-Path: <netdev+bounces-177717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE4A715FD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2381894A76
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707F1DE3CB;
	Wed, 26 Mar 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjROzI2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F51DE3B6;
	Wed, 26 Mar 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989357; cv=none; b=E+138G5L5fzAi26a+1LvWMXvj0ZowJgzPtm0OKvHfn7MDYadefRwh35qT7yaHLFkAgCN3dUdxTMgFA3/Lq0VyPfbTlWQK0fizbs+zOVfWUA6eOhKJU5i4qQcopP+fJ4yZBDZjm9SmPgwvQv2WTExzTTVcelAJgd4P1P7288UNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989357; c=relaxed/simple;
	bh=/RTvibMlmWLVnVqFzS7VXMQU3c2Gw2IB38LgTefVjnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBcA9Nmg+Rpg4cEoWkwWl2rS6lwce5y/0s7v0ofKyEmldmmuPxNgPk+OEGaeGcKq4eQ+0hhbXJKjR8p/cefiOifCroeDCX3wDTm8rdBuUp/EA2Eue27YFPiytgcGWOCM5d4uo5cUTeb252A7pitQh3IOGWLR7LlRIW4scqIVITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjROzI2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F7C4CEE2;
	Wed, 26 Mar 2025 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989357;
	bh=/RTvibMlmWLVnVqFzS7VXMQU3c2Gw2IB38LgTefVjnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjROzI2DxzVyLjTkUlN0Akoaw0HJdPuZUdkamPV8FrkfeweNy2NUtQ8lqHf8q5vL7
	 pDUc8dpLHbiG+AwEDxc0qlZb/eSAn8W2ayhEEDD/gKCYS0/qvle4DOb+3k2nvi2Vs5
	 KRtSynhUNHWsfhgQzMRnU75bs8yy5xu/zp2UniU/ITpvgwAN7FXx4wdKe17VnMVNuw
	 +8LB6eMp2jvBzcc7NahbdtZjwz9kXr13m4ExreKW0sL16I/GeXwk8qTzW8Qn103RGP
	 hi/ks9IDktyZtVsGYUsmfzfzYA/7oVjLS59/XWmneZQ1AmPEvhuuXYokmAAfeMqqKY
	 1iFFECp/xly4Q==
Date: Wed, 26 Mar 2025 04:42:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2025-03-20
Message-ID: <20250326044236.7133b0ae@kernel.org>
In-Reply-To: <0abd9752e86a9cc4e7bdf544a6eee9192c57f69c.camel@sipsolutions.net>
References: <20250320131106.33266-3-johannes@sipsolutions.net>
	<20250326043427.3999be11@kernel.org>
	<0abd9752e86a9cc4e7bdf544a6eee9192c57f69c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 12:36:31 +0100 Johannes Berg wrote:
> > Not very urgent but doing my "pre-PR weird arches build testing"
> > I see a lot of:
> > 
> > make[1]: Leaving directory '/home/kicinski/linux/build_csky'
> > In file included from ../drivers/net/wireless/intel/iwlwifi/mld/mlo.h:13,
> >                  from ../drivers/net/wireless/intel/iwlwifi/mld/mld.c:17:
> > ../drivers/net/wireless/intel/iwlwifi/mld/iface.h:169:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
> >   169 | #if CONFIG_PM_SLEEP
> >       |     ^~~~~~~~~~~~~~~  
> 
> Yeah, I apologize. We had this in the robot for quite a while, but it
> either slipped through or it managed to not hit it. Arnd already sent a
> patch for some of these, and I thought we also already had a patch for
> this one. I'll check.
> 
> What's the best way to get it to you now?

You can send it with the next PR, I suspect it only bothers people
doing build testing.

