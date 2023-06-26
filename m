Return-Path: <netdev+bounces-14011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A373E65D
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7C280E11
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EFE125A5;
	Mon, 26 Jun 2023 17:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68E11CB7
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F402C433C0;
	Mon, 26 Jun 2023 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687800252;
	bh=xNQCG2LqF/V/0wlxLGcR8H9p+ZOQ2yyGq0+QJyOPzQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BNH+kNKi8O8l3GVSyYaSo3MB8bWZ5fO+4SxhNTQ7uc7t7mAf/UBKThwSdREH4IhrQ
	 H2u7rDoz6Socw4ZITfyAm+ZEz48il6XwAObaTNlP+Pi140PNK0kUfjaIh4YPfvUnyn
	 Qp8QDAJw1/A++MIZddAPw45XnUzatsu87wApbZjPajTw1jKsT2FEcQ7+6P9W1bZmgm
	 26hXP0J4mzhj0AGv3SGwwLKQKncq4RSaUMZD4Ih1CwspXAFkvuAj7dZpq/cLOcHfeO
	 35yONOdO1Kvk6dhNxnCPp5FZQeE00XzHcup7e36jMNbuK5bi+a31ggGTd/NtrTphVD
	 FKJUf3ZfcF6mg==
Date: Mon, 26 Jun 2023 10:24:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jiawen Wu <jiawenwu@trustnetic.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: change hw reset mode
Message-ID: <20230626102411.2b067fa8@kernel.org>
In-Reply-To: <6964AD00-15BF-4F2D-9473-A84E07025BE8@net-swift.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
	<20230622192158.50da604e@kernel.org>
	<D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
	<362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
	<6964AD00-15BF-4F2D-9473-A84E07025BE8@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2023 09:56:32 +0800 mengyuanlou@net-swift.com wrote:
> > That does not answer the question. Is this backwards compatible with
> > old firmware? =20
>=20
> Yeah=EF=BC=8Cthe veto bit is not set in old firmware, so they have the sa=
me effect.

Why were you using the more complex FW command then rather than just=20
the register write, previously then?

