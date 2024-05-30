Return-Path: <netdev+bounces-99530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BECE8D52A9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7061C24053
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF104D8B4;
	Thu, 30 May 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Qnlyyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FD433CA
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098681; cv=none; b=vF6Pw7x5tGn+taq+SbOq9SI8mhwowhhXMf6gMCXaI7MDSYzOCq3jsSmDOZhQvqktDSxrn9kS/ZA/uux9hMKNuxps0RycMOG2MtYMiqDySVlmyO02InLULZAltYd5uKSb2v1pTkJ4jLtOvjAcZBv8uXwXjnSNYl992AXLcDLx6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098681; c=relaxed/simple;
	bh=Nmyr7uAPtsAyXazRNmlPBONrlaTM8kyZdNQhI1/Uu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6K1ZdjhzIGkeMKX4ZiNMFLud7+KfiqudV4/IHL1oh2/nEB4P487oSvBhhKnCIGIcFA3O0ugwc7a/8OZdZIvWkPImhq6dGXwm4VLwfezkNNIcZ2oGtXECINGYGqcGLklN+IKQ0F+zi/GUgKQbiuz8H8KjHYYz/DV1F6M0DBqrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Qnlyyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF33C2BBFC;
	Thu, 30 May 2024 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717098681;
	bh=Nmyr7uAPtsAyXazRNmlPBONrlaTM8kyZdNQhI1/Uu/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S1QnlyypfObe38HRI+ORTwCzTVCreNCGd6qUIHtXtKtCDXHnEcRClmrXIhVWTWFLO
	 kkMeuM2i0qMTl84kf+YB8WI3o8uzbFIe2Z+AWaLzVNRhgLQe7B0M69/Yb0kEd2Ai6g
	 +Sy2da6cPTo5ZfA74QE1KnqPKtjINX5r+PUpFHeJ/KG3quwNA36LN3MyNAdpH3ODOG
	 Dcc4oErWwlKvTQPcKEFZh+BvFG2rIt5PhgV3K+qIAp2dZ+mCjcDRpN7oC7UD477rYY
	 auCu5hfP34JVl1Tf7dH72JIu+InlHzdW6Sn/EzpW1KWxQsNnJgFH3cJ8UOJTqAEMUR
	 P/ap59hUqIirA==
Date: Thu, 30 May 2024 12:51:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240530125120.24dd7f98@kernel.org>
In-Reply-To: <6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 20:47:02 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Sun, 12 May 2024 21:24:23 -0400 Willem de Bruijn wrote:  
> > > There is some value in using the same terminology in the code as in
> > > the spec.
> > > 
> > > And the session keys are derived from a key. That is more precise than
> > > state. Specifically, counter-mode KDF from an AES key.
> > > 
> > > Perhaps device key, instead of master key?   
> > 
> > Weak preference towards secret state, but device key works, too.  
> 
> Totally your choice. I just wanted to make sure this was considered.

Already run the sed, device key it is :)

> > > Consider clarifying the entire state diagram from when one pair
> > > initiates upgrade.  
> > 
> > Not sure about state diagram, there are only 3 states. Or do you mean
> > extend TCP state diagrams? I think a table may be better:
> > 
> > Event         | Normal TCP      | Rx PSP key present | Tx PSP key present |
> > ---------------------------------------------------------------------------
> > Rx plain text | accept          | accept             | drop               |
> > 
> > Rx PSP (good) | drop            | accept             | accept             |
> > 
> > Rx PSP (bad)  | drop            | drop               | drop               |
> > 
> > Tx            | plain text      | plain text         | encrypted *        |
> > 
> > * data enqueued before Tx key in installed will not be encrypted
> >   (either initial send nor retranmissions)
> > 
> > 
> > What should I add?  
> 
> I've mostly been concerned about the below edge cases.
> 
> If both peers are in TCP_ESTABLISHED for the during of the upgrade,
> and data is aligned on message boundary, things are straightforward.
> 
> The retransmit logic is clear, as this is controlled by skb->decrypted
> on the individual skbs on the retransmit queue.
> 
> That also solves another edge case: skb geometry changes on retransmit
> (due to different MSS or segs, using tcp_fragment, tso_fragment,
> tcp_retrans_try_collapse, ..) maintain skb->decrypted. It's not
> possible that skb is accidentally created that combines plaintext and
> ciphertext content.
> 
> Although.. does this require adding that skb->decrypted check to
> tcp_skb_can_collapse?

Good catch. The TLS checks predate tcp_skb_can_collapse() (and MPTCP).
We've grown the check in tcp_shift_skb_data() and the logic
in tcp_grow_skb(), both missing the decrypted check.

I'll send some fixes, these are existing bugs :(

> > > And some edge cases:
> > > 
> > > - retransmits
> > > - TCP fin handshake, if only one peer succeeds  
> > 
> > So FIN when one end is "locked down" and the other isn't?  
> 
> If one peer can enter the state where it drops all plaintext, while
> the other decides to close the connection before completing the
> upgrade, and thus sends a plaintext FIN.
> 
> If (big if) that can happen, then the connection cannot be cleanly
> closed.

Hm. And we can avoid this by only enforcing encryption of data-less
segments once we've seen some encrypted data?

> > > - TCP control socket response to encrypted pkt  
> > 
> > Control sock ignores PSP.  
> 
> Another example where a peer stays open and stays retrying if it has
> upgraded and drops all plaintext.

