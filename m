Return-Path: <netdev+bounces-99145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1098D3D28
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275711F24249
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A3187320;
	Wed, 29 May 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AuhPsZll"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303D1C6B2;
	Wed, 29 May 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001963; cv=none; b=QrCi4gM51cuoD4cvNKK1Fa53sNAbhs/MAhID++xErTzUU61Ejw1d816wZ6UOO5uH8kitZJmQWo4oWWLBUuj63U1nn9ubxx2AEbZDGpLRDiPGwLdCfSJRGfQqQYGP5pjlQ8xpizFVzqxZW1UPQT0MCxsQ8dd9AITOzrRS68HyZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001963; c=relaxed/simple;
	bh=3JmITgZLRm7PzrB8DVGRCNYKXDP7KKvUR8Ly1J2HzPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF/Rbc95PvRuOIxZmRxxxPthj2+3MOo848GB0N/rywdVQV9f3BuMkYM9L13WalGeVrPmzuYcEPdeAfjlAGA0V/f1ZquEzKu4TGMwz8ZcLssywbkw6hYHDDwwIL1xMWxI+0qrhta6kANsBCLYH3QELEPzTrLWbTmXsOPFffa7K/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AuhPsZll; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u+J7UNedaAitVJ/3TUFXdqiVh6hPSZVkhW52IorTbi0=; b=AuhPsZllPuI7ck4umh5WNFlRM4
	kjDsDXMQhqShyRjMN84jniKFVV1xgB4Uxj+kuH7+ZQ17fWCTsnKVqBzLoqnrzK5H175Jc35DdhZaz
	41jV09v9hOtW9JOyYemFejCrsVjrJmwd6svk2O1maclnS8lv/I9Kb4Ab7iJ80fGuZXRtzoZMBqk8a
	A+7RCy8gUAspOMQS/jKankHGJI6hWDHYzFiG/ZQPfseDgiXwUXKBpnzlNC24uNCy3K0XXitp1sn3D
	KBPKFd81xny2RqK03UZG8+YgaqrqKsW4SzK4QdyvPXeWk5l3vM24QGqCoQ59r3d4DCztjQgcZAD1f
	KQ4bz4NQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCMdy-000000050Zo-1YlQ;
	Wed, 29 May 2024 16:59:18 +0000
Message-ID: <9076abad-01f6-4ff4-a176-c2f4a85eb3fc@infradead.org>
Date: Wed, 29 May 2024 09:59:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] doc: new 'mptcp' page in 'networking'
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
 <20240528-upstream-net-20240520-mptcp-doc-v2-3-47f2d5bc2ef3@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240528-upstream-net-20240520-mptcp-doc-v2-3-47f2d5bc2ef3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Fix a few run-on sentences:

On 5/28/24 1:09 AM, Matthieu Baerts (NGI0) wrote:
> A general documentation about MPTCP was missing since its introduction
> in v5.6.
> 
> Most of what is there comes from our recently updated mptcp.dev website,
> with additional links to resources from the kernel documentation.
> 
> This is a first version, mainly targeting app developers and users.
> 
> Link: https://www.mptcp.dev
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - v2:
>     - Fix mptcp.dev link syntax.
> ---
>  Documentation/networking/index.rst |   1 +
>  Documentation/networking/mptcp.rst | 156 +++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                        |   2 +-
>  3 files changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 7664c0bfe461..a6443851a142 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -72,6 +72,7 @@ Contents:
>     mac80211-injection
>     mctp
>     mpls-sysctl
> +   mptcp
>     mptcp-sysctl
>     multiqueue
>     multi-pf-netdev
> diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
> new file mode 100644
> index 000000000000..ee0ae68ca271
> --- /dev/null
> +++ b/Documentation/networking/mptcp.rst
> @@ -0,0 +1,156 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Multipath TCP (MPTCP)
> +=====================
> +
> +Introduction
> +============
> +
> +Multipath TCP or MPTCP is an extension to the standard TCP and is described in
> +`RFC 8684 (MPTCPv1) <https://www.rfc-editor.org/rfc/rfc8684.html>`_. It allows a
> +device to make use of multiple interfaces at once to send and receive TCP
> +packets over a single MPTCP connection. MPTCP can aggregate the bandwidth of
> +multiple interfaces or prefer the one with the lowest latency, it also allows a

                                                         latency. It also

