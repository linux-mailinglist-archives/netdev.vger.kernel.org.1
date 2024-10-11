Return-Path: <netdev+bounces-134618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24999A7AC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32331C25ED1
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A549195F22;
	Fri, 11 Oct 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ez2qijYt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B7194C8D;
	Fri, 11 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660536; cv=none; b=cbuS8Kkmg7MLQ5RDOKnNLImtTYf7W7L4vB9NsWUfxVnQ13/cIZ017v2DBc45qerFJXY7ZSbq/l0wDFq6YS7tC6f/u8IQWujbdOX69ZlXwa/P601Oh/zMC4VICoT55Afgg+1wRJFrGqz0gVRhWR4ZShx99JjLBUwDlvGZvCQ+w6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660536; c=relaxed/simple;
	bh=bx074e4HGLmDJv06LML79379zBigZVqcIwirOD1IXIg=;
	h=MIME-Version:Content-Type:Date:Message-ID:From:CC:To:Subject:
	 References:In-Reply-To; b=PZaV2bS1ACuOekqzV7sPV269zgFLRZwf0qDW0TEyS8o983Cjes1NYCfRj+0asCYpW0w7vPrdC8vTVdNMIRKdDN/9LVNvu76VjzzDoNtgWrzMue7QsMLj7IcqLbHLCc5+QJsJC0T9SAL5zor6aQHiLNmMhyRkFNEnKKFLzka2WRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ez2qijYt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728660533; x=1760196533;
  h=mime-version:content-transfer-encoding:date:message-id:
   from:cc:to:subject:references:in-reply-to;
  bh=bx074e4HGLmDJv06LML79379zBigZVqcIwirOD1IXIg=;
  b=ez2qijYtBWKP3YXnq/bDahO0+MHH248zE79D7I+LQZRO/8l5Z+dl47Wq
   44jjeH10WZxhb+iCOOvSno8kpTo00QxejjT2XO9ACzsVjoU4gS8ShFlpy
   JvxwzzeRsj6ab2cDBpE5eaL7mNp21VBQFtwvpWnfAEmuzX/Ycwutty9he
   N/ze04VpQxSV2lQmzpoPoytIa1eZwDZ2c6KDIbqF9wSfA885ZFzOBOOJc
   aeapfBxFARrnya5f+CQgHulY0P25E+PVvPpPcGowFNgZe6JXUcstdcvPP
   0vHcxBSbr6kSpf0aig3Y0xMgInEz7hX4Qtr9ZyIDHgeBMITd3QqS1AKg5
   w==;
X-CSE-ConnectionGUID: Y93VkM+wSkyKET2ip2ekUg==
X-CSE-MsgGUID: QMsnCg/IQOazEdV6BmBZTw==
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="32715362"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 08:28:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 08:28:27 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 11 Oct 2024 08:28:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Oct 2024 17:28:25 +0200
Message-ID: <D4T308XAHU63.3213WKORD0FCL@microchip.com>
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
CC: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20241010130231.3151896-1-ruanjinjie@huawei.com>
In-Reply-To: <20241010130231.3151896-1-ruanjinjie@huawei.com>

On Thu Oct 10, 2024 at 3:02 PM CEST, Jinjie Ruan wrote:
> Commit a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in
> kunit test") fixed the use-after-free error, but introduced below
> memory leaks by removing necessary vcap_free_rule(), add it to fix it.

Thank you for the fix. I reproduced the bug and confirmed the fix.

...

> Cc: stable@vger.kernel.org
> Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in k=
unit test")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@mi=
crochip.com>


