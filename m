Return-Path: <netdev+bounces-283657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i5/mH3mc92mqjgIAu9opvQ
	(envelope-from <netdev+bounces-283657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:05:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AF4B7119
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5B73005D17
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599E30276A;
	Sun,  3 May 2026 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu/7hIjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C32F619D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835124; cv=pass; b=jPEYyUTYF+U2BXym/IHs3VSQrtU3Cz0UQUNH2OpWjbnTklmvw8DP6Futc9MQI9uuleO6iwqxxkK7bDd9KisyhV9WoaitoPtD3Vqi/i5VxY8qE7DLOZvR+kf02/i7du+bec9DzJ2I1AAaA5jExqL6vsczFXbXQP87eBmvO1y403E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835124; c=relaxed/simple;
	bh=xggGsWTaF1GDGwgbViwPyqOX+vgGeNjZz/9vlU/UAQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsbXuhzwr24Bn3y8QvlsX/m7ZTN63myq1HYW8Up2GqVock4a+w0k41aN3hUfiz1fLbm3qtryViQ+ActWBvSLRV7TiifJJBZLeDBoB5VH/pG9eT3mxJQ1zvecOKwviJ1jaeIAhalsMD3NffDSbEK2L/RpW1CJo1Cw26of2nzX0dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu/7hIjR; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726ef332so5270085c88.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777835122; cv=none;
        d=google.com; s=arc-20240605;
        b=fIeIoQF/7SpSjKV5gmCLbQo9Hjh2OvsoNe7T5Z3B4g3QqGP9VmsLCf1HVkZPZdTLtZ
         1WRICBCTZtkbvdDQE+vIwMXprxrV3lqjkuNBZtpR1+asIS/l9T6+wNe4hyr6/mO56iVf
         ePUb2wCzCeJ2x+i3jU0aHjG1kI9l9vUKNZ6bCVsVnfGCgOgnji3Wm3UPxHkc0Upf8Y0M
         OZZIQm01osp7bT2D8s4yOy5NYu3ObP94yOYLflu5CelBa0ZIRWAXcS1dEtLHTziTu1dE
         UYvX9BaYl3hup7tuSguJA+RdtiD9wLsGIOOqHKNx61V8JEuBIZTx/F5nxS3ctBE8DDy0
         TXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yjTBPAUvmM7RV1CR+zbLx7BGUBJ7Hg6OvTM1X6Fkmfo=;
        fh=KGyqiHeplBsWdN/o4Ojbp8VE7kANLLIVFCl4WhW7jtk=;
        b=B9ndWPs/oHheLBuPkir97j/jJ/QLD0I9UmfxdrhnoFanur+wVX/Isc1suVZebvBLyO
         lPGpPJ7f7nyYOGYN86zvpxJ9+Nh++ioVCRwzLAAZ5nXvuqcDN+D7CgVWfky1fgZy+BPK
         R/x3hZQf0R9fol/CYkz+Vn45W8fASJS8OTb2AbTtk1Z55NQOeOfcLKhzZZcmW5W78tIe
         C+HcCarlV7g0uuuGtsPbp85UvYQunYYRdXHYxwaFLJuYE6NwnY4MHDsC9as8SjL2SjN/
         JorKxKfCF+qAwOKW2m8ENZeBCJFnZJHVbR6uPChoybEOuF1cSnzic2c503Dxd32eKyKn
         9kKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777835122; x=1778439922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjTBPAUvmM7RV1CR+zbLx7BGUBJ7Hg6OvTM1X6Fkmfo=;
        b=bu/7hIjR05t5AQnowRqJIcU9Cm/8qLIIuZHW5qH9suyp1nphvZngEVC9Rz74kZMHVP
         1FJAVbyrgLjoIjVsyYlPMo4VNZeVJbmf52MzI5hb6bfpR3o8mYiYWfwgscHM6QncS5QI
         P0vynYJpZUBpLJsf+1robxlmYGB3Ro/WP9iny7PHsgFXw+zSeDVgbuNgn75fLWANKW+5
         4h07vZJBBmCGXvImqqgRneFRPQFDYHtPNdPuo1l6L3ScEitN7CyrKXPSVmGazSdLTOQZ
         PYdp9Tg0IXhN+J20x9YsmwvpAwrHJjsKkGZw5fVElt1G+bN++CvC8RztV491JZaHD88s
         dmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777835122; x=1778439922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjTBPAUvmM7RV1CR+zbLx7BGUBJ7Hg6OvTM1X6Fkmfo=;
        b=EcFlgF5VLmfqIPd5p4HScc4R/1o0AOX7UQWVNUpYa4merK2GeceylmBrNFGdEdeUSl
         7aikpnGrQHNnaYYhwcgWaYfZcvB8i+ve7SgKUgEOAZYFTMAQEFyIR49DGz2P0jSaebSx
         U8lWgNDzqWEtNZN9zfHD3AFkUhpbacjOuZLPE/nF3SuM85wrqk7CzWtnmIjiGz+GvPze
         syfcMMurfm04Or9un1o3+2l9ie9sQhXU+kcAO4O4qxqLVu5dJvJu4oVUe5V/dU8hj4WT
         A/dmxXNV20PfDhZtRJRS9VW0/rjbIOPhgOTyIms7lPN1Eszhgl8fgFaeX9CNS2SfhrDY
         niIA==
X-Forwarded-Encrypted: i=1; AFNElJ+noX50X2zKdIhXD2jBDcngmEREtAIH2z2zfcrN8QYwppnAgzofm5JPZdCP/UIXBU8LQGNRZd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8D1l6xQTulAU4th686iXGdlhEn9U/LFfWqOvoYvP1QagjpIR
	PbLbvLSyo/GbdyHgCDxMMY62begmsetr/Cy+GWqKRwAM2435VcSkJ7sC3sEBT37z8xcoK5X6HCV
	aLmHCE4CLCWBn0uJv12kQQ5/H+h6LS0JJLFcTbDev
X-Gm-Gg: AeBDiesqEBYg1kCYtsyA2qgIAoudUru8eRIjc0WeWXPUq6OHt9kjLqyai+/HcFc+HGA
	ilDXXvdg+8b/+ZEL8z1ZvrcmQC896DozRCvXOa2rGpk8meIkuAXcy6Q8SePDEhyHPEkDeQ/jMET
	+XMMRGT6MA1vujuzKVUUs5xN7VuuGAoaMIUTOD5CU8aoCZmlkmqeNTzABRZuphu01iEpFNSjR30
	XpkyWoO/FMbjAVCb1O23Do1MxwwozOU25lBM5XmP4G2mkB2NeXW/AFFz8hzy8iFf46FxbozFaQD
	bVycKvDdWdSayjjso7ZCbv+jxrxENQvdUVzkdJP7nfFsRL32So6BmgmlDiZrf62uFdxaQZ1VWcD
	M/WyxBo4PBTVmaaBEbKKFGf41Uqw/CJC9Q/bg+4u37/8/hFc7rPV3DmrRKHD2qu2iTaohCI/51w
	==
X-Received: by 2002:a05:7022:e1e:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-12dfd7ac2afmr3179255c88.1.1777835121111; Sun, 03 May 2026
 12:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-15-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-15-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 12:05:09 -0700
X-Gm-Features: AVHnY4KGCVDzFVU1e0dv9uDqm3NUiwCjiiyx8sa6SVcxv9kgJL1I0C5b8jwWehc
Message-ID: <CAAVpQUATEzQJ6oOmBr4TCT5+dCuFrjTxsKULaPhodM1xhpwJYA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 14/15] tipc: Store struct sock in struct udp_bearer.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CC2AF4B7119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-283657-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

