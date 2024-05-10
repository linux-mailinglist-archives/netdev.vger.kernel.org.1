Return-Path: <netdev+bounces-95262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D6D8C1CAF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDFF280D72
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818314884C;
	Fri, 10 May 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNF/NkKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE2148844
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310285; cv=none; b=o4ZuMpebKAWxf5hBSMclHQpQEYM+tSE6aBwCedqX2PiY5aaDbzIUAxnffqm9wfGkcpW0GrLyhu6+UleRdq41iL5m4lWQ55i60lVg9+IswArS/o1oNgDChOZf0h8fEAW23Mnj7XwYdTbIW48/iiEF9TRx4qp64GfWhhd3kJ0oT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310285; c=relaxed/simple;
	bh=LjPHzwCFyMwVfjqom5DoydYZbbWV7DUpKtZlFgS7J7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa/AxtPK9HPgNVG6G+Wx2tMbHg/Rxp5y6OykaceEz+Sx3umcQo327/amMmBGqXKw67yO3HqUjFr4NJl2MR/6zUHHD0ezFIfutfwBwH2OSfevvR0Jjkzd0wE/pncXAazMiAfVpaILVGWJdB9ixuk2ufyrU76LuvXR+xSF04XfNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNF/NkKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8793C32781;
	Fri, 10 May 2024 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310285;
	bh=LjPHzwCFyMwVfjqom5DoydYZbbWV7DUpKtZlFgS7J7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNF/NkKCNF9n51neduwFsiHN83TNGSfTRrPR9k2eCSjSK2TXifi3Y8ESaD9kNkWa0
	 FyiyldKyLnRcqOOxEId7S0QMJ2EbeRtHYfdJdSe1cls0+4SYUFERTFm+w0RQSKIQTd
	 tVyvkE+1LNp63dEj0APLThf+9m3StZyLHpSUa9Z7f6Mwbp0hqN8xhWcYrwwKCfPyCu
	 LcDmMbXUebD8XLxnPyqucT/r/RfWq83TB1CAMqrgjXfgeluPYLnSfOi1FicNMyJmIY
	 YoYLf2nTm5Fy+zkoNNdBFRjfGaIhiuVOdloiSdZvFMAQrebJt8zmGqJLNKkCiz1cnO
	 oTdsggprhfACQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 01/15] psp: add documentation
Date: Thu,  9 May 2024 20:04:21 -0700
Message-ID: <20240510030435.120935-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation of things which belong in the docs rather
than commit messages.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/index.rst |   1 +
 Documentation/networking/psp.rst   | 138 +++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 Documentation/networking/psp.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 7664c0bfe461..0376029ecbdf 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -94,6 +94,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
    ppp_generic
    proc_net_tcp
    pse-pd/index
+   psp
    radiotap-headers
    rds
    regulatory
diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
new file mode 100644
index 000000000000..a39b464813ab
--- /dev/null
+++ b/Documentation/networking/psp.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================
+PSP Security Protocol
+=====================
+
+Protocol
+========
+
+PSP Security Protocol (PSP) was defined at Google and published in:
+
+https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
+
+This section briefly covers protocol aspects crucial for understanding
+the kernel API. Refer to the protocol specification for further details.
+
+Note that the kernel implementation and documentation uses the term
+"secret state" in place of "master key", it is both less confusing
+to an average developer and is less likely to run afoul any naming
+guidelines.
+
+Derived Rx keys
+---------------
+
+PSP borrows some terms and mechanisms from IPsec. PSP was designed
+with HW offloads in mind. The key feature of PSP is that Rx keys for every
+connection do not have to be stored by the receiver but can be derived
+from secret state and information present in packet headers.
+This makes it possible to implement receivers which require a constant
+amount of memory regardless of the number of connections (``O(1)`` scaling).
+
+Tx keys have to be stored like with any other protocol, but Tx is much
+less latency sensitive than Rx, and delays in fetching keys from slow
+memory is less likely to cause packet drops.
+
+Key rotation
+------------
+
+The secret state known only to the receiver is fundamental to the design.
+Per specification this state cannot be directly accessible (it must be
+impossible to read it out of the hardware of the receiver NIC).
+Moreover, it has to be "rotated" periodically (usually daily). Rotation
+means that new secret state gets generated (by a random number generator
+of the device), and used for all new connections. To avoid disrupting
+old connections the old secret state remains in the NIC. A phase bit
+carried in the packet headers indicates which generation of secret state
+the packet has been encrypted with.
+
+User facing API
+===============
+
+PSP is designed primarily for hardware offloads. There is currently
+no software fallback for systems which do not have PSP capable NICs.
+There is also no standard (or otherwise defined) way of establishing
+a PSP-secured connection or exchanging the symmetric keys.
+
+The expectation is that higher layer protocols will take care of
+protocol and key negotiation. For example one may use TLS key exchange,
+announce the PSP capability, and switch to PSP if both endpoints
+are PSP-capable.
+
+All configuration of PSP is performed via the PSP netlink family.
+
+Device discovery
+----------------
+
+The PSP netlink family defines operations to retrieve information
+about the PSP devices available on the system, configure them and
+access PSP related statistics.
+
+Securing a connection
+---------------------
+
+PSP encryption is currently only supported for TCP connections.
+Rx and Tx keys are allocated separately. First the ``rx-assoc``
+Netlink command needs to be issued, specifying a target TCP socket.
+Kernel will allocate a new PSP Rx key from the NIC and associate it
+with given socket. At this stage socket will accept both PSP-secured
+and plain text TCP packets.
+
+Tx keys are installed using the ``tx-assoc`` Netlink command.
+Once the Tx keys are installed all data read from the socket will
+be PSP-secured. In other words act of installing Tx keys has the secondary
+effect on the Rx direction, requring all received packets to be encrypted.
+Since packet reception is asynchronous, to make it possible for the
+application to trust that any data read from the socket after the ``tx-assoc``
+call returns success has been encrypted, the kernel will scan the receive
+queue of the socket at ``tx-assoc`` time. If any enqueued packet was received
+in clear text the Tx association will fail, and application should retry
+installing the Tx key after draining the socket (this should not be necessary
+if both endpoints are well behaved).
+
+Rotation notifications
+----------------------
+
+The rotations of secret state happen asynchornously and are usually
+performed by management daemons, not under application control.
+The PSP netlink family will generate a notification whenever keys
+are rotated. The applications are expected to re-establish connections
+before keys are rotated again.
+
+Kernel implementation
+=====================
+
+Driver notes
+------------
+
+Drivers are expected to start with no PSP enabled (``psp-versions-ena``
+in ``dev-get`` set to ``0``) whenever possible. The user space should
+not depend on this behavior, as future extension may necessitate creation
+of devices with PSP already enabled, nonetheless drivers should not enable
+PSP by default. Enabling PSP should be the responsibility of the system
+component which also takes care of key rotation.
+
+Note that ``psp-versions-ena`` is expected to be used only for enabling
+receive processing. The device is not expected to reject transmit requests
+after ``psp-versions-ena`` has been disabled. User may also disable
+``psp-versions-ena`` while there are active associations, which will
+break all PSP Rx processing.
+
+Drivers are expected to ensure that secret state is usable upon init
+(working keys can be allocated), and that no duplicate keys may be generated
+(reuse of SPI without key rotation). Drivers may achieve this by rotating
+keys twice before registering the PSP device.
+
+Drivers must use ``psp_skb_get_assoc_rcu()`` to check if PSP Tx offload
+was requested for given skb. On Rx drivers should allocate and populate
+the ``SKB_EXT_PSP`` skb extension, and set the skb->decrypted bit to 1.
+
+Kernel implementation notes
+---------------------------
+
+PSP implementation follows the TLS offload more closely than the IPsec
+offload, with per-socket state, and the use of skb->decrypted to prevent
+clear text leaks.
+
+PSP device is separate from netdev, to make it possible to "delegate"
+PSP offload capabilities to software devices (e.g. ``veth``).
-- 
2.45.0


