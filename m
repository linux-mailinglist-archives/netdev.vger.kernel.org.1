Return-Path: <netdev+bounces-276225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEhAIduq1Wm28gcAu9opvQ
	(envelope-from <netdev+bounces-276225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:09:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 911113B5DC1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E2D83013C4E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B533E358;
	Wed,  8 Apr 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvWfTYNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FD2D0C97;
	Wed,  8 Apr 2026 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610570; cv=none; b=lJSj1T/agVmxBGgwAmGfovmpwtuCOwixrVTMGCShf06Z6EwjW5IISrdlGPOlfeNmp3GuxX65hOMDDfOHO+TdNecuP/BFR8TaMSYgobXt9vJUbrFGgGyRE1bXVkpDpyem5x035/qcxxMvhUZq06wP5qSZ15EBbg9kxO2XfyJHjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610570; c=relaxed/simple;
	bh=IwVbSrMv4emx/utx9wlkXpivLxjdmCAf1nYLpqxww5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbDFtq8RaGcqonBUMtitMTGizcjsoLFaWtwQEizV6tyf5VLSLNodid+d2zl79wrL0Msu3XtKhP9KDKlR8q+eOXEYf1fw1aOpJcu4DlcTHaCwEiOi8yGRsQBgqnQeeEE9613Vy3pWBMA8sVQkj9MtMvDF94vXd0WFmUekTUjR7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvWfTYNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EBDC19421;
	Wed,  8 Apr 2026 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610569;
	bh=IwVbSrMv4emx/utx9wlkXpivLxjdmCAf1nYLpqxww5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fvWfTYNacovxHzSM0DmsEagd3HOAtpGxA37kOBqzc5bH6xz5K7xX0291JH61mIwBc
	 DcewijEW5m0cYw0pLN/tHJs4SxkRtJQKDAvNxfTfdKi0xYV9VsclFedqbWQQvFAFEK
	 l4Rg6GZM+iVPKrJjsJi+Txq8FC4xSFBJ5+/8pjJZCbUkJIknUSb9VlwYdfMQJTe1ZH
	 PjrFFVNXF9200tOmre5OAgF8CBR2tAJfTbRhTGZPrOSeC37OIC+uA0GyHTD8NZ+Qf0
	 OZQdTAjjFbTspSrEGpQuUiY4nh+E1Cv3PIcQcvNjnSFu/6HA3FIRjnpUElGXJpNEVF
	 UqK22fCMX+Lwg==
Date: Tue, 7 Apr 2026 18:09:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, kiran.kella@broadcom.com,
 sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold
 attributes
Message-ID: <20260407180928.3ce5ddca@kernel.org>
In-Reply-To: <CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
	<20260406181445.1fb8308e@kernel.org>
	<CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 911113B5DC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 21:09:38 +0530 Akhilesh Samineni wrote:
> > Please read this document:
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
> Thank you for the link. I have reviewed the netdev process documentation.

It is one thing to make an unknowing mistake and another thing
to ignore someone asking you to read the documentation.
Please read the doc top to bottom and tell your entire team to read it.

