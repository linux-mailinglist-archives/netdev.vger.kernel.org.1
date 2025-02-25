Return-Path: <netdev+bounces-169406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC03A43B9C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D963AAC27
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4D26658C;
	Tue, 25 Feb 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqqdKcFI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FC266569
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479080; cv=none; b=oIy8NbPFWpo8YliL0xduioM3fmdFOLaS0EIU/uzLDwtbV1j4ktTl2fDgyOG//fHSmyoJWonlYqQtTRxzFcutQMKsefsCIFWVHy2KujJxV7Dmab/q7AkfPALYY8zpohFQyLCVvYuC2NbqL4GAHlpQjpY1APk8g4g8HicIuU4XZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479080; c=relaxed/simple;
	bh=Vd+GDfZIBhKFOgpBnjISkoGbxRguozABcT/3j88fhw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMelYefEyDs3NqrljmgoXq2zmKWsFDEvCt/vVB0R9Pz51ED8u8oQBQ0rnKlcFvb4qIMQZMpVRlmPUS+nkYPMp0PDpkEBVStnqeAGkFxSRklDORt+WbHHzJcSyx7URQHVWTh4Rhs1McpTHT4MxZfqldnUpSkeb4N01E/UZ8xzkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqqdKcFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE24BC4CEDD;
	Tue, 25 Feb 2025 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740479080;
	bh=Vd+GDfZIBhKFOgpBnjISkoGbxRguozABcT/3j88fhw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqqdKcFI2wwcpNZSZYlSo/3hlDOs3Q2AdPbj6DxjSaoEFv1yN04OnjKPWl9OQ5I9e
	 alaz1V445c7Ofet4fToIvzTHOT6Aqru/o3E421igJH4QMQXhYFqrJcJPLCbVTgLECv
	 qEhk8cT5LK27rdz+Mu7DnSBzDjez339L35F+JOJQYF+8Fx+X4kn5YQttxmxmR/U9sb
	 PmF6dlwwqo7hrJpTdS1WXuPyOVQclB/PQpEg39oxOLsKNDnbHXstWp1S5hW0ifI1El
	 j/jUU1cwZ/PT/gI3XMckP9G4QclOKlliV0noFgBY0Su+l+MKXksfxaoOoH6hOVtV+S
	 Bo38p9nK2LyFQ==
Date: Tue, 25 Feb 2025 10:24:36 +0000
From: Simon Horman <horms@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
Message-ID: <20250225102436.GT1615191@kernel.org>
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
 <20250224134430.GA2858114@kernel.org>
 <38aad71b-db71-d502-9ce6-9bf2efd5a717@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38aad71b-db71-d502-9ce6-9bf2efd5a717@redhat.com>

On Mon, Feb 24, 2025 at 06:34:55PM +0100, Pablo Martin Medrano wrote:
> 
> 
> On Mon, 24 Feb 2025, Simon Horman wrote:
> 
> > Hi Pablo,
> >
> > FWIIW, I think this can be moved to below the scissors ("---").
> >
> > Checkpatch complains that fixes tags should have 12 or more characters of
> > sha1 hash.
> >
> > Fixes: a19747c3b9bf ("selftests: net: let big_tcp test cope with slow env")
> 
> Thank you Simon! I will modify this for the next version. Looks like I am
> falling in all the stones possible for my first patch :) Receiving such a
> friendly support is great.

Perhaps there are too many stones :)

> > Lastly, and most importantly, it seems that there is new feedback on a
> > predecessor of this patch, which probably needs to be addressed.
> 
> Addressing it. Thank you for pointing it out!

