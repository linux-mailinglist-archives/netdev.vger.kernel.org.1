Return-Path: <netdev+bounces-265146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HOo2CnI7rGmTnQEAu9opvQ
	(envelope-from <netdev+bounces-265146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 15:51:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7FF22C3CA
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BC98301BDFB
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E3286405;
	Sat,  7 Mar 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="ewsQ3fwg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C326CE3B;
	Sat,  7 Mar 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895085; cv=none; b=S0kCItvfDmxcVgSV5lOLlBeVNww6OEgoINj+tVlevQxBUbfgsl/37NhH4O2XGTX8ppZUkLE5MAxlkqluuTkGozso/Ap2y8h4xvrlmM1voLtAo6xp+T+lgok4xXW04le2sVnFYUXIi8DJt7IjpWlJLKsP3Ga1bzQERTygBQ8sEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895085; c=relaxed/simple;
	bh=SHVmtj/JnH1O9ywwr5EGZsY/iHF56SN06jjp42Rj2vo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qcwv43M4p0dyulHo/Kcam2K8dBkEwGkdzfRGrKhrolxheAILs23nUBO5FTztnNsA+vUNUWkvT6a8oBuuajiUhROFsWNA1oBpqeT/YIX/mRdVmBsTQmU53sj9NfsxsXQy0yxqQh5SFfSlxXtyPAQjZ/uTKSxzsMUBSZrHmV0lbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=ewsQ3fwg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772895068; x=1773499868; i=t.fuechsel@gmx.de;
	bh=1InblDLulJk8r66o/+xo2S6yRad1/d1PJjl9TxCoc+c=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ewsQ3fwgfEcbqj4dihj9BIfPXh9fcdaSBeKEhvUbNbxvv0SSnr54YDpen02ORECM
	 g1MlQ4wTzzTG2wJDbAJSGV3J2O1no6ryt08fJNKtm/RU5emHm9bwIeisaHf8sk27r
	 UcPNj1MgnZUvRHN7wlp1RwW9uiu9gQCwTNDayuZY1X5qZ0aNDB8H4uiYDaE1fW5vB
	 dfg+a9D9f2b481sXWrXPtGcozoXrajRyQbNKoxMeFmYNouQZeEtuJRrEHE0LP4B62
	 goRzOIwTWCYltFKLTd1t6IFAEb5SW+5kKMtNn1wZXnfIYkm9UXjwqq7dQvdkcXHgc
	 WZpfzft/86pc8AeqdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUnz-1vjwRB0U9p-016AdI; Sat, 07
 Mar 2026 15:51:08 +0100
Date: Sat, 7 Mar 2026 15:51:05 +0100
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
Subject: [RFC v2 RESEND] tcp: Add TCP ROCCET congestion control module.
Message-ID: <aaw7WZdZA9MDo8cm@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1339FLj4pVckPFcb47ELkgY15RvvNKn8bw/Vd6WmF0d3k8PPhfo
 b0tOAHNR+2HSyn84zHyGhXARXLlqb/1kqvrhSpzSTBlngWhNhmH41qnB3rCPcPYdILyUE2Z
 +pPd8Oq0WAP1q4Zrj0QYa5cESDBAhsUcucEmj6LwgOH2Yf2ZclDquFXdlKtQFNfL+KSIZUF
 KpnOMjcglOqeAxrhLXuQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bg7qs/ILDfs=;ICx4T90REQAe4wlffT5b7GR1iMG
 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
 Ay+s/h8OGiFWkKcbhK1RCghy4fc8n
X-Rspamd-Queue-Id: AB7FF22C3CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-265146-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.777];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.fuechsel@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,doi.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ncsu.edu:url,swin.edu.au:url]
X-Rspamd-Action: no action

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

Changes since v1:
	- Removes bug in ECN handling.
	- Received ECE bit is handled as ROCCET congestion event.
