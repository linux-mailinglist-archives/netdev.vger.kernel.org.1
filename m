Return-Path: <netdev+bounces-55604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F580BA55
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253FA1C203DE
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC484881E;
	Sun, 10 Dec 2023 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q76oVVW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC107477
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD7C433C9;
	Sun, 10 Dec 2023 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702207107;
	bh=Mw5kA6PMe+ZvyKQlipStk5punFjg+9Pr9d05A2L1hbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q76oVVW2iIehrIoEA8eEUlj4ummxe3MSsPsc1RnGJGzbjkLTCA2+LkOjVd6rIKS+a
	 t5Shq2mZJisdNP24G1xOmOzqHNEqLxZIE4qxCgIczs/4bKZL8iK1OPqPdzuk5BgQvt
	 N0zUEvy3kgn3ULpvf8JbbakhYocahqZoNVpaaoVGBdKKYHXMwJJb8R5U5QcEl14mYo
	 zwhIqjNnN9XyNLS021RboG0NHHkBBQZe8acGheiLFMkRX4ublkaXEFFvOKRs5riUaP
	 x+R+NS2vZqOlUvEgqCIosMUIGKiZ+4W77mhY9CPi1C9e6xQ4y13kBKJqySCctGwngb
	 NUF5DV6D00qPA==
Date: Sun, 10 Dec 2023 11:18:20 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, konguyen@redhat.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v3] octeon_ep: explicitly test for firmware ready
 value
Message-ID: <20231210111820.GE5817@kernel.org>
References: <20231208055646.2602363-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055646.2602363-1-srasheed@marvell.com>

On Thu, Dec 07, 2023 at 09:56:46PM -0800, Shinas Rasheed wrote:
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
> 
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

