Return-Path: <netdev+bounces-305992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G9iYAxe/TmqXTQIAu9opvQ
	(envelope-from <netdev+bounces-305992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F8572A7A5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:20:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RRBVLDkl;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305992-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305992-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 103DD300251E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76D3E5A07;
	Wed,  8 Jul 2026 21:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0E3AB29E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:20:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545616; cv=pass; b=PwqHXs4BaH9gx5ILT1VIDwqDfGK5HlZwNMoPkCzKeyOp9N14o7tYS8M8l8Gd6EArLwK93eIX8ihnVnp8/R64wIdPx+XMoqk+Y5B/y+Iz3ZFYmtf+iJRI0vGrjrnU5IbbKFK86rgvNmez99LtiD9vCPiC/rQbftTbBKEKF4QtZR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545616; c=relaxed/simple;
	bh=i23ourEsmh0Gz+WLPq6GnU7Yy/el6Z04qG/MBr41xFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiWj1CBj8x2cPVV3QMluE0K/2Tm9gNay+ucLDCk7rrIHfahtel9LzHr6iCZw7vkp8zMqPaxOAH/t6wphlhVgLsTPUoeHPxkA5b5YfuFT3zYQxL7kroMbUeWj1gHsv9SIuWCjISlUuLJjNClhwvd/BEPI4tu+kWtaX//cjTiJIbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRBVLDkl; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845c92bc464so809576b3a.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 14:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783545615; cv=none;
        d=google.com; s=arc-20260327;
        b=D7dPke8+6hriJSfRtAdacNj1vUqSIONhgddpfXXzbm5s9pvFGD5GOaYS3kpyatn7nv
         MNw3RUbgOXDL1K0f0sJazh2J8I/kmpG44tbPhDPEGD+1/MqvbGzuNRwUt1ZnwA74oj2r
         b+T77ECDbN3BnAS6iXq2rVsTcQYcChoNPSnvYxxkST4/LmJMqGZmITEZ4ONE+L8Gh4wb
         XMN+1bH94hSWn8nf0H/aaIjn9D5c7+vX/jwT8SiiTp2UXarcGh68EqgaUI53io6Xhs+F
         OzZNeiffYZEXCukZ6eR/IAmNY3+b48gyjMV3iNvYlr/8t4GvCWVpEdVq1VZWtF+MbTlf
         mduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        fh=UptUDbsFeMc2AP8tUHSzrODFTtMV4wTKjQXeAL1UKPk=;
        b=tAhPTvC+gFYaE9lHdDYP3m8Mo+ew1RIlBs3efZDXvwgpHgCsXJfk5JAGCxoAGLXx7+
         ZOxpu2IrS1XIJcPgjQ9vhJwJwuTefnqwIVJYZcsEUyDhD24cPRUaXPmtaWCwQIRdgzr/
         qEcPsmJmdI1UoMGiCICPF295cAskKDwt7PWLl0xxOhbgkzueR+jvi83fo8iVENfZRMcn
         yHoc//IKIAz194+bTGEdCllNITcJoRRUuMwe7zSOMGwqpTx7BB2XGufKTtm8U4aUtXrf
         +vLegDLDgi6wFdinf3nfdcLpwDlA3s3UV/UJJ4Pniv/KurPlKCIusy1IluVgouYgRq28
         z3rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783545615; x=1784150415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        b=RRBVLDklhMwWjlUZHUZD8mvR1Ulgy6EhrBuOuqJ45UxOyFdM9dWzEX+ECE27P4fI3a
         O1L3CTz2zFahUobZZuDsia2OUGD1ixfoND0ponckTFe+lWaiBxMC6WQg/XFetMso3pZP
         YRBmVbNWzarLfTcxa85ytbjyPx9yMdPXkwhc9IE91/8acV3dV7HAiAcDyuZ8sYeSk1RT
         O6s2keNUwINZfgFe7tCRs1GbyMZ6KQD0IYPhX2lkPqWzLA2snxZF80Zm6dcRtOFdOJUo
         /HDvcwqIhZ0nNBu/wUtBf45ELui1xTI24KxaiEvuxNe4k9hSggmwRSDHkAINW244wWpw
         j0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783545615; x=1784150415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        b=YQGeTYQ1OzPi1TaJZt6RqDCAEJ8g80501YKHmVwH4ZxWK0C4YA9YSiPrafNVumh7Gw
         D3i+H5pShYei6pPHR1wPi6xjIhvi8KSmcVvVMsT+qw2JdjuVrhAmZl49pPfc3Nv4dTdD
         7wL2qioA6XYkiCM1Pk0KQ8aiOFceQQXrmLDI0wPX2i5bCApXCwXu0OUlLl8D2h8UTNfB
         GLiFPNhqY55V5Xpa0om87VrlBdgtEzoDoAjmndvhzINavjdNrbmy55801ZIjbVam2Ll2
         bvUE3zI+sgpMC08vJOiwgRxGChGS2xSr9tbJWBc4vBbJjne5jgabY8+UpanD2Gi5AN5X
         fFzw==
X-Forwarded-Encrypted: i=1; AHgh+RoIwPAlRQFnyiwm4KlTQqvh+XWiBiex6quLlRWHPSjTXNFi4nhMNonYTevm6IrnJcoLIbmterY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXD8J1ftYbh8d4h6dxljSCuHgYJq9QQhE6xzM0iOIp4LQDkwV
	EoOTBXRCoOvhALJnO6o+cq5S4YZGBBWRqQwrmHxNdcS5V56kTaMrCtG4YlSi36ZZQi+FY6HTy6A
	xQsRWyYHaJbAKxKoAnWZsEEcJLi598Vg=
X-Gm-Gg: AfdE7cnSojScSQ5P4SyeB8tFa/1/xQbKe3S+RioVCD4kCBXfaJMy8sF9l3XIcEvgmOH
	Dj02/BbRIpLqjnlUsz2tWuh23Piao1Wi+AsHo5EdZO3H/dpLGn65dIDFDkQLGZd8ailZkrL6mwY
	xTGIlqEUMVH12kXuYqxi5qYEBX0CENATOjuwQ8froiw7QV/FwdzrvOkt3j1Xnyf5NH13fH33vmm
	sSIeOwR90Akz1Dop3JIKGwC10wnTcurP889aKq27LCrYcFGfl35QTrQ4XBVA2qjhfIRom7t/Dam
	1TZrFKwFmTXc/sadFOxVlCNvSwJwXoGL45aEdtsqOVgbMJ6OUNulaHaBRdE3YJivk5aQNVdf
X-Received: by 2002:a05:6a00:8f0b:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-84842fe8cc2mr4141328b3a.15.1783545614779; Wed, 08 Jul 2026
 14:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707203215.2752-1-blbllhy@gmail.com>
In-Reply-To: <20260707203215.2752-1-blbllhy@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 8 Jul 2026 17:20:03 -0400
X-Gm-Features: AVVi8CcGemzqA0x8h-my5ThQQjmDgAX7MqMFTaMXliUpxW6XbifMPoB4xUZHmpM
Message-ID: <CADvbK_fTrjLmFK=ZwGjU=xnDRJ2W_3eewATJHw+kZt9caUsAbw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate stream count in sctp_process_strreset_inreq()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305992-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,microsoft.com,linux.microsoft.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07F8572A7A5

On Tue, Jul 7, 2026 at 4:32=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmail=
.com> wrote:
>
> When processing a RESET_IN_REQUEST from a peer,
> sctp_process_strreset_inreq() derives the stream count from the
> parameter length but does not check whether the resulting
> RESET_OUT_REQUEST response would exceed SCTP_MAX_CHUNK_LEN.
>
> The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes larger
> than the IN request header (sctp_strreset_inreq, 8 bytes). Generally, the
> IP payload is bounded to 65535 bytes, so the stream list cannot be
> large enough to trigger the overflow. However, on interfaces with MTU >
> 65535 (e.g., loopback with IPv6 jumbograms), a stream list that fits
> within the incoming IN parameter can cause a __u16 overflow in
> sctp_make_strreset_req() when computing the OUT response size, leading to
> an undersized skb allocation, raising a kernel BUG:
>
>   net/core/skbuff.c:207        skb_panic
>   net/core/skbuff.c:2625       skb_put
>   net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
>   net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
>   net/sctp/stream.c:655        sctp_process_strreset_inreq
>
> The local setsockopt path (sctp_send_reset_streams) already performs leng=
th
> validation, but the network packet path does not. Fix by adding similar
> length check before calling sctp_make_strreset_req().
>
> Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Rese=
t
> Request Parameter")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/sctp/stream.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 5c2fdedea..ea3805712 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -639,6 +639,10 @@ struct sctp_chunk *sctp_process_strreset_inreq(
>
>         nums =3D (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16=
);
>         str_p =3D inreq->list_of_streams;
> +       if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq)
> +                       > SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_=
chunk)) {
> +               goto out;
> +       }
>         for (i =3D 0; i < nums; i++) {
>                 if (ntohs(str_p[i]) >=3D stream->outcnt) {
>                         result =3D SCTP_STRRESET_ERR_WRONG_SSN;
> --
> 2.53.0
>
I think we should also prevent sending such an 'inreq', since it will
always be rejected by the peer. We can add improve the check in
'sctp_send_reset_streams()' like:

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index ea3805712b76..51a14d1f2391 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association *as=
oc,
                                        goto out;

                        param_len +=3D str_nums * sizeof(__u16) +
-                                    sizeof(struct sctp_strreset_inreq);
+                                    (out ? sizeof(struct sctp_strreset_inr=
eq)
+                                         : sizeof(struct
sctp_strreset_outreq));
                }

Nits: Please keep the '>' on the same line as the left-hand operand and
indent the continuation line using the usual kernel style. Also No braces
are needed for a single statement.

if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
    SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
        goto out;

Thanks.

