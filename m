Return-Path: <netdev+bounces-271565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOJsChHsw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A83266CF
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB29321E472
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285173D669E;
	Wed, 25 Mar 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="O0+yIvEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD83B27E0
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446210; cv=pass; b=dGCufyBfN7pZAeLGHFMXsNYTMRK8QWfaxrYEtqO8wR7QU3uW1H5kZ1eUVkV0Yr9i4sZuDfERUai/Zi6/VWe0RSyGF0riUjrr4KPtIvzOnZ4in323VO368Zp/uoFMEC3+/Nx+Kr7gH+87gaqQbVyEfAeTyS1qzCFUteOZ3SunR0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446210; c=relaxed/simple;
	bh=Ty+ZwtUIfiM1TTQbdI9KSw5FmoX7nhAYATEh+143UEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMTKhhUWoZjlDzGJS9t2CGGGjo8AOqS0zSEM3sXph/DgER61gwS5WOiFwcCGekWXHhqW4QiA+P2bL7FTIqPyzJExc94nUFMo+cGqYg/Bh298IS65bxZ2tukaBubu91s2aIgZycqAAaBApRmve1/MayIc8Htm9s8mwa2OCTSveL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=O0+yIvEG; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so334638a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774446207; cv=none;
        d=google.com; s=arc-20240605;
        b=iSD7EdjaQv7ffhfv0udewPEkW6whGOM7RqaiG93FxJz1PQkKsPhrWVo5eQRopHuMS8
         LmKe87aXKlqyYPjQguisK54uzlbY93If/cGTfjELphciXH8XmiyE1kxhsTEzkrEC89Ko
         WaM+jC3ya22iHDY65Tl+pzdnCOoQaXfrw3Ox1utZTM+EJkETsR6ypJriLovSq3JjOYEE
         gC9oOewLrtvJuOPCbwPatb13yGu9rHRgqvf2XIvyX48Bm8OSP+8Agnc1EG6jZTYDI6kV
         CnVNeHmFmQ1ekT783qE4OAS4dWtYy0++GROS99MjOPggquqPkmEmnvbs1fCTnFu6NW3f
         EoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lphqKf4F/uYNN8qYKbbQ1dR8GaPySrJrOoIkVeC30Gk=;
        fh=6onRMPJOFnN+SFYsH7i1T3oxeslPNmAyryxlffkEzvg=;
        b=QWowEXGzSg5OQLbeC9HXgNLnynsxxAmFWngcY3NYPxU6w2LuIhsOIYaJF3xglrzZeL
         i/AaPSHBuJNmS2iEwDUKcZR1D00Rp6OS4bOnRaiDNFUpLsGvl/iUax0xGDeq1P68LqPR
         75hkV0axfGmA5PPraSvPrm3BbYlSVqWE89c8X4um/ZjPjydRR8dxK5nGNNfCIDbnAHG5
         6mRyGXFwJ6RaYxU0Ol3AGCOpyypWJESyV0JBCgmxBHc97TyykTrxH91/C8hJ2q0hyE23
         frV/Lxm/as9kAQ2iGF+/5nwroTTd6Z1J4WG95YHbTba2z+4xLUd2AoeNV3OJ571rIeLR
         jDdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774446207; x=1775051007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lphqKf4F/uYNN8qYKbbQ1dR8GaPySrJrOoIkVeC30Gk=;
        b=O0+yIvEG8NwTKVKyAiwaEouQbKQVnrDIizVFsXFS8fsB1m1kkx56AEhB+wmFkwvEwR
         bGviQSUlBeb/rALyJxD0K1EZ6I26cophWc/eh4lmTMBqq1aVzJcjBqxipdvA4DWkrdf6
         k7a7es4kzyvPhA0DtTAP4xepAQ3CLaxOmyrC3CCpUW45Tkm2sUSU1i6VPnU5NLl9oPCo
         phU91kKYFj2tVXlPVWR0gVMMy59wQvCvuXFoYdT0Oc89m/jGRTWp/PzHGyP2o7cndyKt
         o0kt8JhXR6HOabzTsUQBxWcRjiprg2qo9yJDWQI9pNVpBw/IHHXNiwsdAHT9PmR+456k
         WXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446207; x=1775051007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lphqKf4F/uYNN8qYKbbQ1dR8GaPySrJrOoIkVeC30Gk=;
        b=YqqyjGPx+rz0KgG0z0shrG+/9IWipEMDxsQf/vtNzA9PW2s233dolAAnsq+8uk3cXl
         dvV8loNdj2tNSdmJMypBKmDevSeD1SEufTbIhh34Fieyea+tIGgTepIsH1EzEq0s28hu
         bM9DCVp9aRtIjOeCbVcfrEXj/AJcWvHTXQuv39Rv8Sx98RmKF5ewTJSuE9HdCqIhQ/Am
         Td0hR1Hps9a7nYLW42nmJp8aGbopu5K7mDGUYNVSa9t43rYL+e0EeuK7InKXi6bFgLwU
         AIVv37ZNSH4xyCTTwjfp+Y7JMtwXyMD3E8qICZ7RZ8aydIwHFAsDXMvdzHdTs61tXFnA
         yZDA==
