Return-Path: <netdev+bounces-52652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E97FF943
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD2928158C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906B59172;
	Thu, 30 Nov 2023 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJiHRxIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42D54FBD;
	Thu, 30 Nov 2023 18:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFDEC433C7;
	Thu, 30 Nov 2023 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701368696;
	bh=wPIgvmYXn8XujCdyRCb4AFBjJLjOcelID6h7SxaT5hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJiHRxIN8DGcil4FV942uO/5zKPkC8dJKlOvVUQW2NSv+ryDnOIsiT2UCRojDOuuX
	 un/61uItBt8ImwU3hUOVnYNe3SGnBAQ5uFA3jMxe8uW+NtChemHvJ8bnlLn2KfViUv
	 yYiUGHcHHbh+5TOoWMWbP0CIZO0N3v2DUTrfHwNBQw34plqsbw8Po0FkEXIrWM79xx
	 ZehUMbkQzXauNCJOF1GatCrYMv4xBJ5zcFyYjbOwTsWuM+9XVB+U1V0VL4TRS3eloq
	 qh+dRR9RLZSwlPfpDNSX/TDn6Rjb87c9KXoByXpe5kbSChA5poSbYtXbrtS4e1oFXQ
	 cLEpD34rBGN3g==
Date: Thu, 30 Nov 2023 18:24:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, nogikh@google.com,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH net] MAINTAINERS: exclude 9p from networking
Message-ID: <20231130182451.GN32077@kernel.org>
References: <20231128145916.2475659-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145916.2475659-1-kuba@kernel.org>

On Tue, Nov 28, 2023 at 06:59:15AM -0800, Jakub Kicinski wrote:
> We don't have much to say about 9p, even tho it lives under net/.
> Avoid CCing netdev.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


