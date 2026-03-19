Return-Path: <netdev+bounces-269278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wClEBDVlu2lVjgIAu9opvQ
	(envelope-from <netdev+bounces-269278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:53:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B372C52B6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C218B3016885
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F62D7DD5;
	Thu, 19 Mar 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es0Wqm8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273A23D7CF;
	Thu, 19 Mar 2026 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888818; cv=none; b=uBHCRH+4Hy0/HiSME3wkYFkqZJx7peg0I2Td+kwbHnyQTv0N4fTt0mXrh8CE6O8vqCen34rsmIGMB876KtD7UCisv73MSAT1PS3uLBgRbh3kMsHhgYi/IxrzmIkiqXIjY+i2BIrqp62N12gbceYHcMx17+eZ02RxDKNqCxNxLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888818; c=relaxed/simple;
	bh=wxUwDuGYqbe4MKbYC5nudTap9xZa9n1gpeSSj4VQ2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiHf9CAUNfMZNUg9beIuvGDHsDh4HggCh+ycnHoel1D6aMLqMBv4PPOgJqBeso6B3f0m8+RngCQyRPhnfe576wZGRHNBoeAbMiiSComOo6pOP8ZEqUI5aDs2BNiHCKEc850LcIkYgQSLDmWdlgLBUGJk8CSuaf4t4z5936dOV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es0Wqm8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1609FC19421;
	Thu, 19 Mar 2026 02:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773888817;
	bh=wxUwDuGYqbe4MKbYC5nudTap9xZa9n1gpeSSj4VQ2LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=es0Wqm8AAzb02ZvqHnoVp0SmdY3ptz54sxM0unxTl/0Nt6F38Fij+3IfDv2OH/OdS
	 l3cSS2Z93PUBt0veMiXa5qrhu2VkFkwmFR2erEfFr8BGUK3ofWpM/wj1O2x39v+Aha
	 tUPOcs6D8dQ9zHtvew6rG/qVCu40vLklb5AQLeH48qgBf8Vzi2qsbpmlnOrTykB7Yf
	 prsztNeF9dqWaGoPAnpZGpQetkfHCo1hlH0fhqMDKSum3yr5WJeILm5fnGjPDNiL/g
	 hBb9XduC99bmGtqT1mB3Mb2xRTsU5REVmHZKxqdfu4RJ4G2Jpdq6BzGx5iiVZ+voCe
	 ++xclM1MqQDZg==
Date: Wed, 18 Mar 2026 19:53:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com, Bhargava
 Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net-next v7 06/10] bng_en: add HW stats infra and
 structured ethtool ops
Message-ID: <20260318195336.0406eaf0@kernel.org>
In-Reply-To: <20260318150149.7a8c6067@kernel.org>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
	<20260315141605.410878-7-vikas.gupta@broadcom.com>
	<20260318150149.7a8c6067@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269278-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0B372C52B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 15:01:49 -0700 Jakub Kicinski wrote:
> On Sun, 15 Mar 2026 19:46:01 +0530 Vikas Gupta wrote:
> > +			/* Per port queue IDs start from 0, 10, 20, etc */
> > +			queue_idx = queue_id % 10;
> > +			if (queue_idx >= BNGE_MAX_QUEUE) {
> > +				bn->pri2cos_valid = false;
> > +				bnge_hwrm_req_drop(bd, req_qc);
> > +				return rc;
> > +			}  
> 
> Dan C's report looks still relevant:
> 
> https://lore.kernel.org/all/202603180509.nOQGZrG0-lkp@intel.com/

FWIW other than this the series LGTM

