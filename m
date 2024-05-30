Return-Path: <netdev+bounces-99428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E608D4D85
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E451C2120A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAF17D8B0;
	Thu, 30 May 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC6DJvho"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541617D8A9;
	Thu, 30 May 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078092; cv=none; b=Sf1wnEizElYArU7Vr6IfX/2m0ARkZa+gINNbAfxj2+B5/G0DVw8zHZRjr3eE+cCD5XCLFsr1O0RXN9DU6qNqsQ36E/8il77jjQx+Mu7kbnYg3J30SseA/Qj1jZhJYZSUKjNjIZOmJY/CflbAn4fAQWCToC0pcA+G7m3HtDxcOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078092; c=relaxed/simple;
	bh=iC5sHTeety2sZO7dIyi8nb8XUzo5F8zKpPMD1PfEHEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlNnqLMZnSFa/lXRcxltOJ+qagUxYDTeedY151JEMdu0dUDgJ9CXUP4Xo9xEpzkBdK9WVnMK2xdNpVqwix7iUxTS7htdRBpYeWCO1O4k4+OOPUrq6P73jqNZkhVXGYKJIbg225c8RwnJoXvRUwituwbqoKL/kdgy23sFwzLPXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC6DJvho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DC9C4AF0E;
	Thu, 30 May 2024 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717078092;
	bh=iC5sHTeety2sZO7dIyi8nb8XUzo5F8zKpPMD1PfEHEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TC6DJvhomq1RSFkY+le9EBCuzqhNgOBaozNmAKdnUMT97FNHTk2p5NaONwSe0PzZH
	 kdJXTGQ9ipHukfKGKiNgEYHf4QuNFBgZkc8xUTJTgmQjWWNYB5p1NbZ2bPAPdHVTTk
	 x8NDPhwWriA6boaqDTBGQE/P66h/b54W2ZXZjsIFBjIWca/cJ/T3ewowiX2D4csT3W
	 ktz7S3czutmFfm/GDcXST6h/4o6CLZ57Wime07YThqIwttSeCPwbnUe1gqXmWeWgmP
	 BoXDZPvUuHIlDafDf5ryvMhX1XlKzvrSwLuQm9GWm10TM2/QQedqi8DJZGWZ4JcubS
	 lAM3wJUXJNAlw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 30 May 2024 16:07:32 +0200
Subject: [PATCH net-next v3 3/3] doc: new 'mptcp' page in 'networking'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-upstream-net-20240520-mptcp-doc-v3-3-e94cdd9f2673@kernel.org>
References: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
In-Reply-To: <20240530-upstream-net-20240520-mptcp-doc-v3-0-e94cdd9f2673@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8710; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iC5sHTeety2sZO7dIyi8nb8XUzo5F8zKpPMD1PfEHEE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmWIg+Ucr/LYX5c7xdpgI5aODbaKJbnOegw0MbA
 0jYODn9ZxSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZliIPgAKCRD2t4JPQmmg
 c6R4D/935EX6shxWOd7UIxAl6CUZuFYePiMfk+rE+aBpvSVNYR14xHvRXbAm+j+1izjtK9v1ARg
 xemOLy6uorTPvs4ON//9oZhXGCuGA27T88XN5iyu9xcGkQ0LwXj3GvkSpa/KAMwrV4Dnz8cyCS3
 Tg0LP42RsHFcjugn/w5zrdYw59WQh8ewzatqmGJd2ekVH6TjKkQHBq6pByJqNhbfRnjvVXV8dik
 54sSBcHdvooFCtSyIrloc92hAQByeQiMC+G1R5lhjf+UGoskOv/WNIfPtj3X+YMJT8yHYdw9dLO
 MaN2P7500GXV0zE7LHjqkVcK+kJcEom+2q/7nczt6iLCHnphvp664mgWaTICrc2GqileUQGc1am
 vYx73Go1SckP7H98KEu4M8z7KrpbsVR8FTdWev2++OnyP0tDfkKXeEPDMU8ZR6qmvxS06H815Ox
 t5m7NXmFRfi+JjgTtANJ7vkLBbk/ofpUgEY/7lgLOYMhYHmnSqidKwjsxB6P80IwTRAEhd3w8jn
 BcnQHn9nRXfyZCrWJsD1sxm9BHi0TWav5plPsljLohSIGcG95EBr2n2hxK7lddgy19w2x7T22+j
 vxgoyes0S9A9lcBngHshe5AjPOnmlqlkONPyC229WJqj49T8jfZgtRhVu++W7F5dIK9Cx+rutRl
 Kgd02VvZZNtU27w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A general documentation about MPTCP was missing since its introduction
