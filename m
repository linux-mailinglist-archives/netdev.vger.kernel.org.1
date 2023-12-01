Return-Path: <netdev+bounces-52789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81C800375
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B4BB20EB8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BFBE5A;
	Fri,  1 Dec 2023 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hub64wgi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C271703
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 21:57:06 -0800 (PST)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 884214444C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 05:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701410224;
	bh=4C3Q+HYtKfZyxDgeOKsRqwmlAqpmpjj4o0+uQrRnSeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hub64wgiE/b7E2AE585ZbC9ukm3cuQL5xj3POaFpP27FysMtDf3kUj67O0KrA32vK
	 j6LGbNRRomJFEE/pdSK00YJUm4VF06tGgbVsYrJ1UyK4ju6xapdIfe7pBi9hdu+vJ4
	 mGwnLiIDQIFHd3u21Ho1kmLaU3Y5hH5iTseJh544JVK7lutQiIXBSbONQGX6meppDG
	 3yFAppSea4+ed1Qs5xsftx4I1JbL1GMn57gdlbdeNk41/IoAR3V7cvJd3a0PHFesUL
	 hVLOEI2HDPbRlZGbXmCaHTAdbB65YSYM/0Vr1J5oWL3ILhSVq5NiMjpoRPeqaCBtLV
	 X+gZdAY7nAiHw==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d336d8f91so1711327eaf.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 21:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701410223; x=1702015023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C3Q+HYtKfZyxDgeOKsRqwmlAqpmpjj4o0+uQrRnSeg=;
        b=Co+Hts7Gl+Hzb42sDbuRLYWgIW2QGVuo61/N5KqIz2C62xDhW++B5anqFvgu6rmW3z
         V3R/qlnItQjqN61iDVIlsF8CaZbsKBbIwL+OfsNaZoxNEVEmit8YsYEEvILFmHHatlwG
         GXQOmOeVbEylKdKG9o+cVfczUFea2AFeGKnB/g4CQSQ3y9D/FI70F8aLZaPHJmv8cINW
         6XIjB5oRCQfvqpErs/OmmhP/FKAcQJsSoCjDsXpUF3DdA7IJuK/7VDP9nTf18gHmXPcN
         e2MoATiDVTJgmiG0DOmmabVTuWeUeC/pAezg/thGRz8W8+ctaQUEuqo7/+fE7xfG/NX6
         nYpQ==
X-Gm-Message-State: AOJu0YwcYFKdlRfWdSQJKhFWuV51f7sTX6hHf/c+1h0SL8LGvGV0tlsm
	aCs7q/Ti7IzF+tLwyNmn+1+bkrUJIVRif+M7RTtEKdy/TJliYtiBeayYi47Tm7OVW+yDMd668Ql
	gQ7q2x2yMQWahLuXS5FiETznX1z+GC4qplcJ7uloiVh++9JXT
X-Received: by 2002:a05:6871:580e:b0:1fa:f5c8:ae26 with SMTP id oj14-20020a056871580e00b001faf5c8ae26mr3724oac.21.1701410223025;
        Thu, 30 Nov 2023 21:57:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Sv7F4YQ6l5th4NeOqoH+2HbufHCZ5sMoYMT8kmkwzAXGA7RHOxgGCCpwa8Zo2RVV8e4FXnLJOe95eFvtZ38=
X-Received: by 2002:a05:6871:580e:b0:1fa:f5c8:ae26 with SMTP id
 oj14-20020a056871580e00b001faf5c8ae26mr3712oac.21.1701410222758; Thu, 30 Nov
 2023 21:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130040105.1265779-1-liuhangbin@gmail.com> <20231130040105.1265779-2-liuhangbin@gmail.com>
In-Reply-To: <20231130040105.1265779-2-liuhangbin@gmail.com>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Fri, 1 Dec 2023 13:56:51 +0800
Message-ID: <CAMy_GT_YawM_6Xw9Qtt8rNLraAnfh_UkYjrb6j_1sWCSjfPN0w@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 01/14] selftests/net: add lib.sh
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org, 
	Guillaume Nault <gnault@redhat.com>, Petr Machata <petrm@nvidia.com>, 
	James Prestwood <prestwoj@gmail.com>, Jaehee Park <jhpark1013@gmail.com>, 
	Ido Schimmel <idosch@nvidia.com>, Francesco Ruggeri <fruggeri@arista.com>, 
	Justin Iurman <justin.iurman@uliege.be>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:01=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>
