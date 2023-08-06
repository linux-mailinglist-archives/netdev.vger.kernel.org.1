Return-Path: <netdev+bounces-24711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909867715E9
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4183328122A
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B853BE;
	Sun,  6 Aug 2023 15:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84D28EF
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579F7C433C7;
	Sun,  6 Aug 2023 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691336226;
	bh=2mjUK8700j2g79TU7Ih+YIIZC0YtpcE+kTjNT8R0CGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsGd4QRKxt0EYKFdTHhkTw3chr5tuibu0t6WAJe5OHdfSMg+qMmcOUrAz7VHLVjx+
	 8HZqicBCR2C3uNmmqt8FfB0PwZSr2/K/cDNTFiczGwWKdHQoMdk3CP8CMRoNvs0CH2
	 mKhqq9MX3spfTbVK67nqyea0Z1MYlPmu9jVUD20x6/ss78WPchc33rcnyLV9D8FGjd
	 RwFnH3ruq7PQEdmo0kv8bHwVN9E46h9wqAMrFpxo+3LFVnYgjJcztsXO2MxewWXNrv
	 S/+2uOzKfWp5bkjYPmiV8pXeaf/H60Bsjt1DXpR7iFFW6sfPhIPHdvfMWZxoQsFQa1
	 +Xvhb4jcbQnbg==
Date: Sun, 6 Aug 2023 17:37:02 +0200
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 10/10] net: fs_enet: Use cpm_muram_xxx()
 functions instead of cpm_dpxxx() macros
Message-ID: <ZM++Hq8h6EUnUGQL@vergenet.net>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
 <2400b3156891adb653dc387fff6393de10cf2b24.1691155347.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2400b3156891adb653dc387fff6393de10cf2b24.1691155347.git.christophe.leroy@csgroup.eu>

On Fri, Aug 04, 2023 at 03:30:20PM +0200, Christophe Leroy wrote:
> cpm_dpxxx() macros are now always referring to cpm_muram_xxx() fonctions

nit: fonctions -> functions

Thanks Christophe,

This minor nit notwithstanding, this series looks good to me.
I'll send a reviewed-by tag for the whole series in response
to the cover letter.

...

