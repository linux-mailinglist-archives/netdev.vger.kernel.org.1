Return-Path: <netdev+bounces-43728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE257D4521
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A409428163E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA06D3F;
	Tue, 24 Oct 2023 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYXbKlTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDF10F9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC4C433C7;
	Tue, 24 Oct 2023 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698112188;
	bh=7zvbU5oTPviUOA6ufHc9x4JMbBU8iZUomlQ0VXXYxBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GYXbKlTimeuOOFjyCDrgymhd/Ju1hdDh/telqutkknVJ2tWytBqnMUWbp1XUDSNM9
	 iZP5dC5MKFNM3qLa4PUwHuuXey99/EhGptt0P9cnQmj6AWVVvXO25A3Lj0sobdWmCl
	 uDyrn3YwGXpQ61zVV1Ck8EjoLWXlJTbo51vgn/n5tTh2dmlk2lvsYpgLsv2FrNVZQQ
	 DanXZjYnT9KTR8LsDOWCbXISTMeqP9mgZj80UuuPJRxNWCznqvcIQ02rKqeDuxkG//
	 llXUh8+LbEygnEg4ddqz/CCNFdRvfHdBAThm00sIe/bSa5ROXs9kD7G9ec9VA02WCI
	 W0dit2sV4Db7w==
Date: Mon, 23 Oct 2023 18:49:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
 syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, wojciech.drewek@intel.com
Subject: Re: [PATCH net] ptp: ptp_read should not release queue
Message-ID: <20231023184947.540eccab@kernel.org>
In-Reply-To: <20231024003457.1096214-2-twuufnxlz@gmail.com>
References: <20231023093334.3d6cda24@kernel.org>
	<20231024003457.1096214-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 08:34:58 +0800 Edward AD wrote:
> > We need a legal name for the signoff, not initials.  
> You may have some misunderstandings about my name, AD is not an acronym. 
> This is my full and legal name 'Edward AD'.

Is there any public person with the surname 'AD' you can point me to?
Or any reference that would educate me about it?

