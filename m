Return-Path: <netdev+bounces-242158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E334DC8CC9C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723673B0FB3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24447298CAB;
	Thu, 27 Nov 2025 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxeS/TaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316324886A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216589; cv=none; b=U+uXvJ9Qck1DzLXqhf1Tnf57J7J+b9oZKXC9RU+ap+Ch6RMtvt94HA8VEKGl3+pGqdTXhKK6JZueKLMXAv1lXso8vPhCdoqvgwIwHwrLdz++H9XHg3JUpKw18n9OJbG27+V9L50mZ4M7ChSOIGVoDrIt4l7xPHptgiT94n3Em3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216589; c=relaxed/simple;
	bh=47ibqBgbYElV5Xv8nOGdu0lOSoSqZMG9McnHZvhgKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5Qcg3UphzNJeaxsHj4mvWQP0DqKz6ahwZrfwb373i4QdaBdAWddZ2oijJ1S/3QHQ+9DLdKbMKpViCl+j6Genu1o7xjAy/4kY6SPBQTFWoKy4gI4BOWFUZU21a0XubxvWApSii94RRvxDIhOq4BtxiRGdu6rzyK9TLcLIVT4zMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxeS/TaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B51CC4CEF8;
	Thu, 27 Nov 2025 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216588;
	bh=47ibqBgbYElV5Xv8nOGdu0lOSoSqZMG9McnHZvhgKjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OxeS/TaYMyuvb9sn03RKnoBbKzYdQ9gINXXJUwXOcmf5ulXtA9ZrHrCLG62+xFKmf
	 kH0nwdzMN3sxs7UHpA3ejFwQZMAhkpz2mq6GDQC//XALx45NDRvGIcyADKP8AjQRoS
	 1YeI+9MfraD8CZ2ASF0Qrfk+pnq7iOE3YpxMInvpg0VrNBoNme/MmvHMFuwvvzv15w
	 4MxgJGScg44s3QauUKYc+DT8O2M/zqCocrgFXjZnTm73WxSJ9QuYh4GfNV+anPq5YK
	 JcAoOfPmu43PS+cCp2T2q8OHsaz2r+khUJtBuStt9vYMFRN9un0kIfaYoCGwq/lQr8
	 1HNww5HTidWDA==
Date: Wed, 26 Nov 2025 20:09:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 0/7] bnxt_en: Updates for net-next
Message-ID: <20251126200947.6180d62c@kernel.org>
In-Reply-To: <20251126215648.1885936-1-michael.chan@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 13:56:41 -0800 Michael Chan wrote:
> This series includes an enhnacement to the priority TX counters,
> an enhancement to a PHY module error extack message, cleanup of
> unneeded MSIX logic in bnxt_ulp.c, adding CQ dump during TX timeout,
> LRO/HW_GRO performance improvement by enabling Relaxed Ordering,
> improved SRIOV admin link state support, and PTP .getcrosststamp()
> support.

Hi Michael, Bhargava, 

in the interest of fairness it'd be good if you could coordinate 
to make sure there's never >15 patches outstanding in patchwork 
for bng_en + bnxt.

