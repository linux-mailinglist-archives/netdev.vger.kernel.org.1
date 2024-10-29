Return-Path: <netdev+bounces-139948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651B9B4C60
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A461F23B38
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14F206E65;
	Tue, 29 Oct 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NxJUub2q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5313205132;
	Tue, 29 Oct 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213028; cv=none; b=MbcneCED9/rBM16gtMSVItHJDoUaKrOHxXIXFR2gi4m4uz1/HL7FrViWsDPucykFyawvsM+KjDIGrwZSsot3NkKK1wySYQpNQdQWaQpmq8tbrEl995UP7PwlT+tMrqrKjQS+yp8J9B6mPM2SJ+eNB+P9vJJfvrd5idlj47bp9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213028; c=relaxed/simple;
	bh=PT4StcArSR+HdFOKwaCI6YmKSem3m0HYggUgezPsAWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUjVGEUdVSY8E65IK1w2QNwxws5vlIvhsFMnpijB7Em9E0TCTZ2Mf3MoRYrOI2338Tyn2sT9R/kKFec8s3mZoXtLLJUh+ybPa6RDFPGoKHYwhEgo55i5tZmA/Y8bRm7CTyalDaENJ64EVl/cq76CR5wWv5zHtMxoXO1nx6iZr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NxJUub2q; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730213027; x=1761749027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PT4StcArSR+HdFOKwaCI6YmKSem3m0HYggUgezPsAWI=;
  b=NxJUub2qR9emMquptoeI0GxautjLsoaiPhtfU9zX8zpEbqYEEBNTfe+G
   w7Fl3dl3crOlVxU0PnsuB566QWIiut9oE2elNx7zQMT+8nNQhmIBVMXw+
   QCgeElCqYKNdOiOrolb+KF3ZNBz6CLmKfJPnuoksbm1xmIjSi39/b81Bd
   58DmHvl7mNfSlcSlGIzs0ZOvrLkb6V+208Hhp03Hr2KzwX6Xg+DIZioW7
   R6TQSPT4OYz3VcTAy+SFFP/A6PKj1cWQ1DaXJ3rt92vfaOc4SzYonAz3K
   UIuozmIpqhYCV0HyFfnlG3q8h9NY00VzXDNVFiUT1FBK6TDA+7oamGdWp
   Q==;
X-CSE-ConnectionGUID: ci9X5QyHT+6033rZJDEQiw==
X-CSE-MsgGUID: 1yp/CUUGSfOpXemhTp7C0w==
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="264731335"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 07:43:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 29 Oct 2024 07:42:59 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 29 Oct 2024 07:42:57 -0700
Date: Tue, 29 Oct 2024 14:42:57 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 5/9] ice: use structures to keep track of
 queue context size
Message-ID: <20241029144257.7bo7zqpyd525dqpb@DEN-DL-M70577>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-5-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-5-734776c88e40@intel.com>

> The ice Tx and Rx queue context are currently stored as arrays of bytes
> with defined size (ICE_RXQ_CTX_SZ and ICE_TXQ_CTX_SZ). The packed queue
> context is often passed to other functions as a simple u8 * pointer, which
> does not allow tracking the size. This makes the queue context API easy to
> misuse, as you can pass an arbitrary u8 array or pointer.
> 
> Introduce wrapper typedefs which use a __packed structure that has the
> proper fixed size for the Tx and Rx context buffers. This enables the
> compiler to track the size of the value and ensures that passing the wrong
> buffer size will be detected by the compiler.
> 
> The existing APIs do not benefit much from this change, however the
> wrapping structures will be used to simplify the arguments of new packing
> functions based on the recently introduced pack_fields API.
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

