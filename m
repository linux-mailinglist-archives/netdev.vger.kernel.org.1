Return-Path: <netdev+bounces-268246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCndLlZIuGlTbgEAu9opvQ
	(envelope-from <netdev+bounces-268246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93E29EE14
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25087300C3B4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79F3D3CE1;
	Mon, 16 Mar 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a5rz4F7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E23D3335
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684816; cv=none; b=MdD7hwWf03a7wJNi9Zkfpoq9OvGlQ6UN2uXT2h5llukyJq4Rvolzd4P9hMMVCEawR9ScX8V7pKdizqk/if23uMWvVs3wwPjoF2AtU7W8XEw4M4jzeVyd8/99oiYfZvez/6uiPl6TWk9/hWbg/sSMO5J9RkzNAeo9hz7WMvXKkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684816; c=relaxed/simple;
	bh=xJhMoZNqr+EHjdBUv6t14tIBHJ2MlKnKgZGrDXGR260=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7Wa/AX9gb3Z4bG1FWvgkSOvD1BxcODPdnaZtjnUiOWhh/WIxnX+1+3wNHvm0qWCbSTNuWr8R7oIO1DwU0YNLRAUThRjNra7xnC0q+vFZqQKKjEMj9adE5OQdlAD592rzIkXzEAD9pPtfvySvR1//EDV5NdSe6rQmB6cFMWldYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a5rz4F7/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73d251b93bso2137322a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773684814; x=1774289614; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I630kcGdJmHLQvgv2ucM+rk0u+MBt6XpMILrvY8Gco=;
        b=a5rz4F7/PIq5VoPeuJr7+Y2B1gH2TPWLfJJYg2OnJMJUiRdcIuf4QvJSK6AnFFYIyA
         kDlAQke4I7guGFiBOIBg2AtC0aFC41RPGIeqiaikJAowEAcmII0mcc80kUAy3q1+ONh2
         G7a9tEcDZjdM4Fllm88bAx31ihMqsRr+sErfpHhfltzj7sfeeHTJLHvckufLbmxwLguz
         kHUILezoTbEFcVO31e+ZHgN1aQxeIP7pr1p7xwyBvOR0kAPrz6c8UlZb4sNw77FcUy04
         CY4X6qDSPN+ro6Fo0oHiQulDhZ/b+mB0QjWIpPxrTDkTLA3iTJS/wQ4oaevjugviTfxq
         vKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684814; x=1774289614;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I630kcGdJmHLQvgv2ucM+rk0u+MBt6XpMILrvY8Gco=;
        b=EHaBUsh88zRDIN/vrY5lhitYsGKZ/JYNv/BQhn5w5xsxZhwowZMKS2IIW1Q3hFMGEx
         pXyDZkWOPLAYXc27ZLKSa1DhFZF0MyOQA9zM/iA622LtUrg7vn9iQQmjtFYy2e1MnNr6
         99tW774pNcqC/BbxGzEx9XKgYjv+aXayLzs08RSMMb8hI0LkXNCGleXxn5ijRB02sP/K
         fVraz+edkQReBGSYbfiUcmUpSsVw4aYAyzZG5ze+Ljc23pZwR3IyWqn/d/1nmo6Xa1LW
         mbzTCeGM/I44bCBPT4BiZQzYhv/K4OVPe/s7W4MWOjUjwsiRDxNQwIo3fZAY3K+yqAbu
         x+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvfZD+bZTBIZau1c60iI/KoDKR+DLMmVbBpz5Swn8DH29QSIVSUcJLdVYHtQou2VfCQhplwUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySL/Qt4Htr8bwU8iM7BCgoDWsIMdb8fxjh12j1uDk0/RzF19Q8
	U/Qm0J3OjHr1F+DnzMRIBdsZG+UmyAe47p8v3V9cqVQ7Js0tyzVv0HDB91yl5OJKZUY=
X-Gm-Gg: ATEYQzwHvBPb0GHpsO2HRA1V5YcjfMyAREYyIiSPKa+fs8WfpUxenOLzJtMfuJB/fhC
	+WNGCxVowabT2XNHxakvxQakgjUfvgqFcsGEdIdFpAf+4a1Q5kjVgrLayP6FjvBUHsho4YdYIYx
	W6e1Djh4bn+/ESt348m10C7DToIlx6MWIQ2iZ2fK7nVV5FDTRyBTtPg2WuyhOXDV36xaVEk9m7u
	1fJZdiRRAQvuLYlQHViZl88OVre0dKbZWjU/Q1G1taPGtai1AVq+dMC9XbDpB3a+DS2qqk/SD19
	RMYoRDDc425SAc1CWm0YMLIrkgv7sotSSYe5LB3Xw59DPCWSMzjgUU887myzlZK+yNr9yQqyywT
	ZDsCZGAmROzduh038vSmHn8GAFzwUwCqZH2gl1WF7f23aOo5C66oyH5llnH9Cg9Zp5SXPA/se9S
	QmoV2lB/U/f0I+v1qwNyc=
X-Received: by 2002:a17:903:22cb:b0:2ae:5a70:477e with SMTP id d9443c01a7336-2b06365b4dbmr4321155ad.12.1773684814193;
        Mon, 16 Mar 2026 11:13:34 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee3basm151378665ad.43.2026.03.16.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:13:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, nm <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, afd <afd@ti.com>, rogerq
 <rogerq@kernel.org>, tony <tony@atomide.com>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 richardcochran <richardcochran@gmail.com>, aaro koskinen
 <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, Andrew Lunn
 <andrew@lunn.ch>, linux-omap <linux-omap@vger.kernel.org>, devicetree
 <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>,
 pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, praneeth
 <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, m-malladi
 <m-malladi@ti.com>, krishna <krishna@couthit.com>, mohan
 <mohan@couthit.com>, pmohan <pmohan@couthit.com>, basharath
 <basharath@couthit.com>, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v5 3/3] arm: dts: ti: Add device tree support for
 PRU-ICSS on AM335x
