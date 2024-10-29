Return-Path: <netdev+bounces-139944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFB9B4C37
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B61C22BBF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1701206071;
	Tue, 29 Oct 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="imBdGrxh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA41361;
	Tue, 29 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212633; cv=none; b=qMPqEFgxWTljBCFOnmdFQ5nCtRAHzJrGqqnYueZRuUxGCbzDtVC0PJrVlSW2GSIY81s+xaTSIpnVXLzzogfWVRDDvRK5UPCJHAunV7OWnBBojuRvMAhlctFJV02gEHFpqkpylGlVsYROtOdtHMsX+8M3oMbooSF0d+Dwsl0fxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212633; c=relaxed/simple;
	bh=jhIeagrsfmCzyreNXSZ+IBZYXKz78nr3SRrw/kS9vUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY3AKRxXDjZ6cbrixOuUCRn1rhzLgdUxVpUydpnpUzfis6/EXQb44qJlgoTyPMABmaD1qP+y7rF5wt8OJX9q1rUDc5+7jnHbrcf8dWYdJjdKHppbPywF/MiUDHjw178ZuB1JRFSYQENCc3X08aZoV0m3UnAGMe0bZrhAHh2tXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=imBdGrxh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730212631; x=1761748631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhIeagrsfmCzyreNXSZ+IBZYXKz78nr3SRrw/kS9vUY=;
  b=imBdGrxhxMDLlqzEUIWlbESC3Gm+Um2mceDlrS/v8MhdqUhi04IyRo7P
   mIzoiwUdlZZfkWkl09uu9BKFUpZR7zqxvr4kEa5KlGgbNnYoPVJgaurFp
   Dd125esLBUZsQpO+EXR8pvtC/E2WpOcgOG2UUPhy8IT8jde83YyiUg+W2
   0KkHrbWtqReEa+8DF10ZuSgsitXfZJw/RzpdEqe/5kE2ls/Q8euFHNSqg
   YehGLkAJvYOy2XSJVKuHIcaO4TT6D7zxhR+X9v5hZSkWAjanOsmMir3ty
   xvfFIguB6UPsu0g/mlgNpqQBCQdzdEo8TVqv0AfD22+FVWjAL0iTuSJQU
   g==;
X-CSE-ConnectionGUID: m0FcBtX7TyywOC2brL55WA==
X-CSE-MsgGUID: 8x5Jh5cDRySu1FF7jeIiAg==
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="201048816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 07:37:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 29 Oct 2024 07:36:50 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 29 Oct 2024 07:36:47 -0700
Date: Tue, 29 Oct 2024 14:36:47 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/9] ice: remove int_q_state from ice_tlan_ctx
Message-ID: <20241029143647.zmrjcfeblpwzvqrm@DEN-DL-M70577>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-4-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-4-734776c88e40@intel.com>

> The int_q_state field of the ice_tlan_ctx structure represents the internal
> queue state. However, we never actually need to assign this or read this
> during normal operation. In fact, trying to unpack it would not be possible
> as it is larger than a u64. Remove this field from the ice_tlan_ctx
> structure, and remove its packing field from the ice_tlan_ctx_info array.
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

