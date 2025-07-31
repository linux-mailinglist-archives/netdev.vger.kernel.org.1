Return-Path: <netdev+bounces-211171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C0B16FD1
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277DE547628
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1822DFBE;
	Thu, 31 Jul 2025 10:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624513B284;
	Thu, 31 Jul 2025 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958988; cv=none; b=pkG3lRCCYNKqcdV2ZebHgNHoUBccFhFFZrtnXnIxPyXVGb5N6QOUPLAGG6+fOEgIAhXRuWjaWnnooBlG4Sox79MCrQlgst5HMl22MblnbJrOj7Gin0RPHkb7EfOf/vqr0H2SyGajqhjdW3xepB++RNaDZEDr3Z0lxPzOmeIzxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958988; c=relaxed/simple;
	bh=XsWeIZ4nlc46t0dOdEaLqA6y04g6JbRMu9f1BFsIRRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPLHLWMxEZ8YqdqCPbAGsDBx5Yz0KLBXzvUxUqkVsf5rXd3CmtAffgx6NWwGNqvUyjvXFvOaPGTPHzGutvRkuTgXlZuU9VMSq88pol+Tcke/S9rOhZwSmzyPlWw0bRC/j5VRmtjoFqWSjaLKs/lq/8CPbJMv1+aNE96pyHGiQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bt5Pd6KhCz23jf2;
	Thu, 31 Jul 2025 18:47:17 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 10CB91400D6;
	Thu, 31 Jul 2025 18:49:41 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Jul 2025 18:49:39 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fuguiming@h-partners.com>, <gongfan1@huawei.com>, <guoxin09@huawei.com>,
	<gur.stavi@huawei.com>, <helgaas@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<vadim.fedorenko@linux.dev>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Date: Thu, 31 Jul 2025 18:49:34 +0800
Message-ID: <20250731104934.26300-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250725152709.GE1367887@horms.kernel.org>
References: <20250725152709.GE1367887@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> >
> > So the swapped data by HW is neither BE or LE. In this case, we should use
> > swab32 to obtain the correct LE data because our driver currently supports LE.
> > This is for compensating for bad HW decisions.
>
> Let us assume that the host is reading data provided by HW.
>
> If the swab32 approach works on a little endian host
> to allow the host to access 32-bit values in host byte order.
> Then this is because it outputs a 32-bit little endian values.
>
> But, given the same input, it will not work on a big endian host.
> This is because the same little endian output will be produced,
> while the host byte order is big endian.
>
> I think you need something based on be32_to_cpu()/cpu_to_be32().
> This will effectively be swab32 on little endian hosts (no change!).
> And a no-op on big endian hosts (addressing my point above).
>
> More specifically, I think you should use be32_to_cpu_array() and
> cpu_to_be32_array() instead of swab32_array().

Thanks. We'll take your suggestion.

