Return-Path: <netdev+bounces-275453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZLsWNHUU0mnYTAcAu9opvQ
	(envelope-from <netdev+bounces-275453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 09:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8739DB3E
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3964B3008A5E
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D43559D6;
	Sun,  5 Apr 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="SwzA+cdt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07941E520A;
	Sun,  5 Apr 2026 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375474; cv=none; b=iYprDZ7NNIrmBNWrrioZQ4YE0yoxwQdNNlIT9bWbR9DuXMK/61EkAx7uuvnZhcdbm2GZ2u3pyLI2SphnAglqUnfKfID6YjtPWMjEMwHdLFZgaojdEHg9SMVFz7GlMQMkzdmL4MgF9rUwCWuixLAMCIfkjYkE24PgMmRK/93cX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375474; c=relaxed/simple;
	bh=QDIspLPKIjuUIt5s6vVMqY4k7oKwH95ZKY8Iz3UlRtg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PTY5DZKmftxg+YJjsbYlUoSqQmpY4YEOlk8DSTHaaqb7Tksgn2drKeMteVuiE9GJEvsZ0ycMo7BhfPceomNGDQWTV644CTc9NZDRHWJORGlzWAArE3/zM1QmHCx75CctDcgqFtGJltlshYgl7GlTPAPvFHHr/swPPqfGjjJpySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=SwzA+cdt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775375462; x=1775980262; i=t.fuechsel@gmx.de;
	bh=O90WFe8x9EDx+VL/jdcCe3wrPVfYWpR5zqCbzExeuLo=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SwzA+cdt3tXnSSayG/NWini0PeA4yjJY0XnEA6gLDTotV5WynZeEyHe4TTFT/BaD
	 kMGxqcc6cfoXX2P4+Hj9PctoEBdY60ZSMFP8UeLF3cWvEIStQEltQ5zJGonW5oOLV
	 szk0yrHJDQmT0T9OhAVoYbsheC9FE7TgZ+2h6ZXMc91ufHEUZmgIXiMx72OmbJuvu
	 w1MV+CULHEosh3QJ5/5mav3kBC8W+JNRVJNI3FEFbLuEgK/VkW8BL+I7Jv9DoR8ln
	 2lub7i587PgLgZbBFj3oKIcakqkH8uZYkYXX3uWjPmRwmYec10yBkUpdpujbNT1zP
	 e5PIBLEKa5vA8zqqvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe5k-1vntUe1pZO-00PoDb; Sun, 05
 Apr 2026 09:51:02 +0200
Date: Sun, 5 Apr 2026 09:50:59 +0200
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
Subject: [PATCH,net-next] tcp: Add TCP ROCCET congestion control module.
Message-ID: <adIUY2N6HOKZNzSJ@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTFlNm0kEoc7k0DLvLc+mi9TYz05wx5kRzzgKCKgan4X18Doogf
 Jo9XpBf9/PsJJBUPSggeeZhra2c4GXLOMGOOWCj8S6fE7DUqsnBibBJbUVctYBYUEr4szd5
 xfwmWNIC+iQ1IVE+TJXBDX4BAeNu1459BsOSD8jZz6Ba2te604ZNsq0rmMXZ5OVxaoIulYt
 FhDo88jb2hfFESdGHXWDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U7Rl5s7Aqx0=;mVqO2zkP8c+e1i2f/sVSbZvBO/i
 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
 FOibnLWZIAFlaxqPq47gpjoUeOJKJeeQw==
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,ikt.uni-hannover.de,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275453-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.fuechsel@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arxiv.org:url,gmx.de:dkim,gmx.de:email,ncsu.edu:url,doi.org:url]
X-Rspamd-Queue-Id: 21B8739DB3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TCP ROCCET is an extension of TCP CUBIC that improves its overall
performance. By its mode of function, CUBIC causes bufferbloat while
it tries to detect the available throughput of a network path. This is
particularly a problem with large buffers in mobile networks. A more
detailed description and analysis of this problem caused by TCP CUBIC
can be found in [1]. TCP ROCCET addresses this problem by adding two
additional metrics to detect congestion (queueing and bufferbloat)
on a network path. TCP ROCCET achieves better performance than CUBIC
and BBRv3, by maintaining similar throughput while reducing the latency.
In addition, TCP ROCCET does not have fairness issues when sharing a
link with TCP CUBIC and BBRv3. A paper that evaluates the performance
and function of TCP ROCCET has already been peer-reviewed and will be
presented at the WONS 2026 conference. A draft of this paper can be
found here [2].

