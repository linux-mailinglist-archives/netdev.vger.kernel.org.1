Return-Path: <netdev+bounces-258330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGUiG+2/jGmisgAAu9opvQ
	(envelope-from <netdev+bounces-258330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:44:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54D126B42
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE3F0300F515
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E634EF0D;
	Wed, 11 Feb 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FubW0Q69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595130AAD0
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831819; cv=none; b=iHxoDZU4olGaw7eseqvsFvsPc610SjxjGOPMTSf4CHbJuAtqkYn0RlWAaPGA6y69kkLQmz48sUINgiQqtY7OoGnvnTcrLdhRDtbP9f67c3Mj3Q1Z9UMlm/HHDiX68Dg6kjL3v6+2PnDcLShaFy7qxZquT4rtsUA5pFOb8omoz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831819; c=relaxed/simple;
	bh=AwWCSDrjKmcnyOyEsme8CImTtgR7+RGZbSCLoizXFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNdvIUnHpXhqE7wMyjKAuWd24B6KqSERWfmipQkIyAbrQTuVeq+pCwpADjEbSY0BVWoMd5/qMVvhKnI6F6YuL+XoZM8D2pyo23lQ2Xx1hgceFh1spUMM3yc7AkDk8qTJ4N9bzxlFruOiGYc7nrr1deeSTAb/Q0YI0jLlblB9fps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FubW0Q69; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6481bd173c0so4844193d50.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770831817; x=1771436617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVHmBx6JgqdyMRN3xgBzaFyHXpp+KqxUacobTKKIt2M=;
        b=FubW0Q69YEpXS8T/Bwzy6Mi3TtMq7JiILQpaIcy50XwZcpp0j976qmLYVd2SKbTyQ3
         l1nq/kxwdVChfGidrsaDRtc9zuvLMm7CW8MZ75aekZP+tDYWvOFSDQRme2scQ0L5o4ob
         UcZe1lpVXFCvMGlvHhdixVruzmqkkbE95v8iDkDAcYbWxWJx/5k8K/A0+7tRnBr8xVi/
         sID/n/yG/nN+bFekYu6TUwNqB0oFn+4dYRYJM051qVxIIXvnfHWtn1yvFa0tbrCyJCUS
         m/HYi1uRr4xDGU7E41ubL6e351UnxZgOdqHCYy7a9PDwEellWJPcLdnRxockQ9ou/6Yb
         UFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831817; x=1771436617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVHmBx6JgqdyMRN3xgBzaFyHXpp+KqxUacobTKKIt2M=;
        b=Q6EfIjF7m08V+lo26NaGPxE6+4B+oNDxZJspCfS/kFVMpYNVHZGotTKq+jIGPv7TX1
         W00c8cQG5n/wawXL8V+L3Sb8Rgs0gxvI0oZmoGIU7yFpt+/tj03h4P6nsgxWx2jtKcMx
         xiWsPXQYxA+oPDouYaDlQw45pb9DjRbMoFzz5Xt1YbnigfUnDf4HrgoDbmV65ODgq0fU
         rh3sUW566+F6FlaDWxOEZ8NX+S24J4lBSO+Fpm4hBG0vZjgbVV0G9MPDqiIHY4hJtw4v
         suvb6XlKdbRnX0+QM4I5iTqbmBtgu9oP0YinA4ToZWK5gahz0V0sAGKbqbSbDCKBBTs9
         cBVQ==
X-Gm-Message-State: AOJu0YwSXfNaZDUkziMwC+F9pbQ3KMtz6OJ476IMAxd5BZq/0bUUnM5t
	G8mTW0vuMfl+RlG2Hrc53qNgQZGLpG8RgMme9WL3olBSZAJI42wUasPd
X-Gm-Gg: AZuq6aLh3nXPwVYd3QdZktTzmQDVjdze6VsMaZQ71kG6eNHO5cgm8ThDj0nimdIA+uj
	XZVhElkznwiWVszOqXeaOMzcy5tDohilB8SmoKpHk0MLTA9dBim5fFB5oAjWVJI7kzWLq6mjUaH
	sjTZ7x7LG51HWMDqgKgjvTgc354vPBkRTARCb9/eIn6JNBRA6Tfys9sgIM35YqsUvsLqpuRNKKx
	U5vFHJrzG4Ub0PKKNRmrwrYA9C823mzPaeaS6X33lFLVfobHW9qXRQC6KfAaXVFz/7HQV5FsNjS
	JB9xSc4pcPQi3UuQeKtqR9Hd6vuuTi+J+grdDyrDb/Ba3eENSU+7FIJTsQ6LtsdFYR7F8ZNpo/O
	Lwae9d+RiNZKOeO8FTj6bthWPLAn9mwMrlSxzrozGT4AMKcsqS59Nez52wxbxDk1OIazP58yRQN
	1iX1RLPNkdLzXBca4nwY33A6c/AOThOiOO+4rk+0CvXSqnnWo5slDV5JDW
X-Received: by 2002:a53:a64b:0:b0:644:4986:4545 with SMTP id 956f58d0204a3-64bbaa863f9mr77069d50.37.1770831816664;
        Wed, 11 Feb 2026 09:43:36 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83ff82sm2593688d50.2.2026.02.11.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:43:36 -0800 (PST)
Date: Wed, 11 Feb 2026 09:43:34 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>, Wei Wang <weibunny@meta.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 3/4] selftests/net: Add env for container based
 tests
