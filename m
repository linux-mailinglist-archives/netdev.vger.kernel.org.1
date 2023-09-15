Return-Path: <netdev+bounces-34146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AB27A2565
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A921C20A87
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4818E1F;
	Fri, 15 Sep 2023 18:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04E168C9
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:51 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090A1FF5
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:49 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Od79BSswqNzk+U4rDbhSnuAMYBJrIm76U7pWJfM4uZ0=;
	b=cme3WUyzSSYqj5v3hKvqYhPRs4sJuLfMYnatrqQrW9xSumAi9IroGA3THbIlY+t1vyH9fl
	S8gFcim4jwWisAgyfRU5ifsZB+nX2nYVPnMiwCRmcgiVoTWxs9qvzBnyag8Wtc62WLZtX5
	gYg48rjBFPfqO5XJ+zfQoRMXeVnmvqRv3Um/FhdYIgVyhdo2jRvc6ozyZh0zmVrtXmFzxp
	NwyVWU3A3sN8Lp+3uTvDys/hryK0pxNVNWZ2xfRbSU17MenXgh1gzkctdAgJYeMA9e+oNo
	9BddayH+2A+zEF2JzqkICKjRRtRd+ww3EEg/GAKhov6wPTv0yg2RwXeaHIECpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Od79BSswqNzk+U4rDbhSnuAMYBJrIm76U7pWJfM4uZ0=;
	b=jtmNRh8v4RzaUYELEPJ6bMpQWpECSPxRtVXBKMR9WtZW7C6A5RGCR3tiDaDmM/2RhMp5mL
	9AbL2jbx7zeAlnDg==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Oetken <ennoerlangen@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 4/5] selftests: hsr: Reorder the testsuite.
Date: Fri, 15 Sep 2023 20:10:05 +0200
Message-Id: <20230915181006.2086061-5-bigeasy@linutronix.de>
In-Reply-To: <20230915181006.2086061-1-bigeasy@linutronix.de>
References: <20230915181006.2086061-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the code and group into functions so it will be easier to extend
the test to HSRv1 so that both versions are covered.

Move the ping/test part into do_complete_ping_test() and the interface
setup into setup_hsr_interfaces().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 249 ++++++++++----------
 1 file changed, 129 insertions(+), 120 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/se=
lftests/net/hsr/hsr_ping.sh
index 183f4a0f19dd9..d4613b7b71883 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -41,61 +41,6 @@ cleanup()
 	done
 }
=20
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-trap cleanup EXIT
-
-for i in "$ns1" "$ns2" "$ns3" ;do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
-
-echo "INFO: preparing interfaces."
-# Three HSR nodes. Each node has one link to each of its neighbour, two li=
nks in total.
-#
-#    ns1eth1 ----- ns2eth1
-#      hsr1         hsr2
-#    ns1eth2       ns2eth2
-#       |            |
-#    ns3eth1      ns3eth2
-#           \    /
-#            hsr3
-#
-# Interfaces
-ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
-ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
-ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
-
-# HSRv0.
-ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 s=
upervision 45 version 0 proto 0
-ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 s=
upervision 45 version 0 proto 0
-ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 slave2 ns3eth2 s=
upervision 45 version 0 proto 0
-
-# IP for HSR
-ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
-ip -net "$ns1" addr add dead:beef:1::1/64 dev hsr1 nodad
-ip -net "$ns2" addr add 100.64.0.2/24 dev hsr2
-ip -net "$ns2" addr add dead:beef:1::2/64 dev hsr2 nodad
-ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
-ip -net "$ns3" addr add dead:beef:1::3/64 dev hsr3 nodad
-
-# All Links up
-ip -net "$ns1" link set ns1eth1 up
-ip -net "$ns1" link set ns1eth2 up
-ip -net "$ns1" link set hsr1 up
-
-ip -net "$ns2" link set ns2eth1 up
-ip -net "$ns2" link set ns2eth2 up
-ip -net "$ns2" link set hsr2 up
-
-ip -net "$ns3" link set ns3eth1 up
-ip -net "$ns3" link set ns3eth2 up
-ip -net "$ns3" link set hsr3 up
-
 # $1: IP address
 is_v6()
 {
@@ -164,93 +109,157 @@ stop_if_error()
 	fi
 }
