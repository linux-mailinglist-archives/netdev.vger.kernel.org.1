Return-Path: <netdev+bounces-114616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370494326A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076391F215F5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD801BBBEE;
	Wed, 31 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUl8moMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C51BBBE7
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437296; cv=none; b=VxFIcfT2rRRFkvlXF7xme1I+5VYlPCsnOEG1srrL4d9T5zMWbxJCEKsjkHyw3+y/E0so+QNaSKgl4dxhxXVrdna6VPV6wq4ZDzcr+NWmUXK3RxmXy8xsLo6jh5jWTJ9gykqQ6dFXVPaU3G15Fh8eMzHWr8LonTOWYYif+/Uah7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437296; c=relaxed/simple;
	bh=pSscipKO1tKZ73SPHB15ojM9oo9OdzMDo45mvvOMHNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEgUo4gs41czx9MYESEi6BFq1Qp13AEZXlye+E4H1DyodBGyagPOgWNH4mOGTK+J/+87FZ8IDZTtfiEtpENYg+g3je/rbtGwTiwl10OWM6myasq1nqfU/XZfFUnqpDEcFqbhHC6GBPl7QcpUG2kw+EhvL1OW7T4rNtSHGlIMsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUl8moMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C359BC4AF09;
	Wed, 31 Jul 2024 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722437296;
	bh=pSscipKO1tKZ73SPHB15ojM9oo9OdzMDo45mvvOMHNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUl8moMH/EqnTuG9CcxcD1dWEB05TfNuQxaI6sFHLpOtuTgVA7Du4U5M+c0xSOYpN
	 /c8QEkOr9k+7guy10v5szDG79vOFYdZ8hCkk4o3Vpc/EwD0toDQZvH9ejB56j3CU+P
	 lPBTNVBxr0/ibCS5ExuzXX4hCn26ATYRpXyx4ejL2iPKM9wlQH8GuccGQ6OvpR6Q8z
	 DXUnMl8MgeswNcE35O2GkWBX7hSorws4vptCtpeRYQ0O4/sxZm1frvocom7uaM2lAD
	 2PaOhRA5V9Z7SV7JSFMQgFYDv3V623OfxUEdihtlOBe3+zOpig+35NIHRzbnfG8am7
	 Qz2lDssxNr1jw==
Date: Wed, 31 Jul 2024 07:48:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <shuah@kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: ksft: print more of the
 stack for checks
Message-ID: <20240731074814.7043d9ac@kernel.org>
In-Reply-To: <87h6c57q4b.fsf@nvidia.com>
References: <20240731013344.4102038-1-kuba@kernel.org>
	<87h6c57q4b.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 13:07:26 +0200 Petr Machata wrote:
> > +            started |= frame.function == 'ksft_run'  
> 
> Hmm, using bitwise operations on booleans is somewhat unusual in Python
> I think, especially if here the short-circuiting of "or" wouldn't be a
> problem. But it doesn't degrade to integers so I guess it's well-defined.

Right, I thought the automatic conversions to booleans are sometimes
considered in poor taste in Python, but wasn't aware that bitwise ops
may be frowned upon. IIUC the alternative would be:

	if frame.function == 'ksft_run':
		started = True

or

	started = started or frame.function == 'ksft_run'

or another way?

