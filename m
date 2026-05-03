Return-Path: <netdev+bounces-283637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN18Dd1792kpiQIAu9opvQ
	(envelope-from <netdev+bounces-283637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:46:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FEF4B6909
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 428943006B2A
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7427F4F5;
	Sun,  3 May 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAgd1w53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F4372EEF
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826746; cv=pass; b=CMoyPNz4cB6sQSh8G3J4G/nAvtCwvDOIPMvQkM9HggrzqjvOgNE4QlTDUi39ZyLeBRM6bLRWtx5hWeCQk9opkx42967KTR0OtFrbV7otWwbPr1LJLIwpAfA3wE2GmcurA2/WXgoD/tvZVajiNNZqUiE9qWo5W8NKxZ4KtPcP2gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826746; c=relaxed/simple;
	bh=LV2XOb0jyUnumBexNMfNxtwYt5s7oyI9ARwa0OImnCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTKezEe0yp+fmGnhN8/E4CHxzSdbYLlzbsVX6RivjoY6vmhFdO9dJ0J30SlTjals4YCWrqQNu40IWjQV7l/ipwrY8myqh7hXDz6m5jiTnwt6GBMOhiwupOU342PuY3Hkc+o8KBSojw4YL9gUUjr0R05J7wlGNd1B0yV2BfS9A6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAgd1w53; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba6838e76f2so363913566b.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 09:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777826744; cv=none;
        d=google.com; s=arc-20240605;
        b=PFlWkSDo5UfrqBLLRle8zURAizQIo0WQN0v1Ka6SGtbmDm6oqJ2AAzWLXO7E9btjxh
         x/QpEdB5TNiql4XmVFuBWf9q5FU6l6olcqLLJZIY5fIJb+zogU59BS1nlW3ImAduxt6+
         suk+SyrGOdJrn/xhH36nyCJnxO/OAOKVNFWemciVUyFWLTRWy9lmlbeq8CuctKEwJgDt
         umeGRaHjX3Ifvunc79mSxiDOB0dv0A+TFdUCPwadnzWYLK+FrQd3y2IuSdW6XfzyOIu6
         caTMUEc49nXlIGds8ljdg93bfa7Jmn+D1i9s8e3RYJj9E/CU2/UK6MW0Y/u2C+O1oP6p
         ToFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8JgN0Hefm3t3vAV3GW6QiuYzvhcPvf24+7SaYMn7ur0=;
        fh=rjGajMQUesDGdaDJgCl5JHj4gmkBog9P3lfhQh09egQ=;
        b=cUw3Q04U5UFJdKCCwUggDuk/VUEaJYihfOya52dxTcMhcG/WIutP0CcJPI7GbKwPZN
         bVK8dvoqxW6n+JYRV4YfZVTTPolWmByQOXgoy8x2ulbZAESxch4dXjH9sNB+tgjlNXd2
         qs0nUOEJL75LYkVKPUCw9CALzAdBQ2m92Pz7Lp07orfx10g4dQYCjV05S8hva9JepNK9
         YW2J/45gPxbF4CFPqkPXEaXNp3110L84F/21VwJRTc3PFxO0E76BrdBYQ3AnAFhC/Ofi
         4V+iD31Onkg3JttBCPuN1qRzqeckE6D2OnuZYtu0ZAIRXCPlbAolw3Tf3ugdd7W65+SY
         ajaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777826744; x=1778431544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JgN0Hefm3t3vAV3GW6QiuYzvhcPvf24+7SaYMn7ur0=;
        b=AAgd1w537meSNpN8m9OyAc/ycTd+YmUKiznHGwvSuRPsYRRfT4VS1GlpzwHVZ8AEjK
         czQ6gyMbMykKQYNpiq+YZi+SPHYJk3yveJHNWvi9uc/SvX012cWG1jI/BO4pUyF5FUa5
         01vf9F1AJtMVC5NEWxlhmbaulgvV7Arjtiyb6GR/JwWwkWArzmIJB4xd/yAh+KqLWj9I
         U9GVoH9XfTPzhwqWC1AeFMmJXnNakaiqH3oRrjjoPKviVAWPE64QIi/QEXNhMVpXXot5
         BB5I7Aat0N8/zChheK4tQ/pQnJMpOVcqAakbC6DiO1U9Tt9n1j0MdVm9BaETAC5XPSdw
         3Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777826744; x=1778431544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JgN0Hefm3t3vAV3GW6QiuYzvhcPvf24+7SaYMn7ur0=;
        b=e2OGNkpDrJwf6kWupNGyACN9YRU1zTioMVdowNtQ/6mNHXxK1owE+scXClUMAWNtob
         /DYiPqoVoRHsie/m+KtqlHS+N3+QA+9UPleHsu7mTsUSuOzdTJz3oT4tSqEC5MbZyREI
         olYeXi3MEvsI3eCVXajYEFPmMBUcXcNFIClMTarfN+azxZ0k3Hwg9j0+h7oW6uUbFMGG
         SOOVx6lHMMUsDG8PJZ8nDwcx3BTkmfFX3b8KYP20rdKu/QN3OY6UyIqxGtBKy/yyaSAM
         nRzBF//r1UFm08CWg+ASrOpre6DF7DLCFHjFcCj/q4wXU6CoVPhFXxwDBR8wog8fzzgC
         t/9Q==
X-Gm-Message-State: AOJu0Yy1LCWhg7sw8h0JyFEFLxKddmBqXxi7miLluyRyAmttubHnv9xC
	F54BEun1IacWaf53aGvMgd3YVTrCIldWVAkw343MuCRmHLXpuQEjWmWzSMjXgZ2D2Rtbx3o/+5Q
	A8Es5sMXTAiszp5p/usQl1jxkMdQKZRs=
X-Gm-Gg: AeBDies1LIe04SgwboTjJYfgz2G9GSo3oXcZDtKdt2/6Ynq5vZ+a2U3L4hSZ/4eAzWI
	zWvfKZuCbhdCe210L912f9/oIpQFKNWcqrL/MJgCWC+haGEeIEWGwD0bX4GS45G40GHDNKeZ0yH
	fD2ZIczPmruDP1Cr3zaIZL+yDSTWYUZciZK8FyK46Rb7/zHObeTd/BJDV014OyKhtnE6FKoH8NT
	OTo5aHaag0tUC2nQ4e7Xs8HrFKxZRI981Whs3jjQSUeM9ycDcH9jHwcFmuAQ2+0nyyy0KXfinpX
	3CJUBPVjoj86mSrl7/2vtUoAvbiZ8v7aJPBhPWH50bRqoJPe+Jad
X-Received: by 2002:a17:907:7b83:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-bbffb846e81mr366878366b.31.1777826743537; Sun, 03 May 2026
 09:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
In-Reply-To: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 4 May 2026 01:45:31 +0900
X-Gm-Features: AVHnY4KphqnnGL_fETaHA4JnbzJ5DlVkT9VAjwd25brXuGY3u1NsNWJOgzjbyW4
Message-ID: <CAGCJULNRzdbVJAtRmAjRcLZ-U9y+Rk9O53yWoivBkjxeyTu9+A@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 0/6] seg6: SRv6 Mobile User Plane (RFC 9433)
To: stephen@networkplumber.org, dsahern@kernel.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A2FEF4B6909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[end.map:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,ietf.org:url]

