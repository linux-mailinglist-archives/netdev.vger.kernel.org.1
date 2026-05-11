Return-Path: <netdev+bounces-286696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO3OMqrwAWpfmgEAu9opvQ
	(envelope-from <netdev+bounces-286696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD026510D97
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F163016026
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2C3FA5CC;
	Mon, 11 May 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1tLH/Bp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A123AE87
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511401; cv=none; b=KeitRoBu5Tah5HOi+YdTe3nZSFfnCBm5+B0t0Hi1kXY9GFwu4rjnpQgdmp6OGOA9NXLrICN8pssJHacW3nEbPmMbj+mi01BXTwXU2wP8j8qi2TmT5irEAyA/1ugA/WyPkNBgtCG1jEejsTgbpme0rYUybIUYdskbJfERxS7gl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511401; c=relaxed/simple;
	bh=nozqZkYqnKNHxP3Iu3Sop6z/onajxYXf0IYlzL4iAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Y6RjNNmdRoI3ed/RiRv7VCIzeRUDnfTENr5aInYtnkK6I087BGqApavXXYWnNYDHqUuOtyZg8KqpqDnjnmbN41nINf+Re+iq2f0q5v361xsueKdV4CoiTkQ+qCo5syIwIanRjR0SrVoM1UD9i2q4wn5KpCaiqhOx05i4PBh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1tLH/Bp; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c8028fa6039so2834546a12.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511397; x=1779116197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/2XYunZZhJOj9243Vaf4F12iOGTyYZHD3g6BpnS6cA=;
        b=F1tLH/BpqP68bSawJG2Tgwo+t1/bm+oLSP6Ns7lbYuREEBXr856W97T9rWZT12D7H2
         pa9RMqg6X5sXFO/VTo3BZEpsbXNYtrM/H5NLNnJvkGsnVO1Kg9CBYyIgtCK3bWUKgIpa
         BQHgjRNXKHF7YxaNtzM9vfa/r9zTisDU8vZKNfFgvA7k4UDJLjgaNTBlpqek3dmyBg8L
         RSOAYThEDYa+1ojHwZGfKxPKp1EpQt1PJfGZ9AFJcqX9WzV6SXOAUBFLLMRTFR8YXTly
         /ULVtA91MllQt9BFpWFhRRuufX6RaUPLHRD6g47IPnF/+kpgEX2BPuxASJ0jJeSlDRet
         N2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511397; x=1779116197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/2XYunZZhJOj9243Vaf4F12iOGTyYZHD3g6BpnS6cA=;
        b=EraQdwDT6IPI4qToQ2TlfpN7HG04IUrGnTa5s7XuDuNOR9xfPl/nkda+gxaz9Fdmjv
         UxaA4HpLzYBsrBsK7slvDS7GYSIInjBBsI+/5ijMwQVNFnYzExnUY5eozvgijK1K1LLC
         j0IZhuyyDOciZGvbzDnmPEmhYq7OzgZwlhyCezyF4TI/sfj5Nz4j/+EER4wEfdbMKmVm
         PwuXd7VYi49S32ig3pDfWK/HF0WP0Ze5U0egSCfz4bLteSBrznBRhiJQ/T15jbhxoL02
         jEzG+oe5kDe1d/i1euK5zcraz+ZhMvCzqls9+7hi49rcX2wxsIFI5z/AM5cUY5kTZWpJ
         5udw==
X-Forwarded-Encrypted: i=1; AFNElJ8TOQ2fK8BShH3ddhXoPXaHAKfiAGiyoH9HE/9R3BnnHfWhiEr4nds5TSVvPfAPvvtp8UXQA4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysywVXK9hcf1JQCaBf6Kr0b517ddLF5QI0TkYmW8SpgWQijxoU
	dxLag3+sqPeRTJGZhD0EBNPHRs6xNaCEEMXgvjwoiuXLuSFD3OPBLCFw
X-Gm-Gg: Acq92OFVBzxiFV+xii2gCEkGdQSCh9cR/RxAe5yZpIwCfCzmPFjWXZ+5DIEtTtg8d8r
	p2AX/3SmsY9ib+vBSQOfUtxoZ9yg9RjKTHVclhTh5b1UlcnC//1U5tWcXDhoJjbfQ/8U8I2bWGn
	dx+AetEbpvEi8tmtoIRacSGJ9uYOAlKwSqf5oglxAbA2Gf21+K3zfw4nugOViANIjG/xjcpDaOh
	K3LBQTr+xtjCRKQmsGOb6kJ+9ugMaGe56fJCoXFgrE0x5H9+Oo7dU1oQJublzLcFnLCvdwjuwdo
	Vljk/6C1IGwXVAs8WOgW0GpGuZmzVHVOE4ATuVtBHdh+s8dKoD44Y7FFXSYxLjj7CArdiAqGjkf
	KuJqDGKI72oNVL2Ks9Pji2nWPWwzsmwdrwV6S6j0ivSnZvIAxJIkLyoDJmXQHuJlzvUR7qqlp98
	mmqodF0C9aEfEB/OCi
X-Received: by 2002:a17:903:22c4:b0:2ba:e66b:ce34 with SMTP id d9443c01a7336-2bae66bd563mr171723165ad.21.1778511396945;
        Mon, 11 May 2026 07:56:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4057fsm103030355ad.21.2026.05.11.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:56:36 -0700 (PDT)
Date: Mon, 11 May 2026 07:56:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <agHuDeKLLUDdWXuS@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-4-kuniyu@google.com>
 <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
 <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>
X-Rspamd-Queue-Id: CD026510D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286696-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bpf_sock_ops.data:url,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/08, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 8:15 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/08, Kuniyuki Iwashima wrote:
> > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> > >
> > > In this hook, we want to parse the RPC descriptor in the skb
> > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > >
> > > However, we cannot access payload via bpf_sock_ops.data on
> > > modern NICs with TCP header/data split on as the payload is
> > > not placed in the linear area.
> > >
> > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> > >
> > > Two notes:
> > >
> > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > >       invoked from recvmsg().
> > >
> > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > >       0 end_offset to bpf_skops_init_skb().
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 5fa9189eb772..94d07a15b2ab 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
> > >       .arg3_type      = ARG_ANYTHING,
> > >  };
> > >
> > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> > > +        u32, offset, void *, to, u32, len)
> > > +{
> > > +     int err;
> > > +
> > > +     if (bpf_sock->op != BPF_SOCK_OPS_RCVLOWAT_CB) {
> > > +             err = -EOPNOTSUPP;
> > > +             goto err_clear;
> > > +     }
> > > +
> > > +     if (!bpf_sock->skb) {
> > > +             err = -EPERM;
> > > +             goto err_clear;
> > > +     }
> > > +
> > > +     return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
> >
> > nit: wondering whether it's better to use __bpf_skb_load_bytes (which
> > wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
> > magic and used already by dynptr?
> 
> I guess dynptr used it because dynptr is in a different file under kernel/.
> 
> Users in the same file (sk_reuseport_load_bytes() and
> sk_reuseport_load_bytes_relative()) call ____bpf_skb_load_bytes()
> directly and clang inlined it there (including __bpf_skb_load_bytes())
> while dynptr tail-called __bpf_skb_load_bytes().
> 
> I see the point (I had to read BPF_CALL_4() macro for ____), but
> ____bpf_skb_load_bytes() looks better.

SG!

