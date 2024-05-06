Return-Path: <netdev+bounces-93715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E218BCEBD
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57BE1F240F8
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAC6EB4C;
	Mon,  6 May 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RsFnTBWH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920F74E37;
	Mon,  6 May 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001258; cv=none; b=TObiAS6pqQsoe7kkmUwHE1n75kaaUxPA3NSnoPqmZWuvFKDDVoV3aEoBT9PzeKFMzjHhKVBB5O2O8fhHaVeanD3e2s9oP6QvthAZEytoCRf2M4rBshzVpIgHEaTwtGBrMjKW9nqAQXpIVlib8oDxdwQlLczTVQ9ayHYEzbDH7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001258; c=relaxed/simple;
	bh=FUH9Pvl78wO2Tw+u2TgK3fr6LB1jY80UfiMnyRs+k04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYBwP72G0/4XhsvDsTrphLvDh9tRQ9f27glJ6t8IVWy7hHzVfWlwejiIPLhbyBP/0/oCEiwHaX5oQbZ1ld5n3PtXPMsUzSC25SJh9MykQ/kOLQbBDYH/ttyHDdPeu3S/xK38O5IPluMrC5f8UPUWkMluEzFf3/aRdYcskG6C1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RsFnTBWH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715001257; x=1746537257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FUH9Pvl78wO2Tw+u2TgK3fr6LB1jY80UfiMnyRs+k04=;
  b=RsFnTBWHkid+otHFvDsIMjkQ1ZRLQ57Yg+HvLsfKHebfmtLUMT0kX/rQ
   DyvI7cVjxkiuQA0/2fNsmN5A7UPoR07dQyyImSYhbpgl3htqskVr6z2nE
   0MXQEnHMEq8+UyDmzDGHKu2PYEQo+g0pVBqz3lwWtR9Bg/cMpqgfbbsfo
   hAJ69Htx1eLT26r0glaKNzHbw+kuoOlHVqZ1rcz0ovKw4zXTDZBANd7M4
   v52RLXMIlMHGjPR5ko2Yn5JC5JqMvva56Y5HdiD7wbi3d06I6x+FsLPQp
   4IwSrDYuhLTwjvstm7pDQKT3dlFwMnTcP8C5x6xzDvO7/s8pkZtY0ehmq
   A==;
X-CSE-ConnectionGUID: wZRAPLjsSoCP0bKRC4CIrw==
X-CSE-MsgGUID: 1zp83vztRY2yEyp6elXCAQ==
X-IronPort-AV: E=Sophos;i="6.07,258,1708412400"; 
   d="scan'208";a="254637492"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2024 06:14:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 06:13:58 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 6 May 2024 06:13:57 -0700
Date: Mon, 6 May 2024 15:13:57 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<soheil@google.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: tcp: Update the type of scaling_ratio
Message-ID: <20240506131357.lplgpwj2h4nkdxa6@DEN-DL-M31836.microchip.com>
References: <20240506120400.712629-1-horatiu.vultur@microchip.com>
 <CANn89i+SJiOLLy8azt8NqckUkTLqTS3Wu=16vfTrqCFYLKxTPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+SJiOLLy8azt8NqckUkTLqTS3Wu=16vfTrqCFYLKxTPw@mail.gmail.com>

The 05/06/2024 14:35, Eric Dumazet wrote:
> 
> On Mon, May 6, 2024 at 2:04 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:

Hi Eric,

> >
> > It was noticed the following issue that sometimes the scaling_ratio was
> > getting a value of 0, meaning that window space was having a value of 0,
> > so then the tcp connection was stopping.
> > The reason why the scaling_ratio was getting a value of 0 is because
> > when it was calculated, it was truncated from a u64 to a u8. So for
> > example if it scaling_ratio was supposed to be 256 it was getting a
> > value of 0.
> > The fix consists in chaning the type of scaling_ratio from u8 to u16.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> 
> This is a wrong patch. We need to fix the root cause instead.
> 
> By definition, skb->len / skb->truesize must be < 1
> 
> If not, a driver is lying to us and this is quite bad.
> 
> Please take a look at the following patch for a real fix.
> 
> 4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
> lying about skb->truesize

Thanks for explanation and for the suggestion.
I have tried this on a driver that is not yet upstream.
Sorry for the noise.

-- 
/Horatiu

