Return-Path: <netdev+bounces-278815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wVvjBG2m32mvXQAAu9opvQ
	(envelope-from <netdev+bounces-278815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:53:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937494058CD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0862300D1CD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4F3D6496;
	Wed, 15 Apr 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v7MHgVl0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164143D522F;
	Wed, 15 Apr 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264809; cv=none; b=R1Nb4cTD/0N7S2EPjM21vSulAD3ym4509b/1geBe9kwkDo5VsprQAYhAbkY4ZsOCF4WhcSMU8NmjNeXhor93cHSFm9kHGWf8J2sdOlPsnkLzU6V3hda18z9CxvFjQ5KabsrPvfMq99clTMHmjzfYhwXHR9Xeka3GM3cTAw1WJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264809; c=relaxed/simple;
	bh=6Nij2QaPO/48oliuTT2ySNl3oPbMk4IZMd0gIIxJTTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEoV/+YaE+CDE97jcHTerxnfsJ4hPaTOEayYo3o5sgfv5Aq6S00dZGOMFf57neU44YMd9Wy/7ZhlimMWCfMMUbZBQs+L7kcTyDkvrgGvLPfIAL1IYCdJe5dm1tNq2lp4vbZRC98EoTAfkZ6mcqrebqHlVCHR0WhSk0lqUk5meOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v7MHgVl0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WfHCAkD7OpqH3CAu3jJp+BXNoIIrKT7ERdRj0E9Rse8=; b=v7
	MHgVl0NlC2ZU39m+k8hFzJkm4Od7Ybiv5xwINs4sna7dFtrKOqsOB1RXji8ah1lY+8HRfNS97uTPR
	zENxKfUza5DlsQ7v2A5OS469/HMGgOv+fpJkdyJgAS8vGcEXv7gr8CcR02PcGj3y6iPMXNI4xa9rR
	Nr03cBHSCDDuK3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD1cD-00GBPd-DW; Wed, 15 Apr 2026 16:53:17 +0200
Date: Wed, 15 Apr 2026 16:53:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: hkallweit1@gmail.com, fujita.tomonori@gmail.com, linux@armlinux.org.uk,
	tmgross@umich.edu, ojeda@kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: rust: net: phy: intent for MAE0621A (out-of-tree C -> Rust),
 request for target guidance
Message-ID: <f57bb151-bc84-4c67-ae43-8901b09de884@lunn.ch>
References: <AFkAcAA-KLHz8L2oAyS3qqrb.1.1776247198201.Hmail.2023000929@ruc.edu.cn>
 <AN6AigCwKNz*0oYAjaS2aKqr.3.1776262694321.Hmail.2023000929@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AN6AigCwKNz*0oYAjaS2aKqr.3.1776262694321.Hmail.2023000929@ruc.edu.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,umich.edu,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 937494058CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> - paged register access is open-coded and does not robustly propagate or
>   restore errors;
> - several vendor sequences use magic page/register values with no documented
>   rationale in the driver;
> - there are unconditional resets and fixed `mdelay`/`msleep` delays without a
>   clear completion check or justification;
> - debugging uses raw `printk()` calls;
> - some helper return values are ignored, and `ret |= ...` is not a good fit
>   for mainline-style error handling;
> - the MMD / EEE handling looks narrowly special-cased and would need to be
>   re-checked against phylib conventions and proper documentation.

Nice, you spotted many of the issues in that code. That gives me a
better feeling, you have some understanding of Ethernet PHYs.

> At the same time, we should also be explicit that we do not currently have
> MAE0621A hardware in hand, nor sufficient public documentation to claim that
> it is already a well-grounded first target. Our current local setup is useful
> for Rust-for-Linux build/tooling validation and limited non-hardware checks,
> but not for real hardware-backed PHY validation.

My personal experience is that anything which is not tested is
broken. For a driver to be merged, it needs to be tested on real
hardware.

Can you get one of the amlogic boards? TrustOnX Player (TOX3)? Radxa
A5E? I've no idea how easy it is to get Mainline running on these
boards.

	Andrew

