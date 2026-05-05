Return-Path: <netdev+bounces-284519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKF6IvQe+mnoJwMAu9opvQ
	(envelope-from <netdev+bounces-284519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:46:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC574D1990
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE1E230093A1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5F492524;
	Tue,  5 May 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JkAevuNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A7492534
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999599; cv=none; b=pBT/B79HvJBoaf/QexpLRUS+zaGXjHW6jHMGFnPZWwV3MS5gc7wN7mRLmx2N0CQHmS6qBWxqBgt/6RrALjbRDB498jRG4XcHa85bfcA3+vZhdwJg6RI87lEnxNFkKxLJ0adP+N1mr134EX79F1TjrY2TlEtAbQanleBr++M8DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999599; c=relaxed/simple;
	bh=lP8GSMfbSOdPUQu2yG23BWNhx5HOEezwIqDOAMp/G78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvw0uQ9ZYEhNYFrbN4/BF5MdPUxoAANvYdig1n7gn15VQ2T/3O4aCE9d15VaB+hfKQkfqrs9OqvFSNaDztrNtzSYU0KYHa5aK/hK84wKD9zjTUprwA9RT7rdIs4Xq7rbAhMVORBdNKufGP91KEbcaPFgLXbkL0YikNla32/Ic6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JkAevuNr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bd5c582c6cso55323197b3.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777999597; x=1778604397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrfGKIeyY4VV6HtGnp4FKIxytz8xo/bAXQmJCIlvsw8=;
        b=JkAevuNruhd/yKdOlNO/Zb4RDcsdJSG8b3alVSqro2WqzsHTZqjrgeqGwWn2qboD0R
         Vvg10QJ5eul0ZaRcVdACZe4ej6YQ6+ykfGXbLrDof53cKOyGDxvQFOXpyBJ+2JgLVEdw
         CmpVDaZfiR0KHOvghsUBqRSnDsIhdmcqGpqEKij3Mk++aVjWT9/l7oNgAwcNdv4WrqzR
         VKOV4rioDm/xd4aAmUWWAdto+cotpCAZ+6rYpyPyqRF1zOt4OeqzKXizhKTimcDgL49s
         DVZZn78TEwa/SfVNS6gcZBT2+EQL3ju7rQ3KLi2V0oDD5NG3pvX1PUlHpZ2sENlL3aJA
         TQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999597; x=1778604397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrfGKIeyY4VV6HtGnp4FKIxytz8xo/bAXQmJCIlvsw8=;
        b=XC7X+5RVOwc4sY9DxNeZGDjluZALLeGjGXaxoDmVLzevvFB+LMuh/uH6nF6iePS2jJ
         kQeA9EO8EahC8LkmMIBlod7gxxPkz30siJvR09+8fJjCyXPfdBTTnplE47YS70wEHv90
         aTwp+LYleJMc4Ps80Xt+OIhpNVzimIM2iC5e9COn87bZNWcNDt/05XpghRJjFJPG6R+Q
         1uVAJSzqYJQ33VfA1gzKyvff0WZrYHpLlH5uc1xKmcpvb/fyz8Xj3+9jE+eZQN0DUUKa
         5pwLnil/reV4EIzCkFWsadwU2R5IN2z3F6tiATuS6/m2ewaUmb+SBkAFQ3Wdvx1juxbl
         sbww==
X-Forwarded-Encrypted: i=1; AFNElJ/PE2T42gHndlIo50XA81nZUEffcXluwVwCJjhjdBtG4M2gm3BIT+oQ71jl8QS6nJRN3L+uA74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuF2Aq3VQ6A3s8SoVIPIY0M54nWDfhUyrt48YKS1py1iBnnvw2
	mAwr2oxB/mxoSNGuKCw7WsurqkNxMb4QnJOIQNb7hACb4KTkcdMk66+ytGjVaoxdwdg=
X-Gm-Gg: AeBDiev9bnbMngsOkbOQIlqzsWwLRvPrw6VxeQsaEAx0j6ZcA4Y/YTk/JDdKWNaEkJB
	RKDVUWRfeOxME6T/IPMkBsYmSXW4nCaDllG5XEIuUNqnpd53p7PoaMAUcwYa7jmUggRUtGJ5LfD
	G/rCG6R6itgGgK0Lrl7xiYmGbOUBHJN+cChzr+P6CW67hI4G7Wo1TYN3fkfz4S7OLrsIZDHgTIG
	YOn0BaNq9NdsIlj3QScfPsia+QnrD7SB5FPo79fTZMLWvBMaUbgsr6mrFA6ruL2/uppz6juzjUA
	/yScOYiicXa9fGDyJLTOej1Zg1RXarvPl7OWoNwQNPHo5wh9LRG4ImbQhAbSgoOua3REUTs6277
	5cayzpcAygL87oqENrU4viV69EDiGo2aIjcbyShJZLrbgq9df2r3DHJ++0urAqPEcdAakPSyJJM
	+4EUPP3lVlxm5MSM4sQ3LMfXo6+wfeRxrUceUyt6gQ4uQd4cXOMqPyKBy0ptCeXPSekgDqMYk6X
	A==
X-Received: by 2002:a05:690c:60c4:b0:7bd:8cb2:4fa4 with SMTP id 00721157ae682-7bdac5ffe89mr42184327b3.39.1777999596609;
        Tue, 05 May 2026 09:46:36 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66558f35sm66666507b3.15.2026.05.05.09.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:46:36 -0700 (PDT)
Message-ID: <c716efe3-1b60-4a82-8fcf-1928c0233d64@riscstar.com>
Date: Tue, 5 May 2026 11:46:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
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
 <20260501155421.3329862-13-elder@riscstar.com>
 <afod8ot7xb+g0wzN@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <afod8ot7xb+g0wzN@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8FC574D1990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,riscstar.com:mid,riscstar.com:email,riscstar-com.20251104.gappssmtp.com:dkim,checkpatch.pl:url]

On 5/5/26 11:42 AM, Mohd Ayaan Anwar wrote:
> Hi Alex,
> On Fri, May 01, 2026 at 10:54:20AM -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
>> TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
>>
>> There are multiple builds of RB3Gen2 with components included/excluded.
>> That means whether or not there is a phy attached to eMAC0 depends on
>> the exact board. However all versions include a TC9564 combined with a
>> single QCS8081 attached to eMAC1.
>>
>> Add properties to the existing PCI nodes to describe how the TC9564 and
>> QCS8081 are connected to each other (and to the host SoC).
>>
>> (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
>> binding, but checkpatch.pl doesn't recognize that.)
>>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> 
> There's a minor typo in the PHY name - QCS8081 instead of QCA8081.

OK, I'll fix that too.  Thanks a lot Ayaan.

					-Alex

> 
> 	Ayaan


