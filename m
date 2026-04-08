Return-Path: <netdev+bounces-276224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ32ILip1Wlf8gcAu9opvQ
	(envelope-from <netdev+bounces-276224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:04:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F93B5D74
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EFA43003490
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DF33F5A9;
	Wed,  8 Apr 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrTi5O32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FCCA45;
	Wed,  8 Apr 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610275; cv=none; b=kbWTECy0rorJkR6mWlINzR8zBgRDlry32JFOyuBj5E5LXu0YsKgX0qJOZGpCYCgvB/8kMj2h4Pduzglx7ANIuPyhgqL5qrNLvIkOS33m0pb8Af8Y0I+zXx7c16mz22G8sC2jNYxwEM7kh5WxrF3qRl+qX/Ou142jJ/dDNYDQqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610275; c=relaxed/simple;
	bh=Eg8v+sP3X1yp5UZjJGBpsFtcvbicVDyA9+mXPo5mCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlg+HCXSy5lSpPXKeasNLQWOZZ46GeIb9qgWdJgYXM1C6QM2l06TEmU84hRZw7RbktAqq+axNZwNJeXgM22vnGeJDHaPGETInoAiUBaSt3maGmm2Gw1OEXMvWXuD5WwEBQkm7eBE830mvfAUY0FrsWOaBMd1TWa8wtDH4trOoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrTi5O32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87EEC116C6;
	Wed,  8 Apr 2026 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610274;
	bh=Eg8v+sP3X1yp5UZjJGBpsFtcvbicVDyA9+mXPo5mCrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YrTi5O32IRI3mQtgu3DFbhjTBpgTKGtW7aNY2EhBkqZdOdi1zt86GMBEOLA/pCAeT
	 zYA5VuUmHLmKImYoCimMfEa8/H8AotQHfc4zukAYq02UnJuhxLHe/iiKn2VRXnx+LG
	 DvJ+n4sANQHR4hy3eouu67e0SZ5dLKg1jaxTi1O2K7qI+OCwbA5QrhZbcXubaYQF4F
	 rBPVDNH91pcj0s1X1cNqXGFvbBtTTBxA+glsfjqQP42krbNoBeptTDcZAP+ExNFSbY
	 Zy3By40qMwOZWNXQHMZZsBLcjBGSmuuhzDKTHFx4Auu1lHkJtpyFZhZQSbaZT6uQwj
	 gVY+WXFYFrrvg==
Date: Tue, 7 Apr 2026 18:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Message-ID: <20260407180432.102073cf@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
	<20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276224-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[broadcom.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 868F93B5D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote:
> > +	if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
> > +		new_config.crypt_offset =
> > +			nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);  
> 
> PSP defines a 6-bit field in 4 octet units. Does this need bounds checking?

More fundamentally, were we to support this -- is it a device property
or an assoc property? 

