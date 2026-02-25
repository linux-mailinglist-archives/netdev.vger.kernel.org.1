Return-Path: <netdev+bounces-260701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMfGBAlUnmmmUgQAu9opvQ
	(envelope-from <netdev+bounces-260701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:44:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E915518FB52
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 936B8307B57D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A82765ED;
	Wed, 25 Feb 2026 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VflXjdjK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212471D5141;
	Wed, 25 Feb 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983725; cv=none; b=c+0Cqi2VZyYPKLCKIv4ut9vX4xznTqxIQuBou7tNHFo/Ifms3g1OTd4d4FLxUQio+L7RF+tHguEhEUza/n3R9XjvtFCV2c8261aDd8lslC7kYFJDngEJwJbZPjsyn0r+vuygCnfEWcolmr5pHrN6SBxMsireX023FN7gU5S1mPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983725; c=relaxed/simple;
	bh=BqZm7X762VsHjVyMnNELv3A+c+xHuWbznHS6VRPJBtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1WzWT9bRGlcMfhpWt0dxSZcjh56tdi2QSEVQC0oewlXn+AFxQEsv5yjKpr8I0CbaaMBF/9WUVktqX9CqnwnO7Se3/VpWgRi34BWs+lGpLTc6SKK64muLnMl3QErTXkHmuKj3MCP+oWnPaKl8Tftru7f4d1b6IDWGeiDDgPXdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VflXjdjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92600C116D0;
	Wed, 25 Feb 2026 01:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771983724;
	bh=BqZm7X762VsHjVyMnNELv3A+c+xHuWbznHS6VRPJBtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VflXjdjKIUbmldcYDAGA9Tyven3hpVzxnEpJjaURyfWDXgw+CW0g6SPUwrIvSSt5r
	 GJ63Wv8grRxeW40rdRMs2Ej+NAqJ6+9rjUHNoKerEoXdIuGVDlgDKDVQSbvULlQ1bJ
	 03TDumiNKsnmnvyc2gni7m3N100XbyNImPJfFTNQA1/bp510ajyEVpXyCFHmllYGei
	 PYD2tY8Z1OCzxUhWHIM3Navl/vhmCXphoVyrzndJMNhHG0jQo/4In3dHfW+Q95pHFs
	 gjxv9tJbnmJi5q2tev0ZBHQV/bThuD6KnnmZMjrfIniUkKAcWA2vgUkNyj6QHTxU/o
	 DEEHXA8LfU8FQ==
Date: Tue, 24 Feb 2026 17:42:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable
 <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <20260224174203.405d0a93@kernel.org>
In-Reply-To: <2026022329-flashing-ought-7573@gregkh>
References: <2026022329-flashing-ought-7573@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260701-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E915518FB52
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 12:28:30 +0100 Greg Kroah-Hartman wrote:
> Assisted-by: gkh_clanker_2000

I feel like this tag completely validates my position that the whole
Assisted-by tag is nonsense. Random "Person X's bot" tags cannot help
any cross-kernel research into problems with AI coding tools. And all
of us, employees of AI-pilled companies, are routinely using a whole
slew of AI-backed tools on our kernel submissions. Which cannot be
practically captured by such tags, since they are evolving rapidly.

Are you okay with me stripping these when I apply your patches?
Or do you strongly prefer to keep them?

