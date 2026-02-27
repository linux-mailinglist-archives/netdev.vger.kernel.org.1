Return-Path: <netdev+bounces-261904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHzZNwm7oWlhwAQAu9opvQ
	(envelope-from <netdev+bounces-261904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:40:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E71BA03E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D1E300FEEA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C40329E60;
	Fri, 27 Feb 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Iw3hMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802819C566
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206747; cv=none; b=kqaUKvtagS/VSCA+a2B4Cwe3nzMCZAXn/8ITyjIgvK1jCrTeazAXoZGDOAyXmQWr/ISK9pADV81y1QC6r+wEGx4xIAjVXK+HJP5Li3gWpCKLPGL5Dd1b871NSz7vO1WF1FykXWtD0frOAN7pcJFvDwSg+OPWBoAyQc0BrPXXlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206747; c=relaxed/simple;
	bh=yWxUrySJ5/bdRJ/H5b7sZiuXY9H8q9AT6tSFen/PFEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxxpg1dwGZatZ0WsY+QQSEa0YstdstwNaQ5Ots/UK9NbstgUiRri3b09vKcYmouioAbQm/Eu429eLchuWi6xCvSTkSS+2GtkPzu1bXq3QOi+52A3vz402Ue9FAxY8jnh2on257WZu1GFPil5JPshAs4UNTOBBRTjiKwqgBaWHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Iw3hMV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483ad568d68so3381045e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206745; x=1772811545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAkEyJJOJ/JdV7CNjPcqTwZJK7pvth1XKt8oYwJ3QEI=;
        b=T6Iw3hMVIy03vsyeeGUHAxzfPLV17yeuzaMh1ZHa0ipJw/LPCMEYuKGvKdN0Q75dkU
         M+DamsAxa+2FaZvWsNoO0ZpiTzS3rBYxgRaZaAYUeiT7z4eVFLu8vD6ToI+q27Yv31H8
         JsQ7CicT44JLnMlq3nByxDiCNapM3qpfZ+Kf3NjxUS2twfBksuX5YwUgeRSkp5wH807h
         GwfHjeCbOyGP8mI5f/SnmNqfBInuizXErL81O4xAEsSBlYiBNSbsKw1i+P6gL0Vyckom
         gzZZuM14vRFm9MAdl0etXF2+YRRNjOk4+0Vi0GLMq9//kCrlcqwT/PEtcibjUcsZ8UGR
         Xt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206745; x=1772811545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAkEyJJOJ/JdV7CNjPcqTwZJK7pvth1XKt8oYwJ3QEI=;
        b=Vh7JfFS9WBG9zKsu0SQ843N9VjxbN5dWNgdSKMzRniE61FSx81hgaaSLtfVI8GpME9
         vvx93TuDQYXZxRun763pwU9XJRuYGTS8q89TIx49Ptiy6LmAXPc/UTGhHWSgddjlQEIa
         W8z3SOsjrrLJvlKpf0zfEgZycisvzlYicWQuH435b7+r0g1Ckab+KSqH9PrIKcc/8Bt7
         u54Dul60Zv5XdirBcfeZsldIPogSlXomTcdGN20+kMdEnTFdRLmtZaEaH6S4ePYAsCX8
         HNLlFnifgQ0wRheXrOMMSA6HUVP5ZEChv38wPQKu7d0dAKR0RCZoX+ceBDuTM0bNFfzF
         tCTg==
X-Forwarded-Encrypted: i=1; AJvYcCW0k9fwJQO5KykKwthnzNi5zCtcz5w38gyqe6qxEK4AK3okfk4lw7ZZ4oCYot4MWlcih0l8Mwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0z8TDrulyU8BGYrtWXxtCKZvhFJnTUwbGNjZJyEGWuO6zsBX
	jUoPz7BwojyTk4ERB/UVwevGLXsCEyKlsW2YRn1by5HIYBxyZm/aDUhY
X-Gm-Gg: ATEYQzyQPQqAheBhJo8A5iJK7npKj2MZEBRPLSIBU6e3mwU8nuLwZI4E2TBUIWy10ij
	t7wXvTDFtc+LM8XQ3XiHFFQGJgi+9nwcczE3PBk02izu171Dln0GAuZ1NgWxdStCF9bulrDd2lH
	2T5Plr/38MUqPWoOdHi7wkpOs2VJIP8y2XKbsDKqk4XW3qsZi7j5NsTaIcci2aZ8JLm787jvIVv
	aHH/Myh5EVfrI9uKiLAz7Ep0oDXPaN9MpfXMGMfUV2fO7QLgE/TzLeiQoOxQLcJZnPix0Tqp9Om
	ZuQIv8uNMDPH1/JF+lH7a0N7XW68UV2BHGeAwadchKKIN5wkacLyhN7JZBrS/RhJKNPWLq7lXyr
	BCdCRj2hv3gKFKBkPpL5MEC8zlTW89Pe9PS/FCdkXeeAYJ1hkS9xBSu3BSP6BULuNXwLNJC9vFz
	q/LXN1gSFi5DQNzA==
X-Received: by 2002:a05:600c:46c4:b0:480:6612:253 with SMTP id 5b1f17b1804b1-483c9c27367mr29499615e9.3.1772206744631;
        Fri, 27 Feb 2026 07:39:04 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:ac95:d4c:390e:fb0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9566sm97450615e9.3.2026.02.27.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:39:03 -0800 (PST)
Date: Fri, 27 Feb 2026 17:39:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RESEND2 net-next 4/8] phy: qcom-sgmii-eth: remove
 .set_speed() implementation
Message-ID: <20260227153901.qor4rtvtxur2zywh@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <E1vvkUD-0000000AuPE-1l06@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvkUD-0000000AuPE-1l06@rmk-PC.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-261904-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 395E71BA03E
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:09:37PM +0000, Russell King (Oracle) wrote:
> Now that the qcom-ethqos driver has migrated to use phy_set_mode_ext()
> rather than phy_set_speed() to configure the SerDes, the support for
> phy_set_speed() is now obsolete. Remove support for this method.
> 
> Using the MAC speed for the SerDes is never correct due to the PCS
> encoding. For SGMII and 2500BASE-X, the PCS uses 8B10B encoding, and
> so:
> 
>   MAC rate * PCS output bits / PCS input bits = SerDes rate
>    1000M   *       10        /       8        = 1250M
>    2500M   *       10        /       8        = 3125M
> 
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