> +fail-over if one path is down, and the traffic is seamlessly reinjected on other
> +paths.
> +
> +For more details about Multipath TCP in the Linux kernel, please see the
> +official website: `mptcp.dev <https://www.mptcp.dev>`_.
> +
> +
> +Use cases
> +=========
> +
> +Thanks to MPTCP, being able to use multiple paths in parallel or simultaneously
> +brings new use-cases, compared to TCP:
> +
> +- Seamless handovers: switching from one path to another while preserving
> +  established connections, e.g. to be used in mobility use-cases, like on
> +  smartphones.
> +- Best network selection: using the "best" available path depending on some
> +  conditions, e.g. latency, losses, cost, bandwidth, etc.
> +- Network aggregation: using multiple paths at the same time to have a higher
> +  throughput, e.g. to combine fixed and mobile networks to send files faster.
> +
> +
> +Concepts
> +========
> +
> +Technically, when a new socket is created with the ``IPPROTO_MPTCP`` protocol
> +(Linux-specific), a *subflow* (or *path*) is created. This *subflow* consists of
> +a regular TCP connection that is used to transmit data through one interface.
> +Additional *subflows* can be negotiated later between the hosts. For the remote
> +host to be able to detect the use of MPTCP, a new field is added to the TCP
> +*option* field of the underlying TCP *subflow*. This field contains, amongst
> +other things, a ``MP_CAPABLE`` option that tells the other host to use MPTCP if
> +it is supported. If the remote host or any middlebox in between does not support
> +it, the returned ``SYN+ACK`` packet will not contain MPTCP options in the TCP
> +*option* field. In that case, the connection will be "downgraded" to plain TCP,
> +and it will continue with a single path.
> +
> +This behavior is made possible by two internal components: the path manager, and
> +the packet scheduler.
> +
> +Path Manager
> +------------
> +
> +The Path Manager is in charge of *subflows*, from creation to deletion, and also
> +address announcements. Typically, it is the client side that initiates subflows,
> +and the server side that announces additional addresses via the ``ADD_ADDR`` and
> +``REMOVE_ADDR`` options.
> +
> +Path managers are controlled by the ``net.mptcp.pm_type`` sysctl knob -- see
> +mptcp-sysctl.rst. There are two types: the in-kernel one (type ``0``) where the
> +same rules are applied for all the connections (see: ``ip mptcp``) ; and the
> +userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
> +<https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
> +connection. The path managers can be controlled via a Netlink API, see

                                                                 API; see

> +netlink_spec/mptcp_pm.rst.
> +
> +To be able to use multiple IP addresses on a host to create multiple *subflows*
> +(paths), the default in-kernel MPTCP path-manager needs to know which IP
> +addresses can be used. This can be configured with ``ip mptcp endpoint`` for
> +example.
> +
> +Packet Scheduler
> +----------------
> +
> +The Packet Scheduler is in charge of selecting which available *subflow(s)* to
> +use to send the next data packet. It can decide to maximize the use of the
> +available bandwidth, only to pick the path with the lower latency, or any other
> +policy depending on the configuration.
> +
> +Packet schedulers are controlled by the ``net.mptcp.scheduler`` sysctl knob --
> +see mptcp-sysctl.rst.
> +
> +
> +Sockets API
> +===========
> +
> +Creating MPTCP sockets
> +----------------------
> +
> +On Linux, MPTCP can be used by selecting MPTCP instead of TCP when creating the
> +``socket``:
> +
> +.. code-block:: C
> +
> +    int sd = socket(AF_INET(6), SOCK_STREAM, IPPROTO_MPTCP);
> +
> +Note that ``IPPROTO_MPTCP`` is defined as ``262``.
> +
> +If MPTCP is not supported, ``errno`` will be set to:
> +
> +- ``EINVAL``: (*Invalid argument*): MPTCP is not available, on kernels < 5.6.
> +- ``EPROTONOSUPPORT`` (*Protocol not supported*): MPTCP has not been compiled,
> +  on kernels >= v5.6.
> +- ``ENOPROTOOPT`` (*Protocol not available*): MPTCP has been disabled using
> +  ``net.mptcp.enabled`` sysctl knob, see mptcp-sysctl.rst.

                                  knob; see

> +
> +MPTCP is then opt-in: applications need to explicitly request it. Note that
> +applications can be forced to use MPTCP with different techniques, e.g.
> +``LD_PRELOAD`` (see ``mptcpize``), eBPF (see ``mptcpify``), SystemTAP,
> +``GODEBUG`` (``GODEBUG=multipathtcp=1``), etc.
> +
> +Switching to ``IPPROTO_MPTCP`` instead of ``IPPROTO_TCP`` should be as
> +transparent as possible for the userspace applications.
> +
> +Socket options
> +--------------
> +
> +MPTCP supports most socket options handled by TCP. It is possible some less
> +common options are not supported, but contributions are welcome.
> +
> +Generally, the same value is propagated to all subflows, including the ones
> +created after the calls to ``setsockopt()``. eBPF can be used to set different
> +values per subflow.
> +
> +There are some MPTCP specific socket options at the ``SOL_MPTCP`` (284) level to
> +retrieve info. They fill the ``optval`` buffer of the ``getsockopt()`` system
> +call:
> +
> +- ``MPTCP_INFO``: Uses ``struct mptcp_info``.
> +- ``MPTCP_TCPINFO``: Uses ``struct mptcp_subflow_data``, followed by an array of
> +  ``struct tcp_info``.
> +- ``MPTCP_SUBFLOW_ADDRS``: Uses ``struct mptcp_subflow_data``, followed by an
> +  array of ``mptcp_subflow_addrs``.
> +- ``MPTCP_FULL_INFO``: Uses ``struct mptcp_full_info``, with one pointer to an
> +  array of ``struct mptcp_subflow_info`` (including the
> +  ``struct mptcp_subflow_addrs``), and one pointer to an array of
> +  ``struct tcp_info``, followed by the content of ``struct mptcp_info``.
> +
> +Note that at the TCP level, ``TCP_IS_MPTCP`` socket option can be used to know
> +if MPTCP is currently being used: the value will be set to 1 if it is.
> +
> +
> +Design choices
> +==============
> +
> +A new socket type has been added for MPTCP for the userspace-facing socket. The
> +kernel is in charge of creating subflow sockets: they are TCP sockets where the
> +behavior is modified using TCP-ULP.
> +
> +MPTCP listen sockets will create "plain" *accepted* TCP sockets if the
> +connection request from the client didn't ask for MPTCP, making the performance
> +impact minimal when MPTCP is enabled by default.


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