=2D--
 net/ipv4/Kconfig      |  12 +
 net/ipv4/Makefile     |   1 +
 net/ipv4/tcp_roccet.c | 671 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_roccet.h |  56 ++++
 4 files changed, 740 insertions(+)
 create mode 100644 net/ipv4/tcp_roccet.c
 create mode 100644 net/ipv4/tcp_roccet.h

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index b71c22475c51..781a0db37309 100644
=2D-- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -664,6 +664,18 @@ config TCP_CONG_CDG
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
+
 config TCP_CONG_BBR
 	tristate "BBR TCP"
 	default n
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index ec36d2ec059e..35fa62b6d07f 100644
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
index 000000000000..892faf907edb
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.c
@@ -0,0 +1,671 @@
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
+ * A peer-reviewed paper on TCP ROCCET will be presented at the WONS 2026=
 conference.
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
+static inline void roccettcp_reset(struct roccettcp *ca)
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
+static inline void update_min_rtt(struct sock *sk)
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
+static inline int get_ack_rate_diff(struct roccettcp *ca)
+{
+	return ca->ack_rate.last_rate - ca->ack_rate.curr_rate;
+}
+
+/* Update ack rate sampled by 100ms.
+ */
+static inline void update_ack_rate(struct sock *sk)
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
+static inline void update_srrtt(struct sock *sk)
+{
+	struct roccettcp *ca =3D inet_csk_ca(sk);
+
+	if (ca->curr_min_rtt_timed.rtt =3D=3D 0)
+		return;
+
+	/* Calculate the new rRTT (Scaled by 100).
+	 * 100 * ((sRTT - sRTT_min) / sRTT_min)
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
+	ca->curr_min_rtt =3D ~0U;
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
+static inline void bictcp_update(struct roccettcp *ca, u32 cwnd, u32 acke=
d)
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
+		/* Handle initial slow start. Here we observe the most problems */
+		if (tp->snd_ssthresh =3D=3D TCP_INFINITE_SSTHRESH) {
+			tcp_sk(sk)->snd_ssthresh =3D tcp_snd_cwnd(tp) / 2;
+			tcp_snd_cwnd_set(tp, tcp_snd_cwnd(tp) / 2);
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
+	/* Respects the jitter of the connection and add it on top of the upper =
bound
+	 * for the srRTT
+	 */
+	roccet_xj =3D ((jitter * 100) / ca->curr_min_rtt_timed.rtt) +
+		    sr_rtt_upper_bound;
+	if (roccet_xj < sr_rtt_upper_bound)
+		roccet_xj =3D sr_rtt_upper_bound;
+
+	if (ca->curr_srrtt > roccet_xj && (bw_limit_detect || ca->ece_received))=
 {
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
+					 max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U)));
+		tp->snd_ssthresh =3D tcp_snd_cwnd(tp);
+		return;
+	}
+
+	/* Terminates this function if cwnd is not fully utilized.
+	 * In mobile networks like 5G, this termination causes the cwnd to be fr=
ozen at
+	 * an excessively high value. This is because slow start or HyStart mass=
ively
+	 * exceed the available bandwidth and leave the cwnd at an excessively h=
igh
+	 * value. The cwnd cannot therefore be fully utilized because it is limi=
ted by
+	 * the connection capacity.
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
index 000000000000..a7201866d5ac
=2D-- /dev/null
+++ b/net/ipv4/tcp_roccet.h
@@ -0,0 +1,56 @@
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
+/* Based on the BICTCP struct with additions specific for the ROCCET-Algo=
rithm */
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
+	u32 roccet_last_event_time_us;	/* The last time ROCCET was triggered */
+	bool ece_received;	/* Set to true if an ECE bit was received */
+	u32 curr_min_rtt;		/* The current observed minRTT */
+	struct timed_rtt curr_min_rtt_timed;	/* The current observed minRTT with
+						 * the timestamp when it was observed
+						 */
+	u32 curr_srrtt;			/* The srRTT calculated based on the latest ACK */
+	struct ack_rate ack_rate;	/* The last and the current ACK rate */
+	struct bandwidth_limit_detect bw_limit;
+	u32 last_rtt;			/* Used for jitter calculation */
+};
+
+#endif /* __TCP_ROCCET_H */
=2D-=20
2.43.0


