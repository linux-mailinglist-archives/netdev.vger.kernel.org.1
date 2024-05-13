Return-Path: <netdev+bounces-96181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C78C49B2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158831C214F3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444638405D;
	Mon, 13 May 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ7vlJVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF222AF09;
	Mon, 13 May 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640214; cv=none; b=Ab1myaSfkfDyUuLsUwujIh7ld6ZlUOuNFTeUFCJ8rTriuobPKsWqxVZ5BvcqaXbXnzdu2BRnruhCZRp0FaYwG8Xlk1Qdw3UAkw40suRN1cc8YMCcifq2ZA8LRS0luqCd1WqGZxif/2XpAbph+tpXq/iFYhGU7hwpc8kd+Rj5IHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640214; c=relaxed/simple;
	bh=VQ9Urm59rmUv8jDvOau4fdEQRHbiw9popBWNhKOZ7Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siRwSjJlufyV2CUZLkRgIondt88nDbN654mhKApPomH0XAw4diGuapuvoKBNGuhD3MuE1fp5iVqCuLgzam72ecM8I1XUbS9CDp3PvLkADiN4pyJawPIux0nuHr6EPHTToEZOt7N/UgvWO/OlOgdDkUTrVHn9lUAUAn/M+HswA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ7vlJVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4644EC113CC;
	Mon, 13 May 2024 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640213;
	bh=VQ9Urm59rmUv8jDvOau4fdEQRHbiw9popBWNhKOZ7Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQ7vlJVRc2ECTpRE6TpVoz4yGD+gwv2CHAwasKSsvG2OxlS5H6QwNS16joypOrN0s
	 UpWX9AzJqYSTh9M9y6NZCJwZBzODNK+yb2kBN2D8sDIwsNWbfXiHjhrj4KaoyOxJip
	 yIjXaY/m+Kx2bWVT/KkNgE2qZvnrSOB1exe3K/+y9uxsx7w0kgBL6ZockGQBJaEqA7
	 pHtnGWIw3tktLWlj5h3tOsAJuNJIq/H+CwQJ1yOKIIZg9pyFL1XfnljeEmzYVxLupC
	 xNyNU7K5AR32fSXnZ5OQQoSqMUnEtXiH/CKjF0Xd5+n8i+Mqhh5u8EzR2FVWxcnBlW
	 hwDsf+yheyc7Q==
Date: Mon, 13 May 2024 15:43:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Pauli Virtanen
 <pav@iki.fi>
Subject: Re: pull request: bluetooth-next 2024-05-10
Message-ID: <20240513154332.16e4e259@kernel.org>
In-Reply-To: <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
	<20240513142641.0d721b18@kernel.org>
	<CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > There is one more warning in the Intel driver:
> >
> > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_list'
> > was not declared. Should it be static?  
> 
> We have a fix for that but I was hoping to have it in before the merge
> window and then have the fix merged later.
> 
> > It'd also be great to get an ACK from someone familiar with the socket
> > time stamping (Willem?) I'm not sure there's sufficient detail in the
> > commit message to explain the choices to:
> >  - change the definition of SCHED / SEND to mean queued / completed,
> >    while for Ethernet they mean queued to qdisc, queued to HW.  
> 
> hmm I thought this was hardware specific, it obviously won't work
> exactly as Ethernet since it is a completely different protocol stack,
> or are you suggesting we need other definitions for things like TX
> completed?

I don't know anything about queuing in BT, in terms of timestamping
the SEND - SCHED difference is supposed to indicate the level of
host delay or host congestion. If the queuing in BT happens mostly in 
the device HW queue then it may make sense to generate SCHED when
handing over to the driver. OTOH if the devices can coalesce or delay
completions the completion timeout may be less accurate than stamping
before submitting to HW... I'm looking for the analysis that the choices
were well thought thru.

> >    How does it compare to stamping in the driver in terms of accuracy?  
> 
> @Pauli any input here?
> 
> >  - the "experimental" BT_POLL_ERRQUEUE, how does the user space look?  
> 
> There are test cases in BlueZ:
> 
> https://github.com/bluez/bluez/commit/141f66411ca488e26bdd64e6f858ffa190395d23
> 
> >    What is the "upper layer"? What does it mean for kernel uAPI to be
> >    "experimental"? When does the "upper layer" get to run and how does
> >    it know that there are time stamps on the error queue?  
> 
> The socketopt only gets enabled with use of MGMT Set Experimental
> Feature Command:
> 
> https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L3205
> 
> Anyway you can see on the tests how we are using it.

Either I didn't grok the test or it doesn't answer my question.
What is the lower layer that we want to "protect" from POLLERR?

> > Would be great to get more info and/or second opinion, because it's not
> > sufficiently "obviously right" to me to pull right away :(  
> 
> Well I assumed sockopt starting with SO_ sort of means it applies that
> all socket families, in fact SO_TIMESTAMP already seem to work without
> these changes they just don't generate anything, so in a way we are
> just implementing a missing feature.

