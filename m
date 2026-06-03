Return-Path: <netdev+bounces-294652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7wn7OSbfH2okrgAAu9opvQ
	(envelope-from <netdev+bounces-294652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:00:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2563573C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="hJu8LI/C";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294652-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294652-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AE88311D560
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F34028DC;
	Wed,  3 Jun 2026 07:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B5403EA0;
	Wed,  3 Jun 2026 07:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472103; cv=none; b=dZTfdpj/MEFmFbLUt2kBjQ/bA962sHlVqXceFFnAbDPMIlK2Sna1iE+rBkjmqecAIt3CUg26w3ymJ0GOTzIz/OBzEmQUZfsfxNPg30eGVWVQEQMoFBQIaRFcUd6Mmbolejji8D+ZTYSaeWCyFt+BDUCntiirR1KoYwGIZZBnuA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472103; c=relaxed/simple;
	bh=bPo7krtIgXs5BY/cpJoOTjf5tgN3Ql9tJqJLf26TgxU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u3V8FgaTSW25YsL0M602Y30rCp5C28mrMCMUJt2t0lz/6EsGH0+/c0FKcW3kysbwpOI29GnKqArHe4IzP4k4R0rx088hN1RVhvBTJifJBM8i5dFgd/jS5KtUPnkGMMnlnJMc9CcnlXUgcIfcfSB8LCMo3WanIDrlNy6kWxetRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=hJu8LI/C; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780472089; x=1781076889; i=t.fuechsel@gmx.de;
	bh=ufz+7dTJxR5gnVDUuGzW1/F/AORyKMfX2UVHJYpWpbE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hJu8LI/CBgqCjDEB058ERu4/+47PPrmTi8OiIzq/9JFotPpSlf0vpHDWLR6JCzhD
	 oVidlxh3vGSbzRDHoaY9ITz6nS04gfNWGSxHgpxLIM+O1D8xWHd3D9Fknr2tOe6Gk
	 QrPum7qDyccvmFH0DRgoGYGB/I1h70BYj65eYCNkJRg6BhYoe+0LG4c18UyMiB+36
	 Jfnk38RZto6obwTnCS4VbQQ4cNa5j2kIwuOysf5VkvtFi6FnS/c4VeEFj/cbde8d2
	 HlkPk1sSYvmK63OpzGbxbZLn8Pll56xZgAh2hieTY8iddrwNeafWkCvjXG2mksDHC
	 89nE7+GV98qOa7A8BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLi8g-1wmD0a2NnM-00PyDc; Wed, 03
 Jun 2026 09:34:48 +0200
Date: Wed, 3 Jun 2026 09:34:45 +0200
From: Tim Fuechsel <t.fuechsel@gmx.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org,
	bpf@vger.kernel.org,
	Lukas Prause <lukas.prause@ikt.uni-hannover.de>,
	Tim Fuechsel <t.fuechsel@gmx.de>
Subject: [PATCHv3 net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <ah_ZFYB_tiw45_fg@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k3bKz7Jfi8sr3dCwbDMgV44CfKmL9Z0Qq9ia2mzmALHhxZiL2tP
 JxfTjHKlSZJnCx9nALTnmd5RhgQuHGYdTXISVqwy/vDaW/qPRmsfQtL/dm5lszUO6L1ZgLE
 5A8HKjfBiHHWUffzduWkFfI8C5LGXu2pL3YSdRXuTkHtOesaNns45XihpV8CFNNDnSQinLI
 ujIWfw+th8LsOiIFCghwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EpkMpwMjVmg=;OhV7f42j3rYNinE3+DgcYiHfzxE
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:fmancera@suse.de,m:ebiggers@kernel.org,m:bpf@vger.kernel.org,m:lukas.prause@ikt.uni-hannover.de,m:t.fuechsel@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,suse.de,ikt.uni-hannover.de,gmx.de];
	FORGED_SENDER(0.00)[t.fuechsel@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.fuechsel@gmx.de,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294652-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arxiv.org:url,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,uni-hannover.de:email,volt-roccet-vm:mid,doi.org:url,ncsu.edu:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2E2563573C

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

Changes since v2:
	* Improve initialization of roccettcp struct
	* Always react to ECE bits and reset flag
	* Detect plateaus in ACK-rate
	* Fix potential overflow in ACK-rate tracking for high-speed connections
	* Reset ACK-counter correctly on new interval
	* Fix potential integer overflow in rRTT calculation
=2D--
 net/ipv4/Kconfig      |  12 +
 net/ipv4/Makefile     |   1 +
 net/ipv4/tcp_roccet.c | 647 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_roccet.h |  46 +++
 4 files changed, 706 insertions(+)
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
index 000000000000..900329bb070b
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,647 @@
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
+	memset(ca, 0, sizeof(struct roccettcp));
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
+	if (ca->ack_rate.curr_rate < ca->ack_rate.last_rate)
+		return 0;
+	return ca->ack_rate.curr_rate - ca->ack_rate.last_rate;
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static __always_inline void update_ack_rate(struct sock *sk, u32 acked)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	u32 interval =3D USEC_PER_MSEC * 100;
+
+	if (after(now, ca->ack_rate.last_rate_time + interval)) {
+		ca->ack_rate.last_rate_time =3D now;
+		ca->ack_rate.last_rate =3D ca->ack_rate.curr_rate;
+		ca->ack_rate.curr_rate =3D ca->ack_rate.cnt;
+		ca->ack_rate.cnt =3D acked; // start counting for the new interval
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
+	/* Avoid integer overflow in the calculation below.
+	 * This could occur in cases where we have not yet
+	 * received an RTT sample.
+	 */
+	if (ca->curr_rtt < ca->curr_min_rtt)
+		ca->curr_min_rtt =3D ca->curr_rtt;
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
+	     get_ack_rate_diff(ca) <=3D ack_rate_diff_ss) ||
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
+	if ((ca->curr_srrtt > roccet_xj && evaluate_srrtt) ||
+	    ca->ece_received) {
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
index 000000000000..5025d14667bb
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
+	u32 last_rate;	/* Last ACK-rate */
+	u32 last_rate_time;	/* Timestamp of the last ACK-rate */
+	u32 curr_rate;	/* Current ACK-rate */
+	u32 cnt;	/* Used for counting acks */
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


