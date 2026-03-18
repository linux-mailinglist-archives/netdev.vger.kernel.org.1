Return-Path: <netdev+bounces-269004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIwNMxmbumnaZQIAu9opvQ
	(envelope-from <netdev+bounces-269004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755A2BB809
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94F6030488A1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD09D3D6666;
	Wed, 18 Mar 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d5NeCFer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069E3D6689
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837011; cv=pass; b=j3NNBFcUul+lZgaqf73upaVxyDjfwtI0pqE7+0+sM0k4xBl3nUrzJiwU9zeLpsONRtA9aq13tSOqTFOh+KwOMYSW10qADOvQTEcC20tmNQlfbOhXPhaC3SqW7wAQwZvmSGgEX+TGm/6x5OaJq+I+Ym81EyfczcPYFZ9L5cak7EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837011; c=relaxed/simple;
	bh=ROhlfTL9Sy3cHk6CLZy5m3sOd3WTbANPLHJNqzwB4D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAsyNbfZ7IEfSpCJl+mXLUnvMWXjuiLojHYGz7IQlWlUBqTOoGHSz7sxSpDg4XT3xBn96n3/wFI1NUEs6nRhCajaGRSJXeoWSwP5rV0Fg/5bafjOujq8EYELq5ERAhKaeDh0jL8oFA9EoTAKoQD8RRzfxu/JpqILqxFUpplMOTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d5NeCFer; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b980785a0bfso54267166b.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 05:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773837007; cv=none;
        d=google.com; s=arc-20240605;
        b=RcLIWHKbU0GlO/sJn9fvjYIZ03QwWRGVOUST7aaFpsxh9euZdSNj5qADIVIWR5Kjkf
         78G1IUb5XcVGkL/09TkJNdCM9kYdbbyVAFqlt9mjuHCk0xRxaVlsDkN0YML2iuhJTVei
         XA+FYA3xNUrN6WvVcUyRxaZh9LV0MSBgyw7YRtvCKpSYoOnoJXk/NXK6w0h1wX+M6YIo
         7kqETWUdhCwYRXieVgQljbywXd3RjnVIALSGGxywVEoSFD4v5XY0sGZH5ZI9+HfHnSq6
         awTkIcPpWReK0SJ26HwNt4DXUETdslX1j7GAXeRQH+5EkNumU9d9gwKyuomQ+CeoRkZe
         072g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iejl5bKnTCPX1VljyvIsJAO5CIjOaHMy3MfRtqFfauA=;
        fh=rWvHT/CJtuCrnt1MgpT05Tpac7Wm6ZuoegNycqTicUc=;
        b=aRoN5m9jzMnvAeH+dHWss1NminJnSG0mV/o/czkyv5/yNSSSYTL+bJ/8hIrBuuHyFl
         GQJvCkhux8mjSyusbb4oFdJxjphj0A/swhEe646Fugg+D6hkhEqH9QN2o7m5U01/bmgW
         a7x3k2tBl+zaj8NzlwZ/Q1mPfG34FUiODXy7rqEF171DSsuDF1nycdTij/mtB8mBWLGX
         RGTS89aWmtTYg5XGdk7MERa8P5DHu2oRLMRAcODUHGI1b/15hnqqcFpYAHMueUUwugGk
         bjLpZIbRYJd7u7p6WyxB17LoD0qqxVdvOon8ijCxUasNvSMpOYXVcUQomRB4j9IWYMKb
         L/jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773837007; x=1774441807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iejl5bKnTCPX1VljyvIsJAO5CIjOaHMy3MfRtqFfauA=;
        b=d5NeCFerBFz0COs5LpJQExE+1eZABScTmh6tz5Rm+H/w/jhkKCEW0vLT9xEzpeb/Ya
         5RZWDbwgRtvmoQxOf2226jvaCQsxpnFfB/q4POmDnz+Kl5l+MqWYO1/w44v3C2xEsZ1N
         D1myokwr/q0cOZuYf5jQxRuY2fulJJnbr9xPHOb+RlW+S95QixbZVVm0Vi/ZvabFYSCB
         Ckn0cZnq/y7YATrsnl7ddKIoJgFhETMrvja7HhGj9V24qg3jq0EquXQu9307a7RdRIu5
         Bax30aN5+LWNMHuNqMyTl4TtQS7RBLontmF4KEq+7CwJ5gl5uf5e1PoXTufa1+1Bh4Ne
         +4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837007; x=1774441807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iejl5bKnTCPX1VljyvIsJAO5CIjOaHMy3MfRtqFfauA=;
        b=HyeKZUJwSfwoZKCEH2P9V6ini3GO4JidGsEVoeFkuUuLVRhPhkhD91St9stAXGWsI8
         eh6f2UTZovhmGSGwt0ldG/IZzh2bE3S+SFcV3hk1PoHglO1YwoT2K5wwc0hnkwdwjIPl
         dGgCUcsrBHNxfeUzUwa8qftDPjELvXBwHtwyQxG5VBp6qZoKngK+gE82qhhxBsiYwJ9P
         f+QXBt1dn5rnUmwC5IFkj17D5p8+dC2TFE+1rWw+ll0+Dv09lNsIexjZHq5qBsBXLsId
         fqygFSYZEszVdDNfvGVR/QVOSxA0vzuv7W2PConnsQygztY2jOHhDrU0Sv5rilXfSNFV
         NmNg==
X-Gm-Message-State: AOJu0YxePzYZBd+xYRTT02z4b70QS4pYFlsnEJzi0KDzXs0m0X+HtIDe
	GsKtNuncaViaud0ComO6O5EDkBa2UpDw/hC7s1Z+Er9kq5e5nMr6jrMyWZOFFXZkEUoIdMHOZ/V
	VFUZQepxShOe4tHDwnIDE8UhKNAMOuQYydaPv33DRrg==
X-Gm-Gg: ATEYQzzscMYdAjA/Mr2VfJwRUc6xqR0RNWgZ/zdKXi3V+0D4o0UnBsChw6pa1ezZCrh
	bBFMy03XSGmsI7d/9Vv9j+FISlNKSCYNpV+D270OG1K+R2h5cuyyzQkN2sgRjHuIhu6NpfcG2Be
	ar/N7TMveZH8IVu0nEX/Er0ZSnvFXgXiiYzl1Ur+NHpqDNTEa6cHF/Q333M9NsGkESY4z9dI14r
	H0OY+ckSbYjbuPP2JXOYqyeDgZFpKHlZNSIb1cAUwP9HRrn0h1rzK9oMhBMaha3Ip7WNTS4tbwe
	dIr0xA==
X-Received: by 2002:a17:907:96a0:b0:b98:5b2:77f7 with SMTP id
 a640c23a62f3a-b9805b28b65mr102526066b.12.1773837006849; Wed, 18 Mar 2026
 05:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
 <20260316162955.1253225-3-justin.iurman@6wind.com> <20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
In-Reply-To: <20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Wed, 18 Mar 2026 13:29:56 +0100
X-Gm-Features: AaiRm53ZHeg1yAGrjAZWpjoVzZYmQo73kAIA1paBZyGcK5uHYxU7ySYRwEAC8Sw
Message-ID: <CAOY2BqxrY6je_34375P2FEGp=-TatSb3oSktWXcc-xBeMRqYVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] selftests: add check for seg6 tunsrc
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, justin.iurman@gmail.com, 
	nicolas.dichtel@6wind.com, stefano.salsano@uniroma2.it, 
	paolo.lungaroni@uniroma2.it, ahabdels@cisco.com, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269004-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,uniroma2.it,cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,mail.gmail.com:mid,srv6_hencap_red_l3vpn_test.sh:url,encap.red:url,uniroma2.it:email]
