Return-Path: <netdev+bounces-111876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B3933D9D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834D41F23B57
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2A17FADC;
	Wed, 17 Jul 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTpaiz/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107E17E8FA
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222987; cv=none; b=rqB4K+K/01Qo7codFzdGr0Qcir/h/f+/49gHDe/3HbPiFFFCVa/ex45MLQy+G1+UW66tcQwFHvwcdml7NQ8xs46BzFwMII/imk5CpdvIcD/R+VLXldlwwEeZlY+idZbPzDmq3RFLtPONAoja1f1RqN9TSnPZLdPMVYUtdZy6XUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222987; c=relaxed/simple;
	bh=54au27XpLCDqeDIpp3H2YKt3Sn2dyUROntZRSBWG7j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxQv60yKf22vfbm5AwpXL4xSUmJtgQvdwb8UxIvn6Mqr5DSCbxgz0KIZT4kmHGrrkLs1y4+DmXMeQBKKKymicXdV+HqsM+tu0z4DpRYWeiN5l/NivD3IWTihSvhhJXWeSaL3HrTmxJ+VtfHwL+4mrQUKDEtssxrWCWiVodnhxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTpaiz/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B74AC32782;
	Wed, 17 Jul 2024 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721222985;
	bh=54au27XpLCDqeDIpp3H2YKt3Sn2dyUROntZRSBWG7j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTpaiz/wm9c1g1sanSB8OfxlJw+XeUTcA+Jvf9/Rse2R3PN1iN/hmb7pXDlbuAZma
	 TkRPBxsW0UOOryo3leQL1pfmlpBXZqGDyrOP+kvKNEl5hRafWM4RoaBObjEKbHFCvt
	 CwdINxlBr8bmgLCGqsO4MDfzISQbdpy8wi2fSCu6964WLk6dOVrhw4lc2dcSSdkD+v
	 pauLUItp1Cd7Gw7BoY9WqhqAmzGI0f1E8ugqnMOFQQhQDtF5v6tDenEK5t+QT9Uhx9
	 mchzZY8xtJr8EqsqFKwyXFp9f0LsGDV4x0SWIcnl4nntUBMu4exd6ouyYZupgszFAw
	 35T0dEZklIH1g==
Date: Wed, 17 Jul 2024 06:29:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net] eth: fbnic: fix s390 build.
Message-ID: <20240717062944.02d54395@kernel.org>
In-Reply-To: <5dfefd3e90e77828f38e68854b171a5b8b8c6ede.1721215379.git.pabeni@redhat.com>
References: <5dfefd3e90e77828f38e68854b171a5b8b8c6ede.1721215379.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 13:25:06 +0200 Paolo Abeni wrote:
> Arguably this is quite sub-optimal, but sharing anyway to have a
> short-term solution handy.

Agreed. We also need a fix for frag count > 25, it seems.
I'll send another fix, but this one is more urgent so let me 
apply already.