X-Gm-Message-State: AOJu0YxR2IY0zffLfz8RMVCuGNm0FpLAxtogJr48l4F+W5d8vEFuPsiN
	zTBtB++/fD7hqIcGh5kxkykCtkvgLT0nM8YQVC2EiE9Qq8nms0PNw0OjlTGb6HeUrlVrR5dUutA
	GHH85tNLpuUp0V+a/piZLab5xSPeQBRdEXuekMVYpmg==
X-Gm-Gg: ATEYQzxd5Oqc+tWDELneCfiHg/YeHdtZMgMfCs8pI5gdAy7P96cz3DcHX2OdYj7WLmO
	bOXkZkwiOeOmWE6KGDQPoRyXisqV96T0U7j2+o7v+CUvp8nNldJUfDGFqLI4oQbXmofYIeW8afD
	iVLaXvEBJy8KMS9udJtXGCJ29HN/UvqTUwRiL+9WIhTsw+FZyp37K/Nz453YCwDg0ntSo8+n//R
	/UIOKR74zil62QSDb5rREElXQC3rya8Vq32Y9Rc4Zk/PBCEFRLTzB8SCkrV0nvfRG3q2fDvdEz0
	cIBZX7Om19zkRUD8hONGfIx5DRgnv7/wq9us88rW+Q==
X-Received: by 2002:a17:907:d096:b0:b98:2df5:9bf0 with SMTP id
 a640c23a62f3a-b9a3f18cc41mr271759566b.22.1774446206701; Wed, 25 Mar 2026
 06:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it> <20260322000557.12559-3-andrea.mayer@uniroma2.it>
In-Reply-To: <20260322000557.12559-3-andrea.mayer@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Wed, 25 Mar 2026 13:43:15 +0000
X-Gm-Features: AQROBzAHzQ59MoQMqYBo9gvtuAAC5KYkGPyBexA5BkJcYV-H6wYp6Sd3JHvprkI
Message-ID: <CAOY2Bqxb1C6myf7DBmfLM_3wZSweYQaQSAVSj_wDihf-N9vQJg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/3] seg6: add SRv6 L2 tunnel device (srl2)
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, 
	Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271565-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,mail.gmail.com:mid,uniroma2.it:email]
X-Rspamd-Queue-Id: 736A83266CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:06=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> Introduce srl2, an Ethernet pseudowire device over SRv6. It
> encapsulates L2 frames in IPv6 with a Segment Routing Header for
> transmission across an SRv6 network.
>
> The encapsulation logic reuses seg6_do_srh_encap() with
> IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
> infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
>
> The device is configured with a segment list for point-to-point
> L2 encapsulation.
>
> Usage:
>
>   ip link add srl2-0 type srl2 segs fc00::a,fc00::b

Thinking out loud...

We'll likely need SRv6 encap configurations specific to each entry
(i.e., MAC address), rather than (or in addition to) per interface.

We could also add a "mode" (e.g., "normal" mode or reduced mode?).

