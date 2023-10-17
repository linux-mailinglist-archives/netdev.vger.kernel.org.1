Return-Path: <netdev+bounces-41824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BA17CBF92
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479311C20A06
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05995405C6;
	Tue, 17 Oct 2023 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtAKlHrf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5883F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5BC433C8;
	Tue, 17 Oct 2023 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697535536;
	bh=q5zeQh7ro2KARanVykv+WJlniZIPzo8eTIj5c61IbSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtAKlHrfihWpLZuYmTMsv3Yh3Ex/Z29hqW3E7PCXH6l7+6D2nGKPXtpnTLBKc+ZFN
	 mohjJ3oiy31ZIPnQsELDRF94QxZiTfOymc2OcGVf1e87/xMDpAbKBc5KSRDVYtJ2eJ
	 PiLhN+JPDaKTNRXisra7A8RGu4lYfWaSbXbJ1UtUyBm1O9PAwhooT4Rdi8+K7BYT7N
	 YMakNmAutTZplQqh23xSFWiOwCRMZfk/s3uMc5pexvyqKMzB8z4k7XbqEh+aJacaim
	 3U4raGDHbqQHLQGQbiBiGzxmYRUKt9xN4t55GMgRqYkTWr/2fi4MGWxcI9r8DBRHLT
	 L/D+UTTja6jiA==
Date: Tue, 17 Oct 2023 11:38:51 +0200
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, egallen@redhat.com, hgani@marvell.com,
	kuba@kernel.org, mschmidt@redhat.com, netdev@vger.kernel.org,
	sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com
Subject: Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Message-ID: <20231017093851.GW1751252@kernel.org>
References: <20231016092051.2306831-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016092051.2306831-1-srasheed@marvell.com>

On Mon, Oct 16, 2023 at 02:20:51AM -0700, Shinas Rasheed wrote:
> Clean up structure defines related to hardware data to be
> attributed 'packed' in the code, as padding is not allowed
> by hardware.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V3:
>   - Updated changelog to indicate this is a cleanup

Thanks, the patch description now matches my understanding
of the intent of the patch.

Reviewed-by: Simon Horman <horms@kernel.org>

