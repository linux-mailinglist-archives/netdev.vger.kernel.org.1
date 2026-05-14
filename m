Return-Path: <netdev+bounces-287773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAueC60oBWo4TAIAu9opvQ
	(envelope-from <netdev+bounces-287773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4853CCFC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FD223028F64
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5C321420;
	Thu, 14 May 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUQEggTA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A131F987;
	Thu, 14 May 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722975; cv=none; b=jh5uu7dOUPhqnFCZYN0GVcdEUJg0oaiI8Y+WNUpHxySfwX671UdquLcRY/ruvps12MeXrtLUFxeaKq60XUdhYSAWkt1GhMx+wq1Eu9UrjiYFT0lt+iiWG1ekpN8uydYIL1al/nDPGRdiCDYcKq0bQ1KrwZZu78Vu3emz1rpnzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722975; c=relaxed/simple;
	bh=oBhCuHah8JcJzRxbSplEMoBSn9c7+hDNbVI06xJE8n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8mXB6oDdHQcSKOs2I6FVy9UeC7mlfqTEH4CmJj90lC4yflZvAsBpABnfmIEVlb8OvQxDHoh7y0gvF/T3C1PB/08oLcr0U5lvgSRcRBCbJKmFbWYWn4VMKTFhDp8h2s1ypguwx1hXo3iPmpUoq4BMs7VvjjZBwNRcGjxHmRlT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUQEggTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F06C19425;
	Thu, 14 May 2026 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722975;
	bh=oBhCuHah8JcJzRxbSplEMoBSn9c7+hDNbVI06xJE8n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUQEggTAnbX4mghOtvtXKy799oS38unx1v4B51VTgl0oxzaZHIsTAk+Ry6m2ICAjM
	 wuw0qSH0EwNXwcWMmVOf5X7kiasv6J0sX73J3K2IbLorAOx1KyIpASgpQMO4lpMRFE
	 1855QjA+/cHbABktGQpZ0j14oMOIDBq4PAV73j+WRSUU4eraKAR4mtxxPFqzH2c+pm
	 //n86azelmDEacVYHBeumOhiBw3QOBqA4YibPkhizu4H6x7KWZiYmpeiQ3Q1YkgGSG
	 ZAhLaPm/eegbbHtNhauBtVT0viC+mYbmzzq7l9BXpOzcneBho3WnJaOtsgA3FZvkyN
	 50leu6uVsOc9w==
Date: Thu, 14 May 2026 09:42:49 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/6] usb: chipidea: tegra: Avoid controller/PHY init
 if bus is externally controlled
Message-ID: <agUomUMW9Yu3n7ZK@nchen-desktop>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-3-clamor95@gmail.com>
 <agJ/T8nBGWEoblmd@nchen-desktop>
 <CAPVz0n173syW9rXy7Qt_N=mChe6WBRLvjRDypcJEC50hPL4OMQ@mail.gmail.com>
 <agLb6mgP45jHjvNt@nchen-desktop>
 <CAPVz0n2yGALm1Z0j0j6_MaqAOZGL+a8EgCWYQpW0QN1YVf96EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2yGALm1Z0j0j6_MaqAOZGL+a8EgCWYQpW0QN1YVf96EQ@mail.gmail.com>
X-Rspamd-Queue-Id: 9EC4853CCFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287773-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 26-05-13 20:30:10, Svyatoslav Ryhel wrote:
> вт, 12 трав. 2026 р. о 10:51 Peter Chen (CIX) <peter.chen@kernel.org> пише:
> >
> > On 26-05-12 09:13:40, Svyatoslav Ryhel wrote:
> > > вт, 12 трав. 2026 р. о 04:16 Peter Chen (CIX) <peter.chen@kernel.org> пише:
> > > >
> > > > On 26-05-11 16:56:57, Svyatoslav Ryhel wrote:
> > > > > If the USB controller and PHY are externally controlled, then the
> > > > > registration of the controller and the PHY initialization should be
> > > > > skipped, since these configurations must be done by the device that
> > > > > controls the bus to work correctly.
> > > > >
> > > >
> > > > I find you only control USB controller device add at PHY driver, most of USB drivers
> > > > has PHY control, for chipidea, it has PHY control at core.c, would please try to
> > > > adapt for it?
> > > >
> > >
> > > Usually yes, but this is not the case for Tegra unfortunately. As you
> > > can see Tegra specific section of Chipidea driver specifically
> > > describes why it has to set PHY manually.
> > >
> > > /*
> > >  * USB controller registers shouldn't be touched before PHY is
> > >  * initialized, otherwise CPU will hang because clocks are gated.
> > >  * PHY driver controls gating of internal USB clocks on Tegra.
> > >  */
> > >
> > > So in order to provide correct work of USB when set by an external
> > > device, both PHY and controller init/add must be skipped.
> >
> > You could call generic PHY APIs at ci_hdrc_tegra.c, after PHY init or power on,
> > call controller initialization.
> >
> 
> I was tinkering with Chipidea driver for Tegra a bit. If you meant to
> use flag only to control usb controller device init and leave PHY to
> be handled by controller, then yes, that is possible and that is
> better approach.
> 

Yes, you may summarize the initialization sequence, and see if put PHY
control at Tegra glue layer or at Chipidea core.

-- 

Best regards,
Peter

