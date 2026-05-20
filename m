Return-Path: <netdev+bounces-289809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP8GNX1iDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57153588F11
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF8630298AE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0936D506;
	Wed, 20 May 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3ucB1jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40404366073
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262072; cv=pass; b=nGHKRjLVUF/qMCM5pazeP0q/Z872UX+NB1w8pIhDf2t7vwJGtqR9YMLHXVTGLFqNipqmcxEtNQja8Ph0bGWWX+v6cWL4bA3JAech+84PItU0RwNamRbk3LzLwKnZ1F/JvJoW9bNugxIQYdWKNY7EbBHOAQABkDNfs8Gwz7MU27I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262072; c=relaxed/simple;
	bh=26j5PnrbpQm8XEb9ANX80wT6LvLHehW7AQcShY/SYFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAk1/Aq/QKEX4kY8Xodiue/CsUQJacNKPBsyKGN3IYz0UmIoCPZjG1+4qeVebWxbquWStP9WLdjztZT2v7/oivT72x+kQ30GNOjtRrSW7RpHriCxnXk3GHHpqjpJAW35/ollIf/+AKspc++by/t3C2uLTG4nVtzapSK6LEDEWRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3ucB1jk; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ca12973e15so63134996d6.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779262070; cv=none;
        d=google.com; s=arc-20240605;
        b=JF+XzVb9mqEBhFzi29prTJEM5Ojs56+hu2Eesqle9c2JiTTd62Nq2zj50/VNtfW6Ua
         dvLX0P+x4cbr+URSpfTHWJi+QQNOLtLO9PQ+fsi/Wm6GQjG+hAeBZu9AOD8N8qYJ6DVR
         4PdUNGqp1NxNp6r/LVr4LLb+Z6Y8WwKuGfr0aIa5LcKWAJKlR8TFYuT5P8OmyeT9Xs6f
         DHFcPLR5c+cWQQr3Qoi1/BIB8gOK2q/loSLcZBA9xzZRd8jTBCvLlZss68lNoNNch9VX
         gSCGQvyNlLoDEBuFf29lktzW1bNySpcI+SPHG29qVs4kr9DG5Is136Xmw2sYq8N5qTJR
         EYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6TWUWPUGYIqERhMMFki3MCHcvxh+u+UVkFu6uEBr1GA=;
        fh=vjHwEWxQ9bVNWGrd8sTDMTG5rXyJiopBazEsZ4mc73A=;
        b=KDFabWQDBb4Eu+6IF9S0OD/9rv3U4miqhiO0PJQOiaQ5NnvWr0nOb5nULs2OYH3NyP
         QpTNvtSOunqnPmpQ765IVAf8rkqYQ8APSQAzlQ5tlMUCwLYIyWFn/miDtciXrASkcofy
         Sa+afHNC2keUYndUDK2hAzQTi4U8mPNc82sI1L+VVUE3sQ+efIwnigIH6FcWxmu6ISWO
         g/T+Rb6DoSm68qY7NUAp5vggrkfG1CjhynuFxG6n5Pdb3VrpXDXQVwY21qqTGiFIa+lD
         jetyyWeQHDY2MigcWYt4t9Z+ge6QNCqtTxYCzqOYStOj+1mPX1pQBDH4+gA++o+fOYzf
         kahA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779262070; x=1779866870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TWUWPUGYIqERhMMFki3MCHcvxh+u+UVkFu6uEBr1GA=;
        b=J3ucB1jk8NrgQVflRPSrss+ErIo8aeQ5KUUengDp9cBQ9QD0+hECHCmaI03WtA27Bg
         N/8t+GqZuD9Nf8dhlfTvj5ab+KrwqRjqoRcvhHUZ0vlwdeEEpHc7FHq+3IdzDPcZ/GBt
         YyUf8SLSFGnMJrGV7XtnZyD34rfvm2KsXuhQsDHMs5REDzKS1JeoSa/Z/1MfV+tlBIcm
         ka3grOZ68AUtRu1xHpMGbPFxOA+86gtquctcSewO5ds7hdPviG7bi6xdFH00eLxTj3sc
         2Qd3+xVldn+QZe88+qhDKTiIWh704y+dY8HYLawyy7s7o0+C9II0ad4JHNllsIKC9zFi
         Pkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262070; x=1779866870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TWUWPUGYIqERhMMFki3MCHcvxh+u+UVkFu6uEBr1GA=;
        b=GyjR0eTbP4Cif00PURPCruAjHpEdbLrownNJ+vNkcAgkCmt+BDkpXxrFnFEzYoY2J5
         zMokxqmdZEPlMA96ycrQfHYwL6F9Z7dumKpoz7qdVdKA3ccxeuPIJuO1ygHIu7uiibVF
         J4Qg3oC0pcvEdAgcgJts5N0uFDo/zmxbeuw98vFzS3twB9gZIIxtp5jLrOWuW7oTzWoX
         Jh8dNDf21VLCIR12lc8EDqzesaNiJQIY2MgMkAjFtF/szyVl52W346cjcTiCxGzJWWoC
         Y695ggSu1dIeV/JKz4pr25SAAfE5o7i9hoj47WjnNB6mFdZ0xZ6PnoKEaAmnNFHpMucX
         CyZw==
