Return-Path: <netdev+bounces-32727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F303799E88
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A839281052
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84996FBD;
	Sun, 10 Sep 2023 13:49:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314442586
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D0FC433C8;
	Sun, 10 Sep 2023 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694353782;
	bh=IAqYcnKPzNeIDqtgIjazLW2Yv7D0oebDNR4aro3tFR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwVw6uy4xBOyPC7qVHVIFToy35ARWHf379d+0HzdxNvsXYwH1v+eY1MvBRhL7oYdo
	 hW/oawjpRjhEPSSVEzxX3YisDq+Jj0P4bGzpnMNZZgm0ajODZLwEg5136pVjUfTgem
	 5SWaweMjWsFxjta5iIwUvjQNib4Upzjz2Q7cj492mahxKd6VRfeqCvwDfDNCHYFYK7
	 WsFGKucXwBEWljBB60m3P88mjdVLA1oV4HByBNPrTYUDayOwZ453Fo27VRUb921im3
	 PZ/7ZTSMCnEIPmOHNggCCcjLLA7caGXZ+sefborg1PEnkXMa6ttMbzrDbZbnq9xZut
	 eRCzJ3cu2fWtw==
Date: Sun, 10 Sep 2023 15:49:37 +0200
From: Simon Horman <horms@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Justin Chen <justin.chen@broadcom.com>, kernel-janitors@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] net: bcmasp: add missing of_node_put
Message-ID: <20230910134937.GB775887@kernel.org>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
 <20230907095521.14053-3-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907095521.14053-3-Julia.Lawall@inria.fr>

On Thu, Sep 07, 2023 at 11:55:12AM +0200, Julia Lawall wrote:
> for_each_available_child_of_node performs an of_node_get
> on each iteration, so a break out of the loop requires an
> of_node_put.
> 
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


