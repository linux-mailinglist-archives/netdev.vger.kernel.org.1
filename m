Return-Path: <netdev+bounces-28985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58E781567
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF0281ED9
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0D71C28A;
	Fri, 18 Aug 2023 22:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4446B0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF34AC433C7;
	Fri, 18 Aug 2023 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397735;
	bh=PZJMYp5nUd49r04EQowO/9QqUs11B3qg589E5ujdIJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIobN80glhvaJmCHWALVks0jIkPkGKIRmGgnpjSPxwiZTB96uM3HwimHaZdPZjbeL
	 5+0E5+K8hDrwPCypdVjmfXjVSOPDeZ3JvqT8aoBd1DQMq4cdFd1BW1uCjcUs203Iet
	 SWoVolLRf3fgMxYmsXhXAuzJB3yU3g9B3P3zccikr+lvCKwUYXEcPBN21N0O8gIUTr
	 p5I4tp5giSHfRIf5xypLv2FmSJu//yOmKcXTZueUGNLXErHWgF4h8hDB98Ra0sP0lo
	 wDDe6u0DblOg/bTtRIww6WLtFgX0SUDTw7oEnVwCy9IfO9R0+pHAEn3o3HTrjkpvJX
	 wYUkA7ICzWhXA==
Date: Fri, 18 Aug 2023 15:28:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [net-next 14/15] net/mlx5: Convert PCI error values to generic
 errnos
Message-ID: <20230818152853.54a07be1@kernel.org>
In-Reply-To: <20230816210049.54733-15-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
	<20230816210049.54733-15-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Aug 2023 14:00:48 -0700 Saeed Mahameed wrote:
> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> errnos.
>=20
> Convert the PCI specific error values to generic errno using
> pcibios_err_to_errno() before returning them.

Is this a different one than:
https://lore.kernel.org/all/20230814132721.26608-1-ilpo.jarvinen@linux.inte=
l.com/
?

LMK if you want me to apply from the list and skip 14.

