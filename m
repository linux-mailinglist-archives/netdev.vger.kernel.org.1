Return-Path: <netdev+bounces-303246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TkrhOhfYQ2oUkAoAu9opvQ
	(envelope-from <netdev+bounces-303246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AE6E5952
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:52:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eguBgHH2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303246-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 205E9306BAB1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EA743CED7;
	Tue, 30 Jun 2026 14:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355F43C05D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:49:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830981; cv=pass; b=YxzEeUzh0AmCVPFTI4Uc4xO6Vr5h6EH7yt6D/eDziaOKg2CvGy7CUFK+wIk58ombnDRRT8cU+YrvFVSKJSO0XYZKfyE4FYRb6Cy+5cJ1yKBcfoPjMvJYIU5I78uaHqbD7VFyHQ4fcoIaeg5GC2S5DOuygFqN25+26HRXtbdWoQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830981; c=relaxed/simple;
	bh=R2RLlWKV31uw1vmm0eE8g4HAQBST/y2tQNtzmoB595w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDIxP2O9WTSuKRC6lvhBA6HBUUUPTNwFjDo6S5y5sBknZtPFy4c2GIHdKWpS5pW3Gf655Tr80BjUZW9wZs6U9ZuAk1UTHBdXF54EprFGMtCExdfHl+UGVEBbRU6Y6wH/h3qd4JI5ahQBVOrS9HX8BfqiT+31aP3r05h/KVLXhK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eguBgHH2; arc=pass smtp.client-ip=209.85.167.49
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb89359a3so2132342e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782830978; cv=none;
        d=google.com; s=arc-20260327;
        b=F7lU5OSC/z+9yKEjGU+arrB0vcHjvEwIYFLOhc8SDYFQoeJ0r19M4qWKycQHdJ6JP9
         GhCAYG6T1GATtYKibKJT4qpAD18U+U4h+qU485FC/T6bfWLUcr0ycPNORKezKtp1hg+r
         fN6U9op9KHGRsUlVu97nHcjPWevn+q9XWHz9rZsHrZN5CBOk9UemXjq0IFTfyYslPH5o
         AbqCpQFKY8F5DVeA0gEGgp0xv6ZBpUou2GFg1my+vc2jAMKDqm9vo3/z/Zz3FhLdG1nC
         jE+yMb7UwzlscwoNpJm5gfKnNhGwD9p9vULY1kQWlUNLwE3TsFrZ8D/ORwxQ86ZsvTWN
         JR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        fh=b9o9xs7mxZEzFiU9iX/E9tVoZ56wmfpCcNe9kIcRFNY=;
        b=UwwKSlS7uUEmNo2xqOiJop13EORl1jTR9x4sUQvKzFbTu5S4qgV1RriKey96jQQ2L+
         EgMaMMI9y8yd0UZ7rUyvvb61WJZjLq6trRaNtFq9bSVW7D64cNWINVNrMaWExO0UXngy
         v0XE+OprkDsfGA0tjfZIYtJHG7q/1wz7etOhGR2k3B8RJu2ZqrYfUMyqBAlkf3Cpzs/d
         idsWwQcqbPwdINmyvlrqTv753YvKL9nEaGrLlT0iJg7GKo9Naj+sTkWVPr0A/9KHMFCi
         oyINa2Mitun8vfVpSt6HocrgTrM9D4QAg1f0YvjkyrPvW0f4rUZPuju6S7JYwAb2Y7AQ
         pe0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830978; x=1783435778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=eguBgHH2CoPRAyRaOi3uiaGSli4ODNgt+uvPY+h/SIbi3UUzw5fgIYyM6JQzztjeNV
         3JlZ/ToxMazHgtcSpYy6Wanx8ZqhDUqqumustyQxJN+22k7vxLd4LMYm7+P0yLfn8pQ9
         JmK4CXxkJxFZX5JST3Z2ucXmDLXruN8OwppFZNOl6Ue/Rze31PgrmjMVcdVChqaVzkn3
         9z6twiYp4Zo1H82GIHWlqKbcTI38vd2yEWEiZYcXIzue3/HMx3mwR50ZIJUVf2D/Y4gU
         v2SGLfGE48Xhlw6IlpE/3my5ZFDfLd1udwdgHT/iCfuo1uBXsQroYQOJpyClQUxBsTNu
         CwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830978; x=1783435778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=DjYIVlWHJDQ/XExBtVnDW1Su7QMbbInluwIXll7ATM4GWtsNfBHIrUEfnzjGapxx+A
         sno9ICC7+IxZNFgLkatllSoHzFwMcPTcrsw4MEgljPcpLrWAx7bwa+ectBE6L+pkmzr+
         stuH5F5kRy5sacpJkCx8yitL44YMuZu+xwdy0QTHx7KN/gTXjJk4ohJY8awyk6wf0Jq4
         tFalXbkXP7VAsS7ASG3niQxep5q8WEUUr1zBjr8ngnKfM4oJA7da2MyEF979v5N1g/Nk
         uqFFe/arHnsS1EeYf8MWL+riJbw1tKCf3B4L2NL1QwBgaKBEHw5N8H6RUHwP7rfayBBO
         8BCQ==
X-Forwarded-Encrypted: i=1; AHgh+RolP/qHkUzZuCMrebLT2R/0eig3mtMY5sQD9AloxlWFIXDvzS85RDzMljzbSdD6OJpG9xi6G4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVFnwNJpZp2ncsa9Su2hDqyA4j/4CvOzOIvLZKPzsnLymhci+
	sPrAjMcQiTTEdlZmAR2txaX0s/LvHQLKYWAq8nW4HVSO6Yt4eltBLkkDCusjxjRDdal+A0QYIZ5
	yuUfIrZtHzl+y5SBmTr2hp3nq28uRxZA=
X-Gm-Gg: AfdE7cnf/KyKXOZ2QoW+evROif8/mhQ85NDACoGRALUpsKy8wYX3jI+8mGZPgVetK3e
	CcWUV8zdy+uWqlt+HuL3p4e2nysU3JgQtol9VnlT4t8e2/2mi3tPYPNfNaWwR+/sCis0lDeBdaQ
	14DUBuw5cxVryPGaCdQdNPIQKsfXsn7haoFvIAJlkIk+gKjyRYWHNW8CK2WBdvqM9pSfuIyg8zL
	/HJof/IcnwU0sxZPQPe1bN6EQek9IntxmHP6DPt4UU/rJ2oUCSyl3VpnmOxJxl9jN+Yk8s0yLRZ
	hq0N/Yhb0Dds1sCwb2TJI+oEAGzNLSdy4737/Ib0AcgB8caKmVYP8IMNtxJyr90Gen5zC0/cq8z
	3rvVeYta+6B2mJpOBJguW
X-Received: by 2002:a05:6512:640e:b0:5ae:b6cf:2869 with SMTP id
 2adb3069b0e04-5aebdb9485emr981524e87.23.1782830977995; Tue, 30 Jun 2026
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aj5KJEIsTl6IK0nX@gmail.com>
In-Reply-To: <aj5KJEIsTl6IK0nX@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jun 2026 22:49:00 +0800
X-Gm-Features: AVVi8CeNolHc0bWFWi94se6V_El3cArCALeJfgf0e7sVp8JXgJSa3XDzBUrtcNM
Message-ID: <CAL+tcoA6=_paEdqWaY7-VHdBeAxEFeMCfTECAEGv3C6ZqFUNSw@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] LPC 2026: System Monitoring and Observability Microconference
To: Breno Leitao <leitao@debian.org>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, 
	linux-mm@kvack.org, iipeace5@gmail.com, gavinguo@igalia.com, 
	linux@jordanrome.com, amscanne@meta.com, sj@kernel.org, gpiccoli@igalia.com, 
	Daniel Gomez <da.gomez@kernel.org>, mfo@igalia.com, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303246-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:linux-acpi@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:iipeace5@gmail.com,m:gavinguo@igalia.com,m:linux@jordanrome.com,m:amscanne@meta.com,m:sj@kernel.org,m:gpiccoli@igalia.com,m:da.gomez@kernel.org,m:mfo@igalia.com,m:platform-driver-x86@vger.kernel.org,m:acpica-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,meta.com,kvack.org,gmail.com,igalia.com,jordanrome.com,kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,lpc.events:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 949AE6E5952