X-Forwarded-Encrypted: i=1; AFNElJ8enFrnyjXZazsx/x2v7PHrsJP4w82uuvo3GdB42DDZbtSyByy3YtO1E8ee7HEXYaAiFp4DsrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzDwsDpSaFDpDCAeQLaCbPlX32ayKW8xs5Ga2W0QMM/FodRqL
	jln8YbndYPo7U3qkEQByw1BthlBhFQ+f/aO9tmTLlfXU6rB2M5z6gtwX8+3iqZcALhnwQElx1LC
	iXdvoeXsxUbJlG3SKQaDf2Cknw8IQyT9W7SK+mC4t
X-Gm-Gg: Acq92OHDvroIQO5UAHwVQH/n3KMvPdFHmvfHCjMU19t3xSn/wQVALfQSY9TBZnaYYcq
	QB+ckYHDRV21WeAKj52LrkLZcyuWpcRsoBFbM/oMQhMPVxzZvbwvntintt7/8EU4YQ/4db0W5CV
	DGZO405jL1xmxdDBk4YlixJ+HdK3l4wKYFeeMICCC1IOPQQp69jtqb3V78duWoC1HjxSG2iWFl7
	EcWbQSVeigQQwVR3A3mtCtejJv4lPYHSFiufWQQ7pqjSboFfJ5CIiCd7pksYno2+FbLEw0VNe2z
	ThlyVwmTaXBHWEwD0486fKMwbgYVNyX3n5IaJypWZaaEpcHJ+rNL9c33wb04JkpBD5gxf1gRN84
	X/rmpcscVWa4qw5iAIW/GWWKjNHtQzzlzMkGxkGiQirTtf09HcngxKoFxmCoNxzlE
X-Received: by 2002:a05:622a:2587:b0:509:238f:ad8f with SMTP id
 d75a77b69052e-51659fdeea0mr321928421cf.5.1779262069703; Wed, 20 May 2026
 00:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518183424.3144867-1-sbrivio@redhat.com> <20260519190352.45c8478e@kernel.org>
 <CANn89i+DknqarcKuZxku-XvoioqkXrd3sQd3PXW5fdFZBpPxjg@mail.gmail.com> <5c1de7cb-42c2-473f-8d67-0523a3c86464@redhat.com>
In-Reply-To: <5c1de7cb-42c2-473f-8d67-0523a3c86464@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 May 2026 00:27:38 -0700
X-Gm-Features: AVHnY4JD8oaBW3zadh01hZWF6u2hCLMPvpBIBzObevgCfqF7AtZO401ykCVikiA
Message-ID: <CANn89i+RqFMt8X48V1xkk8mveLvcBORBb5crDKhSAGAvipxNRw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump and
 data receive
To: Laurent Vivier <lvivier@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Pavel Emelyanov <xemul@scylladb.com>, David Gibson <david@gibson.dropbear.id.au>, 
	Jon Maloy <jmaloy@redhat.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289809-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 57153588F11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:24=E2=80=AFAM Laurent Vivier <lvivier@redhat.com=
> wrote:
>
> On 5/20/26 06:39, Eric Dumazet wrote:
> > On Tue, May 19, 2026 at 7:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Mon, 18 May 2026 20:34:22 +0200 Stefano Brivio wrote:
> >>> Stefano Brivio (2):
> >>>    tcp: Don't accept data when socket is in repair mode
> >>
> >> Not sure Eric is on board with this patch in the first place.
> >> Sound like it's not the intended use case for REPAIR so IMO
> >> it's up to TCP maintainers whether we want to support this.
> >> And it's definitely not a Fix.
> >
> > I am not on board. Only net-next material for sure.
> >
> > While v2 is slightly better, we have the fundamental problem of adding
> > stuff to TCP receive path for features that almost nobody use.
> > (It took more than 13 years to finally complain about the race)
> >
> > This consumes Gigawats of power on our planet (and tons of CO2), given
> > the trillions of packets processed every second.
> >
> > Please at least add a static key as we did in:
> >
> > commit 020e71a3cf7f50c0f2c54cf2444067b76fe6d785
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Mon Oct 25 09:48:24 2021 -0700
> >
> >      ipv4: guard IP_MINTTL with a static key
> >
> >      RFC 5082 IP_MINTTL option is rarely used on hosts.
> >
> >
> > But in my original feedback I pointed that we TCP_REPAIR should
> > probably only insert a TCP socket into TPC established hash table
> > only when it is ready to process incoming packets.
>
> The problem is on the source side of the migration and I think removing t=
he socket from
> the ehash table would trigger RSTs, closing the connection on the remote =
side.

RST is triggered anyway if TCP_REPAIR did not occur yet.

This is why a netfilter solution is generally used to make sure no
incoming packet is received until the whole state has been repaired.

