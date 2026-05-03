Return-Path: <netdev+bounces-283519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOIgF9+t9mlDXgIAu9opvQ
	(envelope-from <netdev+bounces-283519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:07:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C84B4121
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17F3E3002521
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441E23A562;
	Sun,  3 May 2026 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="f1VSA8dB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE23221277
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774041; cv=none; b=RByIRoDr1NRsd5FbzKaFwqslR/ac9DX4nzZ/T4QyAFnh4rZcYyvYKv2Wecn8efAjMrankS4yW6squ1nFnWUDBaS4LXkEZB3kq2dOe2GqSyw6/99TydOwdgN1nhrV4cL0bCAPFp3S5PpvQhm4niy08TNOS5bDxq/LYjKgdKGHFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774041; c=relaxed/simple;
	bh=2Kcr2lEJRIS+Yq6aDi8qN9XogTTh/ToNZ+21H2cfJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmDqm5RY2slqy+Wzp76zUs8ERKtpZC9+1G6R0GVRFD36lhoxTEhi/wZnaX00mGCVnD/QceX+8Qcq1nz6KgeoUm2bdBAOYmjKsoeFpG/vh8nJTldhD/Q9TQrNcXbfkTPtiCyEPYqHh3ZobDKzkOU7Oah5OCe6H3OKkfCFi633aB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=f1VSA8dB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8f83efb5729so341280585a.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777774039; x=1778378839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2F3DN6wiiB7iU2Xt5hwtqlQ5YfweZqx1JbBrqimlAs8=;
        b=f1VSA8dBwfFLwd/ytqc4l7vH+LqReYyAbTzJ1V2uQJj1H2372Zs1uj8leoGjOU3JV7
         +tvSdh0VmDnjGmYvmqYt6Tsv/neN3j4vWkuwcWooMG/dJW4qYE9ToH6R1MUIYRzgJu5y
         FEHbwM9A2CbcPDTLuVPA1l1r9si4z7kHrr+lVGZGGCbFYo3j4QPL2bc4YJNtWqjlVj5m
         O5EtKayL6IOmnNNGmMEm5v0ehOb4rz01yJThPnVsQ9supN3X5s/JIk93uX8IGEF9BTD/
         NAhxY+hY8Q4cp/31nTPYQYIJHdfbzytiuoO18w0Tc1eUz04Z6CexblhuXv1ZK17/IY4i
         cHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777774039; x=1778378839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2F3DN6wiiB7iU2Xt5hwtqlQ5YfweZqx1JbBrqimlAs8=;
        b=l3IKu+7v45WcO4h++7eSywRlXiJW8042qlP8DAzuk9Wbz2NRrymqZJ21i3EMETaaMm
         tscsHBluIS6sqP9HTWRzCerl+LblnyYNW/2szANzlapW64RJMWwCzXLieu1nD15yHc/9
         xXMifACM+uzHCoWl854RAwNxD/+LuitiSFaAC2HXbrOwCPC9YWl4FtP8lHY6x1lzhaHt
         zNQ3W33MfLwXIMhGnQJUPybznIhpN9aTkbAg6F0hMbMSa1XrWZ4+FwR+n4SXxKajS/uN
         RLOtf1hzSgagkrGzG9JvVaVHrQoMoTinfg8WLtQ/9hgDW9YaxNIklvUfY6NL9wisGxiF
         ftGg==
X-Forwarded-Encrypted: i=1; AFNElJ9hGH+VdLrsr7tBVxmqsCInKEnIP7lzMLUn/R94nlh9kJrTnLQX/8yfkWlkNQTO5kxFi4R26Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDhg3mwdLgRG1hFJm17ELsP/Kkk+qUxYFUh28r5Vdi0GFkSi4
	+ih5IAMC/yKtVAaf5zkOfX0BENPGsl3+NIsdoBSmIsk71eHNlf30G+FSBCmalBHK128=
X-Gm-Gg: AeBDiesePBlOukrFCbhJKgiITlFvRE/pu86JHNe/SNPTSJXHyayBphA2pEaVH/HcVnq
	O6G62O9JGRlTFH9TcYA2kU7QCuF7Q76Woirx2yBNm/dCm3MJTxYEakbkztWnVRqLn+/gKn0x7HO
	4TPh/ePYhT+9D33nutA0FRytCj+a+uxNvhEOjWOKAJ6Lh5yHYVn4hbs4hoyIoW1211F0FlXLle0
	okyW+wts06CWk7NbLvWpqHFC3Bt3CDoUIm9VIrkvd1SlIIVS3hU9kO7xioW/bxvBgkMxhaC5Sq3
	gvVWVq028/zZZK47Ivxrf7BkfMcPxMFKTW/EmjLrFCSycbvRAGUcWQHUqbAegwoRaGrbYWqWJof
	JGuTZU93ccriqH4gtAXHshcJfBaeAw5wZFHoz5+fk+MrtQ/gfsg1TvgBalNueaSXqG5uy/QNf6Q
	7pEqkAo2jeoSXoyWpJRmInmMEe4rNK16s+5xLJNaEZV0Bp06GcNzFJUsj3Wn8nmLOBB5roxU4Un
	37+eNNAmvgV
X-Received: by 2002:a05:620a:6914:b0:8ee:cbf0:8311 with SMTP id af79cd13be357-8fd18337fcamr755624485a.54.1777774038660;
        Sat, 02 May 2026 19:07:18 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29889603sm636397485a.11.2026.05.02.19.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:07:18 -0700 (PDT)
Message-ID: <e39b710e-c742-4485-8798-7e27bf15e0ac@riscstar.com>
Date: Sat, 2 May 2026 21:07:14 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] net: enable TC956x support
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
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
 <20260502094712.69b29dc8@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502094712.69b29dc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 634C84B4121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,armlinux.org.uk,kernel.org,arndb.de,linuxfoundation.org,riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 5/2/26 11:47 AM, Jakub Kicinski wrote:
> On Fri,  1 May 2026 10:54:08 -0500 Alex Elder wrote:
>>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
>>   create mode 100644 drivers/gpio/gpio-tc956x.c
>>   create mode 100644 drivers/misc/tc956x_pci.c
>>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
>>   create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
>>   create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h
>>   create mode 100644 include/soc/toshiba/tc956x-dwmac.h
> 
> Please add an entry to MAITNAINERS for tx956x stuff?

OK, I'll do that for the next version of the series.  Thanks.

					-Alex

