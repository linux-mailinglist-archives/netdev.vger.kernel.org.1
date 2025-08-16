Return-Path: <netdev+bounces-214254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEDDB28A43
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4B8B02272
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3991D5165;
	Sat, 16 Aug 2025 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOP47wLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807918DF9D
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314266; cv=none; b=JEn5A9fLVnaZNch7mymH4z1iELCE69Apuy/83Rj1+uUwfDOMgoBExeTD/7IfBfP3NYIKfR2TQpqRQ3/35nCR+DuMUeXxT0zAIgc7LIgZbOjT9FsNPuf8o9naGfz7emAHdoN3R5+oVjWHUqSe3+ddZS8LhKZWRH00/LOjSe0ziQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314266; c=relaxed/simple;
	bh=IDltpbWpSbxJQ90doQZnXbZEUwDE8nkh7yxygl+vDRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUlh4bAuNigH1eUWlzCpbcsV4bFF9NbWbfsAsI4I2lyWyRN/+zbTBH/uLNTCMVbExtydYarz3hl8PSjDNDYEsvFMU+mRjxtNgnwcwXTrsuEgq5Z3iezue59uvx6Knj8S5VAfqbTkav5885bDJDT2SnTLre2R365d0sPKmIiM6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOP47wLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6B7C4CEEB;
	Sat, 16 Aug 2025 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314265;
	bh=IDltpbWpSbxJQ90doQZnXbZEUwDE8nkh7yxygl+vDRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOP47wLhmhfa9Ee7/pE0lZuE1z1GD1D0W8nXqWIWoW5mVmOlC+FDsen+tDuv3JyKH
	 RCbVf7O6BbkzFhGWkTZoLl5Pgy4ToqcOKLc7QMnpwAJ0SqlzoX+t2cUwvyBFTtjAzI
	 URjZF0Gz9BwM/29jSHyhynU03bbVON2A6pONHjgaa/LSct3VaSDciK+GMVoX674yaB
	 EQNww1J94XfcP+/HemifpQVrfzuTObOV1EfbgpC+ul8FSTra2LySTYxVSU56Rx8ibP
	 +JAaOVcYHN5ltU67CGIchomkCNDZqpbBknjrxhc58QrieqgdCCmfqPAzvAXVpQD7jh
	 4NIC5Xlx5woKQ==
Date: Fri, 15 Aug 2025 20:16:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH iproute2-next] man8: ip-sr: Document that passphrase must
 be high-entropy
Message-ID: <20250816031640.GA1309@sol>
References: <20250816030129.474797-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816030129.474797-1-ebiggers@kernel.org>

On Fri, Aug 15, 2025 at 08:01:29PM -0700, Eric Biggers wrote:
> 'ip sr hmac set' takes a newline-terminated "passphrase", but it fails
> to stretch it.  The "passphrase" actually gets used directly as the key.
> This makes it difficult to use securely.
> 
> I recommend deprecating this command and replacing it with a command
> that either stretches the passphrase or explicitly takes a key instead
> of a passphrase.  But for now, let's at least document this pitfall.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  man/man8/ip-sr.8 | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Sorry, please disregard this version.  I had a (small) unstaged change
that I meant to include.  I'll send v2 with it included.

- Eric

