Return-Path: <netdev+bounces-145394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7D9CF61B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EBA2820D2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D231E3DF1;
	Fri, 15 Nov 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNrQ8nXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DF1E32CF;
	Fri, 15 Nov 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702450; cv=none; b=dLmnOuBSBcTek+CO1EuEteuXvpIGZaV1+oxmafRHwbeSKhkWMbUNXXkORpvmh9z2byfuGmq5VYfqAIkQvp+zVD40sjThDi9QvxHtpTm6o4We2Rts+rnpcOGkCj0wZCW+iE7jwXgIKWvQ27yGGDD5IWiTlnyRseaV3MUdchMEXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702450; c=relaxed/simple;
	bh=Q3F2qI8lyJJ5Gvw9bbees6RjAgrPk8PS9O2FYnpkP/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZNaOfZXbWMxEfDAbkne3/E69CfYfH65zcjpDSL4tALcrJn4rdWAmNz8FqR89ltI9IbExaz7W5tjU1Ox5rQ/aps7YYwRKPIzyfSXfavGlSGIvdCS+uAHbmHo0ckvwBMUdj+iDg9X3o2lM5LIu0gPGHCN2NMLkTLDpyxaKtIEepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNrQ8nXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6F6C4CECF;
	Fri, 15 Nov 2024 20:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731702450;
	bh=Q3F2qI8lyJJ5Gvw9bbees6RjAgrPk8PS9O2FYnpkP/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNrQ8nXRkb8HwRWUUkRzefKt6c3MuJ9U0q+nFDCn179Qwb/biLEUYHq/vP6N7icV2
	 jtSq9eQNy6wnciLFLWCwNjrtN9PM2s5F4U5gU02YtGGGdDxf5VYCiStUBw4qeyaypY
	 t0PE2N0qjKKRV86HK6IVvdJivh5LgdQMO51nAtZk+ecKActFWKtgwTuzCrE5ZJv9CT
	 TvUv4/9vl1RLPTT44BXCCq1o0DceQ61t7IXGUI0LcnP6HqMjOW8b3huVvTLi99B09/
	 Ld7kGpC6bCcgkS448Djmu3ujHspZY6cCUX1P7cj/8ooMPMxN09qM7OO2H/m+dnIlSc
	 GomrCavYNV2yw==
Date: Fri, 15 Nov 2024 12:27:28 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com,
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
	brett.creeley@amd.com, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org,
	jdamato@fastly.com, aleksander.lobakin@intel.com,
	kaiyuanz@google.com, willemb@google.com, daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 4/7] net: ethtool: add support for
 configuring header-data-split-thresh
Message-ID: <ZzeusGr18H98xSQN@x130>
References: <20241113173222.372128-1-ap420073@gmail.com>
 <20241113173222.372128-5-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113173222.372128-5-ap420073@gmail.com>

On 13 Nov 17:32, Taehee Yoo wrote:
>The header-data-split-thresh option configures the threshold value of
>the header-data-split.
>If a received packet size is larger than this threshold value, a packet
>will be split into header and payload.
>The header indicates TCP and UDP header, but it depends on driver spec.
>The bnxt_en driver supports HDS(Header-Data-Split) configuration at
>FW level, affecting TCP and UDP too.
>So, If header-data-split-thresh is set, it affects UDP and TCP packets.
>
>Example:
>   # ethtool -G <interface name> header-data-split-thresh <value>
>
>   # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
>   # ethtool -g enp14s0f0np0
>   Ring parameters for enp14s0f0np0:
>   Pre-set maximums:
>   ...
>   Header data split thresh:  256
>   Current hardware settings:
>   ...
>   TCP data split:         on
>   Header data split thresh:  256
>
>The default/min/max values are not defined in the ethtool so the drivers
>should define themself.
>The 0 value means that all TCP/UDP packets' header and payload
>will be split.
>

Users will need default/min/max so they know the capabilities of current
device, otherwise it's a guessing game.. why not add it ? also we need an
indication of when the driver doesn't support changing this config but
still want to report default maybe when (min==max). And what is the default
expected by drivers? 

>In general cases, HDS can increase the overhead of host memory and PCIe
>bus because it copies data twice.

what copy twice ? do you mean copy header into skb->data ? 
this is driver implementation, other dirvers don't copy at all.. 

