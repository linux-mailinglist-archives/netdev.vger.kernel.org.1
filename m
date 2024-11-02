Return-Path: <netdev+bounces-141214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6BC9BA0FF
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C9E281EFC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C72199E8D;
	Sat,  2 Nov 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szwgrSEZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C719BBA
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560361; cv=none; b=T84DIkWdmpiaVDwx1xaFD8gxQIF7snZufshkIXfIbQstRrx/8UwqsVVk3hIR6p6h/EK7MJXXce/TPgfsfgS2+PSl7ebH4lkIo+vOySJSFJ9I6JDp5Sz+PorlCdHKbQccjr8t+mTopMAP5q2RO/s0hSlesubnY4IElZYRluWHogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560361; c=relaxed/simple;
	bh=XVLfr2k/iwF8BCftxJoWl1LX1LkLaC8R7bn44UptcJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRlNPYiT05Cai18m3pcCABoU/F8h+LYPBmTcdRKjkCf+4Ao63FPIRD9S0dmhcsZ3YC7/ClmGi5bcdyJE+d/Drjewxw/2AJFmuXzhHTWSzDNEvDCksM8u39kvTKr5Zlu+GJ2D+qLudyNzlAqjd+In1A810XRC6IfgjHgvSuByz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szwgrSEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D1AC4CEC3;
	Sat,  2 Nov 2024 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560360;
	bh=XVLfr2k/iwF8BCftxJoWl1LX1LkLaC8R7bn44UptcJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szwgrSEZvGkYDfNy6IiBkDLUPhVc2/mDJc7tpzADsNUOSd+0jvliqDJ5DxD5tXg4O
	 ugyNaD9IseLJy2hjktGO0UPx8dlkocs2v6suqfSWy1aiLxhKnNVfp2prjFX4u9E3r8
	 XSn6pak9DSLxQ6kPfGkdfYjkVA6sCtiD+3iAQMicS6ZIK5COPfw/2Bm+toT65l9fQU
	 HjKEUxkvbEosAfEJLmIk9742f+r8X6xBvKUC0suOOSeH+aJbEhur+TR9QGLdsACflq
	 GQbPt9g080u8A8W4NiImT+VDFSmI84iGnyt5bi5dubt3iVurLlSQlq1YngiC6BGjFT
	 W6bpirmTFexag==
Date: Sat, 2 Nov 2024 15:12:36 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH v3 iwl-net 0/4] Fix E825 initialization
Message-ID: <20241102151236.GQ1838431@kernel.org>
References: <20241028204543.606371-1-grzegorz.nitka@intel.com>
 <b6abb7f2-22a3-4e93-a201-292e2b5f907b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6abb7f2-22a3-4e93-a201-292e2b5f907b@intel.com>

On Tue, Oct 29, 2024 at 09:33:32AM +0100, Przemek Kitszel wrote:
> On 10/28/24 21:45, Grzegorz Nitka wrote:
> > E825 products have incorrect initialization procedure, which may lead to
> > initialization failures and register values.
> > 
> > Fix E825 products initialization by adding correct sync delay, checking
> > the PHY revision only for current PHY and adding proper destination
> > device when reading port/quad.
> > 
> > In addition, E825 uses PF ID for indexing per PF registers and as
> > a primary PHY lane number, which is incorrect.
> > 
> > Karol Kolacinski (4):
> >    ice: Fix E825 initialization
> >    ice: Fix quad registers read on E825
> >    ice: Fix ETH56G FC-FEC Rx offset value
> >    ice: Add correct PHY lane assignment
> 
> Grzegorz, thank you for picking this series up!
> It is legally required that you sign-off too, but please wait for other
> feedback instead of rushing with re-send ;)

Likewise, thanks Grzegorz.

FWIIW, I've provided some feedback on patch 2/4.
And the rest of the series looks good to me.

