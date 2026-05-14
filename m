Return-Path: <netdev+bounces-287988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ck7KLDYBWqacAIAu9opvQ
	(envelope-from <netdev+bounces-287988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BA542E39
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF2C13089844
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6B3FD13D;
	Thu, 14 May 2026 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuDcjYLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A03FA5F9;
	Thu, 14 May 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767687; cv=none; b=itUsbQPbCXXZcRHom/RP7z9ZfcXrigeU9ak70ur23FzUaCxqUlu9q5Im6J/JIAVa+w6HPNBcalcBqm/bmHrpkWV/1IcycxHaOH6ZysMDmp46DhfSdnYpZM63ZDjNbKQ+EWxqlYHvgIj1oo/W1LLekXqrBPHLQFwSWT2labzaoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767687; c=relaxed/simple;
	bh=imLyI5VX/UiHKhYAptgg2Ym4C+4f2expui1LJpsnLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDme/EIl954X+mFp6CXtO/tB/Ur1RT9RtxGt8zeTV7iDRmfRT432P0BgO9lr8dVIDnW7MJ8qUIuWiKgXhe1EEpRFbIM8VLBPgfwwMQ7NO9V6M7UPtxuyRM2Ua6vhm4iNGA9l4ps7G4d1I6B3ZBJzN6WK4yEu5RKsfASir+M+Aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuDcjYLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372FCC2BCC7;
	Thu, 14 May 2026 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767685;
	bh=imLyI5VX/UiHKhYAptgg2Ym4C+4f2expui1LJpsnLnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NuDcjYLT7nKnd0/dVsCi7VI7CK/Nn07EJGpF5f0JsHZwyo4MyQzQfZk/mflJ/AKHJ
	 sp7oGVRYOgo0SVEtpUc5+kED425f+b2Jkk0GzBwS2h5ir4AkV21lXDdaGu4kkxN5IU
	 JCUQS9JYW+RZih4AqWYjcoO01F8SdivepOFRPvFf2w31cXaEn/YmQNooH0NXw1UUF2
	 DDBrzVdfqk/JEpwRn76xo0qXfFJMcRPJtG9PTrYtxzRROvEuc74wO4MKz7VfWxz+CF
	 tm4uhkFZaLTx8qY8akRLBFAB1A6vL6qH023mThLlpRchfl8G+I2VY4CIBID6tewI1l
	 bW+Zn/j5KPz3w==
Date: Thu, 14 May 2026 07:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Rodolfo Giometti <giometti@enneenne.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pps: make number of PPS devices configurable
Message-ID: <20260514070804.7cbb6181@kernel.org>
In-Reply-To: <65a3d091-0648-4c6c-8062-869d0fcec8dc@linux.dev>
References: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
	<20260514065526.2ed937dc@kernel.org>
	<65a3d091-0648-4c6c-8062-869d0fcec8dc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 640BA542E39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287988-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 15:03:03 +0100 Vadim Fedorenko wrote:
> On 14/05/2026 14:55, Jakub Kicinski wrote:
> > On Thu, 14 May 2026 11:26:14 +0000 Vadim Fedorenko wrote:  
> >> Modern systems may have more than 16 PPS sources and current hard-coded
> >> limit breaks registration of some devices. Make the limit configurable
> >> via Kconfig, keep default value of 16 devices. UAPI has to be changed to
> >> support maximum possible number.  
> > 
> > Hm, since this is effectively just sizing an IDR maybe we should just
> > bump it to 64? It appears to cost nothing if not used.  
> 
> Just bump to 64, but keep it constant? In this case maybe 256 just to
> align with the max minor value for chardev (in compat mode)?

That's fine too (the value is the count right? It's not the max id?
Cause 256 would spill out of u8)