>So users should consider the overhead of HDS.
>If the HDS threshold is 0 and then the copybreak is 256 and the packet's
>payload is 8 bytes.
>So, two pages are used, one for headers and one for payloads.
>By the copybreak, only the headers page is copied and then it can be
>reused immediately and then a payloads page is still used.
>If the HDS threshold is larger than 8, both headers and payloads are
>copied and then a page can be recycled immediately.
>So, too low HDS threshold has larger disadvantages than advantages
>aspect of performance in general cases.
>Users should consider the overhead of this feature.
>

I really don't understand this example, rx-copybreak and hds shouldn't be
mixed up and the performance analysis you are describing above is driver
specific, some drivers build skbs around the whole frame, and in hds around
the header only, meaning for non hds case rx-copybreak doesn't make lots of
sense and has no advantage, and for hds it's only one copy.. 

Maybe we should define what rx-copybreak should behave like when enabled
with hds.. for many drivers they implement copybreak  by copying the whole
fresh into a fresh skb->data wihtout splitting the header,
which would be wrong in case of hds enabled.

>Tested-by: Stanislav Fomichev <sdf@fomichev.me>
>Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>---
>
>v5:
> - No changes.
>
>v4:
> - Fix 80 charactor wrap.
> - Rename from tcp-data-split-thresh to header-data-split-thresh
> - Add description about overhead of HDS.
> - Add ETHTOOL_RING_USE_HDS_THRS flag.
> - Add dev_xdp_sb_prog_count() helper.
> - Add Test tag from Stanislav.
>
>v3:
> - Fix documentation and ynl
> - Update error messages
> - Validate configuration of tcp-data-split and tcp-data-split-thresh
>
>v2:
> - Patch added.
>
> Documentation/netlink/specs/ethtool.yaml     |  8 ++
> Documentation/networking/ethtool-netlink.rst | 79 ++++++++++++--------
> include/linux/ethtool.h                      |  6 ++
> include/linux/netdevice.h                    |  1 +
> include/uapi/linux/ethtool_netlink.h         |  2 +
> net/core/dev.c                               | 13 ++++
> net/ethtool/netlink.h                        |  2 +-
> net/ethtool/rings.c                          | 37 ++++++++-
> 8 files changed, 115 insertions(+), 33 deletions(-)
>
>diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>index 93369f0eb816..edc07cc290da 100644
>--- a/Documentation/netlink/specs/ethtool.yaml
>+++ b/Documentation/netlink/specs/ethtool.yaml
>@@ -220,6 +220,12 @@ attribute-sets:
>       -
>         name: tx-push-buf-len-max
>         type: u32
>+      -
>+        name: header-data-split-thresh
>+        type: u32
>+      -
>+        name: header-data-split-thresh-max
>+        type: u32
>
>   -
>     name: mm-stat
>@@ -1398,6 +1404,8 @@ operations:
>             - rx-push
>             - tx-push-buf-len
>             - tx-push-buf-len-max
>+            - header-data-split-thresh
>+            - header-data-split-thresh-max
>       dump: *ring-get-op
>     -
>       name: rings-set
>diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
>index b25926071ece..1fdfeca6f38e 100644
>--- a/Documentation/networking/ethtool-netlink.rst
>+++ b/Documentation/networking/ethtool-netlink.rst
>@@ -878,24 +878,35 @@ Request contents:
>
> Kernel response contents:
>
>-  =======================================   ======  ===========================
>-  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
>-  ``ETHTOOL_A_RINGS_RX_MAX``                u32     max size of RX ring
>-  ``ETHTOOL_A_RINGS_RX_MINI_MAX``           u32     max size of RX mini ring
>-  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``          u32     max size of RX jumbo ring
>-  ``ETHTOOL_A_RINGS_TX_MAX``                u32     max size of TX ring
>-  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
>-  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini ring
>-  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
>-  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
>-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
>-  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
>-  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
>-  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
>-  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
>-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buffer
>-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of TX push buffer
>-  =======================================   ======  ===========================
>+  ================================================  ======  ====================
>+  ``ETHTOOL_A_RINGS_HEADER``                        nested  reply header
>+  ``ETHTOOL_A_RINGS_RX_MAX``                        u32     max size of RX ring
>+  ``ETHTOOL_A_RINGS_RX_MINI_MAX``                   u32     max size of RX mini
>+                                                            ring
>+  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``                  u32     max size of RX jumbo
>+                                                            ring
>+  ``ETHTOOL_A_RINGS_TX_MAX``                        u32     max size of TX ring
>+  ``ETHTOOL_A_RINGS_RX``                            u32     size of RX ring
>+  ``ETHTOOL_A_RINGS_RX_MINI``                       u32     size of RX mini ring
>+  ``ETHTOOL_A_RINGS_RX_JUMBO``                      u32     size of RX jumbo
>+                                                            ring
>+  ``ETHTOOL_A_RINGS_TX``                            u32     size of TX ring
>+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                    u32     size of buffers on
>+                                                            the ring
>+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``                u8      TCP header / data
>+                                                            split
>+  ``ETHTOOL_A_RINGS_CQE_SIZE``                      u32     Size of TX/RX CQE
>+  ``ETHTOOL_A_RINGS_TX_PUSH``                       u8      flag of TX Push mode
>+  ``ETHTOOL_A_RINGS_RX_PUSH``                       u8      flag of RX Push mode
>+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``               u32     size of TX push
>+                                                            buffer
>+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``           u32     max size of TX push
>+                                                            buffer
>+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``      u32     threshold of
>+                                                            header / data split
>+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX``  u32     max threshold of
>+                                                            header / data split
>+  ================================================  ======  ====================
>
> ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable with
> page-flipping TCP zero-copy receive (``getsockopt(TCP_ZEROCOPY_RECEIVE)``).
>@@ -930,18 +941,22 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
>
> Request contents:
>
>-  ====================================  ======  ===========================
>-  ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
>-  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
>-  ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
>-  ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
>-  ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
>-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the ring
>-  ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
>-  ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
>-  ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
>-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
>-  ====================================  ======  ===========================
>+  ============================================  ======  =======================
>+  ``ETHTOOL_A_RINGS_HEADER``                    nested  reply header
>+  ``ETHTOOL_A_RINGS_RX``                        u32     size of RX ring
>+  ``ETHTOOL_A_RINGS_RX_MINI``                   u32     size of RX mini ring
>+  ``ETHTOOL_A_RINGS_RX_JUMBO``                  u32     size of RX jumbo ring
>+  ``ETHTOOL_A_RINGS_TX``                        u32     size of TX ring
>+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                u32     size of buffers on the
>+                                                        ring
>+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``            u8      TCP header / data split
>+  ``ETHTOOL_A_RINGS_CQE_SIZE``                  u32     Size of TX/RX CQE
>+  ``ETHTOOL_A_RINGS_TX_PUSH``                   u8      flag of TX Push mode
>+  ``ETHTOOL_A_RINGS_RX_PUSH``                   u8      flag of RX Push mode
>+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``           u32     size of TX push buffer
>+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``  u32     threshold of
>+                                                        header / data split
>+  ============================================  ======  =======================
>
> Kernel checks that requested ring sizes do not exceed limits reported by
> driver. Driver may impose additional constraints and may not support all
>@@ -957,6 +972,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
> transfer a bigger frame from wire. Based on the NIC hardware, the overall
> completion queue size can be adjusted in the driver if CQE size is modified.
>
>+``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH`` specifies the threshold value of
>+header / data split feature. If a received packet size is larger than this
>+threshold value, header and data will be split.
>+
> CHANNELS_GET
> ============
>
>diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>index ecd52b99a63a..b4b6955d7ab9 100644
>--- a/include/linux/ethtool.h
>+++ b/include/linux/ethtool.h
>@@ -79,6 +79,8 @@ enum {
>  * @cqe_size: Size of TX/RX completion queue event
>  * @tx_push_buf_len: Size of TX push buffer
>  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
>+ * @hds_thresh: Threshold value of header-data-split-thresh
>+ * @hds_thresh_max: Maximum allowed threshold of header-data-split-thresh
>  */
> struct kernel_ethtool_ringparam {
> 	u32	rx_buf_len;
>@@ -89,6 +91,8 @@ struct kernel_ethtool_ringparam {
> 	u32	cqe_size;
> 	u32	tx_push_buf_len;
> 	u32	tx_push_buf_max_len;
>+	u32	hds_thresh;
>+	u32	hds_thresh_max;
> };
>
> /**
>@@ -99,6 +103,7 @@ struct kernel_ethtool_ringparam {
>  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
>  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
>  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
>+ * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
>  */
> enum ethtool_supported_ring_param {
> 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
>@@ -107,6 +112,7 @@ enum ethtool_supported_ring_param {
> 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
> 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
> 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
>+	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
> };
>
> #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 0aae346d919e..0c29068577c4 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -4028,6 +4028,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
>
> int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> u8 dev_xdp_prog_count(struct net_device *dev);
>+u8 dev_xdp_sb_prog_count(struct net_device *dev);
> int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
> u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
>
>diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
>index 283305f6b063..7087c5c51017 100644
>--- a/include/uapi/linux/ethtool_netlink.h
>+++ b/include/uapi/linux/ethtool_netlink.h
>@@ -364,6 +364,8 @@ enum {
> 	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
> 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
> 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
>+	ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,	/* u32 */
>+	ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX,	/* u32 */
>
> 	/* add new constants above here */
> 	__ETHTOOL_A_RINGS_CNT,
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 13d00fc10f55..0321d7cbce0f 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9474,6 +9474,19 @@ u8 dev_xdp_prog_count(struct net_device *dev)
> }
> EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
>
>+u8 dev_xdp_sb_prog_count(struct net_device *dev)
>+{
>+	u8 count = 0;
>+	int i;
>+
>+	for (i = 0; i < __MAX_XDP_MODE; i++)
>+		if (dev->xdp_state[i].prog &&
>+		    !dev->xdp_state[i].prog->aux->xdp_has_frags)
>+			count++;
>+	return count;
>+}
>+EXPORT_SYMBOL_GPL(dev_xdp_sb_prog_count);
>+
> int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
> {
> 	if (!dev->netdev_ops->ndo_bpf)
>diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
>index 203b08eb6c6f..9f51a252ebe0 100644
>--- a/net/ethtool/netlink.h
>+++ b/net/ethtool/netlink.h
>@@ -455,7 +455,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
> extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
> extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
> extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
>-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX + 1];
>+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX + 1];
> extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
> extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
> extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
>diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
>index c12ebb61394d..ca836aad3fa9 100644
>--- a/net/ethtool/rings.c
>+++ b/net/ethtool/rings.c
>@@ -61,7 +61,11 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
> 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
> 	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
> 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
>-	       nla_total_size(sizeof(u32));	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
>+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
>+	       nla_total_size(sizeof(u32)) +
>+	       /* _RINGS_HEADER_DATA_SPLIT_THRESH */
>+	       nla_total_size(sizeof(u32));
>+	       /* _RINGS_HEADER_DATA_SPLIT_THRESH_MAX*/
> }
>
> static int rings_fill_reply(struct sk_buff *skb,
>@@ -108,7 +112,12 @@ static int rings_fill_reply(struct sk_buff *skb,
> 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
> 			  kr->tx_push_buf_max_len) ||
> 	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
>-			  kr->tx_push_buf_len))))
>+			  kr->tx_push_buf_len))) ||
>+	    ((supported_ring_params & ETHTOOL_RING_USE_HDS_THRS) &&
>+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,
>+			  kr->hds_thresh) ||
>+	      nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX,
>+			  kr->hds_thresh_max))))
> 		return -EMSGSIZE;
>
> 	return 0;
>@@ -130,6 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
> 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
> 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
> 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
>+	[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH]	= { .type = NLA_U32 },
> };
>
> static int
>@@ -155,6 +165,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
> 		return -EOPNOTSUPP;
> 	}
>
>+	if (tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH] &&
>+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_HDS_THRS)) {
>+		NL_SET_ERR_MSG_ATTR(info->extack,
>+				    tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH],
>+				    "setting header-data-split-thresh is not supported");
>+		return -EOPNOTSUPP;
>+	}
>+
> 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
> 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
> 		NL_SET_ERR_MSG_ATTR(info->extack,
>@@ -222,9 +240,24 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
> 			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
> 	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
> 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
>+	ethnl_update_u32(&kernel_ringparam.hds_thresh,
>+			 tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH], &mod);
> 	if (!mod)
> 		return 0;
>
>+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>+	    dev_xdp_sb_prog_count(dev)) {
>+		NL_SET_ERR_MSG(info->extack,
>+			       "tcp-data-split can not be enabled with single buffer XDP");
>+		return -EINVAL;
>+	}
>+
>+	if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max) {
>+		NL_SET_BAD_ATTR(info->extack,
>+				tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX]);
>+		return -ERANGE;
>+	}
>+
> 	/* ensure new ring parameters are within limits */
> 	if (ringparam.rx_pending > ringparam.rx_max_pending)
> 		err_attr = tb[ETHTOOL_A_RINGS_RX];
>-- 
>2.34.1
>
>

