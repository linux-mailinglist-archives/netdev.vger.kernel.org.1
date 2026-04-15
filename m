Return-Path: <netdev+bounces-278675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKDQOj8x32n1PwAAu9opvQ
	(envelope-from <netdev+bounces-278675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:33:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A77400DC3
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 255633089D3D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663038F24B;
	Wed, 15 Apr 2026 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5F4vRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275231E832
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776234811; cv=pass; b=F+uY2Vsej1eIoNARcK7gVMFzuDRErIPFKRj/seEEOQj3IhFdZpeIrVxJUECnvPe9V1dbW3RkAngLmQOlykh9aoc4b280VQRFfy3Jqsu4hCF0XqPltKpEwemwPSNBNCVhqrYBmjPvA4DJWjis/7VZK5ax5LfXD7Ix0A6a45NikCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776234811; c=relaxed/simple;
	bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyAhMQu4lP6v/KiKrY0qv0KmekED/O09rbCN7pH+aahkzvronoEPDgWLq3QOnXwEyncfeGMSFsz1/IP6EvR03teNK2NjtTznCb0cHo1QG2tfhsOPET9CyQk0pSkKMo/U37kZUJS0y2jeH1OqeU+Ds5JriAqJ9KAIE/k0H7BdcEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5F4vRg; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651bf695701so1627261d50.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776234809; cv=none;
        d=google.com; s=arc-20240605;
        b=QB+VJCHHyOWsTngP3sXOFG4HXJ2WCMNCSH2T5j/79zgo10bcVM3qGXtH7yN3h2D/cN
         O64GL5q0nH64IOXxZshE3mW6sC1j6edA4FK8G48P8dtw7pbYA1bQpFP1szmZ0ERJWm4p
         Kw+PYS1d07Y6jYzzD6/o0CRlFsu3MM8h8W2aX3cghotaxvUVHi28oCaTLMQ9Zj6CzBqT
         cSBZeje37Wy4PvwGIQ1fPVtyJIqb3tKPEQKB1L4n5nPnA3ZFbeR+5p368L0+E0T+K9Zr
         P4kP26975jhKMEZzQ5eqbALgrcssfxBsOtm8zuJS3/IAMkO/jmxNsmU7nabsTUrrhne3
         Fddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        fh=RTqyz2JYNhts63klL/McMY4q2yT/5/ml+4AQyMJkwvc=;
        b=adz5hEVNF+FWgur3tG157XvX6mP2kKtFRRWmp76AuN/oTxEfrMufRCs78b6X0bcxUb
         8mpv0YEJewrMoxxOYr3ahNN6UJn2bxy0KmT3nyOQ5uPA6YsCiWFdqXSZPPYZglWrSTs7
         HkZ6AgRB2bdZlTBYgTLJOSx2mTnnLymeW5rj8iDrt3lYgp+9Ft1hdVcod5vmHVSabfC1
         zOciD7farIqrrJESibyT2EL4Lml5dcKvckEqeoHUjjhqqgoZwdU08RlMHqJOUT5cwVfJ
         4ztAxeMYENdOdDICooDvuCWS8EbpHNSVz0ElI/auZtJ7nGqcrPGBMGl8vcGWTkWRGxE/
         0EOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776234809; x=1776839609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        b=fk5F4vRgR3d32bKCoF0SveC9QkfCfs1LzXWLm/nAV+3/BcZ0m50sq+fVw7fKdwTLBT
         0XFDFENood4KmYUO+zkrYaov3OraNS6jPAkQOHu0RMkbz7kzbzfut3BXrau+lTOWNSaG
         55TXeb747lknnXfq0GWOdB8QoNDrog+7wSK6gn1mJKbCTvgOMhYqn1sjBTmeERTKnYk9
         2TRWukZW63APaLDnceFyKHgQR3g2YZuiSdcUiIFfQSkgGYSjAHx1chLo18LqYIFuUPxl
         EaLwoISicmXSfxV4L37cbjHUQZyQC5TbpZNkx949hPtW1EHRx1gZBlnaSRSjEIv31fr6
         LPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776234809; x=1776839609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/YGk6diE6DwfvFh1WTj1ikmEooEeeXvUwgqkLXnYMI=;
        b=h+wsckqjhJ/q+qB9RQfCLkjWPB+ocl56qqCGQbiCTgpVgIVPhXVtoNQvi/z5DN263c
         ro7pAHkeRc68UkwVLvEaB30Uw3zEJXMvxjEKFU2sFTngWtObTyQ+kcGXKR3JE9XJz2Z1
         mBfCMf6ltV+K0ynA3uV2xE4BXNOdhUTOvQOHouYDuCO/QDNO7ZcbpB+qEcluLWT44YZh
         zes1LasPyB6TSoBuPRycufTC/RearQtoHYjfEiEo7rheNrUws2l2KkrtYeA5Du0bO0Zn
         FCpzAabgtYDrBgKvkbVGkPQsfHi7vAcQ7275Di8G1vOS5wVNI2km6Waw1KH8NYKGp0Ku
         yzCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fcccVKH+yt2EkH6YjKFIRGIbGWpawkkY4mpxwmNHBMADN0BpYDEB6s6SGTgz01ZWLLa04mrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSG8jB+Sx6KgCegWYonD5K8xj4+JAYbqCZCFUKgJ3YZbVpP0rI
	726nFnIW98LcnTc0h87AiXe2wkBz6ITkviJATnTZNSJOLppZBsme612z2V65dWT9cg5YOsXnaZ6
	WFRb8MO4QUMPRc0npWoYJk20tFneMA58=
X-Gm-Gg: AeBDieuebnw7QmC86THnUvwA61QubOdpqIzKYJE3I5DGxWLeKben5t7YGDyjbXRE3+4
	Ln2lSf9Ec//oi2sjbcIJjJ9q6UE/10heGibvwFLzXaPZiUebLnS94xIlVy6LHzMSsxzdfhVzveX
	YrvKFZWrn1gghFc60sctkaTMRjJKNFRDx4qRZoeaGbokVJAgSbVXCiNpncCdvCZqdh0oTJo/muX
	BKcusVMT4sld8n6fd0Rpbq7R7KWFuyl7FYJ/KHdjpJOm8cSVjKRUVR39LMea8tzLNPh5pS+RhRF
	5Y7PuaJIxOjugFDgngf1/3yLmJca
X-Received: by 2002:a05:690e:14ca:b0:652:ddea:11f1 with SMTP id
 956f58d0204a3-652ddea24a2mr2317961d50.30.1776234809273; Tue, 14 Apr 2026
 23:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413112030.2694563-1-lgs201920130244@gmail.com>
 <5da15f31-e9af-4f8d-82fd-eac29a6d98f6@intel.com> <CANUHTR8uNVWR48xs90s+MtGQ6J-1j5R0+64MKVGin0cf-FjRWA@mail.gmail.com>
 <143881d9-02d5-42be-bf77-9fe9e8353c06@intel.com>
In-Reply-To: <143881d9-02d5-42be-bf77-9fe9e8353c06@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 14:33:16 +0800
X-Gm-Features: AQROBzB0J22GUf7_6jCosTMhAtK8yiANwxMUFPDIVG2xrZyTeQWs76gB0isBNRQ
Message-ID: <CANUHTR_ecExv+7JzJ9G0H7kTnPfOWr+epyvJ=qxGF=SvdCU9BQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] dpf: fix UAF and double free in
 idpf_plug_vport_aux_dev() error path
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278675-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 43A77400DC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jacob,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 13:37, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> No problem. I had missed the other version, which explains my confusion.
> Still, to my eyes, the fix looks to be an equivalent fix as one
> submitted by GregKH:
>
> https://lore.kernel.org/intel-wired-lan/2026041116-retail-bagginess-250f@gregkh/
>
> Do you agree this is effectively a different fix for the same problem?
> Or is there really two different double-free issues here that both need
> patching? I haven't been able to fully convince my self either way, but
> I am leaning on this being one problem, and I think Gregs solution feels
> simpler to understand.
>
> Thanks,
> Jake
>
> >
> > Thanks,
> > Guangshuo
>
Yes, I agree Greg's patch addresses the same underlying issue.

For the other path in `idpf_plug_core_aux_dev()`, I had also
previously sent a fix, for reference:

v1:
https://lkml.org/lkml/2026/3/18/1822

v2:
https://lkml.org/lkml/2026/3/19/1285

The v2 for the core path was posted after discussion on the list and
incorporated the feedback I received there.

So my understanding is that Greg's patch covers the same class of
issue in both places, while I had sent them as separate fixes.

Thanks,
Guangshuo