in v5.6.

Most of what is there comes from our recently updated mptcp.dev website,
with additional links to resources from the kernel documentation.

This is a first version, mainly targeting app developers and users.

Link: https://www.mptcp.dev
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v2:
    - Fix mptcp.dev link syntax.
  - v3:
    - Fix a few run-on sentences (Randy)
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/networking/index.rst |   1 +
 Documentation/networking/mptcp.rst | 156 +++++++++++++++++++++++++++++++++++++
 MAINTAINERS                        |   2 +-
 3 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 7664c0bfe461..a6443851a142 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -72,6 +72,7 @@ Contents:
    mac80211-injection
    mctp
    mpls-sysctl
+   mptcp
    mptcp-sysctl
    multiqueue
    multi-pf-netdev
diff --git a/Documentation/networking/mptcp.rst b/Documentation/networking/mptcp.rst
new file mode 100644
index 000000000000..17f2bab61164
--- /dev/null
+++ b/Documentation/networking/mptcp.rst
@@ -0,0 +1,156 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multipath TCP (MPTCP)
+=====================
+
+Introduction
+============
+
+Multipath TCP or MPTCP is an extension to the standard TCP and is described in
+`RFC 8684 (MPTCPv1) <https://www.rfc-editor.org/rfc/rfc8684.html>`_. It allows a
+device to make use of multiple interfaces at once to send and receive TCP
+packets over a single MPTCP connection. MPTCP can aggregate the bandwidth of
+multiple interfaces or prefer the one with the lowest latency. It also allows a
+fail-over if one path is down, and the traffic is seamlessly reinjected on other
+paths.
+
+For more details about Multipath TCP in the Linux kernel, please see the
+official website: `mptcp.dev <https://www.mptcp.dev>`_.
+
+
+Use cases
+=========
+
+Thanks to MPTCP, being able to use multiple paths in parallel or simultaneously
+brings new use-cases, compared to TCP:
+
+- Seamless handovers: switching from one path to another while preserving
+  established connections, e.g. to be used in mobility use-cases, like on
+  smartphones.
+- Best network selection: using the "best" available path depending on some
+  conditions, e.g. latency, losses, cost, bandwidth, etc.
+- Network aggregation: using multiple paths at the same time to have a higher
+  throughput, e.g. to combine fixed and mobile networks to send files faster.
+
+
+Concepts
+========
+
+Technically, when a new socket is created with the ``IPPROTO_MPTCP`` protocol
+(Linux-specific), a *subflow* (or *path*) is created. This *subflow* consists of
+a regular TCP connection that is used to transmit data through one interface.
+Additional *subflows* can be negotiated later between the hosts. For the remote
+host to be able to detect the use of MPTCP, a new field is added to the TCP
+*option* field of the underlying TCP *subflow*. This field contains, amongst
+other things, a ``MP_CAPABLE`` option that tells the other host to use MPTCP if
+it is supported. If the remote host or any middlebox in between does not support
+it, the returned ``SYN+ACK`` packet will not contain MPTCP options in the TCP
+*option* field. In that case, the connection will be "downgraded" to plain TCP,
+and it will continue with a single path.
+
+This behavior is made possible by two internal components: the path manager, and
+the packet scheduler.
+
+Path Manager
+------------
+
+The Path Manager is in charge of *subflows*, from creation to deletion, and also
+address announcements. Typically, it is the client side that initiates subflows,
+and the server side that announces additional addresses via the ``ADD_ADDR`` and
+``REMOVE_ADDR`` options.
+
+Path managers are controlled by the ``net.mptcp.pm_type`` sysctl knob -- see
+mptcp-sysctl.rst. There are two types: the in-kernel one (type ``0``) where the
+same rules are applied for all the connections (see: ``ip mptcp``) ; and the
+userspace one (type ``1``), controlled by a userspace daemon (i.e. `mptcpd
+<https://mptcpd.mptcp.dev/>`_) where different rules can be applied for each
+connection. The path managers can be controlled via a Netlink API; see
+netlink_spec/mptcp_pm.rst.
+
+To be able to use multiple IP addresses on a host to create multiple *subflows*
+(paths), the default in-kernel MPTCP path-manager needs to know which IP
+addresses can be used. This can be configured with ``ip mptcp endpoint`` for
+example.
+
+Packet Scheduler
+----------------
+
+The Packet Scheduler is in charge of selecting which available *subflow(s)* to
+use to send the next data packet. It can decide to maximize the use of the
+available bandwidth, only to pick the path with the lower latency, or any other
+policy depending on the configuration.
+
+Packet schedulers are controlled by the ``net.mptcp.scheduler`` sysctl knob --
+see mptcp-sysctl.rst.
+
+
+Sockets API
+===========
+
+Creating MPTCP sockets
+----------------------
+
+On Linux, MPTCP can be used by selecting MPTCP instead of TCP when creating the
+``socket``:
+
+.. code-block:: C
+
+    int sd = socket(AF_INET(6), SOCK_STREAM, IPPROTO_MPTCP);
+
+Note that ``IPPROTO_MPTCP`` is defined as ``262``.
+
+If MPTCP is not supported, ``errno`` will be set to:
+
+- ``EINVAL``: (*Invalid argument*): MPTCP is not available, on kernels < 5.6.
+- ``EPROTONOSUPPORT`` (*Protocol not supported*): MPTCP has not been compiled,
+  on kernels >= v5.6.
+- ``ENOPROTOOPT`` (*Protocol not available*): MPTCP has been disabled using
+  ``net.mptcp.enabled`` sysctl knob; see mptcp-sysctl.rst.
+
+MPTCP is then opt-in: applications need to explicitly request it. Note that
+applications can be forced to use MPTCP with different techniques, e.g.
+``LD_PRELOAD`` (see ``mptcpize``), eBPF (see ``mptcpify``), SystemTAP,
+``GODEBUG`` (``GODEBUG=multipathtcp=1``), etc.
+
+Switching to ``IPPROTO_MPTCP`` instead of ``IPPROTO_TCP`` should be as
+transparent as possible for the userspace applications.
+
+Socket options
+--------------
+
+MPTCP supports most socket options handled by TCP. It is possible some less
+common options are not supported, but contributions are welcome.
+
+Generally, the same value is propagated to all subflows, including the ones
+created after the calls to ``setsockopt()``. eBPF can be used to set different
+values per subflow.
+
+There are some MPTCP specific socket options at the ``SOL_MPTCP`` (284) level to
+retrieve info. They fill the ``optval`` buffer of the ``getsockopt()`` system
+call:
+
+- ``MPTCP_INFO``: Uses ``struct mptcp_info``.
+- ``MPTCP_TCPINFO``: Uses ``struct mptcp_subflow_data``, followed by an array of
+  ``struct tcp_info``.
+- ``MPTCP_SUBFLOW_ADDRS``: Uses ``struct mptcp_subflow_data``, followed by an
+  array of ``mptcp_subflow_addrs``.
+- ``MPTCP_FULL_INFO``: Uses ``struct mptcp_full_info``, with one pointer to an
+  array of ``struct mptcp_subflow_info`` (including the
+  ``struct mptcp_subflow_addrs``), and one pointer to an array of
+  ``struct tcp_info``, followed by the content of ``struct mptcp_info``.
+
+Note that at the TCP level, ``TCP_IS_MPTCP`` socket option can be used to know
+if MPTCP is currently being used: the value will be set to 1 if it is.
+
+
+Design choices
+==============
+
+A new socket type has been added for MPTCP for the userspace-facing socket. The
+kernel is in charge of creating subflow sockets: they are TCP sockets where the
+behavior is modified using TCP-ULP.
+
+MPTCP listen sockets will create "plain" *accepted* TCP sockets if the
+connection request from the client didn't ask for MPTCP, making the performance
+impact minimal when MPTCP is enabled by default.
diff --git a/MAINTAINERS b/MAINTAINERS
index 27367ad339ea..1a65444adb21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15753,7 +15753,7 @@ B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
 F:	Documentation/netlink/specs/mptcp_pm.yaml
-F:	Documentation/networking/mptcp-sysctl.rst
+F:	Documentation/networking/mptcp*.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h

-- 
2.43.0


