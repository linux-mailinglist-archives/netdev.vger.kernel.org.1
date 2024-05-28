Return-Path: <netdev+bounces-98421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6988D15E9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B8DB22BAC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375213D60D;
	Tue, 28 May 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W35IUspS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229C13D509;
	Tue, 28 May 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883798; cv=none; b=Hkv3gVY8diotrhJyEeIqdgHLzQgCPL9MEvyZTxnEig74z+aatG3hykQMvRkFe3hhQiWZ1Gs/aXN30cK/+otwUqKRI/zkQUKge2MGmSCeP9gdjxcsYyBONuyTg3POhaPQtYrQwT+XPFxw6/dt3mrzTJrC5w9XZTTem0HeKWmJjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883798; c=relaxed/simple;
	bh=qKXzA71iQazzuaFwaRvE/GV0og5PaxKwQ3vjJNhpXjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGvq2cNr7Mea9B4H75LctpXaHkqXtVrJssRhQZq9tOtI+dLq7EvX6GHazvW+wLcJYUmAtSru6oIVXW0J8Hr2r3t+meX9LyrNXI8mo41sWJk/RmqmD+/w/eF+aHP/RrHzzmRukrgEKLAoXc6ZzHfsuhmuB6zrZ1h1l++t1tx06kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W35IUspS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BCCC4AF11;
	Tue, 28 May 2024 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716883798;
	bh=qKXzA71iQazzuaFwaRvE/GV0og5PaxKwQ3vjJNhpXjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W35IUspSwyuF49bxl1m5dcTOkoeHnbXPJ3p9muwi4d4kcF9r/pgB5Ri8i+btv10iw
	 GUBjeZVdikxX8DuobP9ePw/nWC0xIqrLlkqOyiE5YomEB4V/ItlZ8XQzuAwbwfKVLI
	 FJfNz0RSxJ125oVtddeqjcFYcwBTWvHZTW6PFrNZ7ZE0z44c5fDSE6CwHXBezhF/Nc
	 qgD5djV1g1+4AVt5IvuPYgJ5wnEq8hg4ERzKLG4xLTHbHQtfLWwURyvfft3q9tj/Fe
	 cdsyQ1nt7unpHQ/GEC1tgQMuDfOwfaXw8GcUM00H8TfBXzshB3/zkEmrztb7iiTMFn
	 plSc4SNzLPyDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 May 2024 10:09:18 +0200
Subject: [PATCH net-next v2 3/3] doc: new 'mptcp' page in 'networking'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-upstream-net-20240520-mptcp-doc-v2-3-47f2d5bc2ef3@kernel.org>
References: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
In-Reply-To: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8617; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qKXzA71iQazzuaFwaRvE/GV0og5PaxKwQ3vjJNhpXjE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVZFJFGQixHB6d3jeu0DsGyE7HJqOJjptlAB5J
 WRZ01yikteJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlWRSQAKCRD2t4JPQmmg
 cxm3EACBfK5oHE9qdXvOHHqk5OMxscBfnKth+55JAtsGifWCH69VD+nCLOaT+V9INOKOBfHptCP
 vQIcaFMzcu2DZXhM6xU0dsc/F3jQxp9Y/SO1FsXsW9ktsak8m6r9AOYWBgCS34aOSD2ptGk4PGX
 Wqu7YbY8FHFAzJHWSP3lE+Pllx99cK5OTGVAYEbhq+TOirPeXxTlj+lOpjN8qdMs/W9pc1w/5mm
 1HqkbuSGMtJdRBisActQhuJUCSQAMZJSCqcEY/1m8NasXkbUt2gXwqBA2snYFqzI0801X79lWt8
 Bh343rI5VB1yN4fKs8hxca5TXby5kDIU/l4OKeaScUoSE2NEqVXlgOQS3dox501MMEXIeJ7VCGj
 CXxhrAjlKhWsTzzgFY+i/HZkEWDu+d1efM1v/LpZr1hSPkxzdxY9y4cHw46wYeM94r/3I0jsfEd
 tdBmOwJPlTKNvphQsT0uMnXP/IV+wjGhf7padDtLVQW+jBPOYQFAmm4Ocswd/QgAtf6vqZgvcpI
 AeOdV961eTWCIVytsB6XICzIhVCEGl8ced1voP4W/ZcCvGlQh1eCTU4CMFvxQP6PBDGUVtUvL12
 QM8rvNinP6ICHqgjizU0h8z38yFUNz0fJGOzR7ZdQ4bROSpH1C9peOManvgUnWO9b9/qtcAg/YZ
 oCdyGXpZh44XLCA==
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
index 000000000000..ee0ae68ca271
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
+multiple interfaces or prefer the one with the lowest latency, it also allows a
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
+connection. The path managers can be controlled via a Netlink API, see
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
+  ``net.mptcp.enabled`` sysctl knob, see mptcp-sysctl.rst.
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