Please ignore this thread; resent due to a local git config issue
that put the Message-IDs under the wrong domain.

Correct thread:
  https://lore.kernel.org/netdev/20260503154510.912576-1-yuya.kusakabe@gmai=
l.com/

On Mon, May 4, 2026 at 12:30=E2=80=AFAM Yuya Kusakabe <yuya.kusakabe@gmail.=
com> wrote:
>
> From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
>
> This series adds the iproute2 frontend for the SRv6 Mobile User Plane
> (MUP) endpoint behaviors of RFC 9433.  It is sent in parallel with the
> matching kernel net-next series; each commit here is self-contained
> and brings in the seg6local UAPI bits it needs from the in-progress
> kernel UAPI header (include/uapi/linux/seg6_local.h):
>
>   Section 6.2  End.MAP
>   Section 6.3  End.M.GTP6.D
>   Section 6.4  End.M.GTP6.D.Di
>   Section 6.5  End.M.GTP6.E
>   Section 6.6  End.M.GTP4.E
>   Section 6.7  H.M.GTP4.D
>
> The series adds these seg6local CLI keywords:
>
>   src                  IPv6 source-address template
>   v4_mask_len          length of the IPv4 DA portion of the SID, in
>                        bits (1..32)
>   sr_prefix_len        locator length of the egress End.M.GTP*.E SID,
>                        in bits (1..88, leaving 40 bits for the
>                        Args.Mob.Session field)
>   v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
>                        template (1..127, defaults to 64); requires
>                        P + v4_mask_len <=3D 128
>   pdu_type             GTP-U PDU Session Container PDU Type (3GPP
>                        TS 38.415 Section 5.5.2): downlink|dl|uplink|ul
>                        or 0..15.  When omitted, the egress emits a
>                        short GTPv1-U header (no PDU Session Container)
>                        regardless of the QFI in the SID; 5G N3
>                        deployments must set pdu_type explicitly.
>
> A small per-action attribute validator (introduced in patch 1 and
> extended by each subsequent behavior) rejects obvious typos in the
> seg6local block at the userspace layer instead of leaving the
> operator with an opaque kernel EINVAL.
>
> Link: https://datatracker.ietf.org/doc/html/rfc9433
>
> Yuya Kusakabe (6):
>   seg6: add support for the End.MAP behavior
>   seg6: add support for the End.M.GTP4.E behavior
>   seg6: add support for the End.M.GTP6.E behavior
>   seg6: add support for the End.M.GTP6.D behavior
>   seg6: add support for the End.M.GTP6.D.Di behavior
>   seg6: add support for the H.M.GTP4.D behavior
>
>  include/uapi/linux/seg6_local.h |  17 +++
>  ip/ip_common.h                  |   2 +-
>  ip/ipnexthop.c                  |   2 +-
>  ip/iproute.c                    |  14 +-
>  ip/iproute_lwtunnel.c           | 263 +++++++++++++++++++++++++++++++-
>  man/man8/ip-route.8.in          | 154 +++++++++++++++++++
>  6 files changed, 442 insertions(+), 10 deletions(-)
>
>
> base-commit: 4f5de57e2ff11a5925dacdf3deeeabee7ba9502a
> --
> 2.50.1
>


--=20
Yuya Kusakabe

