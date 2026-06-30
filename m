Return-Path: <netdev+bounces-303340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9zk6GiwXRGqEoQoAu9opvQ
	(envelope-from <netdev+bounces-303340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05966E785A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:21:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b="p9Gu/4RZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303340-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303340-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7718931117D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223823955D2;
	Tue, 30 Jun 2026 19:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005b-snip4-3.eps.apple.com [57.103.89.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11025382365
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847083; cv=none; b=SFnvQKD4iUYbgl6mBZfC0edy8UjHvpPGwxl3B1EFweNcNKmBFKj4gYLpaDzTdoZ8wRGPgGgQ6Ok+Uhn8SlTNfTPlRXfoA/B9RxqAIGo7wWH/pE4+KU+m3OkDlkNmFXvcZnhXSVc3SBDE+88wOrt1aLoXTTC6tytXwxNbTvPvQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847083; c=relaxed/simple;
	bh=pf46684xNtbip21wW8cTjgBoM0CKVT0MclUpKHnULS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdCIS4GuUBz1tKmdNxzMQH0yYTugepm9FGugdF7kZ/gtEYZIvETAXQPa5yLLlCRANeJm+95oWv4JImjirZ9xyEd4/1xNn7wmQPiMxG07Gcoqg7sCNUmF9GD88bPHyqZDBW0ohEy5EFc6VR4ITCNM82BmU+M5Mx9IqzcJ4IwrqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=p9Gu/4RZ; arc=none smtp.client-ip=57.103.89.144
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 0B60718015F9;
	Tue, 30 Jun 2026 19:17:56 +0000 (UTC)
X-ICL-RepId: 019f19f7-7a64-74cf-aa61-35f0c0fa452b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNBGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXQFACEECWAZbHEgITANfGlgfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782847079; x=1785439079; bh=QYdekWQA4/y6BZFk6Q5JdM1UqXH8TYidpzZWXu4KVC8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=p9Gu/4RZttR/cyNe1d51IVcweJSe4kV12li/bsABdJpRLqm7z1c9ymd5wwKu+O4FgfG4yzPk90u4MZ2El6xIwxvb/XyKuRdbX3MB219ff0U1q3LOpmLgoKptnQmgGb0MYHhqBkg0XDIcYlvt0fBs2UIxmHeWkQGlIOpnLWZqcVE2De7q749piNr+sISNDqH6t7aChtSg5NKVanOxwMSKwcsilslqWlafdhdy5mbUTUmE6HP5rKubs2ko1DDi0bGw3BvCY/AhOTxMxcb5fUSZCnCSaI8dHf1WNJXbVsrAHRv2WeoPcHUqBIfTGod7HshUr0ZfzJtueQ5qqzOv/cjDUQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 5F9961800375;
	Tue, 30 Jun 2026 19:17:54 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [RFC PATCH bpf-next v1 2/7] selftests/bpf: add test for bpf_xdp_assert_rx_csum over cpumap
Date: Tue, 30 Jun 2026 22:15:05 +0300
Message-ID: <20260630191510.81402-3-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260630191510.81402-1-deliran@verdict.gg>
References: <20260630191510.81402-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sgfVAswNEcooAiSPWOig8TqC2b_rKzgu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX/opp8eC1iOe0
 DmHCrqukEDyn1u5UMyLgK8dlgz5eFddNmy0HmYVoGLbSTfb+aGkk5uEWyvTs4bedlq2CNOKUVwP
 zHibvrRli3NY0CP534yqXhp/iYf7AhoxbyT4oj3+VSPM2cZqZep0rAbV8AsS63MM7du6KYqwFFx
 7HOVZHepXEkLgQm0VAT7l+tSV15KUztoGm6JstJB+hZKLTAclm6Vh+ci/3XlqxZ1zaEn4aSLgs3
 pGGO3BIcX8fnRXwKoQJfwEEbmvCgzs3uJmjlT2doiYLUphRtBixUaGBFcTkKZ96OlXbdvnXWo4d
 M8TOpaP/+FwfLWUxAZG
X-Proofpoint-GUID: sgfVAswNEcooAiSPWOig8TqC2b_rKzgu
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,verdict.gg];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303340-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid,verdict.gg:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D05966E785A

Drive a frame through a native-XDP veth into a cpumap redirect and
observe, via fexit on __xdp_build_skb_from_frame(), that the rebuilt skb
is CHECKSUM_UNNECESSARY when the program called bpf_xdp_assert_rx_csum()
and CHECKSUM_NONE otherwise.  fexit is used because cpumap GRO would
otherwise normalize ip_summed before any later hook can observe it.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 .../bpf/prog_tests/xdp_cpumap_rx_csum.c       | 150 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../bpf/progs/test_xdp_cpumap_rx_csum.c       |  51 ++++++
 3 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
new file mode 100644
index 000000000000..2def92fe1111
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_rx_csum.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <net/if.h>
+#include <linux/if_ether.h>
+#include <linux/if_link.h>
+#include <linux/if_packet.h>
+#include <linux/ipv6.h>
+#include <netinet/in.h>
+#include <netinet/udp.h>
+#include <sys/socket.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include <bpf/bpf_endian.h>
+#include "test_xdp_cpumap_rx_csum.skel.h"
+
+#define TEST_NS		"xdp_cm_csum_ns"
+#define UDP_TEST_PORT	7777
+
+/* Kernel skb->ip_summed values, not exported to userspace headers. */
+#define CHECKSUM_NONE		0
+#define CHECKSUM_UNNECESSARY	1
+
+struct udp_pkt {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct udphdr udp;
+	__u8 payload[16];
+} __packed;
+
+static struct udp_pkt pkt = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.eth.h_dest = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+	.eth.h_source = {0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb},
+	.iph.version = 6,
+	.iph.nexthdr = IPPROTO_UDP,
+	.iph.payload_len = __bpf_constant_htons(sizeof(struct udphdr) + 16),
+	.iph.hop_limit = 64,
+	.udp.source = __bpf_constant_htons(1),
+	.udp.dest = __bpf_constant_htons(UDP_TEST_PORT),
+	.udp.len = __bpf_constant_htons(sizeof(struct udphdr) + 16),
+};
+
+/* Inject one frame on veth0; it is received on veth1 where native XDP
+ * redirects it into the cpumap. Report the ip_summed the rebuilt skb carried.
+ */
+static int inject_and_observe(struct test_xdp_cpumap_rx_csum *skel, int sfd,
+			      int ifindex_src, bool assert_csum, int *ip_summed)
+{
+	struct sockaddr_ll sll = {
+		.sll_family = AF_PACKET,
+		.sll_ifindex = ifindex_src,
+		.sll_halen = 0,
+	};
+	int i, n;
+
+	skel->bss->assert_csum = assert_csum;
+	skel->bss->seen = false;
+	skel->data->observed_ip_summed = -1;
+
+	n = sendto(sfd, &pkt, sizeof(pkt), 0, (void *)&sll, sizeof(sll));
+	if (!ASSERT_EQ(n, sizeof(pkt), "sendto"))
+		return -1;
+
+	/* The skb is built asynchronously by the cpumap kthread. */
+	for (i = 0; i < 20 && !skel->bss->seen; i++)
+		usleep(50000);
+
+	if (!ASSERT_TRUE(skel->bss->seen, "skb built from frame"))
+		return -1;
+
+	*ip_summed = skel->data->observed_ip_summed;
+	return 0;
+}
+
+void test_xdp_cpumap_rx_csum(void)
+{
+	struct test_xdp_cpumap_rx_csum *skel = NULL;
+	struct bpf_cpumap_val val = { .qsize = 192 };
+	struct bpf_link *fexit_link = NULL;
+	struct nstoken *nstoken = NULL;
+	int err, map_fd, ifindex_dst = 0, ifindex_src, sfd = -1, ip_summed;
+	bool xdp_attached = false;
+	__u32 idx = 0;
+
+	SYS(out, "ip netns add %s", TEST_NS);
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out;
+
+	/* veth pair: a frame TX'd on veth0 is RX'd on veth1. */
+	SYS(out, "ip link add veth0 type veth peer name veth1");
+	SYS(out, "ip link set veth0 up");
+	SYS(out, "ip link set veth1 up");
+
+	skel = test_xdp_cpumap_rx_csum__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto out;
+
+	/* cpumap entry without a program: a plain redirect that forces the
+	 * frame->skb conversion in __xdp_build_skb_from_frame().
+	 */
+	map_fd = bpf_map__fd(skel->maps.cpu_map);
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	if (!ASSERT_OK(err, "cpumap update"))
+		goto out;
+
+	ifindex_dst = if_nametoindex("veth1");
+	ifindex_src = if_nametoindex("veth0");
+	if (!ASSERT_GT(ifindex_dst, 0, "veth1 ifindex") ||
+	    !ASSERT_GT(ifindex_src, 0, "veth0 ifindex"))
+		goto out;
+
+	/* Native XDP so the redirect goes through xdp_convert_buff_to_frame(),
+	 * which propagates the rx-csum flag into the frame. Generic mode would
+	 * redirect a ready-made skb and never hit our code path.
+	 */
+	err = bpf_xdp_attach(ifindex_dst, bpf_program__fd(skel->progs.xdp_redir),
+			     XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "attach native xdp"))
+		goto out;
+	xdp_attached = true;
+
+	fexit_link = bpf_program__attach(skel->progs.on_build);
+	if (!ASSERT_OK_PTR(fexit_link, "attach fexit"))
+		goto out;
+
+	sfd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (!ASSERT_GE(sfd, 0, "AF_PACKET socket"))
+		goto out;
+
+	/* Program asserts the checksum -> CHECKSUM_UNNECESSARY. */
+	if (!inject_and_observe(skel, sfd, ifindex_src, true, &ip_summed))
+		ASSERT_EQ(ip_summed, CHECKSUM_UNNECESSARY,
+			  "ip_summed marked unnecessary");
+
+	/* No assertion -> skb is left CHECKSUM_NONE for the stack to validate. */
+	if (!inject_and_observe(skel, sfd, ifindex_src, false, &ip_summed))
+		ASSERT_EQ(ip_summed, CHECKSUM_NONE, "ip_summed left none");
+
+out:
+	if (sfd >= 0)
+		close(sfd);
+	bpf_link__destroy(fexit_link);
+	if (xdp_attached)
+		bpf_xdp_detach(ifindex_dst, XDP_FLAGS_DRV_MODE, NULL);
+	test_xdp_cpumap_rx_csum__destroy(skel);
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..c3a0b2696035 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -87,6 +87,7 @@
 #define TCPOLEN_SACK_PERM	2
 
 #define CHECKSUM_NONE		0
