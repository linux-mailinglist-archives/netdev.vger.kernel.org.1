Return-Path: <netdev+bounces-260143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCWnCYuUnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8556917B287
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F38D301A712
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0C338910;
	Mon, 23 Feb 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huuADg37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E983385B1;
	Mon, 23 Feb 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869045; cv=none; b=PwLSaiRf+b9vdlLLD2ItydhKSDeR5yvocOQ1+xH2CnyOuogsang9/6LFFP472KJSw+Gc1BVHLrDrkra/+b6IE8DLCQBWPxU7X4JaRbiG+OD1NouH4P6DzdKS+DQy5yl0Dl61HwoMtNr5N5698kdFntuXnBIWTX+rtcfdtQRwCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869045; c=relaxed/simple;
	bh=qltNpxVS1O/Ej3OenO1iVrOJiK15RWvrrThFE6tLcuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMksTmfDup+L6C1y5LlCtXIscB2i5KmQ7CMFDuBlOlNnQlQz7k8/DclngvOgL8rOcdNcqmFAcy7yERiL/6Y8wUb3Bl2QaS+M91PxOMCrFVFDywGi8v3ZrAoXtldXC2yRUAl2BnYjBcWAJE0G0RxNjxAytDaGmeWDseXmv6FyKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huuADg37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A82C116C6;
	Mon, 23 Feb 2026 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869044;
	bh=qltNpxVS1O/Ej3OenO1iVrOJiK15RWvrrThFE6tLcuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huuADg37tL1SSfJ6E5JHY7F+eKGmWwAls/fUsnj/NXSp4aqFc0tIfMy2WD4h595ZM
	 YZpv1OngXUgtft8weAj12caAtFF2vQE11IYR8Twy9hntIFArBY/oHdvxDpYjXiPBeN
	 PMkDT8sJrGWmj1+rtx13sR0jtutaep1iHYyKZdHhTb+icML+mAzjODD7byqya/WK10
	 l5QhE/W6VHFwlWI7YsF99z2MTD9a+abVocQ5f3H1wIKu0B4u2/iwoSvu2OeapnwAvg
	 jR/SjMBOI0u8eCwwVoPs5EhSFGa/xJjNGXK6ckIP+gwIIVivVA5wH2s+Y7BqdDjc33
	 CJNvv10Fh/L+w==
Date: Mon, 23 Feb 2026 17:50:41 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register
 width for some chip IDs
Message-ID: <aZyTcWMAIzVOSz09@horms.kernel.org>
References: <20260220155755.448185-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220155755.448185-1-ivecera@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260143-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8556917B287
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:57:54PM +0100, Ivan Vecera wrote:
> The REF_PHASE_OFFSET_COMP register is 48-bit wide on most zl3073x chip
> variants, but only 32-bit wide on chip IDs 0x0E30, 0x0E93..0x0E97 and
> 0x1F60. The driver unconditionally uses 48-bit read/write operations,
> which on 32-bit variants causes reading 2 bytes past the register
> boundary (corrupting the value) and writing 2 bytes into the adjacent
> register.
> 
> Fix this by storing the chip ID in the device structure during probe
> and adding a helper to detect the affected variants. Use the correct
> register width for read/write operations and the matching sign extension
> bit (31 vs 47) when interpreting the phase compensation value.
> 
> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


