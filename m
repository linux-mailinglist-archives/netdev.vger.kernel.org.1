Return-Path: <netdev+bounces-28949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E6C78136D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF72824CB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B791BB31;
	Fri, 18 Aug 2023 19:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D3612B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B28C433C7;
	Fri, 18 Aug 2023 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692387606;
	bh=ieteLVsMIxcVRNFh/sMw6Ea6C+wGGEv0a1ea4Trb7PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CYQ23CHDBXJC5EeJMBSm7MiNIsS/n5m5yNh2T8se0kb5bFpGoyfGoBgJLkOrvO+CM
	 t+UYY/PLl3El4LdJE4f2BXb8Gx6YTz0nZW8V9ARjqMAsuMlBrMDwcswUJCK/f2lBLQ
	 FS0w+c0nu3DKhWbSo/3SMQC5WuAMyiDE75OQIZEzEwZsZfrFpaJ2HPSb/yGqg294Fj
	 ERbphVDYQkOL8pTH2gR9yux12mWKHf/HBRp03XDkKp3e4zXEQV2eaDg+LQHTZnk9o7
	 PSUNJ40XRf6h4LJ5thSTl2zmHkh4iLGX8C4d96XtcNkKtZCSGw0G6ZUfu2KX9mZnQ+
	 5YQxjRNusraug==
Date: Fri, 18 Aug 2023 12:40:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.5-rc7
Message-ID: <20230818124005.20d90a33@kernel.org>
In-Reply-To: <CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
References: <20230817221129.1014945-1-kuba@kernel.org>
	<CAHk-=wi-DdiZu-zMfE3X5nx4i5farupHmJawz-My_Z2nk9Qkow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 06:58:49 +0200 Linus Torvalds wrote:
> > Fixes to fixes:  
> 
> Heh. New header for an old problem ...

Yeah.. Almost all the "current" fixes are just follow ups to the fixes
we sent after -rc1, I wanted to highlight that somehow. Highlight that
it doesn't feel like we're fixing problems which came in via -next any
more.

