Return-Path: <netdev+bounces-133983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF339979BC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEAD1C212BF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A6FC1D;
	Thu, 10 Oct 2024 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntLI+1jf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05818653;
	Thu, 10 Oct 2024 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520862; cv=none; b=MD+vbTP5US5yjfydanoXRSpAx7la8Z/jo3NTst7Fl/ERt2brt2N78RiMe8/gi/Z/dJF7jowYLPCYQOpc1ohoDor6ZkQ8nMVxRqDvgYj/HMPTeRPH6H8+/chL4BjAGlpNpf3biF6h+HxdWlHpmY0HBpE1kT6Ljy0SFV1IzHLBtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520862; c=relaxed/simple;
	bh=0YPN352ZMIr78s4hQESniUD3jXxZkqYAQV/HlVk90QY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN8kS9IxhmqzlftHJYi/PODmJwU6c9psmMeezsCSnU9sX6ry/lYluM0luzvZ+JSURVri98gNQZcfYijeEItTq4v9ot0AjDf1NvQ21xnKvyjxloF6VGnWvfV9STh1rAUdHRKIVXUzrSy9UdZViO3Yhjk92s00p2ufrnfjT1V5hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntLI+1jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C438C4CED0;
	Thu, 10 Oct 2024 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520861;
	bh=0YPN352ZMIr78s4hQESniUD3jXxZkqYAQV/HlVk90QY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntLI+1jfNDaQAtcla1Yrqko/cXXfjy7Fm7F8z0mcbjOyFT2mOPGtmSBujFKkF3Xry
	 qjPxm92GvieelOkEMWWPFDQojRoL1ezk4TN6dE3zza4UDPAHiKcIolg6/svDcPX3Q8
	 YwbUDjDaihBecvwYyw7FPP0FtZuo3zn4KKr1vQsgXaMdxnlHAE5qH3KIa2ZbIMRD9Z
	 +G0n3EN+nPA0em2ILcGDPEX9jX8eBjd0DfPiLiUn9iWeFrzxMvf29kaO7ZZQL39S+H
	 Bidx2/tHqYPqxWQzRIDkjUXbJ9d5HxbXrKQ6c6dc9iZnrOaTcDnGDGVOTBU+Rwza0x
	 gOUdEPUEP7Uqw==
Date: Wed, 9 Oct 2024 17:41:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net: bgmac: use devm for register_netdev
Message-ID: <20241009174100.033a2676@kernel.org>
In-Reply-To: <20241006013937.948364-1-rosenp@gmail.com>
References: <20241006013937.948364-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  5 Oct 2024 18:39:37 -0700 Rosen Penev wrote:
> Removes need to unregister in _remove.
>=20
> Tested on ASUS RT-N16. No change in behavior.

I defer to the maintainer (Rafa=C5=82) on whether it makes sense or not.
My personal preference is to leave existing code be.
*Iff* you get an ack please repost, it's the oldest patch in our
patchwork now.
--=20
pw-bot: defer

