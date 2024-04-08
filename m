Return-Path: <netdev+bounces-85775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D225189C197
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737731F2231A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7DD7F492;
	Mon,  8 Apr 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdlgXzl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7E7EF1F
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582290; cv=none; b=D2Ixc8SZY2sid8GftmRCUujjfJrZgbEj3RjV71pT4Q8OVDxSKl8n5V1hr2VatBskmfneU5/bAJgofxepVsd/R5Nvr15ntdJwkTzj3AqigP6dss5WOdSnPl1QCpunPYgk2aC9O5xoDfB61B8sLzwdzQGqzTNaNynAv3v9i3AoHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582290; c=relaxed/simple;
	bh=vH0xsuRazAz1YBhteI+IlgxwCmTUK4RXlDVbXJRvbUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKyWLonECHRESudEhQcps231DR6aZ5vS2Obk3dXcK6e89GD0jQviR638kH3nmUpdcncdEFgm4OgSZg4sshMwjsLPTRhSQPgYaU2Dyict8G6GIS6H63hQN3wqeB3erVtMzZbYkIbgKFLEFmiAUM8UlFZ/BIVuUFIxGwxTatM/B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdlgXzl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC69C433F1;
	Mon,  8 Apr 2024 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582290;
	bh=vH0xsuRazAz1YBhteI+IlgxwCmTUK4RXlDVbXJRvbUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdlgXzl0Vtapilq9OQS7AVNf/2ViImNMHTwFN+27cKEHTPOeJW47rsXL83AzYvXso
	 riwHm3nVe3X/9ReKgD68/f+m/BQXH8xwSp5hOqJiKp93z1P6k9BUKRCII2EN3tMMWi
	 /Jy8SgH+b3yF0DxnzfDSF6ONAIkl6GB2UAkhu8c/EOeGcvcPdla0/4JgQdGNHYR5tE
	 EF1U8/bw+I06PKR0CV8HB0Y6O6EMC2C0z9J+zKN19NU2dC4oHjvS9D7j+8yIzlZ8d2
	 MlFAacic+Kyl7H9G5YefNvhWYDQEAk73aHWcVWK8+i8A4izH7PzEHINf2OtB8pUtQS
	 Wk5BTa2Cktpdg==
Date: Mon, 8 Apr 2024 14:18:05 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 2/4] nfp: update devlink device info output
Message-ID: <20240408131805.GF26556@kernel.org>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405081547.20676-3-louis.peens@corigine.com>

On Fri, Apr 05, 2024 at 10:15:45AM +0200, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> Newer NIC will introduce a new part number, now add it
> into devlink device info.
> 
> This patch also updates the information of "board.id" in
> nfp.rst to match the devlink-info.rst.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Thanks I agree this is consistent with review of v2 [1]

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/all/20240228075140.12085-2-louis.peens@corigine.com/

