Return-Path: <netdev+bounces-262202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDUSLeleo2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:32:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B91C9230
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81AA132A64DE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA2377005;
	Sat, 28 Feb 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUZ6baVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EA3E0C58
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305528; cv=pass; b=t77ghVzFng5af9qYmlNuX37+k7W7IbyoxunTa0HbeIua2HR3BKtB5Ms9cVBPthtbcIzjG+/D3vD7W6fRLzFwDvuCpzjqqenC+ZJxmWFAh2FQhOyEeTWhs5LCoLrt4DlxnSoNd80vg7yq+dPs3pyyvww2IXk0k32AJnZ+Up6UZ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305528; c=relaxed/simple;
	bh=fiN5CWtw0AZIqy9DAZrjHsFKIp8GX/d/NebGzeRhpDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koviDvRgJFm+CEZzPgun336jrQpv4v9KLyF9dYwDqooqOul8agXZZ1lRZUaZjAtl+1AHngM2M4xDgSPDOV2xMdUJ5vG3CccA5q3mtTZ7OXZa1btQ2Azq0mE+0IazGXUIJiUnyZccPi0uCYxgsFKI/HZIiOfOUAN0xasElLNMl+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUZ6baVM; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-127423bea4bso2539387c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:05:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772305526; cv=none;
        d=google.com; s=arc-20240605;
        b=eWaoIfLcHlSuVZdkuLxAKU1LQNoTi5jy+sk3qzow9W9EQ61liEI3GGhRqSvhcBy3TC
         qIRaALaKws4ExfSUjxI+HWTYJxBabBIxbOoaUvCT9ivVz9J4KjjlimNXhNwkhB1ggfss
         pncl9PyeDbWfkIYr4jQ9pwzwIis0S4qk+JTir9fJpJLf3fCuqGE9IGu64VNpPbINWc77
         BzbX+FBgk/Am2qO4CCfiFZK/ky1e8RgzGtbfzRUxqGZm0m1ISwdUgCqDXUKm3Zomon1v
         48zOXUwRylirjKUlPRdIO9E8EYCh8dGQ20hKqed+X18sFb/DbnXnLgys9sLO5xqjlcTW
         Qr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQXjfoY3SWqMu5Fd/94Odd8mnh+jVMRig1jF1GXJJAA=;
        fh=ow9NeavIgt0ud+S/tOFHEhxoS73Tn0Sb/S2CJqffnxQ=;
        b=XMpLJglK957dYD3STbTezzT6L39EcGHsZFEhyvW38kcRrvxBXeOxyy3O0tcd2DbSlG
         JMRzepnXMHfmI7VCjBVfmETTMULS1h/8oqPVa3l4NIkScfE9L5JInTdtjr0xiwMtyFPM
         0AIev0oHdqWoY353owdksHoU17c9gdNqqfj23eEcwc+z0lgm58mQI6wRVEjbwp7YbDxY
         bFE6vfCU26UDMHA/REbW3kKSL9iVr4JRhRx91aEqfWt0FCiIvKts8ZpB9ccfhOdBouGW
         7ZRiYU+d/Q5aq/0x91MjYc0RAF6BliZR/HAz9Vox8AiapJzjG0lDbkZ/btpHV+v+d4Xi
         68cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772305526; x=1772910326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQXjfoY3SWqMu5Fd/94Odd8mnh+jVMRig1jF1GXJJAA=;
        b=AUZ6baVMqMN1D9gS5z8QAioStQ4ZusTzGDxyUnN6zhCzYmo4ORjRXHYjKjJGC2kdLL
         K8BpeTmp+10oritBF/EIjEbzojy18F344HACK/FVeDd8QG4cb3IWHDu0jMTCn1Tr9+O3
         EiAa/shOdKl8+Jlv5UYD9BnOw2lshpZP/E+e1jBCqQQy2v7KhjMzcHNeMdB5y691Mx+Y
         mm2GM8BJ4afXEfGJWr9IcmPTe9vffa4u69WWfrhl/f0vdsTtPF7znbny/JhaR9+4bJ13
         bEiiZIJvLHq3NCwWuz/zpack4pjQdZbqQD4jkcnbOu8zzp1rSKUDeVM9rSOjRVBd/rpc
         6GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305526; x=1772910326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQXjfoY3SWqMu5Fd/94Odd8mnh+jVMRig1jF1GXJJAA=;
        b=RGcJTek1NK2lZiExpCimLMX3ZFh8CWbIwPEt7g2awjwoQTjATqmEhjouLFxzmGgt4W
         TgTCEA1BammcFvDuO098KMEuV07w7QgzL4FLeB5vBd3DKmWhpcJTQC5O9W1LxGORj8b2
         8wAU8l+VlmKNtk6j+gVMz9LT9r9GmlFAO/BXxbbV64ZnEF3qTR74IZDJBgMLAdpACzqd
         Ky0zuu4lhDiB6h+Cn50YbfTO7Y0we9Iix/DO8ZhcUIEz9sYw8QJloPl5FlyoOvhaYVkl
         O0JKeaat+9Fz9VA0caT1KXuN7avi7km2QPVc+h9FQmQpnPPTx9fzk+t0m0N7hHvla93d
         gYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNYwqS2GzSU7RfsQh6FIrdnN4TpboaNpPbKpUXUn0AJG5xCz37yUUL/kiBN5AZ5WARYKqtGF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysid6NT7NbI5XenHo7HU5PnRdSYnSujboxyfGveDLLijF1UGLp
	WtsSxKA1M0WAX0YBdTvsiNVul25XcQe5K9eANK8gNDisrv+tf3Mecsd/MbHs7Oic4isE/Gpktph
	KCUW/vnRdx+22GAPL3GH1mkEJxyok8Qd9FlnwNYpw
