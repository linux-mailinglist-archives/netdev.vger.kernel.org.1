Return-Path: <netdev+bounces-274117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMr4Kz4jzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD137B9D8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0236F318B640
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BB43E4BF;
	Wed,  1 Apr 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PGFAjVZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E443E48A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050759; cv=none; b=PPRVhSDnKJw1IBao/UDGskUJzx8Bmu3w+7Px+qOKfM9acyO66lL+uN5a+BPsY5IHfUhxJsyA1DmvlBjOGCCDyIV1D1tkeaQlGk2f9GMD6K7gYpKy/l9DO/SmNwReqJPlzPuXS7yP0AQPx3oRH0Nx1GkFPvYC2X8EVFTjwJg+WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050759; c=relaxed/simple;
	bh=hketbG0+Gx79AbhidYUKgR4UjZ73evB3q+sujpFAR0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FgyULHmfXTzS4v/YEfZoAkp4Dvn4ZFmSsi67RDU3zJE4YQwpcpXP01z4F+Rxigzb7jwG8ljwMegiMwZJUpQqbzfvqEyOma1RnF9QCwZAJWd1xSi/fJY4ZJRztGX04RAYNRPS3BWDCfKwQx2I7wTPRc8+p8mJpP+ZeZbz4/Vmc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PGFAjVZ9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66f747175d8so4223076eaf.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1775050754; x=1775655554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f1joDzYvaTTDmb8pu5drhC2rH1ET3V7sJAc7QOTBjM=;
        b=PGFAjVZ995KjAQiKX8imXVjyZCYRcCLNHRkVPxD+VTntDAqEA0uslbIMF6kiPms2rd
         Q9CKnGtAnLTXhSmk5EYRp/lZV66g96qBwB3zLKNq84NIK/ovknGrWSb+on9M7yUQQCVk
         NCsanbdgxmcCGJJ9gIzwg/P1GMKWKeQRb7Hy8owoI+jDAOBAdcVGJYs+3EVvxzxH5vu2
         5C7IruvcXu4/zhADdMdRkmFftBfRC6iG+P5YNcP+wXF9vFuASjJVinILcRIh9I4c7OSK
         l31jis8cazd2FAu2Af1tWRE8lDCtUYnBTSNJCgmn3gBVjGkrXQEp9H+j+Xs2wD18q17e
         nThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050754; x=1775655554;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6f1joDzYvaTTDmb8pu5drhC2rH1ET3V7sJAc7QOTBjM=;
        b=pISjtBcRqWE7eAV3vjSzi9xjHDDEF5XGn2rw1uvE2+OCfmB7z5it+HvopXOtMscQcT
         xKduBvqrJk7SIT0wbCe3AWaLPvTwCCxPv/vuKKRO0krsGEQmSOXuOcbe+G7GXhZxCyfs
         A0gTVqfbj44mtNAZKiOs41693ZIJcwcwfCmeuhQtc26OGTSn/g0aqKO5JcJrkZRCYmcF
         VA6h4irX1wkFqLUIKcDI5HdgEMxUpAJ45bm9H+d6spA0Z/PhKNS08NOBYV5+I9smcP2F
         rnfMHZ2G21VnkASBrbmhmcSZ2p3f+MeGbuWrducyCABB6RcHWVu3jdiXe8F9Jdq4pzla
         VLHQ==
X-Gm-Message-State: AOJu0YxfPDIw3iOpoXCXFSkEwl7PJ2SiY5ZLo9YeLUnZzxZ+3mESRApU
	snFZUM53iZlu73INBxrL9YeO/9uMVXckgrJI7zxpL+dxKvcTf+kAx8icBFRkvart5rF1h9+OBo8
	1ICVw/uM=
X-Gm-Gg: ATEYQzwMFgoV7qA6tFeYWOcxIjOfx99innjBxyP5MBy/nYMaVGgm/D+OJoSeuO9gtpe
	QeSpED/FEs+5xwcnE3GkOUZfxd7EGAjEhVOmNoPWvTycbd24on0XwN42JwCWCdD8pAkJpSnDQLR
	Y8Jt6UAZxJWSwPo1BF1AczTeYaagl40wTaQtKGSRUkftY+9ATIoBAK2xxgSX7KNUwpfuAY//MN/
	TqOssZix622m7Ln8UqTFGeWlGbPrrqUIAqQoNCAVDTJQjEurhjlZz/MTYhHS1ZdJ1LKHUZDadMD
	fptyUdxAV2MtwptqsdKtbGfpy5Dw0JnGLhZvdDo7c3o9owEoQQFW3868wuPoG3vwtOmYNmxuHcR
	ij3ZPGDsM/Z4KsQElABMFoFSJz9uGRN2smiAGx7kY2pJQVHQ6Zo7qmUAE7CSMAIQthmRz1w7a2A
	AAFPZou0Vdl059B5H3bSahpgxESxHQz4W6IbhTPfqJIo5A3Rhd1F2YZDDILfHXW5k1CINLf1duo
	kknHtABl2XchR0=
X-Received: by 2002:a05:6820:1992:b0:67e:16b4:aa07 with SMTP id 006d021491bc7-67fabd02b7emr1830928eaf.61.1775050754417;
        Wed, 01 Apr 2026 06:39:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e23031720sm9598777eaf.2.2026.04.01.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:39:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-7.1 v3 0/6] follow up zcrx fixes
Message-Id: <177505075303.60447.2600863818242060387.b4-ty@b4>
Date: Wed, 01 Apr 2026 07:39:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-274117-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 66CD137B9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 22:07:37 +0100, Pavel Begunkov wrote:
> Follow up fixes for the recent update flagged by review.
> 
> v3: include the mmap_offset cast patch from Anas
> v2: reject REG_NODEV + ->rx_buf_size
> 
> Anas Iqbal (1):
>   io_uring: cast id to u64 before shifting in io_allocate_rbuf_ring()
> 
> [...]

Applied, thanks!

[1/6] io_uring/zcrx: reject REG_NODEV with large rx_buf_size
      commit: f13bf23a829f39f21ac6e0757efe11304fff0e6a
[2/6] io_uring: cast id to u64 before shifting in io_allocate_rbuf_ring()
      commit: 42cf59688914875d6eb06c9674a4b33984e6dd45
[3/6] io_uring/zcrx: don't use mark0 for allocating xarray
      commit: f168ed94b91a63165b99abb868eb3df01b5b5aef
[4/6] io_uring/zcrx: don't clear not allocated niovs
      commit: 600bf4721005b73763089328f17e5248dba2c034
[5/6] io_uring/zcrx: use dma_len for chunk size calculation
      commit: 5ad086c24beda5154ca21495cbc32903d6d64337
[6/6] io_uring/zcrx: use correct mmap off constants
      commit: a49d0b79efc770727ccc9f962afa22fdb99736de

Best regards,
-- 
Jens Axboe




