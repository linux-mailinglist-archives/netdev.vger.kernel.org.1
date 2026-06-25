Return-Path: <netdev+bounces-301819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xn0tKoGFPGotpAgAu9opvQ
	(envelope-from <netdev+bounces-301819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFD6C2281
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:33:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dOGLeW1X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF40B300610B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FAF36F902;
	Thu, 25 Jun 2026 01:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7C34BA33
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:33:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351231; cv=pass; b=ndIy+czv2J4juBqlAD3rBWGEm4OcsmNBCR/+Gl7Ww4AZy06ghHrKEg4rA3i4G4X39MdDt+xd/cmVnGRWFYtfH0P9djpg1W48nS8vgiEHypjvEimSNQQqq3sy9tr67lGmUaEqgJvbY1KPctMoK+fTlAXG/ZHFDNKwqIgDNXjST28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351231; c=relaxed/simple;
	bh=bvJIM8/xCthwijHLxhVnOuQsC8i91NXSMk/PMpAllSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olvPZ1dKWcXRb3ab94uJWO9zG8TH0KKKptqPpHRpsdjcAM6+vvPJKabfAki3AJE/n+Zv2zh16I64atJ+cLFPZVdKFIGREvKDMloM+hwkSyIcwNKsWNwc9ll03sZrqNdirVeWOuh14+LnHYYKKWvhqNhAMQGl9zwwfICnr5x5hzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOGLeW1X; arc=pass smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so1869998e87.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782351228; cv=none;
        d=google.com; s=arc-20260327;
        b=Att7No4BHyC6iVqx2+s/w2Bvtc9Gw8fnQf0pVGVPKqrV0DaTTWIzQnCvBqrpkgZDt4
         C8+j8pl4cLI89UMmmyAfYo7LOWCHZNJEVpEgCEjujKMGft9c5WreuswhqTtuyPxsmJFE
         VITQ/uYIAkZnSYceIdnFsvPp2ET4HSX7ZWAAS+GnsxQg43FqvGYuUm9uwkRp9OxJBvya
         5et0S6yq4KRPa5r9g5EijufDMV1LXVFxpESXqZR9PXsNV0KYxWTidWt8K8fVyIDSS2QQ
         8Ifc3Sug8/oBVHNQAV6tu+HD5p4B5fuVkvog+mptFFxpfzsfEVNjFXnGIs7s8jn26cjF
         WFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        fh=8X6TVz1NI7aOwz9+gj9rwVy19kr1zBj0qps0xcbS7Fg=;
        b=csNEhDC08AqUZ8bOlXmz8mzfErXFmGGUfzBYnn2yOWgNPa5jbONarLQicONzz+bp2M
         v8xEeEAyKowUc40aRHECEy97pOdrRclX8wcr+P3whyzoxYPypyVU/W2TOOEP83muCiy+
         ppP61NZyyAvlqtsbLSID9eW7vHNDIrBARsNRI/ikZMmGjqb2snc3auN8NksNqGNIFAyG
         FpruxLsTWbwLzw1AJ4oAXKvcmaYaqlLoVDWLXxbZ2M6o8kNtE9ajBidn6mEi7PFjkGK2
         YJ57MBP66SJfojaUJGhG1zMHL8TNLUqt7p0ZailiwfUznf4JvYULK4i9G01saR/YmxcZ
         hD+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782351228; x=1782956028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        b=dOGLeW1XCqPoUtl0QbGMxGQ0St1ctJOpZG6SCkne0NWV6mIYc3eSg6N5mHsmqKs1ud
         zuSshqi+ulN6Z5FFCSiOKW17NpomcdiOA2p4gNIkc+ujPozI9tnrrMEoh4wqxe3QNv9s
         PQHGFWZ7UFx+mWPwx9TlD6eQQPfRbxHv0ozMIc+nH+AV4qF06VgOe10jL/x/kGXYLyv/
         GzcyAn3C24fSLOCeNh+pkwxGHjvnY6jco7rg3JJpVXaVVWPHsdUQKvvLkNKFnyZ/MkmO
         PNb0+OLm7LlKpoisYLWRucPfKZJMMwCke7Ebez8iJisNdBWMMXFEPf//2YdmZMCNtr90
         vKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782351228; x=1782956028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        b=noisFpOSOrgezbBHDBzaLk4s87/WxT3/eOMlgoLIqYVcQSYU3FZZPLrTBjc4RBAWTL
         jNnjzO/4Ze7dwiYRmBWwin26kjOr0mcL6VkzfgXGAlW3/paR8EWE1UIcXF/bav34DIMo
         fWKWA+P9oT/ILqbGp502E/M0gQTMvUQmu7An+1CGYQuQh/5b4MVRYSJdIIwlnDu08faN
         UgTC9wfAvvDTTnd5gfAB81Gp6OvwM4L4ilUhM/T9fPztanG69EWKWLoT/2Pc4fty2R9g
         Isly1fQJvhd6ofeRrQR9tWOkLMtqa/ZLF+TyDc7XXkJV4EwHiJujdNoSC6ndbVpV8AWD
         w37A==
X-Forwarded-Encrypted: i=1; AHgh+RpodEOck7d3D3zHU++Q24ZioNeA1eX4bktDIEVajEDmxnZQMsg5t13e0RdacZxxgBp+KS2zi8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWWjVs4xxPgj+uuhvBT53TKoa2ihLQ47PtD89UAPHcd523kIz
	JHqrLayImxHG19sV1p84OCyJrSAxLiFiTUown3Yoj0Na7Q5X9AxVpy0pOGffo68cBs6WqSckjdw
	SmXc4XNtgxhxKOGIXFRzdZKMg8pdtmjY=
X-Gm-Gg: AfdE7cmFWz0AKxFd1YuE93ILjVydQ+WwGdovs+VL/sg4KafYIYAUzJul7fBFBsDtWFn
	pe54JEbRRNrNEcGK/9JuVfzZRRarMmUbvLmgB0OztodzSfd3MItJ0FwzURBauaS6K6Bo874mG1K
	kmtI3aD+yKTXauLvddh8JRqJE2cx1cqSRC5z0A1HEBR2tAKzWRsdOh5OVvZrJNk8D4GbkATWE2U
	GL5+kyUR2sx6QT+WljW7x3fEyFnyZV44JAgLqIsP9T6IzMAwphAoYkK1eB0D9R4SNSoO5y6xtqE
	MNVxcire9BWtYn6h54YxzBox/hI9ulYlupf2GaPJEFVrLJDEE0CZHFPFhLbuEgi7uOzbBI1gEFi
	H/F8TJqRv+IHM+P2ipLLZrA==
X-Received: by 2002:a05:6512:4409:b0:5ae:9fb0:b96b with SMTP id
 2adb3069b0e04-5aea206467amr83428e87.49.1782351228136; Wed, 24 Jun 2026
 18:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
In-Reply-To: <ajwHuCp82SazSwKv@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 09:33:10 +0800
X-Gm-Features: AVVi8CejNPL2iVd8h1Eh90UruuEiheM8NG5djzsjWAZeKwG8TwgGsa7M0VGbIP0
Message-ID: <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301819-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41FFD6C2281

On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > On 06/23, Maciej Fijalkowski wrote:
> > > Hi,
> > >
> > > This series fixes several AF_XDP multi-buffer Tx paths where descript=
ors
> > > consumed from the Tx ring are not consistently returned to userspace
> > > through the completion ring when the packet is later dropped as inval=
id.
> > >
> > > The affected cases are invalid or oversized multi-buffer Tx packets i=
n
> > > both the generic and zero-copy paths. In these cases, the kernel can
> > > consume one or more Tx descriptors while building or validating a
> > > multi-buffer packet, then drop the packet before it reaches the devic=
e.
> > > Userspace still owns the UMEM buffers only after the corresponding
> > > addresses are returned through the CQ. Missing completions therefore
> > > make userspace lose track of those buffers.
> > >
> > > The generic path fixes cover three related cases:
> > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > >   reports overflow;
> > > * invalid descriptors encountered in the middle of a multi-buffer
> > >   packet, including the offending invalid descriptor itself.
> > >
> > > The zero-copy path is handled separately. The batched Tx parser now
> > > distinguishes descriptors that can be passed to the driver from
> > > descriptors that are consumed only because they belong to an invalid
> > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > address area and published in completion order, after any earlier
> > > driver-visible Tx descriptors.
> > >
> > > The ZC batching path can also retain drain state when userspace has n=
ot
> > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > state local to the singular batched path, the series prevents a secon=
d
> > > Tx socket from joining the same pool while such drain state exists.
> > > During the singular-to-shared transition, Tx batching is gated,
> > > pre-existing readers are waited out, and bind fails with -EAGAIN if t=
he
> > > existing socket still has pending drain state. This avoids adding
> > > multi-buffer drain handling to the shared-UMEM fallback path.
> > >
> > > The last two patches update xskxceiver so the tests account invalid
> > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > still not expecting those invalid packets on the Rx side.
> > >
> > > This is a follow-up to Jason's changes [0] which were addressing gene=
ric
> > > xmit only and this set allows me to pass full xskxceiver test suite r=
un
> > > against ice driver.
> >
> > There is a fair amount of feedback from sashiko already :-( So the meta
> > question from me is: is it time to scrap our current approach where
> > we parse descriptor by descriptor? (and maintain half-baked skb and
> > half-consumed descriptor queues)
> >
> > Should we:
> >
> > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspac=
e
> > and do a full stop here)
> > 2. now that we really know the number of valid descriptors -> reserve
> > the cq space (if not -> EAGAIN)
> > 3. pre-allocate everything here (if at any point we have ENOMEM -> clea=
nup
> > locally, don't ever create semi-initialized skb)
> > 4. construct the skb
> > 5. xmit
>
> Yeah generic xmit became utterly horrible, haven't gone through sashiko
> reviews yet, but bare in mind this set also aligns zc side to what was
> previously being addressed by Jason.
>
> I believe planned logistics were to get these fixes onto net and then
> Jason had an implementation of batching on generic xmit, directed towards
> -next and that's where we could address current flow.

Agreed. That's what I'm hoping for. There would be much more
discussion on how to do batch xmit in an elegant way, I believe.

Thanks,
Jason

>
> >
> > If at any point there is an issue, the cleanup is straightforward. That
> > whole xk->skb goes away, no state between syscalls. Thoughts?

