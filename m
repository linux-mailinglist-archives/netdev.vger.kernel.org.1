Return-Path: <netdev+bounces-221193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B1B4FA07
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F534403D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5F288C25;
	Tue,  9 Sep 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr3GFq2P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE542472BF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419942; cv=none; b=YGYkz06u0PAUKdimLVr598eZmFmCMsbFOwIzCUulwt9ANoLvqk+bYvbETW0T98B+J1c1x5A6lCf0tIxjxnoEKspsz1tc3M6GHBjGYA13xo1/3GBQ0RSX47+7B0MFWBqj4MjODAxLzPAdY8a1nbuRTYH5dK3wthoVrCTe6NoFCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419942; c=relaxed/simple;
	bh=ZdvxZqwS38QpgI0dlaojLLJXzDhXZ1uosfIo+2ZyNf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lINRLjgOAyCSetU35em0I/81SuNAgdasIZYJXFKj1om372Kb61VtZSWykRzpt7CbST8hP0G6OIKA7YjORDkYUqEEeZmmYern/AQuSATAHxLogu1Y8gWhu/mtsoGxdp60wk4DzEAyRv76f+2sxxbvzPH0Cyc3lGr0iepvLdJfvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr3GFq2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F917C4CEF5;
	Tue,  9 Sep 2025 12:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419942;
	bh=ZdvxZqwS38QpgI0dlaojLLJXzDhXZ1uosfIo+2ZyNf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr3GFq2PaA9ZRvQi4bzCBko/8iTwxE1wwylRjFaaSj6hLJf4hov1JKa58txSyEGip
	 UzvCLEPmsKMiFWg6OWqrY8UVIq/+5zxKYCgeH4knMoEceM2NP4PgAiBo/dPap8onxD
	 QKsh8/Hc68Cz3kWJJuXEmhVMS5v1hb8qQ6ocHgO5WVjjIg96zvA1aEKBzUn2i8d0hh
	 jsyYIPzncYp7NSdk/GiLY17Wcz1xyH/ZilSzpk/W/kiyyn4rCp+YagHYWKB38m5wWg
	 aA/2e00SOtof2bxTSMMGEhUCLj7LKgvMQG5JSnxipK2MTWchfo5GXa1hs6cKzypVwN
	 Ap8R8oIf/NJyA==
Date: Tue, 9 Sep 2025 13:12:18 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: udp: fix typos in comments
Message-ID: <20250909121218.GD14415@horms.kernel.org>
References: <20250907192535.3610686-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907192535.3610686-1-alok.a.tiwari@oracle.com>

On Sun, Sep 07, 2025 at 12:25:32PM -0700, Alok Tiwari wrote:
> Correct typos in ipv4/udp.c comments for clarity:
> "Encapulation" -> "Encapsulation"
> "measureable" -> "measurable"
> "tacking care" -> "taking care"
> 
> No functional changes.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