X-Gm-Gg: ATEYQzxBmRuNdOVktOow93uWiSIAlFTHPE8mNbc8vtHRpxOlZYFVjUwMXOBIRfgvHHT
	hpnEIo02eNNTC6jq2jARYE+7MmCrYHhA5mxUh7Y5/QrE9LOrJyJH6inUEz8IfcGc1an3Sx65zfe
	S9SokRHOUqZu7hfYy/5HX9V0eBOXp7BGq9fgneHNJJ8x/Ht8LvKcR0dIUWS1UxaXGVg2InJ7pLv
	jR7PGxKyLK48j5bGJ2PJT5lLtwm7T3+WqXL0d7k64uC8HY9BuHS08fsrqz9i9yIbZ0DjBsjIB4R
	4j6qSeOzYekBsuXsvcm56jSRz2s2Dmml7JzLNqIYMl3c03G5npkDYGIJabcbnybNtpLUzI1g
X-Received: by 2002:a05:7022:4584:b0:119:e56b:9590 with SMTP id
 a92af1059eb24-1278fcf8749mr3830629c88.21.1772305525220; Sat, 28 Feb 2026
 11:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227172603.1700433-1-edumazet@google.com>
In-Reply-To: <20260227172603.1700433-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 11:05:14 -0800
X-Gm-Features: AaiRm52dV_1QJ2jJLC0WcjpXPYt1QfNm6too8HMqFPkVxhVe4Gx9UwTVPD_OLac
Message-ID: <CAAVpQUDBbN05SoP0LzSHG6tDmy2OgL8GQa529Tp7V_zKr4CACw@mail.gmail.com>
Subject: Re: [PATCH net] indirect_call_wrapper: do not reevaluate function pointer
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262202-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 922B91C9230
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 9:26=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We have an increasing number of READ_ONCE(xxx->function)
> combined with INDIRECT_CALL_[1234]() helpers.
>
> Unfortunately this forces INDIRECT_CALL_[1234]() to read
> xxx->function many times, which is not what we wanted.
>
> Fix these macros so that xxx->function value is not reloaded.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/0 grow/shrink: 1/65 up/down: 122/-1084 (-962)
> Function                                     old     new   delta
> ip_push_pending_frames                        59     181    +122
> ip6_finish_output                            687     681      -6
> __udp_enqueue_schedule_skb                  1078    1072      -6
> ioam6_output                                2319    2312      -7
> xfrm4_rcv_encap_finish2                       64      56      -8
> xfrm4_output                                 297     289      -8
> vrf_ip_local_out                             278     270      -8
> vrf_ip6_local_out                            278     270      -8
> seg6_input_finish                             64      56      -8
> rpl_output                                   700     692      -8
> ipmr_forward_finish                          124     116      -8
> ip_forward_finish                            143     135      -8
> ip6mr_forward2_finish                        100      92      -8
> ip6_forward_finish                            73      65      -8
> input_action_end_bpf                        1091    1083      -8
> dst_input                                     52      44      -8
> __xfrm6_output                               801     793      -8
> __xfrm4_output                                83      75      -8
> bpf_input                                    500     491      -9
> __tcp_check_space                            530     521      -9
> input_action_end_dt6                         291     280     -11
> vti6_tnl_xmit                               1634    1622     -12
> bpf_xmit                                    1203    1191     -12
> rpl_input                                    497     483     -14
> rawv6_send_hdrinc                           1355    1341     -14
> ndisc_send_skb                              1030    1016     -14
> ipv6_srh_rcv                                1377    1363     -14
> ip_send_unicast_reply                       1253    1239     -14
> ip_rcv_finish                                226     212     -14
> ip6_rcv_finish                               300     286     -14
> input_action_end_x_core                      205     191     -14
> input_action_end_x                           355     341     -14
> input_action_end_t                           205     191     -14
> input_action_end_dx6_finish                  127     113     -14
> input_action_end_dx4_finish                  373     359     -14
> input_action_end_dt4                         426     412     -14
> input_action_end_core                        186     172     -14
> input_action_end_b6_encap                    292     278     -14
> input_action_end_b6                          198     184     -14
> igmp6_send                                  1332    1318     -14
> ip_sublist_rcv                               864     848     -16
> ip6_sublist_rcv                             1091    1075     -16
> ipv6_rpl_srh_rcv                            1937    1920     -17
> xfrm_policy_queue_process                   1246    1228     -18
> seg6_output_core                             903     885     -18
> mld_sendpack                                 856     836     -20
> NF_HOOK                                      756     736     -20
> vti_tunnel_xmit                             1447    1426     -21
> input_action_end_dx6                         664     642     -22
> input_action_end                            1502    1480     -22
> sock_sendmsg_nosec                           134     111     -23
> ip6mr_forward2                               388     364     -24
> sock_recvmsg_nosec                           134     109     -25
> seg6_input_core                              836     810     -26
> ip_send_skb                                  172     146     -26
> ip_local_out                                 140     114     -26
> ip6_local_out                                140     114     -26
> __sock_sendmsg                               162     136     -26
> __ip_queue_xmit                             1196    1170     -26
> __ip_finish_output                           405     379     -26
> ipmr_queue_fwd_xmit                          373     346     -27
> sock_recvmsg                                 173     145     -28
> ip6_xmit                                    1635    1607     -28
> xfrm_output_resume                          1418    1389     -29
> ip_build_and_send_pkt                        625     591     -34
> dst_output                                   504     432     -72
> Total: Before=3D25217686, After=3D25216724, chg -0.00%
>
> Fixes: 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indirec=
t calls of builtin")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

