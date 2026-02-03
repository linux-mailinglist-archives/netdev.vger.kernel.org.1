Return-Path: <netdev+bounces-256071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB1XNxpSgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:40:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B479D3715
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5500230156FD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769122773CA;
	Tue,  3 Feb 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Af7+gO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2713D8B1
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082840; cv=pass; b=AG+0IPRxTB8R8FLq986EZZnYdKUrr9B+JLzNUrN3t6ffupZbrceleqRNtIWekli1HeIRd4+2gS52IheEAVUVTvrqKwtrnVGbv5nTvNGGr+ePolUNDPh++ZlGTuXxt10gsnGmOSvXb2hogiaqPYmB/oWbQx5jxSb9N/Igr7D5gWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082840; c=relaxed/simple;
	bh=zbRtSL8Ax2LP1NjvDUBFjLgYR0DQFYvsLAjuBIau+Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6FA+iaZtPMyESjkdkQGKr02m0MeU6Czz/+ex7s5tVdU9NI7o+JjqPCzu1roejiiM3VhBlBUMKVmFK/KERJrBd+RyumsOte6a8BbxSXdUuvpBBqKd0Dd8OeJp87ZDqp9vfvKybq9vLRPZGjO+ntZrpYbgivLDuB+Su/KIHXpqNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Af7+gO; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4094fbd1808so2085347fac.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 17:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770082838; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0ceVrVQuPqILT+j1X37qKzlIwQMXBFGyQ3cA4vCyeve8xT+QrthrnsYKZsiw3nWbY
         IlbEtC/W7y1CR9mYQgsSGYZO4z+gTtnaIa/0bUTYY2DktXhchypb5PjAiX1ZNbTa3EVd
         kzjqPD4R82JO1d2B+E8KdCM3U8MRuXRITyOgkHuaRGk8HAJoxkzJI8f8jqRWSg7RdC/d
         sCiCAY1wD8lwSdB67nAvULjZgBRVIcyhl3eSQsn8XzLwmtUwbhdV8JAMRB7sqF0Ph/BG
         530YH70DNb3HfgwpTniSpZ1ORIwThtCHfFHUPF5gb9LofmcZ40Qh31v9MCRocdi6OlQy
         Wi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiyjI9Vm1kMsfb2xN9SbpfX5GEHueGZjQa5LCuffj60=;
        fh=2tLs7OlYcuQT/uYY8G6wiSANZwhXhHz+hk/EgYW/Z9s=;
        b=E7vCzScawZZ6XT7MpyqSlFDlPotfjgFPZaBahvK46JHgYMU7sTAKqJjUdejG7roeGg
         9TpxGCmxXhsRS4sXm7uPUcNybeO9RP/Fmxpxty9NmiieVAPIz0tSTuloSwpcL0ct6Dbb
         KemDTClRHPjPz+eXippVCl1qaPxPJr5/TBrGZ4uygIPeewnvAUEbRZZHIjd33zhWe5p6
         /4KIWb4ExocxEqwggJ72lZTKATLuBK4YFligqh3Gt/xP2d1owLnzfn59bJk+i4ktIjg+
         g0P4+svz3VN7vPm5IbmSIKQBfnDzlNY4lXrx/GgR0cke4jEth+JOiY2zfoCGen6RJMi0
         X9Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082838; x=1770687638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiyjI9Vm1kMsfb2xN9SbpfX5GEHueGZjQa5LCuffj60=;
        b=D7Af7+gOIIa1Sh+M2Rcsbi6OgIbOtADBpgb2TkbpCvxsrhOU+CllgdiVaPHLhy5gzJ
         9vYNXfWqeYYLMm7P5oItOsQ51QqBoR4GtkSAd1l0PFbjJ3Ghc1R9ZkF4ly9gvzizmTwu
         Tn2HFRK5czAsmerLY3zp5QxGnf4P5w3Eim+dX3EmNuRx0u93lp3b01/CsTw06mIevshO
         hU67LKXgqwRevKvlt2/nADa75vAftvMlBwbLXR1o7Y0NJRoFkPlom9JSz3toujAz6E/S
         JuGvtNLbopcfjpTFQTSd+2D8Dpl/Vxq3l1skaaM+24T+Px9UFUA2AzcwRcWa5eWU59Tp
         Z8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082838; x=1770687638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiyjI9Vm1kMsfb2xN9SbpfX5GEHueGZjQa5LCuffj60=;
        b=oruDxZAFt+8VTQCIgawpe/rckufn9fV4mP+FmfTF5qClF14Hc+986DufVq/7Vs7bkI
         9GmtSg5BCfYCPu9WYwZhNiiGM1gFjMbEhXIywWT3YC+JyxxkZa/O7PniddI37ymyiwPt
         14jTeMcVHpvg9lO+sOkIK6v6FpGPhqOTAhvVFdawZAYCQF4c/UgXXHp4VE1hUJO3NJoi
         NDY+nDMgpzwR2k8C4VZHcSDiUh0PCF3UKHPGGb6FiuPcD0W5B72sY0CjOinczPD/Xd/M
         7lojl83Irt0WQhKZ0MCYz9c3X1ptYj8av//YXYz8n6wu6NkMFrklXLE9PUCBjSkVkmhL
         8MbQ==
