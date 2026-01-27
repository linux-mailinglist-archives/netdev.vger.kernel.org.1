Return-Path: <netdev+bounces-253813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MDmIq6aeGk9rQEAu9opvQ
	(envelope-from <netdev+bounces-253813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:59:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C089345D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA68302296D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC2336EDE;
	Tue, 27 Jan 2026 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSiLfhmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7434575F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511591; cv=pass; b=Pe3GSC7EqUN9NzX8FAlLbUXfCPSz866LuXPOrPxNJ+IUDLVZHqPxqWQZGO0LlllMEnNgd0D8zCoDXBY1ghustxayWgrF3ZORBD6gTTX9ARxqB3r9AEzrtGqshDPCLMbokRllIFl+SIviaYvYyYCdHeFQxVU7Ngu3CyNkgkEsHJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511591; c=relaxed/simple;
	bh=BECvrmATlKBwshE0pKD8YMPH0q22JCw7MblIaHu1gcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEmECc+nGUMY8teZKu5nuJhnu6Dp2UJoayZRbdi2QpGxt9E6wd++BryIdMFCoWTsrRsUD9S9MtG1RoBCK1xpyzyfJX3NyBalQeYiJw8hdMBL5zihC+xg6GIqnx5fjLK5C+SNq+tGNfvUzfCqIH6VquKwFEe2ltyVj6QK8bJBZ6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSiLfhmm; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd490be5fso7274618e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:59:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511587; cv=none;
        d=google.com; s=arc-20240605;
        b=gzLe8fr2L2vzmr78UB8T/SYt+JGy5v6mgQTFi0ByFZpoc4ZXiDF+atfNSf0cW4ecIc
         9p1yrLJrjpLG6RXjVvJ8UPY0lOYnCGO8OJVOC0e2byELpW/RETsP9z81+G2bZ+6jkoQK
         EV45oPxfgQmfxfGwL82xhAYHj/Uoe5R63Afjw/QT282pgCOc1sgAdDONSyWQ+Pjr5lDD
         S0P2OsE4X4ijNufCAfk/mQ9eyyNXAnKYmtiQwY5AS7Zsh9/NaznTbnyfGQqo339QhVSD
         bwWsq6YIyO4n3Dagedf4Uj/x3aZL/st39rwh2HYmIRVZfCuCXT1XmQ3xTrAng27LHkhi
         3UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WYsfFHIplmOm9N2B0bIUCqqqwv0zYamUAJ//iJfYf5A=;
        fh=XsSkTL9tY5x91IYJpEXbak0D/VCDYUXyK93oJCK5NbA=;
        b=GZq+Mkxor5jLw9l+qW2IZTBaQ1aTSMfWCoBzs2ZPJowvOggAGjL05iQVVes/SlCBCi
         vl3Ru7CrOVZXtfvVStywAY2Y4M2ZimGM/poTnGoWQ0zMoVrKiowyWgaHUI6dsr3yGbwu
         f8CtvVnylof7K5dJ0pyLeAxH59dw3eGn/OhJBb5jV8UJabZffZQOfNz6lx6l/Gj0aAvq
         WtDmeNKj9KLrJbzPogtqZQvxZtwPMDwMJmPthIjKbVBGE1ODVExnwv8fLi1qaGMN4c0q
         xLqvcgp+0jh3Ph3nv5qP8pQXdWgdMR26K6V2AqwHEFMHKW5VJI3F5oS19h05Iwy/KCnP
         1p9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769511587; x=1770116387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WYsfFHIplmOm9N2B0bIUCqqqwv0zYamUAJ//iJfYf5A=;
        b=YSiLfhmmUhBhJ8UB/7rA3oQQzDOCg2xveCdqBGs5si2z4aVjBS62qgHDsN3lauL78Z
         7a8SXQhs5LD8FtlQez2oIzL1s2g/Vkbfob6qvBVYWQx6kqT5npUxWnqX6PbCgf8+1hui
         RGnXEKFPZoskXbCn0WUacJYRBM8DykMMzaSWAOtnKFOz6G7sTkxp8sYtI1FzQLJt3bO/
         +vclPJxovWIzvDp1kn6J+dK4fi6qe8Hd7Xq0PPTGl22rRFZ+UTdOmCUYgIFZ6e2HHEyb
         i6UrgvesIMGqC3Heddylm9FFMwuwnQYq3aJnd5Gr7z/5UXh6sMLujSlhDjkykAsNFa81
         1NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511587; x=1770116387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYsfFHIplmOm9N2B0bIUCqqqwv0zYamUAJ//iJfYf5A=;
        b=clp8TS8a75WxdlQTnIZuwGk6rQ2lHvB16Sry8mcwfw2S3tiEkT2pr6lmJAxIoliobv
         z9MhAX6D+XvVJTJQJ46mz/zV4ueq4kKCKiIm5sR2vXpN76Fqllh6BFHjmjx/cNwkjra0
         dMcYSmEK2xL7+WDC1cO8JyX/YaihsZ1PQSZ8oWkqJEwfwtdhXeiXQGDZL5YTPZFHMkgT
         B5czMnhGLDpu+aOeIIR1QQBW1VtRSBYO+K27mrM3McQigeJOo/0LNImVI2BsIjkUHk86
         p9wgo/3gki1uIg38+Hr0NftwhVUSbWbLLukldT7GWD89zFgI3v84fzSXiu6K3EMo/Vy7
         QN+g==
X-Forwarded-Encrypted: i=1; AJvYcCX8SpUm9P1j6XnTnG3jsnioPB0Y6qyKsbsrRw8+XAir+X+IJMDwPFntThXpnUIljWRBCwfz2mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKx7dVAHKyUWzAMqcqJTyC1ojHGjieWF94LV/ruUX3uI2D5tq
	MOlZ4QmAMt1/LRqUYGmQKQygeDyElbcXX589ahihXppmPJK6NVeFZJhge07NXrbawiNHFq6NsBy
	HhYw2o7skcedB6+dyozseSMhvwrljlgU=
X-Gm-Gg: AZuq6aJ1pVIRMFqsDfvzbKOGEoNs15Cndykzjpjr46rPjA+dHaafnRyzHcZylXBnCjm
	IuyP65QWk0EUjVgOqQqhWq00yTwrP853eXri1YJzEiD/xfLdNgJNE91ADzmJU0ziWrLXYXS8JlG
	7awB16DXOxDcqiXUV2D+9bw8BYRhZ+xkFkxAL2p4SJ+HhEJ0xZNJ5qMun4Pl1OZAESreTJzakz3
	rJEVSUwBLguYG1G5ObqlsjD8Wg9Ps+6+jPqQOEIWYAxlciJXcyCpnww2ZQDsedzovj9w+8wiHyY
	eazTppLw9mUskc7GmhCSGLlscQ==
X-Received: by 2002:a05:6512:234e:b0:59e:14f:a4d7 with SMTP id
 2adb3069b0e04-59e0412c504mr596109e87.27.1769511587201; Tue, 27 Jan 2026
 02:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com> <20260121184621.198537-2-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-2-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 10:59:35 +0000
X-Gm-Features: AZwV_QjjnqVDqp9AOjWvw9Flzx5vLDm-5nUzTQmwPn_FMTo536uddKntxFCb2_w
Message-ID: <CAD4GDZwy3B4pYH8q+MwY=NMNELjAcdwwk-trM+vAKhyvQCzH3w@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] doc/netlink: netlink-raw: Add max check
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,protonmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 38C089345D
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> Add definitions for max check and len-or-limit type, the same as in other
> specifications.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
> index 0166a7e4a..dd98dda55 100644
> --- a/Documentation/netlink/netlink-raw.yaml
> +++ b/Documentation/netlink/netlink-raw.yaml
> @@ -19,6 +19,12 @@ $defs:
>      type: [ string, integer ]
>      pattern: ^[0-9A-Za-z_-]+( - 1)?$
>      minimum: 0
> +  len-or-limit:
> +    # literal int, const name, or limit based on fixed-width type
> +    # e.g. u8-min, u16-max, etc.
> +    type: [ string, integer ]
> +    pattern: ^[0-9A-Za-z_-]+$
> +    minimum: 0
>
>  # Schema for specs
>  title: Protocol
> @@ -270,7 +276,10 @@ properties:
>                      type: string
>                    min:
>                      description: Min value for an integer attribute.
> -                    type: integer
> +                    $ref: '#/$defs/len-or-limit'
> +                  max:
> +                    description: Max value for an integer attribute.
> +                    $ref: '#/$defs/len-or-limit'
>                    min-len:
>                      description: Min length for a binary attribute.
>                      $ref: '#/$defs/len-or-define'
> --
> 2.51.2
>
>

