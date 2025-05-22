Return-Path: <netdev+bounces-192805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE87AC11D3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B93B91C3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5217A303;
	Thu, 22 May 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0GZwZOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3915A85A;
	Thu, 22 May 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933556; cv=none; b=Ksy3j1Ym+Cz7+owdtC+ZF4w1IbEUEJmLzxCqhuaSqgd50T9+3AsRF8Js5KtHt7av3xJI0BOuUnbbpH97QMTGiP/HZSnwqpx2oGwVpSb4XFZ/ttb0HKKUU1WZNl9HesvRchXdLznwUY8EXBYsPB5NvGMCXiX1C0hztQw0nx18m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933556; c=relaxed/simple;
	bh=+IcaZUPJqDtryPZS76Dtv6skfKB9j/o6f3DRCfI3fmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pcn8pac9MWBoEbgEde3Ywu3AoWVii20NZZlFF7yAEI6yxj7osnzsn25cnhIHyLNt1iER9l0piO+A0Yygmhi3kGFMfJbRSWUUuhQpiAGszUse3nM+IfOSj6NGtyNu2cKQgIoTIvLpXQ5i3iqx2zUH8pe2QyrIvawHZKCBAIBbFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0GZwZOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7717C4CEE4;
	Thu, 22 May 2025 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747933555;
	bh=+IcaZUPJqDtryPZS76Dtv6skfKB9j/o6f3DRCfI3fmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0GZwZOqUaVFL8oHanem+nvJObGljjMI5vPTUBjQdoE2X6o0G85BjXxgfI1o1RwVl
	 MW1+0spfYs+vEzzrFPGTJCpXnV5+/2VXSsr6Ms63KDSIZ4Ww9w7ypqmtMc6csnOnhv
	 wY8R41uKjYTQFkEpD6TECaD8Ko0PbDYDhegkyEU4C98sOHPUS6MK6bXyXAaK2mQakh
	 apnIAFAi6ufJT+bxoXxqQ4dHcS4tCUPOFO1OqGgabZerI7JyiCTn7poj7ESKs8IgQ6
	 MxUUswyl8shpxwmj2ZM+TpIinek2wEG2q/9jvq+HGnoJSRkY3hONwSzECUVzVnjp/g
	 dgaNtjKaLvhFQ==
Date: Thu, 22 May 2025 10:05:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: bluetooth-next 2025-05-21
Message-ID: <20250522100554.1508420f@kernel.org>
In-Reply-To: <CABBYNZKEULqzfjZ9Yoa=h3bT88zx6dM9LHaNddSOYWkjqLBp+w@mail.gmail.com>
References: <20250521144756.3033239-1-luiz.dentz@gmail.com>
	<20250522095315.158eee1a@kernel.org>
	<CABBYNZKEULqzfjZ9Yoa=h3bT88zx6dM9LHaNddSOYWkjqLBp+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 13:02:43 -0400 Luiz Augusto von Dentz wrote:
> > On Wed, 21 May 2025 10:47:55 -0400 Luiz Augusto von Dentz wrote:  
> > > The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d312:
> > >
> > >   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading' (2025-05-20 20:00:55 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-05-21
> > >
> > > for you to fetch changes up to 623029dcc53837d409deb70b65eb7c7b83ab9b9a:
> > >
> > >   Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach() (2025-05-21 10:31:01 -0400)  
> >
> > Another bad fixes tag :( Time to automate this on your side?
> >
> > Commit: ee1d8d65dffd ("Bluetooth: L2CAP: Fix not checking l2cap_chan security level")
> >         Fixes tag: Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> > --
> > pw-bot: cr  
> 
> Will fix it, didn't we apply it to net already though? Seems like
> net-next doesn't have it yet.

I see, that's an extra complication, indeed.

I have net merged in locally, just waiting for builds to finish
before pushing. The commit in downstream trees has a different hash:

  522e9ed157e3 ("Bluetooth: l2cap: Check encryption key size on incoming connection")

