Return-Path: <netdev+bounces-234894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2825C28E2A
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9462C3AD5C6
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E36211706;
	Sun,  2 Nov 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyI+Qm8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CC34D3B9;
	Sun,  2 Nov 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083074; cv=none; b=I26roWohYguGpGtcCWJGqKytTisY9w9ORGIBOnO9Eay5FdkRl+SkiCTi9Fj7RLpdWibBPFmxYNHO3CiNcCa492LgIlOEPPI2i1/ZdNarw29FkxO9335jsWAvNsgvKNjW6Rnt6PPNx9kAkY4WvimYKKeamnEOV/KYkysOjbMobwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083074; c=relaxed/simple;
	bh=0y1XI/EIRvC2o9InMnrA2xpCv2VzpZFvPWgHXYqeTmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvparGU3VtCDt6vIMmz+brwzu9D88bGqKK8HPOpmS4LAW5xH1dF5RZTw7bIFc4X4VYOpErrv6P3k30590BDSndyAvcX7FwxZ/QWnmem3BHTWAOZNfw7mpEtIFJKnRXy18h8oA6+E7A6mH9ooZ25fJcrprS2P+TlG+Z8W9zkFuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FyI+Qm8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162A9C4CEF7;
	Sun,  2 Nov 2025 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762083073;
	bh=0y1XI/EIRvC2o9InMnrA2xpCv2VzpZFvPWgHXYqeTmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyI+Qm8nvgqIf/Pq/UdqNaFWxlaD0Y6APo9CmMttM5OCg1Ej/KqPnlAZ0Wvw57dvd
	 4yHlfnUJauJ6RoANb/Vbe1/OcglD5g4Vr/FD42vDxctPWi3XxBwVZ1z0Gz8AjFdk+d
	 ZZspt2n4O2c8rcDMxktJ57/bsb8dtzskyUSlBE9g=
Date: Sun, 2 Nov 2025 20:31:11 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: rafiqul713 <rafiqul713@gmail.com>
Cc: netdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [PATCH] staging: rtl8723bs: use ether_addr_equal in
 rtw_ap.c
Message-ID: <2025110218-monetary-subscript-1217@gregkh>
References: <20251101201623.185575-1-rafiqul713@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101201623.185575-1-rafiqul713@gmail.com>

On Sat, Nov 01, 2025 at 09:16:23PM +0100, rafiqul713 wrote:
> Replace memcmp() with ether_addr_equal() for MAC address comparison.
> This is the preferred and more readable method in network code.
> 
> Signed-off-by: rafiqul713 <rafiqul713@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm sorry, but I'm going to have to start ignoring patches from you as
you have not taken any of the prior review comments and changed
anything.

I recommend working on a different software project.  Best of luck,

greg k-h

