Return-Path: <netdev+bounces-264626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDAfM80+qmnGNwEAu9opvQ
	(envelope-from <netdev+bounces-264626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:41:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 791DC21AAAC
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 802DC30240A0
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A072350D46;
	Fri,  6 Mar 2026 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdpTYMc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368B33688C;
	Fri,  6 Mar 2026 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764873; cv=none; b=s4hz/DBvjrf8gYS02IIOSLKeqfmJLZdAlGIuRQzmfT+Ma6odjLSUPN5k7VqdPm345d+et2nkpBjs3bNdCyxY5iZHzXWrRsik2Bq5AZMjA1KmVHRZ5GM0G9JbmCkx28HBNN4+qAUGaEHfvpFinwM8/mvs0NSXNy8XXcGEFuRIJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764873; c=relaxed/simple;
	bh=GqBefeOg7i4T3RBZfpPYC0R9yFaXJA9/wZ3SV33UALg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwdTSkyHC+jCsQPx1SWAq0GeVg3FDuBOEGqmFVaC7S991GPVJVWS9mceLELOWNRwQyClFHYvru6ADXXRpHx8XHbOxqAmaRZ+9n2i0EbGrBMB8se+f4xUPRDfFpg5vX215f8YjleUqY/J0Xf7xFfmU+LjEcnF9CefnrCO+VmlS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdpTYMc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559C0C116C6;
	Fri,  6 Mar 2026 02:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772764872;
	bh=GqBefeOg7i4T3RBZfpPYC0R9yFaXJA9/wZ3SV33UALg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdpTYMc5NwRNUbWd0gQzyhspSY8WIBfasZ+FM5jpmEle0Io7zgtUm7WqI6Tk8hpoW
	 1Uo2MhmCexY1Zbp9vGfW5v/EK8eYiysS8tbfEwHDURFh38ddvDxvXhC9cStSvtLsgU
	 yHJDt/gOxUk67CbiogXGtVTBImEdqqzVVLpdhopq3Ae02/+gzzhQYvE2PsnXkLr+Xk
	 jpMrxZc0RELRDX5kPKbhcjmSpptupK/7dmEd0bSzlkb5GAFO4y2Y9ckpi0ySwBhUrO
	 f3d3IpBpOyS1S567dOCRsJb55HvqRyRT9DJmzOHG7dQjq/AEAqq9k4x3zmuZXz11eM
	 0GaskYBuE9fDw==
Date: Thu, 5 Mar 2026 18:41:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: David Woodhouse <dwmw2@infradead.org>, tglx@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, taniya.das@oss.qualcomm.com
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
Message-ID: <20260305184110.13e79837@kernel.org>
In-Reply-To: <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
	<be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
	<4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 791DC21AAAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264626-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,oss.qualcomm.com,nxp.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,linux.alibaba.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 20:25:11 +0800 Wen Gu wrote:
> As mentioned in RFC v1, the use cases for drivers in the emulated PHC category
> are expected to be quite diverse, and not limited to the virtualization/guest
> time sync use case. For example, existing drivers such as ptp_ocp [1] and
> upcoming ones such as mhi_phc [2] are not related to virtualization use cases.

ptp_ocp is a real PCIe device with an atomic clock. mhi_phc is some
qualcomm fw-defined thing, so more closely mapping what you're doing.
ptp_ocp should probably stay under netdev, we maintain DPLL drivers,
too. Main thing we/I don't want to deal with is all the corporate NIH
virtualization excreta.

