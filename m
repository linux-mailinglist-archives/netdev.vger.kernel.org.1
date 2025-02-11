Return-Path: <netdev+bounces-165033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B7A30219
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A0B3A7072
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E071D54C0;
	Tue, 11 Feb 2025 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmElfvy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46726BD95;
	Tue, 11 Feb 2025 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244060; cv=none; b=mVv3vrBqk3RZLPnnUY0ieSHPnrR3RGVOgO5M8d4xmEqByubEVYPpTLgTdjTlLbP9zuqd5nUHwWqsfWxax0MRGBZeRTaZzjyT7+KvYQeeqCZjIK/wGiCxa8Shuxw6O9vY+kjj9RbPncpEiZGWywBlZqKvQX+uLnx6jhcPr41v6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244060; c=relaxed/simple;
	bh=TyqVUC1ihDVGaqOg4m/1cz3ovyquVJjJPV218ZwgmqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkic996jVQjMYsIF5Rg88vnrcvVCPcFKWqb4bUHTlg89dTG03vvBYRt8Ht2Zuxi6OSRVy2lTPORvxODnkTXev9etrj2Vhauzis7ZK0H6YLwqBt/Pg+Dojrva1VkSC8XoMRF/v7g3QjiNpjWDkOR+WzjiINUGZufx3wqodT+XGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmElfvy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F25C4CED1;
	Tue, 11 Feb 2025 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244059;
	bh=TyqVUC1ihDVGaqOg4m/1cz3ovyquVJjJPV218ZwgmqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmElfvy9kgokaLWPK4tcitOrHQw+ylSMeM57QOSOM+KN126V8JZnPPtGaUX3uM+e6
	 jydcB2zcQi45b/Q11W6NCK2D6aKtMaRIHBBzhFcKo6jpzS2Q0+KGfis3+6WtDhXwxS
	 2V1SmT8Fg2Mgz3fRcuANriUU2AErzOVNvaZqfQhCuMbxpDiYr8CDozODjukp0XP23V
	 D5At4CjdQrxJoZJK/hxF3hAn3aNhjvRv65I9qKD4pYEDGXS2Xkk83OevMOG0PYx4vU
	 qP3MYCgEVVQef/zPJZjAQazBHmxFMqStNF2rRFy0JYZQWLM6q6h80gtSqjNujAMSx9
	 z902gCWqDk5lw==
Date: Mon, 10 Feb 2025 19:20:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, ahmed.zaki@intel.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] documentation: networking: Add NAPI config
Message-ID: <20250210192058.26b59185@kernel.org>
In-Reply-To: <Z6q7B79h73ydzOhM@LQ3V64L9R2>
References: <20250208012822.34327-1-jdamato@fastly.com>
	<20250210181635.2c84f2e1@kernel.org>
	<Z6q7B79h73ydzOhM@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 18:50:47 -0800 Joe Damato wrote:
> On Mon, Feb 10, 2025 at 06:16:35PM -0800, Jakub Kicinski wrote:
> > On Sat,  8 Feb 2025 01:28:21 +0000 Joe Damato wrote:  
> > > +Persistent NAPI config
> > > +----------------------
> > > +
> > > +Drivers can opt-in to using a persistent NAPI configuration space by calling  
> > 
> > Should we be more forceful? I think for new drivers the _add_config() 
> > API should always be preferred given the benefits.  
> 
> How about: "Drivers should opt-in ..." instead? I have no strong
> preference.

A bit more editing may be beneficial, lead with the problem:

  Drivers often allocate and free NAPI instances dynamically. This leads
  to loss of NAPI-related user configuration, each time NAPI instances
  are reallocated. The netif_napi_add_config() API prevents this loss of
  configuration by associating each NAPI instance with...

  Drivers should try to use netif_napi_add_config() whenever possible.