> Add a lib.sh for net selftests. This file can be used to define commonly
> used variables and functions. Some commonly used functions can be moved
> from forwarding/lib.sh to this lib file. e.g. busywait().
>
> Add function setup_ns() for user to create unique namespaces with given
> prefix name.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          |  2 +-
>  tools/testing/selftests/net/forwarding/lib.sh | 27 +-----
>  tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++
>  3 files changed, 87 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 9274edfb76ff..14bd68da7466 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -54,7 +54,7 @@ TEST_PROGS +=3D ip_local_port_range.sh
>  TEST_PROGS +=3D rps_default_mask.sh
>  TEST_PROGS +=3D big_tcp.sh
>  TEST_PROGS_EXTENDED :=3D in_netns.sh setup_loopback.sh setup_veth.sh
> -TEST_PROGS_EXTENDED +=3D toeplitz_client.sh toeplitz.sh
> +TEST_PROGS_EXTENDED +=3D toeplitz_client.sh toeplitz.sh lib.sh
>  TEST_GEN_FILES =3D  socket nettest
>  TEST_GEN_FILES +=3D psock_fanout psock_tpacket msg_zerocopy reuseport_ad=
dr_any
>  TEST_GEN_FILES +=3D tcp_mmap tcp_inq psock_snd txring_overwrite
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testin=
g/selftests/net/forwarding/lib.sh
> index e37a15eda6c2..8f6ca458af9a 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -4,9 +4,6 @@
>  ########################################################################=
######
>  # Defines
>
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> -
>  # Can be overridden by the configuration file.
>  PING=3D${PING:=3Dping}
>  PING6=3D${PING6:=3Dping6}
> @@ -41,6 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>         source "$relative_path/forwarding.config"
>  fi
>
> +source ../lib.sh
>  ########################################################################=
######
>  # Sanity checks
>
> @@ -395,29 +393,6 @@ log_info()
>         echo "INFO: $msg"
>  }
>
> -busywait()
> -{
> -       local timeout=3D$1; shift
> -
> -       local start_time=3D"$(date -u +%s%3N)"
> -       while true
> -       do
> -               local out
> -               out=3D$("$@")
> -               local ret=3D$?
> -               if ((!ret)); then
> -                       echo -n "$out"
> -                       return 0
> -               fi
> -
> -               local current_time=3D"$(date -u +%s%3N)"
> -               if ((current_time - start_time > timeout)); then
> -                       echo -n "$out"
> -                       return 1
> -               fi
> -       done
> -}
> -
>  not()
>  {
>         "$@"
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests=
/net/lib.sh
> new file mode 100644
> index 000000000000..518eca57b815
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +########################################################################=
######
> +# Defines
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=3D4
> +
> +########################################################################=
######
> +# Helpers
> +busywait()
> +{
> +       local timeout=3D$1; shift
> +
> +       local start_time=3D"$(date -u +%s%3N)"
> +       while true
> +       do
> +               local out
> +               out=3D$("$@")
> +               local ret=3D$?
> +               if ((!ret)); then
> +                       echo -n "$out"
> +                       return 0
> +               fi
> +
> +               local current_time=3D"$(date -u +%s%3N)"
> +               if ((current_time - start_time > timeout)); then
> +                       echo -n "$out"
> +                       return 1
> +               fi
> +       done
> +}
> +
> +cleanup_ns()
> +{
> +       local ns=3D""
> +       local errexit=3D0
> +       local ret=3D0
> +
> +       # disable errexit temporary
> +       if [[ $- =3D~ "e" ]]; then
> +               errexit=3D1
> +               set +e
> +       fi
> +
> +       for ns in "$@"; do
> +               ip netns delete "${ns}" &> /dev/null
> +               if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev=
/null; then
> +                       echo "Warn: Failed to remove namespace $ns"
> +                       ret=3D1
> +               fi
> +       done
> +
> +       [ $errexit -eq 1 ] && set -e
> +       return $ret
> +}
> +
> +# setup netns with given names as prefix. e.g
> +# setup_ns local remote
> +setup_ns()
> +{
> +       local ns=3D""
> +       local ns_name=3D""
> +       local ns_list=3D""
> +       for ns_name in "$@"; do
> +               # Some test may setup/remove same netns multi times
> +               if unset ${ns_name} 2> /dev/null; then
> +                       ns=3D"${ns_name,,}-$(mktemp -u XXXXXX)"
> +                       eval readonly ${ns_name}=3D"$ns"
> +               else
> +                       eval ns=3D'$'${ns_name}
> +                       cleanup_ns "$ns"
> +
> +               fi
> +
> +               if ! ip netns add "$ns"; then
> +                       echo "Failed to create namespace $ns_name"
> +                       cleanup_ns "$ns_list"
> +                       return $ksft_skip
> +               fi
> +               ip -n "$ns" link set lo up
I got this patchset tested the result is looking good. However it
seems that not all of the tests require this loopback bring up, e.g.
* arp_ndisc_untracked_subnets.sh
* cmsg_ipv6.sh
* cmsg_so_mark.sh
* cmsg_time.sh
* drop_monitor_tests.sh
* icmp.sh
* ndisc_unsolicited_na_test.sh
* sctp_vrf.sh
* unicast_extensions.sh

A possible solution could be adding an extra flag to setup_ns(), bring
lo up on demand.

Not sure if this is needed, as I can't think of possible impacts of
this for the moment.
(Maybe a test does not require loopback device in such state?)
Other might be able to provide some feedback about this.

> +               ns_list=3D"$ns_list $ns"
> +       done
> +}
> --
> 2.41.0
>

