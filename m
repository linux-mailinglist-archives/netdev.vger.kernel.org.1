Return-Path: <netdev+bounces-51992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DEF7FCDB3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6981C20BEA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765263AE;
	Wed, 29 Nov 2023 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPPZYNBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA344397
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B9C433C7;
	Wed, 29 Nov 2023 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701230573;
	bh=wOBFlHcrpN6jw6bkW8h2aPIfllb2qos3OxNqtu6JNf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPPZYNBEd0iUMDqB8WYvDBY50pEyRLuSQ6D8IVoAAxoD+3QZbUjwhF/eo9+a0x+b8
	 qD1N8avYrwj0U+U91ZQWTWEZ0ssqpF646JVXNQkDotOPtAlTDBVUcrtYWe1LVOIvlG
	 aem784SKDxxdywAifdk0rVY5dMhPWpK/HuW+dJOGU2tAmtAY32uGKaZuekARryJB9o
	 wqGyYyeHQn3uxdKWp7bGEJMCN/WP32mxZ0yDw5v1fk7VYZGWFfhSTg3KMRetmQ9U85
	 YAQoJlfyFdDUqiB0BAEE44x8ojBP5m3tnDXj5vqY/Vzd30DiyorpTj3VpjhK7xESwP
	 jnErIYX7Hz6Vg==
Date: Tue, 28 Nov 2023 20:02:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Amit Cohen"
 <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
Message-ID: <20231128200252.41da0f15@kernel.org>
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:50:33 +0100 Petr Machata wrote:
> - Patches #15 and #16 add code to implement, respectively, bridge FIDs and
>   RSP FIDs in CFF mode.
> 
> - In patch #17, toggle flood_mode_prefer_cff on Spectrum-2 and above, which
>   makes the newly-added code live.

Is there a reason not to split this series into two?

