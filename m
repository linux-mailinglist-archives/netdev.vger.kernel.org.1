Return-Path: <netdev+bounces-296740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DV/tAZA4J2rmtQIAu9opvQ
	(envelope-from <netdev+bounces-296740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52965ABAA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:47:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qp7wFb2A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A21B43027732
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293C3769E7;
	Mon,  8 Jun 2026 21:47:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3B223DFF;
	Mon,  8 Jun 2026 21:47:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955256; cv=none; b=ktSMkLUhfuxdG0gGAGHLrjHPDz/8bfIK+Ee+cyX9/5Zs/XAbkHCO4vgoF6HJfxIK5DFi9lMZRMDvzYERAQueJr34kUjswnnv5bDPqmeMzYQAAT4av2lirk2cgPg6UGDtKfFt7j3VtJn56rJoB4fzi6injOFzOm/ejhigDSU8pzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955256; c=relaxed/simple;
	bh=ZyRpuVX16kKMoS1mAKp3W3ccdVbgqYPYlye8Jzwnp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZS18bKTIR7aTsaYmpjZBiDGgKC9a9JdmErNkuSfvzdi7/KCfGmwUS6G0KcCt5AY4dLmrro8tWfSEs/shWcJR87NiBkmVC3cD6pTKF305g0P7V3yxx2+G1UjeWdNrvOZHu98OBk912I4ARJPd13u/Z9xM08K6WESkH+i2CECbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp7wFb2A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A41F00893;
	Mon,  8 Jun 2026 21:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780955255;
	bh=2Ws7SCqGd9yTZpOF0W/PLej9DkeY+2Y3ZdgH5+m9bDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qp7wFb2AeUvKYTZSkHQwcPPUhoxifCDu1syESAtMKWhWRYyhWPNEd+xoLC9UAAYhX
	 SHfsUcNl8cFfZcYWDM11TeABywIvCZ3rYuq+erX7lLay1Gv8H0sSdKvBcfr/F/OWgO
	 TXT6uIHtMzD9E5rdClswYXAm3XMQB6wyWILcGmNDSOrI7ojIxiyIKO9qJiYSZnw4CY
	 X8gSSCbiXkB/3ZfdMWg0E26elrVjkxvRDJYeqWRlywhfx9e4P/dKfCTHEHdo/SQfts
	 4JYwDFs8ULEa2F8lU1gF9g1sWHzVeKfpgvGsfzfTbXgmxZvIxHyu5kmBEjeEcOGZc1
	 h/XiEIu8C5qnA==
Date: Mon, 8 Jun 2026 14:47:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/7] r8169: add support for new interrupt
 mapping
Message-ID: <20260608144734.5293f6e2@kernel.org>
In-Reply-To: <20260604102733.1582-4-javen_xu@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
	<20260604102733.1582-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296740-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A52965ABAA

On Thu, 4 Jun 2026 18:27:29 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

drivers/net/ethernet/realtek/r8169_main.c:5168:6: warning: variable 'tx_done' set but not used [-Wunused-but-set-variable]
 5168 |         int tx_done;
      |             ^
-- 
pw-bot: cr