Message-ID: <aYy/xmgPNArOFOr7@devvm11784.nha0.facebook.com>
References: <20260210200419.3555944-1-dw@davidwei.uk>
 <20260210200419.3555944-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210200419.3555944-4-dw@davidwei.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:email,devvm11784.nha0.facebook.com:mid,lib.py:url]
X-Rspamd-Queue-Id: BF54D126B42
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:04:18PM -0800, David Wei wrote:
> Add an env NetDrvContEnv for container based selftests. This automates
> the setup of a netns, netkit pair with one inside the netns, and a BPF
> program that forwards skbs from the NETIF host inside the container.
> 
> Currently only netkit is used, but other virtual netdevs e.g. veth can
> be used too.
> 
> Expect netkit container datapath selftests to have a publicly routable
> IP prefix to assign to netkit in a container, such that packets will
> land on eth0. The BPF skb forward program will then forward such packets
> from the host netns to the container netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../testing/selftests/drivers/net/README.rst  |  19 ++
>  .../drivers/net/hw/lib/py/__init__.py         |   7 +-
>  .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
>  .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
>  4 files changed, 190 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index eb838ae94844..39370a83f238 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -62,6 +62,25 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
>  
>  Local and remote endpoint IP addresses.
>  
> +LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think LOCAL_PREFIX_V4 is not supported in this series?

