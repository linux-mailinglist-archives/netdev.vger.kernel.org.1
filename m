Return-Path: <netdev+bounces-267441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJK8LakDtGnjfQAAu9opvQ
	(envelope-from <netdev+bounces-267441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:31:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE528300D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C060C3017507
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD32638F93E;
	Fri, 13 Mar 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dgd9n2j/"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE237187D;
	Fri, 13 Mar 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405092; cv=none; b=M5BqkDuYK/FzpsH1Cqh3noWX2YXe5CNwCEfAgPOx4pTM1+IEjETU0lEBvTfqpDyJ4hkD9N8gV9FJpU6LXwxui1zzKlVSZZrsb/gzwXzyKU9A64MOsIWlSuMV0qwTd9VXIwy8yiV8EcFD06hU+ZsxlA0ABR3ipHPM8C4EH5MoDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405092; c=relaxed/simple;
	bh=OWsAMDbjxhTXfUK9I0PcKbj+knOjySpUdB8xI1DB8Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbkfwraZ/zfzrbdu7JHPORLRAZWeK41srSRz29QYWRYfDHGay5DQeVBcEVU/RNHzoqmeGQ5DW28pLHyS6Wom6Je7DGU64Fpfa95GjgZE/LInmJRtTK6KY9clv/4GsF8mIzgXzmQXxVUKyfuQoRIFmfooZFPZ5Iy58tM1uXafdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dgd9n2j/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df0ff2c8-da40-4c9c-be39-d1a053585e60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773405088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LuLbMM2W+d0B1mK2Cs3qgA+PTOZ/KPeigPC0b/hAxWs=;
	b=dgd9n2j/C9HgyKQ8FXkoQ6l/tUkeVfY73ynx6TBbxj8E+W8NJY1+MEjgmku8kVomUuqXIC
	Fok1wXfBAIRvua5T4te4xKyU4Mig3cNH5IRS6r97D1zgL+heXuBQh6HXJ/9/uoS0ccwkF2
	nHVlUeiSnEFYN9vlSZOnMGA4zSsMTgQ=
Date: Fri, 13 Mar 2026 12:31:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20260312082009.249622-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260312082009.249622-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3BE528300D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 08:20, Sagi Maimon wrote:
> Add support for the Adva TimeCard model built on a Xilinx-based design.
> This patch enables detection and integration of the new hardware within
> the existing OCP timecard framework.
> The Xilinx variant relies on the shared driver infrastructure, requiring
> only small, targeted additions to accommodate its specific
> characteristics.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

