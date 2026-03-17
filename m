Return-Path: <netdev+bounces-268355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMshAUSduGkzggEAu9opvQ
	(envelope-from <netdev+bounces-268355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:16:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60E2A2359
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EBEB3012E53
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CFC1A6802;
	Tue, 17 Mar 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blgYPrxn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03482A1CF;
	Tue, 17 Mar 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706561; cv=none; b=sFnjNFlkKe82VvjbqfHbejUgM86cqcGljEZEVF9sImVXvhxNUMEboGes5rw7dFThijHu0vhXZxW9lHbriJZxepJ95KygotxBUemNqH5d1/apfeHeWBwwrblaHSqAaErLUaOB7Jjsof6WBtpzc1d8fohho/XLA4UC6MvpIt9ucmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706561; c=relaxed/simple;
	bh=EKXtaLUto5ANZSQPbOQD+hgjCZfTpwRRSRmUiFLocyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu4gTZBj+3CzMz9aBjCJpIA1ZjUFV1dtr4PMETvVTW05M4jZ6dUbaWQ854F6m72IhB4A+jM3+5S8NbVgpfnlJ4b7FPcCbCyBZ8JlIc//Td1ngM9SPrT1PpnIrb2wU24Y/nDIr1uwJYqu+tOuwqe5wp802qZANclMbhZfWtikHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blgYPrxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B630C19421;
	Tue, 17 Mar 2026 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706561;
	bh=EKXtaLUto5ANZSQPbOQD+hgjCZfTpwRRSRmUiFLocyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blgYPrxnvGi16Maf60a5tmjSIURVrSjzqFFZlOWw42joezxInkN1Ymut2bc7iDQZ1
	 gk9PMmI5D55SFnFXWhfj1lLuVYnynnkZDenCW8+JmMlSWYf8pyT2wx1/7rqi31aZkQ
	 xU6lFet7lRNUSyqaeL2gxz3KV/K2+/OMBqEG+T11rjh1CsK0hGcDPzNSSmihTOHn7H
	 0rEhtuCo2hMXm01N/IufKXp0qkfpTX1JxMMMCHfH5zrjcmWWsxO/Dd4iBpFE2YLwvX
	 sa6y2BYtwqak8wFHXpkbDIcYonEBx6E+cQ+/sqK3eVtn9u5LihaO/fYMfYjljKzIpP
	 EgU0EVhVC3djw==
Date: Mon, 16 Mar 2026 17:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, stephen@networkplumber.org, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: ntb_netdev: add SPDX tag and remove boilerplate
 license text
Message-ID: <20260316171600.13321deb@kernel.org>
In-Reply-To: <20260316192248.518-1-rayfraytech@gmail.com>
References: <20260316192248.518-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268355-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,davemloft.net,networkplumber.org,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E60E2A2359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 20:22:48 +0100 Oskar Ray-Frayssinet wrote:
> Add SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license, remove the redundant
> boilerplate license text, and keep the driver description
> and contact information.

Quoting documentation:

  tl;dr
  -----
  
   - designate your patch to a tree - ``[PATCH net]`` or ``[PATCH net-next]``
   - don't repost your patches within one 24h period
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr

