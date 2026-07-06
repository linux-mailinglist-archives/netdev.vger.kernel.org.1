Return-Path: <netdev+bounces-305029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qEZ4IOarS2oxYQEAu9opvQ
	(envelope-from <netdev+bounces-305029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DA71130E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IGjrezxJ;
	dkim=pass header.d=redhat.com header.s=google header.b=Ac2vAY7y;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305029-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7DAD3025A67
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DC40A933;
	Mon,  6 Jul 2026 13:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354640A924
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:09:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343387; cv=none; b=XMqKoptwhXfLZa1VAOle43qe9KP5f7Xqa3dOmAZRXFT7OCLKulXDq4I7Rq1aAJgO/0b7LGR0XK1HSA9Rykpeg9rM7MixVmfd4dRUqvM+WZ6MvuL4kpAZV0yx4tnBDxCOip8vR4LSv4hWHJpBzvECbzHrxmQvHngIBrx3KYeF7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343387; c=relaxed/simple;
	bh=l41RXQvXBkxvYTzqq2rFLxtUAbzHPMY4/jExtvAtGoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBZuDmSLyciPog/Y2txU++F0wTiDnNlV8niV0xA+eUuINpoukvwhwTApEQoi49k48fkRfXnQx3zoRp/6QCciP9FYZ2SUwuosZBh5wO/w7Jc/B0L0tWvMCUjXEoCZeSEMcuG5m8gwxJkPU0LiJJmpV/kUsZ+F4126rGTwWNyAQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGjrezxJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ac2vAY7y; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783343385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUHCisuScEtc1kpgEniw1SQHEHnjG8D0qhIWEGCMudA=;
	b=IGjrezxJZb6tuVeDxoA5xudkI6hhZxPAb3o1xaknL19tS0irr6r3Hcc2xlETxtsvWDInxu
	ejhoJjDG2iKavJguGEREnsrM8kGYJX2DIb6yysLovtRso3xQbk7GFgJji2KqN6WYbPPU8n
	tASSyM5oklRcNCDnhPJDj5K0trK6aLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-XaH-OOZIOBCYRhYS8JcJWw-1; Mon, 06 Jul 2026 09:09:42 -0400
X-MC-Unique: XaH-OOZIOBCYRhYS8JcJWw-1
X-Mimecast-MFC-AGG-ID: XaH-OOZIOBCYRhYS8JcJWw_1783343381
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493c55d5ce5so13417005e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783343381; x=1783948181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUHCisuScEtc1kpgEniw1SQHEHnjG8D0qhIWEGCMudA=;
        b=Ac2vAY7yfmxQbyWeQvPtdzzMOm0k8nRC+Luvqdjzg0WrAC5SZuMmiOeA81AgE17UVY
         5MXaKKU+Xho4YSscxth7UFM8yBnc+E08tgHykdfq8bFSA9t9WcVxozypA0We/C9vxt5E
         2wD8yI2Mli4lyjajve0Dj6Nnepsj3qGz/ixlmqakSPi+P5D+JuxiHBio7celn5yXJCXK
         M5lMSO2vHl38UIzZk/kURmZ0Qlcf09E4lAUTsxIwbJ8MOKgx2T/xuxswl8W7qzihtAuA
         2anZBGU0d3OkoNxC8CEpui8heMnkG6cM2FRxJ3C66qwpk4Jl2zkYs/z0h6VesK+gajSI
         SYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343381; x=1783948181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUHCisuScEtc1kpgEniw1SQHEHnjG8D0qhIWEGCMudA=;
        b=JgZeTFb4wkbUzvwtWFVzud6UQPQcWPadYz5kil9aFtNPWTXnOVJenb9lirvcTg53fF
         ZfHFCeHnTxxwd+PRVISpIAB5TPODvPVIWG1HZfoiPuYQyyk9IsocZfeJzLRaBNbsk99q
         dAL2K2tzIe0gMkKfYUlWzdTWPdTDG75vmGSLqhmmNgd2QVeRn8UBXuakgK61q3TiMK3P
         2jDAGMx1znVxMTIYZuANV8kC3RkL+w66+TJzkY4BejH7ePyoGp3UjpzxOc65rxpOu2b0
         yWPrjug8uGwSITEhurZWPbI0ydTWIuU3vTDJU4h/77Aye6tlT/vggsY4qE9bWq0SF6YD
         u4Kw==
X-Forwarded-Encrypted: i=1; AHgh+RoBcno6NBATOREiq0ojJofMSU9WvSNaoSJDmBpF9bWrfHsQ2WA7/YEKw1cbHSSCn5IkEU3cld0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05ML2tC6HxM5wMHdmrSIiuNYhI4/dBNoN2bMqzRfAhuA8U0PY
	v7lkFZJp608eA8lVaY5oJ9Pkl9uSS22QXyEVppwwtAU0RHzsV+ieaiVDy0d5ULN6j3CEcZ1d2eb
	/0ELZv/OhX7Ya0RyhkuDbcPCP/nMptOVy/sm+kNn8QD8/ZkHa4ejWPNtL8Q==
X-Gm-Gg: AfdE7clpRu0YRQ29/7gioSF6RwhoJ0/PR1tF0o9+1KbbXVYZ9Br7yaBVn1krRwutdTb
	SDnBj2Z2QsGWn4OG4Z6imp9V8rGsDW4frHdeWkToY4LpMqUu6rdNGV21/x+LebXl+zurc6yR4os
	jKARmkhrwLyOOb85K0ZkdIfTEpV4mH02/NkXxmWca9XbDfYlP8yUXMrfZXwyqkOhnIW9wy6A9pK
	adbzUofplzChCmN3lutsrH3i96taKtfwcPp5gHh+hlk+XHSqcbOhESIaax77fJHhCzFz6d2Kn32
	+0TyuO8CwGF5uRxqes9l/J9dmB5e+G9Zk16/2STUa/9ofLpVU5NOJRJULOMl1nEliSE59uB9+Rg
	mF/SXP9fVQQgU7QR6d2Fa0gSwRygziU+qjizBhshQ7IhtEHvJmzX+o5XwVTKHIwr9sNJjlju2px
	ZXor7fXGcynpYX
X-Received: by 2002:a05:600c:3f16:b0:492:454c:347c with SMTP id 5b1f17b1804b1-493df066413mr4850655e9.7.1783343381363;
        Mon, 06 Jul 2026 06:09:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3f16:b0:492:454c:347c with SMTP id 5b1f17b1804b1-493df066413mr4850375e9.7.1783343380895;
        Mon, 06 Jul 2026 06:09:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm25839803f8f.37.2026.07.06.06.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:09:40 -0700 (PDT)
Message-ID: <8e5eb97d-dfaf-47a1-8572-b3252a2c7ed3@redhat.com>
Date: Mon, 6 Jul 2026 15:09:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 maxime.chevallier@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, weishangjuan@eswincomputing.com,
 horms@kernel.org, alex@ghiti.fr, lee@kernel.org, wens@kernel.org,
 lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063445.1226-1-lizhi2@eswincomputing.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630063445.1226-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[eswincomputing.com,foss.st.com,gmail.com,einfochips.com,bootlin.com,lists.infradead.org,st-md-mailman.stormreply.com,dabbelt.com,kernel.org,ghiti.fr,vger.kernel.org,lunn.ch,davemloft.net,google.com,armlinux.org.uk,eecs.berkeley.edu];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:alexandre.torgue@foss.st.com,m:mcoquelin.stm32@gmail.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:maxime.chevallier@bootlin.com,m:linux-arm-kernel@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-riscv@lists.infradead.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:alex@ghiti.fr,m:lee@kernel.org,m:wens@kernel.org,m:lizhi2@eswincomputing.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:rmk+kernel@armlinux.org.uk,m:aou@eecs.berkeley.edu,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,eswincomputing.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188DA71130E

On 6/30/26 8:34 AM, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Enable the on-board Gigabit Ethernet controller on the
> HiFive Premier P550 development board.
> 
> This patch is included only to provide the DTS context for reviewing the
> binding and driver changes in this series.
> 
> The upstream DTS series will be submitted separately after the binding
> and driver changes are finalized.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>

@Rob, Krzysztof, Conor: I see this patch is not listed in the devicetree
PW, but I think it needs explicit acks from relevant SMEs. Could you
please have a look?

Thanks!

Paolo


