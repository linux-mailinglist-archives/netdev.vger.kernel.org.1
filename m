Return-Path: <netdev+bounces-261118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNkRJnmon2madAQAu9opvQ
	(envelope-from <netdev+bounces-261118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:57:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5819FF62
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA9683048053
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79283372B44;
	Thu, 26 Feb 2026 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLZM8Ryo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668A30F80C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071023; cv=none; b=KwAQuRFsW6IUkb91BGzL0fm2xevzITsImTuxtvslnwhC/qb9of+/mCMYFnd8F6TWofdzrd79SArwhU0tNX7QXhxdexe93CRMpBzt74Z1cjZ0tHSYc+fmpo+OS+JIgNIEMPZHLnDotbC97dwNj7/EKtz/sVGJJ3mm5gNmm8sighw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071023; c=relaxed/simple;
	bh=Fw1IjG9gOrdND9hvs6niCSf+eraOAVvcSu8q8TPCEDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBFqJBvBDr8nVHW9NEfKlpElN3F0EzUFjU8ZercjGWw4Pj2ewTI5pFQUki7D/NeQxCcPMuW5FKPWwGJe2pFCwauUYskmiBMdWWR42iCdtdHF/t6CbuU4sRYWMDdHV3a2TUnvjQAlBRQhOcalzlrkdIZ73KRGjukyBDClyulYgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLZM8Ryo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F080C116D0;
	Thu, 26 Feb 2026 01:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071023;
	bh=Fw1IjG9gOrdND9hvs6niCSf+eraOAVvcSu8q8TPCEDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hLZM8RyoyA5nvcII2m0CTdPA56E3xghDOEPVXoor1EyTxnJn6QHz/BZxX4vyVQVP0
	 YYxzfw+D6zJITQqE/T8786qkzwyaZ+2lmN1jbBR47NesPo4Xo0r2O+m8aDmYDlyjfF
	 pu2xczlxCkkmdTrHQUbYrrOZU5fshVeesI9GHuQ3GvDqm/EdvPbyBlO3U6gK7+DRZO
	 6VOo5pI2dfRx25cDaOtSjNKSXoDGxR748K5NbrlvJHhiiwj2PSsKHCnbDoL06o9zcX
	 iqwgzG8mcX841l2dfdx2uu3gKL9zznIHLNH7B//DTrx63chm6KelMkOEMoQNY10O3t
	 1w7nxOUW5wIOQ==
Date: Wed, 25 Feb 2026 17:57:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v3 net-next 1/3] ptp_mock: Expose ptp_clock_info to
 external drivers
Message-ID: <20260225175701.2bcc6395@kernel.org>
In-Reply-To: <20260225153858.29486-2-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
	<20260225153858.29486-2-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-261118-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16C5819FF62
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 16:38:56 +0100 Maciek Machnikowski wrote:
> Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
> Convert spinlocks to SLIS to allow gettime to be called from the netdevsi=
m.
> This is a prerequisite for implementing ptp support on netdevsim.

Slight build error here:

drivers/ptp/ptp_mock.c:57:9: error: =E2=80=98spin_lock_irqsave=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98ss_lock_irqsave=
=E2=80=99?
   57 |         spin_lock_irqsave(&phc->lock);
      |         ^~~~~~~~~~~~~~~~~
      |         ss_lock_irqsave
--=20
pw-bot: cr

