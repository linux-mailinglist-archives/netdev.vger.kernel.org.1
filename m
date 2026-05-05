Return-Path: <netdev+bounces-284518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEhZLWYf+mnoJwMAu9opvQ
	(envelope-from <netdev+bounces-284518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 636554D19FB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADA02300A7F4
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3F49252E;
	Tue,  5 May 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="X5mmn7Lm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2234A3C5
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999579; cv=none; b=X6p2B+jpYCc+NGIWP13Zy8tn/1iwcZ416Jr/LvvlhThAmqB2230bPWwSkPWw1aXw2iEOID1o8Rs8sr31AtZtRKaSNHm4OpzleR+Kbzp+3LQBJ0l9nAd340mI/vNjefoJbw5Upoug2FQO/7c7qZ7gIlcUwCix4aGDFo5u3pd2yAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999579; c=relaxed/simple;
	bh=F6r4/NkT84O6LMINfn4uqKzOCDnyvsWTs845KZsew+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcwrhwO9em47C9crq4h3X4C0UeS5tkJLzu5GepvxeGZlNYyCHI24YrZ9bJJxurZy9EXXgSY3BZu2zcoQfriVLyqjMlvyqK63MhuCEAZCqQi3k7D/R55UtoJYhSv36ExYcMj0nitaHmKUukCvaVIhcns/NeSDQsTW5GiWPAk6UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=X5mmn7Lm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7da9so51276117b3.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777999577; x=1778604377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6Uy1BACyCfz4bGQoQ3uC1bOjVbvH4IGR3oICdNZrGU=;
        b=X5mmn7LmuxQszfavQ+POveGevluU7P0Vd3HRmMQcQSipewpw/vF+RA/dqjferAD4oB
         pteatj+2RLDvR3nOAruGfWssKVbw8LhlK8Z00SnTStpuDSSoQxU4i13/fNRFdn2f23dI
         PeAd6KPtFnRtF3Q3Nd714cFZJ1rua5bOxeV+9nx8ZIDAyrL1q9sw6Rfh1HVgqAI50azo
         KvEHZ48/BWDlB87goXTwqgZ3xaHoN/iaItBoQpMPWdkdRFTxunnYIaRqCpUVFtolYPCb
         S3Xojh3w9bdKZXuAyL+66Nl4S7NepkaG60gqc9sPAXCquh3og2tqg5wH95UpXLCuQ5DT
         CiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999577; x=1778604377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6Uy1BACyCfz4bGQoQ3uC1bOjVbvH4IGR3oICdNZrGU=;
        b=F57Q7Oqc9A/En1kcJ3EHAapyXxM942wYV05dgRpK38rHyoyyT209QfbjTfNMlpmjO8
         AeoGzJn0eVwZUqDD4RfuXlfHfSQpKWHHIax+rp3cTOj105ZhE8sSVGGjmUpRJU4sswtC
         rP/U/c9yKqUO87adTE+AIOBg6JAwPWYhpOvvUWtzCOCa2rm8O3cUgiKTDiqmjvUIFHup
         M89IcXYZDSMm0oJ4fLN2FPDk/UelEI3M1e9lTQM4Ao1nq28Z3dUC/U6DFTYimr0lLA67
         AWXYWaRtub9tReOw6fJrbXN+cxzylnj6P7tPRSxwOr6q5krHzswSLXZFfT5Dma/PXiYQ
         RSsA==
X-Forwarded-Encrypted: i=1; AFNElJ82fAwnP5Vm43M8Ii/QnH7Q4IqoGINn13o5z5Rjllr065ugA6p4LnPycL3SmfnYZjcQn5ylcbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqAx8QMeTsJbLp4sxZnHU86AOSOs/OMOpNDXUIKTgKAe7D1o8
	2rC/NwPACYjQgck/vXFsG2D+A1XbDMCTFAEJWVtsAT60ZJ1evijFgSSFeEW+e2dXTzk=
X-Gm-Gg: AeBDiesth81FUCwC9eBgu7oi6fasSpi9kqd9Lc7Puft+8hgwXr96aJu8hX6KEwJTRC2
	qiehtr3ZDkMl7ztNlOEFPNnP20vRRaMLf/BoyoQNJOFkgrT9qgsD8Rdasfmwg2nsgEkBLD7XCOq
	tTv4BB5YofCjn8AEocsxdn0plqieMsd8e2tc1pX1K/c4IZPE4kKTOwmJlhy2Cpxrlqcxf0v5Wuk
	PU3bQNN9mwwZOmSWhfSST0qQfPBYjv5Fy7rML5m+pHHXQlU+3vuKDl05umkBtFUynvUTgyIaMn8
	QSbtfNvXa5qochMnLZVpU3cN74L9cVeFRjK5WqDOrpw43ZD04L1uKQEdAjEhLynYJpUTFhFQcSO
	1nGHY+VhJRQ6ih0qLGIlXx5LH5q/BEV+q83PPXNegjZ92OeyX9T+DnfSRzCAFfYyWaQt+PQ0xq8
	J9O+DYPD4PaVbCVvXhPUkYew/lv0OxTK3Ai7YMcfEoBtykkujCc+bQYMTFF9a7PBIP0YW2kDUl7
	g==
X-Received: by 2002:a05:690c:e094:b0:79b:e346:fcfb with SMTP id 00721157ae682-7bd770df5b9mr144294337b3.32.1777999577197;
        Tue, 05 May 2026 09:46:17 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6656542bsm66872617b3.20.2026.05.05.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:46:16 -0700 (PDT)
Message-ID: <e582f6ef-aa4d-4d7b-9d4d-7ea0445d42fd@riscstar.com>
Date: Tue, 5 May 2026 11:46:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <afodG9uuopgfvSmu@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <afodG9uuopgfvSmu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 636554D19FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,riscstar.com:mid,riscstar-com.20251104.gappssmtp.com:dkim]

On 5/5/26 11:38 AM, Mohd Ayaan Anwar wrote:
> Hi Alex,
> On Fri, May 01, 2026 at 10:54:18AM -0500, Alex Elder wrote:
> 
>> +	/*
>> +	 * TX956x has 8 TX queues but only #0 to #3 work for general IP traffic.
> 
> Minor typo in the comment: I think you meant TC956X instead of TX956X?

Yes, I'll fix that.

>> +	for (i = 0; i < td->plat->rx_queues_to_use; i++) {
>> +		res->rx_irq[i] = irq_create_mapping(irq_domain, HWIRQ_RX0 + i);
>> +		if (!res->tx_irq[i])
> 
> Typo: res->rx_irq instead of res->tx_irq.

Wow, that's important...  Fortunately we haven't been getting errors.

This will be fixed.

> PS: I was able to successfully test this series out on a Rb3Gen2 board.

Great!  Thank you.

					-Alex

> 	Ayaan


