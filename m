Return-Path: <netdev+bounces-300515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sPVBKLgyNGr6RAYAu9opvQ
	(envelope-from <netdev+bounces-300515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF516A2087
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:02:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XxYInc7h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300515-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300515-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8139D30247F6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919434FF5D;
	Thu, 18 Jun 2026 18:02:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1D34A773
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805722; cv=none; b=qqIy90iMUnbnDIq+mSDdqKfu4VsXJcbuSpAO4r/1VEHTprS0IE2vECVbCFFQnBTkWLuRSYdnfQ79BnuZ5f1DBS2oaxOF2+51JYCvCHFvdGX2WDJt+kFmqKWZ/CzyM1POLrg8fDF7qEQvpcwsaRY330dcALKTEUDaqL4j2ulD+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805722; c=relaxed/simple;
	bh=rceMiOFNT5IbVb+Iy0f6uW9Ol5m+/2jK9nDJ80jiYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M05RBzfrcO3dJlOQ/1Zj2ik8OwcCNJv6odQBijZdunSEL5y0DoGeGumwtyxMw9Q664BU9oXuglgfqbWnUoEVagPAkhdGCAgnGRiWoX/aJYl/cgsjQlJN3dNJZzsaDLNq/qzRYVCpR51FtWgx6c1x9fxmCOFVBuUWgCTIwsjKFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxYInc7h; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84538597e1fso827855b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805721; x=1782410521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sAapUc3J2AoNA+b13H0L2cysqTGIB0y1ElmSTV/xFso=;
        b=XxYInc7hQMjWg1fPqfitpPuUpNQfQM8TsO1rgxAZVrOoY4YguYa0xWzZGaEavR3BpF
         3Vt94mtf7XrZMB7kBXbnPx73jqHYCUajZjuX1HpuEZk6l69FudC4E1NlL6n9EkQXLRlC
         0l2VA+66y5PiQDLVsftjTU/H4yTAh+ABM7oaKO/s0B081P9zc3fLnIXU3jjo8NnilYCP
         SIdKee7bmKpakf6KW3v64357QGOyizBNgxlwKAVIDHH/WbHrNSwiecXF3LlLv6oNhKOs
         s70Y0fRPPDhtlg3holLFBH9J9o3wjxRgAne97eYuhTTbhmZUIXsj9X6L2LnjzPeaDFVK
         BzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805721; x=1782410521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAapUc3J2AoNA+b13H0L2cysqTGIB0y1ElmSTV/xFso=;
        b=mpXMMO7pCyUduTqu/t48ZkY4WLn7QTkEORaml8v6KOKxtjpcqSlK0MiFyV+BG+sx9b
         cqbU+eVd3EFPYXBLXlptOb6ZCUNBBDF5ekki9M5UdtswDpeO1JZ2VWdDAoq2xT85Qmi5
         XVHgcQSGpf9sTTR8Dtxiysii8lxzpAVxlPxSFEdDMXmEsgdvN6VUhVLiy9TIl8skxbei
         rRLae3sKrzpxMX3b/NLDp6ZcXmjkdK74sd+2l2/IXtbj0lOPhDbxB2XPyoqzGVNVwwVI
         7NyI07Sb35hPQRQD1zcHdnZueSYJCgMGS9nIMNyKc38O26YT21T4SMefzQzDmWCZdySn
         YOHA==
X-Gm-Message-State: AOJu0YylYKhc4YXMKJW0bDuYZKIrIcXQuX1VV3wzj+1hrsoTcQQYa3px
	hV1IBMYYhkPsuLdRPmcoukxq/GU3b7I30ihVuRdkD5x5/gELSJZowzhM
X-Gm-Gg: AfdE7clLo5HPqF1KBhSELzwdnolOnoBr1Soq7++CTU9TMS4f42Afk2/CpuLw9Rv2437
	mAjseopflff3lWWObe+kE3krMoBac6P7Zl+ptr7x3l0qfgqKlVaYXEnyZLHXyh09vbLrB06/xIM
	Ub0hyecJ5n2KOMRmg1CE4SSrui69weuZehtevJy18k5BYlOJEbJ8TaLOqDgRChkhlt+bQKR/BYH
	T1sEaarq4tG9KZYYEEqZJDxC3KIaV3CQan8DL5h97PsJrmQhryuPusjdDulb9V/nvsEMGAkjcow
	9OwNek3OvA6UeJ++8mgOoAq3cD6uvxkC0Aw8RlGpedVgQbLv7cvzmwmSL6XVPyZTLsrdyE7bcvt
	PpdXA7PHmGaKxyRhzGW9XwiR5DoP9i7ji+5OhSdBATdQUKW5oIz2UEpg0kaT8apV2xClpjGtHsQ
	coKrxUxkeqNA==
X-Received: by 2002:a05:6a00:3e22:b0:845:36e8:7a96 with SMTP id d2e1a72fcca58-84536e8a65bmr6414763b3a.26.1781805721007;
        Thu, 18 Jun 2026 11:02:01 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad0118asm18772100b3a.27.2026.06.18.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:01:59 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:01:58 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
Message-ID: <ajQwWe4SC1M7MtJa@john-p8>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
 <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:rhkrqnwk98@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFF516A2087

On Thu, Jun 18, 2026 at 07:56:34PM +0800, Jiayuan Chen wrote:
>
>On 6/18/26 6:27 PM, Sechang Lim wrote:
>>sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>>to find the length of the next message. strparser assembles a message out
>>of several received skbs by chaining them onto the head's frag_list and
>>recording where to append the next one in strp->skb_nextp:
>>
>>	*strp->skb_nextp = skb;
>>	strp->skb_nextp = &skb->next;
>>
>>and then calls the parser on the head:
>>
>>	len = (*strp->cb.parse_msg)(strp, head);
>
>[...]
>
>>unaffected and may still modify the skb.
>>
>>Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>
>Is the Fixes tag correct ?
>
>Anyway, I don't think this patch is a fix; it's more of a hardening. 
>So no Fixes tag needed, IMO.
>
>
>>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>>---

[...]

>
>
>CI failed:
>https://github.com/kernel-patches/bpf/actions/runs/27754218839/job/82113319982
>   Failed stream parser bpf prog attach
>
>Hi John
>I noticed that bpf_skb_pull_data was added to the skmsg test:
>https://github.com/torvalds/linux/commit/82a8616889d506cb690cfc0afb2ccadda120461d
>
>Can we drop bpf_skb_pull_data in parser prog(sockmap_parse_prog.c‎) ?
>And are there any scenarios where we need to modify skb len when using 
>strparser ?

We should never modify the skb from strparser. Just remove any tests
that do this and state its not safe. We haven't used strparser progs
for a long time anyways.