[1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
[2] https://arxiv.org/abs/2510.25281

Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>
=2D--
 net/ipv4/Kconfig      |  11 +
 net/ipv4/Makefile     |   1 +
 net/ipv4/tcp_roccet.c | 686 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_roccet.h |  60 ++++
 4 files changed, 758 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c
 create mode 100644 net/ipv4/tcp_roccet.h

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 21e5164e30db..33625111c7f0 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -663,6 +663,17 @@ config TCP_CONG_CDG
 	    delay gradients." In Networking 2011. Preprint:
 	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-prepri=
nt.pdf
=20
+config TCP_CONG_ROCCET
+	tristate "ROCCET TCP"
+	default n
+	help
+      TCP ROCCET is a sender-side only modification of the TCP CUBIC
+      protocol stack that optimizes the performance of TCP congestion
+      control. Especially for networks with large buffers (wireless,
+      cellular networks), TCP ROCCET has improved performance by maintain=
ing
+      similar throughput as CUBIC while reducing the latency.
+       For more information, see: https://arxiv.org/abs/2510.25281
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 7f9f98813986..82ed7989dcb3 100644
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
index 000000000000..b0ec3053182f
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,686 @@
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
+/* The amount of seconds ROCCET stores a minRTT.
+ * Enable "calculate_min_rtt" first.
+ */
+#define ROCCET_RTT_LOOKBACK_S 10
+
+/* Parameters that are specific to the ROCCET-Algorithm */
+static int sr_rtt_upper_bound __read_mostly =3D 100;
+static int ack_rate_diff_ss __read_mostly =3D 10;
+static int ack_rate_diff_ca __read_mostly =3D 200;
+static bool calculate_min_rtt __read_mostly;
+static bool ignore_loss __read_mostly;
+static int roccet_min_rtt_interpolation_factor __read_mostly =3D 70;
+
+module_param(sr_rtt_upper_bound, int, 0644);
+MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
+module_param(ack_rate_diff_ss, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ss,
+		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amou=
nt of segments.");
+module_param(ack_rate_diff_ca, int, 0644);
+MODULE_PARM_DESC(ack_rate_diff_ca,
+		 "ROCCET's threshold for ack-rate and cum_cwnd, in percantage of the cu=
rrent cwnd.");
+module_param(calculate_min_rtt, bool, 0644);
+MODULE_PARM_DESC(calculate_min_rtt,
+		 "Calculate min RTT if no lower RTT occurs after 10 sec.");
+module_param(ignore_loss, bool, 0644);
+MODULE_PARM_DESC(ignore_loss, "Ignore loss as a congestion event.");
+module_param(roccet_min_rtt_interpolation_factor, int, 0644);
+MODULE_PARM_DESC(roccet_min_rtt_interpolation_factor,
+		 "ROCCET factor for interpolating the current RTT with the last minRTT =
(minRTT =3D (factor * currRTT + (100-factor) * minRTT) / 100)");
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
+	ca->bw_limit.sum_cwnd =3D 1;
+	ca->bw_limit.sum_acked =3D 1;
+	ca->bw_limit.next_check =3D 0;
+	ca->curr_min_rtt_timed.rtt =3D ~0U;
+	ca->curr_min_rtt_timed.time =3D ~0U;
+	ca->last_rtt =3D 0;
+	ca->ece_received =3D false;
+}
+
+static __always_inline void update_min_rtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+
+	if (now - ca->curr_min_rtt_timed.time >
+		    ROCCET_RTT_LOOKBACK_S * USEC_PER_SEC &&
+	    calculate_min_rtt) {
+		u32 new_min_rtt =3D max(ca->curr_rtt, 1);
+		u32 old_min_rtt =3D ca->curr_min_rtt_timed.rtt;
+
+		u32 interpolated_min_rtt =3D
+			(new_min_rtt * roccet_min_rtt_interpolation_factor +
+			 old_min_rtt *
+				 (100 - roccet_min_rtt_interpolation_factor)) /
+			100;
+
+		ca->curr_min_rtt_timed.rtt =3D interpolated_min_rtt;
+		ca->curr_min_rtt_timed.time =3D now;
+	}
+
+	/* Check if new lower min RTT was found. If so, set it directly */
+	if (ca->curr_rtt < ca->curr_min_rtt_timed.rtt) {
+		ca->curr_min_rtt_timed.rtt =3D max(ca->curr_rtt, 1);
+		ca->curr_min_rtt_timed.time =3D now;
+	}
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
+static __always_inline void update_ack_rate(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+	u32 now =3D jiffies_to_usecs(tcp_jiffies32);
+	u32 interval =3D USEC_PER_MSEC * 100;
+
+	if ((u32)(now - ca->ack_rate.last_rate_time) >=3D interval) {
+		ca->ack_rate.last_rate_time =3D now;
+		ca->ack_rate.last_rate =3D ca->ack_rate.curr_rate;
+		ca->ack_rate.curr_rate =3D ca->ack_rate.cnt;
+		ca->ack_rate.cnt =3D 0;
+	} else {
+		ca->ack_rate.cnt +=3D 1;
+	}
+}
+
+/* Compute srRTT.
+ */
+static __always_inline void update_srrtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	if (ca->curr_min_rtt_timed.rtt =3D=3D 0)
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
+	u32 rrtt =3D (100 * (ca->curr_rtt - ca->curr_min_rtt_timed.rtt)) /
+		   ca->curr_min_rtt_timed.rtt;
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
+	u32 bw_limit_detect =3D 0;
+	u32 roccet_xj;
+	u32 jitter;
+
+	if (ca->last_rtt > ca->curr_rtt)
+		jitter =3D ca->last_rtt - ca->curr_rtt;
+	else
+		jitter =3D ca->curr_rtt - ca->last_rtt;
+
+	/* Update roccet parameters */
+	update_ack_rate(sk);
+	update_min_rtt(sk);
+	update_srrtt(sk);
+
+	/* ROCCET drain.
+	 * Do not increase the cwnd for 100ms after a roccet congestion event
+	 */
+	if (now - ca->roccet_last_event_time_us <=3D 100 * USEC_PER_MSEC)
+		return;
+
+	/* LAUNCH: Detect an exit point for tcp slow start
+	 * in networks with large buffers of multiple BDP
+	 * Like in cellular networks (5G, ...).
+	 * Or exit LAUNCH if cwnd is too large for application layer
+	 * data rate.
+	 */
+
+	if ((tcp_in_slow_start(tp) && ca->curr_srrtt > sr_rtt_upper_bound &&
+	     get_ack_rate_diff(ca) >=3D ack_rate_diff_ss) ||
+	    (!tcp_is_cwnd_limited(sk) && tcp_in_slow_start(tp))) {
+		ca->epoch_start =3D 0;
+
+		/* Handle initial slow start. Here occur most problems */
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
+	if (ca->bw_limit.next_check =3D=3D 0)
+		ca->bw_limit.next_check =3D now + 5 * ca->curr_rtt;
+
+	ca->bw_limit.sum_cwnd +=3D tcp_snd_cwnd(tp);
+	ca->bw_limit.sum_acked +=3D acked;
+
+	if (ca->bw_limit.next_check < now) {
+		/* We send more data as we got acked in the last 5 RTTs */
+		if ((ca->bw_limit.sum_cwnd * 100) / ca->bw_limit.sum_acked >=3D
+		    ack_rate_diff_ca)
+			bw_limit_detect =3D 1;
+
+		/* reset struct and set next end of period */
+		ca->bw_limit.sum_cwnd =3D 1;
+
+		/* set to 1 to avoid division by zero */
+		ca->bw_limit.sum_acked =3D 1;
+		ca->bw_limit.next_check =3D now + 5 * ca->curr_rtt;
+	}
+
+	/* Respects the jitter of the connection and add it on top of
+	 * the upper bound for the srRTT.
+	 */
+	roccet_xj =3D ((jitter * 100) / ca->curr_min_rtt_timed.rtt) +
+		    sr_rtt_upper_bound;
+	if (roccet_xj < sr_rtt_upper_bound)
+		roccet_xj =3D sr_rtt_upper_bound;
+
+	if (ca->curr_srrtt > roccet_xj &&
+	    (bw_limit_detect || ca->ece_received)) {
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
+	if (ignore_loss)
+		return tcp_snd_cwnd(tp);
+
+	/* Don't exit slow start if loss occurs. */
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
+	if (ca->delay_min =3D=3D 0 || ca->delay_min > delay)
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
index 000000000000..93c81a7ba8d3
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.h
@@ -0,0 +1,60 @@
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
+struct bandwidth_limit_detect {
+	u32 sum_cwnd;	/* sum of cwnd during time interval */
+	u32 sum_acked;	/* sum of received acks during time interval */
+	u32 next_check;	/* end/upper bound of time interval */
+};
+
+struct timed_rtt {
+	u32 time;	/* Time of recording */
+	u32 rtt;	/* Measured RTT */
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
+	struct timed_rtt curr_min_rtt_timed;	/* The current observed minRTT
+						 * with the timestamp when it
+						 * was observed
+						 */
+	u32 curr_srrtt;		/* srRTT calculated based on the latest ACK */
+	struct ack_rate ack_rate;	/* The last and the current ACK rate */
+	struct bandwidth_limit_detect bw_limit;
+	u32 last_rtt;			/* Used for jitter calculation */
+};
+
+#endif /* __TCP_ROCCET_H */

base-commit: 3741f8fa004bf598cd5032b0ff240984332d6f05
=2D-=20
2.43.0


