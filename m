Return-Path: <netdev+bounces-279831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFpfLtVU5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:31:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22442F920
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C3653232B5C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353293A4F5F;
	Mon, 20 Apr 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="voH4XLzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931913A4F54
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692605; cv=none; b=RdIJcGJUHNWKXMRctDhDlFWUO/6qyiS3KqRCkxA7sX1FPniMMhAiFl9ejWZwu8jWmDgeBCmBP72FLctGQZ8DYtcgXmN5JvzeC5xeKZ12/+7UJ5VVFAIEq8tnZSO1Olk0E/REo5SxjOb26oDDJoNvzW9pbWzu4RNGOnsHX0JehVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692605; c=relaxed/simple;
	bh=rogRs0ykHyeyXK7tUMRLku3jZarBPsH1cV9YIgcNcts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiO/wWdeLhgb7qSH1DOnb3s/G9/OBRMA9C4B5piVFbT6IgE43y8yd6eXK96uMAn6kAol9BAORhoD7ETcbEAfe3I2NsO7+67M456jwQnF1b5mbATUPTwv3fNgYMqd6uL5VfqgfEiyTrL+T6GqUAe+lruFCEQPVpfkm1K1flvBIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=voH4XLzD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so40037395e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776692599; x=1777297399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr1T1QwU2AXk21k476IBhpXqaT0faBSmximda28oq1w=;
        b=voH4XLzDtKJQmCbHJ+3NirTZz5XFHLjePkFcZOh92Qg4f441kF+3LM6RCJE/E9+vyK
         LEdz1ik5FNcqVcZ1NooCoe2TIAsIouj87XvQyuQ9yZUC8K6za7caKdKdgddd/lSotzcE
         WQFhnaVxSi+dUwxK5QjBSc9+fmV7QqMIuD5OUZw32/26zgJqpeFQvsNkysIJXpGREPsd
         kooJ5NX41kVR+UWymqXuVAYNl8ITANIpZ/dv0QLbXPRaVtye6pAUu4alziDhHap6aOhE
         1Ds+Sn0E32gWS1KvK/EiBh4LrSzh/0OMM6USs2B8OfAKaOatjuePZAN+gjhgl/Q9E3Eg
         UR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692599; x=1777297399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr1T1QwU2AXk21k476IBhpXqaT0faBSmximda28oq1w=;
        b=sBCA8Sa4uQAXz3IIP56ye7I6i4FqAOFB3f7cK99ua6R15hv41e/xZkVPdQCRmoGtuK
         R/QBEhoHS2pgOKYTz3eqQeTqbRO1v2iv7+RVtCpGRQmlNTCjAFaJVaBbRemltw7DJQi0
         k1iBeBmjyNyVxKpIAt3h5nXBqCRnjm1aOEBYiefaBcMjHzJD6OCWw4s5gkxSCzdjvGVZ
         LpCg+r5ALw/D8fXU7Fu/fPr++UBhkX/yENQqg6lQgFeRirePGiYp3/WbJcruoRhuwsZt
         EBYsh3v1CRNyPCERDgUw0GCaV17NymLPKvcP2HYAR7flLshg/nION83cHDFP8TJdPwUz
         dlfQ==
X-Gm-Message-State: AOJu0YyxbdLKplAFqygA0ra8poXg7Yf56hT7zqi6DqtYi1dJRDg9PiWK
	P5L01TYZQCedfX3NKCjnlrKC1rBmXUgHBxbFuElxtBFpKYDAiLDdIjgRKMZRG9XnseY=
