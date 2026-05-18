Return-Path: <netdev+bounces-289205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JJrHHOnC2p2KgUAu9opvQ
	(envelope-from <netdev+bounces-289205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:57:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8A57549C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C1D6301A409
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F0330D28;
	Mon, 18 May 2026 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkzAcBi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1523112C0
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148656; cv=pass; b=hoioWZdcOdQHcEoADo7tdkKpZxKF/Q/lNMZJQ9UInSZEX0zh0P18vCJ3L+rSqHHiQl7ykHgiOLyucNBLVxoX7XKsVLi6bPiED3TsztZuISKc8K1Pd2nfUmGzV0qFnL5JlGM3PRuIiUgtMYSUUcZTn8eGRLNAuWMT9ngr9MfKI38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148656; c=relaxed/simple;
	bh=4xz9D7VAQrmdEZXxAcS5UoEWPCKtzjLiBUCPWtmx2B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iy4zY3cB3DR5YZYiP0hMaUpOpvghbHiWydgItqiNsnEPvzCpoQMi0RNtdGOZQIuO0pU6uvXovIPeT9M12GPys4HwL7s0K9Oj83INID/Dl76dpHLw4XVwju0b+jJBHCTKuUIhwRwBJ336kpG+RiQU90yh4IcYzRTH3Do0tXzY5KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkzAcBi6; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso3895064e87.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779148653; cv=none;
        d=google.com; s=arc-20240605;
        b=hTMfFs3jujUIGnBJpqNN2inUNL9PhitifSKOmZXGRyedXYLY+7EF+D8zvI6fPZw6XE
         EIQHOFJbKxwuu4B+mrBl4Kb8mlY92zATdHpcffejWu5PSkqArj/LTABC6zL0kKL9mqST
         m43FFnbxMWfBI+p9Kht1QYsQEZUKW0cUUFfOhNUi/SZj/T5Zhzd3ZvJlcKN3fpiD9PPn
         cCvw9d60fPi1J36NKqKSNKJY4C7X67dYvoQ0o/FKT1HB/FqSdKVQ2Bc9mhQ0OMJ11+Tf
         J3y/QpSfslF11mek7LNI2K90uxNGD43I/Vkb6OuQGk9U8nJKOx8pPU6jp0AUqvxc9NiM
         zW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        fh=EAH9SxANYe7mjM3ukcLh6hVtxssvtmrbvHsN9d94uZA=;
        b=Qu6DVvftwNUMDpUXvbjodu2X6AfU3k++cYy/YtC30eIQtQakiYvXXSpvuRzehOMdL3
         Y6FTpk0u6McanZz9BJ4FZFZnRRoxRsaoGtcIGqJj2PteKuWdToYERYYx+wY4G01lFs+l
         k5FGmSpWer468DJuUKU2paL+J6C+D1JmXnxLlGz8k3nHH2k5HD8djHkHdAnIZREeJRML
         bNkfi9P0yY3Ng8UW8YUuvOiMLm32Q5UnNEpcgS2a9Jw9RxkLwlRATG+RSEVEnRAA68CB
         niAxMwoGbTH/dnHZEspmMS1bVTAIsjhdq/fSnH45KgsuWlF0cytMvfay9TBYJwiewDGa
         agGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148653; x=1779753453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        b=mkzAcBi620+pQwhVeVniDJ17RfgJhvsMhOx3i+BhAl1H9J7himww5AH/FFlSDwiGkD
         Ao5qNXgFsLIzq7jSmQkAjWHprvlbpVBntUkb31O2EF34b5kz7RqBSbZh9LM8rcU/ZpGU
         BUOcoByPnEaX3V9+pJWSSe0Ja4ZV6TX8g2//ZFPrVuh4+Gzk+EoCqEinLMUU7JOjMcyY
         hlku4y2imW8glzB9nWIzmuCa+LH486+eGcTE37ZLTLppPfjnwPhXk1TrmFPOuCh7Wb0V
         5Dq7QL1+HHu1S7R+A6Zg8l1v9JKPTHFIyNTs9CJCTAzSP4syXfJfRVJcrigqma8JKVhr
         uAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148653; x=1779753453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8rgBOoJQIg12SJZYcIEL+l2QP9Xebk+rpGwoK9DyJ4=;
        b=L5WdqD8EYmN2T0c3vrsK+JFbSLDtZSyx7/KzYg4WIJbtoWbBmO/bnpJ4pNY/PYagql
         WCYcc7TyCs/2/jsSYvx+kW81MLt+2luw1l8QpkGlUMsNfBPrIxPKcl1wcqqA0S/cJ9e5
         jZK0o6+0qjD0A4lLgD6N6rPYKnP9zlO+focigthek/xHY+DV07CYCIhXi3VhbK/bSTco
         DVOBDzuBrQlCKAJHW/DP5dsyYWAjicln98ps4W4vls9O+1JfwF23H1cK4kvSc37Z0zGj
         0/Af0JdNb6VpvLbKIK88FmTj8VJBQNaKxqLc2V2plmbnxgZ3otT2IySTxsc009gw3sfK
         L6mw==
X-Forwarded-Encrypted: i=1; AFNElJ9ya7pGdQcclH9eNpfv3feK43/pQRNXFIRCHjBFV3dHY738n3/+ZxcxJxZbPCfpS2p9SeQbu64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tnCn7oQIg2dWl/JNTS8/965NkD6cn0bdioazxWIQjvVT60qe
	udAwiqLhNCIjG08FEiDcNQPCNOVovKm5UXAscSF/etTqspo6wQe4jlCKRBFrjUIJDu1l+tIc0rQ
	dVIZJn0eA463oMdcCFf0v70EZrNkXjEc=
X-Gm-Gg: Acq92OEOluqc89rPADgUUz4BwtDy816jEpCiTqhk335VN3qSvqtoUZ4U7fe4c5AoVZW
	Cj27jrhQl6QSzB8IoEXiIG+VHIEDhK4M3H+/Y+kHUKZJwWY9zQ+/FEQ+bC3dJgqXGQGHCQPd5c9
	cl9IslRWrj8o/M2aKC36fMqix5YP4ZIwQLIQlQp9SokCFakQ0XVjdiRTW3fpKjYUuYPXXnCvz8S
	vbwpGaU83p1hD8DoGoBDZSaXz5a9dWcfNRdEteZuXXhLzQg5cKPua6TlBU+NzXtR5Zm6BNE4na9
	gNEkgcS24cCGaRax0hTEbUjtoy70WZW5RZVE1sE=
X-Received: by 2002:a05:6512:1094:b0:5a4:175d:21a with SMTP id
 2adb3069b0e04-5aa0e600e20mr5276550e87.2.1779148652475; Mon, 18 May 2026
 16:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
In-Reply-To: <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 19 May 2026 07:56:55 +0800
X-Gm-Features: AVHnY4KqQCXKCs456Fffv-Vucw_lyoIiww_LVFXcU_9Mv3prioM5sCl1Gc9ovRg
Message-ID: <CAL+tcoASR9sfdi_TiMEN2kqb=WL+HCuOTcO3h4XrLVR+2G2XCA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289205-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E6F8A57549C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:34=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/18, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two if statements to accurately isolate bpf timestamping and so
> > timestamping. They can work respectively.
> >
> > As to so_timestamping, only add a loose condition via report flags
> > to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> > and performance impact. If the loose condition is hit,
> > tcp_recv_timestamp() is able to handle the exact case and doesn't
> > hamper the existing timestamping feature.
> >
> > Make it work in TCP protocol.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..64c69bb3578a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len, int flags)
> >       release_sock(sk);
> >
> >       if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > -             if (cmsg_flags & TCP_CMSG_TS)
> > -                     tcp_recv_timestamp(msg, sk, &tss);
> > +             if (cmsg_flags & TCP_CMSG_TS) {
> > +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +
> > +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAM=
PING))
> > +                             bpf_skops_rx_timestamping(sk, &tss,
> > +                                                       BPF_SOCK_OPS_TS=
TAMP_RCV_CB);
>
> What about tcp_zc_finalize_rx_tstamp? Do you not want the rx tstamp for
> tcp rx zc?

Zerocopy support should not be complicated, I suppose. Let me find a
benchmark to test it locally.

Thanks,
Jason

