Return-Path: <netdev+bounces-270790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMjCCAzAwWlSWAQAu9opvQ
	(envelope-from <netdev+bounces-270790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:34:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D72FE4BC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2847302DF4F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F57381B0B;
	Mon, 23 Mar 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YQrp8FCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF329B216
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305258; cv=none; b=lhGkwN7ijnseezYVLT/Qq1uxFeZOVBT8RYAVb89XkxlBuKEK1NC4XW3goq22fT2SJfD6GB21/Hq1oaOyvowBt+LExv3DLvxZvJ9dEekReaUzRZQItMKTWjAozwIQSle8cshSC1hqdHfC68QYvICo2pZkcKzoIo7rPtBRx0dGkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305258; c=relaxed/simple;
	bh=BXFmjvsjMQTvfaMWOZQXkrVfbrVYPtM0fGsvLEU7BhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gIueICb4QzBMZp9zU5cTzeAUGxn0DAzvxSokI3UvBy/hMJ0j4MZJHCCnvt2Zqd9S+dD6JOHKqnNIB4wwp3RK+eT2YX0wuOsNGas9in22WKRKcqw1CpAuEhnr1yb37en0ftKrZWKT4DDC3FZLmUZeS5eeYvyBag03u0iJH7HugO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YQrp8FCH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7eb85fb81so732996a34.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774305255; x=1774910055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCxQIcYStCZz33HtObf8vi/uZK0sty0tF5QsKOfJztI=;
        b=YQrp8FCHh2iyAvabbwNEEWozisfQkJBW7O0xtNNC5RLkfsUGpZaLZnVHzEhj75PVEY
         2omE2FLb21KYojiwubFUou94u06JWZFAy904EwYZERt66LQ2cpPIfCUDKNNvHbqeoSEV
         nVqEemxHiH2OWRUAdet32V2E7Q27BvN7bEJZ2gl/e3LVZo/TYNm6A/2JBV5p0p5Xucml
         Ec1VHYm8lzJY/5H1ZNJVA4a015UevFeIZvnci5ujDtMIijDW7pdVi1rT0kB9JKvNp8+i
         e9nQnSsyJ9WlEH+BfUAyqRlEfjos0K8Mj6zB9aAGdpnh6Hu7J2jfzcS25hmIul0WV4yC
         3R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774305255; x=1774910055;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCxQIcYStCZz33HtObf8vi/uZK0sty0tF5QsKOfJztI=;
        b=TIpSYBn0yW3b0S1PmcejhxN4CNj56JWvUQwOiWJsEi/si82U624S9ZQMBsbnlv2xFG
         JjDBjno4adzSizNaltzn1teZ/o882x9Q4vEWaK4DaPdg1yAPNtLv1LEo1aetd28BC7Xb
         V91W8Sr3iHeALzgyrmS0yRwP48FI8hEHItzXlPV4t9CMoVPugz4pwd6BS6bM/00zZTAc
         jDrhGdnMypDCa2JPj/SbEes0ge47gxiAvKJTQEF/5O0ErIRj4t5A3Z5rSJ+jFotK3iF8
         dAupTjYO47UWqW/QIdb4Kh5OJgT7tP6eF/6UZvsWdvW+RwGR3ZBi/6BRK/23wwn5y2Yn
         Mohw==
X-Gm-Message-State: AOJu0Yzz6IitG3sw3KYtmmhhzzwzYThA3I6rNHwaNYaPVBZc7jP+bG31
	/B9uYoN6mM/tUDEU1M4+XgOcsnKG57q69vYZgFh3gXTa5kNPMd/TKMd/C4eD31a9K9I=
X-Gm-Gg: ATEYQzyBz2FclaEr5zm2UI5ugpVR7TU/BFDht2LbgGg34FCUJX9DIN6adJJmAFy/6L5
	DjYMp0zH13qjxKxQFNXDIBO1TfhNpu+pFHfYDeaW5Qgp/dRfex4v9W4t5LE6MpKVqTTmTsHjzrX
	JZwisfoM4jFZrHFz26WmJKMZ82ouAN2w1qQYJgf6xanYWKyJIeu8KOmNahR/SlvtUUoGVlUreox
	tpSPaKSj1Lu6K3UU71OmH7B4lBZBN0Fa/tObTaN0zBzBlLvKffnaE2mHZrerYfiKp6lpYGKEFLN
	q6WTczo0ulaC9awLmigIjkKGYBa+AJNympquSrzhKcQ2ZP1D5pot73QbpNW2zl+aLFFFYLQYwlZ
	H6Vu8xEP/QYIh3fJXucljuhlIbSX6VKYMK6f91NXGRSdkP+468XlF48Lwv9yeqEJbyfLniWAXJ7
	8ST6+O0QHlxfms+vvh53Vg2ueb6tvJEbeQ9f9NFaCbGD9xel5EYLWnM7SEbutpcOIVaeG5c2uop
	/Av
X-Received: by 2002:a05:6808:11d0:b0:466:efb5:9434 with SMTP id 5614622812f47-467e5ed6d76mr7944787b6e.31.1774305255312;
        Mon, 23 Mar 2026 15:34:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14dd0a6bsm11014124fac.13.2026.03.23.15.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:34:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-7.1 00/16] zcrx update for-7.1