X-Rspamd-Queue-Id: 8755A2BB809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:54=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> On Mon, 16 Mar 2026 17:29:55 +0100
> Justin Iurman <justin.iurman@6wind.com> wrote:
>
> > Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
> > "tunsrc" feature.
> >
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> > ---
> >  .../net/srv6_hencap_red_l3vpn_test.sh         | 65 ++++++++++++++-----
> >  1 file changed, 50 insertions(+), 15 deletions(-)

[snip]

> > -     # Direction hs-1 -> hs-2 (H.Encaps.Red)
> > +     # Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
> >       # - rt-2 (SRv6 End.DT46 behavior)
> >       #
> >       # Direction hs-2 -> hs-1 (H.Encaps.Red)
> >       #  - rt-4,rt-3 (SRv6 End behaviors)
> >       #  - rt-1 (SRv6 End.DT46 behavior)
> > -     setup_rt_policy_ipv4 2 1 "" 2 encap.red
> > -     setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red
> > +     setup_rt_policy_ipv4 2 1 "" 2 encap.red true
> > +     setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red false
> >
> >       # create an IPv6 VPN between hosts hs-3 and hs-4
> >       # the network path between hs-3 and hs-4 traverses several router=
s
> >       # depending on the direction of traffic.
> >       #
> > -     # Direction hs-3 -> hs-4 (H.Encaps.Red)
> > +     # Direction hs-3 -> hs-4 (H.Encaps.Red + tunsrc)
> >       # - rt-2 (SRv6 End Behavior)
> >       # - rt-4 (SRv6 End.DT46 behavior)
> >       #
> >       # Direction hs-4 -> hs-3 (H.Encaps.Red)
> >       #  - rt-1 (SRv6 End behavior)
> >       #  - rt-3 (SRv6 End.DT46 behavior)
> > -     setup_rt_policy_ipv6 4 3 "2" 4 encap.red
> > -     setup_rt_policy_ipv6 3 4 "1" 3 encap.red
> > +     setup_rt_policy_ipv6 4 3 "2" 4 encap.red true
> > +     setup_rt_policy_ipv6 3 4 "1" 3 encap.red false
> >
> >       # testing environment was set up successfully
> >       SETUP_ERR=3D0
>
>
> The paths marked "true" here were testing the encap.red baseline before
> this change. They need to stay exactly as they were originally.
> Furthermore, if tunsrc is not supported by the kernel running the test,
> the ip route command with tunsrc will fail during setup() (since
> set -e is used), and the entire script dies before any test runs.

