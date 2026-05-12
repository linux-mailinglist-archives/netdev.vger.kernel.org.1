Return-Path: <netdev+bounces-287106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GtkMkAMA2pK0AEAu9opvQ
	(envelope-from <netdev+bounces-287106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:17:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE151F34D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 291B9301982B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEEE46AF1E;
	Tue, 12 May 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="oR3rKi3l"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E817395AF5;
	Tue, 12 May 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584636; cv=none; b=PmcUHJRh6eElHF6mwTajAB7lutTXKfbWeLO+zmeQf+a8rLvPdnxT2nCqVYwMr/IFKm1b++lEkTq9V+IngAGc0UamX70aWBL/U9VuVej6N9rwLePI+F6u6cRAQmmHMRHn9gCz9J13AaMz1Q6jFPejWTwp8iBcFWqV2N78aft7L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584636; c=relaxed/simple;
	bh=tRUEOvaUYkb6QcN5lqNKvdx8TtJl84KKPldZVe3x/5A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iUZGhRjlzjlYB6+kv0vXpVUkYF2cu+QCG6KmXkY3G/3Kr7XEcxBcpGAX70tTUpc1adX6h+1b6POJJwkvlj9oCXT5ubirPl3CWbWBpn2ypI1xN+pg29rFATD2u+eFX0EuD+VYEGUtmsu9viagh1lEDpUHr0l09+ild5BO8kZTulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=oR3rKi3l; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778584628; x=1779189428; i=t.fuechsel@gmx.de;
	bh=3OHWWouPDC8Gm5ihOppF/I3dBoE5OBPdx/S1ZFj+U1A=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oR3rKi3lzCL4ynCyeuuI8NF9ty0KORMRhZrtr9AWTilcSjpxHtuYAwY6QE935/jJ
	 2iEUqkkvApTfqd8bXRaOJWwKbNjsEw9I6lCZ0N4jknPmqJpSyH3bFGRGF1AXikWxm
	 aOUflWtQpLTVRTE6Or+Gi8nCSFZBKgroWxHFQ04pm/F+0tTD1f3dsDaLuKzHfcNBf
	 wkvM040aC/luPs/17lzVVGzEMWlZFgSSzKN9We8nFPI6LEXc52pOjdAoBAX8b/kqp
	 CoL4WrUHpvcsd1ae0+Uov8EYakNnLoqczL6m4lHMwPg4btwTFTyeTVW5id1eOSAlZ
	 o9B6aOcElYXnx/yKDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1xE2Jn1GZL-00zmNF; Tue, 12
 May 2026 13:17:08 +0200
Date: Tue, 12 May 2026 13:17:05 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv2 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <agMMMUotXaG_Ypqz@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jEPP9BKA7MbAfnb1t8wSXwILcx5H9yNH7mDaA2kUSV8+dc/ORos
 /yBr+trXL+lX/XT3K+7G30IpcOnPvJb0z8G9soxBCNm/OMV85+9AWxDbOMr39ZjMdHDPYi6
 lZV1fM51ZpexD7lH6cWEdNwXj+696bjIj3aaoc7A9YjTDQFeGabvF5iXG4wiRt2gIo3Il4x
 QxVHwGBbLZB3ZRewujgDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YN1CZf2U9qo=;Z6ywz/TuAXUtiBUOW3J+CeyYFFz
 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
X-Rspamd-Queue-Id: 38BE151F34D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[swin.edu.au:url];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287106-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmx.de:s=s31663417];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,ikt.uni-hannover.de,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmx.de,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.650];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.fuechsel@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,doi.org:url,gmx.de:email,gmx.de:dkim,ncsu.edu:url,swin.edu.au:url]
X-Rspamd-Action: no action

TCP ROCCET is an extension of TCP CUBIC that improves its overall
performance in cellular networks. By its mode of function, CUBIC
causes bufferbloat while it tries to detect the available throughput
of a network path. This is particularly a problem with large buffers
in mobile networks. A more detailed description and analysis of this
problem caused by TCP CUBIC can be found in [1]. TCP ROCCET addresses
the bufferbloat problem by adding two additional metrics to detect
bufferbloat. The first metric is the relative increase in RTT from
its minimum, the srRTT. Here, bufferbloat can be detected when RTTs
increase due to buffer filling. The second metric is the acknowledgment
arrival rate sampled over 5 RTT intervals. If CUBIC increases the send
rate or congestion window, and the acknowledgment arrival rate stays on
the same level, the connection is limited by the bottleneck link's
capacity. In such cases, ROCCET reduces the send rate to prevent
bufferbloat. ROCCET uses a modified version of slow start rather than
HyStart because HyStart is known to enter the congestion avoidance phase
too early when used in cellular networks [2]. Therefore, ROCCET uses a
combination of srRTT and the acknowledgment arrival rate to determine
when to exit slow start. For the congestion avoidance phase, ROCCET
relies only on the srRTT.

In real-world mobile 5G NR measurements, TCP ROCCET achieves better
performance than CUBIC and BBRv3, by maintaining similar throughput
while reducing the latency. In stationary 5G NR scenarios, the performance
is similar to that of BBRv3. More information about TCP ROCCET and
measurement evaluations can be found here [3].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://doi.org/10.1109/WMNC.2016.7543932
[3] https://doi.org/10.23919/WONS68803.2026.11501781

Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

=2D--

Changes since v1:
	* Adjust some comments & Rework commit message
	* Fix Kconfig format
	* Add div-by-0 check variables
	* Fix ack summation from +=3D1 to +=3Dacked (counting now ACKs instead of=
 ACK events)
	* Fix wrapping in time comparisons
	* Remove most module_params, including 'ignore_loss'
	* Remove check that always evaluated to 'true' regarding 'bw_limit_detect=
'
=2D--
 net/ipv4/Kconfig      |  12 +
 net/ipv4/Makefile     |   1 +
 net/ipv4/tcp_roccet.c | 639 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_roccet.h |  46 +++
 4 files changed, 698 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c
 create mode 100644 net/ipv4/tcp_roccet.h

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 301b47660305..23197958324b 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,18 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+	  TCP ROCCET is a sender-side only modification of the TCP CUBIC
+	  protocol stack/TCP CUBIC congestion control algorithm that
+	  optimizes the performance of TCP congestion control. Especially
+	  for networks with large buffers (wireless, cellular networks),
+	  TCP ROCCET has improved performance by maintaining similar
+	  throughput as CUBIC while reducing the latency.
+	  For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 7964234f0d08..60bf2d2e4ce5 100644
=2D-- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INET_TCP_DIAG) +=3D tcp_diag.o
 obj-$(CONFIG_INET_UDP_DIAG) +=3D udp_diag.o
 obj-$(CONFIG_INET_RAW_DIAG) +=3D raw_diag.o
 obj-$(CONFIG_TCP_CONG_BBR) +=3D tcp_bbr.o
+obj-$(CONFIG_TCP_CONG_ROCCET) +=3D tcp_roccet.o
 obj-$(CONFIG_TCP_CONG_BIC) +=3D tcp_bic.o
 obj-$(CONFIG_TCP_CONG_CDG) +=3D tcp_cdg.o
 obj-$(CONFIG_TCP_CONG_CUBIC) +=3D tcp_cubic.o
diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
new file mode 100644
index 000000000000..e26d445bec9c
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TCP ROCCET: An RTT-Oriented CUBIC Congestion Control
+ * Extension for 5G and Beyond Networks
+ *
+ * TCP ROCCET is a new TCP congestion control
+ * algorithm suited for current cellular 5G NR beyond networks.
+ * It extends the kernel default congestion control CUBIC
+ * and improves its performance, and additionally solves an
+ * unwanted side effects of CUBIC=E2=80=99s implementation.
+ * ROCCET uses its own Slow Start, called LAUNCH, where loss
+ * is not considered as a congestion event.
+ * The congestion avoidance phase, called ORBITER, uses
+ * CUBIC's window growth function and adds, based on RTT
+ * and ACK rate, congestion events.
+ *
+ * A peer-reviewed paper on TCP ROCCET will be presented
+ * at the WONS 2026 conference.
+ * A draft of the paper is available here:
+ *		https://arxiv.org/abs/2510.25281
+ *
+ *
+ * Further information about CUBIC:
+ * TCP CUBIC: Binary Increase Congestion control for TCP v2.3
+ * Home page:
+ *	http://netsrv.csc.ncsu.edu/twiki/bin/view/Main/BIC
+ * This is from the implementation of CUBIC TCP in
+ * Sangtae Ha, Injong Rhee and Lisong Xu,
+ *  "CUBIC: A New TCP-Friendly High-Speed TCP Variant"
+ *  in ACM SIGOPS Operating System Review, July 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/cubic_a_new_tcp_2008.pdf
+ *
+ * CUBIC integrates a new slow start algorithm, called HyStart.
+ * The details of HyStart are presented in
+ *  Sangtae Ha and Injong Rhee,
+ *  "Taming the Elephants: New TCP Slow Start", NCSU TechReport 2008.
+ * Available from:
+ *  http://netsrv.csc.ncsu.edu/export/hystart_techreport_2008.pdf
+ *
+ * All testing results are available from:
+ * http://netsrv.csc.ncsu.edu/wiki/index.php/TCP_Testing
+ *
+ * Unless CUBIC is enabled and congestion window is large
+ * this behaves the same as the original Reno.
+ */
+
+#include "tcp_roccet.h"
+#include "linux/printk.h"
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/math64.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <net/tcp.h>
+
+/* Scale factor beta calculation (max_cwnd =3D snd_cwnd * beta) */
+#define BICTCP_BETA_SCALE 1024
+
+#define BICTCP_HZ 10 /* BIC HZ 2^10 =3D 1024 */
+
+/* Alpha value for the sRrTT  multiplied by 100.
+ * Here 20 represents a value of 0.2
+ */
+#define ROCCET_ALPHA_TIMES_100 20
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+static int sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+
+module_param(sr_rtt_upper_bound, int, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amou=
nt of segments.");
+
+static int fast_convergence __read_mostly =3D 1;
+static int beta __read_mostly =3D 717; /* =3D 717/1024 (BICTCP_BETA_SCALE=
) */
+static int initial_ssthresh __read_mostly;
+static int bic_scale __read_mostly =3D 41;
+static int tcp_friendliness __read_mostly =3D 1;
+
+static u32 cube_rtt_scale __read_mostly;
+static u32 beta_scale __read_mostly;
+static u64 cube_factor __read_mostly;
+
+/* Note parameters that are used for precomputing scale factors are read-=
only */
+module_param(fast_convergence, int, 0644);
+MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
+module_param(beta, int, 0644);
+MODULE_PARM_DESC(beta, "beta for multiplicative increase");
+module_param(initial_ssthresh, int, 0644);
+MODULE_PARM_DESC(initial_ssthresh, "initial value of slow start threshold=
");
+module_param(bic_scale, int, 0444);
+MODULE_PARM_DESC(bic_scale,
+		 "scale (scaled by 1024) value for bic function (bic_scale/1024)");
+module_param(tcp_friendliness, int, 0644);
+MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
+
+static __always_inline void roccettcp_reset(struct roccettcp *ca)
+{
+	memset(ca, 0, offsetof(struct roccettcp, curr_rtt));
+	ca->next_srrtt_check =3D 0;
+	ca->curr_min_rtt =3D ~0U;
+	ca->last_rtt =3D 0;
+	ca->ece_received =3D false;
+}
+
+static __always_inline void update_min_rtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Check if new lower min RTT was found. If so, set it directly */
+	if (ca->curr_rtt < ca->curr_min_rtt)
+		ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
+}
+
+/* Return difference between last and current ack rate.
+ */
+static __always_inline int get_ack_rate_diff(struct roccettcp *ca)
+{
+	return ca->ack_rate.last_rate - ca->ack_rate.curr_rate;
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static __always_inline void update_ack_rate(struct sock *sk, u32 acked)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	s32 interval =3D USEC_PER_MSEC * 100;
+
+	if ((s32)(now - ca->ack_rate.last_rate_time) >=3D interval) {
+		ca->ack_rate.last_rate_time =3D now;
+		ca->ack_rate.last_rate =3D ca->ack_rate.curr_rate;
+		ca->ack_rate.curr_rate =3D ca->ack_rate.cnt;
+		ca->ack_rate.cnt =3D 0;
+	} else {
+		ca->ack_rate.cnt +=3D acked;
+	}
+}
+
+/* Compute srRTT.
+ */
+static __always_inline void update_srrtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* avoid division by zero */
+	if (ca->curr_min_rtt =3D=3D 0)
+		return;
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min).
+	 *
+	 * curr_min_rtt_timed.rtt is always <=3D than curr_rtt,
+	 * since this is the minimum of the rtt.
+	 *
+	 * 0 is a valid value for rrtt.
+	 */
+	u32 rrtt =3D (100 * (ca->curr_rtt - ca->curr_min_rtt)) /
+		   ca->curr_min_rtt;
+
+	// (1 - alpha) * srRTT + alpha * rRTT
+	ca->curr_srrtt =3D ((100 - ROCCET_ALPHA_TIMES_100) * ca->curr_srrtt +
+			  ROCCET_ALPHA_TIMES_100 * rrtt) / 100;
+}
+
+__bpf_kfunc static void roccettcp_init(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	roccettcp_reset(ca);
+
+	if (initial_ssthresh)
+		tcp_sk(sk)->snd_ssthresh =3D initial_ssthresh;
+
+	/* Initial roccet parameters */
+	ca->roccet_last_event_time_us =3D 0;
+	ca->ack_rate.last_rate =3D 0;
+	ca->ack_rate.last_rate_time =3D 0;
+	ca->ack_rate.curr_rate =3D 0;
+	ca->ack_rate.cnt =3D 0;
+}
+
+__bpf_kfunc static void roccettcp_cwnd_event(struct sock *sk,
+					     enum tcp_ca_event event)
+{
+	if (event =3D=3D CA_EVENT_TX_START) {
+		struct roccettcp *ca =3D inet_csk_ca(sk);
+		u32 now =3D tcp_jiffies32;
+		s32 delta;
+
+		delta =3D now - tcp_sk(sk)->lsndtime;
+
+		/* We were application limited (idle) for a while.
+		 * Shift epoch_start to keep cwnd growth to cubic curve.
+		 */
+		if (ca->epoch_start && delta > 0) {
+			ca->epoch_start +=3D delta;
+			if (after(ca->epoch_start, now))
+				ca->epoch_start =3D now;
+		}
+		return;
+	}
+}
+
+/* calculate the cubic root of x using a table lookup followed by one
+ * Newton-Raphson iteration.
+ * Avg err ~=3D 0.195%
+ */
+static u32 cubic_root(u64 a)
+{
+	u32 x, b, shift;
+	/* cbrt(x) MSB values for x MSB values in [0..63].
+	 * Precomputed then refined by hand - Willy Tarreau
+	 *
+	 * For x in [0..63],
+	 *   v =3D cbrt(x << 18) - 1
+	 *   cbrt(x) =3D (v[x] + 10) >> 6
+	 */
+	static const u8 v[] =3D {
+		/* 0x00 */ 0,	54,  54,  54,  118, 118, 118, 118,
+		/* 0x08 */ 123, 129, 134, 138, 143, 147, 151, 156,
+		/* 0x10 */ 157, 161, 164, 168, 170, 173, 176, 179,
+		/* 0x18 */ 181, 185, 187, 190, 192, 194, 197, 199,
+		/* 0x20 */ 200, 202, 204, 206, 209, 211, 213, 215,
+		/* 0x28 */ 217, 219, 221, 222, 224, 225, 227, 229,
+		/* 0x30 */ 231, 232, 234, 236, 237, 239, 240, 242,
+		/* 0x38 */ 244, 245, 246, 248, 250, 251, 252, 254,
+	};
+
+	b =3D fls64(a);
+	if (b < 7) {
+		/* a in [0..63] */
+		return ((u32)v[(u32)a] + 35) >> 6;
+	}
+
+	b =3D ((b * 84) >> 8) - 1;
+	shift =3D (a >> (b * 3));
+
+	x =3D ((u32)(((u32)v[shift] + 10) << b)) >> 6;
+
+	/* Newton-Raphson iteration
+	 *                         2
+	 * x    =3D ( 2 * x  +  a / x  ) / 3
+	 *  k+1          k         k
+	 */
+	x =3D (2 * x + (u32)div64_u64(a, (u64)x * (u64)(x - 1)));
+	x =3D ((x * 341) >> 10);
+	return x;
+}
+
+/* Compute congestion window to use.
+ */
+static __always_inline void bictcp_update(struct roccettcp *ca, u32 cwnd,
+					  u32 acked)
+{
+	u32 delta, bic_target, max_cnt;
+	u64 offs, t;
+
+	ca->ack_cnt +=3D acked; /* count the number of ACKed packets */
+
+	if (ca->last_cwnd =3D=3D cwnd &&
+	    (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
+		return;
+
+	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	 * On all cwnd reduction events, ca->epoch_start is set to 0,
+	 * which will force a recalculation of ca->cnt.
+	 */
+	if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
+		goto tcp_friendliness;
+
+	ca->last_cwnd =3D cwnd;
+	ca->last_time =3D tcp_jiffies32;
+
+	if (ca->epoch_start =3D=3D 0) {
+		ca->epoch_start =3D tcp_jiffies32; /* record beginning */
+		ca->ack_cnt =3D acked; /* start counting */
+		ca->tcp_cwnd =3D cwnd; /* syn with cubic */
+
+		if (ca->last_max_cwnd <=3D cwnd) {
+			ca->bic_K =3D 0;
+			ca->bic_origin_point =3D cwnd;
+		} else {
+			/* Compute new K based on
+			 * (wmax-cwnd) * (srtt>>3 / HZ) / c * 2^(3*bictcp_HZ)
+			 */
+			ca->bic_K =3D cubic_root(cube_factor *
+					       (ca->last_max_cwnd - cwnd));
+			ca->bic_origin_point =3D ca->last_max_cwnd;
+		}
+	}
+
+	/* cubic function - calc */
+	/* calculate c * time^3 / rtt,
+	 *  while considering overflow in calculation of time^3
+	 * (so time^3 is done by using 64 bit)
+	 * and without the support of division of 64bit numbers
+	 * (so all divisions are done by using 32 bit)
+	 *  also NOTE the unit of those variables
+	 *	  time  =3D (t - K) / 2^bictcp_HZ
+	 *	  c =3D bic_scale >> 10
+	 * rtt  =3D (srtt >> 3) / HZ
+	 * !!! The following code does not have overflow problems,
+	 * if the cwnd < 1 million packets !!!
+	 */
+
+	t =3D (s32)(tcp_jiffies32 - ca->epoch_start);
+	t +=3D usecs_to_jiffies(ca->delay_min);
+
+	/* change the unit from HZ to bictcp_HZ */
+	t <<=3D BICTCP_HZ;
+	do_div(t, HZ);
+
+	if (t < ca->bic_K) /* t - K */
+		offs =3D ca->bic_K - t;
+	else
+		offs =3D t - ca->bic_K;
+
+	/* c/rtt * (t-K)^3 */
+	delta =3D (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);
+	if (t < ca->bic_K) /* below origin*/
+		bic_target =3D ca->bic_origin_point - delta;
+	else /* above origin*/
+		bic_target =3D ca->bic_origin_point + delta;
+
+	/* cubic function - calc bictcp_cnt*/
+	if (bic_target > cwnd)
+		ca->cnt =3D cwnd / (bic_target - cwnd);
+	else
+		ca->cnt =3D 100 * cwnd; /* very small increment*/
+
+	/* The initial growth of cubic function may be too conservative
+	 * when the available bandwidth is still unknown.
+	 */
+	if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
+		ca->cnt =3D 20; /* increase cwnd 5% per RTT */
+
+tcp_friendliness:
+	/* TCP Friendly */
+	if (tcp_friendliness) {
+		u32 scale =3D beta_scale;
+
+		delta =3D (cwnd * scale) >> 3;
+		while (ca->ack_cnt > delta) { /* update tcp cwnd */
+			ca->ack_cnt -=3D delta;
+			ca->tcp_cwnd++;
+		}
+
+		if (ca->tcp_cwnd > cwnd) { /* if bic is slower than tcp */
+			delta =3D ca->tcp_cwnd - cwnd;
+			max_cnt =3D cwnd / delta;
+			if (ca->cnt > max_cnt)
+				ca->cnt =3D max_cnt;
+		}
+	}
+
+	/* The maximum rate of cwnd increase CUBIC allows is 1 packet per
+	 * 2 packets ACKed, meaning cwnd grows at 1.5x per RTT.
+	 */
+	ca->cnt =3D max(ca->cnt, 2U);
+}
+
+__bpf_kfunc static void roccettcp_cong_avoid(struct sock *sk, u32 ack,
+					     u32 acked)
+{
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	bool evaluate_srrtt =3D false;
+	u32 roccet_xj;
+	u32 jitter;
+
+	if (after(ca->last_rtt, ca->curr_rtt))
+		jitter =3D ca->last_rtt - ca->curr_rtt;
+	else
+		jitter =3D ca->curr_rtt - ca->last_rtt;
+
+	/* Update roccet parameters */
+	update_ack_rate(sk, acked);
+	update_min_rtt(sk);
+	update_srrtt(sk);
+
+	/* ROCCET drain.
+	 * Do not increase the cwnd for 100ms after a roccet congestion event
+	 * because the buffer is still not drained.
+	 */
+	if (now - ca->roccet_last_event_time_us <=3D 100 * USEC_PER_MSEC)
+		return;
+
+	/* LAUNCH: Detect an exit point for tcp slow start
+	 * in networks with large buffers of multiple BDP
+	 * Like in cellular networks (5G, ...).
+	 * Or exit LAUNCH if cwnd is too large for application layer
+	 * data rate (tcp cwnd validation).
+	 */
+
+	if ((tcp_in_slow_start(tp) && ca->curr_srrtt > sr_rtt_upper_bound &&
+	     get_ack_rate_diff(ca) >=3D ack_rate_diff_ss) ||
+	    (!tcp_is_cwnd_limited(sk) && tcp_in_slow_start(tp))) {
+		ca->epoch_start =3D 0;
+
+		/* Handle initial slow start. Here occur most bufferbloat */
+		if (tp->snd_ssthresh =3D=3D TCP_INFINITE_SSTHRESH) {
+			tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp) / 2;
+			/* since this is the initial slow start,
+			 * the min cwnd won't be 1, so the window
+			 * can't be set to 0 by accident.
+			 */
+			tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp) / 2,
+						 TCP_INIT_CWND));
+		} else {
+			tcp_sk(sk)->snd_ssthresh =3D
+				tcp_snd_cwnd(tp) - (tcp_snd_cwnd(tp) / 3);
+			tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) -
+						     (tcp_snd_cwnd(tp) / 3));
+		}
+		ca->roccet_last_event_time_us =3D now;
+		return;
+	}
+
+	if (tcp_in_slow_start(tp)) {
+		acked =3D tcp_slow_start(tp, acked);
+		if (!acked)
+			return;
+	}
+
+	if (ca->next_srrtt_check =3D=3D 0)
+		ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+
+	/* Check if it's time to evaluate the srRTT */
+	if (after(now, ca->next_srrtt_check)) {
+		evaluate_srrtt =3D true;
+
+		/* reset struct and set next end of period */
+		ca->next_srrtt_check =3D now + 5 * ca->curr_rtt;
+	}
+
+	/* Respects the jitter of the connection and add it on top of
+	 * the upper bound for the srRTT.
+	 */
+	roccet_xj =3D ((jitter * 100) / ca->curr_min_rtt) +
+		    sr_rtt_upper_bound;
+	if (roccet_xj < sr_rtt_upper_bound)
+		roccet_xj =3D sr_rtt_upper_bound;
+
+	/* The srRTT exceeds the upper bound if bufferbloat happens.
+	 * Here, we want to reduce the cwnd and drain the buffer.
+	 */
+	if (ca->curr_srrtt > roccet_xj &&
+	    (evaluate_srrtt || ca->ece_received)) {
+		if (ca->ece_received)
+			ca->ece_received =3D false;
+		ca->epoch_start =3D 0;
+		ca->roccet_last_event_time_us =3D now;
+		ca->cnt =3D 100 * tcp_snd_cwnd(tp);
+
+		/* Set Wmax if cwnd is larger than the old Wmax */
+		if (tcp_snd_cwnd(tp) > ca->last_max_cwnd)
+			ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+
+		tcp_snd_cwnd_set(tp, min(tp->snd_cwnd_clamp,
+					 max((tcp_snd_cwnd(tp) * beta) /
+					     BICTCP_BETA_SCALE, 2U)));
+		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+		return;
+	}
+
+	/* Terminates this function if cwnd is not fully utilized.
+	 * In mobile networks like 5G, this termination causes the cwnd to be
+	 * frozen at an excessively high value. This is because slow start or
+	 * HyStart massively exceed the available bandwidth and leave the cwnd
+	 * at an excessively high value. The cwnd cannot therefore be fully
+	 * utilized because it is limited by the connection capacity.
+	 */
+	if (!tcp_is_cwnd_limited(sk))
+		return;
+
+	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+	tcp_cong_avoid_ai(tp, max(1, ca->cnt), acked);
+}
+
+__bpf_kfunc static u32 roccettcp_recalc_ssthresh(struct sock *sk)
+{
+	const struct tcp_sock *tp =3D tcp_sk(sk);
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* On loss in slow start enter congestion avoidance
+	 * without a cwnd reduction.
+	 */
+	if (tcp_in_slow_start(tp))
+		return tcp_snd_cwnd(tp);
+
+	ca->epoch_start =3D 0; /* end of epoch */
+
+	/* Wmax and fast convergence */
+	if (tcp_snd_cwnd(tp) < ca->last_max_cwnd && fast_convergence)
+		ca->last_max_cwnd =3D
+			(tcp_snd_cwnd(tp) * (BICTCP_BETA_SCALE + beta)) /
+			(2 * BICTCP_BETA_SCALE);
+	else
+		ca->last_max_cwnd =3D tcp_snd_cwnd(tp);
+
+	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
+}
+
+__bpf_kfunc static void roccettcp_state(struct sock *sk, u8 new_state)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	if (new_state =3D=3D TCP_CA_Loss)
+		roccettcp_reset(ca);
+}
+
+__bpf_kfunc static void roccettcp_acked(struct sock *sk,
+					const struct ack_sample *sample)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Some calls are for duplicates without timestamps */
+	if (sample->rtt_us < 0)
+		return;
+
+	/* Discard delay samples right after fast recovery */
+	if (ca->epoch_start && (s32)(tcp_jiffies32 - ca->epoch_start) < HZ)
+		return;
+
+	u32 delay =3D sample->rtt_us;
+
+	if (delay =3D=3D 0)
+		delay =3D 1;
+
+	/* first time call or link delay decreases */
+	if (ca->delay_min =3D=3D 0 || after(ca->delay_min, delay))
+		ca->delay_min =3D delay;
+
+	/* Get valid sample for roccet */
+	if (sample->rtt_us > 0) {
+		ca->last_rtt =3D ca->curr_rtt;
+		ca->curr_rtt =3D sample->rtt_us;
+	}
+}
+
+__bpf_kfunc static void roccet_in_ack_event(struct sock *sk, u32 flags)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	/* Handle ECE bit.
+	 * Processing of ECE events is done in roccettcp_cong_avoid()
+	 */
+	if (flags & CA_ACK_ECE)
+		ca->ece_received =3D true;
+}
+
+static struct tcp_congestion_ops roccet_tcp __read_mostly =3D {
+	.init =3D roccettcp_init,
+	.ssthresh =3D roccettcp_recalc_ssthresh,
+	.cong_avoid =3D roccettcp_cong_avoid,
+	.set_state =3D roccettcp_state,
+	.undo_cwnd =3D tcp_reno_undo_cwnd,
+	.cwnd_event =3D roccettcp_cwnd_event,
+	.pkts_acked =3D roccettcp_acked,
+	.in_ack_event   =3D roccet_in_ack_event,
+	.owner =3D THIS_MODULE,
+	.name =3D "roccet",
+};
+
+BTF_KFUNCS_START(tcp_roccet_check_kfunc_ids)
+BTF_ID_FLAGS(func, roccettcp_init)
+BTF_ID_FLAGS(func, roccettcp_recalc_ssthresh)
+BTF_ID_FLAGS(func, roccettcp_cong_avoid)
+BTF_ID_FLAGS(func, roccettcp_state)
+BTF_ID_FLAGS(func, roccettcp_cwnd_event)
+BTF_ID_FLAGS(func, roccettcp_acked)
+BTF_ID_FLAGS(func, roccet_in_ack_event)
+BTF_KFUNCS_END(tcp_roccet_check_kfunc_ids)
+
+static const struct btf_kfunc_id_set tcp_roccet_kfunc_set =3D {
+	.owner =3D THIS_MODULE,
+	.set =3D &tcp_roccet_check_kfunc_ids,
+};
+
+static int __init roccettcp_register(void)
+{
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
+
+	/* Precompute a bunch of the scaling factors that are used per-packet
+	 * based on SRTT of 100ms
+	 */
+
+	beta_scale =3D
+		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
+
+	cube_rtt_scale =3D (bic_scale * 10); /* 1024*c/rtt */
+
+	/* calculate the "K" for (wmax-cwnd) =3D c/rtt * K^3
+	 *  so K =3D cubic_root( (wmax-cwnd)*rtt/c )
+	 * the unit of K is bictcp_HZ=3D2^10, not HZ
+	 *
+	 *  c =3D bic_scale >> 10
+	 *  rtt =3D 100ms
+	 *
+	 * the following code has been designed and tested for
+	 * cwnd < 1 million packets
+	 * RTT < 100 seconds
+	 * HZ < 1,000,00  (corresponding to 10 nano-second)
+	 */
+
+	/* 1/c * 2^2*bictcp_HZ * srtt */
+	cube_factor =3D 1ull << (10 + 3 * BICTCP_HZ); /* 2^40 */
+
+	/* divide by bic_scale and by constant Srtt (100ms) */
+	do_div(cube_factor, bic_scale * 10);
+
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&tcp_roccet_kfunc_set);
+	if (ret < 0)
+		return ret;
+	return tcp_register_congestion_control(&roccet_tcp);
+}
+
+static void __exit roccettcp_unregister(void)
+{
+	tcp_unregister_congestion_control(&roccet_tcp);
+}
+
+module_init(roccettcp_register);
+module_exit(roccettcp_unregister);
+
+MODULE_AUTHOR("Lukas Prause, Tim F=C3=BCchsel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ROCCET TCP");
+MODULE_VERSION("1.0");
diff --git a/net/ipv4/tcp_roccet.h b/net/ipv4/tcp_roccet.h
new file mode 100644
index 000000000000..d47f2bad848e
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TCP ROCCET congestion control interface
+ */
+#ifndef __TCP_ROCCET_H
+#define __TCP_ROCCET_H 1
+
+#include <linux/math64.h>
+
+struct ack_rate {
+	u16 last_rate;	/* Last ACK-rate */
+	u32 last_rate_time;	/* Timestamp of the last ACK-rate */
+	u16 curr_rate;	/* Current ACK-rate */
+	u16 cnt;	/* Used for counting acks */
+};
+
+/* Based on the BICTCP struct with additions specific
+ * for the ROCCET-Algorithm
+ */
+struct roccettcp {
+	u32 cnt;		/* increase cwnd by 1 after ACKs */
+	u32 last_max_cwnd;	/* last maximum snd_cwnd */
+	u32 last_cwnd;		/* the last snd_cwnd */
+	u32 last_time;		/* time when updated last_cwnd */
+	u32 bic_origin_point;	/* origin point of bic function */
+	u32 bic_K;		/* time to origin point from the
+				 * beginning of the current epoch
+				 */
+	u32 delay_min;		/* min delay (usec) */
+	u32 epoch_start;	/* beginning of an epoch */
+	u32 ack_cnt;		/* number of acks */
+	u32 tcp_cwnd;		/* estimated tcp cwnd */
+	u32 curr_rtt;		/* the minimum rtt of current round */
+
+	u32 roccet_last_event_time_us;	/* The last time ROCCET was
+					 * triggered
+					 */
+	bool ece_received;	/* Set to true if an ECE bit was received */
+	u32 curr_min_rtt;	/* The current observed minRTT */
+	u32 curr_srrtt;		/* srRTT calculated based on the latest ACK */
+	u32 next_srrtt_check;	/* Next check for srRTT */
+	struct ack_rate ack_rate;	/* The last and the current ACK rate */
+	u32 last_rtt;			/* Used for jitter calculation */
+};
+
+#endif /* __TCP_ROCCET_H */

base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f
=2D-=20
2.43.0


