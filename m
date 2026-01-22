Return-Path: <netdev+bounces-252270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA4XBVQAcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:47:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715C6577D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E08A0B07
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956F3EDAA4;
	Thu, 22 Jan 2026 10:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E403E9592;
	Thu, 22 Jan 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078370; cv=none; b=CZUyukVO+Fiv0V17SSiZEgzbsPupapJgO/T/figMiKXKCVa90Fi9nIC4r1+FuONRGxcD1a2ZBmu+8mnq/dZNbVu1kEZAJ/egjPFZs9ntgcoj0G6tMOFfQ4opgy1Nfa+6AikhJnQYiTDQAFCkjGesZBXaBMQ8HmyVURupLS3yLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078370; c=relaxed/simple;
	bh=L9h+VVmrw/S7QwFfMyKNXRU5RtA1qftvKbCmgN1C+Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+0KhjvLT3Xh0Z4pm4GxcFrYMKtT+llwejrVc5tZwucQnda7w92pdmMjBQ4bPRs004YsByZGR3W51s9pEsFkKCbP+NFsjqMDRhy4bE0beztaWHgA5Yv8lIXxOiJ9ZFXRQxxi0mzXbHZj3I4zYs4vh+6DWZlnaI12YHG6frYpbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.20.167] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABnhdxK_nFpSZlDBg--.20370S2;
	Thu, 22 Jan 2026 18:39:07 +0800 (CST)
Message-ID: <5639ff0c-dfd1-4528-a0ce-92d3c457ce64@iscas.ac.cn>
Date: Thu, 22 Jan 2026 18:39:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: spacemit: Clarify stat timeout comments and
 messages
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Chukun Pan <amadeus@jmu.edu.cn>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
 <20260121200439.64c22125@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260121200439.64c22125@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowABnhdxK_nFpSZlDBg--.20370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryxGw48ZF47tF17KF4Durg_yoW8XF4fpa
	1IgwsxGF1xtrWkXrsrtw10qFyYvw1vqa43ury3KryDtF15XrZa9r1FkrZ0kFZrZ393u3yj
	qr42gFyv9FsrZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUgd-PDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252270-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 0715C6577D
X-Rspamd-Action: no action

On 1/22/26 12:04, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 10:17:18 +0800 Vivian Wang wrote:
>> This patch isn't a fix for the problem per se, since it is hardware
>> behavior. The new message and comments, however, should direct those
>> running into this on new hardware towards a fix.
> Is it not possible to improve the situation?

Maybe I should have made it clearer, but this comment and messages
improvement was proposed by Andrew in the linked thread [1].

As an aside, saying that made me realize this patch should be:

Suggested-by: Andrew Lunn <andrew@lunn.ch>

> Is the refclock disappearing because of power saving?
> Or because the link is down?

I'm not really well-versed in what's allowed from the PHY here, but at
least the Motorcomm and Realtek PHYs seem to only stop this clock while
the link is down. So from what I can tell it's PHY stopping the clock
because of power saving for when the link is down. I'm not sure how that
should translate into an answer to your question here...

> Because if it's the latter we should be able to skip reading the stats
> when link is down (still racy but better than waiting in cases we can
> detect?)

If checking the link is definitely up as a condition for updating stats
would be acceptable, then maybe the original patch from the linked
thread [2] can also be adopted?

Vivian "dramforever" Wang

[1]: https://lore.kernel.org/r/48757af2-bbea-4185-8cc9-2ef51dbc8373@lunn.ch/
[2]: https://lore.kernel.org/r/20260118100000.224793-1-amadeus@jmu.edu.cn/


