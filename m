Return-Path: <netdev+bounces-294515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9dx9F3uPH2rPnAAAu9opvQ
	(envelope-from <netdev+bounces-294515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:20:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD8633A00
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:20:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Dtp/jnQj";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294515-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294515-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA40304D92E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1A3D3D07;
	Wed,  3 Jun 2026 02:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF233949;
	Wed,  3 Jun 2026 02:20:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453238; cv=none; b=hMq6p7NylXUW7/jzlAU5pOKBVJQjZJQY99ijkgAi5BQMirFR6Yi0NTv8bIru1SRd6PTL1Vx1ih8QsXT4HZJuWi7VvvI3YzJs3x2rEd2r4X0kiF8sEFXprYXVzXP1eYAlsQcS7EQGaBsbwIwTHTApO/6us5gkBQRZmiCN0onlyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453238; c=relaxed/simple;
	bh=M0icSYUpwjidM91a9CSaBCLnufhdPEAGwxRPFHGLfiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS8A8uAZKuDaJU9zy6CW93L37eT3Et0SF369rEbPpfgJWLl/a+dlYL2zHiBNJg08SXZ5+iN0sjNHQ41GWS5YB6ZzySpSAXumIJtzMxPIZhu5ot8GvrsHamDmAEVEZaFG8VHUMf8EgiBidG1X6CbBJM3Sf7OoKuEIRsqaeQuDp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtp/jnQj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2381F00893;
	Wed,  3 Jun 2026 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453237;
	bh=M0icSYUpwjidM91a9CSaBCLnufhdPEAGwxRPFHGLfiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dtp/jnQjLfISW5AeF6ugLMKcDnl1cN6dIeAAR493UwY7/EkiyxqVRN9CK6vqFd0ck
	 QxNxZ9EMEyJlyUiwzuTDy+GqVundBap7i3o6N6dxVb1Hl1tBAJawSOuEtnOkLOrLbw
	 qaUHp+bYH48EMzYuNvhUbRJ5uxPavglTOsPbyF67nhhBhBPa8KiGNfJseAuo/NUkZG
	 klVmPnVvgvNND4Vm5mdAPKs0D1xICKktO781r2sfBjDMBlMErQB/K1dfunY65317R3
	 QqNizdA408DBoUnryzpa6mUkutnxX0uITxFWGY2Kdd7314Q6IWXMPIClivSYUhk2dw
	 t76gxwoljQmdw==
Date: Tue, 2 Jun 2026 19:20:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: Improve Tx timer arm logic further
Message-ID: <20260602192036.7cc25ae8@kernel.org>
In-Reply-To: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-294515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5CD8633A00

On Thu, 28 May 2026 23:46:59 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> There is no race concern: hrtimer_start() is internally serialized and
> safe to call on an active timer. In the event of a race between
> hrtimer_active() and hrtimer_start(), the worst case is calling
> hrtimer_start() on an already-active timer, which is identical to the
> pre-patch behaviour.

I mean.. I wouldn't say that this is not racy. But I think you're not
making it much worse than it already was :S

Could you experiment with deleting all this local driver logic and just
relying on NAPI's built-in defer IRQ mechanism?

