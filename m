Return-Path: <netdev+bounces-57906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD18814777
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C4C1F22897
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31725564;
	Fri, 15 Dec 2023 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkxPkkPu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D825561
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FB1C433C7;
	Fri, 15 Dec 2023 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641500;
	bh=nqv+DYErsm2v/00oIU0u2K2ZivFpXs2/RT2SkJYXqP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkxPkkPu06oVjkkUglY0utpNrlMlOF6OffzIdjWxpZaByJzKW4UawPthCL5Xw6v66
	 OaHFnPlwuntIcrYIUbJ40wUHopEAvcVG2s/uqTXKuO20GIfiZPqwQKyHNClQoaeSE7
	 pDuV5IeFxZnYZj1d07aMZOuN1as+HDOhrf9JIIKml7nYfYpDbYecTDYIgIHboG4wQT
	 FUl8DGtDpULrx3FHYu5rUiE0uXnf2f//CAL6h7cG0e6VgMvWNrrjc7kNWECymMnt3b
	 2pjTMDT8ndIhGqY64ExDXRiLhnrvhw5hzwUVphOjtAm/e+n0oKTnfg0x757vZ0vSXH
	 PBhyUHvVLfCwQ==
Date: Fri, 15 Dec 2023 11:58:16 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/8] dpaa2-switch: print an error when the
 vlan is already configured
Message-ID: <20231215115816.GF6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-4-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-4-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:06PM +0200, Ioana Ciornei wrote:
> Print a netdev error when we hit a case in which a specific VLAN is
> already configured on the port. While at it, change the already existing
> netdev_warn into an _err for consistency purposes.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


