Return-Path: <netdev+bounces-290202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMFrGLNrDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABA59DFE3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3156B309214D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58FD33D6FC;
	Thu, 21 May 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFTF0pde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1632E134;
	Thu, 21 May 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329800; cv=none; b=a45imBGoIhd2lOnpoE75LZ4Tdd6ODyFp9/GXXzaDQZsnzxx4RKy9p0JoUUh6br0+FJmuXzTmrIHl+xqYS3sbBH43ZJvJYzSIUDKENP1vBJ1pn1RgwyUUFop/kWevjrOQEjA0itOQ2tFxUfdDJKj15d+/qxbzCe8nmloDpUZpJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329800; c=relaxed/simple;
	bh=5NNfixH43rJtIbq0/JHV8UMMN/w6MQSF5gq/5wPqC3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTZc++XV+MBU6JGCs9yIy4W4Cvb5YKUkOFcwEy4JCCEY3Q25N8JeHeZW4kN5gyYF4YXKWzYF0qphoyc6jkKno1ZjXdJyK3pJHSjkZJjmI0MQvQ7ruHeXpQQrZ54T6ztNOJMtTlmEBYDmNlrzjVDYOBa5GPb0SeDKrwvjbJnohnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFTF0pde; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADFF1F000E9;
	Thu, 21 May 2026 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329793;
	bh=/Bp0SYVMP6JwekykUnpp109Yxa0slvT9rm10mIA60D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HFTF0pdevcJ2ZmKPVbmFLvzZGw1jxvli9uWf4+q7fporrrqx0aY/aTkzKBQnhpT2H
	 FMbQnQplvuE5OmzhPGW7lkgdXDBrVckVxhXahCopMY0dRtKofd6cxGvH19an2vtDK3
	 m3R++EBXTliVWCGrDIoLu2UnIGCwdttEiLbYmH85pQ2ZSN+DicUNFJKS8FZjaayQ74
	 dHXQYcDWdaEaD88OWJ+QAPB6ON3yMDjdYcfL2ugN1w/oxEHTjxuaYodA8gSKn96si6
	 IkJza/lCIyIHSb3y76s1Bhe58/eM77IdJqX09YZ13QGgeIrASAYolAZ2dp1f53FV5c
	 CO/VoyG0LtBbQ==
Date: Wed, 20 May 2026 19:16:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, Michal Schmidt
 <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen
 <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: add DPLL_PIN_TYPE_INT_NCO pin
 type
Message-ID: <20260520191631.639a9820@kernel.org>
In-Reply-To: <20260516175744.26749-2-ivecera@redhat.com>
References: <20260516175744.26749-1-ivecera@redhat.com>
	<20260516175744.26749-2-ivecera@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BFABA59DFE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 16 May 2026 19:57:43 +0200 Ivan Vecera wrote:

> ---
> v2:
>   - Clarify int-nco pin type documentation to describe frequency
>     control via the PTP clock interface instead of generic "controlled
>     by the host".
>   - Tighten FFO attribute documentation for INT_NCO pins to describe
>     the DPLL's output frequency offset from nominal frequency.
>   - Mention both fractional-frequency-offset (PPM) and
>     fractional-frequency-offset-ppt attributes in the commit message.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Both patches have SoB after --- and changelog, please fix :(

