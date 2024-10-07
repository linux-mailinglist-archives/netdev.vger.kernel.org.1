Return-Path: <netdev+bounces-132896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5755993AA1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61E01C22DB1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219D17D896;
	Mon,  7 Oct 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQMSxbn4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0513D8B1;
	Mon,  7 Oct 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342185; cv=none; b=Sd2iEqUKyqvTprjKBARAolX7jAODbydvKqAH20F+B4Xb5Z+ddtw2AUGM0oUjUPQRjLsTMvtNYpTfQGtEF7K6irzKPOzKXcxbffqbFFXKA5g3PGQ0z3Sd1QOBN1gRX0PZ9e94Hn0j+VTGNHkeYFbqXAse36p/TmAmSb6Gpie7tBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342185; c=relaxed/simple;
	bh=Duo4y6dwJDlWYCUCaXKo3IgzU776UNw0umD4Fhn68fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btVMR9Dj8ObgcrfWIUTvxwS2Gzbco4YxSftoCbCRlxzk05cEMPAEbKtBjnBIv36JvP3d84cfs5jKVMtYikIQRqpqORUr+BjbiQU7AdlOLhlwTv22931NmZxVJdVdZeNokcd4+ocblSqxxr24pLOSOUdDIlORokTnvzaJo6A0sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQMSxbn4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342183; x=1759878183;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Duo4y6dwJDlWYCUCaXKo3IgzU776UNw0umD4Fhn68fY=;
  b=eQMSxbn4+7S4qU86OunMwMWJ5QDvwmCMq/PT8x+jmATiDH1xuw5fDNck
   1FGP2ko5hoZR9meEsFzvCdj80w6io37a3s7rAZ85S4GYgquw2dl1zraQF
   6Sm++RgMQioOjPF18X/uMtXnPtWS6cM+LbMQ73OSBevzad+Gi8p8zMJy6
   HidHu6hMyjpMtPSV+Fm4O4kLDreT211PG51EyS1MrZJp3k1tSgf/S26ap
   Wr2UXjqDen5KhPfdHu0+C+Rc7g2Li/P+WU8DQtobmB1aD496XWBqYFvm9
   b3bgjpSBu+QezTIl+S+SUznsYMdDegsqrxnpfOIoqG3kJkFwMDGRNWNuZ
   A==;
X-CSE-ConnectionGUID: 9X8dwLDcQcypWlpIZrBh5w==
X-CSE-MsgGUID: OWhwGhDPTLOLXXhACH4jRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27454571"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27454571"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:03:03 -0700
X-CSE-ConnectionGUID: G9AYz1QISK6vASQrVyCYHA==
X-CSE-MsgGUID: YoOhUAmDRXmN0/OTIzzNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75185870"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:03:01 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, Jakub
 Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next 0/2] igc: Link IRQs and queues to NAPIs
In-Reply-To: <20241003233850.199495-1-jdamato@fastly.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
Date: Mon, 07 Oct 2024 16:03:00 -0700
Message-ID: <87h69ntt23.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> Greetings:
>
> This is an RFC to get feedback before submitting an actual series and
> because I have a question for igc maintainers, see below.
>
> This series addss support for netdev-genl to igc so that userland apps
> can query IRQ, queue, and NAPI instance relationships. This is useful
> because developers who have igc NICs (for example, in their Intel NUCs)
> who are working on epoll-based busy polling apps and using
> SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
> queues.
>
> See the commit messages of each patch for example output I got on my igc
> hardware.
>
> My question for maintainers:
>
> In patch 2, the linking should be avoided for XDP queues. Is there a way
> to test that somehow in the driver? I looked around a bit, but didn't
> notice anything. Sorry if I'm missing something obvious.
>

From a quick look, it seems that you could "unlink" the XDP queues in
igc_xdp_enable_pool() and (re-)link them in igc_xdp_disable_poll().

Or just the existence of the flag IGC_RING_FLAG_AF_XDP_ZC in the rings
associated with the queue is enough?

I still have to take a better look at your work to help more, sorry.

> Thanks,
> Joe
>
> Joe Damato (2):
>   igc: Link IRQs to NAPI instances
>   igc: Link queues to NAPI instances
>
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> -- 
> 2.25.1
>
>

Cheers,
-- 
Vinicius

