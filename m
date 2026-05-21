Return-Path: <netdev+bounces-290339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJogHe3cDmonCwYAu9opvQ
	(envelope-from <netdev+bounces-290339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 438465A3351
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26D7F30FBDC8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134F3955C4;
	Thu, 21 May 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPUhabzh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A33389E02;
	Thu, 21 May 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358685; cv=none; b=OpRo0ri4Yo+MTgMVm+4gRJnRFpbMzE812SiHDGKHbcIBSK0uK/aedDEwTlffbI8S1rGheicr45ss3qf2Y2s35YNiSp4TJnTWqSRYk3IG/Xx7rcTORqChCprPwVJGq9zOPFeZdB3gLvptpDGmz5YqZfXCMAHwkDS5RhqF/vUjRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358685; c=relaxed/simple;
	bh=G9dUDE57/plskdTOGXGFEUmoJDGDjy6KP6TN1k4cH5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI1K3B0GgO5XJ8qGs90wQvbFQ3uHUXHL9Poipr5MVjN11O+K/OmJ7trdVtEUtUWAxzSp1plZOO9TeSemlZTR9OXxhVQbgzizhj8+fUHZ0io+MTCWnorVDnM12wFu49senAprez9F8nDRlpK83K+hIBwZBuaIyTZ4Dh7G2cGkVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPUhabzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8C1F000E9;
	Thu, 21 May 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358682;
	bh=cWklvZ0hMHT0iogyKba21Wxgt77edXzV0ISJvMVJQ9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BPUhabzhrsU06hASnrmP4UJERr/cN59RiKfzgMzwfGfZruTBPzro19zyS3w3xoIEO
	 ALv/ZpRMPTUXe/W/cHjjMKY7J+yPZNOqbM1Nr34RxPNbDbqjy94dL0oSM9/u05+6RQ
	 N3LSLEZ1+wJdsPdc+rfimQrBUBb8EZ3iQZk2eTQhfsSSv2ccSFjFMrMa/n4Ik/++v/
	 8XqDIckAiJUhzNCW54Y+Zl/pdp+iLHoFf1Joma3OlZDg4mHJwRFyVxHomnuROMSpVb
	 hdPgKSFlI0EW2ZXgX49QnBfH3jXO77sL6M921cdtdUR/MdmDxVr6eIk6+JgIRwoAuc
	 SwTMXkfk0yoTg==
Date: Thu, 21 May 2026 12:18:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <rouhi.ali@gmail.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Subject: Re: [PATCH v2 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Message-ID: <20260521-happy-celadon-hamster-94802c@quoll>
References: <20260520191943.73938-1-arouhi@sitime.com>
 <20260520191943.73938-2-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520191943.73938-2-arouhi@sitime.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290339-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 438465A3351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:19:41PM -0700, Ali Rouhi wrote:
> Add vendor prefix for SiTime Corporation, manufacturer of
> programmable clock generators and MEMS oscillators.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>

Mismatch in From/DCO.

Best regards,
Krzysztof


