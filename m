Return-Path: <netdev+bounces-296852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oaNUBSd1J2o7xQIAu9opvQ
	(envelope-from <netdev+bounces-296852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130665BCB2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="OSDzm/J1";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296852-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0370C301B538
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3097035F16B;
	Tue,  9 Jun 2026 02:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630B346FBC;
	Tue,  9 Jun 2026 02:06:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970785; cv=none; b=J5ue3mf/ErFTgBU+IA3WTpnFRgaPRfhM+bNwmakgEEpJBmdZVaadERo/dV645n4eEEQJoxCT78ifjlx0tgTb/LhXNo25652dJBe47u71qVf7rlVY4qvTzXkTuvADEgKYiDWPctgZfHx2zIJaVpbPOoso+f1E0c2aHo0UxlfGmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970785; c=relaxed/simple;
	bh=+ZU+8q3YzQl6NM0T5FTCPvEVjQzYWV1OKXa0+76ccYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJtS4njN4mX+0oFqteOQzWdgMtMRReGQw54p/02Jmnrlxf+ZiSap20//vgzzNQJDtyJhCbyFIyzQ/BjiZEBL6z5LiKpqHUL9JRPd1nRAZz8VOxfgApT6sKymtoJaGNZ0kC73fO6WNlre//9bdcqOkFETIFyP8VBngEtzxhGO7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSDzm/J1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31151F00893;
	Tue,  9 Jun 2026 02:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970783;
	bh=Y1AN9aEbDpmG7aUuWdVXhYudC9Qm5EVzSPLGx8WTLhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSDzm/J1Ssa8QQpz78roFl1qyl/l4vg2zKkMr4o1OYKoqGnXCKQCTLgStxRa/a/M5
	 /oYbd55Mz/pz+rE1TlgqYOL/uq4bH82PJmLGt05ZEesmYS+QlXTiW/hZBQ3zXZwYS/
	 VRzBYOgnKq81W1tKETjTuWMY62TeGQnElbhS+lTTYvSW1AtdAFcFnHvZcC/S2R64Es
	 XIZbv3K/vH+8/KgT+pi4nsTM0Bcl/O0bLuvLRCbOTGUduX4PoVwcd9TK2oBWL0/G2a
	 bnsUcVQWgD8D/V6qgLhlGMjBWRwfpZ+YIlNlClxR0UAMEJQXffpVdMgRL3aobuZe/2
	 8dZmNAbVaQulg==
From: Jakub Kicinski <kuba@kernel.org>
To: t.fuechsel@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	fmancera@suse.de,
	ebiggers@kernel.org,
	bpf@vger.kernel.org,
	lukas.prause@ikt.uni-hannover.de
Subject: Re: [PATCHv3 net-next] tcp: Add TCP ROCCET congestion control module.
Date: Mon,  8 Jun 2026 19:06:20 -0700
Message-ID: <20260609020620.787588-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ah_ZFYB_tiw45_fg@volt-roccet-vm>
References: <ah_ZFYB_tiw45_fg@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:t.fuechsel@gmx.de,m:kuba@kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:fmancera@suse.de,m:ebiggers@kernel.org,m:bpf@vger.kernel.org,m:lukas.prause@ikt.uni-hannover.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arxiv.org:url,swin.edu.au:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1130665BCB2

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tcp: Add TCP ROCCET congestion control module.

This patch adds a new TCP congestion control algorithm derived from
TCP CUBIC, called ROCCET, which adds bufferbloat detection based on
srRTT and ACK arrival rate, and replaces HyStart with a custom slow
start phase called LAUNCH. A few observations follow.

[Low]
The commit message says:

  The second metric is the acknowledgment arrival rate sampled over 5
  RTT intervals.

Looking at update_ack_rate(), the sampling window is a fixed 100 ms
wall-clock interval (u32 interval = USEC_PER_MSEC * 100), not a
multiple of the connection's RTT. The 5*curr_rtt window only governs
ca->next_srrtt_check. Should the commit message match the
implementation, or should the implementation be changed to actually
sample over 5 RTT intervals?

[Low]
Could the commit message also discuss why ROCCET cannot be implemented
as a BPF struct_ops program on top of CUBIC, given that this same
patch already registers BTF kfuncs for the struct_ops interface and
that most of the file is a verbatim copy of CUBIC?

> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 301b47660305..23197958324b 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -663,6 +663,18 @@ config TCP_CONG_CDG
>  	    delay gradients." In Networking 2011. Preprint:
>  	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-preprint.pdf
>  
> +config TCP_CONG_ROCCET
> +	tristate "ROCCET TCP"
> +	default n
> +	help
> +	  TCP ROCCET is a sender-side only modification of the TCP CUBIC
> +	  protocol stack/TCP CUBIC congestion control algorithm that
> +	  optimizes the performance of TCP congestion control. Especially
> +	  for networks with large buffers (wireless, cellular networks),
> +	  TCP ROCCET has improved performance by maintaining similar
> +	  throughput as CUBIC while reducing the latency.
> +	  For more information, see: https://arxiv.org/abs/2510.25281

[Low]
The help text describes ROCCET as a "modification of the TCP CUBIC
protocol stack/TCP CUBIC congestion control algorithm", but CUBIC
itself is not modified by this patch; ROCCET is a new sibling module
that copies large parts of CUBIC. The acronym ROCCET is also never
expanded here. Should the help text be reworded?

> diff --git a/net/ipv4/tcp_roccet.h b/net/ipv4/tcp_roccet.h
> new file mode 100644
> index 000000000000..5025d14667bb
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.h
> @@ -0,0 +1,46 @@

[Low]
Is the separate header net/ipv4/tcp_roccet.h needed? It only declares
struct ack_rate and struct roccettcp, both of which are used solely
inside tcp_roccet.c. Other in-tree CCs (tcp_cubic.c, tcp_bbr.c,
tcp_vegas.c, tcp_dctcp.c, tcp_bic.c, tcp_cdg.c, ...) keep their
per-socket state in the .c file.

> +struct roccettcp {
> +	u32 cnt;		/* increase cwnd by 1 after ACKs */
[ ... ]
> +	u32 curr_rtt;		/* the minimum rtt of current round */

[Low]
The comment says "the minimum rtt of current round", but in
roccettcp_acked() curr_rtt is assigned the latest sample
(ca->curr_rtt = sample->rtt_us;) without any min-of-round logic. Was
the comment intended to be copied from tcp_cubic.c, where curr_rtt
has different semantics?

> diff --git a/net/ipv4/tcp_roccet.c b/net/ipv4/tcp_roccet.c
> new file mode 100644
> index 000000000000..900329bb070b
> --- /dev/null
> +++ b/net/ipv4/tcp_roccet.c
[ ... ]
> +/* Parameters that are specific to the ROCCET-Algorithm */
> +static int sr_rtt_upper_bound __read_mostly = 100;
> +static int ack_rate_diff_ss __read_mostly = 10;
> +
> +module_param(sr_rtt_upper_bound, int, 0644);
> +MODULE_PARM_DESC(sr_rtt_upper_bound, "ROCCET's upper bound for srRTT.");
> +module_param(ack_rate_diff_ss, int, 0644);
> +MODULE_PARM_DESC(ack_rate_diff_ss,
> +		 "ROCCET's threshold to exit slow start if ACK-rate defer by given amount of segments.");
> +
> +static int fast_convergence __read_mostly = 1;
> +static int beta __read_mostly = 717; /* = 717/1024 (BICTCP_BETA_SCALE) */
> +static int initial_ssthresh __read_mostly;
> +static int bic_scale __read_mostly = 41;
> +static int tcp_friendliness __read_mostly = 1;

[Low]
sr_rtt_upper_bound and ack_rate_diff_ss are declared signed int and
exposed as 0644 module params, but they are compared to and added to
u32 quantities (curr_srrtt, get_ack_rate_diff(), roccet_xj). If a
negative value is written, the signed-to-unsigned promotion turns it
into a very large unsigned, effectively disabling the bufferbloat
detection branch. Should these be unsigned int with a setter that
rejects 0 / negative values?

[Low]
Is there a way to avoid adding seven new module_param tunables to a
new in-tree CC? Five of them duplicate CUBIC's identically named
knobs (fast_convergence, beta, initial_ssthresh, bic_scale,
tcp_friendliness), which makes it hard for an admin to reason about
which knob applies to which CC, and these are global (not per-netns)
unlike the sysctls used by other modern CCs.

> +static __always_inline void update_min_rtt(struct sock *sk)
> +{
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	/* Check if new lower min RTT was found. If so, set it directly */
> +	if (ca->curr_rtt < ca->curr_min_rtt)
> +		ca->curr_min_rtt = max(ca->curr_rtt, 1);
> +}

[High]
Can update_min_rtt() and update_srrtt() leave curr_min_rtt at 0 and
crash the kernel via divide-by-zero in roccettcp_cong_avoid()?

After roccettcp_reset() (called from roccettcp_init() and from
roccettcp_state(TCP_CA_Loss)) curr_rtt is 0 and curr_min_rtt is ~0U.
On the next ACK that reaches roccettcp_cong_avoid() before
roccettcp_acked() has set curr_rtt to a non-zero value (the early
return in roccettcp_acked() suppresses updates for HZ jiffies after
fast recovery), update_min_rtt() does:

	if (ca->curr_rtt < ca->curr_min_rtt)
		ca->curr_min_rtt = max(ca->curr_rtt, 1);

so curr_min_rtt is clamped to 1. Then update_srrtt() runs:

	if (ca->curr_rtt < ca->curr_min_rtt)
		ca->curr_min_rtt = ca->curr_rtt;

which overwrites curr_min_rtt with 0 (curr_rtt). update_srrtt()
returns early on its own divide-by-zero guard, but cong_avoid keeps
running and reaches:

	roccet_xj = ((jitter * 100) / ca->curr_min_rtt) +
		    sr_rtt_upper_bound;

and divides by 0.

Once curr_min_rtt becomes 0, the unsigned compare
(ca->curr_rtt < ca->curr_min_rtt) is false for any later positive
curr_rtt, so curr_min_rtt stays 0 for the lifetime of the socket. Is
that intended?

> +/* Compute srRTT.
> + */
> +static __always_inline void update_srrtt(struct sock *sk)
> +{
[ ... ]
> +	u32 rrtt = (100 * (ca->curr_rtt - ca->curr_min_rtt)) /
> +		   ca->curr_min_rtt;

[Medium]
Can this overflow? curr_rtt and curr_min_rtt are microseconds and can
reach values close to TCP_RTO_MAX (~120 s). 100 * (curr_rtt -
curr_min_rtt) is computed in u32 and wraps once the difference
exceeds about 42.9 ms. The wrapped rrtt is then folded into
curr_srrtt and drives the LAUNCH/ORBITER decisions. Should this be
promoted to u64 with div_u64()?

[ ... ]
> +__bpf_kfunc static void roccettcp_cwnd_event(struct sock *sk,
> +					     enum tcp_ca_event event)
> +{
> +	if (event == CA_EVENT_TX_START) {
> +		struct roccettcp *ca = inet_csk_ca(sk);
> +		u32 now = tcp_jiffies32;
> +		s32 delta;
> +
> +		delta = now - tcp_sk(sk)->lsndtime;
> +
> +		/* We were application limited (idle) for a while.
> +		 * Shift epoch_start to keep cwnd growth to cubic curve.
> +		 */
> +		if (ca->epoch_start && delta > 0) {
> +			ca->epoch_start += delta;
> +			if (after(ca->epoch_start, now))
> +				ca->epoch_start = now;
> +		}
> +		return;
> +	}
> +}

[High]
Is this body reachable? In include/net/tcp.h tcp_ca_event() dispatches
CA_EVENT_TX_START exclusively to .cwnd_event_tx_start and returns
before calling .cwnd_event:

	if (event == CA_EVENT_TX_START) {
		if (icsk->icsk_ca_ops->cwnd_event_tx_start)
			icsk->icsk_ca_ops->cwnd_event_tx_start(sk);
		return;
	}

tcp_cubic.c handles this by registering cubictcp_cwnd_event_tx_start
in .cwnd_event_tx_start. With the registration here only setting
.cwnd_event = roccettcp_cwnd_event, the entire idle-period
epoch_start adjustment is dead code, and on a transition out of
application-limited idle bictcp_update() will compute t with a stale
epoch_start, which then propagates through:

	delta = (cube_rtt_scale * offs * offs * offs) >> (10 + 3 * BICTCP_HZ);

producing a large bic_target/cnt. Should this be wired to
.cwnd_event_tx_start instead?

[ ... ]
> +/* calculate the cubic root of x using a table lookup followed by one
> + * Newton-Raphson iteration.
> + * Avg err ~= 0.195%
> + */
> +static u32 cubic_root(u64 a)
[ ... ]
> +/* Compute congestion window to use.
> + */
> +static __always_inline void bictcp_update(struct roccettcp *ca, u32 cwnd,
> +					  u32 acked)

[Low]
cubic_root(), bictcp_update(), the module_param block, and the
precomputation in roccettcp_register() appear to be byte-for-byte
copies of tcp_cubic.c. Should these be factored as shared helpers in
a common file (or ROCCET implemented as a BPF struct_ops on top of
CUBIC) so that future numerical fixes to CUBIC propagate to ROCCET?

[ ... ]
> +__bpf_kfunc static void roccettcp_cong_avoid(struct sock *sk, u32 ack,
> +					     u32 acked)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct roccettcp *ca = inet_csk_ca(sk);
> +
> +	u32 now = jiffies_to_usecs(tcp_jiffies32);
> +	bool evaluate_srrtt = false;
> +	u32 roccet_xj;
> +	u32 jitter;
> +
> +	if (after(ca->last_rtt, ca->curr_rtt))
> +		jitter = ca->last_rtt - ca->curr_rtt;
> +	else
> +		jitter = ca->curr_rtt - ca->last_rtt;

[Low]
after() is the TCP sequence-number macro from include/net/tcp.h.
Using it here for an RTT-microsecond comparison works (it expands to
a signed 32-bit subtraction), but it is a sequence-space helper and
reads as a layering mistake. The same file uses raw subtraction with
<= a few lines below ("now - ca->roccet_last_event_time_us <= 100 *
USEC_PER_MSEC"), so the time arithmetic is internally inconsistent.
Could the after() uses be replaced with explicit (s32) subtractions?

[Low]
On the very first call after a reset, ca->last_rtt is 0, so this
computes jitter = |curr_rtt - 0| = curr_rtt, i.e. an entire RTT
worth of "jitter". That value then feeds roccet_xj and loosens the
bufferbloat-detection threshold during the LAUNCH phase the
algorithm is supposed to keep tightest. Should the first sample be
suppressed (e.g., skip jitter computation while last_rtt == 0)?

[ ... ]
> +	roccet_xj = ((jitter * 100) / ca->curr_min_rtt) +
> +		    sr_rtt_upper_bound;
> +	if (roccet_xj < sr_rtt_upper_bound)
> +		roccet_xj = sr_rtt_upper_bound;

[Medium]
Same overflow class as update_srrtt(): jitter * 100 is computed in
u32. With jitter above ~42.9 ms in microseconds the multiplication
wraps, and the subsequent clamp "if (roccet_xj < sr_rtt_upper_bound)"
only catches a subset of the wrap cases. The wrapped value drives
whether the cwnd-reduction branch fires. Should jitter * 100 be
performed in u64?

[ ... ]
> +static int __init roccettcp_register(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_SIZE);
[ ... ]
> +	beta_scale =
> +		8 * (BICTCP_BETA_SCALE + beta) / 3 / (BICTCP_BETA_SCALE - beta);
[ ... ]
> +	/* divide by bic_scale and by constant Srtt (100ms) */
> +	do_div(cube_factor, bic_scale * 10);

[Low]
Can these divides panic at module load if bic_scale=0 or beta=1024 is
passed via modprobe? do_div(cube_factor, bic_scale * 10) divides by 0
when bic_scale is 0, and beta_scale divides by (BICTCP_BETA_SCALE -
beta) which is 0 when beta is 1024. The same shape exists in
tcp_cubic.c, but should the new file sanity-check these inputs
before computing the precomputed factors?

[Low]
MODULE_VERSION("1.0") is more typical of out-of-tree DKMS modules
than of in-tree code; should it be dropped here?
-- 
pw-bot: cr

