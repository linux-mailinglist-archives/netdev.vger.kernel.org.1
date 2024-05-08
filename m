Return-Path: <netdev+bounces-94642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579B8C009A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAD1C22ED0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630686AD6;
	Wed,  8 May 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c06nezEY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7328662F;
	Wed,  8 May 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180879; cv=none; b=CL9aiJwIyo+T2VrgcmdhkK3EYP+wpp8rlEZxgqnpNBp5EY2HxdMDBoCSG7tnhmVIa8pQTUvV42UdinayqRviLNeIXBafJhOU8Q9Llqgx4xgRtJVgFYpXLh7unxBcSyYRzzHZxmxtPZy4FrKAHyI6M2WX/d0OMuFTBe73VhkVX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180879; c=relaxed/simple;
	bh=GciHj+oZ2fXP+d0t8BBXmVMu4hdURU+8gmHOXySA124=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrG4ejC1OcC6XvAfgwTMTwKjH1RBDTDai/oL8CdMkJz4KxWrYRWcKADKge/sMxMjUCKZuqqZqG1CBio7T7aBSXoQr/B1tVkVDh07sSc+KxUnFVmgwuXt7CC5bE/i1AZ09N/F1vtQb5k07A9oEDdJJgRX2hs0OT4fcOrUUN64Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c06nezEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C6C2BD10;
	Wed,  8 May 2024 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715180879;
	bh=GciHj+oZ2fXP+d0t8BBXmVMu4hdURU+8gmHOXySA124=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c06nezEYl1LdgI3waamrNIV13kQ53qXqYx967MvYOeHk107qc5SkaRxjYeubzP6ie
	 hz+werFguJaxK+lyztT54imHkGIhQ27D/vzyOHxjGr39zwc9G9k4UoimMndoRNkNgk
	 zFDPHho/FwqxAgVDQHFk6N+l1HwmE2RalfF7gwtFIBuSQEAPWSikKTZkqjFcZBlX5I
	 vqM8k2tGwchCeEptTRpVQjIG5nGpj6qms6RZ3kzHZ+bYynoTks4CwZSQC+D4dYwVIP
	 yeOldfvyAMSs6Fhy3tO+XJm44g7N1fzoT2TaY7b87b/eukvuHH0IHf5xCUmUOB6KUu
	 cJI2tBOpR7zAA==
Date: Wed, 8 May 2024 08:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Message-ID: <20240508080757.5022b867@kernel.org>
In-Reply-To: <1478421.1715176828@warthog.procyon.org.uk>
References: <20240507194447.20bcfb60@kernel.org>
	<20240503150749.1001323-1-dhowells@redhat.com>
	<1478421.1715176828@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 May 2024 15:00:28 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > Looks like these got marked as Rejected in patchwork.
> > I think either because lore is confused and attaches an exchange with
> > DaveM from 2022 to them (?) or because I mentioned to DaveM that I'm
> > not sure these are fixes. So let me ask - on a scale of 1 to 10, how
> > convinced are you that these should go to Linus this week rather than
> > being categorized as general improvements and go during the merge
> > window (without the Fixes tags)?  
> 
> Ah, sorry.  I marked them rejected as I put myself as cc: not S-o-b on one of
> them, but then got distracted and didn't get around to reposting them.  And
> Jeff mentioned that the use of the MORE-PACKETS flag is not exactly
> consistent between various implementations.

Ah, mystery solved :)

> So if you could take just the first two for the moment?

Done!