X-Gm-Gg: AeBDiesShYFBO8Ze1mD0riQ0T+BfvEl6G/A1Uy1lqX6DoIEIyZULmCUXvYCTLw32hMH
	Pc/SFn64phSvGXXXXRxJhWe7cdCp95M9HLuSzef0M0X5zJGExpFJuBA35FOMtdT5gmg71VKQhGE
	iEoy7hzWsUOyd1VVQJBaVZOnCSDDZKLoOTnc17vJP7ZZgrzUhQsi8bEX62/xMUzhNX3GJSJm2/A
	TJLNl7GiHdiWgn2M20n4ngusSzVG1CPeMGecr/1nwjF9EGd/MSHAJHLmzKY184djohQgeNvPovN
	zhvMQj0hODJMiYaQUD4syxSHKQVNdzFwbBmN3ksKQGtUr6xamDVZivT4hYE2wzxKFPVgselVLld
	HCH6aTSnjEsNCFO9eNbdp36pkorToud9MRuL+bkXkyWjR66TJD6Q6v8HMWXTdr/3TgCyACVCl5q
	d7Rfic6UAjlMbkZPgTSpZIzj56MAIDNhuCI2wZEw7MM384Og==
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr193865265e9.21.1776692598743;
        Mon, 20 Apr 2026 06:43:18 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm31239443f8f.25.2026.04.20.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:43:18 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:43:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: Question/proposal for DPLL NCO (DCO) mode
Message-ID: <3rgm35qzwvzdrubvtdrccl3sb5cx2ufiy7b5wnjun223bosi45@2bnbfrlqnsbk>
References: <21cce17b-9a79-41b5-8363-faee2378aa37@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21cce17b-9a79-41b5-8363-faee2378aa37@redhat.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-279831-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB22442F920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 20, 2026 at 01:42:29PM +0200, ivecera@redhat.com wrote:
>Hi all,
>
>I am currently working on adding PTP clock support (PHC) to the ZL3073x
>driver, and I would like to discuss an architectural addition to the
>DPLL subsystem enum dpll_mode before sending the formal patch series.
>
>To support IEEE 1588 PTP, the hardware DPLL must be decoupled from
>tracking physical reference pins. Instead, its output frequency needs to
>be continuously steered by a software PTP stack (e.g., linuxptp) using
>the .adjfine() callback. In the industry, this specific hardware state
>is widely known as NCO (Numerically Controlled Oscillator) or DCO
>(Digitally Controlled Oscillator) mode.
>
>Currently, the DPLL subsystem defines two modes in enum dpll_mode:
>
>MANUAL: The user explicitly selects a physical input pin to track.
>
>AUTOMATIC: The hardware automatically selects the best physical input pin
>based on priorities.
>
>Neither of these accurately represents the NCO/DCO state, where physical
>pins are ignored, and the loop is fully software-steered.

The manual/automatic mode is defining strategy/behaviour about how the
input pins are selected.

<header_quote>
 * enum dpll_mode - working modes a dpll can support, differentiates if and how
 *   dpll selects one of its inputs to syntonize with it
</header_quote>

You don't want to change the strategy. You just
don't want that/don't care. Why it make sense to add a mode then?

I was thinking exposing this over STATUS. We have:
UNLOCKED (free running)
LOCKED
LOCKED_HO_ACQ
HOLDOVER

So something maybe like SW_STEERED? But:

The problem is you need to do selection. Perhaps we can have a
"magic pin" to select for this :S ? We have pin of type
DPLL_PIN_TYPE_INT_OSCILLATOR already. Perhaps we can have
DPLL_PIN_TYPE_INT_NCO/NDO? It's a source.

Makes sense?


>
>Without a dedicated mode, drivers are forced into "automagic"
>workarounds. A driver might implicitly switch the hardware to NCO mode
>in the background as soon as .adjfine() is called, while misreporting
>its mode as MANUAL to the DPLL subsystem.
>
>I strongly believe this hidden "automagic" behavior is a bad design. The
>user-space should have full visibility and explicit control over what
>the DPLL state machine is actually doing.
>
>The Proposal:
>I would like to propose adding a new mode: DPLL_MODE_NCO (or
>DPLL_MODE_DCO, I am open to suggestions regarding the terminology).
>
>The expected workflow would be explicit:
>If a user wants to actively steer the DPLL frequency via software (for
>PTP or other Time-over-Packet applications), they must explicitly set
>the DPLL device to this mode via Netlink first. Only then will the
>hardware accept frequency adjustments via .adjfine().
>
>I would appreciate any feedback from the DPLL subsystem maintainers and
>the community on this approach.
>
>Thanks,
>Ivan
>

