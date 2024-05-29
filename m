Return-Path: <netdev+bounces-99152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024C8D3D74
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA9B1F24CAA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80215B574;
	Wed, 29 May 2024 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYJn4JKg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7133C0
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004107; cv=none; b=F99lSc/kLn+Qjs+ALUEL+bcv/R18dbqZAngK0QdBkfBZOx19CSEdd4Rtf/gVxutQMBRiqdH6QbxgWr9YiHiezzrt6m6ocZqPdaS7o1J4tPEOxHqlKuNmu5NRoGDoffDzWW1agwWlFkBnOq1O/YI8LFPF8SNmufwPyLwFT4SgZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004107; c=relaxed/simple;
	bh=ItDmbwLW3q6IRlTRNcDoAhZqwZc1WSjCl3nxhra0VEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uws87e+exYS/fCD1W2heKUxuydozEeM8xq8KwePj2G0Ht8jfQTyI9GceRw584oX5P4YsUDK1uPMLLUEPRTZXMnsJeI5wNGcwv1u+N02S1hKNIg85jBMXIZA6Vek9CE0B6W6Hot8oyc+6opil5h3gnRCjWUkBT/RYAEek7gT/L9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYJn4JKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA87FC113CC;
	Wed, 29 May 2024 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004107;
	bh=ItDmbwLW3q6IRlTRNcDoAhZqwZc1WSjCl3nxhra0VEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYJn4JKgiL1ve/pwx2ejfJOZtF1UrXNsdZGusDa8Y/y/2a7HM1CQ6x8XzZSwq9XDO
	 Dz+p90Zjykhsxx7kZ/rPJ5MIRlnBEO3qobNwVgZ+CQfHNv9kq3k/q3/3A6qiZu4Pd/
	 QpjvANyFpdmSP+xCg98xx2gAqzVQHe1BM7zXmWyzWiKmGb8lScwzp7eu5ZX8xCb5ZM
	 b8X+xkBwInLxNozLrL1a28jI2zCI0TWH5xLG8tvNDNNECIQWRADMH3WJIt70j74F/B
	 PFTNgBgjO8WCocL6j5BlgWj+diEvEJapJL5wR9AO+3/cC8Krd26qmltTLnN3mQOdmL
	 bEJPK2/0Tb9LQ==
Date: Wed, 29 May 2024 10:35:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240529103505.601872ea@kernel.org>
In-Reply-To: <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 May 2024 21:24:23 -0400 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > +PSP Security Protocol (PSP) was defined at Google and published in:
> > +
> > +https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
> > +
> > +This section briefly covers protocol aspects crucial for understanding
> > +the kernel API. Refer to the protocol specification for further details.
> > +
> > +Note that the kernel implementation and documentation uses the term
> > +"secret state" in place of "master key", it is both less confusing
> > +to an average developer and is less likely to run afoul any naming
> > +guidelines.  
> 
> There is some value in using the same terminology in the code as in
> the spec.
> 
> And the session keys are derived from a key. That is more precise than
> state. Specifically, counter-mode KDF from an AES key.
> 
> Perhaps device key, instead of master key? 

Weak preference towards secret state, but device key works, too.

> > +Derived Rx keys
> > +---------------
> > +
> > +PSP borrows some terms and mechanisms from IPsec. PSP was designed
> > +with HW offloads in mind. The key feature of PSP is that Rx keys for every
> > +connection do not have to be stored by the receiver but can be derived
> > +from secret state and information present in packet headers.  
> 
> A second less obvious, but neat, feature is that it supports an
> encryption offset, such that (say) the L4 ports are integrity
> protected, but not encrypted, to allow for in-network telemetry.

I know, but the opening paragraph has:

   This section briefly covers protocol aspects crucial for
   understanding the kernel API. Refer to the protocol specification for further details.

:) .. and I didn't implement the offset, yet. (It's trivial to add and
ETOOMANYPATCHES.)

> > +This makes it possible to implement receivers which require a constant
> > +amount of memory regardless of the number of connections (``O(1)`` scaling).
> > +
> > +Tx keys have to be stored like with any other protocol,  
> 
> Keys can optionally be passed in descriptor.

Added: Preferably, the Tx keys should be provided with the packet (e.g.
as part of the descriptors).

> > +The expectation is that higher layer protocols will take care of
> > +protocol and key negotiation. For example one may use TLS key exchange,
> > +announce the PSP capability, and switch to PSP if both endpoints
> > +are PSP-capable.  
> 
> > +Securing a connection
> > +---------------------
> > +
> > +PSP encryption is currently only supported for TCP connections.
> > +Rx and Tx keys are allocated separately. First the ``rx-assoc``
> > +Netlink command needs to be issued, specifying a target TCP socket.
> > +Kernel will allocate a new PSP Rx key from the NIC and associate it
> > +with given socket. At this stage socket will accept both PSP-secured
> > +and plain text TCP packets.
> > +
> > +Tx keys are installed using the ``tx-assoc`` Netlink command.
> > +Once the Tx keys are installed all data read from the socket will
> > +be PSP-secured. In other words act of installing Tx keys has the secondary
> > +effect on the Rx direction, requring all received packets to be encrypted.  
> 
> Consider clarifying the entire state diagram from when one pair
> initiates upgrade.

Not sure about state diagram, there are only 3 states. Or do you mean
extend TCP state diagrams? I think a table may be better:

Event         | Normal TCP      | Rx PSP key present | Tx PSP key present |
---------------------------------------------------------------------------
Rx plain text | accept          | accept             | drop               |

Rx PSP (good) | drop            | accept             | accept             |

Rx PSP (bad)  | drop            | drop               | drop               |

Tx            | plain text      | plain text         | encrypted *        |

* data enqueued before Tx key in installed will not be encrypted
  (either initial send nor retranmissions)


What should I add?

> And some edge cases:
> 
> - retransmits
> - TCP fin handshake, if only one peer succeeds

So FIN when one end is "locked down" and the other isn't?

> - TCP control socket response to encrypted pkt

Control sock ignores PSP.

> What is the expectation for data already queued for transmission when
> the tx assocation is made?
> 
> More generally, what happens for data in flight. One possible
> simplification is to only allow an upgrade sequence (possibly
> including in-band exchange of keys) when no other data is in
> flight.

Like TLS offload, the data is annotated "for encryption" when queued.
So data queued earlier or retransmits of such data will never be
encrypted.

> > +performed by management daemons, not under application control.
> > +The PSP netlink family will generate a notification whenever keys
> > +are rotated. The applications are expected to re-establish connections
> > +before keys are rotated again.  
> 
> Connection key rotation is not supported? I did notice that tx key
> insertion fails if a key is already present, so this does appear to be
> the behavior.

Correct, for now connections need to be re-established once a day.
Rx should be easy, Tx we can make easy by only supporting rotation
when there's no data queued.

