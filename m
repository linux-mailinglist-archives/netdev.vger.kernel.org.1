Return-Path: <netdev+bounces-67245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC2842747
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6577B1C265DC
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488D7E56C;
	Tue, 30 Jan 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5wXC7ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865E7CF37;
	Tue, 30 Jan 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626545; cv=none; b=UaRSFoZCc+XBD4jlhzk3w5Wsw24e0mpIaGsjC9Dt+EfZ7pLpRFCdYn+PcmLlIXa8e56t8TFo5ezMdRPGDcbhXEECp9zEbllRfDoCFSlQ3LpQrLRyenxUuUxW5CH6iQPcWtLB3P5RLc8uagbLkOpPJFjX9NUjuJ4VPfNqMl6stFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626545; c=relaxed/simple;
	bh=Anu8EbvK2I56DyoxGKfmfPHC+5qwy3Re/Z8pRTKYjgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Lj9QhV86y7aa2sjHyaK7+Dq2urEAcqGQIcf0CWOxBs9yYgv5l5Ye2QiEzJomPyrBn6OjZa2UZmfrNuY0KU1V1KLRPDaoCzISFEjbE50NSuKWV+PgaJxm8008WlnjqV7OTnt3EBgNwU0D4dwIYeLSscot9jO1ZAJfb05IlwQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5wXC7ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826C5C433F1;
	Tue, 30 Jan 2024 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626545;
	bh=Anu8EbvK2I56DyoxGKfmfPHC+5qwy3Re/Z8pRTKYjgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5wXC7tiJTJTIXHw2dgPDnMxATy64Ety7+/D1Aw0ViQC1CzLRQwbZQ4UzY1P+2d6b
	 Zlr/uNadqUA3WHqo+GWl7U/jluRB7PhC1/dBLHVsVUa8uVE4m2L3NQdnwyCk2+wxnP
	 iqP6beCWaLZu9lnAWNbX+NKG5l9ujxdQGXj7FOUwYNGyuRzSZJ4tcJ0+UAL7mAl5mB
	 +tyaJ22Ry0VPhLV7E9cwJZ/jveDOwVLBgY9nhJfSWxAVOq1/CDU6LPRRZkhfiff9OF
	 rjghRn8m1LNVChSgUVgImR5PXIte256js3uHDXM69e2QGiJZ94whc4oVeK3cjaPjWY
	 KE44CHUtzw56w==
Date: Tue, 30 Jan 2024 15:55:21 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate fq_band_pktlimit
Message-ID: <20240130145521.GL351311@kernel.org>
References: <20240127023309.3746523-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127023309.3746523-1-willemdebruijn.kernel@gmail.com>

On Fri, Jan 26, 2024 at 09:33:03PM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This test validates per-band packet limits in FQ. Packets are dropped
> rather than enqueued if the limit for their band is reached.
> 
> This test is timing sensitive. It queues packets in FQ with a future
> delivery time to fill the qdisc.
> 
> The test failed in a virtual environment (vng). Increase the delays
> to make it more tolerant to environments with timing variance.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


