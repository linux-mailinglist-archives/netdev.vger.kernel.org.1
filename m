Return-Path: <netdev+bounces-75552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA12286A73B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 04:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D841F2C41C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C6200AE;
	Wed, 28 Feb 2024 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTohTh9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2D1F952
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091300; cv=none; b=PjR/t2RzCr57TP1h8jh3ijCTcKzTI9gEGp5ofW+dlXnMZNcxDjwBsUwjRx0LJdNjdZ8zSZQFoaGRBBdtNPLhZJS3BYq9AywzhpKWk3kTSaHmnYaWuETy6V2tNjgpRHaZoJam3dgOajPJbWmMVLfO1p/JFfQtDainydt2UgAfDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091300; c=relaxed/simple;
	bh=RFlrVdMoK0PNTF2EbV5/48IAa5f8QRvx5Rul9RU9xZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzbSeqc3Ch+gytqv4kCZ/IsN/hv7PxpSABrskA6AdmSOdrtrmc213SPHbXMyrTi7SeBEFNe/jlwmQNuyRdU8ZQw1M0ordI8U/qqvk71rQxGiX7B7SIzdHROA4vc0gzDdyts2ql24AaDoTnfYO8S8UrfEzmqCwgRR/0POpwgB5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTohTh9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17262C433C7;
	Wed, 28 Feb 2024 03:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709091299;
	bh=RFlrVdMoK0PNTF2EbV5/48IAa5f8QRvx5Rul9RU9xZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rTohTh9aB0+YdMWSTrFZjSxG6Fow2Z3LOwPuonwwwlXt3tdOwY/SwbVjZxrfEZlMP
	 joRYWk4RK8f1iUwyLrfBS32nQcx2JG4kn9hYjkpTkSMbw4rWc7unJlqZRoauESq95+
	 GBUmQTPgfi213/JQLFtTHWfXzwJTZ5bYc70rcsakCYPU12Eow3+kNd8FLpohksZf0X
	 FDwHYkm6uroS0xfHdYJ7FGYXa+16p4M21tNjfXDhgfvKOQkNhMdfIsGOTnONV2vxN/
	 iIdIe+mgGTxLSlh6IyehudKlMYkn0UQ9EjNF1+/MFtaJfl/a4LfyXzdDxXj1QsDT14
	 gSG69aB5aDIDg==
Date: Tue, 27 Feb 2024 19:34:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <20240227193458.38a79c56@kernel.org>
In-Reply-To: <4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
	<4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 19:17:27 +0100 Petr Machata wrote:
> +	/* bitfield32; operation-specific flags */
> +	NHA_OP_FLAGS,

>  static const struct nla_policy rtm_nh_policy_get[] = {
>  	[NHA_ID]		= { .type = NLA_U32 },
> +	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),

Why bitfiled? You never use the mask.
bitfield gives you the ability to do RMW "atomically" on object fields.
For op flags I don't think it makes much sense.

