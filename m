Return-Path: <netdev+bounces-127980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66013977632
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F7E284F23
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA11FBA;
	Fri, 13 Sep 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH6ufpB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FDA59;
	Fri, 13 Sep 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726188368; cv=none; b=E4Q0I9vLWLd9788Bs8S0E+9d0Etrps6MgGT3+4uLu60gIrjB3ak8EaTNph2gqdvHCfKhcy7KJ6r9UZbmjuCfdxge51twyV1EAjGD01i4SE19hwUy9wKpXXjD/YrK43gymYlkNJcJiBHnjnT+ybZl5kMMGiIHeGLlZvVHaha10bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726188368; c=relaxed/simple;
	bh=okrO9J2eaHkDTmcWg9GzHl26lCb/j+s27cVNH2FA38w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bjsv+8oQXhv9R2UJc5ZjOQk9gzi78ZxIdS7G5WZTAKIEZFDXrH1eQOwauIs8YJxyoaAWZmBWjmCF8BffYZ1MBZChtY1oP1K/SmYfwjllvwOUlp4Ja0x+J0nZWKsj9++jfk9InNMUiqHCcvDUVXl5W1u+9ZZKyvVYgMZzI9VkfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH6ufpB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FB3C4CEC3;
	Fri, 13 Sep 2024 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726188367;
	bh=okrO9J2eaHkDTmcWg9GzHl26lCb/j+s27cVNH2FA38w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oH6ufpB97kd/t6+5JhZHck2GzKWWO5hfSxIVNQnkipec40T3A7lEBD3eV3uHGeoY+
	 px6iapSJidNAnrCE9u0UbyMI7JJWNV/dPwLfPFBuVsxCiQHYTnleoyup0aN+VWf+wT
	 bOxBL39p3znKchWmZPrgwTb2huUOpfd3467zg8QI4+/7nlgh9tHRDsbPO++V1/gMuv
	 Fee5GEDqPNPSeEP98zWXP4FmfxmSFgQtRTFpsw9zWLTM+JflP6TVB8a22C35mYqjNy
	 9LBrKI7TGqDPDH3lmgiOdme9Vad8JQWJQ2dtVrsAGfccyn/Ao6s4XvTlFZLML0nUUv
	 3nmZGVJ8NKxug==
Date: Thu, 12 Sep 2024 17:46:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Juhl <jesperjuhl76@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: igc: Network failure, reboot required: igc: Failed to read reg
 0xc030!
Message-ID: <20240912174606.3f008a47@kernel.org>
In-Reply-To: <CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
	<CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
	<20240912083746.34a7cd3b@kernel.org>
	<CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 21:45:17 +0200 Jesper Juhl wrote:
> > Would you be able to decode the stack trace? It may be helpful
> > to figure out which line of code this is:
> >
> >  igc_update_stats+0x8a/0x6d0 [igc
> > 22e0a697bfd5a86bd5c20d279bfffd
> > 131de6bb32]  
> 
> Of course. Just tell me what to do.

TBH I don't work much with distro kernels so I don't know.
There is a script for decoding stack traces in the tree:
  ./scripts/decode_stacktrace.sh
but it needs vmlinux (uncompressed) with full(ish) debug info.
I think that distros split the debug symbols out?

