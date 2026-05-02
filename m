Return-Path: <netdev+bounces-283449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOH8Oacz9mkgTAIAu9opvQ
	(envelope-from <netdev+bounces-283449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8394B3098
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEA4300BDBB
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C93033EA;
	Sat,  2 May 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyXm7Z6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE0358D32
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742756; cv=pass; b=jJ8kzFk/gkiAE4p4DNlqPr0lPkGXMtslU0/2qsaaV5nz72/zrhy9qn9SOhxGx4xUA0uXcOh2yJ5rH/JQ45kLdZ598ussKgDHME1MwhwCTVzEqKtJb54UY75leTJmfKztdE0vdef/NzOO07pZziFDAurrg3izBoP1pWfQFZ2p84Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742756; c=relaxed/simple;
	bh=zVLQpkyliinpbC1REK+CRGmV+piTDuhN1wWWCedvfwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RS3twLP7dVdBN834eVfkxDsxK/V2+R5+hEDm2qDzmEVh1t3I3j0Gkg8+hr4ZWF2gVCifWjfH9wrpmlpjd6pjj+1AyrYQPWW7ABpUGoTvJIUJMg/dsI2tZ3cqL4lz3R/1Vk6UvZFLDFAl4yx/d+LvfmN5Cd2TR7ypKq+CPtVds9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyXm7Z6b; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso30818846d6.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 10:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777742755; cv=none;
        d=google.com; s=arc-20240605;
        b=iWz9z2Wj41OdWspJIvtI7VsKNwL3kBRGiuLaHT17cB3FhBtxkmNr0xL3BOWZWd23Nk
         tO2/QSJhMPGseQ7aX3zl+C3hddvFZ53upGHVbuI+vKpu52LVTGoJNW5S7e8wAq2sZ71F
         oAojI1Nb3uAjWaAAQplDWpWsuPZ5IpEHckveCURVG3koKHmGPIfexqmUpdPGsCo4AGfc
         tlJ2m6zWw5O0nAzgFp6wI22P88N83zKCKeifSi7usCLFzySf1AYM3J9hSEx/ofO1bjKH
         XVRnIO2+5VRzsQilicYUIn79AI4rh0H0RnWPL63a21S2waXR0hghFbwb1WZRBeKTloyr
         12Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVLQpkyliinpbC1REK+CRGmV+piTDuhN1wWWCedvfwc=;
        fh=jq7Eb/XJ481woNKLA93pPeQOmzXLJ7tAxDuxf69Fi3s=;
        b=fgM5zst8RUP5I4FHEZ/mz8DrikFC/v3GAzdfCDadQCGAfgOL36b6TFphzCba8jo8SO
         sxYOjH5VrsAhb4Rif+uTEj9jpvT/8rRQHsqoxLUrU3Z2UtKWymmr0HquQsUijTDkM3VB
         YaE+XNnr1aPjg8HClkPb7XciG12ygSluVg8O/6a/9EUSlcFxsODIYxOLVGVmeLC00QW/
         +XFWjMLQD27AmTl38BE2ifAz5cdZHnRlARnksDEY4bWrVDqRVk9CxuLVloTg0fARA7hc
         6ncg/muJR3JJ5K3I4qno6IZftGxEAFnltBqPPg21whCvVMESLhSZhsLiE4wpS+/be1Hg
         +FWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777742755; x=1778347555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVLQpkyliinpbC1REK+CRGmV+piTDuhN1wWWCedvfwc=;
        b=CyXm7Z6bqqbV0HWcCgqMPYUqG3jFbQb/Sq3cqvgCsyi5StUXfcPYU8GUiJxdikYzQA
         6UEhOkj9nr6HTE2JMXOpzC4mJxlpW55bGg6eg6AeDYjJzrd8WcA2TpMu28qiBJntjTke
         EupAw6XZDHQMQ7hJ7mm5aK5SMTtisggWkJuJYnHMl76pwQhrVpGg7miNeMEdrdAuF2Yy
         vf2rpsDaErSMTJWyL/DHR7MPorBRgqQlr3bKsFWzBUOYBLNBUvcp7Gg56242YhTAobbJ
         qZf3RwhgGZyekzpeSjZjZtRv+muVE52vFOjyQShI+mVWtDs0boMK+3kVR9ZWIpasqegZ
         QZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777742755; x=1778347555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVLQpkyliinpbC1REK+CRGmV+piTDuhN1wWWCedvfwc=;
        b=IjDGISxhXaQhRjXSB7bZts8K1lFNA0U3V5vNH5i66RuzaJeh/vrAF4kKecG5Mmy9ty
         CxdK4vcPofxmNBOonDg9aPsQo5/rfo+UNumnNJnxNVM0/4HIx/qDt5Hkz/4RD59nTZTB
         UnL/wcELj+BbKBPr/jzwmnjYjcCnxNX1wZog/Byjcm/JdoEKGIrBOUY22b9KJR35AHIp
         VVJiPdyH4cNtyOVYOitNaF9yisqnlutRj7UrMSOT8eDE8TfytqcPQqAaXnGzu86UJDmr
         N7BF+jzaJusTEU+8XDY8FlpTSfxN+jFkJL1QsWIapp+YdFiZXwhkJywVrqK2xAgJAdXt
         Uk+g==
X-Forwarded-Encrypted: i=1; AFNElJ+M79zYaeD6/rysqndGOAohwzUWF+d9TCYRC98XDcdaHaiEyClYcw2+RGn2Xsu23ODSaRDqfxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnilg9GKbU1Sv+J8rCiFeUe//2+o8u6PcOwLXHDi/nd9BHLjR9
	RaEBAnwBIe9Bjahz7Dr3PyL+izbp3HXDrD9Ec+T7oqUmbaBlwrf161bYOVuK0W1Y6Kzy+8Os9fz
	nsOQUwGjmgSS1CIpT7ARVodU5OKn2uLUVcxiIYYBr
X-Gm-Gg: AeBDietU7tKHlUzlltv4jpDegUbgrVQIX04LlI7N7IitfTxmNCYohKnmLFJJgwx7Cex
	y0aGsBu3hZKIKNhgrjCfeQMAhan93YSJifnj1EbEII2LBbnmyLDgCU3Z2rA9olO8I2fXbLEKfrf
	1UTArChtdSnmbDWqFkDuiZ1S0qZ4Yk5uZL4hdV3negz80pAIS7ajJ8NS92dQhxhDsN6tjgBQEd3
	6lL/1OhiqBGZxr/z/sHCgH5caYDuurOnBhhK11Ye6UQIduG6G4PNFC/CUjTqdf97SflpoUPUKzX
	pVwIQYbGWoDKVoYS0BzFpTvIeRQlrmwYDCFAFSCq/ebT+X6RPjTXXR6kof4rLE0NZNAt1SCHDZ3
	Kd4DH2TVIo31Ddtm7YvWWqN8b9fwN+c33MDFGAKZg
X-Received: by 2002:a05:6214:4d06:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8b6682579b0mr63611486d6.24.1777742754183; Sat, 02 May 2026
 10:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428082851.3240821-1-edumazet@google.com> <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
 <CAM0EoMmHMMsAbORxETh72c0=CyyAY+PhXReXwP-woGp31YOkHw@mail.gmail.com>
In-Reply-To: <CAM0EoMmHMMsAbORxETh72c0=CyyAY+PhXReXwP-woGp31YOkHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 May 2026 10:25:42 -0700
X-Gm-Features: AVHnY4L47nkTAPq5MfCrk33pCVRgDaDpC4mNVwoiv9u1569lQeB-LNtb9MeA3ho
Message-ID: <CANn89iLTH=_=qYS6RzqpGeCo2FuuVW70h_yRycy2L59G+APiew@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F8394B3098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283449-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]

On Thu, Apr 30, 2026 at 11:20=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Apr 30, 2026 at 11:36=E2=80=AFAM David Ahern <dsahern@kernel.org>=
 wrote:
> >
> > Jamal: waiting for your review ...
> >
> > On 4/28/26 2:28 AM, Eric Dumazet wrote:
> > > Some setups can have thousands of devices.
> > >
> > > ll_init_map() is rather expensive for them.
> > >
> > > Only call ll_init_map() in the following cases:
> > >
> > > 1) tc runs in batch mode.
> > > 2) tc runs in monitor mode.
> > > 3) tc dumps qdiscs/classes/filters for all netdev.
> > >
> > > This greatly reduces RTNL pressure on common operations.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>

Gentle reminder, this patch has not been merged.

I have other patches coming that depend on this one.

Thanks!

