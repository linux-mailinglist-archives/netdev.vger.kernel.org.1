Return-Path: <netdev+bounces-252995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML59OYIMdGlV1wAAu9opvQ
	(envelope-from <netdev+bounces-252995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:04:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FC7B94E
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460653014973
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA83C0C;
	Sat, 24 Jan 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQrwhNlr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F138D
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213056; cv=none; b=tyXkdSGjUTIidtkWb17BdjOtILtW0uH7AIur9hor+6m+2QyB9Qp4qHiuPKbGCygXdSO6+FwNzIfjKSPdXrpW6crQ/rYGW8c8C6XbSfgGwzlcmHBDOHE5etDpwSkIjcmhjrfp7JvzDRbDsmBgpOPW9gSpF2L9O8DBRBUH5bqVAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213056; c=relaxed/simple;
	bh=zdkJCU+YqALmJbm7uee+ZMbnxI+rEjkN0g1hAPbe2Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZbZSKV8j70qzhJ2J14lCmlwaGnlto0bh9NlX/MnS+vc2PlHcohfmf8ULyS8lcE+z1V0YZfZyh2p1ugXZNCfUF6ZWr+GOqM5G+IEsVFFMf5wd5UlHGIihkobuYirAAeiR/TKPbTNwhbRgFA8xOnUIoOtmAPyJ9BtcqrP4PmjOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQrwhNlr; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4359309bf32so358638f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769213053; x=1769817853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6r2QurZAQWCjh0fiFFVfKXSGYPjUAsKdH07r9CUR7DA=;
        b=AQrwhNlraQkih5w2PwJzErstyIV3VCLx0xwdcDN/ZzhIp4Kx0Q75zkpDuEgEFv3yxo
         mYgcfVO8G4Riap+0LYeUG+U7Niy8P/S5ec2C07LXTO14GM+JWEpm4dalbUXQipRlP3c8
         Y4PsFtBcSubHXcGVTWJDJFDq1rsaox3vrQyBDinXRQWrr8BewQYx3fPtCS7aTgB3pzmd
         dk0ifgKkjfZ01OikJ9gHL6pCfnOE4Wl2qWL5eZhCxKK7QNk81QYxWwxEkjAWM8820Pjv
         hA5SntkmUFpj4J76AhIsGwn6NscrNRtef/9kW4GQHhxCbf4Zg3Y8rVukIMqMEA6u6QsQ
         iWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213053; x=1769817853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r2QurZAQWCjh0fiFFVfKXSGYPjUAsKdH07r9CUR7DA=;
        b=nbcb33PsubmcBi5Gt7g9A/qfW7XSIFUkU+di5bURoPi7eVLwtLa0pKG/cmdpKsrEne
         qdOEI6R5MQxHE1JWJ7XpLAMBZhbCGMUB+0IsqbOQ0fjeeea5yudka8dRQ6GpnVVqt4OQ
         58/JUdWwtJO2BiU02tOeN61+UW/3DB8tOFP6HwDPUzn82BHHnSEUQVZG6CnpAQ4HNFde
         RbdFO0mn75J9RlIlDo2KOplVmBlsGVNlUwBIsf0z0HsMsKysIA7bK3IpbZeW2te5wlJJ
         JFZAb47cZfQedteKL9ovipbg/FN2p5Vw9LGOvev27nnW3unHRS9dWuszpZMqKSO/m/m9
         ZY7w==
X-Forwarded-Encrypted: i=1; AJvYcCUQJ0Kx2nUFGCTrDsCG8wxCd9Uq/hCHCtkkFbZkTkON9vw8xihxIrjUElPVaPq/Y0tKSfMUQqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMsOPRNDBUb9gDXby01374NxRJTHsAL9zdgsJpa1s5nXhIupA
	zWPr246coXWFiHfQUmllpafnrS+d5vkNaAnuqe+xpnI1sHJwXfXF7d2l
X-Gm-Gg: AZuq6aKiiKfOWW92I2j8n5ibLrD2yjpob87v191RlG7YIQL24Ra8bHkAb8zB0oB8s+a
	4mRsD+2w2xm0ZFDCz2vjvZmZwgdUG6Bq4NgeRgUcJoQ+NSXUQyB1JAN8m5n40v6otYpgNXEGldl
	DYzo/HEYImzBR4ZzNKJlZ0s+63NJjX2dmmgPFjAbbDulDW0HqBN+15htZsBNxg4fcD17uJufDXF
	/gOyXWoNnmujuG4sFtobJb38MItL4NslJd+dAMcT+WQ0qenXi0povo2WbrRP63DykhQxhqh6/lo
	q0KoVzRjeWyqHKuf9M5OIFfbjY2e2tQDRgWHefzIKKdfvdgx0bkD8CzIGgYkUEKBwKhSpiy6Jc3
	JsNZtfHGmGuOxr2BRpERIErolAIyfmMpwKgp5nXeNNFK+tIHsfIr+i9EfQhXxTbDaSRXYe3seDW
	c3fg==
X-Received: by 2002:a05:600c:3b29:b0:47a:8bfa:bd5 with SMTP id 5b1f17b1804b1-480541f9e3cmr11110495e9.8.1769213052988;
        Fri, 23 Jan 2026 16:04:12 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:1430:8b48:2d45:6c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e716b6sm10359890f8f.27.2026.01.23.16.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 16:04:12 -0800 (PST)
Date: Sat, 24 Jan 2026 02:04:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: SerDes, PCS, BASE-X, and
 inband goodies
Message-ID: <20260124000409.36nsxlvkde4zpddk@skbuf>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <aXNX1oi7nWLcPK28@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNX1oi7nWLcPK28@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252995-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 934FC7B94E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:13:26AM +0000, Russell King (Oracle) wrote:
> According to patchwork, this doesn't apply to net-next. That's odd,
> it was generated on last night's net next, and although there has been
> further work, it rebases cleanly on top of this morning's. How can
> these changes:
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   |  6 +++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> which happened in net-next overnight result in this change in patch 1:
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> failing to apply?
> 
> No, patchwork is clearly wrong.

Conflicts with commit dc6597fab3e3 ("net: stmmac: dwmac-imx: keep
preamble before sfd on i.MX8MP"), merged in the meantime.

In include/linux/stmmac.h (your commit "net: stmmac: add stmmac core
serdes support" adds a "struct phy;" line, but that other commit
modifies the context by inserting:

#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD	BIT(14)

(the last stmmac flag in your context, at patch generation time, was:
#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
)

