Return-Path: <netdev+bounces-21133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A37628CE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF3228144D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199A1108;
	Wed, 26 Jul 2023 02:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C31101
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C196C433C8;
	Wed, 26 Jul 2023 02:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690339497;
	bh=YQK1s5Ah4BQ7ozFO4P/+hVUk2JoiWuZleyroP09VLBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENq15mZUoUwGkmZtrJITxychCBYG8Juz2s2gaLWB9sx1CebUBThfrOhxhIGGJENpb
	 mUjF5SwdYr+noEkvbmlUZlz8Wnok/8qeWTW5FHftg4RL5qJMBVk43++NSyw3xEfHQ5
	 H9Mjd9Ujj3kZJww+qZpmtHtkHwARI7g+YZRCy1j9LoSAThWKZfdv3jjDucXyMXIWAs
	 LHFod4bbpYRhkZDSiqSRWIbCikWFVG5UkbxI+CwmlQxkH9DFGNrpqlgiMJC0d7mfef
	 bujTTS/vAlPx5P0RpSQgXtpgj8cZexpFZdlT1MuDBfhfQf90RyjjXC+JW1eq4Daf3z
	 AiDm98skk9hog==
Date: Tue, 25 Jul 2023 19:44:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for
 wangxun nics
Message-ID: <20230725194456.7832c02d@kernel.org>
In-Reply-To: <6D0E96D7-CDF4-4889-831D-B83388035A2C@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
	<20230725162234.1f26bfce@kernel.org>
	<6D0E96D7-CDF4-4889-831D-B83388035A2C@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2023 09:59:15 +0800 mengyuanlou@net-swift.com wrote:
> > 2023=E5=B9=B47=E6=9C=8826=E6=97=A5 07:22=EF=BC=8CJakub Kicinski <kuba@k=
ernel.org> =E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, 24 Jul 2023 17:24:58 +0800 Mengyuan Lou wrote: =20
> >> + netdev->ncsi_enabled =3D wx->ncsi_hw_supported; =20
> >=20
> > I don't think that enabled and supported are the same thing.
> > If server has multiple NICs or a NIC with multiple ports and
> > BMC only uses one, or even none, we shouldn't keep the PHY up.
> > By that logic 99% of server NICs should report NCSI as enabled.
>=20
> For a NIC with multiple ports, BMC switch connection for port0 to port1 o=
nline,
> Drivers can not know port1 should keep up, if do not set ncsi_enabled bef=
ore.=20

I'm not crystal clear on what you're saying. But BMC sends a enable
command to the NIC to enable a channel (or some such). This is all
handled by FW. The FW can tell the host that the NCSI is now active
on port1 and not port0.

