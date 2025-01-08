Return-Path: <netdev+bounces-156077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66262A04E01
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC443A0851
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D561C32;
	Wed,  8 Jan 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eURV55On"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF110E4
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294577; cv=none; b=HkAv1tmHTBTnIJOugmEcXZrYh3tuFkTwL36onNulB6YExi4Nbq78+eF3KkMl+ycTQiEJA8D2OW8BPoxGsJtSOjQZvDb68HDZKCeQvVsdt2bMv3zoLuxrRHtj3zEqLV12VPS3QTeoDkrDrWNbs8VFGJW7i6M64mnQ9+A3D8N5ns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294577; c=relaxed/simple;
	bh=PI6Vl4Zz0Z5FvQkkkCATk2ciIhZk+RKF+DqI3/40q3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK3zwW5SJFq8Ez9gXSa95AtvVD7n2njKjxuQm3e1NUWNI+phxT1EbBhjAaFYLH04g/FA6rXuK+DRNX0MMBqWQBob3VRCUXeJSf+dToViHrT1gvZrA7akxF3xDWk2xX6sdu54TbzGjEtH8vBH4P1JQg7BLoBoNEvko0xJW9F8ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eURV55On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D226C4CED6;
	Wed,  8 Jan 2025 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736294577;
	bh=PI6Vl4Zz0Z5FvQkkkCATk2ciIhZk+RKF+DqI3/40q3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eURV55OnjXeH6r+0jeasIirKUSdrR0zPCQ1+MLb1x837Wmp1KFlIeS+z50b2PlFfL
	 XoGu1tkvHVgyRK0lESSicHTO1ruZ4BqxuDK0A+lJqzy67+d194SZc6kRYm/DUa8xS3
	 tku93zogBx28madJnEmN6m2+pnFmZeDXct0MS8Zy5YlAj3lWegF2yE1aH5jhLtyH//
	 GtOLHHXTDgf7yv5E+HW03QTLq4r9C6Yf9QCde2xNg5FFm6XSokVnVDRrgWhi9BQYfL
	 GrShX4GOD0CsNWf8KqI0ORYPj7PpZ5pJkWnbc0CIZV/90Yy3xF7uvoM8wTC79QlsNT
	 KCkYHDfMHo/dA==
Date: Tue, 7 Jan 2025 16:02:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <20250107160256.5eed016f@kernel.org>
In-Reply-To: <CAGXJAmzt3xypxdM7=6LSQL7rn++mv-033CLcw3LGS0PxCV8d5A@mail.gmail.com>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
	<20250106181219.1075-7-ouster@cs.stanford.edu>
	<20250107061510.0adcf6c6@kernel.org>
	<CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
	<CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
	<20250107132425.27a32652@kernel.org>
	<CAGXJAmzt3xypxdM7=6LSQL7rn++mv-033CLcw3LGS0PxCV8d5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 13:58:07 -0800 John Ousterhout wrote:
> On Tue, Jan 7, 2025 at 1:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue, 7 Jan 2025 22:02:25 +0100 Eric Dumazet wrote: =20
> > > While you are at it, I suggest you test your patch with LOCKDEP enabl=
ed,
> > > and CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> > >
> > > Using GFP_KERNEL while BH are blocked is not good. =20
> >
> > In fact splice all of kernel/configs/debug.config into your
> > testing config. =20
>=20
> Will do. Does "splice" mean anything more than copying
> kernel/configs/debug.config onto the end of my .config file?

I'm not 100% sure but I think:

 make debug.config

should update the current config with the additional values.

> Is there general advice available on managing multiple configs? Sounds
> like I'll need different configs for development/validation and
> performance testing.

I'd maintain the real config and just add the debug stuff based on
kernel/configs/debug.config when building.

I've seen people use the ChromeOS scripts in the past, this I think:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/M5C14J/ch=
romeos/scripts
but that may be more complicated than what's needed here.

