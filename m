Return-Path: <netdev+bounces-234487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B3C21813
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4691A63BD9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3336A5F1;
	Thu, 30 Oct 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQLTOF59"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5633368F42
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845609; cv=none; b=BkaD5Ng28T9UCZJao5g6vzC4Fc2xNqOu2y+W9IQM9woQPiJxV4CAOEOx3vxnWZGcLSLpsboLp1w/7Yb5rPgSgjq+YuOF2mZy3yRThENGfwLuujdhzmdHyKXW+OFSLDc0618UfgiLDTDsuaiD3ibYlctuOlTul+FyqOcY3+EGRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845609; c=relaxed/simple;
	bh=xnGGxM/CF6TVarz5S8vaXF2pA0gekIJ2t0Xy6Gx5bnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQZvXVn35IqvjicFs5VJXyDtkEj2cag1f5Etx7WyKwO3WRpp5lTNwjtQa0cXrQqwGbQ9Drv9U0gcKxtyvovsvW6YkDxPHyVei0Lz41iBKGHX9y8gBCeHFVd6ulRGUx4Vd5/ihFacLO1MxutCG1tnLAJ/4M/AY/F4zYNl1MD04EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CQLTOF59; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 91DDBC0DABA;
	Thu, 30 Oct 2025 17:33:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DBC6B60331;
	Thu, 30 Oct 2025 17:33:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF6C118090C0;
	Thu, 30 Oct 2025 18:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761845604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xnGGxM/CF6TVarz5S8vaXF2pA0gekIJ2t0Xy6Gx5bnQ=;
	b=CQLTOF59nUhH5gl9BN5oQjxk4pYrHmXO7UsHk6ulEkZ2Vg+Z5hG78W15bgqasSJfbWIITv
	cRP1sQcNgc3L0EYTxrgap5B2rIP4baMScIY7aKGJvxvA6tgu+zGu7HZ6Fwt7HKwcuHARYY
	PbpRxjvc8N+W9kX4cMzXxGotMScBiHAi9o2g9ei1JsojEpSh5ERAizKsgxkYNn9l9eGJyF
	B61RWlKuctRETcQjof2CHDwSpro5Nnbj0Vz9ctw47QtMuppuoA7t7HIHoQXHXXHhvuRtNF
	t0Y1zKhNkTqYOK015tcDLY4sDBBnFoC5ZWFfVxg+fNiqdAHoxhNkf9QBJXxYeg==
Message-ID: <e4011f81-bc46-41d6-a259-f45d10c46302@bootlin.com>
Date: Thu, 30 Oct 2025 18:33:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 3/5] amd-xgbe: add ethtool phy selftest
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
 <20251030091336.3496880-2-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251030091336.3496880-2-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 30/10/2025 10:13, Raju Rangoju wrote:
> Adds support for ethtool PHY loopback selftest. It uses
> genphy_loopback function, which use BMCR loopback bit to
> enable or disable loopback.

This is not strictly correct, genphy_loopback() is only used for PHYs
that don't provide a custom .set_loopback() callback. For example, C45
PHYs don't use BMCR for loopback.

> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

With an updated commit message,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

