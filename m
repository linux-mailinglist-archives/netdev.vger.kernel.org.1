Return-Path: <netdev+bounces-67244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219E842740
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CB01C2651B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4C7E56C;
	Tue, 30 Jan 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYREH9M9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB57CF1B;
	Tue, 30 Jan 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626465; cv=none; b=kGEVWYLfDsRoN+I0oKUCRlNcaBLOZOpPtCg3+rLAs76hHWjg6UV6NXigdzz8ucl9/HFEuGBhuemTIlTrUGGHETGS0qy6ThcbwXpwyLRhn9cnmDXUMVClcHzMp3klP+wcg+DQXPcoel5G/nah4NKUolhOpp6+CPV7PUHwpnuXbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626465; c=relaxed/simple;
	bh=8cLeOPgTadYKlEfNe21+miLFsUXVR0uTfie/gImXNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snKpfXd5YTnpdCmFWI0sm0EviZTFjnUGw6LUAn+EZ4IHycJtIYHv342fGbOtFEZzdl3ESUKyqK0Gal19pIZT+BclvbhOqFW93z2RtYr0cEfK/Vv8k9MttFtAxZkN54J3aorAWtPE9PcqjNtr5Hhdwp06jdCchNEjbVRBdpYltJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYREH9M9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0C6C43601;
	Tue, 30 Jan 2024 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626463;
	bh=8cLeOPgTadYKlEfNe21+miLFsUXVR0uTfie/gImXNcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYREH9M9EYrB13sbo/d2NK3gwFtnk4JZjfedGc9ndsllaZfKk2aJt18OKu948LQrc
	 DuVYpQRsx2HgDVkD6//O9oLo/p1YjGgnPQBuFjxSUfuz/1x79y8ZcXC/j+eTPmuNFJ
	 KaHKinWQic+W0t6BrWjPGSrj7TghNl0weDXI/dSh9+RV30AsAj3KHNT81QuMXcwXLc
	 2lJqAEN8UD0ww42AMs9tjiF/1N6gRawda0nEXD68bcrk1DNISxz22aQ2uAJo+qDmhR
	 /82WuoPE1i5a+ZmfosbiKG8hr7nYWd04IUBkAPuO+X68PW1Tgho9HWtlXNk3tIsSKs
	 elMqbFBhXnqaA==
Date: Tue, 30 Jan 2024 15:54:11 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Message-ID: <20240130145411.GK351311@kernel.org>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>

On Fri, Jan 26, 2024 at 09:31:51PM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The test sends packets and compares enqueue, transmit and Ack
> timestamps with expected values. It installs netem delays to increase
> latency between these points.
> 
> The test proves flaky in virtual environment (vng). Increase the
> delays to reduce variance. Scale measurement tolerance accordingly.
> 
> Time sensitive tests are difficult to calibrate. Increasing delays 10x
> also increases runtime 10x, for one. And it may still prove flaky at
> some rate.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


