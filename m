Return-Path: <netdev+bounces-221470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A97B50941
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA61B21E5C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D327F4D5;
	Tue,  9 Sep 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O7c7gQdN"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D23D7DD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460721; cv=none; b=RhOBNfu0sY56kgnxt9b82ArtYwiKwLPibGgR4X9Px1M6s13gqDNDwEEMqFw5E6+r49ZHRTMiVbesS18h3lm97nN2eYdgWdbjimUjrwqnvIBn4SrhrJnm1BtCWoy2GzsqP5uJilXu4QkUNGhoRwc/su1hpEts9bc/gaAIsWC6yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460721; c=relaxed/simple;
	bh=gQ19h5eDMgwU+NMksfusYpv6ql3bFQJJJLXK1NwVHsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIbntHef4OZdJENFq0NoczvX4oFtBy8BfcaXhtnkvWUCtdXoMAYGRnpPA/qALXnttiwQMU3IWEvD0l8BBnEIGeWo8XbbAmR5zheQyN8r3H/AiOcccjOzg5soFeusCzxB0h9FYI/8foPL7Pw4Q6/pAuNLcDINsxq3V3PPLAzqHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O7c7gQdN; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7319fea0-8f3f-408d-abb9-f0217939d8c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757460715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTbGJ1tuE98dk/9HnOtWeyR4tHqkPUzRmsmmB3OyYag=;
	b=O7c7gQdNyxXMAK0Ti9dLtaUr5Xe/lmg0YcZ7llOVhJSDFXf9wNLv9HP/KVBLMi6v+PZuV9
	yG5Sdbjzt6F1YOBAOPi4bk/6Z3WLYQmHymm/tazLaHQ/b/Ic2rGJEY8vHA/jtxSU1GqGio
	1OkLk7TocKoVNS0TmHhbIHXoPT2PQyk=
Date: Wed, 10 Sep 2025 00:31:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/4] net: dsa: mv88e6xxx: remove
 mv88e6250_ptp_ops
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
 <E1uw0Xa-00000004IO0-0Etl@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uw0Xa-00000004IO0-0Etl@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 16:45, Russell King (Oracle) wrote:
> mv88e6250_ptp_ops and mv88e6352_ptp_ops are identical since commit
> 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter period from
> hardware"). Remove the unnecessary duplication.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

