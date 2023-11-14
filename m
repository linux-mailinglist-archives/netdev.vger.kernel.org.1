Return-Path: <netdev+bounces-47619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1977EAB59
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 09:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C1128109F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122D13ACD;
	Tue, 14 Nov 2023 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="WOpmg7za"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5B134B7
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:10:32 +0000 (UTC)
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3C1A6
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:10:31 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 670E7440871;
	Tue, 14 Nov 2023 10:09:27 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699949367;
	bh=4nljcGjgLvKiRJNDtiqRyuLQWvMc5MSzFe52pPPF7tQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=WOpmg7za90HvSejIURro8YlKBZySezLL42hsEDhsmrMTJXv/Nil6JhxA3V6NrMQ5l
	 NFAf4pOUXsXPOTGDJLsp1fpgFrafB+cKEzK0He7JvDyNGPvVxZ+L93dVq2lkL0Y34u
	 3EgM+ZdEt9ZlZAtFD5pWlXCdCKYozk4exhdIrIpwKlUr2sxBqN4emNWG/Fla7rp2IB
	 NtAxDJSthu+zuP52WmuQcjXbSi0YextL2bzRW1aPQR6TG0UutQ1KEHHXTibFqq57Zr
	 jEca23stEQ1GW2d+86ZAWvCmMmgbE4EQlUW5AG+pOVTwAmk8/Nc1m8oOBCKT0ujahJ
	 83B/TY0INobsQ==
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
 <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
 <20231113175222.674a3971@kernel.org>
User-agent: mu4e 1.10.7; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: avoid rx queue overrun
Date: Tue, 14 Nov 2023 10:08:29 +0200
In-reply-to: <20231113175222.674a3971@kernel.org>
Message-ID: <87h6lodabv.fsf@tarshish>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jakub,

On Mon, Nov 13 2023, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 19:42:50 +0200 Baruch Siach wrote:
>> dma_rx_size can be set as low as 64. Rx budget might be higher than
>> that. Make sure to not overrun allocated rx buffers when budget is
>> larger.
>> 
>> Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
>> 'cur_rx'.
>
> Can we get a Fixes tag for this one as well?

I believe it goes back to the commit that introduced the driver.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")

Should I resend with the Fixes tag?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

