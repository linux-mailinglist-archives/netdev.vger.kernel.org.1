Return-Path: <netdev+bounces-284162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE41DNVS+Wm27wIAu9opvQ
	(envelope-from <netdev+bounces-284162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:15:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC134C5EFF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 272D8300846F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E339020C;
	Tue,  5 May 2026 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gcJs2SOj"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329934A3C5;
	Tue,  5 May 2026 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947343; cv=none; b=dC2TJnEgev21GBdtAdkNR7pLLGicSZjx6cRZ+lqn882+5OnjZcWvxR/lUH9C1HI5BFBdTR+sFr8xMMVmAw3k9ChfvPZ4fhztGOL956TXdn0zG4VX2cAHZSuM5wFV4MO2XR07LCizXbg11SFa05bGI8F5HhOtTlpytldBceKUCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947343; c=relaxed/simple;
	bh=9Ha0x1iziaemk5qEGAzVk/tIiaPr9YK8E3ttBsGz63c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFt1PPNfAhpL//jGWtctG8QsbCuNSlckDTrJ2NtDzEgVO7bJ0AYnQhv59RnwIedcJCVVe6wPCP176GgIj6t0FkHFGj9cNX4ifz8lXHQN07//VKnk6QRxYn4x4fjgsWhr4D7BiSF2C97aTm0K/LN4/ulydrbYTCyD+kMZ0N+mjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gcJs2SOj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777947333;
	bh=9Ha0x1iziaemk5qEGAzVk/tIiaPr9YK8E3ttBsGz63c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gcJs2SOjfX3fhIwAapMqsfPIieDdEN8wuaIY0RMebl3OGYLr/sNipalu96Fl5MzwP
	 AnhVFyP8Ljb+z/3LVuKhMP/D6WVuNtNfTndF++9oGmPb1t9771FTXig69sGMpSwXMR
	 t+FaoxKbEGNJfVmjmv8FP6sq+W5Y9EVSoyePphSmjJo0ZfL2hSfquOKY3AdcXjarcw
	 SVdI51OIEi0z0KkAQVZ5waAC8lU3oqSHK5JF3/4gXQEltm5OfFTKHmgJBP/QHqsftS
	 /ydIQQrMKOK6RcPxL1C/xTLp+Dr4nWvPIPAabX47rRqf9VczQtfX8tokMKas8oIIrC
	 AAenhf/EpMKCg==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9685D60417;
	Tue,  5 May 2026 10:15:31 +0800 (AWST)
Message-ID: <9cee1c2102f53bb33e96c186c21ba6447d1db4cb.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 0/1] Proposal for in-band firmware update over
 PLDM-MCTP
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Badal Nilawar <badal.nilawar@intel.com>,
 dri-devel@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
 michael.brooks@intel.com,  heikki.krogerus@intel.com,
 michael.j.ruhl@intel.com,  thomas.hellstrom@linux.intel.com,
 michal.winiarski@intel.com,  anshuman.gupta@intel.com,
 jacob.e.keller@intel.com,  maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com,  anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com,  mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com,  singaravelan.nallasellan@intel.com,
 kelvin.gardiner@intel.com,  matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net,  edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, james.ausmus@intel.com
Date: Tue, 05 May 2026 10:15:31 +0800
In-Reply-To: <20260504193420.1232842-3-badal.nilawar@intel.com>
References: <20260504193420.1232842-3-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2CC134C5EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284162-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi Badal,

Thanks for sending this RFC through! It's good to have some early input
on the structure here.

> Problem statement:=20

This is exceptionally verbose for "we would like to add a MCTP transport
driver". :)

> Option 1: MCTP Transport as Part of drivers/gpu/drm/xe Subsystem

This sounds like the best approach to me. The MCTP transport drivers in
drivers/net/mctp are intended to be fairly hardware-agnostic, and all
are spec compliant. I see no issue with having your own code do a
mctp_register_netdev() from elsewhere in the tree.

I'll also reply on 1/1 with some implementation comments.

> Note: This RFC is prepared with AI assistance (e.g. GitHub Copilot etc).

Then please ensure you have read
Documentation/process/coding-assistants.rst, as you are missing the
Attribution requirements from that.

Cheers,


Jeremy

