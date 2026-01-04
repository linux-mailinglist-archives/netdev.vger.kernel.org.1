Return-Path: <netdev+bounces-246705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F206ECF0890
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 03:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E6A3005BBB
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 02:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AF279DB3;
	Sun,  4 Jan 2026 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiVWgph6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E374277037
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493673; cv=none; b=NHJU9nsbiRsA7RX2sP9xwzW8POi8cEGyHXI6I/VEXkCt0qVvwMpTGkaU4zIG1BqdYT6Ls6bzs06jcnA/ETE08e/Wad4mCGfjDJvoxwa6sAxRIK8X+5U/8+SmalfsGf8GYZaL+mLeEwfu+6owJ9WW74hmTjAbGtXSiAylIXh8Ek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493673; c=relaxed/simple;
	bh=Jy6TDFwUPDml9oKiitvqE6DAOXraFJqVSifSbB0f39w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX7zVp3UwE49n/OIvLXOFjsGeXwTT6gVf3Km3yt2KqFOzqqDWT8G6CEkI4RPGb0pqPRsg5D4woReUkLirLGlmELq+vBf7nqVyH+TaInRnB7UO53LkFQFQvHyiU92MFjVhF2vBcQ9Kn8wraN1okzPPCj9uqXR3WvQB+g6TKUkbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiVWgph6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAB7C2BC86
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 02:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767493673;
	bh=Jy6TDFwUPDml9oKiitvqE6DAOXraFJqVSifSbB0f39w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QiVWgph6HOoREcuAc3od3wH+b5hy+SyDqGD9IOr9j1+ILAJMRsDmRm+j0VwB0xC/J
	 JF7M4NrJN2ryJED/wlov9YOM4lL9tqGUj4uzYSIDiSicZC77zcUX1c5Va6n85qFQ7F
	 iy9K5arKY2PeuJnyQYcFAIq5OMuFCZxT/GsZOrg1S8PErvj0Hn+b56mRe/PrfSOsKk
	 ndlOi74im5TXbVC+Fmy0k0deybvqZmg1ZMX5YBqPssNbFvGrJyofFEuZlkliri5smf
	 aHCKqdsqNqZKKw8iKyguorA3YgAbX2FsqKPSjxE3MWsS6bEsbgwU1RK+R5AkryfOay
	 ZwqPnD071CP0g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso118125501fa.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 18:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW66CHFgVSfaisv6Fw0bmIdNoSiQi/dOizgu5dPJdjxX00/3MlTit1ZBBL2sFKHnzADwmV7zHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9otk+JfmqXy4nAdbplpWrf+EFB1PnARgpW0g5I+70OyIB2us
	PKiaKHFYcpPvz5hzqLHQoDDsmhvqJY4hOqpsQkStHhW3KMWgEL50ESIpoKFVKV16Mxa6DzABn9U
	7fNCLp9VeXTVWnm6X6+pCpShuA2sxcb8=
X-Google-Smtp-Source: AGHT+IGEGbu36+0tuWAcRgk/H4tDD24+EljSx96wqwIwVX/GWfQgrTK08uP/mRgkKmr3P6MKvJoJuX1FPpe3i3s5ZTw=
X-Received: by 2002:a2e:a804:0:b0:37f:af63:c382 with SMTP id
 38308e7fff4ca-3812158e409mr131822321fa.13.1767493671580; Sat, 03 Jan 2026
 18:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
 <20251222-cstr-net-v1-2-cd9e30a5467e@gmail.com> <44fd3760-5a01-43b4-ae68-31e6d3c18dc3@redhat.com>
 <CAJ-ks9kQj0bSAA0j0MRhbvSk7OkMqAaFuw+TsS9HMEgjqyW6Cw@mail.gmail.com>
In-Reply-To: <CAJ-ks9kQj0bSAA0j0MRhbvSk7OkMqAaFuw+TsS9HMEgjqyW6Cw@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 3 Jan 2026 21:27:15 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=eeg0fsLurb2fJR4mCnQOFxt0aJTEfbiKAn+0LT9=xNw@mail.gmail.com>
X-Gm-Features: AQt7F2qY-VrA1gX-FyPK2vHgBMSSeBV9Twrrj8NOQNkN7qgs6RvRhcJyNr58-sA
Message-ID: <CAJ-ks9=eeg0fsLurb2fJR4mCnQOFxt0aJTEfbiKAn+0LT9=xNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: net: replace `kernel::c_str!` with C-Strings
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:27=E2=80=AFAM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> On Tue, Dec 30, 2025 at 5:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 12/22/25 1:32 PM, Tamir Duberstein wrote:
> > > From: Tamir Duberstein <tamird@gmail.com>
> > >
> > > C-String literals were added in Rust 1.77. Replace instances of
> > > `kernel::c_str!` with C-String literals where possible.
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Reviewed-by: Benno Lossin <lossin@kernel.org>
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  drivers/net/phy/ax88796b_rust.rs | 7 +++----
> > >  drivers/net/phy/qt2025.rs        | 5 ++---
> > >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > It's not clear to me if this is targeting the net-next tree. In such ca=
se:
> >
> > ## Form letter - net-next-closed
> >
> > The net-next tree is closed for new drivers, features, code refactoring
> > and optimizations due to the merge window and the winter break. We are
> > currently accepting bug fixes only.
> >
> > Please repost when net-next reopens after Jan 2nd.
> >
> > RFC patches sent for review only are obviously welcome at any time.
>
> Yes, this is targeting net-next (unless you folks are OK with it going
> through rust-next, which is also OK with me). Thank you for including
> the date to resend.

v2 (same as v1 + tags):
https://lore.kernel.org/all/20260103-cstr-net-v2-0-8688f504b85d@gmail.com/.

Cheers.

Tamir

