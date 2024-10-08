Return-Path: <netdev+bounces-133198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE099548F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C9AB283FE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21051E0DD3;
	Tue,  8 Oct 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMSaxAzK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911B1E0DBB;
	Tue,  8 Oct 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405433; cv=none; b=UDvpjRbmXONIt4o7dhSGnlPgoIGokczf+5JLwBmQlw7smPljhv5C5/8KDCIuD6qppEL9rOSsau2HZnRHkZ41NsyG3s9NDiozgrVMUcFUJVrnFtzU/83Sx2j1oMjuVpSQmOD6SwF0nvx0H0vwdSkGaviw0tBI5LXVNIP+Th5+YMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405433; c=relaxed/simple;
	bh=Et7/X+kGjmeCGGVKG9k0uplKblXWJ8NNGdWbvurdZuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTlspa6ari2+Zr+Gx6wI+Fdl7yi6npxvm3xraAmXXL9xQb0eZvdI5UzyjVRY47Y1RFjsiowC6DhBBJA3Iba1cFYpORlBXyJrwbERasdMQLRb6h9jxy9/yAZ1lr6LG4ZN1ebaq1PGQCr6s9i8Y++EJH+/OlBIrbMeP79SVFXN6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMSaxAzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F01C4CEC7;
	Tue,  8 Oct 2024 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728405433;
	bh=Et7/X+kGjmeCGGVKG9k0uplKblXWJ8NNGdWbvurdZuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMSaxAzK3AZUhTWcbPCMtJo75D2sWr/XmCPgl0xgtZutHoR3GJD5bevVXMk+Hbc28
	 VY3EbemjGUwjewXc2u7mgj7wB06gG3236sVuKZMaoqU4pSD6WYVSihMmNH+91VOfAp
	 XPdNGOkFkMuNFf0vgy7mbvFVkaZtOqobG5lQOQSpQkXjGdNxfyvdCN0MEpfH+Uzwa8
	 BWqYXwml+vnU8Pxx8JhJvc/9HsGeLBNOErq2hekJ1OdTIhK3MT+M6UrpcUEsPbzU99
	 Z16fsgj6csYIH4pKyQ0VZ9KONKO0a3u/bsr1pu+PiPtukWC6wUoO6Btk4qH8WBlIkx
	 bZPWrHk1Xlkvw==
Date: Tue, 8 Oct 2024 17:37:09 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: ayush.sawal@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] chelsio/chtls: Remove unused chtls_set_tcb_tflag
Message-ID: <20241008163709.GC99782@kernel.org>
References: <20241007004652.150065-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007004652.150065-1-linux@treblig.org>

On Mon, Oct 07, 2024 at 01:46:52AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> chtls_set_tcb_tflag() has been unused since 2021's commit
> 827d329105bf ("chtls: Remove invalid set_tcb call")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