In-Reply-To: <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
References: <20260307122641.738450-1-parvathi@couthit.com>
 <20260307122641.738450-4-parvathi@couthit.com>
 <7ho6ks1r4s.fsf@baylibre.com>
 <91797572.667989.1773662409130.JavaMail.zimbra@couthit.local>
Date: Mon, 16 Mar 2026 11:13:33 -0700
Message-ID: <7hcy131w36.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268246-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[couthit.com,ti.com,kernel.org,atomide.com,gmail.com,iki.fi,kemnade.info,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,couthit.com:email,baylibre.com:mid,ti.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BD93E29EE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Parvathi Pudi <parvathi@couthit.com> writes:

> Hi,
>
>> Parvathi Pudi <parvathi@couthit.com> writes:
>> 
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
>>> This patch adds the new device tree overlay file in-order to enable
>>> PRU-ICSS instance, along with makefile changes.
>>>
>>> PRU-ICSS instance consists of two PRU cores along with various
>>> peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
>>> Ethernet Peripheral(IEP), the Real Time Media Independent Interface
>>> controller (MII_RT), and the Enhanced Capture (eCAP) event module.
>>>
>>> am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
>>> of the PRUSS subsystem node.
>>>
>>> am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
>>> eth port information and corresponding port configuration. It includes
>>> interrupt mapping for packet reception, HW timestamp collection, and PRU
>>> Ethernet ports in MII mode,
>>>
>>> GPIO configuration, boot strapping along with delay configuration for
>>> individual PRU Ethernet port and other required nodes.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> 
>> [...]
>> 
>>> +/*
>>> + * Disable CPSW switch node and
>>> + * MDIO configuration to prevent
>>> + * conflict with PRU-ICSS
>>> + */
>>> +&mac_sw {
>>> +        status = "disable";
>>> +};
>>> +
>>> +&davinci_mdio_sw {
>>> +        status = "disable";
>>> +};
>> 
>> I think you need s/disable/disabled/?  (note the trailing 'd').  Without
>> that, I don't think you're disabling these nodes, so I'm curious how it
>> is not conflicting with the PRU-ICSS.
>> 
>> Kevin
>
> Thank you for pointing out this typo.
>
> We checked the kernel code as to why this did not create any issue in our
> testing.  We found that the device availability check goes through
> of_device_is_available(), which only treats "ok" or "okay" as enabled.
> Anything else is effectively treated as not enabled.
>
> So even though "disable" isn't the usual DT value, it still prevents the
> node from being probed since it doesn't match "ok"/"okay".

Yes, but since your node is in an overlay, if a previous .dts[i] had set
this to "ok", then your overlay would not disable it, which would not be
expected behavior.

> We will update the value to "disabled" in the next version, since that is
> the standard.

Thanks.

Kevin

