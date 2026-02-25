Return-Path: <netdev+bounces-260989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDosLMQHn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:31:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0D198C4B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12CF0302732E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACE2765ED;
	Wed, 25 Feb 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/GUKXyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2D273D8D;
	Wed, 25 Feb 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029881; cv=none; b=Zc0N8mJ2eGyZD4WkbJvj+RXg15HlShKAD54rsBc897HDuIqs73oPyl5Wgc4+1aHqV7hZoeB56A/zaGtbb3Qvgm1CV/tcfTc9iWSkGCpc1ssSzPAhLZ5KkMclONSnxLAVBfwo0rdoYia+xWDQajoVPr9oLhpPOykgdK7TQhtFVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029881; c=relaxed/simple;
	bh=B0S7Rd+h6N6IKNOomazsVTs7waWASyt1VkHyU82BipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9v3ZIzemIyHuctWhn/WvJ2iR7aeOoYVc8mzhJuboi6TzJBvxOZGOT55nZxbKvfXmOhSqdudHA2oiwguKtfcf4oTr9h3Y0KLjxtxy5SuQuRxE589n8wcn4zZMYMCfbgLAYBFBsyXNqjOvXkf7M1b5e1csiJXyB9u85J1ORtd0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/GUKXyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CC9C116D0;
	Wed, 25 Feb 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029880;
	bh=B0S7Rd+h6N6IKNOomazsVTs7waWASyt1VkHyU82BipQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/GUKXyNBZFnLpUyW4VCTGCc/YVR42bktsNoX6LC5kipIZ4p/AuC0+ns2Etn1tKr9
	 k9pS+SDKJpncptztmrQflQ9PIqSVbB1SPYgz16+8v5Awupbi3oe8jVjRMsXjenwO+a
	 Oiwfrm+YXdCTG/VcMyYio9hVQczghz80rS1uzQZI=
Date: Wed, 25 Feb 2026 06:31:12 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <2026022536-douche-concert-544a@gregkh>
References: <2026022329-flashing-ought-7573@gregkh>
 <aZ1sjK3LwiLDt4F2@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1sjK3LwiLDt4F2@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260989-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00C0D198C4B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:17:00AM +0000, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 12:28:30PM +0100, Greg Kroah-Hartman wrote:
> > When the device is disconnected from the driver, there is a "dangling"
> > reference count on the usb interface that was grabbed in the probe
> > callback.  Fix this up by properly dropping the reference after we are
> > done with it.
> > 
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg,
> 
> As a fix, a Fixes tag seems appropriate.
> This seems to have been there since the beginning, so perhaps this one:
> 
> Fixes: c46ee38620a2 ("NFC: pn533: add NXP pn533 nfc device driver")

Fair enough, I don't normally add Fixes: tags for my stuff as it's me
doing the backports to stable kernels once they hit Linus's tree :)

> That notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

thanks for the review!

greg k-h

