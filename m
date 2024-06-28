Return-Path: <netdev+bounces-107856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF391C9A9
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6711F22894
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 23:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F981729;
	Fri, 28 Jun 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNRXX4h/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3BBA53
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719618115; cv=none; b=Ksyfy++wubScN5WcppHbQBgGWFwUv+Hk8gZtjyOcUzQE+9My9hCcnTRO7cuioiG3pf0CrtyVQypmAI1CXFZPg0WO4cr/si/u/Ear0xXSOk9y4YD4Q5ejJBWX0mDOUHiqVYkAUSU/99LMqmcknTOKJUT7mBkKbuz4TbAewsnbJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719618115; c=relaxed/simple;
	bh=YODfp8zlPRhWJiNiEkofFT5h2hke+1lj+VZEjz9QmCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i91OrXOat08qPQPKudb30mshSytAGV+g+e4DtUqIoq+zVYK5aw9QXLZH1kk2dTeiBEhNz1fYAfPWKOlmA3QT4QBRusftMGkqXbZLnKEbe/7SDY2ZWBMyruAUev+VgbIvggjLyILx1KMMiqzqVqRnXSvRdJgJBiFrhWx2o63lq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNRXX4h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB16C116B1;
	Fri, 28 Jun 2024 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719618114;
	bh=YODfp8zlPRhWJiNiEkofFT5h2hke+1lj+VZEjz9QmCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNRXX4h/w0u8Qc+Hq1GFe89EG+KOttCyW0eUafDsI8JAfNtC8wDisHmGtYKdHoJbm
	 sub5F1tSs3pfdZC7EXc4OWeKw3ri50A1PgnXMPyKjUHxBAhi0MgMUaFKkB8RrVerk6
	 hu98ixi2Tuoeug9YomETTSICE0bc0FFvlvSpxmOCz8G1k8nxHqqGoiMzdf5wRfX/O2
	 qfnnICmgaWanHjrFquc6fNXn2A4SPR/yDDK1KHpf6vUMGZdm8zA4NRSckv3BedjHil
	 T24j7tzQQSXWhJFMek4HAWG9iIfZVDk7yc4tyOqHb2zbAXoQ1mWmWdj2ccgJAkw1Fm
	 fRcNd+QPNjT/Q==
Date: Fri, 28 Jun 2024 16:41:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lance Richardson <rlance@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240628164152.34b69c01@kernel.org>
In-Reply-To: <CAHWOjVL2hM4Lv=jNAv9CmLHYJL5ZBHmDH=ySQr7fr1Z6kgAvjg@mail.gmail.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<CAHWOjVJ2pMWdQSRK_DJkx7Q9zAzLx6mjE-Xr3ZqGzZFUi5PrMw@mail.gmail.com>
	<20240627153347.75e544ac@kernel.org>
	<CAHWOjVL2hM4Lv=jNAv9CmLHYJL5ZBHmDH=ySQr7fr1Z6kgAvjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 15:33:28 -0400 Lance Richardson wrote:
> > Interesting. Hm. But SADB drivers would then have to implement some
> > complex logic to make sure all rings have cycled, or take references.
> > I'd rather have an opt-in for core to delay reaping old keys until
> > all sockets which used them went empty at least once (in wmem sense).  
> 
> Right, ensuring that the old entry is no longer referenced by packets in the
> transmit pipeline before removing is definitely a concern. One simple
> approach is to simply keep the old entry around for long enough (e.g. a
> minute or two) to ensure that any packets referencing it have been transmitted.

Sounds good, we can opportunistically remove immediately if socket is
idle, otherwise use a timeout. I'll try to have the patches on GH
before I post v1, it won't all fit in one reviewable series.

