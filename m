Return-Path: <netdev+bounces-256420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JB3IQM/gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:31:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C608DD9DA
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D46630C3922
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F6A31AF36;
	Tue,  3 Feb 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhlS55y6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF511F471F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142735; cv=pass; b=k+Zb3jGySz68VFEpMh4tX259G8vFK6sradrWgKDW41mFec8uypQJ0V27dxgPTMhji1Vvp+Jwdp8BMSs3OtV6SSrN6CeNqqk9GRgE5+Olum5njJPVcJUZvE59D8iVmJ9OI4yWBmgj+s+OmB+6mn4dKS0YTCDm+tnWN/BIyPHfjNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142735; c=relaxed/simple;
	bh=cA1Jli+sscvDVqImV12sewCIoKF8Ea9sjbU+hyyTh/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDTOkTJhzYIyQuFwBFKvB6jhT/xGCl85HIBG39m3Hx/Zte4Z82GGDWc6v4h5wVtDXuBpWFSxAHupL3EA9KBJ2eUhJIzBedENuzgLuIFmKw/sh3CKXVFRJtxgMvobnlL6cM2uMlHZn/CzElE7FbOZWbb8GYoTAizrWzR1LCRyN78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhlS55y6; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50334dd44d2so68973971cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:18:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142733; cv=none;
        d=google.com; s=arc-20240605;
        b=MQbO0tW2N2YfNwJrwjP2X5G09xMbDoSFNkmx7u9KWoCLGD+7FTf6DckjIDnTxpozhj
         QuFC8umIZnpx7tPeaGvDw3Rtz2M1xXzN/Y6zhp3rR3F2AMRkJ7LOtiRioH1G234kqMAi
         kxNaWW+So9mlHnHwcuZO95daYBq6CXSh9yXjC06Ge4moNqJSh7kWoOnqmBBb7zMBbMp4
         IJ2QlMYuQAP9Q1ggMQJtHC3yH5sCbW5rJ4VAMQWw8ZLwsUhvfIGJGTDETqp6gf+68i2A
         bsSh7K11+LyFhHtx12hOvDLUJchVxI0FGuJCEx2AcJndwL2dIEt0MeOEPmz5hOQpldwc
         K/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z4WgtTkSreI/HB6UOuYuttLEkY/8EQTdFHXMp6Zq1w8=;
        fh=hWWU/8xTBa/qUFgWbAz/pnQKTgtoiEtcyd3pc6I5ZKg=;
        b=F6ik7LF+NosbK8WfEgtoDNc0ltvhTirpZ9NO/kthSZ8cKOujsiAbSHjlymDEMzfVkv
         8M+PlP6ln5m3gbIMDLAXC7OyhsPXA/8E46Ha3hE18jtJO2uzTr1Z0imK2z1YMKI/XIZt
         O65oSBYyaLwzHiIjx93CBOBD104Qr+kGO0bt/K9p2tZKdjDXwRBWeFRQyed4ztiUqq1u
         z+/Uu0C+xv6PMWexHj65C71URYmjYKn5Jxe+QRD3avye1QGL99l6gMH3jut77jzJC1us
         KTdAgBZ3d4sLegYT7lFPklHXiBQ/q4Qtf0gzyw1Hd2mzqqwChfZk4IW7JMdqWBA7KLK2
         1zWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770142733; x=1770747533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4WgtTkSreI/HB6UOuYuttLEkY/8EQTdFHXMp6Zq1w8=;
        b=FhlS55y67k21BmXo7SqxyftxfvtS9Lapz0KWF7EBp34YLAgeokIsic1ygtO28Tkk3Q
         C5KAZD9f5jKTv39FBc7lZ2WKnEesPyq15r1a0nDruFbz3T5OkQajBxxGZFQURDR9jFk8
         0zj9s4gY4QZC455+uAlANwhS6wo2UL35F/Q0ZUx1ZUsskz/N2cGCjh3xS1llnQ+z6B5X
         nXIaBbwa8JNfqamY7YwFNEsX2fIeOSRK5HKBbfxS6vcMVlE3VUplZHfUrHwTG9J5tkTM
         tb3Fwo2XpzRHttr6ZJ+t7frpQDZnQvikNR8lQerlE8esoNkzuCSREceamTZ/EVvyeBOS
         dD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142733; x=1770747533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4WgtTkSreI/HB6UOuYuttLEkY/8EQTdFHXMp6Zq1w8=;
        b=bIiL/TrINKkTI5jRfdAkWSe+IsXZYtGbuZs5uUpBlO3y4ya5LE/gfAxrqvjz1VhSUz
         q6dZQPkzx8qEXn99jNFLGTNdK0AlCJERQoifoC6IGt78WaIgkoWTJQmlYhMBXwsh5mst
         706nIlDDmhJ/tGQ5vVAYWA3kLtWdvGU1F/X2v6yUSfjQO1JKn+irfnUfoeu7o3c83H68
         XNcU1J3v8PPGg++eGve8FwzCFrvLdByo5YGvUFRQelg7QcFP4L2FQkXXpIjPa7WcZfy2
         1DzkYzJcF18Z+3gMFelz0Sq60INduRwYTsy4BviLlw7FYmt4f9YjqXYZozwNbvJMe3LR
         m0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVrcgs+pN31vLKtdYjbq/92wEgpZYuAbgX235Qnd+4lEz0ybXzaWzvnHlax2nhhvAbPoDWSjBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjfkJCPuR0XnpifIfqSkGIuSrVIpFvRUOT9ZmY31eyjYIluJ9
	6cORltWkxBwX4iuuVYdLc6WECkjcZzkjtGzXLZCOjiwb+UQnL+P0RumOBFrCyNppgx+pxidP/nE
	IIFko836TUXxXmMX7Azj9UQAfds0rLXfZwH9NA+1j
