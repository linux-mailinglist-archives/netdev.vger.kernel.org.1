Return-Path: <netdev+bounces-256031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPuhGdc5gWmUEwMAu9opvQ
	(envelope-from <netdev+bounces-256031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 00:57:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3578D2C89
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7533019834
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33D3612D8;
	Mon,  2 Feb 2026 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OksZrj4O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108F35E544;
	Mon,  2 Feb 2026 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076442; cv=none; b=cGSflFdVzLmx+UvuNSQxUX3DmUlnoFnNNvl8Al3mEuVEEuBEvIWKI5hYXp6UgqedtnvlVi8qfhSzbbdBdeNwcqM9r5O9xEiERfTdvYK+JnkUfn6kevXEx6XntI3hW57obduhUxpWClrzvKTYDimItgd9aNkwVTZ4K6xeAdc4rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076442; c=relaxed/simple;
	bh=azyRiz3LlfiXbz8gKlNj5i+kZN/7hbDKSy0h0BMxefw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dX8EAtJEGWL7MQDtwebS+Be7wmEfFGBWCxUOIzAcBAZJtwWLAaMTpW017bPRG3c8ojvUDUrSA/4nrYOFRractQq+Xc8tXKCuMgJdLuXAuVGrrREp8t/WWwrPu4g77RyazH6eL4Zll1hPfOT0QG4HnHtFaUiXj4M+AK7g5RP2Fow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OksZrj4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CB8C116C6;
	Mon,  2 Feb 2026 23:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770076441;
	bh=azyRiz3LlfiXbz8gKlNj5i+kZN/7hbDKSy0h0BMxefw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OksZrj4OYeE1GR0H8xBwOcDserCfD2EnoWSuNcXVsj5ptsI+NccMernr+B99aKvoe
	 Q3kzRAOTQ9Y1VarMd87ctWMtq1/jhk2/e0c+a7YuUlhx6KO19jIX2HyA0XSOZtdGfe
	 XVO38h2uH4lx2sLcS0YaYstMCN2TEGUSB8YkPCasbvx3DxtvcbthCVgvHBWYEV9biw
	 D9NwjmFXAfFCqjtAMzg5BLcb+xlaPHSFfnwoKpIO3hifLan8t7fEv7UGoAJONxa9AK
	 uLoJReGgrHWBR6dYzD328BIEhbIfez7zWfa7DUpCL5tXh5hqSAwMfR2lJtjt6bwc7z
	 EHLOem5QNRPQA==
Date: Mon, 2 Feb 2026 15:54:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125cp
Message-ID: <20260202155400.161df253@kernel.org>
In-Reply-To: <20260202105828.54-1-javen_xu@realsil.com.cn>
References: <20260202105828.54-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256031-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3578D2C89
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 18:58:28 +0800 javen wrote:
> +static void rtl8125cp_hw_phy_config(struct rtl8169_private *tp,
> +				   struct phy_device *phydev)

Please run checkpatch on your patches:

CHECK: Alignment should match open parenthesis
#76: FILE: drivers/net/ethernet/realtek/r8169_phy_config.c:1106:
+static void rtl8125cp_hw_phy_config(struct rtl8169_private *tp,
+				   struct phy_device *phydev)
-- 
pw-bot: cr

