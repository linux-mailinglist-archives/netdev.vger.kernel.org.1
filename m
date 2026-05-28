Return-Path: <netdev+bounces-292498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM8PF5SRF2oUJggAu9opvQ
	(envelope-from <netdev+bounces-292498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:51:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DE5EB6B1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 933C93006B60
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5A21ABBB;
	Thu, 28 May 2026 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CscUn77h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24171F5858
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929488; cv=pass; b=msI+gyDxzr0nS6oKc/wdG9eJJx9CXO5HnacIwmxLV6lGqtVtygxnYrWGcsv2dvA+vHcBIv4hW3PuDYAWOlbtJhZt/5LlhwcTMcECjmHaejHLMF03ELz1lYPF9TiR3w0OFSk7m8RP7hnlOOVq0YDruO/BtY1KqzA7ARez5l/Rfko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929488; c=relaxed/simple;
	bh=a6f2SLT1GPJi4izrfMemOEuzQDyU010ja+PV5H2i20k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZtXDtusfdJDXNDukTwTISO8Z5KAoNycZcaOhpJmoNr0xXINv60amolQWl77NiRsjDMiobaKFkixLN6OIhl0tyuQ1EB1bJMVWe17ENFKf/5Y/LnlWSV1UvWOF0Z+pjs3OchQEYSETgmo+sj92x8OnPLqKDQwJ5OMpqcXsGCqX1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CscUn77h; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a746f9c092so16683003e87.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929485; cv=none;
        d=google.com; s=arc-20240605;
        b=TFEUWIBsgDsnZTZFdyjFRIXlKCDpbsOsTltUSBNtAM0xxfAiWAxnmdkaR4oq3fmlX/
         FzKYsQ8L3PaktR4FULlxtnGS7F+P6HyT7N+XpZzqcQ8RBKTaYyCIz63TebkV8mXQwtwq
         ulWT20PhIWNScUGueJQLgTMM3Vi+g+yrHfxFsjDpBhPHR19ndWha00SOrQemXTicqVpT
         1zQpJv+Nse2ucO4isGhIHPAHJbztmz0gpvLrLaDRicS1r07ehBzMUj7vpKmc6isfDkSx
         EBsDWFN4ZDuyFh9oJVvVe00HcA0pMxzDFWsIqxBuTJJPkpGAd4qMKw3g3rpz+OpdJ7tq
         nNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        fh=e5vULpWN2BSRWVqyQ5Y2TTLa6kMgxhfe4R8SRrs6IS0=;
        b=G8qA5ysMyq68z2jAx6FA6d6Dxy4PzQqY5ypruzDUTRtsdRWihnd659oYyBiGBjDVJF
         13zK1l5OZpim4XDOJ7hgmb4lAfZc6MpeSFoOhto3PQhKsUh3hmPbFyhREzyoJ9AKKuCa
         Lo/+7Km/eDmzX6lPsXct2OBieowG/vySjOvPx2byb1FXHfmh1ope4OacDJYoeuHZ3VBP
         /vUWh/L9Iyf7Dl2QqHvpZtrVjpB/n3AAP4OTYD5jPSbFIkS9LfRf1DhM6d92llYjxn70
         QK1yQNO4UAJK7VWQb1LtjtOCd7WHlGV2VRX2Pwuvz9lojlSa+13LCci+LdEtpmIya/wd
         fKCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929485; x=1780534285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        b=CscUn77hoZkAoEysSp4YdBSEId4tEW2O+KLCappTNSowCOBEXck3zY2IgUk81tySbG
         Vs7TKjIGGFRaKwly23CAMJopm6uvfbfE2Kh5vO5pJxX2jFyMPz+UmRoZB0KAJO2jQ7qu
         Jp3b6RfEwDFlTw2BvbsqulwHlM0noYeb7gnJRI8oCuhWQ9AJdlnN7mcJpwfTu+4WsLCw
         jvykHCTWlbdofPzxDJtpGCiMw+E8YIQuUHFl90g6VvLWAYB9QnDTOueEcdgdRtVvJywG
         9zJIznSDu9BrY2SJnPgRHuMh39QHs39LIjUgbFlZN7Grf1oE912LSAI7OKlOPFKBUzNA
         GRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929485; x=1780534285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9cHiZnFP+maioEiAfwsmvGD3ZcMnOA0PgSE42ZM/Ag=;
        b=SrbV6uAcjndKUBNOR2MldNwMB03xf59LDHIGIr5S/uXs8ptMBMZSJmXLearkucBVbb
         kGs39Q5xthGIL0/qZN1zUaagCqAiiHq5aJw2fv+K9eU4JnxWcS6ciqhH94/TM2RLMylp
         WBuI+O8Jt7QRjnmQVpPOsQG7hk57a2EzSgQKcPm9SaUxtLH3hK3g34JoAayNw/R9k2GB
         F8diYJ23tSet54v4YeXnyk/zE3CfVSkiaxRdR1CqDkJBroVQy4p/D2EX2kcZgcbfe8pr
         2RBQRHpY8yZdfA7jJjrQ3iPZ8xe9UHQmkyEkQL967v0pR9a1BGOgvjhjuFD4muooPpWA
         mjxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hMOrQszHNQHnQF4G09wM8CrPcLqeR7uHWvXJJ/g36j2ofzx2J2KJw9WulbXo8VgIsrIXHxaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQkarcQO3V4Mhk76FXEFEA/qU2fRbDxxKMUEE8lCYIk1B+crt
	VN4JZh7WCIDL8KMfQ1lM1YbbjRrucWS+oeeqmnhKhq6LuZURBRu2y21sgwmkP0A+dLCmA5Rx+xJ
	u3tyhtpIzbk1DKxeoISdhbanpxcf5ZNU=
X-Gm-Gg: Acq92OHjfo57IuoTagGiwHuzFclv/QfuKuBZr3dZd1czCIJXaWQvs6hm+L/gVoTjXBe
	a3oj79Dz7GHI7nxxUnlWyV2gZ9c0w/z6Fe4HmZdvUZmmG3TJCS0ciJL9WwCoc7IBHVFiAUK/d7a
	Kz8Ny8jmBvcCoyFrFZgQZOfFqsp5u9WQcAUZ9mBqvOzsx9yozHZBIU5Ix10/ftPdgInLWlofddR
	Spx9q8Be3X7Nt/GofbqnHZVCK+poQOs5GK6ECPrDH+aPCPjy/0oN6EoTTjQ4+y2R8MCEARfdB+7
	2rSIJocLn1XHP9E0Znw3rEp/WHWnxW4ElWroFRqGD8fmcwyLnw==
X-Received: by 2002:ac2:5606:0:b0:5a8:6ee0:ff40 with SMTP id
 2adb3069b0e04-5aa322c9b4fmr4671981e87.7.1779929484779; Wed, 27 May 2026
 17:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
In-Reply-To: <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:50:45 +0800
X-Gm-Features: AVHnY4KU2z4siULEeXOFZcRcPUBdcPXCf7bV3t0DxKEV9UNwpR0ELkShqU5KC6w
Message-ID: <CAL+tcoCQRzWJEh9YM=XjO_OUAhiYyznvQvn-z8RZ80eGTU2tgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292498-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 013DE5EB6B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 11:47=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> > [PATCH net-next v2 0/6] bpf-timestamp: support rx side
>
> nit: This should target to bpf-next.

Fair enough. Will rebase.

>
>
> On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Previously the series[1] has already supported tx side for BPF
> > timestamping, now it's time to support rx side.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3D68b92ac494eb
> >
> > ---
> > v2
> > Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxin=
g@gmail.com/
> > 1. support tcp rx zc case (Stan)
> > 2. add if-statements for ASSERT_TRUE (sashiko)
> >
> >
> > Jason Xing (6):
> >   bpf: Add bpf_ktime_get_real_ns() kfunc
> >   net: export sock_disable_timestamp() declaration
> >   bpf: support bpf_setsockopt for bpf timestamping rx feature
> >   bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
> >   bpf: enable bpf timestamping rx in TCP layer
> >   selftests/bpf: Add RX latency tests for bpf timestamping
> >
> >  include/net/sock.h                            | 12 +++-
> >  include/uapi/linux/bpf.h                      | 10 ++-
> >  kernel/bpf/helpers.c                          |  6 ++
> >  net/core/filter.c                             |  8 +++
> >  net/core/sock.c                               | 20 +++++-
> >  net/ipv4/tcp.c                                | 10 +++
> >  tools/include/uapi/linux/bpf.h                |  5 ++
> >  .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
> >  .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
> >  9 files changed, 172 insertions(+), 5 deletions(-)
> >
> > --
> > 2.43.7
> >

