Return-Path: <netdev+bounces-280243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C+/MNLY52kBBwIAu9opvQ
	(envelope-from <netdev+bounces-280243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA143F3A1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B798530CC4C0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574373DD53A;
	Tue, 21 Apr 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y15qGO7K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf5CfghO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2E375F83
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801786; cv=none; b=YjAbHhxeEauERLJ/ZqxF7MI4dpoukvVSLadHXDRaBGLSoC/RdXQ9/Ly3Cj7P0ISJj5yVyC6o9in77ZFim1rpthhrf4bU6QsNdIQUjeOVr6fApgufhn1wgJNiuzIHGjO9meO2Hp/xnVSHsSCyv9atGl9jeVgARekKDLAJf7/9gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801786; c=relaxed/simple;
	bh=z/yo03AiSA0eCKVwpNdHXlr1nQWbFRacndf5yazbhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKsTOU3iA0qATrxbCwxs/9qvlwjyIv9cDhRBwyxB+Au7Vy/JoBwcDb1viPiK43keDfi0Bu91pYQKvobNw+tw+kcYoUpDrBz1M84MDFOrV2TyIfNHXPNoDHk6iFq1W7Kp0wt8QJUC6+HNS+KYCLsCKc44nD4N38EzO81rOuETdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y15qGO7K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qf5CfghO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776801782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zuspwqjQXluBmm8BYsT+wPUm5BBdmNQ0nxP766NAw4=;
	b=Y15qGO7KatdL8QazAM5wT6++n+fu4VAih4ufZsVgYo0ESc2Tb5Wl8Qsoq24N3D37l1qRRG
	NM9Y+bBKmhYZL51LZ5uqXBTQL7esDc0GJz/S3nJSLcb5nxs5DePMQJ8TR0Q+o7c5mhZxoo
	tpM4UfdP1fovgyRu70fQOJzv1kEo22A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Meu8y5skOhuLtF-xuBVkmw-1; Tue, 21 Apr 2026 16:02:59 -0400
X-MC-Unique: Meu8y5skOhuLtF-xuBVkmw-1
X-Mimecast-MFC-AGG-ID: Meu8y5skOhuLtF-xuBVkmw_1776801779
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8acb26fbbb2so70005706d6.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776801779; x=1777406579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zuspwqjQXluBmm8BYsT+wPUm5BBdmNQ0nxP766NAw4=;
        b=Qf5CfghOVthZvhlWyx//1FRq1D4MEv2vkPpXuvZRNNKNtZ1GdGI/h3UDhH/WP8brUU
         2fBYsUlv+FLtOF0MeiwjAgPLHVS9pqRL36VN84uOkdQFlZgwrEfoHFneEW7LnCAOLA2S
         er7vnuc0kNZAP45MakmSHkbWYikZNlv9FQ2VzVvR9S+UyYgEx+lBS6Xp12Biz30utn6+
         UHeJnihQXQCoNFe1Zvts8Ht3emDdBPeevdwyiprqTznV5ZvY79KPENwqVcQU5yWwOQzP
         PWsZGfC74eqZdktTUqT2vAFlxaO0EsVu/WeXm7q/ecwiMDGxEvO2HK03GRaf4tWf6XIC
         UbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801779; x=1777406579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zuspwqjQXluBmm8BYsT+wPUm5BBdmNQ0nxP766NAw4=;
        b=bNwp8bP320D5rt3qrQWHGGktqFC0GXjdzY0UXnf1NM9dXZcsL4wOcf+4fOlf+hgXcp
         jtecoDWogjE2rRZyUGro+pCkwucMjKZ3Mg0b94Wa5GSdih2qjronjbuIS7nx/pB3At6i
         os0PP06UcQkFu860w7hSZOo3+HP7FLOgb6JtKvkwB2uhIHE3P7iemDnkUIwRCOmwnaIj
         Gu1+8FCNwx7eyJQzYksgSAToXS7/Lpc+iIM7+WWU98HAKeFEpAtMRNQjsVPxcFytM6pU
         fE22jM0la4R/V0x+LkP+MYcqSZc3AuFsySA3n7xXcW6n54HbdVnOKt/4jMYTJq2inT8b
         OVLg==
X-Forwarded-Encrypted: i=1; AFNElJ9TWHt3ZCD8xqAS+dHseKZytXo6mbh1a7SX7GHWouE/5IRZ9+HD0U5kpsgNcxliMAqNXlI/dMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+vkZq+ntk+J2JESv2ZW4N6M94n0AKoVA53hhzlCSfWhG91DA
	2XngdzbYkd6idjZ3qX/9Twn/kETNAEwruO47VpLf+1pPnOc9egdE4D5ZsKnb5d5+ine+NTvIIZj
	mCquS+ru/ezEdY3yreVtda5EELcURLM5PrhN7C9Q6duJy2lsStNUvHRHuMQ==
X-Gm-Gg: AeBDietIwq7SGkfv4q0exEMW0moAED2dmDsSCFiEq/jIHE0CJvT4YO/7j5t3yNvjzJ7
	MPTlKZGz2tdawq5CbQL1h2/99bzI5TSG6LBy6drNOH0WIVaMf7zIw4CYJkn0nx5EP8aUnlTDuP5
	ryKJ/vgOmT+QNoxUxyCt2+K/VEwzfw3lZBypDr/fCmwlDyNaizrH4g9ADHOxLOcMmI7jEgf7qgk
	eMUIuYn35kCvIOiCfGx/KQsesJ+7ZhKIyLJEWH7Dza2fBuv8CTe0tBnReGFMIp7yWagMRNogc2C
	AsHRQ2UsvJInSzFgrJJhi938+hXvXRXf6QmhbPWg6imn9iXuVvHXWyHB3DKYIdwPAt7IXnIzAXR
	o9sz4+mV/AN56mK3ItNYvPg3FXk/dT47/9WjQXuTBXQ==
X-Received: by 2002:a05:6214:5b87:b0:8ac:a5a0:481 with SMTP id 6a1803df08f44-8b028015984mr335683606d6.4.1776801778612;
        Tue, 21 Apr 2026 13:02:58 -0700 (PDT)
X-Received: by 2002:a05:6214:5b87:b0:8ac:a5a0:481 with SMTP id 6a1803df08f44-8b028015984mr335682706d6.4.1776801778111;
        Tue, 21 Apr 2026 13:02:58 -0700 (PDT)
Received: from rh-jkangas-kernel ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm115982646d6.29.2026.04.21.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:57 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:02:52 -0700
From: Jared Kangas <jkangas@redhat.com>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	boon.khai.ng@altera.com
Subject: Re: [PATCH v11 4/4] stmmac: s32: enable support for Multi-IRQ mode
Message-ID: <aefX7Ajltzt5EqIR@rh-jkangas-kernel>
References: <20260312-dwmac_multi_irq-v11-0-09621ccb040b@oss.nxp.com>
 <20260312-dwmac_multi_irq-v11-4-09621ccb040b@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-dwmac_multi_irq-v11-4-09621ccb040b@oss.nxp.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280243-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,armlinux.org.uk,altera.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[s32g399aevb3:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33EA143F3A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jan,

On Thu, Mar 12, 2026 at 09:55:30AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Based on previous changes in platform driver, the vendor
> glue driver can enable Multi-IRQ mode, if needed.
> 
> [...]
> 
> If those prerequisites are met, the driver switches to Multi-IRQ mode,
> using per-queue IRQs for rx/tx data pathr:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQs) selected
> 
> Now the driver owns all queues IRQs:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>  29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
>  30:    0    0    0    0    0    0    0    0    GICv3  91 Level   eth0:rx-0
>  31:    0    0    0    0    0    0    0    0    GICv3  93 Level   eth0:rx-1
>  32:    0    0    0    0    0    0    0    0    GICv3  95 Level   eth0:rx-2
>  33:    0    0    0    0    0    0    0    0    GICv3  97 Level   eth0:rx-3
>  34:    0    0    0    0    0    0    0    0    GICv3  99 Level   eth0:rx-4
>  35:    0    0    0    0    0    0    0    0    GICv3  90 Level   eth0:tx-0
>  36:    0    0    0    0    0    0    0    0    GICv3  92 Level   eth0:tx-1
>  37:    0    0    0    0    0    0    0    0    GICv3  94 Level   eth0:tx-2
>  38:    0    0    0    0    0    0    0    0    GICv3  96 Level   eth0:tx-3
>  39:    0    0    0    0    0    0    0    0    GICv3  98 Level   eth0:tx-4

I ran this series' changes on an NXP S32G-VNP-RDB3 (dwmac-s32) and
confirmed multichannel TX by doing a basic iperf3 throughput test:

    # dmesg | grep Multi-IRQ
    [   37.463467] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQs) selected
    # iperf3 -s
    [connection logs snipped]
    # grep end0 /proc/interrupts | column -t
    29:  0      0  0  0  0  0  0  0  GICv3  89  Level  end0:mac
    30:  968    0  0  0  0  0  0  0  GICv3  90  Level  end0:tx-0
    31:  0      3  0  0  0  0  0  0  GICv3  92  Level  end0:tx-1
    32:  0      0  3  0  0  0  0  0  GICv3  94  Level  end0:tx-2
    33:  0      0  0  3  0  0  0  0  GICv3  96  Level  end0:tx-3
    34:  0      0  0  0  3  0  0  0  GICv3  98  Level  end0:tx-4
    35:  67302  0  0  0  0  0  0  0  GICv3  91  Level  end0:rx-0
    36:  0      0  0  0  0  0  0  0  GICv3  93  Level  end0:rx-1
    37:  0      0  0  0  0  0  0  0  GICv3  95  Level  end0:rx-2
    38:  0      0  0  0  0  0  0  0  GICv3  97  Level  end0:rx-3
    39:  0      0  0  0  0  0  0  0  GICv3  99  Level  end0:rx-4

