Return-Path: <netdev+bounces-75791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D196486B2E9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026281C21A13
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD715B97D;
	Wed, 28 Feb 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="At/upyYh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396015B97C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133363; cv=none; b=Z9mfBgKYl2mGs2iZ8mdBRHtWHc4vXEhaYDl8mvSCkOCg3et4R7isv+4ZXPjajSARFKIZqz89sUNbqwPyZWOi3t5yGYKOAuQMoUZ48cjOKd7AgVG/7W7X20j0KJ+Lx2pmeeFrl50H1X3aHJS5uTdKGWMspA9vmDwnnmz8xHpUm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133363; c=relaxed/simple;
	bh=vFYZUiYteM+Zfp3PSUtmZGb5nCKMIt9tCcgL+gdm1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmWZpSAgc3Amd2u48MepMBOp1o0cKQOp1XzezcM+0jZSIdPWCQgpIAppldioScuCcq1vVJzWskcWWTTMJ2WcXtMjYSv1o+VF/oiAlRVrgEPU5mrZqIKj0kwEXggGKtxiLvCsm7Eu+O/tC4wC6CCOlaWUUvq+39fGJ4H4+WrK/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=At/upyYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B0BC433C7;
	Wed, 28 Feb 2024 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133362;
	bh=vFYZUiYteM+Zfp3PSUtmZGb5nCKMIt9tCcgL+gdm1vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=At/upyYhwhbrp1Z9iThg4th2FPiP7ZrltDLEuF9rz5FlQXs195GfJ2ssuIIgt8jch
	 rS3Wa4BwEcaubli5dCJNZYvRH6RtLYZ4Ac7VdOiGMKOpULaH7GXUNNKq90ppceeXWq
	 aHpkQYGO26mBW37fFTStEeveAThUQEWy/rolfPEdcI5onYJVFlQ6wlpYzFxx/zWKBe
	 IzWCqtxDaHiOLsnkqQ72CwHYp5OwB9P7ZEeRlYjjveoe4lwDa5qkjNHWsWfYMUPlFc
	 ldyQPXp8tCe/uKoB2+eTGSmkvaowtNSW1GT9IaXTZJFXJ5+9eQQWqdXaUwZTclxKUf
	 c6gTC/d8KV5pg==
Date: Wed, 28 Feb 2024 07:16:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <20240228071601.7117217c@kernel.org>
In-Reply-To: <20240228064859.423a7c5e@kernel.org>
References: <cover.1709057158.git.petrm@nvidia.com>
	<4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
	<20240227193458.38a79c56@kernel.org>
	<877cioq1c6.fsf@nvidia.com>
	<20240228064859.423a7c5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 06:48:59 -0800 Jakub Kicinski wrote:
> > But also I don't know what will be useful in the
> > future. It would be silly to have to add another flags attribute as
> > bitfield because this time we actually care about toggling single bits
> > of an object.  
> 
> IDK how you can do RMW on operation flags, that only makes sense if
> you're modifying something. Besides you're not using BITFIELD right,
> you're ignoring the mask completely now.

Let me rephrase this a bit since I've had my coffee now :)
BITFILED is designed to do:

	object->flags = object->flags & ~bf->mask | bf->flags;

since there's no object, there's nothing to & the mask with.
Plus if we do have some object flags at some point, chances 
are we'd want the uAPI flags to mirror the recorded object flags
so that we don't have to translate bit positions, so new attr
will be cleaner.

That's just in the way of clarifying my thinking, your call..

