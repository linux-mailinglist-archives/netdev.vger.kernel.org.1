Return-Path: <netdev+bounces-133639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73799697F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A8C1F22D8B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA9192B81;
	Wed,  9 Oct 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STTBgIQR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F261925A9
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475454; cv=none; b=MNbZfaq8VbAKqn5RHunz1etFBER20OYCcItLlLHEfqRJceFMhZW4fibyFgbgb7pE4vXYGkHZo2vvumM076nr2AKoRhuy8pGo+9F+c2CvSD6vIZlt04i7Ualg8NfSai8xe7/J8bkvN5AFC96sSQqOu026M0w8K4ieL2CSg0Eoi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475454; c=relaxed/simple;
	bh=YumbO4wvEjFOyfMTFNQ/J1uDtAmiNRKEA+VTav951m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBLcHSHM2KiaEKcNCjSB0Q9w5YKVkJW86MP8gCz6Hv/JeqG34HONCXfhvmfNNzApV41nsDg5y2jRq1Xt9NnikvBJWCvL+EWLAsJoYIhzCDAFqZzatFVptg8++8MAaiKrBcsQkhJ1GrTuZx3hPaKirjf8yjAen8wUlz1yLd/ayGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STTBgIQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A380AC4CEC5;
	Wed,  9 Oct 2024 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728475453;
	bh=YumbO4wvEjFOyfMTFNQ/J1uDtAmiNRKEA+VTav951m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STTBgIQRZNCoE5BilWKnHtMq/rTc89rO1PxFZ2K9VC4CflqUqoyHGUt2NzMpz8Ju0
	 0C9oZRj37g0L41GDnK6COgbarUeqirVPqRYeAUmvghHPpcg6u13RCNRayauGkb+vN5
	 8ZzHY2gyjyB9OYzhDIoi0ut/AKJNS0YMMRWQM5jvnuskpMG30N6nNpbDDlMEnNgEsZ
	 FjBfIuePF9IsQpZWgeD1YbDndkH7+8+Twhzjztr/JdoqGBx0Glpo1wQ0IQxura5H8O
	 88GuGVhzQpMUqZRPuqX7VKMte0ZqtYEiGMgs8dWmI1vGWPwzPRQ88TRGmQppo9bg90
	 Q9vDlszNFeEpQ==
Date: Wed, 9 Oct 2024 13:04:09 +0100
From: Simon Horman <horms@kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv6: Remove redundant unlikely()
Message-ID: <20241009120409.GL99782@kernel.org>
References: <20241008085454.8087-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008085454.8087-1-tklauser@distanz.ch>

On Tue, Oct 08, 2024 at 10:54:54AM +0200, Tobias Klauser wrote:
> IS_ERR_OR_NULL() already implies unlikely().
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Looking at the implementation of IS_ERR_OR_NULL() I agree.

Reviewed-by: Simon Horman <horms@kernel.org>

...

