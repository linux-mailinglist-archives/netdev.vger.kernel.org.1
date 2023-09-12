Return-Path: <netdev+bounces-33371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96B79D9BD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FCC281878
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68682AD32;
	Tue, 12 Sep 2023 19:45:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D628F68
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 19:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9DFC433C8;
	Tue, 12 Sep 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694547922;
	bh=4iroGb+H8hWQx0SA7FdXQ78q/JfXbfPgai/e9OcB/mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiXKdH2NLcIvKce6hICwQyF+HnF6aLYIve/zcthYTzfD6ezy4jL3OZUEhllfQDgOm
	 5/4UOOj2zGz9LGCl7je7U97WoTFtqKDq9IWXedHGGwmxPyg8ntrb+lczOuSehvoKSw
	 4feVarKeFxJ6hqBQAjU/lEx1mHkgGGhHEs7j4LVNhywBqE/o9mBCPtrrKtSusu8GQp
	 14TlU2pTuuBMgmnQcEiUz52ZgiPouIdSXJuSPtlUHQlGuL1wt2aygiGVY09dC9iYXn
	 cTqEo9jx+8Z/Zcmy3IAzVOwOf8+Z7K8VDsorXuhgnAdSrkBnSFGTyK4agyPdd71uGl
	 9SSS5cgN9W6IA==
Date: Tue, 12 Sep 2023 21:45:16 +0200
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	"mschmidt@redhat.com" <mschmidt@redhat.com>,
	"egallen@redhat.com" <egallen@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh B Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Satananda Burla <sburla@marvell.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [EXT] Re: [net PATCH] octeon_ep: fix tx dma unmap len values in
 SG
Message-ID: <20230912194516.GN401982@kernel.org>
References: <20230911092306.2132794-1-srasheed@marvell.com>
 <20230911180113.GA113013@kernel.org>
 <PH0PR18MB473404EA35ADAC222C9EB68FC7F1A@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB473404EA35ADAC222C9EB68FC7F1A@PH0PR18MB4734.namprd18.prod.outlook.com>

On Tue, Sep 12, 2023 at 06:37:46AM +0000, Shinas Rasheed wrote:
> Hi Simon,
> 
> This change is required in octep_iq_process_completions, as given in the patch, since the scatter gather pointer lengths arrive as big-endian in hardware.

Hi,

yes, I see that. And sorry for asking such a silly question.
But what I meant to ask is, if the change is also needed in
octep_iq_free_pending()?

