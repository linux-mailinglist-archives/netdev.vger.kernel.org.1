Return-Path: <netdev+bounces-273765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HB3BlhFzGm+RgYAu9opvQ
	(envelope-from <netdev+bounces-273765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:06:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D883724A4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567283028B34
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE43ED5B7;
	Tue, 31 Mar 2026 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HM6ab7h1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73638F647
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994664; cv=pass; b=bpX6XTihC4x4UI0au+h0E2G+luRrQQWUxwVpVX2x5p29Fc5rik9rt3V4to1Fwy5aHKeLA0mPiu7engCOXuXYWLgr1CsWpT3Q9+4xgjNmqpfSmL9HXyfjj0tr5ygTOmEf1Dh9csHUqD4vRqjG3AYDZE31wNlOc4khLE2dqCbhppE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994664; c=relaxed/simple;
	bh=KXz8Z1YsAvBqjHVB5QBXZKVYV6oF9RS44FiMgG7zIIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D48MIu6SGs1ZVoP4p69GNpFAWRR2ZBIkjLuFCw67E8QO6ffXN+lD8GYOhsMqTeQLqcq1fUEBAm4eXuK87N1B4/qBZ0jWkN/lObtOBbAEnwU8krDqAL8eogiI2SS9lE4UqXnHVhcvrGuiKXPiaVMmwCCh4tHImqO2hlxcqJsm5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HM6ab7h1; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so675071c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 15:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994662; cv=none;
        d=google.com; s=arc-20240605;
        b=T4x4rye043s0gjtnePps/DHBPA5LtMITMgtaGcPqscaH+tCwvlRozoz+LmJjKjozGW
         8KhGOfsguvew8/hULhha528bdCBD8Jri9qjF17mqd+mBTJ4M0CS4Ye4EP5rPtVzeJI1q
         KSgRI76UTbvLiFPMPzMYJQgso5k86Zz2L6ndw9fZhoqWkevgmfEKzbttu+rr8hJgX6pb
         dYbAy4O/pn8SZJt6u8BnGur9wDosWmGqvS+aEKrmNcF344XZ7wwwwzXw3l3E/gSS+8TW
         cjrZPBwX5BrwtgyzRrGYajndW6xNjl7OO+4E6y4wtCyrUQWsyBGfmakfnO+JKLhtF2iD
         xckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        fh=SVZIt2nK4ptZ0g+GnL6zH/Yv1mmWjLYOzXfqo1vDGxk=;
        b=P/1p+YoeDIuq1Ra5BAuZYLGa5TTSm54qYkXAhqvwV7HOziwb9TP/oRHOYLy4VzvLr/
         0RlUopCw5IdqWvtXFFaUG4hX9McFbIEyDDyd9lEuj/7qNQsXRQbHs8IRu2goefHW9NAR
         cYaHVI+X5YnPaA1OJfygTBQtc9T9ZXPeoGF88h7OwO4A67Lcg5WMBzNc38ZXEYQkTIkp
         m0uvg1kzohTL0e2Ip6b8zoooccuGWZJ0SsABeC7qdX7GbLGNJ+0uEcSqb0wbL6W9M7zf
         Cw4XVX1rZTM70+jEnm+tn+lKnl+G7fR0TmMdqV5ZGuASZyaDIO7In+isXxS8Qs87RFes
         ZhHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774994662; x=1775599462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        b=HM6ab7h1ilYQVfb/3UM4pRXH1ZputZepe+FLPcABlQtMy83+hm5vnj4MOLSP6EaR6u
         t92P5IAkgNgly2CBF3mrNzm39DAeZtC3fiL9SZ+Fa8tU7RbB8vxqySEQWqTgk/n5QG+h
         Ikzfa1+kZMkqLf+fO/3kC4aSAS6dNCawWSzQMrwswnQLFEjpjk/WyhT8HfOZnH+2biVC
         V+Lt7BxvoXcwQJXM9deBF75sJLTo5KVsOINRt62RB/DbqbOxgTfavY2V4OlMXvGmkGop
         qxBhvfEaN+mAU+EHemXchi+Q1vw0USBuh0pZ44o9JsV/I3tdaHPZv8QbzqUSYsvWlmUZ
         PXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994662; x=1775599462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        b=n7EvK78tE8+Lzv15J47KB6xMZWthTGnoyDla2b3xnsuGz4vRSpc0WuqPDLaB1F+io8
         PKWCQ0nJVF+OQx/jgf1qNepMbOyQe0R6bCsyPWdv6ssqPUBLp+10vl/jgJdtmhFW7HJB
         JVfbKvw/ktSDIMgkm13Q/OBbO4vGmgflef8Xta0rUDmTe8HbhDmQPcnnSIfIkDqPcRW0
         4pPeL5dxKbG7oQbQsbWe0ejDmQ3TxseTnBcjbCmjLYdQYwB9XQc6UuJY1Z90PqZnKVbq
         wCjhaY4qm3QLtUXnIuhm5P6mMBJFE4if6z9G56XLHaxztiR2BG/ezHRJJ+JTpd1lATEu
         e5qA==
X-Forwarded-Encrypted: i=1; AJvYcCV/HkKYfDWHEGUXih/bRQrgA8CaoWfVlXAmeZYfM/dus2N+MZJeX1sf6cmEHE3gE0muGV9r+mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6SPa+4+qSBx57ADR1DaEqi8bZ6pFVvyeuylvQKkb87UGm/Av
	xyFYcWjXLbXvsSKtAmcMHag54Q+VNkg3Tc5ak8r0Gl3yRhKHvFC3qK+/UrEPbqJpuoKFxBmBXl0
	uZTSG2BS2jE+pgEu5Z1elUXrCYDN1jdD7e8U7eoCD
X-Gm-Gg: ATEYQzz3FeoTh5lVH1qaeT3qcKrH4ZPuzpRqRn8zDNQRi/wA3EszauxJn5KxgEHxkzA
	6NElh7hax/Rssv7cqPE1ognRD3T7Ui8ksXC6V5D0etFLd3viH/130Z/m0hKNc3sX+oFgdQ5IPqQ
	22k2oced2yyFvK4yx+Y89Y+U/wktmY9G+ILOp2qUSon81g/+c1Z0vCuaGDWYDUtQ17hD1K4evGg
	HL+bE7wJURLPdYSdTXxjUo55do3H4T4lsB4sZt1dr6a+EJAzfUUsLs6HEUePHz3amrNAYk+4Xhf
	CvAzZsAc2V1p/jMZVQlorcg3Dat5LJBAFm27KeJ5cN4Hv/HLiuVnFPSO6IvckP7d/gG/NQ==
X-Received: by 2002:a05:7022:684:b0:123:2c98:f65d with SMTP id
 a92af1059eb24-12be6437dd6mr762968c88.13.1774994661813; Tue, 31 Mar 2026
 15:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev> <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
 <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
In-Reply-To: <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 31 Mar 2026 15:04:09 -0700
X-Gm-Features: AQROBzAQ8y8qSCQrKpuNkixRyfIBAjxtkwpMokHCZ1Bvt_oQRokJ_pel-hcekD4
Message-ID: <CAAVpQUBbAQO8rSE-WSS1M7kEcD_sQ_9zHTyJg-+v2FoVuHZ8Kw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bot+bpf-ci@kernel.org, bpf@vger.kernel.org, 
	clm@meta.com, daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	martin.lau@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,meta.com,iogearbox.net,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 61D883724A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 8:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/30/26 6:35 PM, Kuniyuki Iwashima wrote:
> > On Mon, Mar 30, 2026 at 2:26=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >>
> >>
> >> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
> >>>> #if IS_BUILTIN(CONFIG_IPV6)
> >>>>       case htons(ETH_P_IPV6):
> >>>> +            if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> >>>> +                    return -EINVAL;
> >>>> +
> >>>>               ops =3D &tcp6_request_sock_ops;
> >>> For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
> >>> immediately following the base IPv6 header. If extension headers
> >>> are present (hop-by-hop options, routing, etc.), nexthdr would be
> >>> the extension header type rather than IPPROTO_TCP, even when the
> >>> packet is a valid TCP segment.
> >>>
> >>> Would it be worth using ipv6_find_hdr() here, similar to
> >>> bpf_update_srh_state() in the same file, to walk past any extension
> >>> headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
> >>> always identifies the transport protocol directly.
> >>>
> >>> In practice this is very unlikely to matter since TCP SYN packets
> >>> with IPv6 extension headers are essentially non-existent, but the
> >>> check as written would reject them.
> >>>
> >>>
> >>> ---
> >>> AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> >>> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/RE=
ADME.md
> >>>
> >>> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/237=
35111188
> >>
> >>
> >> Thanks for the analysis.
> >>
> >> There are many places in the kernel that check nexthdr directly withou=
t
> >> walking extension headers.
> >>
> >> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
> >> potential future improvement if needed.
> >
> > +1.
> >
> > Given this feature is to create a reqsk to process on this running
> > host, it does not make sense to support such ext options.
>
> While at header reading, does it need a pskb_may_pull() before reading?

Ah good point, now that we read skb->data, pskb_may_pull() is needed indeed=
.

