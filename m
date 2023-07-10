Return-Path: <netdev+bounces-16367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C236174CEAC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2588280F8B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454ABE61;
	Mon, 10 Jul 2023 07:39:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A30C8CC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:39:11 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6554E6F;
	Mon, 10 Jul 2023 00:38:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1116517b3a.0;
        Mon, 10 Jul 2023 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974735; x=1691566735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0cvgCuH/2UE9JLFG5tGldADsplPGRbN7ePmEMFuXak=;
        b=UutFIxk+Hmq9V098LLNWlzZ1Z1dRbmxcMS0MT50WAJxzW9GNNNWBTt3kg+vABHp0KP
         lhcg5xpzImGLBdr2+N48AbZD2KHJAqEE2N+XL4ZfMmmPaHNjj4whJbyBZPRrkCFdQ8cV
         +u9+QFp/c+Qw9CFKs/wJ8FXLC1VDrCa8/5MTN5+abLSyKSEnC9BbtsWwezLYaHuB0Kqh
         VQdvitvu8X/mD7IiLwIs6plMX7zNjitOjA5O6wgugjnLOAStRlTMvxMa3xDCNC+xPEb+
         K0Jxn4FyBHOrCqItFsYHPmYxdpVPb3sjhDmhCXq7A+ZTXFkXVZ23ocv8EMnKWfHAQ5mJ
         1OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974735; x=1691566735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0cvgCuH/2UE9JLFG5tGldADsplPGRbN7ePmEMFuXak=;
        b=KV0nQpClJDFYO8dOLSwLx2zZrRXM39aYGPXuIQFF6LzucwWvleeeIDkGGpi90sEioW
         1iJshw/O402DeTa7l3QdjTDt1oRTUTg7NaqdDPFr6FwVLS04Y24Umxe1LGgOZsWKkTdH
         3OJc4H5yPFMqMrWwRHh3LxndBLTnshmPtwhGmRmkOCQbRgfHMcU1AjoytzaMSXC5XJMo
         uk4DqMLrv0GvC2R+Vmf8VEKrk5mOTi+ilPlLaBqn8591roqYtfwp0sIzQqYtvdkbi2V6
         YkRCruuvmIVSUiEH/DTOwcOXPlo+jjGOdv7pya1zmf/O6ndPaEH3iRqfAX7zizfRd/Y2
         cpxQ==
X-Gm-Message-State: ABy/qLYYyTKYgxN1zLmyrbNnTn412f9o4my9xqQKMBLShn44j0KenSV8
	e6gnNr+9jJuKEUyBq1yXrxop00i7aQYU6CwN
X-Google-Smtp-Source: APBJJlFnjmb5qzv534zFkRQuJwhanRa+Q0xoodeeohGNpnu8ZOuowvWqjOKOi5RRWpjIiSEil5LYWA==
X-Received: by 2002:a05:6a00:14c9:b0:682:59aa:178d with SMTP id w9-20020a056a0014c900b0068259aa178dmr12718760pfu.1.1688974734733;
        Mon, 10 Jul 2023 00:38:54 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r20-20020a62e414000000b0063f2a5a59d1sm6514483pfh.190.2023.07.10.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:38:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew@lunn.ch,
	aliceryhl@google.com,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH v2 3/5] rust: add methods for configure net_device
Date: Mon, 10 Jul 2023 16:37:01 +0900
Message-Id: <20230710073703.147351-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710073703.147351-1-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

adds methods to net::Device for the basic configurations of
net_device.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers.c         |   7 ++
 rust/kernel/net/dev.rs | 185 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70d50767ff4e..6c51deb18dc1 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/etherdevice.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
@@ -31,6 +32,12 @@
 #include <linux/wait.h>
 
 #ifdef CONFIG_NET
