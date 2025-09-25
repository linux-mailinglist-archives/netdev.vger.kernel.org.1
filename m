Return-Path: <netdev+bounces-226136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066FB9CE8E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240C02E82A0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978792D3231;
	Thu, 25 Sep 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH6sUjJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC32D320E;
	Thu, 25 Sep 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760553; cv=none; b=AWGU45TPyDHDiZ6h8g5lfkxWRvnt/TRvhZF9dvGaAw278Q6naeWMmAUFqsZTrtFA/EAtTprwSjgQ84zVXh/bqaYpTy2qwvtCeVyXysbRXKwKvXYjnX9XY1Qnrn4uLF5GtZ4MppKqA/On/ngQbRxpl5qvpLCYiEoV5cTtvK06VmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760553; c=relaxed/simple;
	bh=IoOKWP7KCWx1/+dfW5jgvFGaEP12J8ouah4qQKtJ3lM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1fQMsMGBImgYuRK6nJWBX4IxlHruxm/a11+pb4psymDtfFWyHFoJ10/HzM1++ciB6GJbiUDr64MQ0q/NGgwqNVlbrd3F11ti1U3aLmBMQ8pJZPf0cQOx/Qpmm2ep6Ejm2OFo7mMPTVkxT+X8gHrUJtsxo12kZ+n7BqBTaCo8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH6sUjJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB9C4CEF8;
	Thu, 25 Sep 2025 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758760553;
	bh=IoOKWP7KCWx1/+dfW5jgvFGaEP12J8ouah4qQKtJ3lM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mH6sUjJd74NBnJk4fJcsViXsgvP0pS8U/fJGqs9SHCJwV/x/wSy7jNWPU7YNFSUep
	 bSM+DvvFEJqlFvV8lDR9JiYJ+24VVwJwhZsq7E7etT0cbgJLQl+4XE+aLZraTtJFBY
	 ccaI22dbyMNOvoNAhQwygpfHjT6R2dsHWDU6qOxntvFqbU/Z7oRQZVNICJxHgqPnoK
	 +luos9WjycvfvQccolMNlfWNtjVvLwAOl0yx3ZoyzqPR0vhEYDVesFVCe3W6WYsWGG
	 Cks8roMCWbNSqBH7KzKT7dqJZRMxtJX5vfBlN0WZpdG3kCDXBC58pebaN8eGyZa/dy
	 zN9eZZnlCxfuw==
Date: Wed, 24 Sep 2025 17:35:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/5] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250924173551.2e09b168@kernel.org>
In-Reply-To: <CAAXyoMNBHgG-DFv16ua-T__iBXg=chFQ6TNoXdZvk4VP2aYESA@mail.gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
	<20250922131148.1917856-6-mmyangfl@gmail.com>
	<20250923174737.4759aaf4@kernel.org>
	<CAAXyoMNBHgG-DFv16ua-T__iBXg=chFQ6TNoXdZvk4VP2aYESA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 20:33:57 +0800 Yangfl wrote:
> On Wed, Sep 24, 2025 at 8:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > > +             cancel_delayed_work_sync(&pp->mib_read);
> > > +     }
> > > +
> > > +     dsa_unregister_switch(&priv->ds); =20
> >
> > The work canceling looks racy, the port can come up in between
> > cancel_work and dsa_unregister ? disable_delayed_work.. will likely
> > do the job. =20
>=20
> Are you sure about this? There are many others who use
> cancel_delayed_work_sync in their teardown methods (for example
> ar9331_sw_remove). If that is true, they should be fixed too.

Not at all! I'll gladly accept an explanation of why the code is
correct. "Someone else is doing it too" is not an explanation.

