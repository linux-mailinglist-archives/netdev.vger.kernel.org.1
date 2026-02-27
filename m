Return-Path: <netdev+bounces-261905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH2JLEW7oWlhwAQAu9opvQ
	(envelope-from <netdev+bounces-261905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:41:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE881BA0DA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA9ED30A4571
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0613F23D8;
	Fri, 27 Feb 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KguO3zMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100443C041
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206833; cv=none; b=NsywhAFFhr4izfnQTONgtABvZDTI6k5Jsm+lMq0MQn2+d8LaUFW/PDfkfkLu+1r4F7p/GA9zIDh4AIe1y5WUMWXwqxE3P4G4XQQJl231WSDtpGujaCMudUeMRnstHyPaKsKolE8+Z7ZdfvoaV8aRrQn3shkp+Km6GSkIosz6txU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206833; c=relaxed/simple;
	bh=B9cYTz3/Azcv65f/loLdlB5667RSkLaa+xjI8VMfNhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmIPsIgmmbFXBKPymMTKo1L250hzP1SttENkkUo6n6c69j1QIbw6ttv7kF1N2WPKYwipaGj+9Gk/VCc8vKI8hNIawDIQICZDt6jODngNwwe6zwz4pL/f2kk7GLUWIkENaIHfq2Z2bjD42lIYK0cUak7Br+ghOcqQI0BQL+wbsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KguO3zMB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836d541968so2341445e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206830; x=1772811630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6eW6Ffiaz+a/K4TbWo3MIPEdUxUEHjHOWmvCKtzuvO0=;
        b=KguO3zMB8kkd4uOFjbr3v04KGhhDp36BOHTIclrK1xkhSYlEtiEvT13Eaozu0j4ptQ
         GwnNdbhSYldmEWMMevRS60ipTM0BSSTpivU1MescDGX4+hGsF3Y6EyMDNInH+77Gavuq
         XZTmxLOywwrycT8bVMXKy0txewx7V+nsz9Hl5oLlZWVonKKT/8ubw1Ha2CR2lqbeVmGS
         3FLd54sX9l+GnA+DEKf3dJtcgBLH0nXJ3Obl1dTwQ6h1HQfCJLnbk54C7XEZOVyGGusc
         A7fgKgDuk9fL/TQm+MtVO4sA9FxN4H+mwma/GvaUXd3oOFwjmGYiRd+v9P1GqtwHG07y
         iTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206830; x=1772811630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eW6Ffiaz+a/K4TbWo3MIPEdUxUEHjHOWmvCKtzuvO0=;
        b=QzAhoNW1JciQyCR9ZqcKW437SgUEhg4WHmB6n2AC4A3ZimCC7P7XXup2SzBOcotwGi
         COcLAZp66AD4EMLeYnSJfMc0FdQ1W7ocuu5EC0pFHK2+MUB1Yw5od2odvRe9sXxSFYuP
         MBKCVSH86RYXkrmZ+iSkeAJbGdQFvDm+qkFuHDODzQ/nctLI2ajc+LwdAvHDSlqB+F4a
         eFaBgSs5PfhhQ5vlgEUVErhzQceOUjc0yrR98NbMGbGYCGTobyI+2yQ9szAiX9bsXVZg
         wfAmyDkUa1kV/dYJhmj4mM4FTrOCpDBNnQ1cxh9rIhSj1sIeCktJOJ8yHz4FOYPA+um3
         ft2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrp73ESKM+tForoCwJAe6ifOr8MXGsve9iTKaVZn8Yw49jjgZ5WShjCOw6AUt7CbNrsKYzrU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5wEmxDi97LDap7YUbVNWfs7a3hb8GJhALaw8j628ieRv/i+D
	9pgnCecBFYHu/98/lF4gHYPgY6YW1SaaRcdB76Ews55GAsdySMBzfb6M
X-Gm-Gg: ATEYQzyac4vHnSgXrLtBaz6HDr5bddr1iUVVdBMQrgiui7MKCEzKGi3Rg9vGJEeJixa
	ZywAzJoH0CGDVyYQSuT+bepvmDYuY/UOO3MyHT4+mnUEu7Xf/IZBhkVWrlwnxpg2+XkJrzpzpcE
	VV2UpGgImnGrSkTBK3rNpnUkZc1b1CzSDzw23boMmTGTgReHAsgX0XLf2dQ443nXcCGXkx3PaiH
	q2N6EUgMliN5ioha/FapHPVn6sJLqqPqJXHtXr0sGCqntSYaCs9xc1Kq7wq70lxi0RV1jDEMLoX
	DOhGBOjMiJAaWagMHgQ6Y/hgHcyCIiU+89VCVs+/TsCFfEwZTa9DI/agpzu/WWYwEwDixPerANS
	/5bOtVaVru7PNVEA2KHQvjlet4iUsgzVWUcqgL6drE/iF1XvIdol/WsRssXAYjWDOcm0QS9cMiH
	geD7tmWUs52Re50g==
X-Received: by 2002:a05:600c:350e:b0:483:79af:ca1e with SMTP id 5b1f17b1804b1-483c9be0523mr30417725e9.5.1772206830140;
        Fri, 27 Feb 2026 07:40:30 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:ac95:d4c:390e:fb0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf016sm101582255e9.5.2026.02.27.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:40:29 -0800 (PST)
Date: Fri, 27 Feb 2026 17:40:26 +0200
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
Subject: Re: [PATCH RESEND2 net-next 5/8] phy: qcom-sgmii-eth: use PHY
 interface mode for SerDes settings
Message-ID: <20260227154026.dx364j5scae4epqw@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <E1vvkUI-0000000AuPK-2IBa@rmk-PC.armlinux.org.uk>
 <E1vvkUI-0000000AuPK-2IBa@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvkUI-0000000AuPK-2IBa@rmk-PC.armlinux.org.uk>
 <E1vvkUI-0000000AuPK-2IBa@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261905-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 0CE881BA0DA
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:09:42PM +0000, Russell King (Oracle) wrote:
> As established in the previous commit, using SPEED_1000 and SPEED_2500
> does not make sense for a SerDes due to the PCS encoding that is used
> over the SerDes link, which inflates the data rate at the SerDes. Thus,
> the use of these constants in a SerDes driver is incorrect.
> 
> Since qcom-sgmii-eth no longer implements phy_set_speed(), but instead
> uses the PHY interface mode passed via the .set_mode() method, convert
> the driver to use the PHY interface mode internally to decide whether
> to configure the SerDes for 1.25Gbps or 3.125Gbps mode.
> 
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

