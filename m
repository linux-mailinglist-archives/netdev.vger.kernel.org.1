Return-Path: <netdev+bounces-17288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3A75117E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083812819E4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B9724173;
	Wed, 12 Jul 2023 19:48:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48C17758
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58166C433C7;
	Wed, 12 Jul 2023 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689191287;
	bh=tWDNCS0KPz2aaKuLfKxjCNjaaiGoRwqtrsqHEHlcTR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bg8lXiYspAfHD8LzKSkM4CsEy1B+GWbJMX/DH/DlsKtOt7lxJFzZztI0I7jio0fea
	 O1wXqJRGa0Q8t2ShULx/CFU23uqpfywzvUzfjiHSm+BrsOUpOwP3kgAi69AMUfwPGz
	 DmPByOg8kPMYX3e8BeEPSUmHEWyatQo+xomsVlsqfnMAlprEzzKqDbt9gQ8CyGvhhD
	 WbijDRdY+KTEEJFmTp3xfCYlOLkhsNu02zVLM2l+UsdAClnDBSpEheLHazuuQrOI8H
	 jtzEhHeC0wqhp+E4EQZ1ueRc6HTgEpfii7s1Ceh+uR0k43yyILevIMMAmouf4qDpZT
	 FUYnVxPPyaq9w==
Date: Wed, 12 Jul 2023 12:48:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] devlink: uninitialized data in
 nsim_dev_trap_fa_cookie_write()
Message-ID: <20230712124806.5ed7a1eb@kernel.org>
In-Reply-To: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
References: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 11:52:26 +0300 Dan Carpenter wrote:
> Subject: [PATCH net] devlink: uninitialized data in  nsim_dev_trap_fa_cookie_write()

We usually reserve the "devlink: " prefix for net/devlink/ changes
rather than driver changes, so I adjust the subject when applying.

Applied, thanks!