On Fri, Jun 26, 2026 at 5:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> We are pleased to announce the Call for Proposals (CFP) for another
> edition of  System Monitoring and Observability Microconference, this
> time at the 2026 Linux Plumbers Conference (LPC), taking place in
> Prague, Czechia, from Oct 5-7, 2026.
>
>   https://lpc.events/event/20/sessions/262/
>
> This microconference provides a valuable forum for key engineering areas
> such as:
>
>    - Kernel Health and Runtime Monitoring
>    - Hardware Integration and Error Detection
>    - Correlation of Issues (crashes, stalls, bugs)
>    - Virtualization Stack Monitoring
>    - Memory Management Monitoring and Observability
>    - Anomaly Detection Algorithms for System Behavior
>    - Automated Analysis, Remediation and post mortem analyzes
>
> The purpose of each talk is to share challenges and discuss potential
> improvements. Sessions will last 20 to 30 minutes and aim to encourage
> brainstorming and open dialogue about ongoing issues rather than
> delivering immediate solutions.
>
> The conference acts as both a knowledge-sharing platform and a strategic
> venue for guiding the future of kernel technologies to better meet the
> demands of large-scale infrastructure.
>
> We invite you to submit your proposals here:
>         https://lpc.events/event/20/abstracts/
>
> Please select track "Linux System Monitoring and Observability MC"

A kind reminder: at the bottom of the page [1], please click the
'Submit new abstract' button so that you will be able to quickly
submit a new proposal. (Admittedly, it's a bit easy to miss the entry
especially for the newcomers)

If you have any questions/suggestions/problems, please do not hesitate
to contact Breno or me.

Again, proposals are greatly appreciated :)

[1]: https://lpc.events/event/20/abstracts/

Thanks,
Jason

