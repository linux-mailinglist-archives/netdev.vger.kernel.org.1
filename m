Return-Path: <netdev+bounces-169604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9177BA44BCA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5EB3B348A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061081DC9BB;
	Tue, 25 Feb 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KocZg/as"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DC19C546
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512914; cv=none; b=k2TaTIwCEM/ZGpXhZ4abQ1yRGDbLlkmQqke8j1Jysax+ogQRQ2gQp2PVEl+AovmnGDiuK1WiFRu/UAjgycyBEeWe5sWaMWCHBKYWdgunPdovwqvECzbKf0siYEghiNo4mhJiPrVWcaauVVUKTFOE7dEIxJGdZ88q3vcEasBXlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512914; c=relaxed/simple;
	bh=eGO9RjWRqyaPT8WjWPxv97yfiGsPtGMAuOfKry2KSCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8dDxSph6mZmaDMw1D459PsPD9DuMtMSWtu7bgv1RMIBM/t4RvlzPYIwIUqQo48KHdefmdCDTq4opn7rv0vqq3X3mq+vKthqEv+SHeOqW3c1UyS4g4NvuD73nCFdKwVZYDLHZVnoScw2WZq2M5BnakLi96TOW8AoISg02NTbko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KocZg/as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEACC4CEE2;
	Tue, 25 Feb 2025 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740512914;
	bh=eGO9RjWRqyaPT8WjWPxv97yfiGsPtGMAuOfKry2KSCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KocZg/asEq7B3EiFyhHzcrZDGwLZgCD7tH2SvzxTznrso+daJ6TxcqcV6Pszz0Kic
	 joCZP/52P6YTf/ZBe1gYWKptaSWaEfEkdYWkZK7fhXMTlkm1XLlEsGp11VYCqk6CmS
	 QghkYfeP5xhd46S3Lz6DJhwkv7tP69/oIOATXrtJqF9qZZVNUkCrb9SG2H/K2fuiqz
	 S5nnpioSjKHplG+69ZgcPBiB3ASn4ECfnufwKv6+moWMUF63dZXUieOD0VX1rWJfqu
	 qXCvaT5cBz0qcxHRyhMlbOXgiARBD86CUu6rPkNtJ6U2Hg95Q0ZmzIWZlsZviS7Dw1
	 kwikAyQ2NX2OQ==
Date: Tue, 25 Feb 2025 11:48:33 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Roy <jf@devklog.net>
Cc: netdev@vger.kernel.org
Subject: Re: mlx5e_xmit: detected field-spanning write (6.12.16)
Message-ID: <Z74ekZy_WnOhAQrD@x130>
References: <CAE8T=_Go-A_W9j18oO+5S52pXKwgFDcR8XgHiywwSRSZmO2LEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8T=_Go-A_W9j18oO+5S52pXKwgFDcR8XgHiywwSRSZmO2LEw@mail.gmail.com>

On 25 Feb 08:37, Jean-François Roy wrote:
>I'm regularly seeing field-spanning write dumps from the mlx5 driver
>on one of my Talos Linux + Cilium nodes running Linux 6.12.16. I don't
>know if this is caused by a bug in one of Cilum's bpf programs or if
>it's a legitimate issue with the driver.
>
>kantai1: kern: warning: [2025-02-25T16:19:43.741311529Z]:
>------------[ cut here ]------------
>kantai1: kern: warning: [2025-02-25T16:19:43.741322529Z]: memcpy:
>detected field-spanning write (size 32) of single field "h6 + 1" at
>drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:469 (size 0)
>kantai1: kern: warning: [2025-02-25T16:19:43.741350529Z]: WARNING:
>CPU: 2 PID: 5273 at
>drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:469
>mlx5e_xmit+0x99b/0xe00 [mlx5_core]

False alarm 

Can you please test this diff:

  git diff
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f8c7912abe0e..40ed9d37edf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -448,7 +448,7 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct
sk_buff *skb,
         eseg->mss = attr->mss;
  
         if (ihs) {
-               u8 *start = eseg->inline_hdr.start;
+               u8 *start = eseg->inline_hdr.data;
  
                 if (unlikely(attr->hopbyhop)) {
                         /* remove the HBH header.

Thanks,
Saeed.