+void rust_helper_eth_hw_addr_random(struct net_device *dev)
+{
+	eth_hw_addr_random(dev);
+}
+EXPORT_SYMBOL_GPL(rust_helper_eth_hw_addr_random);
+
 void *rust_helper_netdev_priv(const struct net_device *dev)
 {
 	return netdev_priv(dev);
diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
index ff00616e4fef..e4d8d8260c10 100644
--- a/rust/kernel/net/dev.rs
+++ b/rust/kernel/net/dev.rs
@@ -8,9 +8,116 @@
 //! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
 //! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_link.h).
 
-use crate::{bindings, build_error, error::*, prelude::vtable, types::ForeignOwnable};
+use crate::{bindings, build_error, error::*, prelude::vtable, str::CStr, types::ForeignOwnable};
 use {core::ffi::c_void, core::marker::PhantomData};
 
+/// Flags associated with a [`Device`].
+pub mod flags {
+    /// Interface is up.
+    pub const IFF_UP: u32 = bindings::net_device_flags_IFF_UP;
+    /// Broadcast address valid.
+    pub const IFF_BROADCAST: u32 = bindings::net_device_flags_IFF_BROADCAST;
+    /// Device on debugging.
+    pub const IFF_DEBUG: u32 = bindings::net_device_flags_IFF_DEBUG;
+    /// Loopback device.
+    pub const IFF_LOOPBACK: u32 = bindings::net_device_flags_IFF_LOOPBACK;
+    /// Has p-p link.
+    pub const IFF_POINTOPOINT: u32 = bindings::net_device_flags_IFF_POINTOPOINT;
+    /// Avoids use of trailers.
+    pub const IFF_NOTRAILERS: u32 = bindings::net_device_flags_IFF_NOTRAILERS;
+    /// Interface RFC2863 OPER_UP.
+    pub const IFF_RUNNING: u32 = bindings::net_device_flags_IFF_RUNNING;
+    /// No ARP protocol.
+    pub const IFF_NOARP: u32 = bindings::net_device_flags_IFF_NOARP;
+    /// Receives all packets.
+    pub const IFF_PROMISC: u32 = bindings::net_device_flags_IFF_PROMISC;
+    /// Receive all multicast packets.
+    pub const IFF_ALLMULTI: u32 = bindings::net_device_flags_IFF_ALLMULTI;
+    /// Master of a load balancer.
+    pub const IFF_MASTER: u32 = bindings::net_device_flags_IFF_MASTER;
+    /// Slave of a load balancer.
+    pub const IFF_SLAVE: u32 = bindings::net_device_flags_IFF_SLAVE;
+    /// Supports multicast.
+    pub const IFF_MULTICAST: u32 = bindings::net_device_flags_IFF_MULTICAST;
+    /// Capable of setting media type.
+    pub const IFF_PORTSEL: u32 = bindings::net_device_flags_IFF_PORTSEL;
+    /// Auto media select active.
+    pub const IFF_AUTOMEDIA: u32 = bindings::net_device_flags_IFF_AUTOMEDIA;
+    /// Dialup device with changing addresses.
+    pub const IFF_DYNAMIC: u32 = bindings::net_device_flags_IFF_DYNAMIC;
+}
+
+/// Private flags associated with a [`Device`].
+pub mod priv_flags {
+    /// 802.1Q VLAN device.
+    pub const IFF_802_1Q_VLAN: u64 = bindings::netdev_priv_flags_IFF_802_1Q_VLAN;
+    /// Ethernet bridging device.
+    pub const IFF_EBRIDGE: u64 = bindings::netdev_priv_flags_IFF_EBRIDGE;
+    /// Bonding master or slave device.
+    pub const IFF_BONDING: u64 = bindings::netdev_priv_flags_IFF_BONDING;
+    /// ISATAP interface (RFC4214).
+    pub const IFF_ISATAP: u64 = bindings::netdev_priv_flags_IFF_ISATAP;
+    /// WAN HDLC device.
+    pub const IFF_WAN_HDLC: u64 = bindings::netdev_priv_flags_IFF_WAN_HDLC;
+    /// dev_hard_start_xmit() is allowed to release skb->dst.
+    pub const IFF_XMIT_DST_RELEASE: u64 = bindings::netdev_priv_flags_IFF_XMIT_DST_RELEASE;
+    /// Disallows bridging this ether device.
+    pub const IFF_DONT_BRIDGE: u64 = bindings::netdev_priv_flags_IFF_DONT_BRIDGE;
+    /// Disables netpoll at run-time.
+    pub const IFF_DISABLE_NETPOLL: u64 = bindings::netdev_priv_flags_IFF_DISABLE_NETPOLL;
+    /// Device used as macvlan port.
+    pub const IFF_MACVLAN_PORT: u64 = bindings::netdev_priv_flags_IFF_MACVLAN_PORT;
+    /// Device used as bridge port.
+    pub const IFF_BRIDGE_PORT: u64 = bindings::netdev_priv_flags_IFF_BRIDGE_PORT;
+    /// Device used as Open vSwitch datapath port.
+    pub const IFF_OVS_DATAPATH: u64 = bindings::netdev_priv_flags_IFF_OVS_DATAPATH;
+    /// The interface supports sharing skbs on transmit.
+    pub const IFF_TX_SKB_SHARING: u64 = bindings::netdev_priv_flags_IFF_TX_SKB_SHARING;
+    /// Supports unicast filtering.
+    pub const IFF_UNICAST_FLT: u64 = bindings::netdev_priv_flags_IFF_UNICAST_FLT;
+    /// Device used as team port.
+    pub const IFF_TEAM_PORT: u64 = bindings::netdev_priv_flags_IFF_TEAM_PORT;
+    /// Device supports sending custom FCS.
+    pub const IFF_SUPP_NOFCS: u64 = bindings::netdev_priv_flags_IFF_SUPP_NOFCS;
+    /// Device supports hardware address change when it's running.
+    pub const IFF_LIVE_ADDR_CHANGE: u64 = bindings::netdev_priv_flags_IFF_LIVE_ADDR_CHANGE;
+    /// Macvlan device.
+    pub const IFF_MACVLAN: u64 = bindings::netdev_priv_flags_IFF_MACVLAN;
+    /// IFF_XMIT_DST_RELEASE not taking into account underlying stacked devices.
+    pub const IFF_XMIT_DST_RELEASE_PERM: u64 =
+        bindings::netdev_priv_flags_IFF_XMIT_DST_RELEASE_PERM;
+    /// L3 master device.
+    pub const IFF_L3MDEV_MASTER: u64 = bindings::netdev_priv_flags_IFF_L3MDEV_MASTER;
+    /// Device can run without qdisc attached.
+    pub const IFF_NO_QUEUE: u64 = bindings::netdev_priv_flags_IFF_NO_QUEUE;
+    /// Device is a Open vSwitch master.
+    pub const IFF_OPENVSWITCH: u64 = bindings::netdev_priv_flags_IFF_OPENVSWITCH;
+    /// Device is enslaved to an L3 master.
+    pub const IFF_L3MDEV_SLAVE: u64 = bindings::netdev_priv_flags_IFF_L3MDEV_SLAVE;
+    /// Team device.
+    pub const IFF_TEAM: u64 = bindings::netdev_priv_flags_IFF_TEAM;
+    /// Device has had Rx Flow indirection table configured.
+    pub const IFF_RXFH_CONFIGURED: u64 = bindings::netdev_priv_flags_IFF_RXFH_CONFIGURED;
+    /// The headroom value is controlled by an external entity.
+    pub const IFF_PHONY_HEADROOM: u64 = bindings::netdev_priv_flags_IFF_PHONY_HEADROOM;
+    /// MACsec device.
+    pub const IFF_MACSEC: u64 = bindings::netdev_priv_flags_IFF_MACSEC;
+    /// Device doesn't support the rx_handler hook.
+    pub const IFF_NO_RX_HANDLER: u64 = bindings::netdev_priv_flags_IFF_NO_RX_HANDLER;
+    /// Failover master device.
+    pub const IFF_FAILOVER: u64 = bindings::netdev_priv_flags_IFF_FAILOVER;
+    /// Lower device of a failover master device.
+    pub const IFF_FAILOVER_SLAVE: u64 = bindings::netdev_priv_flags_IFF_FAILOVER_SLAVE;
+    /// Only invokes the rx handler of L3 master device.
+    pub const IFF_L3MDEV_RX_HANDLER: u64 = bindings::netdev_priv_flags_IFF_L3MDEV_RX_HANDLER;
+    /// Prevents ipv6 addrconf.
+    pub const IFF_NO_ADDRCONF: u64 = bindings::netdev_priv_flags_IFF_NO_ADDRCONF;
+    /// Capable of xmitting frames with skb_headlen(skb) == 0.
+    pub const IFF_TX_SKB_NO_LINEAR: u64 = bindings::netdev_priv_flags_IFF_TX_SKB_NO_LINEAR;
+    /// Supports setting carrier via IFLA_PROTO_DOWN.
+    pub const IFF_CHANGE_PROTO_DOWN: u64 = bindings::netdev_priv_flags_IFF_CHANGE_PROTO_DOWN;
+}
+
 /// Corresponds to the kernel's `struct net_device`.
 ///
 /// # Invariants
@@ -49,6 +156,82 @@ pub fn drv_priv_data(&self) -> D::Borrowed<'_> {
             ))
         }
     }
