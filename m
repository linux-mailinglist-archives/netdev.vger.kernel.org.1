Return-Path: <netdev+bounces-28521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E777FB23
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2522820C7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D143156FC;
	Thu, 17 Aug 2023 15:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAF14011;
	Thu, 17 Aug 2023 15:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07921C433C7;
	Thu, 17 Aug 2023 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692287329;
	bh=uk4TBZhJDCJb/PJgfGwfebt7sQtNGiZfM7nXbfcGbC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g1UCv6HKMAnBfD+Ylvjm/RzbmJ3983m4GeWrNiJmDc9+ZhSEAuQ22EkfYkgC5WO2e
	 OsQbNftPSyzFF4iDTSoCiDiYwxEkv2SCky786hVZhmVKgdlca5KPF0eo6Ae9Of0DQC
	 g/M+sVWBCKCySLzf6WygdfKnv0v/oJZjBvxU6HAPnv2UN2g+SixsTMrgZ7NNTeCNvm
	 9yaD3B5ri0wc63f0tAbnG54wdWLhANXmaQ8UO/yzwKzvIpuD5Px4XrK/3DWe8uVFZD
	 PNGBm37wzNzc79Hmb2gR5No5lm3VdCMJi9hyDZnkrnh6vrF76cSgOQ2o9PpKS5+RQH
	 5T54UTl+H5TYQ==
Date: Thu, 17 Aug 2023 08:48:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michele Dalle Rive <dallerivemichele@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice
 Ryhl <aliceryhl@google.com>, Davide Rovelli <davide.rovelli@usi.ch>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <20230817084848.4871fc23@kernel.org>
In-Reply-To: <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
	<2023081411-apache-tubeless-7bb3@gregkh>
	<0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
	<CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
	<e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
	<CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 16:53:03 +0200 Michele Dalle Rive wrote:
> in the last few days, I had the opportunity to discuss with some people from
> the RustForLinux community.
> 
> I apologize for not being clear: the goal of these APIs was to give some
> network support to, in particular, out-of-tree modules; they were not meant to
> be used by a specific module that was planned to get upstreamed as well.
> The idea behind this patch is that, as of now, Rust is not a viable option for
> any OOT module that requires even the highest-level network support.
> 
> I am wondering whether the `net` subsystem is interested in reviewing, giving
> feedback and eventually accepting code that is currently OOT-only.

This is a bit concerning. You can white out Rust in that and plonk in
some corporate backed project people tried to cram into the kernel
without understanding the community aspects. I'm not saying it's 
the same but the tone reads the same.

"The `net` subsystem" have given "the RustForLinux community" clear
guidance on what a good integration starting point is. And now someone
else from Rust comes in and talk about supporting OOT modules.

I thought the Rust was just shaking up the languages we use, not the
fundamentals on how this project operates :|

