Return-Path: <netdev+bounces-275004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOncCwKpz2lxywYAu9opvQ
	(envelope-from <netdev+bounces-275004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B8F393CD6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CF123010700
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9A3B776C;
	Fri,  3 Apr 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKa+m0+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462213AC0DF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216892; cv=pass; b=gmQF2/SGbtCaGqfih4ea2beiFx/R0vk+U12Pkd81NCwwWmiuo4k1LIvPkqT1CxWniv6AEqT9RfiHEOMwwcY+KOjA4Ha4RSzVRuUWO8U1MebUZDDv4TNhJN+8VjRIKd8WZl1ZhE/K3G+0DNMgE9dq88fO4KCVpGYl5DcMIJMGsME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216892; c=relaxed/simple;
	bh=URfO4qXQmNwqn6yWmUmDTG0PuGd0UKqDBdiR0nFIs0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaJ1rWo3LI8YwLAwiQdeaZolQEJuqOeSyURgXqjBGiCsXkdlqjZFCwSCNNg1uD4x4azI06ka9cW9qLrYQ3EGduHHIl4uz03TcyDg5oPgtMlXPipWBB11kLZre2i9menAJMeU/D3nGn/0u3jY4Y6iYTnRv383pnJPr4mHeLLaJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKa+m0+G; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40429b1d8baso681523fac.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216890; cv=none;
        d=google.com; s=arc-20240605;
        b=YMcJR0ApItRrI95KY1SjaaAm9k69zc+RDGMsmBkk9GafF2ObW9PWmh/CgT1gbK2zsd
         X+UqIXmYcZUWeCftCQStALWZ58t/VMcZG1j/NWznkFHZVuV3MBMmWAKgCNeBj+WIIdyU
         xyKkWg4db2dpVLlJVmq0rVVvRSYhwXaqP/FznFTX3xO5Cd+anc+MIpxTm8vqjXEMcHPM
         16mSZGe4MRiq+Hq2/IM8Y08CQh6Dz3rsklVpY3vSPLhwOWlrcrwMIi3i/VPhIhA1Lk8t
         9LVCiCCPQ3tg6b5GZI9h0Wh2VKx5ZBWQDpaUqrX7dzttBOIYvDFHlyeJUWW7Jm3y6CYB
         Edpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        fh=ysTuxMZKLnjMGblIXQI+S/nyEO1KxUM/nbaD2l/jFBY=;
        b=WnZ6bZNIdVSAf4ZSQxsw/51MRv77TxxmjRUXtJ2aMKYyXfhxqhEG9STbjTNs4W+LHr
         yGycpLXpKn8DOsKsj4PG9EArg5cyB1AYsXzFWe2/4Ci3gKM2m5R/GTvZF78ypQAdYzIn
         cKPVtdqs6+5acdlb1Sl+UBiM/FuoXt8+xFF6/meFZXavvrJs8N6BYpapBXOmz4AdDy+F
         8kNMQlK9tvSVZsgOK+MNrsnbVK6qnohDm9jztM2a1fd6CUWJAgT9nRjy66D9YlmkUz3B
         MwtwwW4yhOBD3ng5lxQ59Pj9MeKIQOFzlDeABVohp9V8SQcnNj6fxjz3OiicGFIxwRzk
         VjIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775216890; x=1775821690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        b=aKa+m0+GY2iLL9slBEtgLVhT7mFnRDVZm3O/5OnPDoB5g7V5CJNhQhYPgjNK8XhxOz
         hvlkHgJbKu+DlDr68MSK71jkYy4KAJLM+R2zJkaD8g/Rtfu/E+7SE/hTgOEqzMRkZ2Wy
         tYzws9CM7Fv2DWDBQnuLsV8oCX8HhVy881EgK4p13e8e8uDA01fPqCS0oSFwikYFgdB9
         +A0PloJv/LAmCswn4OFo3y7s58WN78fnl03YTMcATGbL82Gth9y+eS3OSjhwMpehga8J
         7Nb3+nQ50gDIlYWfe9tZqR35c89udzMUPFMkqwQ1/gufp5bkg3DDxhwMix97DoOMpxYA
         0D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216890; x=1775821690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        b=p93GrqagVV/niUwvejgz/gKCePNoeOJyjfmHRNVIZfHJou9vV4WkIdOVDcBzHHiOWP
         1nS46s9mSNhTkFQwHYGCmtYrWjbkSl9mqtJDbBSCPSZ0zifUoh+Ax1DhJ40U1a6VTtAR
         /zDOaBt+ZBDHbn/Ky5kJ0/5xZQtQWbUu5hCVTzNgGIbKKnw1vUciiLB9rQvxTlcXSHD8
         3jYgpYXYogK02hZxqPo+l3k+GPIGMT2fUB07qmw5Pa/P7o3ocxjYYHAQXS6M4jKEFENN
         19Tl7jQ4PXkryd4CPIy8WB8kI5L0x0sm3u+phyOMV6oUWNrwcU8LOAtvlLY6HonBusfa
         DYVA==
X-Forwarded-Encrypted: i=1; AJvYcCUnzmcRNm3QVEtyC8O34Z8bZaKXneQW7X4ru6acr1ok1sTzsR6d7hdC+zW1DiVuVckRjPJrTMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4d4TIJfYv2lYhYh63N7624H2i9T6FbfumiCxGIaSve93leUrh
	ZAur01pyvyQIQKhGMfp/3fNYmsZZ5Pr6BwxGROmWKnO3lWAZVv3cp3jnl7LxEpXxHbf8PUHw115
	Ueu0cObAnnT02HGKEJSHn201aHesTayQ=
X-Gm-Gg: ATEYQzw2Pgkj5Hi466HS+J++XDhXWEg6u3CQhu48Zjxqa8/fe0+sjpBSVELbkgnMUd4
	9LBJhEzdYiXLrt4brDGSBOK492EeujAEUdjHhjjx4mFdQHnCturRIILtpyJlEWoay0hrTFUXCN9
	jIEuXFKOe0Po+BRRGUvO1gLWQWzmIGHUkUcxMcUAAQFDx4iB0wJTmeGtF8goPV0ulBMJHMRUAnH
	m+VFlavc650vNO//hcI9f4zifb6fZu259PEQ+gvHOXAxKqchacQOxaHIKAmUjLvWoiCesbptGeJ
	UKWFBeTu0cQZfRpKlBE3CZ1fRgWeotgfbm4ZQQ==
X-Received: by 2002:a05:6871:79b:b0:423:1a33:c275 with SMTP id
 586e51a60fabf-4231a342d07mr837578fac.9.1775216890130; Fri, 03 Apr 2026
 04:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403110238.16596-1-devnexen@gmail.com> <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
In-Reply-To: <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 3 Apr 2026 12:47:58 +0100
X-Gm-Features: AQROBzAV-cZ7Lwo6cZ6k65vh0g1kAjYjcFfMc1jdULr6qoX4UM3ku51haJ1XjHk
Message-ID: <CA+XhMqyYo8WwCwRg2kUv=HNo0bGXe+kOTDFH8rg2keDFJmvxhg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP
 error packets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36B8F393CD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi eric,

On Fri, 3 Apr 2026 at 12:38, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Apr 3, 2026 at 4:02=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
> >
> > Update the inner IP header checksum when rewriting addresses
> > inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt(=
)
> > behavior.
> >
> > Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  net/sched/act_nat.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> > index abb332dee836..cd1d299da57c 100644
> > --- a/net/sched/act_nat.c
> > +++ b/net/sched/act_nat.c
> > @@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *s=
kb,
> >                 new_addr &=3D mask;
> >                 new_addr |=3D addr & ~mask;
> >
> > -               /* XXX Fix up the inner checksums. */
> > +               /* Update inner IP header checksum after address rewrit=
e */
> > +               csum_replace4(&iph->check, addr, new_addr);
> > +
>
> ~20 years old code, are we sure this fix is needed?
> How was this patch was tested?
>
> A selftest would be great.

Ok sounds fair

