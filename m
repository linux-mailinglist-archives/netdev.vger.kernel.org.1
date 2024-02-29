Return-Path: <netdev+bounces-76196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0686CBA8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F691F23834
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7D7D3F9;
	Thu, 29 Feb 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15aNYzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935734EB5F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217267; cv=none; b=FXdIb2eV4qZnYvKrGnPpbMzv7PwQiwQCjyr+qWrgb1eQjqogBsxla0j6PHESsaKf8tj+TIZqj7B8zYlAfmEaSzBVLgyZlVZtDYSh4DTRBKo8F9Lsb5gqDiaYG2GRVU7IVcg3o1G3bCM2+G5ZrJp/ZVstViss9kVO5aDRNr8f/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217267; c=relaxed/simple;
	bh=bEYrVNSNnDLRRGJ6XNrRzPrM3pBTYO5Qxzh1Y1dskgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5JBHiOldMCbn8HlyHase/QzlHjEiJidMVRGILXkwoCXL3I+RCQ6pTbG4pJ9PlBKKkDufh8XPOAqR8iPIpbr8/qGUydwOuz1YId2/fzau/vibOmhtozZyOnj4+HATip+Agk5ul+UMc0lf0qw2gNLsSWoZyUUqpHFAWN9Ag9CC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15aNYzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8DFC433C7;
	Thu, 29 Feb 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709217267;
	bh=bEYrVNSNnDLRRGJ6XNrRzPrM3pBTYO5Qxzh1Y1dskgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l15aNYzlxv1dOvwhM6r8VIs/X0CN+B+fR4w/PJbodL9TDAqQmarcCD0rNzIdGkeOb
	 zP7M0Mz3xiDIN02m4QtYxaHNJIguTr28Zw4SyorbXxS0+phMEBQcF6Ig8gEo+AvlnA
	 LoIIkMh5y4AlZ0bXIjo92Z4PBgIdA3ciWhf9HN1h+0hjyk7IZ80qIBWS70MlVoImn8
	 8OHkLeELtn+Vtl4zwQY7XljCGLIAhhEwD60MU1j4SWA2zZgA5KYJCinlRCFMWrtYwF
	 5mSDUKd2eUEXOmHX40VV428wgltRKY8yu5mLZrdkVU7niM7UozGroXOksN1o/DXazp
	 oQxUhZNMh6QTw==
Date: Thu, 29 Feb 2024 06:34:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tariq Toukan <ttoukan.linux@gmail.com>, Saeed
 Mahameed <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240229063425.5ccbd06b@kernel.org>
In-Reply-To: <ZeA9zvrH2p09YHn6@nanopsycho>
References: <20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
	<20240220173309.4abef5af@kernel.org>
	<2024022214-alkalize-magnetize-dbbc@gregkh>
	<20240222150030.68879f04@kernel.org>
	<de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
	<ZdhnGeYVB00pLIhO@nanopsycho>
	<20240227180619.7e908ac4@kernel.org>
	<Zd7rRTSSLO9-DM2t@nanopsycho>
	<20240228090604.66c17088@kernel.org>
	<ZeA9zvrH2p09YHn6@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 09:21:26 +0100 Jiri Pirko wrote:
> >> Correct? Does the orchestration setup a bond on top of them or some ot=
her
> >> master device or let the container use them independently? =20
> >
> >Just multi-nexthop routing and binding sockets to the netdev (with
> >some BPF magic, I think). =20
>=20
> Yeah, so basically 2 independent ports, 2 netdevices working
> independently. Not sure I see the parallel to the subject we discuss
> here :/

=46rom the user's perspective it's almost exactly the same.
User wants NUMA nodes to have a way to reach the network without
crossing the interconnect. Whether you do that with 2 200G NICs
or 1 400G NIC connected to two nodes is an implementation detail.