+
+    /// Sets the name of a device.
+    pub fn set_name(&mut self, name: &CStr) -> Result {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe {
+            if name.len() > (*self.ptr).name.len() {
+                return Err(code::EINVAL);
+            }
+            (*self.ptr)
+                .name
+                .as_mut_ptr()
+                .copy_from_nonoverlapping(name.as_char_ptr(), name.len());
+        }
+        Ok(())
+    }
+
+    /// Sets carrier.
+    pub fn netif_carrier_on(&mut self) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { bindings::netif_carrier_on(self.ptr) }
+    }
+
+    /// Clears carrier.
+    pub fn netif_carrier_off(&mut self) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { bindings::netif_carrier_off(self.ptr) }
+    }
+
+    /// Sets the max mtu of the device.
+    pub fn set_max_mtu(&mut self, max_mtu: u32) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe {
+            (*self.ptr).max_mtu = max_mtu;
+        }
+    }
+
+    /// Sets the minimum mtu of the device.
+    pub fn set_min_mtu(&mut self, min_mtu: u32) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe {
+            (*self.ptr).min_mtu = min_mtu;
+        }
+    }
+
+    /// Returns the flags of the device.
+    pub fn get_flags(&self) -> u32 {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { (*self.ptr).flags }
+    }
+
+    /// Sets the flags of the device.
+    pub fn set_flags(&mut self, flags: u32) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe {
+            (*self.ptr).flags = flags;
+        }
+    }
+
+    /// Returns the priv_flags of the device.
+    pub fn get_priv_flags(&self) -> u64 {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { (*self.ptr).priv_flags }
+    }
+
+    /// Sets the priv_flags of the device.
+    pub fn set_priv_flags(&mut self, flags: u64) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { (*self.ptr).priv_flags = flags }
+    }
+
+    /// Generate a random Ethernet address (MAC) to be used by a net device
+    /// and set addr_assign_type.
+    pub fn set_random_eth_hw_addr(&mut self) {
+        // SAFETY: The type invariants guarantee that `self.ptr` is valid.
+        unsafe { bindings::eth_hw_addr_random(self.ptr) }
+    }
 }
 
 // SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
-- 
2.34.1


