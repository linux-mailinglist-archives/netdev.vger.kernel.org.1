Return-Path: <netdev+bounces-295736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0mjOHKWImpYagEAu9opvQ
	(envelope-from <netdev+bounces-295736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B3646D71
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=Ik9ET4at;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295736-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B6B9302EB67
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5143E4C81;
	Fri,  5 Jun 2026 09:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AB4BC017;
	Fri,  5 Jun 2026 09:11:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650715; cv=none; b=cGzIlGESDlr3fzijbB1jmpSeb1Ov9lvINKl7YYKEoT/vryv8xEQUymyTnDd06rXt11jNrl6Z3v50hoxCd31UbXYuC6Y8RDAGrBCR9OKR5zcUHXe+gamfSyvccIaRIcRLximEvgG0W9cLXzCsD8SaooU4w0jf60+/kF2dXb8ZQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650715; c=relaxed/simple;
	bh=MuGBut1FtJQzdAFLjx87BgB6LjFUv77fDZHP6Wq9/0k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O4TVyK5agBnOhP8xvoXGq56OSoxvmOu23rQh0aLmvU/54OHNCFj119Ur76Qx6kz6zgsbgrDUKMNytpM49jDUwCWWLD4ojs44Eb/epEpPZbB4EXus0xH9GpGHMcZhkIP3Oly2WBfQIHgKXrk/3aF0QlMWOO/YdxWXropQOR/fznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ik9ET4at; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EE7EA002F;
	Fri,  5 Jun 2026 11:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780650711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6hHGKFoipsvu3O3524CdwJVZxf1JZmWhoR13aqgMWMM=;
	b=Ik9ET4at6vndL44P3/i9Q/eTVu4//4RT4RE2lXlJEguSW2rtsY/vep5/xMS7RbZ8uS5kz6
	p9Q3V+CPgUeaESV1yprPmhj27OnvV+bU/xI2Uy8YhAb7CuoggqvX3pVzsSV/cu0CjwSOv5
	RL72i/P9zYR/8E1CFyZwQtaTQ8qUhBNDR2KDg26+GRN07SC9DUjLZxKPP4wj0R1qjZtDex
	SCk5ccjUb+0CQrj0zt+wlmMqbymzoVtaPgZromPyagrQuNuY9TWEg+BHP5Fceh9+lF3yoj
	nUIKiMzcwUfceCb/AAmbjfTUAhcDzU2RTRJRVXIJTLUl/N5BKOnF9/joxXjJBg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 11:11:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
In-Reply-To: <20260605074328.1800-5-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
Message-ID: <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295736-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:from_mime,tipi-net.de:dkim,realsil.com.cn:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E54B3646D71

Hi Javen

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove __pack, struct rtl8261x_fw_header and rtl8261x_fw_entry will 
> not pad
>  - reverse xmas tree for some definition
>  - add explanation on rtl_phy_write_mmd_bits()
> 
> Changes in v3:
>  - add struct rtl8261x_priv
> ---

> [...]

> +static int rtl8261x_config_init(struct phy_device *phydev)
> +{
> +	struct rtl8261x_priv *priv = phydev->priv;
> +	int ret = 0;
> +
> +	if (priv->fw_name && !priv->fw_loaded) {
> +		ret = rtl8261x_fw_load(phydev);
> +		if (ret) {
> +			phydev_err(phydev, "Firmware loading failed: %d\n", ret);
> +			return ret;
> +		}
> +	}

fw_loaded loads once per lifetime, phy_init_hw() does soft_reset before 
config_init.
So after a reset (e.g. resume), aren't the patches gone and never 
re-applied?
en8811h for example re-runs every config_init - but just guessing as I 
don't know
the internals of your fw.

> [...]

Thanks,
Nicolai

