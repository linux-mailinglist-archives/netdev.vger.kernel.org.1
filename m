Return-Path: <netdev+bounces-47802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFE7EB6AC
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C4281218
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472117D8;
	Tue, 14 Nov 2023 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrew.cmu.edu header.i=@andrew.cmu.edu header.b="ZI7fcifa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F017992
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:59:55 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830BF5
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:59:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507975d34e8so8557994e87.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021; t=1699988391; x=1700593191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNgEn5MHOBLKcKp35GgG7HkD8xuD2aBJCnBlK/ITIEE=;
        b=ZI7fcifaOt3rdJ/+nMVtCfM4q7M23qUAXgW0nd/HiOWoTHqr41nKossYOePXpIzpl9
         NV5LM0cCo84Tgc1sgrXvKrQrr2SwxojQHugcXqXgQlpVkso611T//+v5zYqxwDDLwQj1
         VueQyQGi6Qae0PDU5csZzIMKBhcO8zOY+6RuHQM6bKL5lRnnTCyl6F54YYyzPq6xsLat
         A8dwSJMQdqtN2uG0pKouzRwd+4c+2TblCyy1NdV0CLM1ec6JbRy5uEDycBLWpg3Lz3J/
         p6GPZ9En7ZObH29+57S6Vs31sSFKoyV+bVLlnKFBV8hgLhrUjlVUdvf41zWeu+LmERP+
         3pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988391; x=1700593191;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNgEn5MHOBLKcKp35GgG7HkD8xuD2aBJCnBlK/ITIEE=;
        b=nkYmsmOF2/2HCplFfSH+4lKAIj2XB7/FkGSDdd30HXlqhHEUFFfMCFNUMhUBgQ6ysd
         4rXTHwcDD0YsT/XttR+D/rrnzOCwljPJxcqfmD8gzTFJssSI/Gli++RGamvSrZQT2EFB
         HSzjojNO5rl/ZzI+DKmE73URt/GqxT/DYRnYuqF++ky4Arif5yrkKBjXcp5EMruc9uAC
         LcQoC9WHvS/hLE/DJAhmOrzcTfFql5fhBFIFBuq5Wm/wgV/AFf28iFg6i2yUf6rgI4y8
         3kCKY98Z/25CHFzdmO6C+YlKouCfHQjAf8bkY+Lq6ISwvtlH8wSQ+jok+Sjjuld7uUFP
         Nh1w==
X-Gm-Message-State: AOJu0YzTvbuG3dCUhX9UhY48dOsk/4u0AcziPAtmWh/6IwOr1NG1k4Hk
	Ivq+Kwv0C/IZeKh3tPlcr8DRvFwsZtvLfDLg+/4zB7h7pgZTc0gcK2c=
X-Google-Smtp-Source: AGHT+IFz1ZIHlASEpMGn1O7yGfXayIYT78/XWws1I9SQxR0ijsZAfoiJp1QI2JCy10NxLvOun7X+dGMiop9pxajPkbE=
X-Received: by 2002:a05:6512:238b:b0:50a:7575:1339 with SMTP id
 c11-20020a056512238b00b0050a75751339mr8100703lfv.18.1699988391438; Tue, 14
 Nov 2023 10:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Agarwal <anupa@andrew.cmu.edu>
Date: Tue, 14 Nov 2023 13:59:15 -0500
Message-ID: <CAFYr1XM_UGejZdnUYYBQomq0jBDMpV+HWCd1ZDorD=xOGXq4CQ@mail.gmail.com>
Subject: Potential bug in linux TCP pacing implementation
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

Sorry for the duplicate email. I am sending again as I got an
automated response from netdev@vger.kernel.org that my email was
rejected because of using HTML formatting. I have resent a plain text
version. Hopefully this email goes through.

I saw that you are the maintainer for the linux networking TCP stack
(https://www.kernel.org/doc/linux/MAINTAINERS), and wanted to report a
potential bug. Please let me know if I should be reaching out to
someone else or using some other method to report.

Based on my understanding there is a bug in the kernel's pacing
implementation. It does not faithfully follow the pacing rate set by
the congestion control algorithm (CCA).

Description:
For enforcing pacing, I think the kernel computes "tcp_wstamp_ns" or
the time to deliver the next packet. This computation is only done
after transmission of packets "tcp_update_skb_after_send" in
"net/ipv4/tcp_output.c". However, the rate, i.e., "sk_pacing_rate" can
be updated when packets are received (e.g., when the CCA gets a
"rate_sample" for an ACK). As a result if the rate is changed by the
CCA frequently, then the kernel uses a stale pacing value.

Example:
For a concrete example, say the pacing rate is 1 pkt per second at
t=0, and a packet was just transmitted at t=0, and the tcp_wstamp_ns
is then set to  t=1 sec. Now say an ACK arrived at t=1us and caused
the CCA to update rate to 100 pkts per second. The next packet could
then be sent at 1us + 0.01s. But since tcp_wstamp_ns is set to 1 sec.
So roughly 100 pkts worth of transmission opportunity is lost.

Thoughts:
I guess the goal of the kernel pacing is to enforce an upper bound on
transmission rate (or lower bound on inter-send time), rather than
follow the "sk_pacing_rate" as a transmission rate directly. In that
sense it is not a bug, i.e., the time between sends is never shorter
than inverse sk_pacing_rate. But if sk_pacing_rate is changed
frequently by large enough magnitudes, the time between sends can be
much longer than the inverse pacing rate. Due to not incorporating all
updates to "sk_pacing_rate", the kernel is very conservative and
misses many send opportunities.

Why this matters:
I was implementing a rate based CCA that does not use cwnd at all.
There were cases when I had to restrict inflight and would temporarily
set sk_pacing_rate close to zero. When I reset the sk_pacing_rate, the
kernel does not start using this rate for a long time as it has cached
the time to next send using the "close to zero" rate. Rate based CCAs
are more robust to jitter in the network. To me it seems useful to
actually use pacing rate as transmission rate instead of just an upper
bound on transmission rate. Fundamentally by setting a rate, a CCA can
implement any tx behavior, whereas cwnd limits the possible behaviors.
Even if folks disagree with this and want to interpret pacing rate as
an upper bound on tx rate rather than tx rate directly, I think the
enforcement can still be modified to avoid this bug and follow
sk_pacing_rate more closely.

Potential fix:
// Update credit whenever (1) sk_pacing_rate is changed, and (2)
before checking if transmission is allowed by pacing.
credit_in_bytes = last_sk_pacing_rate * (now - last_credit_update)
last_credit_update = now
last_sk_pacing_rate = sk_pacing_rate
// The idea is that last_sk_pacing_rate was set by the CCA for the
time interval [last_credit_update, now). And we integrate (sum up)
this rate over the interval to computing credits.
// I think this is also robust to OS jitter as credits increase even
for any intervals missed due to scheduling delays.

// To check if it is ok to send pkt due to pacing, one can just check
if (sent_till_now + pkt_size <= credit_in_bytes)

Please let me know if you have additional thoughts/feedback.

Thanks,
Anup

PhD Student in CS at CMU
https://www.cs.cmu.edu/~anupa/

