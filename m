Return-Path: <netdev+bounces-289581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNE5G4+uDGrikwUAu9opvQ
	(envelope-from <netdev+bounces-289581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B90CB583C8B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1053005764
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5E369999;
	Tue, 19 May 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gotHQicx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8031AA9B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216012; cv=none; b=m7rbVZrei2jP06u0NoyL2EfYdu5bYzzPspdt+2DiRiCLjn0LUZlI3jrV1tAB5Xx6CeLXbZ/CyZds9FSKlpUvaLB9J7NMZYbRC+Rc9FcJkmxbyXXYma/pGJPQmamu4INzjkVbaGuu4pZuWMfBS/NaNwfmfLMU3ZQ28KwfDpiFTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216012; c=relaxed/simple;
	bh=d6rzr2YNGuS8x54Z2sIdFn40QZMIPF2jgLkO+AUn4eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By0BQBsWVDfucYcMWmOSf1yuGtgGsYyed5YrjIGWeHXV5WrO1GoeTciAqTf1QKuBokpzT00kO/7iLKo1FRLVQ1sTjGrQaifAlobKJEWoyF12v8ofyxx8YLMh4Njwr+gbe4thv9fS3yhDV+Up1GG4i+O8AQHgdAq4AEoTyPwVmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gotHQicx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso3740925e9.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216009; x=1779820809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZRR5GiYso+3hYJHzSyklERXVlkOlpiy70ZAvGBjBOs=;
        b=gotHQicxlqdA3pVAa75UoI0q4IzP8xjyK5xqO8HvA++pfO3Vh8J+1sqRz1tbnKc1JL
         EX3edMTlO+ddOX7mgBOZtxh5iAOJvWtKcVF+IDHzuL6ZLQBdNIZ4FyANJX/gAyhPFpXE
         hCCEwlZCx+wZqu2kHsUFug7EtcSNv1Mdcf9QVAbFank0UD1yaCmg4tf6G5WNQ50Su6jo
         7ZlM27OFZhQm3hfWAotyry6Jix29+r9rooUXHcyuNqeMTtoVNgL9oYzLONfLj2kDcPZV
         ro5xDIrCLkmJ9h/VnekfU72jSpqbkYnI53mUHoL9ftFg8f+5tttF8ustaoWPdtvxslM4
         qRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216009; x=1779820809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZRR5GiYso+3hYJHzSyklERXVlkOlpiy70ZAvGBjBOs=;
        b=So04OrBDy8lTebS3LT0hx2mlM9YSTgB2dL6KtLXyKz5femPEFQ8Gq+AXKwIvgDaFT6
         GuDjIOjzIipw6gYjboOQhKqHxJ8Yu+zTfgACMpMcN2Ie96f0Ma5GLDEMcwnW/albWlU/
         +t57xkqi3yssAIiksiWPblIHZATrHKsPMihU9plyCpOxYTr67D6jYm3Ubv4dK3RSb9mR
         5Eotw4wBrFkMWA4qsyJE7HXmW6PviMfYEVvDNTFwOA022HfVPpwY7An2csoE7Kb1aQ7N
         g4Xl/oGbtKR0yXJ9DGRdaVHr1uR14qF26pufhL3jgePMXt0lxuziboh5SBhU7vyeFTQ/
         owFg==
X-Forwarded-Encrypted: i=1; AFNElJ/7Y5vEN2MLEJyLtDvN0Br3cCW2dw+y+wtTajWinj8ZK9Lj3YH6veXLNYv7Bsl9rEy2EW0f7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykC9guzeKb0tGcGLodgr73fcb+2sLxZ7v1jsZqIzoSQQPNjjV8
	jN4mDCsg3gwj1yB911CCTZtsVl6nv3o3NqjCdcK4U80AB56GT1ctTeQv
X-Gm-Gg: Acq92OH/LigUlHFsKxSSS9L1CpFMhKAWUxnm6JTjbZCRKE2ezUtdiYZm7FYqH6c9RBe
	3Sz8OuH7Gh4X8NVTYR8m0giR6h2+BPKenZ4MowLCxztGaNk7xspFYZgZqH77/doH5VUlM1tO2uZ
	seQchbpKKxM8wFpDJej55aIdOlfy3Amu3ouqYJ3ZBxsuuz4uQjYqbrG7U9YdcmR4OEJQjbldpno
	4PDtKstXa42RXxkIAvhipZO43cXrpnILhkSMAIFK+tL7gR0RCgfDc1/kR3ii5XEntEk4kVfm5Es
	yN00ApF9jRcqzizIwqb2oIbyzQeZR66AzhKIwWUhUN+Q1rVtz7jaoVUAWUxAtI0KMYJ4Vmu0QdA
	lr4A7boHd+mkDsApmLAmdUBnTeVIhmf315DPwQueepOguU7LJT+1lNsmyaTecH2J/O+4s1Xuqbz
	1T1xE2YWBGaQZO8UbgSVf8pZu/+A==
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr170280415e9.2.1779216009072;
        Tue, 19 May 2026 11:40:09 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d507:6e00:6547:d81d:b8f8:e501])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab26ed9sm164943905e9.2.2026.05.19.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:40:08 -0700 (PDT)
Date: Tue, 19 May 2026 21:40:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: dsa: mxl862xx: add SerDes ethtool
 statistics
Message-ID: <20260519184005.cx32dtj6v6wosb3s@skbuf>
References: <cover.1779203863.git.daniel@makrotopia.org>
 <5e8391488f4dbf23133d16ceaf1b168b39304c97.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e8391488f4dbf23133d16ceaf1b168b39304c97.1779203863.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B90CB583C8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:39:29PM +0100, Daniel Golle wrote:
> +/* --- SerDes ethtool statistics --- */
> +
> +static const char mxl862xx_serdes_stats[][ETH_GSTRING_LEN] = {
> +	"serdes_tx_main",
> +	"serdes_tx_pre",
> +	"serdes_tx_post",
> +	"serdes_tx_iboost",
> +	"serdes_tx_vboost",
> +	"serdes_tx_vboost_en",
> +	"serdes_rx_att",
> +	"serdes_rx_vga1",
> +	"serdes_rx_vga2",
> +	"serdes_rx_ctle_boost",
> +	"serdes_rx_ctle_pole",
> +	"serdes_rx_dfe_tap1",
> +	"serdes_rx_dfe_bypass",
> +	"serdes_rx_adapt_mode",
> +	"serdes_rx_adapt_sel",
> +	"serdes_rx_signal",
> +	"serdes_pma_link",
> +	"serdes_link_fault",
> +	"serdes_in_reset",
> +};

Which of these are statistics counters, and which of _those_ are
Ethernet-specific (SerDes may be multiprotocol, also supporting PCIe
etc, and the info above is all protocol-agnostic)?

I'm trying to hint at the fact that ethtool is not the right interface
for presenting such information. Intuitively, I would suggest we need to
put head to head various SerDes designs and present to Vinod Koul a
netlink UAPI for monitoring purposes.

