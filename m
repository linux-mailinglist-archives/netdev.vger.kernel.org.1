Return-Path: <netdev+bounces-103216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22977907114
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23E8282C98
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED800143868;
	Thu, 13 Jun 2024 12:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92E13E3F9;
	Thu, 13 Jun 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281997; cv=none; b=PRL+LnUiAYqUq38MTSC6numaDMgovg8Xx47wg9cyN/fhSuuNABK70eD59EPIcUrP1lanOwSLV/HFcvFnSOsg7HZZMSsyzE6UMIq2nMBPngqiQacth+SeY93AGTuWB/EEYrCHs07UTVR38ixyHatB7C1uHRYISb/SjC26b5G2ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281997; c=relaxed/simple;
	bh=ULg8Fs3ylKzlzeu4L15VUpi6+aXnakKnXxBv8V2L7ac=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ilFwWLLEY6fDn9RKUsK+iXZF0m3vOf3SI6Nka+io3XKb0Dm7X/SHTwbnJIBF1SRuPpLNwdp5+QsmdRkq79jI1SkhcOmcnuhBtP2/mtcV+6Hzk1dU8582umaU6HBTD/pIKENDYpoEXU+pXr1IDLxRHXk0fMQjmu7OUXUEbYi64FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjdc-002CGp-PB; Thu, 13 Jun 2024 14:33:08 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjdc-000WTx-7V; Thu, 13 Jun 2024 14:33:08 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E9337240053;
	Thu, 13 Jun 2024 14:33:07 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 7E5D1240050;
	Thu, 13 Jun 2024 14:33:07 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 2CCC53852A;
	Thu, 13 Jun 2024 14:33:07 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:33:07 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/12] net: dsa: lantiq_gswip: Don't manually
 call gswip_port_enable()
Organization: TDT AG
In-Reply-To: <20240613115226.luvvmfwsdkp6bmx3@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-6-ms@dev.tdt.de>
 <20240613115226.luvvmfwsdkp6bmx3@skbuf>
Message-ID: <f76cb6f2ba50c43e950f9e690c3aa90a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718281988-F1CA462D-6B8E3CDD/0/0

On 2024-06-13 13:52, Vladimir Oltean wrote:
> On Tue, Jun 11, 2024 at 03:54:27PM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> We don't need to manually call gswip_port_enable() from within
>> gswip_setup() for the CPU port. DSA does this automatically for us.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> Needs your sign off.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

