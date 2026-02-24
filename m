Return-Path: <netdev+bounces-260624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANghM57snWncSgQAu9opvQ
	(envelope-from <netdev+bounces-260624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:23:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5818B4E3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5210531D7E30
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78602046BA;
	Tue, 24 Feb 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/9PtSLg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304E70810
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956470; cv=none; b=Wqp2lo/dhs//2HS7Z5/RNGac9t4tcJPgTsLOP0pT+e0i+FIijgg7fwCQhtNcVS/uLo01BHlZk3izV+9uFmDYna+LJC9X+AdYtyPNWheKIu/V56WH3Pt3VkjVJTG+ptKAXLZpn8tjRV0k53qX8pz3YT3716+8eEoosOq9x7IMtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956470; c=relaxed/simple;
	bh=fgzJ3IMQdAMzejtFEJljAl6SvulwCuVl4ArDslyeT8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFYixf5AvNxi95UnnhAMsJvTtv56n4fnhVKHMj0ctJ8pttlZECztuCT2Ph5X6Enm1MJfcKStZxOeo6gvatZM54t+CtkJtBbcpYqCv0ReQGsk8abYhXeC2Z+5pkAUv8iAirDkSl//eDiHdiDUD4QNzLDVjO7TJ+kEx8HyDIViP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/9PtSLg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436e87589e8so5594646f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956467; x=1772561267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bFMgYpjVNXlCPtjo5P1vN5+m+PTM8Dera8y/sVDNAc=;
        b=m/9PtSLgYqBxWghvDwmKe3jIMyfZwSBIiE60uD87FzkVvJrd1Pr3lzRe69LUiJkF4H
         s+d4i1JaZHE/LAa6iA2LqelalQ+cqJvnET/2klCxG4IT0Nvg/MEWCgIKrM5GU2Bef/Zp
         pmOPdBij+8NFnjho0MMiyxF+q5oirWBuxrr3JKQvtWYJNkkGCSqe5lczm3thCYnot3xS
         uu0Zty8K97qIRe8SSKjcyAPeBq+cK3bYryXLQYK8RwXp4hDz3SZdkW/01GnSepCkz/YI
         LtuNNQXQc9IiaUrTyLZJjPZeFP92V3jVvvdhBgga518VLbE2O95mJOfD9kDkpYIpIskf
         BeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956467; x=1772561267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bFMgYpjVNXlCPtjo5P1vN5+m+PTM8Dera8y/sVDNAc=;
        b=u9vimun8ToyoqRkdv/5UrmgZM5lhplR+D8monJxyJ2I5GO8N01hRZxaah4osIvsX4B
         ABWPfXyzyZjh6h8GYw8+H/Hgp0Kzfd7UIxsxdGdRA8mQgGhdrMkz34inlLBFnQu9wIQb
         lee5S6yqDpQCsEnx2P/mJT9Z4nvZNFt4B3HcV0rCsS5WX4YBQ9RuLzylLMJntYTllzai
         R+efqDjAEj+d4eXQlIrpIkjxw7g6QHpHIDqbFfzHR5RYXvATc6y4TOO+4uJQSlUwgU9P
         lzMjM/jxVuCUSlTSGrq1wp7zszcJs77jtvaKhwYLASUUtbBB/njgL2MAxa9jITpXWfpX
         +faw==
X-Forwarded-Encrypted: i=1; AJvYcCXhD5WmOc6bdD2CAjtsn+dQpBJtex4L6rC7Y1rJdxUkOF0ZN1nhq2qhiJY+eqXXz9csqUBK7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBIQM+xpnYx29n4VUoF4MOt8Ee384Avfz5Efd3IRtsmBhMzwM
	Ug+8m6S6Hq47ZSQPhkSGzQHCKVrhpRrcQsjnNw5UlXX+Z1f4qRSzZtsi
X-Gm-Gg: ATEYQzzpX0SIoosbrqAAijfhjpSqLO7YvM57taGdLsYC1v4Urbt/3zqopj3WrYnx+7y
	C/XMpBnYc8J3VK1r+N1IWoAbfuJ8t21kMFR9Lva/MioK9WuV4fyj7AIe725oeojR3nOV7NEIAWx
	bss3K57iwGBZoS/Q02InrZ4wtbeYm20hwo9bnfHqKUY020dVRpYA/rWXshOq1qClw3CexTuMQcI
	GPVEtChfmPoZz84ZvB4p2Nwb02p7XUDJEnDr76HQg/3wKqOsDUtufDVwYmtRFr9CkGuhxYkdIRg
	Mfo0Cxgadd+zXge9NYrjyxgXtEC8lyv5zPu513LecTihMdUxsRz7A1u5++NFPSoZ4QxtXaQpgOL
	JgJrON7aCkAmofB/RH6uOehsX8kFKo032HYMkJbb4g8aj443sQmI5kibIRbp7X5VLp1zAPZcJHf
	ATPb1ZJ5i1MOYDAaHcTgoV2ZMQqT9DWEChycks/++7y7V1UkerV0ybu3BeHEjhzsfiViK0Ab9fA
	MYzIvbF3T2Gj8MzpheUWNA=
X-Received: by 2002:a05:6000:2c0d:b0:436:37a1:db58 with SMTP id ffacd0b85a97d-4396f18a6aemr23670493f8f.59.1771956466798;
        Tue, 24 Feb 2026 10:07:46 -0800 (PST)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm28362739f8f.6.2026.02.24.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:07:46 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 99E042FDD65E; Tue, 24 Feb 2026 19:07:45 +0100 (CET)
Date: Tue, 24 Feb 2026 19:07:45 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>,
	Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/4] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <aZ3o8RQehJDK_rcl@gandalf.schnuecks.de>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
 <20260220-tcp_rfc7323_retract_wnd_rfc-v1-1-904942561479@gmail.com>
 <20260223232636.1ead2b3e@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223232636.1ead2b3e@elisabeth>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[passt.top:url];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260624-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	NEURAL_SPAM(0.00)[0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gandalf.schnuecks.de:mid,passt.top:url,criu.org:url]