X-Gm-Message-State: AOJu0Ywx52Ikb6DaSlM5cgQnfTxjHGqLigy6UkUeqAv3m7VhmpAMsrgF
	16ZhnSRV/qgfaqNpA1LNBW9Sn5xheqJLexGkFET00EwAbQm76IpEFdV8xM4ijJEjhfp7hnB0unf
	+KmXz+1sMQDvM1JM9LJGAfRDNOlHz30k=
X-Gm-Gg: AZuq6aJLBxonqmajpjajMfYnPkslVjA/ESei7uJCCUE44o1YvJEUNA5Yl7PHq+TUsqQ
	aBnVHgzqg8kQLNaPJ42cm8svWKjEb5NGU/z4ul2ulem2JC1I+U/kVv0+BnGZ4XC9EmriUjfZFfj
	NnvCFks1MrWIarhRVWVMkJkS1PjkBXt7T1vRJKKMsAv6x7uZ7eq6/dtsBxe5T5Do/H8mPuuXpjc
	ThlO9EG3ihOlgjmD2ecmHixEKcoYCIuyqSuN4nxAxbDV7LiLZNe2vX5ODRVvuF9AInn7YusknLs
	I7HK/d1UU3cctrXv7AAnXNipBrThJQ==
X-Received: by 2002:a05:6820:205:b0:662:bf9b:1638 with SMTP id
 006d021491bc7-6630f3f1bf5mr6818609eaf.62.1770082837986; Mon, 02 Feb 2026
 17:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131045821.3451873-1-mmyangfl@gmail.com> <20260202105218.sx5k6ksy5ycpfyxf@skbuf>
In-Reply-To: <20260202105218.sx5k6ksy5ycpfyxf@skbuf>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 3 Feb 2026 09:40:02 +0800
X-Gm-Features: AZwV_Qi-vRlyab4tdaKUWb0tOBo8rCG61AiWbG6nMiyg8MoDWve8mlymJmIy1l4
Message-ID: <CAAXyoMOiLBcS3E8kRFGpxPzhXEtq+BhZRkQNbvcNiG96+LRQqw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: sync dsa_mall_policer_tc_entry with FLOW_ACTION_POLICE
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5B479D3715
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:52=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Sat, Jan 31, 2026 at 12:58:16PM +0800, David Yang wrote:
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index f59d66f0975d..2a209b83c701 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -1497,8 +1497,19 @@ dsa_user_add_cls_matchall_police(struct net_devi=
ce *dev,
> >       mall_tc_entry->cookie =3D cls->cookie;
> >       mall_tc_entry->type =3D DSA_PORT_MALL_POLICER;
> >       policer =3D &mall_tc_entry->policer;
> > +     /* until they export the type of act->police in flow_offload.h ..=
. */
>
> There is no "us" and "them", it's a single git tree. Just submit a patch
> to whomever ./scripts/get_maintainer.pl says to.
>
> Have you tried something like the patch attached (just compile-tested)?

Yes, but I was afraid it would be kind of inconsistent not exposing
other struct flow_action_*. Nicer and better approach, though.

