Return-Path: <netdev+bounces-164934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E8A2FBFA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76BC16530B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24BA1C2DB0;
	Mon, 10 Feb 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="P1MkszLE"
X-Original-To: netdev@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E67189B8C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222767; cv=none; b=Pk6jYCcycftAKJtWTwAeWyykx3ykNdnPRgUsJJw3sr9CGbqHlILbLXwOZ3C1d12ZetDe44FDRJFgGIEg7EaxaFPIf23ltt4nuiNenK8DZTM59CLXGalXjJt7MLKjVJ0sdBV+KqMwbyQ4+SLuCC2Meo/vWUcR6786HU2HIE4+xGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222767; c=relaxed/simple;
	bh=PHnXMs2aP1nRZ3kx4/ik8KOkWi00ecq8fsqcNsyvwCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qn7wchyGuF9JZ0jMdxhzN0YuQ55ybcr/8R9N7yXUfCs+gq+2SfmqfZ5hFRICj3JVHepxiiqgXv9ArvAcnTD/WQjKoLZIlZHgYrad2v1jT8m6qWoN0o9ywpZccTsPp+F6N4RCxX9T3kVBIVdsiknaIDA3NbrVhqp1tk/VX7REa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=P1MkszLE; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PHnXMs2aP1nRZ3kx4/ik8KOkWi00ecq8fsqcNsyvwCo=; b=P1MkszLEP/MF1UfFLY2anAljxH
	jmfuZ/KTuW9qljoZFj8cF/rwd4fmDVJ83YnTjLWO+7etM1qwWU9qWw1bVFphshkdu4CmMubI/9R+i
	Bzbs9YcBdrgtPT2ee4RFxspBAnMda/NQ5q76Cx1xsH4t7Am69PnjXhkZYVIpC1U1SeL8=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1thaAt-000000000NS-1KUN;
	Mon, 10 Feb 2025 21:14:35 +0100
Message-ID: <b1b3e5e1-b1fe-4816-85eb-61ac7ea2d46d@engleder-embedded.com>
Date: Mon, 10 Feb 2025 21:14:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] igb: Get rid of spurious interrupts
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joe Damato <jdamato@fastly.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-3-bde078cdb9df@linutronix.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250210-igb_irq-v1-3-bde078cdb9df@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 10.02.25 10:19, Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.

igc or igb?