=20
+do_complete_ping_test()
+{
+	echo "INFO: Initial validation ping."
+	# Each node has to be able each one.
+	do_ping "$ns1" 100.64.0.2
+	do_ping "$ns2" 100.64.0.1
+	do_ping "$ns3" 100.64.0.1
+	stop_if_error "Initial validation failed."
=20
-echo "INFO: Initial validation ping."
-# Each node has to be able each one.
-do_ping "$ns1" 100.64.0.2
-do_ping "$ns2" 100.64.0.1
-do_ping "$ns3" 100.64.0.1
-stop_if_error "Initial validation failed."
+	do_ping "$ns1" 100.64.0.3
+	do_ping "$ns2" 100.64.0.3
+	do_ping "$ns3" 100.64.0.2
=20
-do_ping "$ns1" 100.64.0.3
-do_ping "$ns2" 100.64.0.3
-do_ping "$ns3" 100.64.0.2
+	do_ping "$ns1" dead:beef:1::2
+	do_ping "$ns1" dead:beef:1::3
+	do_ping "$ns2" dead:beef:1::1
+	do_ping "$ns2" dead:beef:1::2
+	do_ping "$ns3" dead:beef:1::1
+	do_ping "$ns3" dead:beef:1::2
=20
-do_ping "$ns1" dead:beef:1::2
-do_ping "$ns1" dead:beef:1::3
-do_ping "$ns2" dead:beef:1::1
-do_ping "$ns2" dead:beef:1::2
-do_ping "$ns3" dead:beef:1::1
-do_ping "$ns3" dead:beef:1::2
-
-stop_if_error "Initial validation failed."
+	stop_if_error "Initial validation failed."
=20
 # Wait until supervisor all supervision frames have been processed and the=
 node
 # entries have been merged. Otherwise duplicate frames will be observed wh=
ich is
 # valid at this stage.
-WAIT=3D5
-while [ ${WAIT} -gt 0 ]
-do
-	grep 00:00:00:00:00:00 /sys/kernel/debug/hsr/hsr*/node_table
-	if [ $? -ne 0 ]
-	then
-		break
-	fi
-	sleep 1
-	let "WAIT =3D WAIT - 1"
-done
+	WAIT=3D5
+	while [ ${WAIT} -gt 0 ]
+	do
+		grep 00:00:00:00:00:00 /sys/kernel/debug/hsr/hsr*/node_table
+		if [ $? -ne 0 ]
+		then
+			break
+		fi
+		sleep 1
+		let "WAIT =3D WAIT - 1"
+	done
=20
 # Just a safety delay in case the above check didn't handle it.
-sleep 1
+	sleep 1
=20
-echo "INFO: Longer ping test."
-do_ping_long "$ns1" 100.64.0.2
-do_ping_long "$ns1" dead:beef:1::2
-do_ping_long "$ns1" 100.64.0.3
-do_ping_long "$ns1" dead:beef:1::3
+	echo "INFO: Longer ping test."
+	do_ping_long "$ns1" 100.64.0.2
+	do_ping_long "$ns1" dead:beef:1::2
+	do_ping_long "$ns1" 100.64.0.3
+	do_ping_long "$ns1" dead:beef:1::3
=20
-stop_if_error "Longer ping test failed."
+	stop_if_error "Longer ping test failed."
=20
-do_ping_long "$ns2" 100.64.0.1
-do_ping_long "$ns2" dead:beef:1::1
-do_ping_long "$ns2" 100.64.0.3
-do_ping_long "$ns2" dead:beef:1::2
-stop_if_error "Longer ping test failed."
+	do_ping_long "$ns2" 100.64.0.1
+	do_ping_long "$ns2" dead:beef:1::1
+	do_ping_long "$ns2" 100.64.0.3
+	do_ping_long "$ns2" dead:beef:1::2
+	stop_if_error "Longer ping test failed."
=20
-do_ping_long "$ns3" 100.64.0.1
-do_ping_long "$ns3" dead:beef:1::1
-do_ping_long "$ns3" 100.64.0.2
-do_ping_long "$ns3" dead:beef:1::2
-stop_if_error "Longer ping test failed."
+	do_ping_long "$ns3" 100.64.0.1
+	do_ping_long "$ns3" dead:beef:1::1
+	do_ping_long "$ns3" 100.64.0.2
+	do_ping_long "$ns3" dead:beef:1::2
+	stop_if_error "Longer ping test failed."
=20
-echo "INFO: Cutting one link."
-do_ping_long "$ns1" 100.64.0.3 &
+	echo "INFO: Cutting one link."
+	do_ping_long "$ns1" 100.64.0.3 &
=20
-sleep 3
-ip -net "$ns3" link set ns3eth1 down
-wait
+	sleep 3
+	ip -net "$ns3" link set ns3eth1 down
+	wait
=20
-ip -net "$ns3" link set ns3eth1 up
+	ip -net "$ns3" link set ns3eth1 up
=20
-stop_if_error "Failed with one link down."
+	stop_if_error "Failed with one link down."
=20
-echo "INFO: Delay the link and drop a few packages."
-tc -net "$ns3" qdisc add dev ns3eth1 root netem delay 50ms
-tc -net "$ns2" qdisc add dev ns2eth1 root netem delay 5ms loss 25%
+	echo "INFO: Delay the link and drop a few packages."
+	tc -net "$ns3" qdisc add dev ns3eth1 root netem delay 50ms
+	tc -net "$ns2" qdisc add dev ns2eth1 root netem delay 5ms loss 25%
=20
-do_ping_long "$ns1" 100.64.0.2
-do_ping_long "$ns1" 100.64.0.3
+	do_ping_long "$ns1" 100.64.0.2
+	do_ping_long "$ns1" 100.64.0.3
=20
-stop_if_error "Failed with delay and packetloss."
+	stop_if_error "Failed with delay and packetloss."
=20
-do_ping_long "$ns2" 100.64.0.1
-do_ping_long "$ns2" 100.64.0.3
+	do_ping_long "$ns2" 100.64.0.1
+	do_ping_long "$ns2" 100.64.0.3
=20
-stop_if_error "Failed with delay and packetloss."
+	stop_if_error "Failed with delay and packetloss."
=20
-do_ping_long "$ns3" 100.64.0.1
-do_ping_long "$ns3" 100.64.0.2
-stop_if_error "Failed with delay and packetloss."
+	do_ping_long "$ns3" 100.64.0.1
+	do_ping_long "$ns3" 100.64.0.2
+	stop_if_error "Failed with delay and packetloss."
+
+	echo "INFO: All good."
+}
+
+setup_hsr_interfaces()
+{
+	echo "INFO: preparing interfaces."
+# Three HSR nodes. Each node has one link to each of its neighbour, two li=
nks in total.
+#
+#    ns1eth1 ----- ns2eth1
+#      hsr1         hsr2
+#    ns1eth2       ns2eth2
+#       |            |
+#    ns3eth1      ns3eth2
+#           \    /
+#            hsr3
+#
+	# Interfaces
+	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
+	ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
+	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
+
+	# HSRv0.
+	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 =
supervision 45 version 0 proto 0
+	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 =
supervision 45 version 0 proto 0
+	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 slave2 ns3eth2 =
supervision 45 version 0 proto 0
+
+	# IP for HSR
+	ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
+	ip -net "$ns1" addr add dead:beef:1::1/64 dev hsr1 nodad
+	ip -net "$ns2" addr add 100.64.0.2/24 dev hsr2
+	ip -net "$ns2" addr add dead:beef:1::2/64 dev hsr2 nodad
+	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
+	ip -net "$ns3" addr add dead:beef:1::3/64 dev hsr3 nodad
+
+	# All Links up
+	ip -net "$ns1" link set ns1eth1 up
+	ip -net "$ns1" link set ns1eth2 up
+	ip -net "$ns1" link set hsr1 up
+
+	ip -net "$ns2" link set ns2eth1 up
+	ip -net "$ns2" link set ns2eth2 up
+	ip -net "$ns2" link set hsr2 up
+
+	ip -net "$ns3" link set ns3eth1 up
+	ip -net "$ns3" link set ns3eth2 up
+	ip -net "$ns3" link set hsr3 up
+}
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+trap cleanup EXIT
+
+for i in "$ns1" "$ns2" "$ns3" ;do
+	ip netns add $i || exit $ksft_skip
+	ip -net $i link set lo up
+done
+
+setup_hsr_interfaces
+do_complete_ping_test
=20
-echo "INFO: All good."
 exit $ret
--=20
2.40.1


