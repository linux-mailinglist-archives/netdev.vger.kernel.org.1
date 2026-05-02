Return-Path: <netdev+bounces-283467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPq0AtVK9mk0TgIAu9opvQ
	(envelope-from <netdev+bounces-283467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 21:04:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EF4B3466
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 21:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78133300808D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CF3876C3;
	Sat,  2 May 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ0AUG7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911D3876B8
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777748689; cv=pass; b=Nk88wmtds8NK8U3M+wTrlNitOzLL/l3uqo6ve8C/wZEmkRKIOAtAx9e9PdhSAEJQS9ZimR24bT1E1mjaDpL00KuZ+zcYebANOolxlgbvLLJ9F1Za885TiOu+21eUYcIMyrC3r5ZuccvVn1KSp7+INus/LSOCeCRzsuouB2+6XMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777748689; c=relaxed/simple;
	bh=JabJJvGOVACFB5Q05Gm+KwlOst4BTOxQbBgtxJNSxhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djX5xcbtTr1ti+JF7+/Aof3hDG8B7nYJTLUhqpbJmYrJl2vlkwubZ+w+h8OrsBUhkADUCkgix4PQTB4NYNT3t8zkXyoLeFn+nbAVkxtSAaxukXhuGSdJ+A7JPfYlocoIAS+JW/b9enW+DZAcGedef23RA/imLAVZQxxkr+j+Ev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ0AUG7d; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so4020586e87.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 12:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777748686; cv=none;
        d=google.com; s=arc-20240605;
        b=V++muUvN3BBoEYpKjZ5UcgfDBkycq4wkGqaPe8myJEc82PYUXui5kopyzMv0xwqCgt
         uWTRlW/52hPaOsoLExDOHu9vAZGMvsB18L3Us8aXtvVQjjnczYLIjSPP0hLzfw6Hm3q1
         NljV3iauAGfEYSfh64rvtZ4pxdpNjhgF/QC4IGovrirkRyH9JjIK3g9DiRDh6imP+NgW
         a5d8z/e6wbRhRfQ40bFvREljvFKzaee+GxEwmKcSZtZXJTkqCF5Ocfk+yQTRvMRJGQR+
         l6/XUGzqf40vxzak0Up4OlxdF+LiSQWgXb/pfOOiBg+sQBUnh2q/GG+aS1LQNg4xEm9A
         GiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        fh=fl5Ps0zdjwMpHnAWUfF6GrH570ZTDT8hu4ANVFhv0zM=;
        b=HJiUwT1awkCOI8MT/rBfUN+yiAPq3rX7ZK+GzSGRZju/169+Tk5iNoJXoqOjTY+RpY
         ovM5v6zX7esZDIOkzgXNc2fFuq3Ex1Ul4RmPPDQ0cU5jdDq2LIG5xm3/GYyG4HYqjNUU
         uYJohiWxcuTz4N2pkL2Nzlyd8CIS/z4n/vbi302xZlsdtVt4Wd1gHpGd8jaBAnbu6zfG
         UDU2Ue9g1XagcqaBNM9RKAhRm4aBGQ4XAgqhqzi8/JJh50ac9ytQOY0Qw4latwDqhMaf
         JOjs71DeqR13PTq2XmYfYS4U7NOUKReZo1KKa/yPQTZmnUIWkqv4v+H7sTwFhvixO/ir
         KRKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777748686; x=1778353486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        b=tJ0AUG7dhkSzOJzkp5ME5CQTf+lbbkBHLNqtJi2+FQwaw1VuFN8ybt//bO1oO5tdD4
         RnotA4P4MEVgVtLPwxRwVyq3IA3nXyecK34EQO1Aln5e3iyf7+5UsHNwk31opsUc/t86
         7TyNGkFPb7YMvhnhJWWW/ZxQHo409VISb8XYTshKOKA61WnDZQkp1rCp1pCpGvXcsWHS
         WJGa/ZCvsJmsEIZHRFF9KVvjvSwd08XFVgOE9ndJBmDFfhBkM2hlMTl86o9KAoIoBjzx
         AOumvS8S+4Dd76GtKVNOiBpt6PQbMBMP9ORbAIR2YXc03qAu/sxfv11rgzYTmlhHnJT8
         u5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777748686; x=1778353486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJEn27V6OkYesuaUVcNgLy1Ezf+jQkNNDAQg+5dVDzg=;
        b=rMiQIrumuaA5qaY+gKdoD3No+ea198yz3CkzMV66lc00x9+V/XjHGm8fOF9QSsM9Jr
         COkPMuavHpIqS5hkMxtEzvdJmOFBmtn8zfcaFtEE307mr9wPi0GyrSjZA8i/bzIjHc2/
         qMTc0lzhCuav1sq9r6V10rF8aoOpVL4/N4GzbJ8ujhcdGDDQKMqL0/ck67k2UevblAzW
         i8ObwkrI9OYwlZ5Feg22ypyxVxYl5W4xcviQ2q1R21qFKqYjq5ODIPK/OuFpq+O8nAtE
         DY4nSCP0nn/eEGv9UDqu5+OqgYN4KxN4tnOOqCePce1BSzGrC5jq9PlRxFW0ox7gMWPv
         3kGA==
X-Forwarded-Encrypted: i=1; AFNElJ/V+SKVgDri1Lq91hJB+RMcS4961ZRLz8ihJmyd0kbScziwVmldG1Q3Roc5EHCq/MO8ShDxCNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPjlse/fWRpfHsv77tU4xdPC4fydLFV2V3vY0x9ZbgvqROpxO
	F5l8cZGn53gpkrSkgRuNZbN50V8ZpIGjXIq7JOi+HhbC8ax/Q5oX2V4OQYL3Xl/YEEtHllHI5qc
	e/JLz+v4YhbY8CJJbs2wqgfQxxKoxU2s=
X-Gm-Gg: AeBDievQC3fF+t4FBhAp5q5nMTEPGii/AuVGtqhjbyQgC3ApypvBbFL3zCRrYYg0rmB
	DJ2pu15OSEHs7479BcpdLYD/gyu12IlPIDKCzuEV3ZZo/gozNfaaSxqtGOoAtTnKKBEDRYgj0Be
	V4VNYy+zmO3sKYWBBxSRjcLgwtBFy87ZMPOVSd7L2mQ4RwxZT3cY+rOfHM09w4BNCq1sGcNFL/Q
	7UMviyDezv6TxE0PJ/uWxIutON8NtOyWC48ZGjgqbwOY2u6UmQOa9hRnB9Z1KFUYHmYxU5i+KWh
	3+QM0vsM1egmqXRLXt87yuATVd528TRdORqT4XB5J9iMq39T
X-Received: by 2002:a05:6512:31c9:b0:5a7:46f1:d96a with SMTP id
 2adb3069b0e04-5a862ec3439mr409761e87.13.1777748685442; Sat, 02 May 2026
 12:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-2-kerneljasonxing@gmail.com>
 <20260425054032.28A27C2BCB2@smtp.kernel.org> <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
In-Reply-To: <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 2 May 2026 22:04:06 +0300
X-Gm-Features: AVHnY4Lr-W5067WEgcSeNunEx2Jj-8DqWBliGYLjrFqxjd89zBTtZWswi8YtXcc
Message-ID: <CAL+tcoDcOz0q9MNNOfgYdt2XAKHAkjFW=r-seHifYqyMH3RV5g@mail.gmail.com>
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, sashiko@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 924EF4B3466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]