X-Rspamd-Queue-Id: 27D5818B4E3
X-Rspamd-Action: no action

Hi Stefano,

On Mon, Feb 23, 2026 at 11:26:40PM +0100, Stefano Brivio wrote:
> Hi Simon,
> 
> It all makes sense to me at a quick look, I have just some nits and one
> more substantial worry, below:
> 
> On Fri, 20 Feb 2026 00:55:14 +0100
> Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> 
> > From: Simon Baatz <gmbnomis@gmail.com>
> > 
> > By default, the Linux TCP implementation does not shrink the
> > advertised window (RFC 7323 calls this "window retraction") with the
> > following exceptions:
> > 
> > - When an incoming segment cannot be added due to the receive buffer
> >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> >   handling of extreme memory squeeze") a zero window will be
> >   advertised in this case. It turns out that reaching the required
> >   "memory pressure" is very easy when window scaling is in use. In the
> >   simplest case, sending a sufficient number of segments smaller than
> >   the scale factor to a receiver that does not read data is enough.
> > 
> >   Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") this
> >   happens much earlier than before, leading to regressions (the test
> >   suite of the Valkey project does not pass because of a TCP
> >   connection that is no longer bi-directional).
> 
> Ouch. By the way, that same commit helped us unveil an issue (at least
> in the sense of RFC 9293, 3.8.6) we fixed in passt:
> 
>   https://passt.top/passt/commit/?id=8d2f8c4d0fb58d6b2011e614bc7d7ff9dab406b3

This looks concerning: It seems as if just filling the advertised
window triggered the out of memory condition(?).  Am I right in
assuming that this happened with the original 1d2fbaad7cd8, not the
relaxed version of tcp_can_ingest() from f017c1f768b?

