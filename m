Return-Path: <netdev+bounces-256325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMuyLEwMgmnVOgMAu9opvQ
	(envelope-from <netdev+bounces-256325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4EDADAD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B8C30EFCFB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23503ACA78;
	Tue,  3 Feb 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYezj5nE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D33ACA74
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130305; cv=none; b=WrEz9LCqawXy1Fl1togcrndYcK69F4MHFsnJmQ8Dasyzh0qHognsnCTF9E+JxgyGuBC6Be90Zpc4Ax7c+PgDt3yOE8Mu0p6EKorhdloW7e8NG3slpbhx+4o4K7JOwrFcRCZ89pvtBKjSyZ3TSEQsBz4htJSu8mp7/AZ/5Y5fJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130305; c=relaxed/simple;
	bh=ucMcN0j4Ae1voA0dJmdcb6b3d9m2avLloAVQpB0Ygvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ika1Al3jAMnyYA3AusGjnBoN+AnMzLNDFJGjD5fTABKjVxemGiZRCqxk0VCcbX+qm3xG+CbrEhhTgSwOXIDi9AFxbwULZT1ylyPUn3Me9Gnc3j1tgJYajMjdOJepYRFVJSprdw3jQ50RFyi5NC+wq4s8ILN/+NL6/3Fzve/5cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYezj5nE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso25859115e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770130302; x=1770735102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVDbMP2h4x/mUb6G2s8x3K2KoBv6D/1Du/nOa/GGM5s=;
        b=pYezj5nEdHQ+wv6/8H7xEsT0QwqogATqxZDHieEP8yEpdwIqGcWg2RQV74cdX8N1mr
         EoDPI8qdqohDZ1nq6y2hHsUeOj2O+PV/xRIpLKZt1HUEsN3gg2QYwY3fofseiMg9tCnK
         EyirfrbKiaUog0bD5csvMI7bhLxF2IFol5jRfBpDBsIJaxk452zbFGwm3+5mzA5ltV5g
         xHNxfknxsM9F1RcThoeRHaOxg106BFGJhgFFpiRDqTC8rpVt2lyuyRjPjSg5jpPkAhY5
         9nSVApGjLvtSyIg0FM6q2FxR8FiqqyHfjDvqNJXDENNsGT/HxVdIi0Kp10D+DpuLqaiJ
         NhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130302; x=1770735102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVDbMP2h4x/mUb6G2s8x3K2KoBv6D/1Du/nOa/GGM5s=;
        b=pw6xtP3V8QhLEivI3ROAuOr2BxQsSCzsfsvea7C+7qiufMmbxkQ+ZAcMzy/+Uptyyx
         LVM9Dss8ZpAI8ps5tG1tNxYma+4F6k4PmLoSdK6A2X0jfaBBP3rH1t3OZhe/IWYQOka4
         lzNUD3XkV9ePLH7EytQMoRmxjCn66CkSAMfXW/TqYV+E4KieP4p0/RCfm+UIOvzZX1Cc
         M+l46Fi4BRnvyb4C3qBUlBFWb9HI7feKIzRFEyQOqSJLy2JjmaPCEY+Oqv7rVrczBZi6
         yoYD58xS5lc2Hzv009Qo+c/DK8nEUoe1+IBBVTXHpRGNfoJMvRRiIPqNEllPuaSWDWLy
         RY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzuctT6wepmAJNN6kzLjhbTzHd9pcjFLD7nnDhI6DVPUtTE2NKPDqLz19/QPDsEFXn+b4hZPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJu5mIcy/g/YnVR2tUUWIPqlwea9b9YEuxq4EYXpzFikdtUKSh
	Z2x4sPUBGluPQvclSkhV0MLkGznGedHBfiUwSnwP1yMX2gJ2VAJaMVE2lRuGhqaRNEY=
X-Gm-Gg: AZuq6aLZ0Ufn/+WHzPyjn6J7to6iOr+n0DDLcfajA04jyqM5efC70OO6O8X3ezQkuFV
	ctaaXdWmlSp0BqKf6+Ewu++qKHmZi82QquSlwvzUeFjHUzLh08sLc2sB0BNTK+iVUgmHpWmWhWc
	fkpe+MhUbd+yL0jVCjnd4z2tQQLWirG9gZKOlk5USU6DcTmr9OnAaheo33q+AI9L+pWHzxDs+Mo
	ib5verw0O6O02mZ8ZH/ZIfuq0BkWbY2JX1FQyIXMQWYsDPhnigpdAdlla5sDFiU7Har7tZFz0jv
	trRdZhQm9wz3lUuiOZ9vP/fZD9a7DomnWfaqgJz+J/fExvhUJRGPzY3i2vViD4p0FBWlj6HBEBc
	qCUyVfrh1aGXM4T4gGUGrKF15H8K7ltoaGltJugZRPxDFoRWqC75Xu5My8SW6uGg2vyr0t+purZ
	weTFBzwWj8matWmbl0
X-Received: by 2002:a05:600c:859b:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-482df17bd2cmr154388865e9.20.1770130302262;
        Tue, 03 Feb 2026 06:51:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dffd47c2sm121508595e9.0.2026.02.03.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:51:41 -0800 (PST)
Date: Tue, 3 Feb 2026 17:51:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linaro-s32@linaro.org
Subject: Re: [PATCH v6 0/3] s32g: Use a syscon for GPR
Message-ID: <aYILejxAJef9F8bn@stanley.mountain>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,nxp.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,pengutronix.de,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 17C4EDADAD
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:18:54PM +0100, Paolo Abeni wrote:
> On 1/30/26 2:19 PM, Dan Carpenter wrote:
> > 
> > Dan Carpenter (3):
> >   net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
> >   dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
> >   dts: s32g: Add GPR syscon region
> 
> It looks like patch 3/3 depends on 1/3 but it should land in a different
> tree, as patches 1 && 2 looks suitable for 'net-next' and 3/3 should
> probably go via the arm/freescale tree.

Yep.  The driver needs to be updated first before the device tree.
(The new driver is compatible with old device trees, of course).

> 
> We either need explicit ack from freescale maintainers or this should be
> split across subtrees, right?
> 

regards,
dan carpenter

