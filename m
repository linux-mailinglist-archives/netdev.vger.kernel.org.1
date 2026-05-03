Return-Path: <netdev+bounces-283518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ7RArSt9mlDXgIAu9opvQ
	(envelope-from <netdev+bounces-283518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AB4B4103
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5C3130022E2
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BB25B2F4;
	Sun,  3 May 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="btbRK1G5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616E23FC41
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773999; cv=none; b=O8tG1romadp2qb2yrmspbcPZjkUfwjT5azB68neAsEs6g7k2bBD7BkOjX+q+c2A0IRhjAhx76Yp2F5v45bjmm6bjyJouiPNVPNvAYN9r0HBR7Rv51jz2EgN1NpXGlEcDLFFOH5u6wf9ulqFZSTw5J6a9uEBXB4jOA+v/hvrIjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773999; c=relaxed/simple;
	bh=qSG0sZNcjOSchIbQqXWGt3+PH22qMGXJjEvLkAzwfr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojpU99stiw5Icjd4FKQ8BCNZt/gEFvgL1H7OctKr3F6JlTQuOVK2JtVCeRx1zlZmmzKO2wfUgbXsbP7BMJxUMHp9pbpj6jLC0VPhFQy5vvJ7g4n7oZ0qZRTE1HftGQwXtXb2Z0ss4mCCXtFbmtX4DiUGubf18ETqiJzwC2QmwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=btbRK1G5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b701756684so5434156d6.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 19:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777773997; x=1778378797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnVCaxNshzzHjwMMq5W7gN5QUApxgL+R58MdQlfO6d0=;
        b=btbRK1G5RFZ+SyUUfNLzRaZPSzJ9/mretRVTMuZqtyEjAHFRiP+elmVpqzKdwFaqZS
         K1JQ7VMuUx2eE/ACxjiOd+YQB4fYAaK9PnDYGMlwiGUrDK6iKy16aM7glSDXlcsYCWOZ
         pdbtAygj+OTRinuD4hOOpFFclJKItdPC3RSTp00eokz7QCw22sM+tDNGcxoBaZLAOhtK
         eqj3Xts+60lWyE4slvV5QZpOBupe5XgNG+mc8HgCjbk6Yr2dQSKb2kIxW1cJXnOmA5Ju
         KhhQFLAWheKe2R6mmsZjG0MV4EgsW40uo6+MK7clHHb50WVAqb6OEut8vo3Se8+IXAUi
         540w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777773997; x=1778378797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnVCaxNshzzHjwMMq5W7gN5QUApxgL+R58MdQlfO6d0=;
        b=nid6nxaQ1gGn59pc3Il7NeA6sbN1Ud7/wOX8fai4rHwwNd9Ow7jWWFERphZEimZcXi
         nAxEnjPs2+n7GJuRkRmpy+b9VR2Yw3bsPmyj8JGHkW6Ml9OBrLmVrnRX6q4cNWNQw1+0
         es/dnRQjhOVIELtd5QKLa4SU2V2+g/VI+mWOX5lv/sJpoBUdFLiiGX9Mlhe+IC7qcTIA
         1UA8Sp0ASRcGA9VTUfjt7mwRkhjRHkbSQ6+vn0d0hYdg9K5yucYEphfGxQr95d9BoP23
         CrzXXdPGbxKTzddPP2tdMT/aaplSsM2HwIiVHvfX2yTecQf+W2u60rbrLOEOdc+2RBxO
         Orbg==
X-Forwarded-Encrypted: i=1; AFNElJ/Nwg/tEq66NVXmiioKymWn+MXHie9DLUl9nC6jm0WxcUaG8dQwvT2sCiodMidAvqcEpVIWddI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVvls31mE9KEp1X1FrbtSzh1cR93klI9fdW+Sy8w8idCbIozG
	OAcgX58FiicFzoGRKtn5nH0wsCE/PBStZ68CGyY61CwWn3UUYatvnAOaZac3h8Y2+Ds=
X-Gm-Gg: AeBDieu+p94vYyQFq1jAewelB529NryBY9jS+oTMGDMN98mCpxUnmYcuEox1NIXb37g
	zQ/aeFueH3pCbuUYaJ4hM9uBGXskM5WOCuRd5NYaAeNbsFV9HIFyEv63QxPYPoMQiLOXOtvWI2K
	tjgfsYhiyvH46R4WpO6nYzBm4iMAcaLSohjCSHrprBOLFmEGLKuDEOb9ugWpMJ7aiwBg5nzNmcc
	ggfeEcLlcU1oDNGXez04DLw0+4Syg2jcfgz0tIzN0kx+q/jRkem5TlGD0GBtxefOnhJkGpxBeWF
	YXRMTdGetRAzeVMGslwz+afyYdQzFKLSU9jEPeqHM/XxZ3JsQos0WMT1pQ9cMfBIlKeOnUPpX6N
	K8THSW6cG7eQNkDi1sS5TyDaOdJves48iT9LMXdWgufM2R88DDwe6xA9zI79T75zck8G3WwJNxM
	lPcj2ekTTsi5fUgMyq/6+FJ3lmhCv7dP7XySg/kAKZ97iU0iktO016A71fTxnRatFxWM2qVlCiy
	w==
X-Received: by 2002:a05:6214:610d:b0:89c:8a3c:e34f with SMTP id 6a1803df08f44-8b667b79753mr56665696d6.12.1777773997147;
        Sat, 02 May 2026 19:06:37 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm72634806d6.49.2026.05.02.19.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:06:36 -0700 (PDT)
Message-ID: <649428a4-9505-4a1a-bbbe-bd90be9b8155@riscstar.com>
Date: Sat, 2 May 2026 21:06:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
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
 <20260501155421.3329862-12-elder@riscstar.com>
 <20260502094559.15c3f479@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502094559.15c3f479@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E63AB4B4103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,armlinux.org.uk,kernel.org,arndb.de,linuxfoundation.org,riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

On 5/2/26 11:45 AM, Jakub Kicinski wrote:
> On Fri,  1 May 2026 10:54:19 -0500 Alex Elder wrote:
>> The Toshiba TC956x is an Ethernet AVB/TSN bridge,  and is
>> essentially a small and highly-specialized SoC.  It implements
>> a number of internal functions, including a GPIO controller,
>> control registers managing internal reset and clock control
>> signals, a PCIe switch and internal endpoint, and mapping
>> hardware that translates between PCIe and internal addressing.
> 
> drivers/misc/tc956x_pci.c:541:17: error: call to undeclared function 'u32_get_bits'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    541 |         chip->rev_id = u32_get_bits(val, NCID_REV_ID_MASK);
>        |                        ^

Yeah I think I noticed an error like that shows up with 32-bit builds?
In any case we didn't see it during development, and we'll make sure
<linux/bitfield.h> gets included.

Thanks.

					-Alex

