Return-Path: <netdev+bounces-95926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5A8C3DAE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C57B1F22C33
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D5148313;
	Mon, 13 May 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvdhs1oh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B722B9D1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590788; cv=none; b=FWRii9/Z9bkaM6G3YQUa8A71oxokve4B3+gh5sMBbkUxU9C+ySKTapu+CICCANf+H6EXfH5hsB5T/ll9rC2QM7mnZ4rwb+7vFHp95IVDQ4XUZsGrRRVJiBbyQZTkig2J1TGZx1He+UZMAVIE6gAAMcO6T43L0A4/DiezLOKO+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590788; c=relaxed/simple;
	bh=2khpdNC4nBfeHHEH81yTMJp3W124lhTVBulUZlobIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMYonfFYm4wYFKTCSfmq0KyhhmsJpkl1A3VVqeFUoA5RBp07QzwbYcm3ayqh/kA7g8MRmFqJbpqL4Bt6H4NFGwwI8LkZdZm4oEoLiliVU+YjSOgAuUAwiphEpsaaHl7/+evxVop9CTxELPyfRqcQPu0UgDw41wXbbRYw0XB5qtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvdhs1oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9E2C113CC;
	Mon, 13 May 2024 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715590788;
	bh=2khpdNC4nBfeHHEH81yTMJp3W124lhTVBulUZlobIMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvdhs1ohgN7bzeniJXFdRUFHghn+JsqqjAaqhcw1xitCqdWmwl9EoqDoHpxfeeNnR
	 9iPOuzn5C/qdbFXAewVzIDlZ5N568ptLD6vjye9aYtD32WRcgVrx0RV4D/znPQD/Qe
	 vMtomPy+RAL4MgnWE48f2FEbdjpquU2CIrjddsbQn1oh/O9Y/hTpX8v8w7/Zhwj7SL
	 OT4lN3Qq+BjMBeDjA9qtWhwGeUaWOgyERUs4dVLU7xqov3GgS7Do+EvRCAn46TtAMO
	 sb4J3YJbIzPGVqLbijCSXr+0QinShSw5WOeQrc1MQx+6rUWzfRv+GHPIAR/4VSmfe0
	 PKUhsPyVQz8Zw==
Date: Mon, 13 May 2024 09:59:44 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5e: Modifying channels number and
 updating TX queues
Message-ID: <20240513085944.GC2787@kernel.org>
References: <20240512124306.740898-1-tariqt@nvidia.com>
 <20240512124306.740898-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512124306.740898-3-tariqt@nvidia.com>

On Sun, May 12, 2024 at 03:43:04PM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> It is not appropriate for the mlx5e_num_channels_changed
> function to be called solely for updating the TX queues,
> even if the channels number has not been changed.
> 
> Move the code responsible for updating the TC and TX queues
> from mlx5e_num_channels_changed and produce a new function
> called mlx5e_update_tc_and_tx_queues. This new function should
> only be called when the channels number remains unchanged.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


