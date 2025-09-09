Return-Path: <netdev+bounces-221049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB56B49F4E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B217A2E1B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AEA2522BE;
	Tue,  9 Sep 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlBqYG4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA5244669;
	Tue,  9 Sep 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385553; cv=none; b=UP/Q3oq67znwuBPVQ+bAsIButgjiiWfgdqVN64kQBdlEMwcNXicveVClgXYgzXUNsOPGbe+WhN39wN4+Aid4gYIFh+5cBS6rv4YZsaAnCt9CD01AX4HLPXLcGAqpnt1NK2pkNbBd+b1Wx1kjQZ+KRojphm8KMvsOJ5O/6rTOetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385553; c=relaxed/simple;
	bh=c+xOG14cIR+h7UZrzd8eYGlQ9oDD51wB2GUUD5JSYUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2Rw5y3l1zpyvFfu4kmCO4WlhTHtY/sLQJwU7DJcpNSvCwNjRC2EjXiXVYIhqrLcdAM/SLenDIbiS8gKL345MOHXqbxFFJuHSfk4J5uFK+o9Fdzx6KdAepHHu5/EsA5cmKjizpd8YGekP/YbZBQN3kVIrCFz47Q2/OtryMR8s0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlBqYG4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A170C4CEF1;
	Tue,  9 Sep 2025 02:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757385553;
	bh=c+xOG14cIR+h7UZrzd8eYGlQ9oDD51wB2GUUD5JSYUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlBqYG4rT934qVoVECcsXFYHoHKJqmrYKiq/47AYDk8MGxcCLQDeDBZbdzut1Nct5
	 QluBhNZKn6nVRPBeRvkanABzOtC8vF/5Hhs+uWMs9OoXt5b3WemIEefh1N9gVFvEFG
	 K47gHeXbnmgziYrWlBVYJsq1NP2o6XX6AOL092pxPwRE4t3KZ3cOdd5CuaKdDmYEuF
	 B37nJ0IcsuBgNUK4+GBSqQrW54zNmYqJvKc/jEUX831cKPd52q7kvBuFr5cPGUJz9m
	 xG8L3KL++R4STPfaE4w8/BYA7Cd9TnPTTPYyTMUUW8CjOG1P6GfAVzAvo1bTT4pg+M
	 peJZQS3bxtCZw==
Date: Mon, 8 Sep 2025 19:39:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v6, net-next 02/10] bng_en: Add initial support for RX and TX
 rings
Message-ID: <20250908193911.21bbdc2c@kernel.org>
In-Reply-To: <20250905224652.48692-3-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
	<20250905224652.48692-3-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Sep 2025 22:46:44 +0000 Bhargava Marreddy wrote:
> +static int bnge_alloc_rx_rings(struct bnge_net *bn)
> +{
> +	int i, rc = 0, agg_rings = 0, cpu;
> +	struct bnge_dev *bd = bn->bd;
> +
> +	if (!bn->rx_ring)
> +		return -ENOMEM;

Why would rx_ring not be set at this stage?
Please avoid defensive programming.

