Return-Path: <netdev+bounces-251454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILORJ3JYcGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:39:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14317511B4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D9DD7E748D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABED40F8FA;
	Tue, 20 Jan 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OvX2ojV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E553D6484
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907101; cv=pass; b=NJpa0gNpXuIGXyUKTITUfSJnc+XTXEOPV+3pJieUL7Mz8EfVGiUmoWKTMQ3fYapbKeV/bZa0Ruco3uF5wQuwYB8uyJwNXbn5NIOfkUkslyMZSm8SGO43skajoVW3hJoeWwW5hpz29m5l1LVeVInKDMchXWHLAYWPeG9o5cSRGBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907101; c=relaxed/simple;
	bh=cnNo9W12NhCz5DB49rDqOpnrfJrsY5xjkCHj5l6IZJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/S9wuv8WBUEsPyVac0HZmseCrO63XBCXMUMDezh/NGgoBYKySY59z5Mv3EAQ6SaezHj45Gj86gwJYsdTGo+hLoSGT9tXqb0ghMlrQ/8djuQ0SkrAEa/mrsf5DVXE38HHkwGqRv6Etc9ttvJBhDenNWlnd7hKHPD4PBGi0UBFro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OvX2ojV; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-501506f448bso29780571cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907099; cv=none;
        d=google.com; s=arc-20240605;
        b=h/FEbdfPlfGIJJrbTUkKj7jr3LIUR83yEMBmWxV84qqjR9kjCrJeUVdjFY1WZBuImY
         zXzxcgl2p3aURk57nDuSjNP8GG1GboU2dftw4/Y42LJtZDC8cSqeDaFow7EVCHbz2Je+
         N7LPF0dPgxlbBnhy2vibbNbBJzrFwKnpiJ93vAYrrTcoOPusnjpJGJBzTs8pdPWQRGxq
         0zLnJAVezChmEFGyq/S7dl2NL4qwDm6ARNh32BTP+avcjbMNdfFggnp9MIXA0O9eWay5
         vSq5LZxoIhKlpRo12ZrKnFPwv07OQVUsUqZnF7C3VZLrfDMWhsMmoh3DN6K3uV/ee9eM
         P0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        fh=55UK7hxkFgnhLXMRzceikdk6mKqw0P0Fc7O+TjpS0pk=;
        b=hBYm6ry9GKUpmv9oL9uxfRN9br00S8nyT0jiJ0RqlWDwvGp2M9RYNSy924VEsy2sGq
         zwPLRhvFKvp4uWGO3ROMP1zFKup+qGx2tt98gVat8r8xKO4ahUewK9yfangAeVMkQEnj
         CtwNbwD/RZGnCeJpt/8oBqq4E1qONk5P4B/96ngSni/+sh+QHCn5lWb/Eo8NAwyZD1wP
         p2Wq6wsbfgZV45l0QVI8hrfF00doKjiS7DW0VYutt7fPVKhx4wqcG9QCCAUbvWIhq0bv
         OQgPlR8n3FTICYkdzTqUjmkEc6JqWBLL6X9DXXaol6mgZpGkcTohN2A+6uixiPHTAxEE
         7BjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907099; x=1769511899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        b=0OvX2ojV+3vqnvaV4xrU6+G21Qtn1xnc8WGr/gIJe+4bn+fcki/sjEKNHo8NMJyx47
         lO6rtKPsXDPBNdKbbIR52kzsu4CqavaVN41ag7XrJoBrk3KyeKRE6ciMwQmlnC37eYwk
         hxASpdqgH7dcK0K3GUIS3ZrhPc6IfRQVb9/kRU9wV11pCQobB3Vhc2TOuWulkikpYZNr
         +5VboIYew+Rpj3rQglzEGBaJnMgGWLkcbEoQiXC867qs7S47Gi/WTsA/Ywb6cyCJf2jU
         m+X5kYYAzc/ZpAiryj+Z+Gf8PfSpC8Iq4s+ANsF0FI5ZdNZ+CsBWJAgoSxfljAAM8MQP
         F+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907099; x=1769511899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KC9nK0KpQPdmvTA7SrKRg+ar3wUw4irfinZL9hXebI=;
        b=Sf9u4EaRhF5W/e/cXZlsDTsHr6L6oeOUxwtZu6POWx5GBbZYDXluG7YSIkHp1R6t2e
         ANuRXG7hFJpejDY/90peMr065WnAbvap7lV+sIxwvezM3ymeVPB2x2hyxDmteL5h0Z7K
         K7xWXi2WRMCEMoSYvc4R0wlVUEnCQX6UzD4frhSzxbso6cW9ODzCBJtVlXOnkjzEQfbp
         H+cC6bkg9ibVUig1YFDrk8OgS1ZGQz+41Y1nOGHQztGDzwPPxZZYnpKltcx56ABh6VTf
         vBpaqV60pCTPqxLMRCt9SmZcJRQSKV+9MBV5qIynTDFanvxDw3jrvj67zwT3hjrJvsEN
         A/DA==