X-Gm-Gg: AZuq6aIsmxmrbv9/yy1rHVU2TWQ+xRv4ER6QrFKQpHfKCTO1B9nQ4IdvSEDHfIpwusj
	eDD+NzIyfGTsaNvGmaJ2Uy1/ZWn8b3j8wg9CY7OzvxLs82MIT0XHRtFfWZDTcXMTaAVJAXcCq19
	jsaTBCufFNBTRm9x2rp9L02e31Dt6i5Muh+18VGFzJyBVHexdkqTbazoYf1JtuoMyn+yZtOobGL
	YW7Rm0gcnWfy2QyAkxLFPZJxoSetKOLAI0OwgXPYE5zRVAMATP2+51UdldKM7tclA0bSCI=
X-Received: by 2002:a05:622a:249:b0:502:984a:ff19 with SMTP id
 d75a77b69052e-5061c18dea7mr3044341cf.43.1770142732321; Tue, 03 Feb 2026
 10:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203144053.83193-1-edumazet@google.com> <20260203144053.83193-4-edumazet@google.com>
 <20260203092636.20c6bb6e@kernel.org>
In-Reply-To: <20260203092636.20c6bb6e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Feb 2026 19:18:41 +0100
X-Gm-Features: AZwV_Qgm4gl1EfsQB2ukQ8cwHlrjTLJqmHhhal7QaqPlRTamvT07T_TJ-CfUCYg
Message-ID: <CANn89iKaHErtov9nnzQQ56XHGdrM--n+H3k2JEBM=v7MwyV-VQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256420-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C608DD9DA
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 6:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  3 Feb 2026 14:40:53 +0000 Eric Dumazet wrote:
> > tcp_v{4,6}_send_check() are only called from tcp_output.c
> > and should be made static so that the compiler does not need
> > to put an out of line copy of them.
> >
> > Remove (struct inet_connection_sock_af_ops) send_check field
> > and use instead @net_header_len.
> >
> > Move @net_header_len close to @queue_xmit for data locality
> > as both are used in TCP tx fast path.
>
> Seeing this in allmodconfig:
>
> net/ipv4/tcp_output.c:1482:13: warning: unused function 'tcp_v4_send_chec=
k' [-Wunused-function]
>  1482 | static void tcp_v4_send_check(struct sock *sk, struct sk_buff *sk=
b)
>       |             ^~~~~~~~~~~~~~~~~

Silly me, I will squash this in V2 tomorrow, thanks.

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fc9f096dff313d14b96a4d7d2724f9740aa55d61..0381112f05e6d48f70f4941abc3=
af6e9b6b148d9
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1617,9 +1617,8 @@ static int __tcp_transmit_skb(struct sock *sk,
struct sk_buff *skb,
        if (likely(icsk->icsk_af_ops->net_header_len =3D=3D sizeof(struct i=
pv6hdr)))
                tcp_v6_send_check(sk, skb);
        else
-#else
-               tcp_v4_send_check(sk, skb);
 #endif
+               tcp_v4_send_check(sk, skb);

        if (likely(tcb->tcp_flags & TCPHDR_ACK))
                tcp_event_ack_sent(sk, rcv_nxt);

