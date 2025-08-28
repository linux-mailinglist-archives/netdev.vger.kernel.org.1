Return-Path: <netdev+bounces-217847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F942B3A230
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDFC5669DC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660E30E83A;
	Thu, 28 Aug 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q75bb9Ld"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D90B665
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391482; cv=none; b=nHUm9AYYEk0jixx7Mc2jwDZ7zvxo2XDR9c8qD5upPj7yN3jWeGYW8S6+DJdO4ijHr+LdaIkrVXmicPQ1moHZDoZ41FrxgP82v4gbaajSGGrkRJCeUPrFHw5eteaBMUMnc2kejrDCTXAeI4hQvDUmq+DwMukbNvcfjT7hFArX240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391482; c=relaxed/simple;
	bh=kCakHvs5CG9z9MGHeVUb7hQAWlH8dJWxJBejvFlHDOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shRLiDPxjRQ8BqM8XChvadhWIrfXY0We7fd3RND6DaVYA9LIg0X1uHjCJ79//K+44yLUqYd2SlwIDdR5pgxA5hOuuhmpdojIpTVB3+JUDbb61yLU1SwB6JRMdjLy7pwmX6l0SMcKXN/bDDeBJQNk5UPOE4mo0EBrd5ybuq991To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q75bb9Ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAA0C4CEED;
	Thu, 28 Aug 2025 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391481;
	bh=kCakHvs5CG9z9MGHeVUb7hQAWlH8dJWxJBejvFlHDOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q75bb9LdLQthDycXjZzMXCBxZ6HOOGm0k5TO5IOWE2SlLJHaB9KeCobm6tpHVqNBZ
	 jTgavfEwdMSetBphE8h/bayUA2LHt/dxlW5rXwly/rj2LcIaY2gqQpbcisUnL4P5Dn
	 Fbw57/2Q0/GmO4JBxIAwSluUyRX5RnjD0wwpS/wN7cgHyqT438WxQLJ+q3rtrF8jHI
	 mRQXyMKRJc775YNUOAinh1ITUlycGAKhvNuWW1oPQCMGto1tEjShJkvZ4x63KS0OIY
	 EaLchbk649i5mNCb0n3gLbqKCSmgOMV5Z4qQ/+jj6OqdH5VD2Mo8AiWyYY0IpyJbWI
	 kODVuQjKguDDQ==
Date: Thu, 28 Aug 2025 07:31:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/13] macsec: use NLA_UINT for
 MACSEC_SA_ATTR_PN
Message-ID: <20250828073119.62cb3545@kernel.org>
In-Reply-To: <aLBm5t5nZtILh8YN@krikkit>
References: <cover.1756202772.git.sd@queasysnail.net>
	<c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
	<20250827185415.68d178c3@kernel.org>
	<20250827185540.3e42dbcc@kernel.org>
	<aLBm5t5nZtILh8YN@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 16:25:42 +0200 Sabrina Dubroca wrote:
> 2025-08-27, 18:55:40 -0700, Jakub Kicinski wrote:
> > On Wed, 27 Aug 2025 18:54:15 -0700 Jakub Kicinski wrote:  
> > > On Tue, 26 Aug 2025 15:16:24 +0200 Sabrina Dubroca wrote:  
> > > I think this is a slight functional change on big endian.
> > > I suppose we don't care..  
> > 
> > we don't care == the change is not intentional, so in the unlikely case
> > BE users exist aligning with LE is better in the first place.  
> 
> I don't think this is changing the behavior. The previous check was
> copying whatever bytes were in the attribute into a u64 (incorrectly
> on BE) and setting the rest to 0, and then checking that this u64 is
> != 0. The new check is reading the value correctly and also checking
> that it's != 0.
> 
> Converting the nla_get_u64(MACSEC_SA_ATTR_PN) in
> macsec_{add,upd}_{rx,tx}sa to get_uint would change the behavior on
> BE, but the current code hasn't worked correctly since XPN was
> introduced? We use 1<<32 instead of 1 as our PN, which doesn't make
> sense when using 32bit PNs. So I think we'll want to change all the
> nla_get_u64(MACSEC_SA_ATTR_PN) into
> nla_get_uint(MACSEC_SA_ATTR_PN). WDYT?

Heh, TBH I misconstrued the patch, I thought you already did
switch to get_uint. I think switching makes sense, I don't think
anyone is expecting the difference in behavior between LE and BE.

