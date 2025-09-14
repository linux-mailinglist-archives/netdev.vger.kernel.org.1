Return-Path: <netdev+bounces-222884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E073CB56C2B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F35917A71C
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2438221703;
	Sun, 14 Sep 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbdmkuMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C238DDB;
	Sun, 14 Sep 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881912; cv=none; b=gFxSSTXo52DMBI4Z0pUDQIkqiC8X96XHSeixmNMozcYjkTTTKvjbAa1+saOLbQVvcNW2Qw150ifqZrZyXFq/7c+ey8sHzjTfO0eLYtqZpFVxMtw1eUWO1FP9sfagTt2p555xVRvpHYgfzZxP13p5SPunkLWZlSdxhjpC9M5c/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881912; c=relaxed/simple;
	bh=avc3T9OKXOTUPbjbWJB+zkAClQK4ZtLW+SC5KE/5ISc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJxwmod7eud4E2tZ4sGKO10xpUuj+L2A1xDX1vcMcSbBwj+dNg763cdZZ50ONWUB1Enktw8DO0dJwHSFaKGexzwQuNiHPNb0CUpQh2otSDnmGbNQNC8IKnsnoXrHTf6pNW5RGclI7/iStcoVEELAeOh96YQBC3uEDXu2FRN8k0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbdmkuMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA24C4CEF0;
	Sun, 14 Sep 2025 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881912;
	bh=avc3T9OKXOTUPbjbWJB+zkAClQK4ZtLW+SC5KE/5ISc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VbdmkuMNZd9Z5TV+M6sgMDbT7/nJ17GwAlIRxC+on3xA0K2OzxuSihvuoozTQHLB3
	 TZVYIyFNH1u5OujgQW/W68g2gZoEs5mGwzNy6hepDb6qkOmBa/gKoJ/Hzxc8XFnNfV
	 aG9AwH53wh1Up16yGQjvUWv1lB2HEvwGxlrPM23g5O87Y8dVoj/eqTTmIvS+cuYS2t
	 P2INuRb85r9hkCfcQb/6a7++Vr5woRYemXCHInp0+WFFgDQEeGsszg/8gSYgOYrA/J
	 blaHs9YteWzGMFhVFddm53XLqYTLxCg6mV5bUNxq7dpEmW4ZfmYZR3SsAbr6K5KQYQ
	 glZDUocq7SeQQ==
Date: Sun, 14 Sep 2025 13:31:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 06/10] bng_en: Allocate packet buffers
Message-ID: <20250914133150.429b5f70@kernel.org>
In-Reply-To: <20250911193505.24068-7-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
	<20250911193505.24068-7-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 01:05:01 +0530 Bhargava Marreddy wrote:
> +static void bnge_alloc_one_rx_pkt_mem(struct bnge_net *bn,
> +				      struct bnge_rx_ring_info *rxr,
> +				      int ring_nr)
> +{
> +	u32 prod;
> +	int i;
> +
> +	prod = rxr->rx_prod;
> +	for (i = 0; i < bn->rx_ring_size; i++) {
> +		if (bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL)) {
> +			netdev_warn(bn->netdev, "init'ed rx ring %d with %d/%d skbs only\n",
> +				    ring_nr, i, bn->rx_ring_size);
> +			break;
> +		}
> +		prod = NEXT_RX(prod);
> +	}
> +	rxr->rx_prod = prod;

You should have some sort of minimal fill level of the Rx rings.
Right now ndo_open will succeed even when Rx rings are completely empty.
Looks like you made even more functions void since v6, this is going in
the wrong direction. Most drivers actually expect the entire ring to be
filled. You can have a partial fill, but knowing bnxt I'm worried the
driver will actually never try to fill the rings back up.
-- 
pw-bot: cr

