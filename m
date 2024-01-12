Return-Path: <netdev+bounces-63169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE082B885
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB96B21554
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34343EBD;
	Fri, 12 Jan 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKIEQ0+q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDEEA6
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBBBC433C7;
	Fri, 12 Jan 2024 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705018441;
	bh=Zdom5WIaXNax2GQ5CAHnV8GQSfg9PPsNtQ+esTOHokY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKIEQ0+q8RHAnPkU+Myy/BLA3wNAAqCWiUqppp0GO4AjowoUEAR3B/HZZaiwLgDI6
	 Hg5cIx6lQm721WvX0pgYiuuiiaGwr0Se8LKhYh8KXqlFbTk6D5yRzuBsmAGCOG9VKz
	 OOqf8Y39QB+eqjAnTVxUziNYD/l71zUTUZClg8DqBfOF3nEAs+NoegziZZVF0B3bqM
	 +6Bfrpbk5Z/q6lgG+hrF2JHEl3P3wVilNaWTYAHIeAV3qYRL75F5LA0e90CYk55APn
	 U/7Wy40mZQ5krOhCB1rpmMzh5iGiALrj7HsScfKfVs2gmZAQi3uaKzDpwmuqu7D7Bf
	 jEQrei0ASBA6Q==
Date: Thu, 11 Jan 2024 16:14:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] Fix MODULE_DESCRIPTION() for net (p1)
Message-ID: <20240111161400.067dd107@kernel.org>
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jan 2024 10:16:00 -0800 Breno Leitao wrote:
> There are hundreds of network modules that misses MODULE_DESCRIPTION(),
> causing a warnning when compiling with W=1. Example:
> 
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o
> 
> I am working with Jakub to address them, and eventually get a clean W=1
> build.

As discussed with Paolo offline I'll cherry-pick the patches which
were good from here for net. Because these warnings are generated
at linking time they _all_ pop up on _every_ build our bots do, even
if it's an incremental build touching a tiny corner of the kernel.
-- 
pw-bot: ur

