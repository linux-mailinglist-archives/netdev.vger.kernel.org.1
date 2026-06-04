Return-Path: <netdev+bounces-295474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hEUvJmMHImrnRgEAu9opvQ
	(envelope-from <netdev+bounces-295474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:16:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B610643E9E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j9HLeZFz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DAFF3028C73
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBF23EAA6;
	Thu,  4 Jun 2026 23:16:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BF5CDF1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614965; cv=none; b=diNPEi21IBIkvbepoixnlzTVmOqFwsHT/TQBIRicGYIf83sAKicOL3QOTpSgSqDnjwnWxX/WdXzSRub6Ny3ymVGklyOA4aKvnipNh1GlMwFutXl79AthlOhGp89JajskihWLk17lylRs8mf+zB+DyCrQVPCTL3qj3BQccp/u8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614965; c=relaxed/simple;
	bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjbGntyEQiKEb7gs0JhIuS2Afc13NVgVq/VSV7RKqu+NLyi8gKPcTiwAZJkMv388Z6X23B8DVTELeb8cRvyMvYgE5fQ6d0fhi5iiofTWwSz9HLiwDHg0SksRKvUJg3bNlPiRQdisxgMwF/ExP+lYBx1hMJcBGyCX4UTfMow4sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9HLeZFz; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso800708a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780614964; x=1781219764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
        b=j9HLeZFzTnakEYid8CsgKBoGNJoYeehe4u347ZVqIauAyH/dcPOQx+u+yZbT6U6sy+
         Rn2HO0Nbr5GCGVm5CExbc1Mt690tWpkPGnR/+ZdqhZZHY1xxujdOiywUY9SneWUt1IhL
         Hgh/UCWV8v0T/VkTFuJs8zQD/EsYzqygCoYTQPpykkPDsOoMSOJUhMzMy/ACVUhghKu5
         1dRweCteKHZ8yh3PQNFzB9ppRiMJCwn9sI0+E8dQMLK5YYI6Y8Xdupugo3bRMS9kgGev
         JmD6ioSSpVemfI1rcAObG6HSf0mQHYD17j6ePaMms0dF8NWbq+T8RozZgwSxokzBTpzC
         oW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614964; x=1781219764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
        b=UY+myijsjitaD93sWLhznnfa99dlXgZUOqvzCWbaVCK+kqpdNkY8yz+7dJjMIC/j2Y
         zxOpMrkct0FY/Tg91aHY50zdYmuwj47udDyzgQI22aFMoI1wUTblH/o5Vf++s3G1J34S
         447fvRuLoTc8mIIvJQ0c8000chV4G5uhK4FT2XpfJie46inE2E9pk/347jrfr1k03966
         Avx7gmAZ1m1AWSa5MEwgM7iZcZr65GgzikNFaRln5pS9jqAyvinmNxkdgyapqm2A6XtC
         jbLw/n6M82f31WPhsO7hnD1de0tYjJrjqHZrm7nokuelMVp8sn8+MjSaJgQRSfHF2KZy
         kbGw==
X-Gm-Message-State: AOJu0YyalR2z0JcrUeqmXpQHeguKD/b/MxbdJIwp4jaUB21rKdjOB3Al
	joPy295RvYeF8XIoKnQfc0qZJ9/GbdDdTtgZ9TQ1CX25PZ2mCEjgK7/t
X-Gm-Gg: Acq92OFckB0n8dRDeEKjCLQ0JdCWtH+/eRgwy67p0mCJJ/FhQbYC9LbMIH3KIthRJT9
	HbMIkxnC4N2kvuKla+B7jcb6kludBWFCZEaVm4LWqclE5B6WiRAMSt1LmSekvsRk1p0rXEVBiM9
	sqnZON2GMnj00GVbo6T0dpIsCzoMotY4l9GH+ExlN3BbSBxDIP8iQpd6WXeg8PLE3XsJ+/nK1wP
	ko8cs1ppu1RyN7Ry79Lelpz7gUY3uYqYPxycmFPyiVhtvO12kIXaPqJzcN1dWdKPL9t/+OxS5rX
	Hln8cvcQNbXZ+n6CWfQRfPUE4aS8o8qHbedcIL9J7U3cZqR9WzsoZzMtuToSmdiPXVcHFflSJT0
	/+NOHUufNRdd6i8xDlZHJbCFT3mUtCPAf3799jMvbNGqXBtGv8i2TUWyGd0Kv8b1ULS8j/LzDWz
	QW81w3DQPvma8d1Sh+wFA9kOtc/hNtx+kSHLhJSuz+z7iJ2OsaZWzlmTfGs/VQww==
X-Received: by 2002:a17:90b:1d49:b0:369:1dcf:4a46 with SMTP id 98e67ed59e1d1-370f086eacbmr945034a91.25.1780614963599;
        Thu, 04 Jun 2026 16:16:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c76f55asm4370624a91.7.2026.06.04.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:16:03 -0700 (PDT)
Message-ID: <ea9c2389b73ffa0625da6365b4f4e7fde3b3f6d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on
 acquire_reference() in check_kfunc_call
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 04 Jun 2026 16:16:00 -0700
In-Reply-To: <20260604220904.1032145-2-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
	 <20260604220904.1032145-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B610643E9E

On Thu, 2026-06-04 at 15:09 -0700, Amery Hung wrote:
> acquire_reference() returns a signed int that may be a negative errno
> but was converted to unsigned, which makes the subsequent error check
> deadcode. Fix it by declaring 'id' as int so the error path is taken
> correctly.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

