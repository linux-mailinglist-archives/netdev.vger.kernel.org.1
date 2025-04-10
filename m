Return-Path: <netdev+bounces-181437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF9AA85000
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49571BA3C22
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBE20C038;
	Thu, 10 Apr 2025 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKdzBGFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD04204C30
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744326973; cv=none; b=AAeYrEkeMWpYVFy5R/fnph0KIDeNV0vaQtDFsr3nG5vtsbnFfksgeWv8LOxzCQPTtBHSqWkGkRAzBri74ibDcZnGqFYK1JeSe80bjEulyMC4XllgoJ6E1NR4IRCMBvHGDGLjL5cRBA8Hv5KNmyS7rfd9MhugfoTmzIf2LC2aWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744326973; c=relaxed/simple;
	bh=YryBWyAcW6TQxuCdSyh+/Hbfu3fg4INQeZHmq7I/ZI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzVAO6UUYoqCJh0FQIBmMqyyWzpdKFiVnIzdDYad/e/fC3F+/urNqBkT/Wonh/jbhA8W8rT6GK6biX3IkEA4M5HhyWQw18X8pOtiwj3HVmjTFSIKSd0NMQLkwblLoL2FxLQ9Czp0R719145zui/M5pE1K2I8J41F+CqZNnGnH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKdzBGFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834BC4CEDD;
	Thu, 10 Apr 2025 23:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744326972;
	bh=YryBWyAcW6TQxuCdSyh+/Hbfu3fg4INQeZHmq7I/ZI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKdzBGFK2h7ksgFbq1+i7L9XDjTOrca88PNFyS5MHkrvNF+fIF5qzKpHZM8L++x16
	 mzhxPsp2gLsJbIL2SzqiQuDUpcf2yA671KQJ5LDKrgaRc1pUu/bRDu62Fzj2PQZybk
	 dypIgHxHdwebnpfPhLtxLILQZlhbzXntnLSa9sa0C+CE4YUa3xu3L4gPoEjE9P7Dtx
	 xvyUpGqcfKzv9dLu2TDrQ6H5OTFSTkszfSBUqVwTGXIwFkNk7rpLj3h2ehxj9H6MXL
	 dOBIakoA0IKgOQdl/n+h2ZKJNjJzo+SnBdpWprKkaOAi1R50BVtKMRWH/LhCXxkUrf
	 hMy9bHgBgvJvw==
Date: Thu, 10 Apr 2025 16:16:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: net-shapers plan
Message-ID: <20250410161611.5321eb9f@kernel.org>
In-Reply-To: <2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
	<20250328051350.5055efe9@kernel.org>
	<a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
	<20250401075045.1fa012f5@kernel.org>
	<1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
	<20250409150639.30a4c041@kernel.org>
	<2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Apr 2025 18:23:56 +0300 Carolina Jubran wrote:
> We do configure the correct priority-to-queue mapping in the driver when=
=20
> mqprio is used in DCB mode. In this setup, each traffic class has its=20
> own dedicated Tx queue(s), and the driver programs the mapping=20
> accordingly. The hardware performs its default priority check, sees that=
=20
> the packet matches the configured queue, and proceeds to transmit=20
> without taking any further action =E2=80=94 everything behaves as expecte=
d.
>=20
> When DCB mode is not enabled, there is no fixed mapping between traffic=20
> classes and Tx queues. In this case, the hardware still performs the=20
> check, and if it detects a mismatch, it moves the send queue to the=20
> appropriate scheduling queue to maintain proper traffic class behavior.
> The priority check is always active by default, but when the mapping is=20
> configured properly, it=E2=80=99s followed by a noop.

I hope you understand my concern, tho. Since you're providing the first
implementation, if the users can grow dependent on such behavior we'd
be in no position to explain later that it's just a quirk of mlx5 and
not how the API is intended to operate.

