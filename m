Return-Path: <netdev+bounces-290891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOtIHHaREGqIZgYAu9opvQ
	(envelope-from <netdev+bounces-290891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:25:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62165B8256
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE60304500D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DFA357D0C;
	Fri, 22 May 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6Ch0ie3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064C357CE8;
	Fri, 22 May 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470200; cv=none; b=TV8qzxQ/i08J4Unhz+536giJcUOokDNPbiLLOJ4ZfAC6jQ9TVsjglGdtfrwq90p7PFoKkPGHwHujMqct5E2jDxSOjv1NfhW5EBB6zkMkaBS1SX67FXVC2CrT5/EwX6ntLaEHxhC6TRUBPOPzB3oWFBNqvZA6nZEd7gPCi2yAQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470200; c=relaxed/simple;
	bh=1y56nUpA/Y+X+XvZPz26/FgV1G7tUZX1zC9Islfq2Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJHc272sg7MNYMZLYp7tpmQbroYJNVAMix1FsbJQ5QbvVRhxAeryFQ0WA53KkAykd+aKzZSokxuncmsfxRzqqEVdgBY2XrEeC8dQHuTW2Sg/bkWA7oI33Ka4PoaOo4bU1/f7QpSJrorncEUuKg2kIG9RKWmtvqFEi8yV0kryDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6Ch0ie3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E411F000E9;
	Fri, 22 May 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470199;
	bh=WmNE7wq3JTBkgjSfjlSQ4LNdguK4xEZY5STSAtSNLag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e6Ch0ie3OgbtbrzkKag7IYjaI9/j9O1vWdz3AC2n/CgTeHOl7/Nl7PJc6JOal2Tw2
	 Lu9AH8qexOKne0wNswAy7ndtB0zKCj4ezmfPTCYLP0aVPb3zYxhkc4f+e6ovSJClBQ
	 2OcduCSLdGbTB5pA51w/pA1upiHZAtMjSt1AT+3TqszMTWAWxWvTyURhgceXJyT/Ir
	 fu+3XJVo8q7ldfbxqH5lzOmPWMSLuhYABVWBPNyQsVNSHL1EHgGcOsD9PTEWRldKDl
	 CBUrfD7K49AXFjViWvHEb79ckQzPzLhsPmIFYEJff4R5xbDS807ysOy4q+SYsOtD4Z
	 O2FUEpngQDIDw==
Date: Fri, 22 May 2026 10:16:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v15 net-next 10/11] net/nebula-matrix: add common/ctrl
 dev init/reinit operation
Message-ID: <20260522101638.2466ebee@kernel.org>
In-Reply-To: <20260520032950.4874-11-illusion.wang@nebula-matrix.com>
References: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
	<20260520032950.4874-11-illusion.wang@nebula-matrix.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290891-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C62165B8256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 11:29:42 +0800 illusion.wang wrote:
> Common Device Setup: nbl_dev_setup_common_dev configures mailbox queues,
> registers cleanup tasks, and MSI-X interrupt counter initialization.
> Control Device Setup (optional): nbl_dev_setup_ctrl_dev initializes
> the chip and configures all channel queues.

drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c:97:21: warning: result of comparison of constant 4294967295 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
   97 |         if (common->vsi_id == U32_MAX) {
      |             ~~~~~~~~~~~~~~ ^  ~~~~~~~

