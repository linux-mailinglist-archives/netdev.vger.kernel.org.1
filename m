Return-Path: <netdev+bounces-50146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28727F4B4F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADBC281207
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910856B6B;
	Wed, 22 Nov 2023 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beZDI3eC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED856B68
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F36BC433C8;
	Wed, 22 Nov 2023 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700667842;
	bh=X5EgM62uINGxbjN1yuYL9Kitf1k3eUlMC2x4ZrpcDMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=beZDI3eCVBhthAdEMRfwFalXZqtF/ATYO57C4ilkEaZjdxIvRTSN6G2pVTFlaEWSg
	 RszFvbOeodZAxEOIJfJqkfsl3tSxAwDKE+fEahAkT/+xQ8P/W7r6+p6x59c3xQEUWr
	 KuWUyAFT4NWFv1VwwjHK+BF9cs/b5kYkam6eWG/fzermLjm+NB76BhP3wdCNkNZpol
	 q6ndOcaOgC8dnuwG4egFnicq60gdBViDLmi3KrtlmWt24HT0ekQddQEzcuMgnaxs5d
	 2U0A6NcvOnnfVb+muJ1F5lbCwhOIJZZPhpEjsHKNtM0I6zeyFeTEVNpHe1zF7dseHL
	 Oeji5ZINbyLrw==
Date: Wed, 22 Nov 2023 07:44:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Subject: Re: [PATCH net-next v3 03/13] net: page_pool: record pools per
 netdev
Message-ID: <20231122074401.56df54e4@kernel.org>
In-Reply-To: <CANn89iKPhGtC6wgThpoe7DmMkowNSbOQehcpDVnOayF42Uqk2g@mail.gmail.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
	<20231122034420.1158898-4-kuba@kernel.org>
	<CANn89iKPhGtC6wgThpoe7DmMkowNSbOQehcpDVnOayF42Uqk2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 09:55:34 +0100 Eric Dumazet wrote:
> > +       lo = __dev_get_by_index(dev_net(netdev), 1);  
> 
> Any reason for not using dev_net(netdev)->loopback_dev ?

Incompetence :) Will change, thanks!