> 
> > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> >   allowing the tcp window to shrink") addressed the "eating memory"
> >   problem by introducing a sysctl knob that allows shrinking the
> >   window before running out of memory.
> > 
> > However, RFC 7323 does not only state that shrinking the window is
> > necessary in some cases, it also formulates requirements for TCP
> > implementations when doing so (Section 2.4).
> > 
> > This commit addresses the receiver-side requirements: After retracting
> > the window, the peer may have a snd_nxt that lies within a previously
> > advertised window but is now beyond the retracted window. This means
> > that all incoming segments (including pure ACKs) will be rejected
> > until the application happens to read enough data to let the peer's
> > snd_nxt be in window again (which may be never).
> > 
> > To comply with RFC 7323, the receiver MUST honor any segment that
> > would have been in window for any ACK sent by the receiver and, when
> > window scaling is in effect, SHOULD track the maximum window sequence
> > number it has advertised. This patch tracks that maximum window
> > sequence number throughout the connection and uses it in
> > tcp_sequence() when deciding whether a segment is acceptable.
> > Acceptability of data is not changed.
> > 
> > Fixes: 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze")
> > Fixes: b650d953cd39 ("tcp: enforce receive buffer memory limits by allowing the tcp window to shrink")
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  Documentation/networking/net_cachelines/tcp_sock.rst       |  1 +
> >  include/linux/tcp.h                                        |  1 +
> >  include/net/tcp.h                                          | 14 ++++++++++++++
> >  net/ipv4/tcp_fastopen.c                                    |  1 +
> >  net/ipv4/tcp_input.c                                       |  6 ++++--
> >  net/ipv4/tcp_minisocks.c                                   |  1 +
> >  net/ipv4/tcp_output.c                                      | 12 ++++++++++++
> >  .../selftests/net/packetdrill/tcp_rcv_big_endseq.pkt       |  2 +-
> >  8 files changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
> > index 563daea10d6c5c074f004cb1b8574f5392157abb..fecf61166a54ee2f64bcef5312c81dcc4aa9a124 100644
> > --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> > +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> > @@ -121,6 +121,7 @@ u64                           delivered_mstamp        read_write
> >  u32                           rate_delivered                              read_mostly         tcp_rate_gen
> >  u32                           rate_interval_us                            read_mostly         rate_delivered,rate_app_limited
> >  u32                           rcv_wnd                 read_write          read_mostly         tcp_select_window,tcp_receive_window,tcp_fast_path_check
> > +u32                           rcv_mwnd_seq            read_write                              tcp_select_window
> >  u32                           write_seq               read_write                              tcp_rate_check_app_limited,tcp_write_queue_empty,tcp_skb_entail,forced_push,tcp_mark_push
> >  u32                           notsent_lowat           read_mostly                             tcp_stream_memory_free
> >  u32                           pushed_seq              read_write                              tcp_mark_push,forced_push
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..5a943b12d4c050a980b4cf81635b9fa2f0036283 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -271,6 +271,7 @@ struct tcp_sock {
> >  	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
> >  	u32	mdev_us;	/* medium deviation			*/
> >  	u32	rtt_seq;	/* sequence number to update rttvar	*/
> > +	u32	rcv_mwnd_seq; /* Maximum window sequence number (RFC 7323, section 2.4) */
> 
> Nit: tab between ; and /* for consistency (I would personally prefer
> the comment style as you see on 'highest_sack' but I don't think it's
> enforced anymore).

Thanks, I missed that.
 
> Second nit: mentioning RFC 7323, section 2.4 could be a bit misleading
> here because the relevant paragraph there covers a very specific case of
> window retraction, caused by quantisation error from window scaling,
> which is not the most common case here. I couldn't quickly find a better
> reference though.

I agree, but there is a part that, I think, is more generally
applicable:

2.4.  Addressing Window Retraction

   [ specific window retraction case introduction removed ]
   ... Implementations MUST ensure that they handle a shrinking
   window, as specified in Section 4.2.2.16 of [RFC1122].

   For the receiver, this implies that:

   1)  The receiver MUST honor, as in window, any segment that would
       have been in window for any <ACK> sent by the receiver.

   2)  When window scaling is in effect, the receiver SHOULD track the
       actual maximum window sequence number (which is likely to be
       greater than the window announced by the most recent <ACK>, if
       more than one segment has arrived since the application consumed
       any data in the receive buffer).

There is no "When window scaling is in effect," on the first
requirement. And it "happens" to be implementable by the second
requirement (with or without window scaling).

I think an improvement could be to refer to the receiver requirements
specifically here.

> More importantly: do we need to restore this on a connection that's
> being dumped and recreated using TCP_REPAIR, or will things still work
> (even though sub-optimally) if we lose this value?
> 
> Other window values that *need* to be dumped and restored are currently
> available via TCP_REPAIR_WINDOW socket option, and they are listed in
> do_tcp_getsockopt(), net/ipv4/tcp.c:
> 
> 		opt.snd_wl1	= tp->snd_wl1;
> 		opt.snd_wnd	= tp->snd_wnd;
> 		opt.max_window	= tp->max_window;
> 		opt.rcv_wnd	= tp->rcv_wnd;
> 		opt.rcv_wup	= tp->rcv_wup;
> 
> CRIU uses it to checkpoint and restore established connections, and
> passt uses it to migrate them to a different host:
> 
>   https://criu.org/TCP_connection
> 
>   https://passt.top/passt/tree/tcp.c?id=02af38d4177550c086bae54246fc3aaa33ddc018#n3063
> 
> If it's strictly needed to preserve functionality, we would need to add
> it to struct tcp_repair_window, notify CRIU maintainers (or send them a
> patch), and add this in passt as well (I can take care of it).

Thanks for the pointer, I missed that tp->rcv_wnd update.  Could the
following happen when checkpointing/restoring?

1. A client app opens a connection and writes (blocking) a specific amount
   of data before doing any reads.  (Not very clever, but this is
   supposed to work; this is what caused the problem in the Valkey
   tests.)
2. The traffic pattern causes an out-of-memory condition for the
   receive buffer; we see the RWIN 0 segments that do not ack the
   last data segment(s).
3. TCP connection is checkpointed and restored (on the client side) without
   restoring rcv_mwnd_seq.
4. If the receive buffer is still full at the new location, the
   acceptable sequence numbers in the receive window will not change
   (restored client is still blocked on write) and we no longer have
   the larger max receive window -> the client's kernel will reject
   all incoming packets and the connection is stuck.

If this scenario is possible, I'd argue that rcv_mwnd_seq is
necessary.

> Strictly speaking, in case, this could be considered a breaking change
> for userspace, but I don't see how to avoid it, so I'd just make sure
> it doesn't impact users as TCP_REPAIR has just a couple of (known!)
> projects relying on it.
> 
> An alternative would be to have a special, initial value representing
> the fact that this value was lost, but it looks really annoying to not
> be able to use a u32 for it.

Do we need a dedicated value indicating that rcv_mwnd_seq is not
present, or is it enough to choose an initial rcv_mwnd_seq based on
the size of the struct passed?  Both seem doable to me:

Missing: Initialize rcv_mwnd_seq = rcv_wup + rcv_wnd (possibly
leading to the problem described above, of course)

Default value 0: Store how much we retracted the window, i.e. 
rcv_mwnd_seq - (rcv_wup + rcv_wnd). 0 means the window was not
retracted and could double as the "we don't know" value.

For the time being, I will just initialize rcv_mwnd_seq to rcv_wup +
rcv_wnd in tcp_repair_set_window() to keep status quo. Of course,
I am happy to discuss enhancements.
 
> Disregard all this if the correct value is not strictly needed for
> functionality, of course. I haven't tested things (not yet, at least).
> 
> >  	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
> >  	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
> >  	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..e1944d504823d5f8754d85bfbbf3c9630d2190ac 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -912,6 +912,20 @@ static inline u32 tcp_receive_window(const struct tcp_sock *tp)
> >  	return (u32) win;
> >  }
> >  
> > +/* Compute the maximum receive window we ever advertised.
> > + * Rcv_nxt can be after the window if our peer push more data
> 
> s/push/pushes/
> 
> s/Rcv_nxt/rcv_nxt/ (useful for grepping)

tcp_max_receive_window() is an adapted copy of
tcp_receive_window() above. But it makes sense to improve it.

> 
> > + * than the offered window.
> > + */
> > +static inline u32 tcp_max_receive_window(const struct tcp_sock *tp)
> > +{
> > +	s32 win = tp->rcv_mwnd_seq - tp->rcv_nxt;
> > +
> > +	if (win < 0)
> > +		win = 0;
> 
> I must be missing something but... if the sequence is about to wrap,
> we'll return 0 here. Is that intended?
> 
> Doing the subtraction unsigned would have looked more natural to me,
> but I didn't really think it through.

The substraction is unsigned and the outcome is interpreted as
signed. And as mentioned, it is copied with pride ;-)
 
> > +	return (u32) win;
> 
> Kernel coding style doesn't usually include a space between cast and
> identifier.

Yes, same reason as above and I will change it.


-- 
Simon Baatz <gmbnomis@gmail.com>

