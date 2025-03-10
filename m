Return-Path: <netdev+bounces-173493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6CA59320
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C145188CB2F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B402223323;
	Mon, 10 Mar 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOa57sj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743222257E
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607684; cv=none; b=uIu4CbnmJB/Ey0+2tc/dYaNGlIhnSjp9WfTMXKozx6KWLifiaDU0IaasbMIZX3dhnZ3lcBW4ui2hNEsWGadjmdNGwhn18KlMkQ+ugdyyzAIZKxtZ9ULV3zjxcOiI944CDXx9LXDLck9FGZXhjsE+EKRLC0bCF9KLozJGFbMA4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607684; c=relaxed/simple;
	bh=mQXBXAlzuLu+l+ebRrDsY4EkIPxJYQa3tk2eT5AJp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWydEnHkbZGoZ76hB+aBaxlhh0BNUTwc7lwTGcr63vF5WajNDM7GtsCgRz+7r2Scn2tEZcl9QXTxYGa93GshbnI8JhejnDOlpUXC7rozydwQLpAK98y97dCsczFM9FQjV7F0sU0S7Dh3KFiqzfhovpToSBVaxpc2xCQhZln+C3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOa57sj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33611C4CEE5;
	Mon, 10 Mar 2025 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607682;
	bh=mQXBXAlzuLu+l+ebRrDsY4EkIPxJYQa3tk2eT5AJp/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOa57sj/Fu5n7BvS8gBDwB7ssaRA9jExNhVl6tV79yocp94BiQnlwPxtoB4y3osyg
	 2eK0WmCgETxP/B4kEDlADHLXfEbV56gxpLPhGVjl98xeX2JLAvX9Zrh8SpuCvlUt7Y
	 0Oc+opTuSj5OrLbxyIXUNeNdxmuXzWNSD5jPfjwD4ogrEmLLOhSGKG0uXO03CoV2SJ
	 Rxei0v4UxleCbQzxCwC2Y3DbPuXn2Y4jw2Z6zYDy2uwACpwl2r6dbnGsHSjZxV0Jz8
	 04+9U7beO1Bn+rgvA8Zhg7QSBNO0SzKMy8GaBh94MHEXa8zkMOnJimdW3VNMW930Ka
	 PCMWsTKs2sXHA==
Date: Mon, 10 Mar 2025 13:54:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chiachang Wang <chiachangwang@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	stanleyjhu@google.com, yumike@google.com
Subject: Re: [PATCH ipsec-next v4 1/2] xfrm: Migrate offload configuration
Message-ID: <20250310115439.GE7027@unreal>
References: <20250310091620.2706700-1-chiachangwang@google.com>
 <20250310091620.2706700-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250310091620.2706700-2-chiachangwang@google.com>

On Mon, Mar 10, 2025 at 09:16:19AM +0000, Chiachang Wang wrote:
> Add hardware offload configuration to XFRM_MSG_MIGRATE
> using an option netlink attribute XFRMA_OFFLOAD_DEV.
>=20
> In the existing xfrm_state_migrate(), the xfrm_init_state()
> is called assuming no hardware offload by default. Even the
> original xfrm_state is configured with offload, the setting will
> be reset. If the device is configured with hardware offload,
> it's reasonable to allow the device to maintain its hardware
> offload mode. But the device will end up with offload disabled
> after receiving a migration event when the device migrates the
> connection from one netdev to another one.
>=20
> The devices that support migration may work with different
> underlying networks, such as mobile devices. The hardware setting
> should be forwarded to the different netdev based on the
> migration configuration. This change provides the capability
> for user space to migrate from one netdev to another.
>=20
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> Signed-off-by: Chiachang Wang <chiachangwang@google.com>
> ---
>  v3 -> v4:
>  - Change the target tree to ipsec-next
>  - Rebase commit to adopt updated xfrm_init_state()
>  - Remove redundant variable to rely on validiaty of pointer
>  v2 -> v3:
>  - Modify af_key to fix kbuild error
>  v1 -> v2:
>  - Address review feedback to correct the logic in the
>    xfrm_state_migrate in the migration offload configuration
>    change
>  - Revise the commit message for "xfrm: Migrate offload configuration"
> ---
>  include/net/xfrm.h     |  8 ++++++--
>  net/key/af_key.c       |  2 +-
>  net/xfrm/xfrm_policy.c |  4 ++--
>  net/xfrm/xfrm_state.c  |  9 ++++++++-
>  net/xfrm/xfrm_user.c   | 15 ++++++++++++---
>  5 files changed, 29 insertions(+), 9 deletions(-)
>=20

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

