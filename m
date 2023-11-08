Return-Path: <netdev+bounces-46555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89BE7E4EEF
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E491C20D54
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5DD138F;
	Wed,  8 Nov 2023 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAS+6wur"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173A137D
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 02:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E7DC433C8;
	Wed,  8 Nov 2023 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699410778;
	bh=oxdPRn1arWKno+F4Ag4BitwCnKv4pNyK5vr88aO4zBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sAS+6wurvdk5DVWAx4sIYBr1J8yvuysqIW9qVadwv/hAIBX5k9wdQuWNvhOfg41LN
	 XmRgZNvcm/rg1M4DiPiRkTH4O0AbTX3i5+6ZijZbq80vT41bU15qIOFhhtQFosrJng
	 YlXv6HHXQ3womyyI2n7pw3gPZua2khbYJVtdO1hjcIIyvdisXMw+2bOSqhcD1B5IWm
	 /nLVrmYwCXqcEy2FZ3QgHVaAtxwDzcfWLrYuzps/xZR/74z7U+C2t53PlabHW3CmDC
	 hZNHnl7I9LTEOm/FRkvnBU8P6fLqwiADQCjNZccv5s0JulfmTUq1opqJnFaG0Uv00z
	 +mj8QJD+7hNgw==
Date: Tue, 7 Nov 2023 18:32:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar
 <danishanwar@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>, Nishanth
 Menon <nm@ti.com>, "Su, Bao Cheng (RC-CN DF FA R&D)"
 <baocheng.su@siemens.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add missing icss_iep_put
 to error path
Message-ID: <20231107183256.2d19981b@kernel.org>
In-Reply-To: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
References: <b2857e2c-cacf-4077-8e15-308dce8ccb0b@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 12:47:42 +0100 Jan Kiszka wrote:
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")

Is there a reason you're not CCing authors of these changes?
Please make sure you run get_maintainer on the patch, and CC
folks appropriately.
-- 
pw-bot: cr
pv-bot: cc

