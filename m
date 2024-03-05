Return-Path: <netdev+bounces-77646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B935187278F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F921F2654E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF43BB3F;
	Tue,  5 Mar 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn7BzQXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62F18EA2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667034; cv=none; b=i0lFGZhsElEnyQnjZVeBCucPp3uig0ci/UKdTZ0obgHK3H9z27PxzXPD1ens2lotn1+v8BBEnzqnQYkhqxf9Q1lEcgCrLP92JlsLHu3B3TC4FRJAvHQGY0ccoqSdaxFTv4fDu2UI7MqdyEEuvW43x29+M2DGkDfJEDMF4HnD9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667034; c=relaxed/simple;
	bh=g8tgOqipFYAYeMumFuJ14Y0ZXvZ55IwD02OkI7OFkA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z92A+9mpGIBhvjJrAvj52mMneaKZhVfq/J5PxWEDaOg77kOT47JsjRs5kgcmVSO2p/8JEhuXSuFB+Ug9jZnTJeWvpfMD4F+7idzpb2FCBeV++cNusVywbkQu4+4ifb9Hr45Fl79l7Y5sTTb1FaNi2vRMSBROiiyvPV6c8H5inZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn7BzQXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A284AC433F1;
	Tue,  5 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709667033;
	bh=g8tgOqipFYAYeMumFuJ14Y0ZXvZ55IwD02OkI7OFkA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hn7BzQXXRyOUNwPOJki8c/p+Ep7QvDmXbpFw6TWVWT0QtBiw+dajpb7Z2kjZBeXCr
	 A9Qn7qffKhpdyspsUp1GToBKcJj440HJwlQDpcy/099flYCwpqWskyyZHeyZ2DzPDZ
	 NLOobWWcQxrvjJddTFBQpbCsWv0GSA0KIcEDRkuV30cy+bzntM0ecKfAr8GcE00dcv
	 on+vdn7sDiXiiexPUdYFJ8387LyxtqPHzxrfsBSBdQZyfM7WcEXTx1I3MLRZ2thUMT
	 Lk05RzvlcW8Xfm14Hl0wbzyiiH6bFy2Z3/GeZ+VO4D24oLLkP5TfpLUNkGfWnBpNMF
	 bgYxCmenznsjw==
Date: Tue, 5 Mar 2024 11:30:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20240305113032.55de3d28@kernel.org>
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:08:51 +0100 Antonio Quartulli wrote:
>  create mode 100644 drivers/net/ovpn/Makefile
>  create mode 100644 drivers/net/ovpn/bind.c
>  create mode 100644 drivers/net/ovpn/bind.h
>  create mode 100644 drivers/net/ovpn/crypto.c
>  create mode 100644 drivers/net/ovpn/crypto.h
>  create mode 100644 drivers/net/ovpn/crypto_aead.c
>  create mode 100644 drivers/net/ovpn/crypto_aead.h
>  create mode 100644 drivers/net/ovpn/io.c
>  create mode 100644 drivers/net/ovpn/io.h
>  create mode 100644 drivers/net/ovpn/main.c
>  create mode 100644 drivers/net/ovpn/main.h
>  create mode 100644 drivers/net/ovpn/netlink.c
>  create mode 100644 drivers/net/ovpn/netlink.h
>  create mode 100644 drivers/net/ovpn/ovpnstruct.h
>  create mode 100644 drivers/net/ovpn/packet.h
>  create mode 100644 drivers/net/ovpn/peer.c
>  create mode 100644 drivers/net/ovpn/peer.h
>  create mode 100644 drivers/net/ovpn/pktid.c
>  create mode 100644 drivers/net/ovpn/pktid.h
>  create mode 100644 drivers/net/ovpn/proto.h
>  create mode 100644 drivers/net/ovpn/skb.h
>  create mode 100644 drivers/net/ovpn/socket.c
>  create mode 100644 drivers/net/ovpn/socket.h
>  create mode 100644 drivers/net/ovpn/stats.c
>  create mode 100644 drivers/net/ovpn/stats.h
>  create mode 100644 drivers/net/ovpn/tcp.c
>  create mode 100644 drivers/net/ovpn/tcp.h
>  create mode 100644 drivers/net/ovpn/udp.c
>  create mode 100644 drivers/net/ovpn/udp.h
>  create mode 100644 include/uapi/linux/ovpn.h

At a glance you seem to be missing:
 - documentation
 - YAML spec for the netlink protocol -
   https://docs.kernel.org/next/userspace-api/netlink/specs.html
 - some basic set of tests (or mention that you'll run your own CI
   and report results to us: https://netdev.bots.linux.dev/status.html)
:)