Also tried out multichannel RX by adding 'snps,route-multi-broad' to
rx-queues-config/queue2 in the devicetree, which showed activity on
the corresponding rx-2 entry:

    # grep end0 /proc/interrupts | column -t
    29:  0   0  0   0  0  0  0  0  GICv3  89  Level  end0:mac
    30:  4   0  0   0  0  0  0  0  GICv3  90  Level  end0:tx-0
    31:  0   1  0   0  0  0  0  0  GICv3  92  Level  end0:tx-1
    32:  0   0  1   0  0  0  0  0  GICv3  94  Level  end0:tx-2
    33:  0   0  0   0  0  0  0  0  GICv3  96  Level  end0:tx-3
    34:  0   0  0   0  1  0  0  0  GICv3  98  Level  end0:tx-4
    35:  68  0  0   0  0  0  0  0  GICv3  91  Level  end0:rx-0
    36:  0   0  0   0  0  0  0  0  GICv3  93  Level  end0:rx-1
    37:  0   0  91  0  0  0  0  0  GICv3  95  Level  end0:rx-2
    38:  0   0  0   0  0  0  0  0  GICv3  97  Level  end0:rx-3
    39:  0   0  0   0  0  0  0  0  GICv3  99  Level  end0:rx-4

I didn't see any regressions with light network usage, and both TX/RX
appear to function as expected.

Tested-by: Jared Kangas <jkangas@redhat.com>


