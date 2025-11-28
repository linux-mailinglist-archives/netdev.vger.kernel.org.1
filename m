Return-Path: <netdev+bounces-242612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C09C92D60
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B457344086
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED52829D275;
	Fri, 28 Nov 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQz6++mY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F423B62B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352243; cv=none; b=s5er5Ndx1Gcx4AtxGWgmJuYZK4U3Cqkml/Oo5GAZg2VJlSx0SN+pG5xNnod/u3YdgGIb2gYYnezcIix3VQi2rLvZWdajSK7fHcLMie1nNXX/b9oZtmQq0E8cLEnJ6sMICZJrmzYalY9MA7N1G5SAcadB4UgRmtV4yDhK3KnnYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352243; c=relaxed/simple;
	bh=KsUUaEtkI8a/3CrRZsfe/EA0o66YF5q2GX/qJ78sX5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1y3TSAkkKGsRZN8HhY120SpK29SN3yJUQ8HCno9tOdq8MlUCHTbSmXT3eDattPtj8l8J5U86/6e0TcKG7huE3LhB7HK0D7bb2KKQSTRMZoAibflzKMMSLmBSNmfdbvakTiyKhShVWdXReL/nu3sRLE1nfw/rW1l2cVSQfWK3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQz6++mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0BCC4CEF1;
	Fri, 28 Nov 2025 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764352243;
	bh=KsUUaEtkI8a/3CrRZsfe/EA0o66YF5q2GX/qJ78sX5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQz6++mYQKaG+wl17G4Y9AHp8LzBwpVpK1jk1+/lDd5wUTM5ij9r4LtCp1dl3nSig
	 jjo2KMzfEU2h4h59tofFd7RznsoQkcLifTAd1Wz5TfO+aku/9WuoF+SU9/jCAra/oU
	 NZwNYfTop3RaKHS4GdrvBlnVamRxr2Xir1Q0VwHHbo0cQ4nR6+GY7QpCvAafUzmJVs
	 lLTRdRE4idCuJ4dAbzg3SUQNhQCiCdQ6y8q62YJ6xkbnSiej27y2zVg8kks8KZObPX
	 87kMjG9LatX+Q+zhTwN6/qcmgAhYgi9hiRMybt0fdjR3CWhzF0YvihTMuzVDa7z6EP
	 NBYFUkNLHckEQ==
Date: Fri, 28 Nov 2025 09:50:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas
 =?UTF-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
Message-ID: <20251128095041.29df1d22@kernel.org>
In-Reply-To: <87o6onb7ii.fsf@toke.dk>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
	<aSiYGOyPk+KeXAhn@pop-os.localdomain>
	<87o6onb7ii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Nov 2025 20:27:49 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Is there any chance you could provide selftests for this new qdisc
> > together with this patchset?
> >
> > I guess iproute2 is the main blocker? =20
>=20
> Yeah; how about I follow up with a selftest after this has been merged
> into both the kernel and iproute2?

Why is iproute2 a blocker? Because you're not sure if the "API" won't
change or because you're worried about NIPA or.. ?

