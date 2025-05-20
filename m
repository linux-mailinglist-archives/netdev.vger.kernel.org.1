Return-Path: <netdev+bounces-191715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A6ABCDAA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E27A17FF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA02571B6;
	Tue, 20 May 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ7bFFpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81624255E32
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710431; cv=none; b=aDtEJEvprvP65Wqsyw1tb8KuoEZEnenjuc7K2RovTyTB3zNI/4iIZ95iGP9sMPzDkjsf6mZ8BnnVnUxRHJjDohFmq/1OjImrZdcmqffXVe235xRrr0V9CjVyGHPwsV7ebmP1bio7HZJjX49HxVtcawA+uGAMZXc1TlZ21IzfYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710431; c=relaxed/simple;
	bh=9nhrmNWsuiDatDVHKzazqzOcVK17BdPx3Q8+eAtL7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV7vzvjjFa6623iKgOtTG+ewweAn5LCqidBTdW0ebIsFSkb9RBbjYwX72vIXrUctx2I649YnEImJP6yVKspm0u1ILkVrOOrJqagFU9Bb2u0r++VtXRodRn6iH8jkM0kIAg/QuCZgSJL4WknLpXkz4SiQmiDKeXXB8EhC+aPHdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ7bFFpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A692DC4CEE4;
	Tue, 20 May 2025 03:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747710431;
	bh=9nhrmNWsuiDatDVHKzazqzOcVK17BdPx3Q8+eAtL7Bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQ7bFFppgWsN93XWbb639F24Ff07qQ2hadMQJbNZ1s1jyrvMtsj31Ezf2q1UTYD0v
	 Sb4+vm+LBa70YaXFP7bpHdXsNnmPZuZta0VDvJewJVgAbMR7X44HgPr/NNzcE1NzsS
	 ffbuazhmkHWpGQRW8ttCc/cMs2vTf+Tss1etyVerEPVJFUOZzDuTE1GppGjxdo8jCo
	 E/ZW9brYb2uOC1pEWaVkHemtdKaA8qOPXtxcVQ8kU1uG4mR/ZKrUDwgXjXEsy1pyNw
	 3Ar5OrfEJ0+LWHxu/qpKcSwFrxAcBQUqJPiv/nCWJafJf2IPOkjSJse2o1CUv2PvIY
	 z5P2dN3y67bOQ==
Date: Mon, 19 May 2025 20:07:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jacob.e.keller@intel.com, sdf@fomichev.me, jstancek@redhat.com
Subject: Re: [PATCH net-next 08/11] tools: ynl-gen: support weird
 sub-message formats
Message-ID: <20250519200710.714715d3@kernel.org>
In-Reply-To: <m2frh1j6jy.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-9-kuba@kernel.org>
	<m2frh1j6jy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 10:25:37 +0100 Donald Hunter wrote:
> > @@ -2234,8 +2260,9 @@ _C_KW = {
> >  
> >          ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
> >          get_lines, init_lines, _ = arg._attr_get(ri, var)
> > -        for line in init_lines:
> > -            ri.cw.p(line)
> > +        if init_lines:
> > +            for line in init_lines:  
> 
> I have a tiny preference for this construction, to eliminate the if
> statement. WDYT?
> 
>            for line in init_lines or []:

Sure thing, the if was annoying me, too

Will post v2 tomorrow morning, thanks for the reviews!

