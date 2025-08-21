Return-Path: <netdev+bounces-215681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68433B2FDD4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC41C227D6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B30258CCE;
	Thu, 21 Aug 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8xRoN7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8D22FDE6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788614; cv=none; b=IECcmRqAN9alYzK/C4wOL2qHAUw+DBIutSwSaMJLEx8b++cPIRFEL/wSQjLm9GSk2iPpZnX/fTIcoJnoUgGuqpQriHOmUwXoV+joVhYtxCba0ig2IF98iunoxpM5ZDcIC0JG1WxIjGtalXlBzwYxUj0R+dVzG2Q4bEGOEG55HGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788614; c=relaxed/simple;
	bh=Fnwq/oTVD3IaJtkpXyB88i3zr/1jrqaavDjbvCcLXlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i240x5/TBmmqL9i5rzW57ESWq5cNHpTD2RFPsRQRrNeK+1yfh1814ZzRJPihe7lnkqb9l0b8tZk6lykqioPZbTukKv8uYYzDQ2b+btVHc+7fsyUIg7EJbpURt7x5Iw2hmD2V+c87cl8LkUmsi8I8PR8yBEbFB8G+83xFoxFwvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8xRoN7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06581C4CEEB;
	Thu, 21 Aug 2025 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788613;
	bh=Fnwq/oTVD3IaJtkpXyB88i3zr/1jrqaavDjbvCcLXlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p8xRoN7/3hPHJrN8auRWh/GfNxDA0gxrbo9S1pyGrIEqAQZ8BXa9gNtrEm03fCES+
	 n9JfJjv90qn4SLTqrNF1TQWhan/9WXxdJG1m7mKqsuEINqbl7raYvvhuznYlgOuMoA
	 JERRe6Uw1+lTy9AVRENjZ7AcaPnxgYOyEvscH/uN/r7DHfcHgAVuCyxqEdzUZLhpp6
	 7arxKFOIpeZTMQVN5hWgZ0/8VxgMO021b/jOIUg0pp1MSeiqL8BUCZsFaAa2PGOt2x
	 B39Zp6MuGZ9qRzT4Tt4CB4TV22rLOznM7lqrRiol6U5z+Y5ggZPqCVx9xZTuzsz1mN
	 dcTtt4fO3isHQ==
Date: Thu, 21 Aug 2025 08:03:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, michael.chan@broadcom.com, tariqt@nvidia.com,
 dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 alexanderduyck@fb.com, sdf@fomichev.me, davem@davemloft.net
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
Message-ID: <20250821080332.7282db12@kernel.org>
In-Reply-To: <CAMArcTW7jTEE1QyCga5mpt+PLb1PDAozNSOwn8D7VwNYBp+xTg@mail.gmail.com>
References: <20250820025704.166248-1-kuba@kernel.org>
	<5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
	<20250821072832.0758c118@kernel.org>
	<CAMArcTW7jTEE1QyCga5mpt+PLb1PDAozNSOwn8D7VwNYBp+xTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 23:53:37 +0900 Taehee Yoo wrote:
> > I haven't looked closely either :) but my gut feeling is that this
> > is because the devmem test doesn't clean up after itself. It used to
> > bail out sooner, with this series is goes further in messing up the
> > config, and then all tests that run after have a misconfigured NIC..
> >
> > Taehee, are you planning to work on addressing that? I'm happy to fix
> > it up myself, if you aren't already half way done with the changes
> > yourself, or planning to do it soon..  
> 
> Apologies for the delayed action.
> I would appreciate it if you could address this issue.

Will do, thanks!

Let me apply the first patch of this series, and the rest has to wait
until I fix the devmem test, I guess.

