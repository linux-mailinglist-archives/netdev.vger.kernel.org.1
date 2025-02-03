Return-Path: <netdev+bounces-162264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD10A265BA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078597A05E5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB51FDE29;
	Mon,  3 Feb 2025 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1vbASGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA50A31;
	Mon,  3 Feb 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618491; cv=none; b=Fiq+oqC0vhS9aXC/2OCfzdkWd5MNAvmMix+NooT0yZmbqHUuvFDPTOlkJV0uHWX96AqveVRe41WJT/NOdgDLguWNRj9beIMcAogrhKb8352RAfxHxk3+xmD0p86HROkY7pn7uIgvbZYw1CmNVQWZX9MoWTuTu8VdRt2DoIE55bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618491; c=relaxed/simple;
	bh=DSI1vKImG1avYG1UPdI/lYBxPumkdumlKB1g32F1K7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LV6B3vhe7VW3/kGeUsDKyN5jWF3JcCabpc41RusEwuDKm4Fpo1uryevzf6tTtIxEDVdxb4NsCq3p4DJrR+IauRSiUY9yROUtTw2qnp86dvAus39CNMZf/3VrYlSjWicD9F+871sTIxMxcy1+Gzkfcyee8vQSH2lMKVK74bH1FWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1vbASGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB529C4CED2;
	Mon,  3 Feb 2025 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618490;
	bh=DSI1vKImG1avYG1UPdI/lYBxPumkdumlKB1g32F1K7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O1vbASGSn3BM3qbaxvFtrDQA28D3rN0cFELq3FBx99FAqYyAbqTsFLZ8eo1npNlMd
	 sEQraG/Kl8loOTXtWY6+bH/jz8xijP7UwTXZ5y1/G0EpES++qNuklugWOVq5yX10qL
	 gfvx4xK1oMDl8e97QNs7hW63rcBLBbmpsm+Jv08E5QUUXYkOv1aJCSotsswwfHmpC/
	 Jh3T/CI5tP9IbhRuh7USZTzVz9LW0J761qayH+hvwtjRzAJYe9rIooRzaU85MF04So
	 YjvUbGTb0oDd+AUVfCDZrcJgd6k3r/DU96cSA7P/4aIG2wrqYr1HMJCacxiylfYQ0b
	 h8VENOiJAHd7A==
Date: Mon, 3 Feb 2025 13:34:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: Add mock device
Message-ID: <20250203133449.287502ee@kernel.org>
In-Reply-To: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>
References: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Feb 2025 20:50:46 +0100 Thomas Wei=C3=9Fschuh wrote:
> While working on the PTP core or userspace components,
> a real PTP device is not always available.
> Introduce a tiny module which creates a mock PTP device.

FTR we (netdev) do not accept mock devices unless there are selftests
which exercise them in a meaningful way. Otherwise we get a stream
of impossible to judge patches for such devices :(

