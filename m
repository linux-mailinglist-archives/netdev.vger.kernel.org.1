Return-Path: <netdev+bounces-194303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0677AC86D7
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D1B3B0593
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE1156678;
	Fri, 30 May 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kDisTgNK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3475674E
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574314; cv=none; b=cxU1gIgkgRzNnxhD9wjGw6MraQxKkrTNhcY3xGA9J86juLHs79CCXebwwCtks9Hxmt6h56vxbrP1fqitBcw5foK7cbM7IYtUfljwV9doc9Nuw7d3ri156IspWbhkBneMN/ekmC21+RFus8LupK2JDmhXlN3PAHSbymJTntWG50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574314; c=relaxed/simple;
	bh=Ed/1kpQgPuIflN+iFJmjwMyfqiJ72dOoP6UFlWY9yKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dKwOC4cukJXx71II2nMCVkBYsyG4tdVEBL3op7ZV0TuO2UYniOThtaJIxx+K9h/nDLatppUO42//797z1MGeb8Yur90C69l1vucDGJkTzPf5EvVYEOXhza05/pNXJ+07/BjFEa8iT3RPzPeQ4JwcZThIwo1sYyCJhZlC3Tcku10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kDisTgNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640D9C4CEE7;
	Fri, 30 May 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kDisTgNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1748574312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y6St3cgKQZciDsGGzmjn2Zn57IHrz+tLteQrqrRsTns=;
	b=kDisTgNK0+rP8BXYC9ljK4WpGU2py+pN0MDG8pmMrOuAkMi46vggUjhmmzJI24OCUYcs2I
	RMxp2TS4XpjKe0qSvmwcm2dQjRkPISXjPOXSDjbq5tWPDyZztqFDxcqzYpLEVzTRy5c/oE
	TcRf/e/2HRYG+i6wMEQwNqRdpAFSjmk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff6821bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 May 2025 03:05:11 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 0/1] wireguard updates for 6.16, part 2, late
Date: Fri, 30 May 2025 05:04:57 +0200
Message-ID: <20250530030458.2460439-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Jakub/Paolo,

This one patch missed the cut off of the series I sent last week for
net-next. It's a oneliner, almost trivial, and I suppose it could be a
"net" patch, but we're still in the merge window. I was hoping that if
you're planning on doing a net-next part 2 pull, you might include this.
If not, I'll send it later in 6.16 as a "net" patch.

Thanks,
Jason

Mirco Barone (1):
  wireguard: device: enable threaded NAPI

 drivers/net/wireguard/device.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.48.1


