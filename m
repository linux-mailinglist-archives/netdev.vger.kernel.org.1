Return-Path: <netdev+bounces-258334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIbHJXnKjGlktAAAu9opvQ
	(envelope-from <netdev+bounces-258334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A218126DB8
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E2203004F3A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F35350A1E;
	Wed, 11 Feb 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihi46+2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB7313552;
	Wed, 11 Feb 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834550; cv=none; b=GP+NM0iVk5Ttn0D2UUQI57e7pXv72pctn3kzMOAnamm9sKk+/eeaQ4uH1sKPoVGOavWMYT+f/KM2Iu8rwxK4HnO0xLLaSXr8Hn0OOlJb37gZ8mfrThh4pytx3nxnLnoNn7/EYycg9CreZRSSSlxSEjaou6q6rTFCFUd6et5fa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834550; c=relaxed/simple;
	bh=FkTdMrzfnWOa65M7TOxVOTewRFDuBbrSyTDkM7TTM8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b8XNLretdvXyctEaIchimOOAtOtYBG+lgUnRpT61O7/1W2ClfeRrJ3zirBPNLN1wtFKvLrAPJZh4zDLl97gAIIvkCZ0GGrax7pi5HbByzFBstu1bX4XAWuZqU7yrW7A3f0ybkp9bsviy63PfSggMG/I+nkv4pXc2UqfE+N2M/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihi46+2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507CFC4CEF7;
	Wed, 11 Feb 2026 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770834550;
	bh=FkTdMrzfnWOa65M7TOxVOTewRFDuBbrSyTDkM7TTM8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ihi46+2ENQiAMifT2Lwhf/yFa/G83yY9BjSdarvUEs+XcVzxfI+w05QH04NLlMp0v
	 44hlBE/eE0wfizEO2hpc3uOb9+MU2yNXFctF3UZ14tUxQhcQdGA9ImtLD+ewuTLLcA
	 7Gms8XyrzbWAPve/KSNRv5/gHcsC/YWNMqzxlEAQrjNTP+Atlg3RmmhshTFiw+hwRY
	 IGqizqdeHOJe4/B7D3oCPwH4+azvPI89LhaJmhtW97tIzFamykfTgd/rmPY/jw/SqF
	 jWoxRbhpyre9gOys2dhtDuzF9RoTzddsb6XliZydSW2JA39prYpok2l+VRtNsIO3qE
	 9TUrdcrz+HFkw==
Date: Wed, 11 Feb 2026 12:29:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harshank Matkar <harshankmatkar1304@outlook.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tony.nguyen@intel.com" <tony.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] igc: Add PCIe link recovery for I225/I226
Message-ID: <20260211182909.GA117627@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210203332.23200-1-harshankmatkar1304@outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258334-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email]
X-Rspamd-Queue-Id: 3A218126DB8
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 08:34:02PM +0000, Harshank Matkar wrote:
> From: Harshank Matkar <harshankmatkar1304@outlook.com>
> 
> When ASPM L0s transitions occur on Intel I225/I226 controllers,
> transient PCIe link instability can cause register read failures
> (0xFFFFFFFF responses).

At the PCIe level, the failure is some uncorrectable PCIe error like a
Completion Timeout or Unsupported Request.  The 0xFFFFFFFF response is
implementation-specific behavior determined by the Root Complex
design.

> Implement a multi-layer recovery strategy:
> 1. Immediate retries: 3 attempts with 100-200μs delays
> 2. Link retraining: Trigger PCIe link retraining via capabilities
> 3. Device detachment: Only as last resort after max attempts
> 
> The recovery mechanism includes rate limiting, maximum attempt
> tracking, and device presence validation to prevent false detaches
> on transient ASPM glitches while maintaining safety through
> bounded retry limits.

I assume the glitch is a hardware erratum and should be documented as
such by Intel, although it's possible ASPM L0s isn't configured
correctly.

If it's a hardware erratum, I think you should use a quirk to disable
L0s on these devices, e.g., pci_disable_link_state(pdev,
PCIE_LINK_STATE_L0S).  Even if this patch allows recovery, the PCIe
errors will be logged and reported via AER, which will be confusing to
users.

Bjorn