X-Forwarded-Encrypted: i=1; AJvYcCW24EjWBK8jRyCbXas/Ct824mNKhbkovTFzj9LfZhFerfYMrvV4Nr6sKL4FYtNVPrVkxrtrNXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt31JaAy/xvDVHCaCu1Z3duerrfLFculHyCWmULAQbYnM0cSV8
	6kb1OxF/xKUxa+HRUSF7go9RXvGzz+nb8qwSOwwB66SwKitr93/8CUlASbJX3mA32xtP0wIP7Yo
	xCTp9k7xWw0RxoqUsaHcBV09l1chkFcpBc1I3jBat
X-Gm-Gg: AY/fxX4UwqJ28lXq3Xw8cn/mx6xWW46IONZrIoYNDVm/fGivGB9CgCuAmYMItoMdcm4
	3OKXycadTST6595j+GCShcdwLjM1LvkhNiZ+SicdgxBPq2NVi/VRJ2hFAxRYpGz2ZGVVEpA6GaY
	A3Bj/rJXLGc2qSXIRbfjF1KFsPvJiIPwKewghYS4qWgYeCflY7r+5lrknKV4uqJQIw81b0QaC6m
	TnlzCcKeybRs7qh2xnFa+n1Wj3TCaUGr/cxgzIbQR2e/xrnUFCVvK7f1P7up9KAJ5x8a1U=
X-Received: by 2002:a05:622a:148:b0:4f3:5961:3208 with SMTP id
 d75a77b69052e-502d82776d6mr12850331cf.12.1768907098103; Tue, 20 Jan 2026
 03:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:04:47 +0100
X-Gm-Features: AZwV_Qgu9ZDw1Q07OvyxlnkIP9uze425ltlSjgpCGKeRZRntsHDU01ieZ5kjIGg
Message-ID: <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-251454-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ietf.org:url]
X-Rspamd-Queue-Id: 14317511B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
> AccECN mode MUST NOT set ECT on any packet for the rest of the connection=
,
> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
> with (AE,CWR,ECE) =3D (0,0,0) during the handshake.
>
> In addition, a host in AccECN mode that is feeding back the IP-ECN
> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
> latest valid SYN or acceptable SYN/ACK to arrive.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v8:
> - Add new helper function tcp_accecn_ace_fail_send_set_retrans()
>
> v6:
> - Do not cast const struct request_sock into struct request_sock
> - Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
> ---
>  include/net/tcp_ecn.h           |  7 +++++++
>  net/ipv4/inet_connection_sock.c |  3 +++
>  net/ipv4/tcp_input.c            |  2 ++
>  net/ipv4/tcp_minisocks.c        | 36 ++++++++++++++++++++++++---------
>  net/ipv4/tcp_output.c           |  3 ++-
>  net/ipv4/tcp_timer.c            |  2 ++
>  6 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 796c613b5ef3..f5e1f6b1bec3 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -97,6 +97,13 @@ static inline void tcp_accecn_fail_mode_set(struct tcp=
_sock *tp, u8 mode)
>         tp->accecn_fail_mode |=3D mode;
>  }
>
> +static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_s=
ock *req,
> +                                                       struct tcp_sock *=
tp)
> +{
> +       if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +               tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
> +}
> +
>  #define TCP_ACCECN_OPT_NOT_SEEN                0x0
>  #define TCP_ACCECN_OPT_EMPTY_SEEN      0x1
>  #define TCP_ACCECN_OPT_COUNTER_SEEN    0x2
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 97d57c52b9ad..9d16cb9c3db4 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -20,6 +20,7 @@
>  #include <net/tcp_states.h>
>  #include <net/xfrm.h>
>  #include <net/tcp.h>
> +#include <net/tcp_ecn.h>
>  #include <net/sock_reuseport.h>
>  #include <net/addrconf.h>
>
> @@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>             (!resend ||
>              !tcp_rtx_synack(sk_listener, req) ||
>              inet_rsk(req)->acked)) {
> +               tcp_accecn_ace_fail_send_set_retrans(req,
> +                                                    tcp_sk(sk_listener))=
;


Ouch.

I think you missed the fact that a listener is shared by many SYN_RECV requ=
ests.

Consider it as read-only here.

