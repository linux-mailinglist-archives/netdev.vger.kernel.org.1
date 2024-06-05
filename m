Return-Path: <netdev+bounces-100790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D208FC04E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331261F23183
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2B383;
	Wed,  5 Jun 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNGnOgNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF636C
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546131; cv=none; b=e2W42MUQuRdSLqiTgZ1pJsMsfLYNNuataPSd+fzzq2EN7d6tCLRW1ip2S6KMe62Oe0SY6u0ZCAb+KhyIgyUo/P6fBVEoax9VaB9BHkdEhasMTkrzPTTTF/6lpquy/2VhfPJmC3oxh2jq+xSdHmFRaIb1bBUNKYVfPbyBc/ERQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546131; c=relaxed/simple;
	bh=j1ePnyIJoB2sT/cayy3Re9NWXNLwO8fMH9gtHPjuTjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WonxYtBvfP3bkAlfdlx8adUaEED6j5gQ4bfXtdZvEOhTcx43Lcq+PWKCyLCU3NCk9F7TKhxMk6ayLXotKiBA9pqG1QY8t4a1gF8GwM143CjEEIjff4/h2ZQ8dMlmNiY9XDpOIhNkuqXMzKBI4SRW3DpGNXZRIXd3qZo/CASCaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNGnOgNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C626CC2BBFC;
	Wed,  5 Jun 2024 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546131;
	bh=j1ePnyIJoB2sT/cayy3Re9NWXNLwO8fMH9gtHPjuTjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cNGnOgNgA3CYKq0gmAI31/sKP5/RNMqQsQE3lw+x1IVX/t3Q46/+taO1b4aKSh15x
	 hKtIS5jx2ulv9Svo2Ox4xCT78k+ZOiOX5vJhEtBBqAll2qUa2jcIb79+E63R1QVcpK
	 LzQCZiiJHAh763EB2dl7NvdgYTuPoscJQ6JRKBj36Rotc3gcf0Hxh2sGys50lCJ/CR
	 8IZ09jdmwNtOraWJHjmdxhd1XoBJWelAvTWBJl7QNt82wFe5eqJ0k6si1CNDg2v+sX
	 SySNdN7zbXIMihscVCr7vBh47fzzIA2UZUW6YnOLxcvH7r10ws71QdACNYA4DQ07zz
	 ZWwUFtc1okeKg==
Date: Tue, 4 Jun 2024 17:08:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com, mingtao@meta.com,
 knekritz@meta.com, Lance Richardson <lance604@gmail.com>
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240604170849.110d56c1@kernel.org>
In-Reply-To: <6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
	<20240530125120.24dd7f98@kernel.org>
	<6659d71adc259_3f8cab29433@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 09:56:42 -0400 Willem de Bruijn wrote:
> > > If one peer can enter the state where it drops all plaintext, while
> > > the other decides to close the connection before completing the
> > > upgrade, and thus sends a plaintext FIN.
> > > 
> > > If (big if) that can happen, then the connection cannot be cleanly
> > > closed.  
> > 
> > Hm. And we can avoid this by only enforcing encryption of data-less
> > segments once we've seen some encrypted data?  
> 
> That would help. It may also be needed to accept a pure ACK right at
> the upgrade seqno. Depends on the upgrade process.
> 
> Which may be worth documenting explicitly: the system call and network
> packet exchange from when one peer initiates (by generating its local
> key) until the connection is fully encrypted. That also allows poking
> at the various edge cases that may happen if packets are lost, or when
> actions can race.

Dunno if the format below is good, but you're very right.
At least to me writing the diagram was an hour well spent :)

> One unexpected example of the latter that I came across was Tx SADB
> key insertion in tail edge cases taking longer than network RTT, for
> instance.
> 
> The kernel API can be exercised in a variety of ways, not all of them
> will uphold the correctness. Documenting how it should be used should
> help.
> 
> Even better when it reduces the option space. As it already does by
> failing a Tx key install until Rx is configured.

Something along these lines?

"Sequence" diagram of the worst case scenario:

01 p       Host A                         Host B
02 l t        ~~~~~~~~~~~[TCP 3 WHS]~~~~~~~~~~
03 a e        ~~~~~~[crypto negotiation]~~~~~~
04 i x                             [Rx key alloc = K-B]
05 n t                          <--- [app] K-B key send 
06 ------[Rx key alloc = K-A]-
07     [app] K-A key send -->|
08        [TCP] K-B input <-----
08 P      [TCP] K-B ACK ---->|
09 S R [app] recv(K-B)       |
10 P x [app] [Tx key set]    |  
11 -------------------------- 
12 P T [app] send(RPC) #####>|   
13 S x                       |<----    [TCP] Seq OoO! queue RPC, SACK
14 P      [TCP] retr K-A --->|   
15                           |  `->    [TCP] K-A input
16                           | <---    [TCP] K-A ACK (or FIN) 
17                           |      [app] recv(K-A)
18                           |      [app] [Tx key set]
19                            -----------------------------------
20

There is a causal dependency between Host B allocating the key (line 4),
sending it (line 5) and Host A receiving it (line 8). Since Host B will
accept PSP packets as soon as it allocated the key, Host A does not
need to wait to start using the key (line 12). Host B will queue the
RPC to the socket (line 13).

[Problem #1]

However, because Host B does not have a Tx key, the ACK / SACK packet
(line 13) will not be encrypted. (Similarly if Host B decided to close
the connection at this point, the resulting FIN packet would not be
encrypted.) Host B needs to accept unencrypted non-data segments 
(pure acks, pure FIN) until it sees an encrypted packet from Host B.

[Problem #2]

The retansmissions of K-A are unencrypted, to avoid sending the same
data in encrypted and unencrypted form. This poses a risk if an ACK
gets lost but both hosts end up in the PSP Tx state. Assume that Host A
did not send the RPC (line 12), and the retransmission (line 14)
happens as an RTO or TLP. Host B may already reach PSP Tx state (line
"20") and expect encrypted data. Plain text retransmissions (with
sequence number before rcv_nxt) must be accepted until Host B sees
encrypted data from Host A.


With that I think the state machine needs to be amended:

Event          | Normal TCP  | Rx PSP      | Tx PSP      | PSP full    |
-----------------------------------------------------------------------
Rx plain (new) | accept      | accept      | drop        | drop        |

Rx plain       | accept      | accept      | accept      | drop        |
(ACK|FIN|rtx)  |             |             |             |             |

Rx PSP (good)  | drop        | accept      | accept      | accept      |

Rx PSP (bad    | drop        | drop        | drop        | drop        |
(crypt, !=SPI) |             |             |             |             |

Tx             | plain text  | plain text  | encrypted   | encrypted   |
               |             |             | (excl. rtx) | (excl. rtx) |

> > > Another example where a peer stays open and stays retrying if it has
> > > upgraded and drops all plaintext.  
> 
> May want to always allow plaintext RSTs. This is a potential DoS
> vector.

Because of key exhaustion? Or we can be tricked into spamming someone
with retranmissions and ignoring their RST?

> In all these cases, I suppose this has already been figured
> out for TLS.

Assuming the answer above is "key exhaustion" - I wouldn't be surprised
if it wasn't :(

