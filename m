Return-Path: <netdev+bounces-255235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN3LNVUEfWmRPwIAu9opvQ
	(envelope-from <netdev+bounces-255235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:19:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C81BE103
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8404B30090B5
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732437F738;
	Fri, 30 Jan 2026 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="K/BTlhmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012542FDC5C
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800785; cv=pass; b=CYcAXEK8iLIaqB/EVH38nEOqSG691HgYfK1ET2WJ/On74ccB4o2aceAoywOaSAsg8wGxPA7hpytnLeylLxw2oJL611ucZE7EKxxy6/Ak6kdlryT8KTfgPPU6vAIktZbieMkR/lBuTIta4JYUfNEayff5LPuoHK7r8QuGOIzEzmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800785; c=relaxed/simple;
	bh=xnpwfMSL4a2MlmbEJZYfMcFHaBcZAK5OOTv0D+eL7gM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S+3yoAMBZIW/CPsqzR/us/0bHaFcmjm+mbF+Mg8L+6exhTeA47KOX7pvpppGAMNvb4k56DyZothbgnA7RygsRqj2GsSu6/sWDjc8rAb2zXLfv9irPOcTX2FwxXTeEwm5Jvytfzj8UL6aLhOYHrvqc6csPFOE/rkYsWbgMFGiQdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=K/BTlhmX; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6610b05b37dso1945984eaf.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769800782; cv=none;
        d=google.com; s=arc-20240605;
        b=A4F2t0Uyl2v0PJqiOhW6Moe8D0/rr6nvQyMEj+PMddUuG8w75lmdnpP3EOKO4bdWZY
         AdAV8/idV9XLcP6nabRI+7PEOe1CE4+D3iW7M5nRPRMx5RjlS2HKnBJNwD9SEyxlXYej
         Hqb/eurERxCplBFcpQmKpALPL0+MquQ3iUZKFOeOpBJXW+rcbbFjczxN+tEsfCqOpK9a
         PHVu2mIG7HsZp7Ox63Ea/qgV3/CoaWgv3wgJ4hOthBGXFn4Eyp5dKxpZRAeRpPz85ZJq
         RLBciNw6nEZ9TT2k9raXjfsPLlX0uOCNbp9FLJyHckaq6CrQ+JzEUYuoyCpjzkybIS2O
         QR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xnpwfMSL4a2MlmbEJZYfMcFHaBcZAK5OOTv0D+eL7gM=;
        fh=+vJvXl/0FKybyWYzpXf+sudFn4QyxVbC6cmZmWFsvy4=;
        b=Ot9yPX9pXdCMJjewavFyHDRjitCrIIX3Z31EPK6MycyNEDl7nrXyVoQzHttr9qdqb7
         0FkLR6e1dgUSzm2+zsGY3+hfBM0xDXFE6yVSE2Co1w+GVwtVFT0NduW4l95YqmAluh+e
         X2AyOJTZqnDfCUAJ2zmpMZC+mm0yNlXHspY+od2pxL3fyB0WfqlZBre1Ao+hHgqc0+rr
         wDWqnWsBNHkUj4Zt2+UxdbP5E/uT/ZfgxUF9j5DtO19Zap1aysGslVfhqNfhlvOufr6w
         UnAS5JvERWuEds+cWxIpQowSv/biMp6NJTKs9UiOFGpxJ817h+trywINOectuW1SaKdX
         BDwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1769800782; x=1770405582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnpwfMSL4a2MlmbEJZYfMcFHaBcZAK5OOTv0D+eL7gM=;
        b=K/BTlhmXklOJOSiAe70soP+ojG6ULV3QnE7U7k5wRlZvImD7BmVcTUEcEtchSAdd6y
         p/8cgcEJuYCMunjlSS9q9xd+VpeKoCJqpXr+84gVzojom3MprzwNkKiFBZmLHZcuAjie
         i7uHFSFL3HCW7HJISgEaAgA8AZhvl1IFdxTd4KNrrkKfD4SMFSF3DHiuqXB42vPQUkeM
         5+VaP4m7ixrlWwZNumDTMepdtnmY+ZZP66tiSVg50v9Bq0Epj/0X96UNPA+voG0HApOM
         RYRY+QZ3Dh9N1O97hEzfMQ5sd3jcCoEX7mC7J8C63IjwIuylkkf9zM7tYtHdBO+EXuWi
         qHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769800782; x=1770405582;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnpwfMSL4a2MlmbEJZYfMcFHaBcZAK5OOTv0D+eL7gM=;
        b=CsH8NSLa5ndNMO8ouyryIrxXWJU1s3E5wE+ylW2J0d1ST0AKxGwD9018O5wgt1WhQ9
         FIYzrEKeo0sEPB/ipmaUwrd1ocdCNF97T8BE2hkajnlNP/O13w9FWfbI1vQ8EtakXb9n
         NGNW0S3gD8MzPwr9ix80jCyXYfLwirIqRxIJqjxpO6+3c0kJzHfgMT8sLEWiTmvyoEPC
         WZAsYWN2AH31mrKAijUnoVUqS0sMUrbzSE6kvwWrgXwrEEzv1LHnv1zabs3ICRnX0iii
         lF/1y3JMWkWeNwAAIb7Cgm4+j+6jgtdHQfnRKmNYoTaVgd7KCbSXgHVHg2qKC8HDAH8r
         hHpA==
X-Gm-Message-State: AOJu0Ywu4djkQr1oZv07kIDFOqKXDW7HtEiKBbc3Rt57z8+LihD1kJHY
	gsITi9qRp91SHC58TNuOzvDY8IUxUfeWqMoghI7yJs5SXR6Q0roakT5pzfzVamZm3PUt2BViTTN
	4QaKu9CB4vvEnCnv5WWY9CWhz+Qazm0bpRR+Ge4BpS7YaicA6mVIV
X-Gm-Gg: AZuq6aIVwxhhmQD9a58dwfiqfUHHa9Y9SvHDDphrLHPUzMmxhwUhL4rdjsKMfcoDj0/
	+UdBheOb6+yQUbfwfUNxxp3m/G81GRaSIEJYvZ8jDy94bfIh2W13180VpqykteZaSOVgg0HW0E+
	ORcOxCygUMbAV+3JDKnW7HBiI4ZY7efPzWm4lJ5v0wlKaqOQ9GD2Y6gDtREwYJtGDSYYKr0dKdC
	NZ/wMD0sYC5WDQFK/hsjok9w8+7HsuPDNRjMCPgNTWGVFjMDZAYkKhp8xOf6kU5KOEfm+g=
X-Received: by 2002:a05:6820:c88:b0:663:d06:81e9 with SMTP id
 006d021491bc7-6630f3c4248mr1923122eaf.62.1769800782328; Fri, 30 Jan 2026
 11:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 Jan 2026 11:19:30 -0800
X-Gm-Features: AZwV_QjntK_ZWmcxxhhBpXh1vi_fQcysTYLRrVOc3sidwZyR6NjjfoCQaWZXtIM
Message-ID: <CAJ+vNU32MJA_YqX6Q3XVZViYrZZQD+ro83dUyRP+t57taghrWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
To: netdev <netdev@vger.kernel.org>, Heinrich Toews <ht@twx-software.de>, 
	Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gateworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gateworks.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tharvey@gateworks.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gateworks.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gateworks.com:dkim]
X-Rspamd-Queue-Id: 24C81BE103
X-Rspamd-Action: no action

> Hi Andrew,
>
> > Am 28.01.26 um 16:22 schrieb Andrew Lunn:
> > Is that really true? Generally, what actually happens is the
> > configuration is left alone. So if the boot loader, for example, has
> > set the configuration, that configuration is left unchanged. So it
> > could actually be in single LED mode, not tri-colour.
> >
> Oh, you're right. We cannot assume a hardware reset state here.
> Since the driver currently does not touch these registers, the configuration is indeed
> "inherited" from the bootloader or the
> hardware strapping.

Hi Heinrich,

The setting the SW_RESET bit of REG_SW_OPERATION in
ksz9477_reset_switch() resets all switch registers so even when the
mode/errata are taken care of in boot firmware that gets clobbered
when Linux starts. It is not inherited.

I have this switch with single-led mode on two of the boards I support
(imx8mp-venice-gw74xx.dts and imx8mm-venice-gw7901.dts) and am
interested in seeing your v2 of this series. Please add me to the cc
if you would not mind.

Best Regards,

Tim