I kinda disagree here: you're not supposed to run the updated
selftests on an old kernel or with an old iproute2 version (versions
are kept aligned). And I also concur with Jakub about degraded
environments on your last comment below.

> The idea here is to avoid duplicating the entire test suite, while still
> providing dedicated test cases for the new per-route tunsrc. A reasonable
> approach could be adding the tunsrc checks as new, separate test cases
> that run after the baseline ones, leaving the existing paths completely
> untouched.
>
> For example, a dedicated test_tunsrc() function could take care of the
> whole thing for a given path: setting up the tunsrc address, installing
> the route with tunsrc, verifying the behavior, cleaning up, and finally
> restoring the original route.

Well, I actually thought that this approach would be easier, and would
specifically avoid adding too much code or having duplication. FWIW, I
don't think providing dedicated test cases for the new per-route
tunsrc really makes sense, as it's the same behavior as without
"tunsrc". It doesn't impact the encap baseline by itself, since
nothing in the selftests depends on the outer source address. I'm open
to implement what you suggest, though, it's just that I'm not sure
it's the best way forward.

What I suggest as next step: I'll ship patch #1 alone, along with the
iproute2-next companion series, so that we don't miss the merge window
and have the feature in 7.1. In parallel, we keep discussing design
choices for the selftest and ship it as soon as we settle. Would you
agree with that plan?

Cheers,
Justin

> > [snip]
> > @@ -819,6 +853,7 @@ test_command_or_ksft_skip ip
> >  test_command_or_ksft_skip ping
> >  test_command_or_ksft_skip sysctl
> >  test_command_or_ksft_skip grep
> > +test_command_or_ksft_skip ip6tables
> >
>
> This will skip the entire script if ip6tables is not present, which
> takes down the baseline tests too.
> I think a probe at startup that checks for both tunsrc support and
> ip6tables would work well here. If either is missing, we can
> just gracefully skip the new tunsrc tests and let the rest of the script
> run as usual.
>
> The bottom line is that the script needs to keep working exactly as
> before when tunsrc is not supported or its dependencies are missing.
>
> Thanks,
> Andrea

