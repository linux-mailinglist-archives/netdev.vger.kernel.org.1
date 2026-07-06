Return-Path: <netdev+bounces-305233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3kLdAr0tTGpJhQEAu9opvQ
	(envelope-from <netdev+bounces-305233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD16715FE3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:35:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=lLbdaQpX;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305233-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305233-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8DB30393AB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F0435AB5;
	Mon,  6 Jul 2026 22:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8124435A84
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 22:34:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377279; cv=pass; b=VjvpuwFs9wQ7u3BzmA3c6v/SetJ2iP5yPYS37Wub4bZzSYn2HBBX3HzAOcj1UWtnMMw33nzGMNzlzr3YOEBAD1rOqPzsPbvrl0oDMms1/jJ2vcNIfkFUeTwr58gh7hlZWT4B8lVpPmAA77BX4+e+bHPlYMp1cOa14m2DRn+apQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377279; c=relaxed/simple;
	bh=lTUZOY94Y25rO1nRtht75vyOJgRt/imSYgOoE51K5B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCtYGzVVWXlP3arX8cAJ9LTtEeY1zrsMOH8hEwECGxh3Bu9uEZqWrbXedJuQ71jBJyEVcg5SS9dMcVjFYHNts2WLB2pZhOJPnf6oMdoAuknCGkYHYvDlehIIHGkcqRuQTJLp5wVMhRNciEnaBd/q0kcY1PdX8SZmKWgoviDZc8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=lLbdaQpX; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8482074a000so916326b3a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 15:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783377277; cv=none;
        d=google.com; s=arc-20260327;
        b=hmvahZ4xGWbM0qwl2wywnbkofIbXIqdNdJ/IYDsiJAwpKiM4+Iuge6dWL7g2RbM9RS
         dRj2Ko9c5A0npahfu6RUbnroJY1SahG0sUwxa7a8o0ciFUhbblHpXENLJUZYADdRnTtx
         klNgAmstH12HiNwVl3WuYF/ifvthc2k5tG5pfxZtopo95OC0FeiW3slU5Otm+IfChbC8
         /iHJccG3fAnAEEITCBzzHqqPXkyn6amuE0TfxB0y0xt9nk78KQzsSR+TQmx+SdbLhVXW
         BlMGx1eEK+8IgYzRavr4+M7wK0z1pIleadfVYYCHcaB6768JAeNGCjuiAHAyQEWSQqIF
         tQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=68t6a7+LCIVpY0XGg4cKf/lUG6JLduRCM6rLL7aPU4I=;
        fh=7MqmH3hpqSbtEyPtNN1An1VxIQd2RK6ix9drvGV/H/0=;
        b=OJLWPAt4gPTpmNjEOWVRbkShnQR4yzHxBGpCbW26iZO3OP72OICckKWQDa2jYP/Mg/
         YhCpxHjAdyK8mY9P2a97SwrgNNmKLclDQOkp+tAcMJJ7OrzCEU20+7PDcVE6Ginbjkj1
         ExS0bNqQ5f8TnaSQnbsde8UIIczEBV5drYqsZdc5xoAolxde2WXU57azHMU9n6LUyG9T
         pd5rYQOLyirPhJXFBolT1wxW6ZUnrJEx9cdB949SvXTpTYuuats1fI/2yzWQtkk10n09
         gZ37WGRO4qp7UBeTNXOPUqU+h9odMM0y0W2TER+/xu9RjFAO4bUuRAyvqzVZmn2kQOUu
         iftQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783377277; x=1783982077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=68t6a7+LCIVpY0XGg4cKf/lUG6JLduRCM6rLL7aPU4I=;
        b=lLbdaQpXRyC4yN1mpnf/LKWBQELmGU6njW/S+S7bI6XWLzmzF1oAo0pvtbiuMyn9jf
         zBWE/uXzGppjcxkMpNXFh/0P8NRsk4mbAYrEEYBeI1/Xk/E8AgTWHcjxInGOY97olpwj
         TnKFPnvpC5vk52f3ivu+IcT0fnICrY8THRWmUOvwPyb0Aj2Ffjh5y5CXxWE3n5mNAiKi
         rKnhrLJYltkgef72PomTa8R/TsL2MOaxrwzAof8lJncjTyYgEgjtQLCiTbADjHjk2HrI
         jvl6gECAoaWOrGG1bUnw+Ink5IZ0ctyEorYEn/jnahOwRXBdEavNUnQdUD7ao2VUszx/
         zHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377277; x=1783982077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68t6a7+LCIVpY0XGg4cKf/lUG6JLduRCM6rLL7aPU4I=;
        b=C3vUnvvstDJZdYO/mxhuI4KKq3/QMvwYDudVeIeNYcxgoj4illJCb/6uDZbnHWukzy
         CW+tbr/ufVGjoNhrAG1rw8jMzmw0fnHzqDvDd02uNHO/84350T7BfjY6XkdPxu3PQeLL
         StzkuLB8r8xISXmDlY2v0vwZSG87o9vmtNmozu8wlTTLUrWyYJvFkzTluyE7Tn7QWnU/
         B7vZz+JI3v7OAhSz6a3lS8Llv6CdYWiJKIeyZ0TqAhPsohL7qw6sHlo8HbKsLNGSXJ5E
         yW2cEEgAP7z9ueZajpDRn4PW9ByQzoWCHxJ+ibcofRKlGYn5TeRMbQMfHcTFgQSROpBG
         fGfg==
X-Forwarded-Encrypted: i=1; AHgh+RoGrPsYW0hGL81qhg7+eAFeHu/1qgr5E2/oQer8sJSeLLj359ZnMirtlqmaMCa0L04Ir9mZnZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQD8PNrcEENuEv/Pg1pjohy83W2hM5naOXtsl7l4RSmcwVwiX
	7IliN2vFxMQmK/8QWcKe9Ur/JgyQujQuGoR3xmpLQWouwuy5vOo1++D8vvD2MQiB8obTJUMC4SL
	aYwowlm5hvjXgTl5lWFLpIZ3wdghJXZ98tDQzx3Wl
X-Gm-Gg: AfdE7ck9ZsE2L2v7f3yqQS07ZPV746icLOBZASWXsoTlk3eVUTISdLt6hBaeXcnuiT2
	bWuYKEETgrIQNwg0V/CHDZ3cvRqWXhnKW1KD4XhlCNatY4DaECMhvhHKjS5dOdtEI2NG4dZO8h0
	8upVNyjy+ySj5i7NaqbuqpkGU/VcFcqocsPLTyhMNYrjtAlwyQCn80emS45F8ay+Kyhi/7X9cRL
	08QK2TpltgIetzMfXS9X0dT6CSV9bMAiIvKJYYhonl9OpbyNm8PEvtnboRq55Rw/Nx8UAa70Chj
	9ycYnDfIAThGtIRZUIs79T0TL1t/
X-Received: by 2002:a05:6a00:b95:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-84826c94d12mr2519150b3a.5.1783377276995; Mon, 06 Jul 2026
 15:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706212556.3199234-1-xmei5@asu.edu> <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
In-Reply-To: <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 6 Jul 2026 15:34:26 -0700
X-Gm-Features: AVVi8CfB7jFXvlXcgemzpJQ3O6nY1afh0xCFUyctWYI5a6_8Q0NxjT__WTPfteo
Message-ID: <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
To: Thomas Karlsson <thomas.karlsson@paneda.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"AutonomousCodeSecurity@microsoft.com" <AutonomousCodeSecurity@microsoft.com>, 
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305233-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.karlsson@paneda.se,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FD16715FE3

On Mon, Jul 6, 2026 at 3:31=E2=80=AFPM Thomas Karlsson
<thomas.karlsson@paneda.se> wrote:
>
> Dear all,
>
> While restricting a lower max than MAX U32 may be warranted the proposed =
limit of 4096 is way too small for high throughput multicast traffic.
>
> We currently run many production servers with the BC queue len set to a v=
alue of 100 000.
>

Thanks, Thomas, for your feedback. 4096 could be small.
We would like to hear your suggested values, and we would like to do
some tests with the value you suggest.

Xiang


>
> Best regards,
> Thomas Karlsson
>
>
> Sent from Outlook for Android
> ________________________________
> From: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Sent: Monday, 06 July 2026 23:25:56
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@davemlof=
t.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org=
>; Paolo Abeni <pabeni@redhat.com>
> Cc: Thomas Karlsson <thomas.karlsson@paneda.se>; netdev@vger.kernel.org <=
netdev@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.ke=
rnel.org>; AutonomousCodeSecurity@microsoft.com <AutonomousCodeSecurity@mic=
rosoft.com>; tgopinath@linux.microsoft.com <tgopinath@linux.microsoft.com>;=
 kys@microsoft.com <kys@microsoft.com>; Xiang Mei (Microsoft) <xmei5@asu.ed=
u>
> Subject: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound broa=
dcast backlog
>
> The netlink policy for IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32, and the
> value becomes port->bc_queue_len_used, the only cap on how many skbs
> macvlan_broadcast_enqueue() may queue on port->bc_queue. An unprivileged
> user owning a user+net namespace (CAP_NET_ADMIN is checked only against
> the target netns) can set it to 0xffffffff, so the backlog check never
> trips and every broadcast frame is skb_clone()'d with GFP_ATOMIC and
> queued. When RX softirq outpaces the bc_work drain (e.g. many ALLMULTI
> macvlans under a broadcast flood), the queue grows unbounded and
> OOMs/panics the host.
>
> Bound the value with NLA_POLICY_MAX() at 4096, 4x the default of 1000.
> This keeps headroom above the default while capping the backlog; values
> above the cap are now rejected with -ERANGE at netlink parse time.
>
>   Out of memory: Killed process 141 (su) UID:0
>   Kernel panic - not syncing: System is deadlocked on memory
>   Call Trace:
>    vpanic (kernel/panic.c:650)
>    panic (kernel/panic.c:787)
>    out_of_memory (mm/oom_kill.c:1166)
>    __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
>    alloc_pages_mpol (mm/mempolicy.c:2490)
>    folio_alloc_noprof (mm/mempolicy.c:2591)
>    filemap_fault (mm/filemap.c:3565)
>
> Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  drivers/net/macvlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index c40fa331836b..d4cede6393b0 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -37,6 +37,7 @@
>  #define MACVLAN_HASH_BITS       8
>  #define MACVLAN_HASH_SIZE       (1<<MACVLAN_HASH_BITS)
>  #define MACVLAN_DEFAULT_BC_QUEUE_LEN    1000
> +#define MACVLAN_MAX_BC_QUEUE_LEN       4096
>
>  #define MACVLAN_F_PASSTHRU      1
>  #define MACVLAN_F_ADDRCHANGE    2
> @@ -1755,7 +1756,7 @@ static const struct nla_policy macvlan_policy[IFLA_=
MACVLAN_MAX + 1] =3D {
>          [IFLA_MACVLAN_MACADDR] =3D { .type =3D NLA_BINARY, .len =3D MAX_=
ADDR_LEN },
>          [IFLA_MACVLAN_MACADDR_DATA] =3D { .type =3D NLA_NESTED },
>          [IFLA_MACVLAN_MACADDR_COUNT] =3D { .type =3D NLA_U32 },
> -       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D { .type =3D NLA_U32 },
> +       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D NLA_POLICY_MAX(NLA_U32, MACVLAN_M=
AX_BC_QUEUE_LEN),
>          [IFLA_MACVLAN_BC_QUEUE_LEN_USED] =3D { .type =3D NLA_REJECT },
>          [IFLA_MACVLAN_BC_CUTOFF] =3D { .type =3D NLA_S32 },
>  };
> --
> 2.43.0
>