+#define CHECKSUM_UNNECESSARY	1
 #define CHECKSUM_PARTIAL	3
 
 #define IFNAMSIZ		16
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c b/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c
new file mode 100644
index 000000000000..86c691887d25
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_cpumap_rx_csum.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_endian.h>
+
+extern int bpf_xdp_assert_rx_csum(struct xdp_md *ctx) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_cpumap_val));
+	__uint(max_entries, 1);
+} cpu_map SEC(".maps");
+
+/* Set from userspace before injecting each packet. */
+bool assert_csum = false;
+
+/* Filled in by the fexit program when the cpumap skb is built. */
+bool seen = false;
+int observed_ip_summed = -1;
+
+SEC("xdp")
+int xdp_redir(struct xdp_md *ctx)
+{
+	/* Assert the L4 checksum so the skb built on the cpumap redirect
+	 * path is marked CHECKSUM_UNNECESSARY instead of validated in software.
+	 */
+	if (assert_csum)
+		bpf_xdp_assert_rx_csum(ctx);
+
+	return bpf_redirect_map(&cpu_map, 0, 0);
+}
+
+/* Observe ip_summed exactly as __xdp_build_skb_from_frame() leaves it, before
+ * GRO in the cpumap kthread can normalize it. tc-ingress would be too late:
+ * GRO software-validates a CHECKSUM_NONE skb and marks it UNNECESSARY anyway.
+ */
+SEC("fexit/__xdp_build_skb_from_frame")
+int BPF_PROG(on_build, struct xdp_frame *xdpf, struct sk_buff *skb,
+	     struct net_device *dev, struct sk_buff *ret)
+{
+	if (ret && ret->protocol == bpf_htons(ETH_P_IPV6)) {
+		observed_ip_summed = ret->ip_summed;
+		seen = true;
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.0


