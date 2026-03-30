Return-Path: <netdev+bounces-273314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJnlACLTymmsAQYAu9opvQ
	(envelope-from <netdev+bounces-273314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C33609CD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4DD5305561A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57839B495;
	Mon, 30 Mar 2026 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM7jqwdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94D39A7FA
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899570; cv=pass; b=kqxI494JVHV2bWAnOHY3QGZtBDY+C2VB6LEo6B9m5KFU6Ub3bAGhIQWBnLHUQwbSKygvLCfu8VZyrYCs8dgQnypVId24Nwl/rIrqAHr5cG+UON+Hz1y0GGhXQTCz2PIMxjXNo4+FARPnuhKDs9U5bVe4PU/blMfjfCcjyC+hO60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899570; c=relaxed/simple;
	bh=raOnWdkwciR774nemG5W5s7l+qsio7cSR6A3+T7p82Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae3jaII10s3zJjlZOwt3FuzPUZ3MZGxpiERQYoNNEtj0ZjOAF58hfdKnw2WVQzPGcbckblVDsyEXXlMdSQC+nR9IdP8Amz/WQu0+z/aIDasgIMbxnXHhPaDtLWMG9ohbsuUd9YUG0fMlLMswFiEjnIvH/+SWYRevoFoAGNsvnlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM7jqwdh; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso531215966b.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899567; cv=none;
        d=google.com; s=arc-20240605;
        b=TryR8WH4HI2TljJwayzm9XjMN6UhmFsdwexmk+mpbh68H1OAtlSy3MTeZKJNh7m/UA
         k9zLPoussduKPSAk8xfH9mJd064Y/21OXPhVPYLxs6mkX2QDXMzWGS34aEln7+rmDFAi
         KAV8x0ADC3unq0+U4ndJBQOyRQhU+Gtxn+eQx+GMAJUA2eveROwfuVuEquCtoE4weOe8
         IqEUh9qsMw4l912Jyt6mqt/eiuG2PX8nOpfkOfRfKyIZtyEIblNe5epTInjN5rM9UtLr
         kJunrR9zOIPz/I0mEaae5m2erL6Dn7JauWCMAHp6wqPoHRIyAyIJ19uhof2LZEglrofV
         hoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        fh=DxU4otGZDM1BykcDirRXYMSBe1eM4HF3WO4A2x46fk4=;
        b=DqS4FwScSLJ3Dtd43FztM4psL82XryuT4Oq4bQzExauEXJF6aDwEis58tI/lrLkMbs
         3h2jR6UnoCQNl+HqCWJNLGqfwc+8EiAsPDYjoPVjVOXFO4AQHsCJvrt3tN1U++Oo9gHT
         RY/9ugYsl1nGEEfuOt00u1svN8DhB6CFSFbKhziSRODJsptU1l8Yq7LA/r+oOGDbuxYi
         4XALYodTI7Vtasnb2Q6OJYXVj4rQJeuPwtDL74Lwt+544K3F8Gh6WLEuMTocsdBx82DN
         bHr6qEpFKbZGRDnFSaj0jqvqhOL8FNqfxio3CZpJKZrOYpCsPL4wp5DlPS6d6a7lK8x/
         TlpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899567; x=1775504367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        b=gM7jqwdhW2iE88jS5syb5bwmhyo9wNc2USf0BEwwBaNuF4dlYsz8oJo9DXaaoh8KaF
         9ZhkNK3xGPKX5Lpz+t3jPWwRUlU3HvsDo6BidFHzszGw1hiGI3T6bNf80S0sM2PzgeXB
         oADL5LZiq5vjq3JpM5S+jVzmc2jdKi79JP/bjEMZZR4LkaUCaCuPihpVcKD4ZYg4kPRR
         qw3TMJwytaCdFEYylnjNvjckVr+43aSlxbx+uE+56BO1Pw4uMhcdfJo9rOQt3t8AGLfs
         1LoXBtgvT6jFqKlhRhHyt20FdrTFp4vz2F111N96vEWtoYAeiqTvx31wdrK+JBzEPJey
         1nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899567; x=1775504367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        b=YLvHDad/IWIYn4ykABw8gz/rgQoaIK0PQUYB4twwTVZHSQAJBmxAYoBm91qYVNJbFY
         OkgXWS36CjqKz5wvPvFpdIp2B25oc8PrzSwnBi3kcgzu8rC/ulqLSsnVN4qDIGKNNoby
         xhKjVSxAVQzGmBRhvVrxrieSQMLB2yHQz6FwyBQKbEPxxApzlHFcf3sb2YU4BdN5Iz0/
         eWcYwatuiVvNiWsNdZYro/bjHt/BjMH7OFNaczRdbtuLN2vn4JUOg1aMLpXaaIkywgAZ
         vNwbLyCzFRYHIAv+bvf+uHwm7lNeJjWJ/MemdbDMoZUdIj35F+EDfVgQA47AO5v9yOpK
         Vffg==
X-Forwarded-Encrypted: i=1; AJvYcCUuJDW5wVdKV0QiQ0Lm6pmQ/ijom/HsYGvUeYIJZlQ/Gh8FJglOthyo+8vlrWNjTEUjFiZjvdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2QYWg2oImJ79+PWdpbkixgTfz7U3b0QeNHkFwvYw8Jma8gNU
	Hw7A6DKFo+7me+6IVFN9P8jJL+wJ7/YCR3DlZewTBy5zOcSO8bvcSNjwEfE/oYZwgSiodRCEW5Q
	L9negOais9zvY1g4SXl/CcMcDMs87+Jk=
X-Gm-Gg: ATEYQzyRMgc/072F1SLKQFmIR51DGfDuV3LeJKFr2K0/hYoqK9NJpcuKIlxDDaFT0Yv
	PkwSzlb91qrNS/vpbyeNcnGp153Nq1GeflQtaAWY7B+oshdNBlSzxnZbYSaP7vTAAI0ZB41uLch
	kPXW1V/bXDjfRFP00hPbg7jfnuDMGqwd+IGZkZfpRZ52X65TEAh+deQOzON+BJJVlbON9C+oVdb
	xgy4rGh9LRLah4dKhyFnqF2TWOjWhp1zRU1GEPZ1mbXHYuGNq8sVpo0iakwMxHuNpxR1UoYShT1
	XFO6Whs=
X-Received: by 2002:a17:907:846:b0:b98:4f24:a6d with SMTP id
 a640c23a62f3a-b9b502bfd51mr937477666b.11.1774899567358; Mon, 30 Mar 2026
 12:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org> <20260330191611.16929-1-royujjal@gmail.com>
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Tue, 31 Mar 2026 01:09:15 +0530
X-Gm-Features: AQROBzBPKFrWxeTO63V57MZLR93bpDWq5OJl46BKm3EnyddwLm9W3nhW6ZcH4tU
Message-ID: <CAE2MWkkY3anF0Am4JbCFeFax1dSH2F7AyRUjHJs6S17fKkhU6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast
 exponential field encoding
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273314-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_igmp.sh:url]
X-Rspamd-Queue-Id: 516C33609CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 12:46=E2=80=AFAM Ujjal Roy <royujjal@gmail.com> wro=
te:
>
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.
>
> The patches introduce a unified floating-point encoding
> approach based on RFC3376 and RFC3810, ensuring that large
> intervals are correctly represented in QQIC and MRC fields
> using the exponent-mantissa format.
>
> Key Changes:
> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>   Removes legacy macros in favor of a cleaner, unified
>   calculation for retrieving intervals from encoded fields,
>   improving code maintainability.
>
> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>   Standardizes MLDv2 terminology by renaming mldv2_mrc()
>   to mldv2_mrd() (Maximum Response Delay) and introducing
>   a new API mldv2_qqi for QQI calculation, improving code
>   readability.
>
> * ipv4: igmp: encode multicast exponential fields
>   Introduces the logic to dynamically calculate the exponent
>   and mantissa using bit-scan (fls). This ensures QQIC and
>   MRC fields (8-bit) are properly encoded when transmitting
>   query packets with intervals that exceed their respective
>   linear threshold value of 128 (for QQI/MRT).
>
> * ipv6: mld: encode multicast exponential fields
>   Applies similar encoding logic for MLDv2. This ensures
>   QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>   when transmitting query packets with intervals that exceed
>   their respective linear thresholds (128 for QQI; 32768
>   for MRD).
>
> Impact:
> These changes ensure that multicast queriers and listeners
> stay synchronized on timing intervals, preventing protocol
> timeouts or premature group membership expiration caused
> by incorrectly formatted packet headers.
>
> v2:
> - Retargeted the series to net-next as suggested
> - Fixed a compilation warning in the MLD rename change
> - Kept reverse xmas tree order in IGMP exponential encoding change
> - Added bridge selftests to validate IGMPv3 Query MRC and QQIC handling
>
> Ujjal Roy (5):
>   ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>   ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>   ipv4: igmp: encode multicast exponential fields
>   ipv6: mld: encode multicast exponential fields
>   selftests: net: bridge: add tests for igmpv3 MRC and QQIC validation
>
>  include/linux/igmp.h                          | 158 +++++++++++++++-
>  include/net/mld.h                             | 179 +++++++++++++++++-
>  net/bridge/br_multicast.c                     |  22 +--
>  net/ipv4/igmp.c                               |   6 +-
>  net/ipv6/mcast.c                              |  19 +-
>  .../selftests/net/forwarding/.gitignore       |   2 +
>  .../testing/selftests/net/forwarding/Makefile |  10 +
>  .../selftests/net/forwarding/bridge_igmp.sh   | 109 +++++++++++
>  .../selftests/net/forwarding/mc_decode.c      |  38 ++++
>  .../selftests/net/forwarding/mc_encode.c      |  40 ++++
>  10 files changed, 535 insertions(+), 48 deletions(-)
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c
>
>
> base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
> --
> 2.43.0
>

Forgot to attach test result using bridge_igmp.sh selftest.
First two test cases are added newly v3query_mrc_test and v3query_qqic_test=
.

Without these patches:
tools/testing/selftests/net/forwarding# ./bridge_igmp.sh
TEST: IGMPv3 query: verify MRC (configured=3D160, expected=3D132)       [FA=
IL]
        Bad MRC value in IGMP packet:     Max Resp Time: 51.2 sec (0xa0)
TEST: IGMPv3 query: verify QQIC (configured=3D160, expected=3D132)      [FA=
IL]
        Bad QQIC value in IGMP packet:     QQIC: 160
TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
...

With these patches:
tools/testing/selftests/net/forwarding# ./bridge_igmp.sh
TEST: IGMPv3 query: verify MRC (configured=3D160, expected=3D132)       [ O=
K ]
TEST: IGMPv3 query: verify QQIC (configured=3D160, expected=3D132)      [ O=
K ]
TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
...