Message-Id: <177430525401.475832.17980460579260076952.b4-ty@b4>
Date: Mon, 23 Mar 2026 16:34:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-270790-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8E8D72FE4BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 23 Mar 2026 12:43:49 +0000, Pavel Begunkov wrote:
> The series mostly consists of cleanups and preparation patches. Patch 1
> tries to close the if queue earlier at the start of io_ring_exit_work()
> as there are reports io_uring quisce taking too long leading to fails
> on attempts to reuse a queue. Patch 5 introduces a device-less mode,
> where there is only copy fallback and no dma/devices/page_pool/etc.
> Patches 11-12 start moving the memory provider API in the direction
> of passing netmem arrays instead of working with pp directly, which
> was suggested before.
> 
> [...]

Applied, thanks!

[01/16] io_uring/zcrx: return back two step unregistration
        commit: fda90d43f4fac7c0ee56a71c5a9a563bd57dcd96
[02/16] io_uring/zcrx: fully clean area on error in io_import_umem()
        commit: 234fe7bc53d8b2b37bf26a1392020e5b7b58c7d1
[03/16] io_uring/zcrx: always dma map in advance
        commit: 8c0cab0b7bf768594e8efc73f7b8f3d5abeb74f1
[04/16] io_uring/zcrx: extract netdev+area init into a helper
        commit: 80a4144de4e1cc8faeea700fb5a6e6ccc8aa02be
[05/16] io_uring/zcrx: implement device-less mode for zcrx
        commit: c11728021d5cdf8d99a5b127ec21d957d93e2d6c
[06/16] io_uring/zcrx: use better name for RQ region
        commit: 3bb8e0665fd7497e325ef799f945eb9e70186476
[07/16] io_uring/zcrx: add a struct for refill queue
        commit: 161399f0a7414e6b1f09cc76bc1067816bb04ad4
[08/16] io_uring/zcrx: use guards for locking
        commit: a5da6e340ccf62d2672ea90a400a4a66bd13205a
[09/16] io_uring/zcrx: move count check into zcrx_get_free_niov
        commit: ac02a64c479af1ab85b5c31b82345c1c9b6016d1
[10/16] io_uring/zcrx: warn on alloc with non-empty pp cache
        commit: 072237bd1a919545a1c174cd6171a5ee8e709096
[11/16] io_uring/zcrx: netmem array as refiling format
        commit: f3e6e4b057a8e1d4913d92f564c80c3bdd5dab55
[12/16] io_uring/zcrx: consolidate dma syncing
        commit: 2bd8e5066fde4ca5f9f382676ffa830c0e2803fd
[13/16] io_uring/zcrx: warn on a repeated area append
        commit: d2df9b6808abcc46cec4122457693001436e06e7
[14/16] io_uring/zcrx: cache fallback availability in zcrx ctx
        commit: edec451ccfce61291588163f2f8f7e9ed46bb119
[15/16] io_uring/zcrx: check ctrl op payload struct sizes
        commit: 49105528107676a49e5d5a50fa865781986a7c61
[16/16] io_uring/zcrx: rename zcrx [un]register functions
        commit: 623a6d44981f78d7f3391a59d62ae8b55f694850

Best regards,
-- 
Jens Axboe




