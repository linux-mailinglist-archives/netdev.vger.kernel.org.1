Return-Path: <netdev+bounces-254112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC2XOqioeWl/yQEAu9opvQ
	(envelope-from <netdev+bounces-254112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 752D49D596
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4D3A30039A0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A1334692;
	Wed, 28 Jan 2026 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9NT9y4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80827B4E8;
	Wed, 28 Jan 2026 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580708; cv=none; b=k/Mfcb1F24tyWDE+jxhOxQZB4bmc1Pka4mKSdJTQTzyZqjKt2kQ9vOVzkb0aC0eAN8J8rtZq5aL1WxophXAWM/In1eeckCadrcAM08DESHfhkPxOWx0TZdQoTBQrSbqI5wdsaIrn1D8thyzMI8nUjKLUy1pD71RF7kgt55Gz32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580708; c=relaxed/simple;
	bh=JXmx3ru6DbNGgSS53SUU+Z+OgHwry2j4I+n2aYrQwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAKSzZkdaHJtNB5a2mX4MfQIqoLODXAHOvZFOCN0rKycBIFnd7nVI0+wV+MDbtxsWDlbLLhdJs6JXESh2YYEejDem3eLGkKoUYpKswuH6MY0Y099a4k9OyU3o/v7MsDD8gDpVqVOePP3vTe/E2l8CYhE37bkmcuZwQahmwACsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9NT9y4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DCC4CEF1;
	Wed, 28 Jan 2026 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769580708;
	bh=JXmx3ru6DbNGgSS53SUU+Z+OgHwry2j4I+n2aYrQwCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9NT9y4J4ceqqk4QjELnD3ZXmNMp7zvRkys4VW9AQ/9NFdtdkdqJuRhdUSKIf0DmR
	 FjbJ2VCcz82PFxcxH46+26PoBeCNdA253BYNBpIhSnlovZcm+HFaDro52U8nrDf7Ri
	 MOmx4BcJIxKAtCGtZkjGTMJaDcjyz4Lv6rQIyprU=
Date: Wed, 28 Jan 2026 07:11:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan <kernvirt@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] r8152: Tx timeout and xHCI setup device timeout. RTL8153
 31.00
Message-ID: <2026012811-sepia-aeration-0238@gregkh>
References: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>
 <2026012758-dedicate-desecrate-358a@gregkh>
 <CAOf3c5eJp7432wRk1E0cDTWMccO_m9fWYDKU25-qJ7Owk8mVQA@mail.gmail.com>
 <2026012720-outmatch-worry-b92d@gregkh>
 <CAOf3c5dCsN2rDURv_Ct_K2agiFRe1zEjrQi1AM8LjTCfUYnLVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf3c5dCsN2rDURv_Ct_K2agiFRe1zEjrQi1AM8LjTCfUYnLVw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wikipedia.org:url]
X-Rspamd-Queue-Id: 752D49D596
X-Rspamd-Action: no action


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jan 27, 2026 at 07:02:46PM +0300, Ivan wrote:
> Yes, the log is correct; during the time since boot, I had just
> finished downloading those 900MB of packages. In this specific case,
> the interface disappeared just before or during the reboot. After the
> reboot, the interface did not reappear because the hub remained
> powered, and a physical reconnect was required to initialize it again.
> The previous log was short because it contained only kernel messages.
> This time, I am attaching the full output of journalctl -b for more
> context.

Thanks, but it looks identical to the previous log, the device, at boot,
didn't want to talk to the USB host (i.e. your computer), and so
disconnected itself.  It must have gotten "confused" and so a physical
disconnect from power fixed it.

That's a lot different from "it was working and then it stopped", so it
might be a firmware bug in the device?  I don't know, sorry.

If you plug it in, after the system has been booted, does it always work
properly then?

thanks,

greg k-h

