Return-Path: <netdev+bounces-83178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6D891355
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF0DB22BC5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 05:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2FF3C08D;
	Fri, 29 Mar 2024 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8G7rjQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581F3A8F7
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691144; cv=none; b=aTzMDlhIzfOaMTa+9tWKXzyjeqYyTW9WGJk6tnphOJL94NPpwqX8/gcpZhgdQ9VeM5mLFB6/Hgsudn+hlF55knbnLlU8P4lEcEPqsIxaA47FAfPyOxZnSE75FgdubdBpsSXE3WCzduxq5u24vyBiEmM/HfVd/H4/2iJmB7rHh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691144; c=relaxed/simple;
	bh=4SMy25oZGjgmVlakxk72s6rot8SmmO+GanyNpBeHFZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJ30/WwgFuyehVfa23OmEbFym+I+3H1T2ZWUro/oZCAfEo3H21qrraGFAfqs2cM9juL8BuTfFRF7FErnhazI16qB2vnMhjeq+YOzRt+jADA0ZcU2SiMsUqTfkvl2mYHj40vuoGMPiFMQdSOHT0ETtyWTpgMNB2KRuWQyM54LxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8G7rjQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691B2C433C7;
	Fri, 29 Mar 2024 05:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711691143;
	bh=4SMy25oZGjgmVlakxk72s6rot8SmmO+GanyNpBeHFZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q8G7rjQFcby1xQrkVBz91WLmI1FMDAywNR2mXmtXr5HRmK86CXpTO0zAKkYvdD4uS
	 YNMaAS9UvAfI6SWNBgHndLfQVmtvMkNRy/WBLZEsqw83D7k1pqvjPxnlAD5x2mZ9zX
	 KRLchy3okIzBlYdurdaS5llqUVb9vAvDTaMnWq0yUXlSxY05fUmqxppxB+3CS59WrA
	 nNZCG/yYeNZsI0Lr9hp9Uyas8FOdeo9PjSG+/dgw0Lchdr3YYVA8Vpir1PGvr23GjM
	 MZTF6jxBgV2T/zO8NqlZ4vlLUuTR/WSgsGePqpu8OyEobQ8eLsnIU6SQZxuBG31WMo
	 5TmwiQ3+jZhxg==
Date: Thu, 28 Mar 2024 22:45:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/8] net: rps: misc changes
Message-ID: <20240328224542.49b9a4c0@kernel.org>
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
References: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 17:03:01 +0000 Eric Dumazet wrote:
> Make RPS/RFS a bit more efficient with better cache locality
> and heuristics.
>=20
> Aso shrink include/linux/netdevice.h a bit.

Looks like it breaks kunit build:

../net/core/dev.c: In function =E2=80=98enqueue_to_backlog=E2=80=99:
../net/core/dev.c:4829:24: error: implicit declaration of function =E2=80=
=98rps_input_queue_tail_incr=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
 4829 |                 tail =3D rps_input_queue_tail_incr(sd);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
../net/core/dev.c:4833:17: error: implicit declaration of function =E2=80=
=98rps_input_queue_tail_save=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
 4833 |                 rps_input_queue_tail_save(qtail, tail);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
../net/core/dev.c: In function =E2=80=98flush_backlog=E2=80=99:
../net/core/dev.c:5911:25: error: implicit declaration of function =E2=80=
=98rps_input_queue_head_incr=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
 5911 |                         rps_input_queue_head_incr(sd);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
../net/core/dev.c: In function =E2=80=98process_backlog=E2=80=99:
../net/core/dev.c:6049:33: error: implicit declaration of function =E2=80=
=98rps_input_queue_head_add=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
 6049 |                                 rps_input_queue_head_add(sd, work);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
--=20
pw-bot: cr

