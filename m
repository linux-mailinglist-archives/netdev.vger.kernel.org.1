Return-Path: <netdev+bounces-148780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236B9E31D7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19D22847E2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCE13D281;
	Wed,  4 Dec 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymh/pWQH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16B13D246
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281762; cv=none; b=TQ7EVPdU7PBVbMpWch8HOapWtUAeEKQGka3h/Vx/BM0CazsWH6vLfqraGIhUZzsnQ9g4Y6SCwSEtTxOTkOqIFq9GtdPeqUsokCnop5f36eYTouBYNtonwE7pXQaD8EHdWXGUZ0Ny0l/Xu65LTyDnusDEuhYctyrE+C0GpHuTaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281762; c=relaxed/simple;
	bh=s6j08+KKxkhmWsVdvz0z5kQ4Dd7McNmugq9MxfDhMZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXG/9K1BnGryfIZHPXO8fpa/AT8XQBgKElmy5GGyOb85YelGdeG4dCwFcB4NnV4NgL/bYU9ceuDd3rad2MZ/QwFMs6r3V+4qFnEZlhUQWdFtrEiRmUpPZo25tIonc+Hb24TZNgZKC72k0SqSqwMOGbIGHh+IHccpJ53f6cB+A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymh/pWQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67820C4CEDC;
	Wed,  4 Dec 2024 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281760;
	bh=s6j08+KKxkhmWsVdvz0z5kQ4Dd7McNmugq9MxfDhMZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ymh/pWQHYRgNuQtECtvAxSxmV5nCCRNPJ07ZkcPhBGdFrGbDVMc9AOBAkKT3JUPG2
	 FdPGfVO12s0Hz9wmgTXIbjqf85DHSY8dyq3U+2lu/IWKUR61Esk4MvpvhxAxmDp94D
	 fj9mmqzvMyr2tn/XueiXREAlx5PKYrQZb86FOkh+4vaDfnaAtuSeBOGjlZGpjs59ye
	 2STigwS4XXQ2ZeI3n4xLFox+h1+VPmzGCHPI51S8Zu7IpVTsmUS0sgfrsB0wrzJ4QI
	 4YBA+nl/grmriOeE0rc4SfxQKvCE7COxNbOLc/qpCVQdCSabRgMfILIOOaq6XTjLM6
	 s8YvzvBHZ6v+A==
Date: Tue, 3 Dec 2024 19:09:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net] cxgb4: use port number to set mac addr
Message-ID: <20241203190919.33421a6b@kernel.org>
In-Reply-To: <20241203144149.92032-1-anumula@chelsio.com>
References: <20241203144149.92032-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 20:11:49 +0530 Anumula Murali Mohan Reddy wrote:
> t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> uses port number to get mac addr, this leads to error when an attempt
> to set MAC address on VF's of PF2 and PF3.
> This patch fixes the issue by using port number to set mac address.

Please add a Fixes tag pointing to the first commit where the issue can
be observed.
-- 
pw-bot: cr

