Return-Path: <netdev+bounces-47803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650CC7EB6C4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC42B209B3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1158717D8;
	Tue, 14 Nov 2023 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrX+g084"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF81FD3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:09:19 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90BF4
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:09:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so1902a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699988956; x=1700593756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMhZhxj9GWSVyzmmYjvAklSYcqYI+VSCH3sYmo0njbg=;
        b=rrX+g084MlkTqwwTZ1xvX3ZDxnj2mUyUWehFlHQzrSwpCHSvuEJPh1lZA5xBJvuOuX
         PRFOFa3IuJ6pW3glvn9gu6thD+ZPkUOtY4chvbltsplXsZr96GL3efDQ5Vel9JOsJFcb
         riOULrBBvUJiNhv11gCt4yh3ULcsNPOM9/yCQzoPe2if1Zyz//GQdF8YCJ3AWbOXoHDt
         v/n/gZyoxy9U5A2yffwQCWCY3l3W3m0h/h/ax67BtSjiwkZfkYfj6L91Il6nsEDmtAMb
         ANq5dHNpxmq97MILpiDqM1mBXu3CT2/N7grH5Lg3WelYrXloBudGLZyLfVI+uADOba8J
         73kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988956; x=1700593756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMhZhxj9GWSVyzmmYjvAklSYcqYI+VSCH3sYmo0njbg=;
        b=ucr+A8Ta10CokVI3vxUTNHTD5kO8bOgtP5JbCz+dM1JNcMdpu7lzLKK+0Zxmc71lHN
         q4OeoYFXRLYdYNI95CBZzdo0in/3uKAshV0mBvfMA372pE/OzfdUt5SitQyEWV2gsoAV
         2rARoM5PSCGbEadTvG/OjALMyry8GIe4wmuGBjGBzFT7J+svdlRgyAgt61AK3i1E91xJ
         K3N4PAAK16MjewAjlysp4P/9zVsSADH9yO1BHeP+xl/Pq/Q7jvuzvbz3mDrstlx0pqI/
         KP/htrqi/qhRUpmrYTlPblBex9+SpvhFOedOOaG5aWCgu02poC1vQAkRbgfQb8Tkd+/C
         AKEg==
X-Gm-Message-State: AOJu0Yzbhfh11WGq/uJCQTrtYO6zjo718IXzkzF8wxRpS8Dal/kovFOa
	1ifOL9WUZug+ZXaKwW/dRtjb+WIUHpgAJtwQJfSbqVLlPHO87wk7JD4=
X-Google-Smtp-Source: AGHT+IGvNrcGeJdNSqL7F2roS50cvcWensFlP8KNw5x412VNrZW749jTCQ4qhNKQs2sXr/A9YcpETXz0rCqg0/D0VhU=
X-Received: by 2002:a05:6402:e95:b0:544:f741:62f4 with SMTP id
 h21-20020a0564020e9500b00544f74162f4mr30134eda.0.1699988955795; Tue, 14 Nov
 2023 11:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
In-Reply-To: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Nov 2023 20:09:01 +0100
Message-ID: <CANn89iKhboBst+Jx2bjF6xvi1UALnxwC+pv-VFaL+82r_XQ9Hg@mail.gmail.com>
Subject: Re: Potential bug in linux TCP pacing implementation
To: Anup Agarwal <anupa@andrew.cmu.edu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:59=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.edu>=
 wrote:
>
> Hi Eric,
>
> Sorry for the duplicate email. I am sending again as I got an
> automated response from netdev@vger.kernel.org that my email was
> rejected because of using HTML formatting. I have resent a plain text
> version. Hopefully this email goes through.
>
> I saw that you are the maintainer for the linux networking TCP stack
> (https://www.kernel.org/doc/linux/MAINTAINERS), and wanted to report a
> potential bug. Please let me know if I should be reaching out to
> someone else or using some other method to report.
>
> Based on my understanding there is a bug in the kernel's pacing
> implementation. It does not faithfully follow the pacing rate set by
> the congestion control algorithm (CCA).
>
> Description:
> For enforcing pacing, I think the kernel computes "tcp_wstamp_ns" or
> the time to deliver the next packet. This computation is only done
> after transmission of packets "tcp_update_skb_after_send" in
> "net/ipv4/tcp_output.c". However, the rate, i.e., "sk_pacing_rate" can
> be updated when packets are received (e.g., when the CCA gets a
> "rate_sample" for an ACK). As a result if the rate is changed by the
> CCA frequently, then the kernel uses a stale pacing value.
>
> Example:
> For a concrete example, say the pacing rate is 1 pkt per second at
> t=3D0, and a packet was just transmitted at t=3D0, and the tcp_wstamp_ns
> is then set to  t=3D1 sec. Now say an ACK arrived at t=3D1us and caused
> the CCA to update rate to 100 pkts per second. The next packet could
> then be sent at 1us + 0.01s. But since tcp_wstamp_ns is set to 1 sec.
> So roughly 100 pkts worth of transmission opportunity is lost.
>
> Thoughts:
> I guess the goal of the kernel pacing is to enforce an upper bound on
> transmission rate (or lower bound on inter-send time), rather than
> follow the "sk_pacing_rate" as a transmission rate directly. In that
> sense it is not a bug, i.e., the time between sends is never shorter
> than inverse sk_pacing_rate. But if sk_pacing_rate is changed
> frequently by large enough magnitudes, the time between sends can be
> much longer than the inverse pacing rate. Due to not incorporating all
> updates to "sk_pacing_rate", the kernel is very conservative and
> misses many send opportunities.
>
> Why this matters:
> I was implementing a rate based CCA that does not use cwnd at all.
> There were cases when I had to restrict inflight and would temporarily
> set sk_pacing_rate close to zero. When I reset the sk_pacing_rate, the
> kernel does not start using this rate for a long time as it has cached
> the time to next send using the "close to zero" rate. Rate based CCAs
> are more robust to jitter in the network. To me it seems useful to
> actually use pacing rate as transmission rate instead of just an upper
> bound on transmission rate. Fundamentally by setting a rate, a CCA can
> implement any tx behavior, whereas cwnd limits the possible behaviors.
> Even if folks disagree with this and want to interpret pacing rate as
> an upper bound on tx rate rather than tx rate directly, I think the
> enforcement can still be modified to avoid this bug and follow
> sk_pacing_rate more closely.
>
> Potential fix:
> // Update credit whenever (1) sk_pacing_rate is changed, and (2)
> before checking if transmission is allowed by pacing.
> credit_in_bytes =3D last_sk_pacing_rate * (now - last_credit_update)
> last_credit_update =3D now
> last_sk_pacing_rate =3D sk_pacing_rate
> // The idea is that last_sk_pacing_rate was set by the CCA for the
> time interval [last_credit_update, now). And we integrate (sum up)
> this rate over the interval to computing credits.
> // I think this is also robust to OS jitter as credits increase even
> for any intervals missed due to scheduling delays.
>
> // To check if it is ok to send pkt due to pacing, one can just check
> if (sent_till_now + pkt_size <=3D credit_in_bytes)
>
> Please let me know if you have additional thoughts/feedback.

This was a conscious choice really. More state in TCP socket (or in
FQ) means higher costs.

For conventional CC, difference between pacing P1 and P2, and usual
packet sizes (typically 1ms of airtime)
make the difference pretty small in practice.

Also, pacing is offloaded (either in FQ qdisc, or in timer wheel on
some NIC hardware).

With EDT  model, you probably can implement whatever schem you prefer
in your CC module, storing extra state in the CC private state.