For Sashiko review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> @@ -793,7 +796,8 @@ static int tipc_udp_enable(struct net *net, struct ti=
pc_bearer *b,
>
>  free:
>         dst_cache_destroy(&ub->rcast.dst_cache);
> -       udp_tunnel_sock_release(ub->ubsock->sk);
> +       udp_tunnel_sock_release(ub->sk);
> +       synchronize_rcu();
>  err:
>         kfree(ub);
>         return err;

---8<---
Since tipc_udp_enable() is executed under the RTNL mutex, does this
explicit synchronize_rcu() cause a system-wide stall for all network
configuration operations?
---8<---

Yes, but this is unlikely error path, and as mentioned in
the commit message, we can remove this by converting
the following kfree() to kfree_rcu().


> @@ -812,10 +816,10 @@ static void cleanup_bearer(struct work_struct *work=
)
>                 kfree_rcu(rcast, rcu);
>         }

---8<---
This is a pre-existing issue, but does calling dst_cache_destroy() before
list_del_rcu() violate the rule to remove objects from RCU-protected
structures before freeing their resources?
---8<---

Not related to this series.


> -       tn =3D tipc_net(sock_net(ub->ubsock->sk));
> +       tn =3D tipc_net(sock_net(ub->sk));
>
>         dst_cache_destroy(&ub->rcast.dst_cache);
> -       udp_tunnel_sock_release(ub->ubsock->sk);
> +       udp_tunnel_sock_release(ub->sk);
>
>         /* Note: could use a call_rcu() to avoid another synchronize_net(=
) */
>         synchronize_net();

---8<---
Also a pre-existing issue, but since dst_cache_destroy() releases the
underlying per-CPU entries via free_percpu() which doesn't wait for RCU
readers, does calling it here before synchronize_net() allow RCU readers
in tipc_udp_xmit() to concurrently access the freed cache?
---8<---

Same, not related to this series.

