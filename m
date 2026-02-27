Return-Path: <netdev+bounces-261756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FKkBK5PoWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAD1B4382
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF81301F9B6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E778312805;
	Fri, 27 Feb 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp9PLyNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7030E0FC
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179298; cv=none; b=H07Z2zZfu7226mloQFliurXa1B2EuTlJn/n3+NaXmJO3Oh10eASgl6lbFqTqDeh3ci8KNe6xqmxUGY7dHv69FM75E5/KQVnvI4EAdxkN996GABdWiTm0lI7rGcGKc6lUPQyGzNkdDmg0UKmXkVLga5eH5UPvUi5a0YXKZfMWhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179298; c=relaxed/simple;
	bh=Dvlg++DM52DQtEyG524IkAGBeRlEN9y3gQuOsexBZos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjIREnpHpfTkVP451lYSjTyuUsqyiuSmZGYkGzjkl4bOzeCwkmtOwQWCa3tKps4D7y7ThsGJRAXjBK83BdAA6SyHvJNWOXQIA73BcTa6iBFrG5P/hSBrZ8KmROEwl+8FnNs3O5FdxNo2LQvREd59ruNN64xP/luodeO0I7wRU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp9PLyNO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82742aa5a3eso737191b3a.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772179297; x=1772784097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie2+UrGam8yuOMRgs4ibqBLJsyZZMJwKunkcFXbejKY=;
        b=lp9PLyNOSq1Mc/9CMmg68aEIV1IBYo82UmiPnecYMiFjxGzjWj53eQWd13e2FpA3R4
         80Fkqj8WlPYrbGuzK99F7kT0saR7rO1CAwLx5lZyS0yF2n1Q+UzSn+DR+VssrcO8/TmX
         20PkYHPEHjBUiAG4OxyBvrljnzFt1LWMlbmAu6Rjfi4vHuEgAVy4istXR4x4XDcJmD3P
         JZWaptYDorT0in6S8NlDFlq8N6NwvN2paovI02npw/4YxIsfOIWq9qzfgrfQG6a+bp8Q
         D3jsygA2v3xX/ngKFW7Ug9+uq6/CKImyKryqzuhJcAEinUFrdx2BH6aJ06GgM3cCpM2c
         s52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772179297; x=1772784097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie2+UrGam8yuOMRgs4ibqBLJsyZZMJwKunkcFXbejKY=;
        b=uN4i7aOVAB97CDkXvU0aBVvveqOf+Py9rDvPVtNgZHiWaUEGlPUMFnlrrb6+dXRaI8
         a0di5YbvCNwLnXtrAg7n7IwHk9U8DzIq/1rWRs6m/mb+FFnsY+lDzoxQKKdT0KkweXpq
         hJ3w5fFUdyjI8FPtezO3u0aUjmNPPFE32m6twtwGcpon/T/tzcqX3MP4p1ONoks5z7Dt
         jZbdi70JUF8ji5EZiUc4QdKYz7geqXBM1FVRyFbge+8px1rJe/mf93EgqaDg4SOPKS82
         oFa8PJyL5aNnG8Jd2xa8uXXCAbDHG/ONgyKcPl2+/vsMBi11yhGi5T5Cigak3RHWo7yr
         ZlHw==
X-Gm-Message-State: AOJu0YzeAz0oeixalKs7xfF2f8BvgxamocLV/k1rXPeglfF6PaL2E78q
	h/m5PdJ/OQdmNTNNdl8nH8pRNaaJcpziLHUovfykNJuh6BU5KXlFlGpl
X-Gm-Gg: ATEYQzxKkD0BYOrazTcqRz3wo+RVkNMOk5UOsSaIfAZDDXe9SWZExGSWo/xXTZIinT3
	rw2A8iUyOFqe8QF3NzcjsvS4jpkyQw56Q81O5m+E91sVVq6bxw8iP3C8LeMDYj7S4eh0YOStnfT
	sjLI4P/ei7b/yoI8pR6NqaHIeraP/U5rk6d7st+4bi+k+rdRF12TRKbRp18FtCI4I7nQp6jKM8U
	kkyH62mzFRcsrv4w+4/v5ekuYn+N/WpbvUD9Oad/HNWj9cfECpuAd44UwyrRBH2fzbpsEfc0bCD
	CGIY2EcsGWoLoNc0lKe4SiKhx0CoB6mcXh7H3rjvkYe8lpkYEpZo5vb2b0OYtPagQbFdYipz/mW
	QbNl5E8luL7HYlD5JPbkBj9GhW/lYbkFWs+VZUEQZeBTfoqr+6FVlfsNMVzey1QS+OaF8U7l1lH
	2gh/dB2xm3bu8piajAuFSUEA==
X-Received: by 2002:a05:6a20:94cf:b0:393:dc6b:a10b with SMTP id adf61e73a8af0-395c3b0f6e6mr2039870637.44.1772179297185;
        Fri, 27 Feb 2026 00:01:37 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359037af175sm7729375a91.13.2026.02.27.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:01:36 -0800 (PST)
Date: Fri, 27 Feb 2026 16:01:07 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>, 
	Zhi Li <lizhi2@eswincomputing.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 0/3] riscv: spacemit: Add ethernet support
 for K3
Message-ID: <aaFOeQ0deTKVW0_N@inochi.infowork>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <CANBLGczi6o4NwDF0fge0_RZ+TVX2dQ=vYD2PYMSupb5xSnabZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBLGczi6o4NwDF0fge0_RZ+TVX2dQ=vYD2PYMSupb5xSnabZQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261756-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,eecs.berkeley.edu,ghiti.fr,foss.st.com,lunn.ch,altera.com,kernel.org,davemloft.net,google.com,st.com,synopsys.com,bp.renesas.com,bootlin.com,dabbelt.com,redhat.com,cherry.de,eswincomputing.com,cqsoftware.com.cn,disroot.org,gentoo.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Queue-Id: 72AAD1B4382
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:00:29AM -0600, Emil Renner Berthing wrote:
> Quoting Inochi Amaoto (2026-01-30 03:27:01)
> > Add initial support for ethernet controller of the Spacemit K3 SoC.
> > This ethernet controller is almost a standard Synopsys DesignWare
> > MAC (version 5.40a). This controller require a syscon device to
> > configure some basic features, like interface type and internal delay.
> 
> Hi Inochi,
> 
> Do you have a tree that includes the dt entries?
> Otherwise how are we going to test this?
> 

Yes, I have one, but it is not opened as I was requested.
I will send the DTS patch, once the clock, gpio, and pinctrl
device is available. At least for now, I had no way to post
my DTS patch.

Regards,
Inochi

