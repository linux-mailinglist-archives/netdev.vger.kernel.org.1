Return-Path: <netdev+bounces-29840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB5784E62
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F331C20C03
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26961381;
	Wed, 23 Aug 2023 01:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B010E9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 01:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A172DC433C7;
	Wed, 23 Aug 2023 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692755205;
	bh=TsZD25Y/24LTSpkUXi5ab7o3lyZUrIrCSQaeiBB8jwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R15edRetBKcnFq8DTLxzpfxVenxWiQpVjITO0OaTo/HlqYgK25BvOT1Ur68fSVxJD
	 4F8dN2bOvAfOfhjfHzM6XFdJhxslbaNQ6H85G4MeaQCVoSFUL4jQkeprIWHCygfz8d
	 qcIHiQxA58RdQg0qNSEizuJ9KT+j3kRPm1xJtpC/DoM44R34WjeikXbVm8juyVf7FL
	 Pbuj/C/CDHXz6qbSHuVbDOiYsDGeV5se9Uiq1fHXNc/84Vc7tsq0YfhdhDaNx4pgkW
	 rISWaWit+2o/IVHN9IbTbYV1LIr6FHb6uDMHZZaKeeVlJPI1GtJWR6YXvDNinam6A2
	 U2S/iuV8rrCog==
Date: Tue, 22 Aug 2023 18:46:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Marko
 <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <20230822184644.18966d0f@kernel.org>
In-Reply-To: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Aug 2023 08:51:57 +0200 Thomas Wei=C3=9Fschuh wrote:
> Remove the necessity to modify skb_ext_total_length() when new extension
> types are added.
> Also reduces the line count a bit.
>=20
> With optimizations enabled the function is folded down to a constant
> value as before.

Could you include more info about the compiler versions you tried
and maybe some objdump? We'll have to take your word for it getting
optimized out, would be great if we had more proof in the commit msg.
--=20
pw-bot: cr