> +
> +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
> +network name spaces behind macvlan, veth, netkit devices). DUT must be
> +reachable using these addresses from the endpoint.
> +
> +  +-------------+        +----------------------------+
> +  | INIT NS     |        | TEST NS                    |
> +  | +---------+ |        | +------------------------+ |
> +  | | NETIF   | |  bpf   | | Netkit                 | |
> +  | |         |-|--------|>| nk_guest               | |
> +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
> +  | +---------+ |        | +------------------------+ |
> +  | | Netkit  | |        +----------------------------+
> +  | | nk_host | |
> +  | +---------+ |
> +  +-------------+
> +
>  REMOTE_TYPE
>  ~~~~~~~~~~~
>  
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> index d5d247eca6b7..022008249313 100644
> --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> @@ -3,6 +3,7 @@
>  """
>  Driver test environment (hardware-only tests).
>  NetDrvEnv and NetDrvEpEnv are the main environment classes.
> +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
>  Former is for local host only tests, latter creates / connects
>  to a remote endpoint. See NIPA wiki for more information about
>  running and writing driver tests.
> @@ -29,7 +30,7 @@ try:
>      from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
>          ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
>      from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
> -    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
> +    from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
>  
>      __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
>                 "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
> @@ -44,8 +45,8 @@ try:
>                 "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
>                 "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
>                 "ksft_not_none", "ksft_not_none",
> -               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
> -               "Iperf3Runner"]
> +               "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
> +               "Remote", "Iperf3Runner"]
>  except ModuleNotFoundError as e:
>      print("Failed importing `net` library from kernel sources")
>      print(str(e))
> diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> index a18e21069f7a..6b55068d5370 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
> @@ -3,6 +3,7 @@
>  """
>  Driver test environment.
>  NetDrvEnv and NetDrvEpEnv are the main environment classes.
> +NetDrvContEnv extends NetDrvEpEnv with netkit container support.
>  Former is for local host only tests, latter creates / connects
>  to a remote endpoint. See NIPA wiki for more information about
>  running and writing driver tests.
> @@ -43,12 +44,12 @@ try:
>                 "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
>                 "ksft_not_none", "ksft_not_none"]
>  
> -    from .env import NetDrvEnv, NetDrvEpEnv
> +    from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
>      from .load import GenerateTraffic, Iperf3Runner
>      from .remote import Remote
>  
> -    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote",
> -                "Iperf3Runner"]
> +    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraffic",
> +                "Remote", "Iperf3Runner"]
>  except ModuleNotFoundError as e:
>      print("Failed importing `net` library from kernel sources")
>      print(str(e))
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 41cc248ac848..857ae0f37516 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -1,13 +1,16 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +import ipaddress
>  import os
>  import time
> +import json
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
>  from lib.py import ksft_setup, wait_file
>  from lib.py import cmd, ethtool, ip, CmdExitFailure
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
> +from . import bpftool, RtnlFamily, Netlink
>  
>  
>  class NetDrvEnvBase:
> @@ -289,3 +292,163 @@ class NetDrvEpEnv(NetDrvEnvBase):
>                  data.get('stats-block-usecs', 0) / 1000 / 1000
>  
>          time.sleep(self._stats_settle_time)
> +
> +
> +class NetDrvContEnv(NetDrvEpEnv):
> +    """
> +    Class for an environment with a netkit pair setup for forwarding traffic
> +    between the physical interface and a network namespace.
> +    +-------------+        +----------------------------+
> +    | INIT NS     |        | TEST NS                    |
> +    | +---------+ |        | +------------------------+ |
> +    | | NETIF   | |  bpf   | | Netkit                 | |
> +    | |         |-|--------|>| nk_guest               | |
> +    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
> +    | +---------+ |        | +------------------------+ |
> +    | | Netkit  | |        +----------------------------+
> +    | | nk_host | |
> +    | +---------+ |
> +    +-------------+
> +    """
> +
> +    def __init__(self, src_path, rxqueues=1, **kwargs):
> +        super().__init__(src_path, **kwargs)
> +
> +        self.netns = None
> +        self._nk_host_ifname = None
> +        self._nk_guest_ifname = None
> +        self._tc_clsact_added = False
> +        self._tc_attached = False
> +        self._bpf_prog_pref = None
> +        self._bpf_prog_id = None
> +        self._init_ns_attached = False
> +
> +        self.require_ipver("6")
> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
> +        if not local_prefix:
> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
> +
> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> +        self.ipv6_prefix = f"{local_prefix}::"
> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
> +
> +        rtnl = RtnlFamily()
> +        rtnl.newlink(
> +            {
> +                "linkinfo": {
> +                    "kind": "netkit",
> +                    "data": {
> +                        "mode": "l2",
> +                        "policy": "forward",
> +                        "peer-policy": "forward",
> +                    },
> +                },
> +                "num-rx-queues": rxqueues,
> +            },
> +            flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
> +        )
> +
> +        all_links = ip("-d link show", json=True)
> +        netkit_links = [link for link in all_links
> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
> +                        and 'UP' not in link.get('flags', [])]
> +
> +        if len(netkit_links) != 2:
> +            raise KsftSkipEx("Failed to create netkit pair")
> +
> +        netkit_links.sort(key=lambda x: x['ifindex'])
> +        self._nk_host_ifname = netkit_links[1]['ifname']
> +        self._nk_guest_ifname = netkit_links[0]['ifname']
> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
> +
> +        self._setup_ns()
> +        self._attach_bpf()
> +
> +    def __del__(self):
> +        if self._tc_attached:
> +            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
> +            self._tc_attached = False

I know this was resolved before, but unfortunately I think these might
have to be getattr (or another approach) for the case of
super().__init__() failing? I found one bad setup may result in
resolve_remote_ifc() failing and cascading up:

Traceback (most recent call last):
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/./tools/testing/selftests/drivers/net/hw/nk_netns.py", line 29, in <module>
    main()
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/./tools/testing/selftests/drivers/net/hw/nk_netns.py", line 23, in main
    with NetDrvContEnv(__file__) as cfg:
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/tools/testing/selftests/drivers/net/lib/py/env.py", line 315, in __init__
    super().__init__(src_path, **kwargs)
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/tools/testing/selftests/drivers/net/lib/py/env.py", line 173, in __init__
    self.remote_ifname = self.resolve_remote_ifc()
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/tools/testing/selftests/drivers/net/lib/py/env.py", line 234, in resolve_remote_ifc
    return v6[0]["ifname"] if v6 else v4[0]["ifname"]
TypeError: 'NoneType' object is not subscriptable
Exception ignored in: <function NetDrvContEnv.__del__ at 0x7fab5578c1f0>
Traceback (most recent call last):
File "/data/users/bobbyeshleman/linux-worktrees/tcp-dm-netkit/tools/testing/selftests/drivers/net/lib/py/env.py", line 370, in __del__
    if self._tc_attached:
AttributeError: 'NetDrvContEnv' object has no attribute '_tc_attached'

Best,
Bobby

