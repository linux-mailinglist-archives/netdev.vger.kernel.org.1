Return-Path: <netdev+bounces-283465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI5xJaxC9ml7TQIAu9opvQ
	(envelope-from <netdev+bounces-283465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474C4B3343
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 141E13002B17
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702193822A2;
	Sat,  2 May 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkC/jdtb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5462C235E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746600; cv=none; b=aPQ8TnRxf0e3uBCqg5az2hFx2ua/zJn0yeLCZx5qVknJtBg1XmukaEXpB4u7hYoocdoD5gl0YVZu1OGbUv0J5pzlBUmC4F26W/lUlEHzz3p6zblAc9d1NjQFpXbD58BYJbS3ItsxGTyKkqXxG1wND3sTTp6LrpVzxaZpq/50tSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746600; c=relaxed/simple;
	bh=NoSBlen3yMcbs4tlBG3WFuihOgRWbuKau4R6b09B7Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUL27lzx2j5eCpq9wRD95ZsJB2ic08nyrO7WIdxcnJ4y6ZO+Q4cxlEf4Mo/OBhpXERInZLUwNXMjjsZZa5SgSkPpTBFJ6oylkulRpfMNTIFpiXtCKrdnstaVod5k3cPu9lWXBFSWL2gzjUPYIX4nDER4abinI17MJUPWTNWObsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkC/jdtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EDBC19425;
	Sat,  2 May 2026 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746599;
	bh=NoSBlen3yMcbs4tlBG3WFuihOgRWbuKau4R6b09B7Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AkC/jdtbeiaUFWN81dJ1EPlMKzZFHvS+GQqFZZmeWDnt1+yFc4tA2ptwR9D9o5ogG
	 I30/r/fzqqGdv6d9TLsG4fr+kJrD+70hJo3RTOC57w4TMITTTk5UoysBt5CBHFiqW1
	 8jeE7zp4+E7gZ/dNgxin2jvCsk39OZTDysa+2XAZLFzUCYZxKbZTrnchmTJz4dHaVg
	 aWUHCRL/9MIzueBlRkSRhW8fJnyyg5Sp89FPWncmBmxK84t7yqSHwkLwSqETHQvuov
	 Q35WEM9UpG0txunjrIRosHqB9+FOv9qSQpb/1ii5T0n0r4hbXPdhe/jy5fPsEQJeWj
	 n46VZabRgoyyw==
Message-ID: <d99ca8ef-c11f-4190-bf08-b94c3ac76462@kernel.org>
Date: Sat, 2 May 2026 12:29:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: add frequency monitoring support
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Petr Oros <poros@redhat.com>
References: <20260428152115.2815860-1-ivecera@redhat.com>
 <20260428152115.2815860-3-ivecera@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260428152115.2815860-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3474C4B3343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/28/26 9:21 AM, Ivan Vecera wrote:
> diff --git a/man/man8/dpll.8 b/man/man8/dpll.8
> index 89f17af74923..59ec4208f251 100644
> --- a/man/man8/dpll.8
> +++ b/man/man8/dpll.8
> @@ -111,7 +111,7 @@ Temperature (if supported)
>  Type (PPS or EEC)
>  .RE
>  
> -.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ]
> +.SS dpll device set id ID [ mode { automatic | manual } ] [ phase-offset-monitor { enable | disable } ] [ phase-offset-avg-factor FACTOR ] [ frequency-monitor { enable | disable } ]

very long line; please fix up.

Keep Petr reviewed by on patch 1.

Claude has some comments on the man page in general:

● I found three issues. Let me show them clearly:

  Issue 1 — Typo: "locked-ho-ack" should be "locked-ho-acq" (line 107)

  The man page description of device show output says locked-ho-ack but
the code (dpll_lock_status_name) returns locked-ho-acq
  (ACQuired, not ACKnowledge).

  Issue 2 — Wrong mode values in output description (lines 104–105)

  The "Output includes" section says:

  ▎ Operating mode (manual, automatic, holdover, freerun)

  But dpll_mode_map and DPLL_MODE_* only define manual and automatic.
Holdover and freerun are not DPLL modes — they are lock statuses.
   This should read (manual, automatic).

  Issue 3 — Undocumented but accepted alternate values for monitors
(lines 134, 144)

  The man page documents { enable | disable | true | false | 0 | 1 } for
phase-offset-monitor and frequency-monitor. The tool's own
  help text shows only { enable | disable } and the error message says
"use enable/disable". While str_to_bool technically accepts
  true/false/0/1, the canonical interface is enable | disable. The extra
forms in the man page are inconsistent with the help text.




