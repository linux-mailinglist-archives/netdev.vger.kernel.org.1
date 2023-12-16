Return-Path: <netdev+bounces-58166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06517815641
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA31C219C4
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33C15B9;
	Sat, 16 Dec 2023 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeOGuwZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504115AF
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160CDC433C8;
	Sat, 16 Dec 2023 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692505;
	bh=FdOMlRrbw6WEPTOY6OyEmFTSLcPkkxbb8YZNutNWY9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aeOGuwZ/Vwpg5b51/bLvBh05mxBdiDNEH7VBTv8D1oPito+wsJ2qteL7DbRdNzzzX
	 LQelTvqkYs9IaPC10bYeVQMaWql2Yn1IYeSe3Qcjo08d61KXKdDbPknzszdy/xmf3k
	 b538K7x4Hkg1Vr+jZihoH7q5ghi4c4dHs+8Q9LEo7FT52TXcdSJiKq0H4FQd97lQFV
	 kfFdjblw9U7ajYLhhHPG5wCTFyCq5JnV+KGXZ16LoLVDUN1cZcI+Ps+EgzGE//1d/6
	 +5df1MSZsmunNphBfNbaiuu1C0Fc81MRrshaHWh2VodBkzAg/EIJtYj2yfPYh9ez2q
	 +XryEJgjVIYnQ==
Date: Fri, 15 Dec 2023 18:08:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: support using defines in
 checks
Message-ID: <20231215180824.0d297124@kernel.org>
In-Reply-To: <20231215035009.498049-3-liuhangbin@gmail.com>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:50:08 +0800 Hangbin Liu wrote:
> -    pattern: ^[0-9A-Za-z_]+( - 1)?$
> +    pattern: ^[0-9A-Za-z_-]+( - 1)?$

Why the '-' ? Could you add an example of the define you're trying to
match to the commit message?