On Tue, Apr 28, 2026 at 4:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/25/26 7:40 AM, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_=
help() triggered by pure-fragment SKBs. It successfully prevents the explic=
it fallback in xsk_skb_metadata() (which wedged the TX ring), but leaves th=
e implicit generic network stack fallback vulnerable. If a user sets XDP_TX=
MD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checks=
um offload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the=
 core stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed=
 to remain active even without checksum features, skb_needs_linearize() eva=
luates to false, leaving the SKB unlinearized. The SKB is then passed to sk=
b_csum_hwoffload_help() -> skb_checksum_help(), which hits the exact same W=
ARN_ON_ONCE(offset >=3D skb_headlen(skb)) because skb_headlen is 0.
> > --
> >
> > commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
> > Author: Jason Xing <kerneljasonxing@gmail.com>
> >
> > xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> >
> > This commit attempts to fix a warning triggered in skb_checksum_help()
> > by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
> > drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/#t
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate=
 function")
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> >> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> >> index cd7bc50872f6b5..d981cfdd853578 100644
> >> --- a/net/xdp/xsk_buff_pool.c
> >> +++ b/net/xdp/xsk_buff_pool.c
> >> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >>      if (force_zc && force_copy)
> >>              return -EINVAL;
> >>
> >> +    if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> >> +            return -EOPNOTSUPP;
> >> +
> >
> > Does this still leave a path for the warning in skb_checksum_help() to
> > trigger if hardware checksum offloading is disabled at runtime?
> >
> > If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR devic=
e,
> > and hardware checksum offload is later disabled (e.g., via ethtool -K
> > eth0 tx off), the core stack's validate_xmit_skb() will take over.
> >
> > Because NETIF_F_SG can remain active even without checksum features,
> > skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.
> >
> > The SKB is then passed to skb_csum_hwoffload_help() which falls back to
> > skb_checksum_help(). Since the pure-fragment SKB still has a headlen of=
 0,
> > won't this hit the exact same WARN_ON_ONCE(offset >=3D skb_headlen(skb)=
)
> > warning?
>
> My take here is the issue describe above should be handled separately.
> (And on top of my head I don't see an easy way to address it short of an
> additional check in the tx path, which I think we want to avoid).

Agreed. I've already reworded the commit message locally :)

Thanks,
Jason

