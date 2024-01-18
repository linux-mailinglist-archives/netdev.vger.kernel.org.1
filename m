Return-Path: <netdev+bounces-64099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B883113E
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 03:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB921C21A1C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF354418;
	Thu, 18 Jan 2024 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpXoqlXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473569444
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543498; cv=none; b=Z/6qpEbOWXGjFIag9u7Jy6Ob8V5EFNyQeZGxu9UpG2/e1Uucy4IfnPiMCdeEFCNWcKbE1jNkPqJW5ac4Du10phsKaJ5katy3ixyVndKQvnF624h7eceNFpPI+I5Oxk+BWpn72+QpM5ya45xZZhZc4d+l+T2fRkAv1IrUx5Nprm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543498; c=relaxed/simple;
	bh=P3zEyjV3FZDMsjNrYgOsvvuyQWboLuAY8cauwi4uXbQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=euuUQeoESvZUlxVdekS+LXZsPfXsY0T+J+dnne1DvD5Bwv6E8P+ofpmWuJeUM5iExgd2/mV2YBaEbwC6pyGQUfNaocwGE4w9++T3JvEHSJuID2rSCiQ/0JPT5oXMLmJpL1VHem5mFBpRj0YocKzOHG4g3gKqCRyvOhbcpRkFI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpXoqlXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F655C433F1;
	Thu, 18 Jan 2024 02:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705543497;
	bh=P3zEyjV3FZDMsjNrYgOsvvuyQWboLuAY8cauwi4uXbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fpXoqlXcZt+dfg1POpepMReL/Q/BbWepRASvCel8SEgmgVQ9zybutEtRh3mhx6m7F
	 tvbDrK1gQRVPqzvSDc+ZMvOtWtlbg6JTohba4bhuf+gQTC5D3JjEACo+9SJHROBUa2
	 8nL3+FMqts+smLhfA9nfeSlQYzs1q5+WPGMzNL7q2Me3r6IVg2CHIzovanKwCXp5jO
	 AhfZqbIhzCJnpwi6XgTq/ieMA4HUpBvVbJKlbQiW1OFAe/V/ye9VrThs7qlvsR5Q82
	 e5DMJge7xnkJQBBFMq0tViU9N2uxEBXtwuwccZWVSCs+tf2lc3Wr19oc5ZI5D5FIzq
	 EOTdvlwC1inOw==
Date: Wed, 17 Jan 2024 18:04:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Armen Ratner
 <armeng@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
Message-ID: <20240117180456.385430b2@kernel.org>
In-Reply-To: <ZaeDuDSVFs46JffL@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-16-saeed@kernel.org>
	<dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
	<ZYS7XdqqHi26toTN@x130>
	<20240104144446.1200b436@kernel.org>
	<ZZyDpJamg9gxDnym@x130>
	<20240108185806.6214cbe8@kernel.org>
	<ZaeDuDSVFs46JffL@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2024 23:37:28 -0800 Saeed Mahameed wrote:
> On 08 Jan 18:58, Jakub Kicinski wrote:
> >On Mon, 8 Jan 2024 15:22:12 -0800 Saeed Mahameed wrote: =20
> >> This is embedded core switchdev setup, there is no PF representor, only
> >> uplink and VF/SF representors, the term management PF is only FW
> >> terminology, since uplink traffic is controlled by the admin, and upli=
nk
> >> interface represents what goes in/out the wire, the current FW archite=
cture
> >> demands that BMC/NCSI traffic goes through a separate PF that is not t=
he
> >> uplink since the uplink rules are managed purely by the eswitch admin.=
 =20
> >
> >"Normal way" to talk to the BMC is to send the traffic to the uplink
> >and let the NC-SI filter "steal" the frames. There's not need for host
> >PF (which I think is what you're referring to when you say there's
> >no PF representor).
> >
> >Can you rephrase / draw a diagram? Perhaps I'm missing something.
> >When the host is managing the eswitch for mlx5 AFAIU NC-SI frame
> >stealing works fine.. so I'm missing what's different with the EC. =20
>=20
> AFAIK it is not implemented via "stealing" from esw, esw is completely
> managed by driver, FW has no access to it, the management PF completely
> bypasses eswitch to talk to BMC in ConnectX arch.
>=20
>=20
>     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =
   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>     =E2=94=82             =E2=94=82            =E2=94=82             =E2=
=94=82
>     =E2=94=82             =E2=94=82            =E2=94=82            =E2=
=94=8C=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>     =E2=94=82     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=82 mgmt PF    =E2=94=82
>     =E2=94=82  BMC=E2=94=82       =E2=94=82 NC-SI      =E2=94=82   Connec=
tX =E2=94=94=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>     =E2=94=82     =E2=94=82       =E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82             =E2=94=82
>     =E2=94=82     =E2=94=82       =E2=94=82      ^     =E2=94=82     NIC =
    =E2=94=82
>     =E2=94=82     =E2=94=82       =E2=94=82      |     =E2=94=82         =
   =E2=94=8C=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>     =E2=94=82     =E2=94=82       =E2=94=82      |     =E2=94=82      =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=82 PF   =
      =E2=94=82
>     =E2=94=82     =E2=94=82       =E2=94=82      |     =E2=94=82      =E2=
=94=82     =E2=94=94=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>     =E2=94=82     =E2=94=82       =E2=94=82      |     =E2=94=82      =E2=
=94=82      =E2=94=82
>     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98      |  =
   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>           =E2=94=82phy           /            =E2=94=82 phy
>           =E2=94=82             /             =E2=94=82
>           =E2=96=BC            /              =E2=96=BC
>       Management      /              Network
>         Network      /
                      /
                     /
What are the two lines here?

Are there really two connections / a separate MAC that's
not the NC-SI one?

Or is rhe BMC is configured to bridge / forward between NC-SI=20
and the port?

Or the pass-thru packets are somehow encapsulated over the NC-SI MAC?

