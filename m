Return-Path: <netdev+bounces-288665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOMCHzjVCGpJ7QMAu9opvQ
	(envelope-from <netdev+bounces-288665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:36:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1B55DB21
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8220630107F1
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176935E1D9;
	Sat, 16 May 2026 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXZK1rpK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC848305691
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778963743; cv=pass; b=jzkma7poY0qe2DdL5M33gXUmZ3sadv71ROfrxfquNozDY8yMvVvGDp1BHNkW7fzeh4v3Inglk0E+Ur1WYTa6rw5qFHdckp+3IbFej5t9LVbV90aygxIyR69Z9vI6/5r+mLPhgC3M9eTv9Sc+fOv9psOf8gJq5WMSpUhfsMDNPrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778963743; c=relaxed/simple;
	bh=QDKONued7/xd2RqstwrJGKmy0uPXkNmeq8jOp4roBKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoSJi8TT12aybj/J/rYettDDlOfb6nZu8U96cG9RrFj12oAP4yrMiz837kzsMuTkPtfP8KrDI+Ct+KsqLZ5pdT0Ml7ewZ/9BTJvnvtn83IDciu7/qfGGbROs/Xkk08ivyk1B5JS1zbv/oH+DEikk9Sr1SdsYN+LBa31jWV585Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXZK1rpK; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ef10ec84cso863903fac.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 13:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778963741; cv=none;
        d=google.com; s=arc-20240605;
        b=M59s+ckVBzipbwvEjQ9vnb0qislZHA8+Mq9Pt1GZ9QbgYJ8jo1iwAtr3n0OGx8arVu
         LDezUV87iVgIQpPeHQwlukzlrx/UaFtaqfjzgWNr/rKdvnRxRMOPp77yAJItYh4g/XBF
         rjZlsALxqbMPwmB5FTmBGkggeUSvpNEHWeESDIRNT6MJPXl3ZF/dfUIhM2IPlHIh8fCv
         csp8VTIOeLuoULBlyXATE6Md7gHP7jGjpjtB7cnBZGzWuyxINYc7l6r4pJOAcwWi+X4n
         d5viEoiMs0ItL+BQk5MPlqtHbUBvxHj4psyb7qFzANBv0DPldLsIJR/jXfYALLo34uEZ
         jmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        fh=BJSEeeGGwg0gZ/wsFO4vdmr/s0B9/nuUAUgNLymGya0=;
        b=P4Qqp2OlkuYc7lmv2+1Y8yLhQAJdqqZlZeo/KMiQ9zAKiZhQb+zyQ81DXM8AhCErch
         kLzt0XDcNa49DNv9uQOQtACFNbOl/CdbrYXBpS32Dcih8W/lUYiryi/ZOwxFykTMTB+K
         1qF70zoIpfKF9hzY3sYNdCV0osEl54qBxW1R9CdV2Oq4WiF2l0JcifRiKExCz11P2ipa
         H+pEgFi63lqPdeOl2Q+mEWYijJ0XUrxBLtaYhnazI7dJ/92kQV/IS/tnyd24z0o9DyJQ
         bNcpN1pmN+Q/5/IqwiJTFEV8WrgzoScUkTygZ4t+7gAWoVadaXj4KHDAyTEv3/mYBPwP
         DAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778963741; x=1779568541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        b=iXZK1rpKD9y9BWj5Mq/FQeFHkEp0DkDHftcgDcNPW62IqusLNfaSgJzlaZAEyoyJry
         pnVJZir2PenEmdS0NOYTA6nS8mSPVagx2oLF7GgpZ4Tw7edz+M9JT7iezXVZQIH4EYIe
         XTGwYAU2AY3cia6k5OjOcZRMBcW+nY1aa9cOCChXwdZepbFCIAy1bbSIj/hi4KpKhZ9i
         rEbAF5gvlrzw+P5pjhukSDCbM1XAGZA5jzHLmeYDPoFgqQkdnlkxyn71A4ZyhlIF6Aek
         Ye6BYWVRZfLGDxk7ubZuAwvlGT8+b4bLipZ80j5Qrd7lH/t3UUv6Vu/3vfXZWTnRtxcD
         Bo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778963741; x=1779568541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHLDSY42IzpgtERPSbX/qbfMGmcCVU2Ad0Vzt2eV/jw=;
        b=keL3RS6Y1plOrdwGc3VvCyka+OQCXleypIxXti6KSQMTIOb4pfs8X5WsfvGSbx/6La
         TzQ0I3BZV+gELAeGs6Km+r1JOvZIKNfoDGK9ev+2OYaPVYdFTISqrLBFp5tYoulDAruw
         ejwvHwBQWqryss4nRzZGUHvB0qgMi3Vlslw93OjdwIScNu8Jn0XtNyz+yO/GfaXbthSD
         HNB3+snPDWI1D210vN6wZPOJlC1rEGHofxoL2MwUaUzRnzAxJb+qIbH7Bg64rSy6T9Eb
         lUksckQVst1UJuYBSjXeCSI7qnQciqHzxvv3PJkNpFIMxE9l2c0QZWpIM342aKZK4Mde
         6XcA==
X-Gm-Message-State: AOJu0YxW3w+DZiekDSFdpQBIRcRTZPoBFL7HQ/bvUyHlJFRPICoVOxwP
	s5/hGvM0T6t3Vmn1SDUeZWbdD97TarnzYb3fIlHJkoBvTKr6rtKHg95VTF2S/+qg5kq8n2LOpgE
	JQGK09zXliywv1SV0CJnyMsr33g7hwJ5Y8XWEHI0=
X-Gm-Gg: Acq92OE0ZB8Zrh16rERe5zbNPmMo71rq5AhJRmFfvYVhLUkBT/faP+y0h/zG7WMjQfv
	YlL+w73qS1ZA0fIM4lBLNdm1nnpVxfgHxtTmPzKgyyQZHwt1hovc2rCmU388tbmAXNEq/RvT3v5
	5oZv4XxbCzB/jtcNDxxy41Awvb1zxf/js7kuTNWWlHaqMh+b3MjEIINyv4X0HwU9wyqba/lZLL/
	G/Rj6XElFDfDA0XmepqTMpGJi8seIHJkFgD+iIffoyRUEzTgcQBvl8hPiIR/ciGlG0HZfj8K5S8
	wONtn8d6XaJnLmKbTEtDMTNLEk1yjl8rz95URw==
X-Received: by 2002:a05:6870:440d:b0:42c:127b:a973 with SMTP id
 586e51a60fabf-43a2d8f308cmr6097007fac.7.1778963741602; Sat, 16 May 2026
 13:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516050858.23858-1-devnexen@gmail.com> <20260516050858.23858-2-devnexen@gmail.com>
In-Reply-To: <20260516050858.23858-2-devnexen@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 16 May 2026 21:35:29 +0100
X-Gm-Features: AVHnY4LUIoOncuwcab_LTMexQNoMCkZUK0QYYQEBIYnfrnDkO_0bRquj4-gjFnw
Message-ID: <CA+XhMqwo3KqfhPPjU25GPVD5o+c=yKByr_Yqo6AL291mn=5APA@mail.gmail.com>
Subject: Re: [RFC net-next 1/1] net: tpmr: add Two-Port MAC Relay driver
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D5B1B55DB21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> Ah, you already have it here. I still think this can be optimized.

  Fair =E2=80=94 the helper still memcmp's five bytes for every multicast f=
rame,
  even plain IPv6 ND or IPv4 mcast. I'll fold the check into the caller
  with unlikely(), and gate the inner test on the 01:80:c2:00:00 OUI so
  ordinary multicast falls through with a single compare.

  > This seems to assume that tpmr->ports[0] is filled first.

  You're right, that's broken =E2=80=94 after a detach, ports[0].slot is st=
ale.
  I'll iterate ports[] to find the surviving member instead of trusting
  positional order. The del path is already slot-agnostic.

  > Maybe you also want to act on NETDEV_PRECHANGEMTU and reject it?

  Good catch, nothing stops a member MTU change from desyncing the pair
  today. I'll reject in NETDEV_PRECHANGEMTU.

  > Driver version is meaningless

  Will drop.

  > I also wounder if this is the correct home

  I went back and forth on that. Landed on drivers/net/ because TPMR is
  structurally closer to veth/macvlan/bonding than to bridge or
  openvswitch =E2=80=94 no FDB, no port state, ~400 LOC. Happy to move it i=
f
  you'd prefer net/tpmr/, but my preference is to keep it here.

  Thanks for the review.

Cheers.

