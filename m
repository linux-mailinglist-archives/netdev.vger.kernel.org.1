Return-Path: <netdev+bounces-209390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81558B0F747
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDF55811CD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDD1FAC42;
	Wed, 23 Jul 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOdfsOq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764C1F873B;
	Wed, 23 Jul 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285253; cv=none; b=HceEA7OUwkf3McIFU8jYuPVdRQx7336sbeihaiewh/WQlq/Enx5ThbgMwTXxfIHBUDOc+ThdMsY+cIV+fQhjbcVN7sgjX1qSz/1QrmOYgxd3jADnTuFDvtMlCPNyiSa4UGCn3BEKar4lnmVmxXIPCRIT1ZWJ3eFwI6xlJN4v4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285253; c=relaxed/simple;
	bh=+F5PDOGgm3CgM6Hbrc3ton2CGh3rZgivEAkUwBwDjjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCmoklBPpiCt5YD/1NXSfVPxOTikopzTFZ6ubS2mgUsjrpeQLAA4Lwn5fuunf9m6ES/OWVptTxpO1CNz6hOwuxyv9Ia7qBBFzWRsT900BvCadL80g3rXvK2mHXDlexr1jNxbIqdoD3LirfFq1XZigA59vwm8A9AAwjzCcn5ERG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOdfsOq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2663C4CEE7;
	Wed, 23 Jul 2025 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285252;
	bh=+F5PDOGgm3CgM6Hbrc3ton2CGh3rZgivEAkUwBwDjjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOdfsOq35PVi3TehOdeQUAhKzAusGBTjUqZMC4rSE6bGORFn/3qsNkfH7JC2wypIT
	 4x0DbQJI+j0HWIWv9Iv3tQpJgmmUnwOZ9DW5IM4mRSvWrajie6Jx5Ayz9JCYjrgjeU
	 2MgzCuERlLDqVc1wPW8qJxZ09y00QLtDzV1B3z6VhpxNTLH8a+Wc4/D4Y8jTt7sxI/
	 a1jyWTm2bJ9tnYXKQxPMkyyVx0iB5Tn4Utynu/D4KReH/yDwU5zxnThEOdqluCQz3M
	 WDrpphm5iznb2DGHSOGXXklYWMqys+oXqOEXL+WoF4/vDSybUuRlNh93mUmFA83hTK
	 vg21q2GbQFmrg==
Date: Wed, 23 Jul 2025 16:40:49 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: Add in6.h to MAINTAINERS
Message-ID: <20250723154049.GH1036606@horms.kernel.org>
References: <20250722165645.work.047-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722165645.work.047-kees@kernel.org>

On Tue, Jul 22, 2025 at 09:56:49AM -0700, Kees Cook wrote:
> My CC-adding automation returned nothing on a future patch to the
> include/linux/in6.h file, and I went looking for why. Add the missed
> in6.h to MAINTAINERS.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, nice to have one less file without a home.

Reviewed-by: Simon Horman <horms@kernel.org>

