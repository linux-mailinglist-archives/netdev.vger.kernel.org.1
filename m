Return-Path: <netdev+bounces-137585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857689A7150
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A52833D9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878F1E6DD5;
	Mon, 21 Oct 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xcgebuae"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3365028C;
	Mon, 21 Oct 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532903; cv=none; b=Ttm2GlQ62CLM3k2Sdv9QOl/QA/UFjMzPJ8GkYf8NsOq2qXMFNQaamDI9pSFf2NJp9NQaAAWzxM8d8jRXisAevDNSzTcW25GDX4deQEFiUCFZtlxpZ3ft8ZwHBSq/0b9T+tjUg6zmV1ZuBG7d02BM40gqMI0ao9BxIriAudTPENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532903; c=relaxed/simple;
	bh=fySSFkngfY5fa46FAuxT2ZsveJWPtJxTCyFd6HqJqEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n06IqxDYCKgJyBqDCxS4fkIvLG1t3XPBypergokFp5iKh1kZo1XMryDZMacdLpm6ErjCijkOLTLNbK16uY6lqzk8fqkxXcUWGGFBtW6M6URzgTnwE4eNPb7yFxe8RXLX1eJ9qW3AT5/pBCGOgZPBDebiEDusPn7+vybdbb1B8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xcgebuae; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729532902; x=1761068902;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fySSFkngfY5fa46FAuxT2ZsveJWPtJxTCyFd6HqJqEo=;
  b=XcgebuaegV+YpmMGI/5QL38SWBCrhhk6vBgSSnQv7vl/Fk1x6WQWvpwN
   PyXqL8qrV7tdazXsGdq4eN9P7hp9A6PxuQMKnZbcBQ2bMO0DtuQZrzk2k
   RrPp6nxl9YrJ2RYdES55iIb6qW9Eu1dIwnV8fEvgZcVRtK6yQzqph+AjF
   6uqHy7ttGJIfeAxpQxLaTlkVoQXzP4Y7af6NQG2SSGg0hbXc4ybDoU5xc
   rL10K3c6mQcISX8a6ol/3llW21OMQR6tuWkVpMPImVIy0/p3UQ+WjoY4X
   ejZLw+9rLz+twcJ36Raj5/xSQjI21N2a3YxGNNTkXZ0vZx4aIBGp1x54T
   g==;
X-CSE-ConnectionGUID: IYRyfBkISSWGiWt8+WCoRw==
X-CSE-MsgGUID: arLk4uuaT5OnNMN0FJ/ZAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="16663292"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="16663292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:48:21 -0700
X-CSE-ConnectionGUID: ZtSOvIZcTwyhQrB+3z08CA==
X-CSE-MsgGUID: qhfYvI10QSmqJMIREiZfxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80001296"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.26])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:48:19 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kurt@linutronix.de, Joe Damato <jdamato@fastly.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v3 1/2] igc: Link IRQs to NAPI instances
In-Reply-To: <20241018171343.314835-2-jdamato@fastly.com>
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-2-jdamato@fastly.com>
Date: Mon, 21 Oct 2024 10:48:18 -0700
Message-ID: <878quhgxel.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> Link IRQs to NAPI instances via netdev-genl API so that users can query
> this information with netlink.
>
> Compare the output of /proc/interrupts (noting that IRQ 144 is the
> "other" IRQ which does not appear to have a NAPI instance):
>
> $ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
>  128
>  129
>  130
>  131
>  132
>
> The output from netlink shows the mapping of NAPI IDs to IRQs (again
> noting that 144 is absent as it is the "other" IRQ):
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json='{"ifindex": 2}'
>
> [{'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8196,
>   'ifindex': 2,
>   'irq': 132},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8195,
>   'ifindex': 2,
>   'irq': 131},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8194,
>   'ifindex': 2,
>   'irq': 130},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8193,
>   'ifindex': 2,
>   'irq': 129}]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

