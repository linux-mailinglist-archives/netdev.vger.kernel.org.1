Return-Path: <netdev+bounces-296160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VS4XFUORJGps8wEAu9opvQ
	(envelope-from <netdev+bounces-296160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:29:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5064E688
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:29:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=bjc9r2pQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296160-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0C803014C55
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69613C5DCE;
	Sat,  6 Jun 2026 21:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0C3793C6
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 21:29:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780781368; cv=pass; b=CuggoNWzWE9xqXl2vqzekrz68R7vaHJATleXcr/A+1LpCs/UxRLlW/0zrspjvVZENhvjrXXOjAiWhqMTGLFfwOod8Mex1iusYhmC4byNVwiAw8LHB+2PpApev2EL7nL1flMsC7jL3gE7H9M5fBmTinQanCBALzGomK1+oKSoFdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780781368; c=relaxed/simple;
	bh=JxM+mGu5ioX88sdAXbddE3qWPX4MmpyrMeBL98/pJs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR/m7tCA/a4vu5S5OqA5uBU3tXVX+vtd5Gfaf7YvC1P9Wi/YB4vHVafrHQQXF+lY2CcAWADuipSgYR+QUJIaOdpA6q5dzS5Plyse9sWBBIg3C23ss2Yp+nZiOcALBXDD5nvX5O8XwjZtqgvMsNovspi2NtkKX4Zenp6qQORPGmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bjc9r2pQ; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84230ab8857so1334300b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 14:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780781367; cv=none;
        d=google.com; s=arc-20240605;
        b=KfjgZxeVXTBdx7akSbnYYhPikm+C/txwfHjF08n11JZ0TkD/dPKbDImI3iqsIbXPsD
         oFMSEFk7P/ftPWl7ZLPtqHvIlwImrsBEbpZOzaOnzV7ZUpUlRHB6hidbcAx3oCtuMjX4
         Y/l43J0FDeo1ySoDGZ4NeVrOGi9nWgNslBUlgcsI8G4bQPMnzR12R/p2qlcJzX+OxZCa
         R5YnZa9zuHm0KWm9ZW5RhmSlNcT1JalCgrVNd7M0Lz6GPHaNz8tlOAVdVVDPPCIoovsW
         VtECVH31TvCqrPZNItP8EA+zD3SsRKvf2QSOMORuVGGXd2vxn+Y30NQIXER+MKMJ+8+3
         JjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jKqHCCUOtukrW4wUq4e9m8O65I6oe0zpEm5iXZUodEU=;
        fh=LIUp8473v33OkWVCA89b+pArUxW41KQX7cYsFCab3fI=;
        b=e8l2rftsQOyoYoJrRxa3jVjdkZN8WKAgCtVc0GvFUc7uL+nrZL2vtigOdkaCxeMgdN
         vijPhE1XTo+YNmQ/fBmGcFiX2Dl9McI2LyWq4hRkiU3rd1KJ7UO/izCxqtG6OXjsMQ6D
         VaZkvNJaIXWvxZHf769LqbBPkwt16cYYnOT5WbEH7dnrbit1X3WFnp92/gxqClbao2sH
         NMk37u8RemzLuLXTBt60dzavmmdkJOkOXuCwYfSucaA06I/OdQqwLyi1zoxOsNU6qf7j
         OUjXSAFzmblQ7tmaXhkpDz5j3Mx2+oEQo9zMWctnS3KipSmzVWkQVm510VihhRS4N+TB
         a1DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780781367; x=1781386167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKqHCCUOtukrW4wUq4e9m8O65I6oe0zpEm5iXZUodEU=;
        b=bjc9r2pQQpYNKDYk04z4tLiOmV3Jd38YrYYM0wBNPCryXEGTdLweanz4hCTmZvVNdX
         waLHlkBumf/LDX9OPAAgw+OULbumqCvioU+7Eb6AsM8OL5qDgwYKith06pQZBoI9/xZK
         mL6bDMjtnVVrOEWpn5Xgl+SEtgfAmE6IBBJkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780781367; x=1781386167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKqHCCUOtukrW4wUq4e9m8O65I6oe0zpEm5iXZUodEU=;
        b=LJekWVGp8gTiGU/25pQa4fBs0CrE4nuH8XVVtJsZMw2y3pbupjQbX7x27KONU7mRSH
         fTk3PE5bgOTIbL/IWdMEs6z4t9vbKAt2b2f3/sT9cLYNlMv3o7deePciqy791T1E4vhb
         ZIwUGgYAA6eXCwgXDCNbdEy47jKMHjvXdeiIW0rFUR4UIgkd27vBIc4fGoiOokllCrIc
         0NnloCU9K59lyF0Oot7mYMiCfMCjVmBaDdHDu/8Fk/MeyJTWcZMTJDdgn7ojAjNykscn
         3moIihqGeT95b2jTzIbvDkuIzCDgX9szCOx55I95ArhUXN8wCKukS0h5HAZwW3ANOOoW
         jouw==
X-Forwarded-Encrypted: i=1; AFNElJ+9RShQI9eB3xzhmYhB8xWsr9wlktetKp/tFimpGdrOY+jc0wioX68UGunhKI2h3c98R/Fe7Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OwukJQSvN4ZyBgf0IOVkpdaDtDJJKPoDM4gyYigPSdTQoT6J
	1o1EgCpBVYfqpY8qh4A+33GiUw1ydMTT/wCDwmLElxboD/TK1MP/OJBsOcEVR0IZzM3xcgkktH0
	eU+HdLwhPmN2/8F1Se5uG59yRBps6jtHENwNJGjqVtVYjGpMATimA4Gz+
X-Gm-Gg: Acq92OH5lcq+TqscVDIZFJMa2sbIGgp2Fx7uhcQZEf1vxuJG2LsX2GBD88H9UP7DN8W
	XB2OTeA7uwY381FBdnd4y6Ar5lsY/5IBi9wET0Lg1HakMFNAxt+/RHWLyiYIYN6IUADH2HzrYdZ
	zMR0f3WMJEYaaDr7U71nc3mtdDUyAENCTYjTNh5svjXGtf1Xxu+8jsmNMc/kdK2AgC5jBztgTUD
	VTt13seu0zrR7aQMuwgjbA4dNqnmL41bQdiFQhfdEEGJLpdK4No6ba2NPfOGxvFkLxseKXzJ7U2
	L+LEdpywxUsQHb5Pngs=
X-Received: by 2002:a05:6a00:1a94:b0:842:5b63:6114 with SMTP id
 d2e1a72fcca58-842b0e582c2mr9739520b3a.13.1780781366874; Sat, 06 Jun 2026
 14:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 6 Jun 2026 17:29:16 -0400
X-Gm-Features: AVVi8CdG2NUcrzgONywlRMrdgMIxHQZjGs8YrCrChoWLOG3mItrq9jaFQG50szA
Message-ID: <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296160-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,trailofbits.com:email,mojatatu.com:from_mime,mojatatu.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FB5064E688

On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> header fields without confirming that the IPv4 protocol field matches
> the selected transport header.
>
> That lets a rule written for TCP or UDP modify unrelated payload bytes
> in a packet carrying a different protocol.
>
> Verify the IPv4 protocol before applying TCP or UDP extended header
> edits.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  net/sched/act_pedit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2789..9a4590451f7e 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff *skb, i=
nt *hoffset, const int head
>
>                 if (!iph)
>                         goto out;
> +               if (iph->ihl < 5 || iph->protocol !=3D header_type)
> +                       goto out;

From inspection the fix looks reasonable.
At first glance it seems that the only fix that resolves the issue you
are describing is to check the protocol header.
header length seems to be an extra thing. But let's do what the v6
side seems to and skip frags as well? Something maybe along the lines
of:

if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_off &
htons(IP_OFFSET)))
        goto out;

Are you able to describe how someone would configure a tc rule that
will allow this to happen?
IOW, how did you verify the problem and then validate that your fix works?

cheers,
jamal

>                 *hoffset =3D noff + iph->ihl * 4;
>                 ret =3D 0;
>                 break;
> --
> 2.43.0
>

