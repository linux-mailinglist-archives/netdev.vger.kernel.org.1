Return-Path: <netdev+bounces-300267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3HvG0cmM2r29wUAu9opvQ
	(envelope-from <netdev+bounces-300267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E329B69CC1C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HMKbd+BA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300267-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305AD3037BB6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BE3BB119;
	Wed, 17 Jun 2026 22:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DE32ED27
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:56:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737009; cv=none; b=D6avz7ybNB8+hBP4chs6B9OVG2cb4N38geIndawA5c3wQfRf+XtqIiOOiiYVZQyjv7d+8KHnw2p7iOTLP91A8ZNzIuBBkxWsoeGCgo8DOPr/KE/UAD9oMpIv71eVFPekgxjlT1D8dRYTEv39LnxzFPqfcz8aTezd6yvIzesiavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737009; c=relaxed/simple;
	bh=RvctmYDa3xZVlcrU2f+tZVPrXqI+vNI7nKiwIvKMQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJiq5nitUoB2VaP7ujMq76wU2vSd8M+7EoWIor6AISbKZh7vSF/eXg6/7i+d80hZjQK3WtefOqP1HEaT55bOwOL9XcaH203N+xJ2gOHkaVAMu1uOAeMbSd4kcf6Fayi8/cix2da+iXXvBruwGb71Ce97AsBptqV/EzDxI8AUbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMKbd+BA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28741F000E9;
	Wed, 17 Jun 2026 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781737008;
	bh=RvctmYDa3xZVlcrU2f+tZVPrXqI+vNI7nKiwIvKMQtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HMKbd+BA8bmmKJQurj/KD48a8Atr0sJAlpbYv7wc59eHONfgy3yAOvToYw+INLhxu
	 xw1dahST/ZtM8e9EtLWxwGGs4KXpnr2Mx95NQQ6qPCB8d924yZLnx3+LUGhPi2VMNg
	 Ew3LuRXbAYJldhc2fXNO+8EZCYbf2P5z4C3VLpAZWXDBVKBGgETgJ9ROntn7qQsrmy
	 hqdIjesPPVbbVypdaIVRR8R/35crk/SkPCdfS9XuX4yoGbxFAdwrWBOlZouXbPgi12
	 EZdCGLZlb6OK9fwi1V8MpbPwS6cdoWQZ+k0W9NFT9gyf9o2U2MWrgi3wcGHI0FEtmS
	 oYgN8flROPHAA==
Date: Wed, 17 Jun 2026 15:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v14 6/9] tls: device: add TX KeyUpdate support
Message-ID: <20260617155647.78e3b3c8@kernel.org>
In-Reply-To: <CAKaoeS3mTGUo-dvtdmQfz3JAnn69-e36xrj9YmjbWTnsiw9uqg@mail.gmail.com>
References: <20260515212715.3151307-7-rjethwani@purestorage.com>
	<20260525211608.2508449-1-kuba@kernel.org>
	<CAKaoeS3mTGUo-dvtdmQfz3JAnn69-e36xrj9YmjbWTnsiw9uqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300267-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@everpuredata.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,everpuredata.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E329B69CC1C

On Wed, 17 Jun 2026 15:32:58 -0700 Rishikesh Jethwani wrote:
> From: Rishikesh Jethwani <rjethwani@everpuredata.com>

Please keep in mind that net-next is currently closed.
You need to wait until the merge window is over (2 weeks)
before reposting.

