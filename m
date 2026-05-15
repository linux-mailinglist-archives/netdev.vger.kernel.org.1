Return-Path: <netdev+bounces-288156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDu2BjODBmqdkQIAu9opvQ
	(envelope-from <netdev+bounces-288156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A5548B3C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC333050CA8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3383A7D6D;
	Fri, 15 May 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BeSzxk08"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611E19995E
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811519; cv=pass; b=baIBR3ll4LWV/GWiYbiB7GHD5e98rI8mJLvKBSiPBg5j+SPkD3NHrvxKN3PlqScSKAbulbl0Qoi98eIFVdngR29No516lrx44OqkMbCzYGjeyGfGTfD7sok/I0DzmcZpJ09OfY4apq6hrrGmb724jTsNXZwV6AYGI6Om+97E06g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811519; c=relaxed/simple;
	bh=oY1lQ3P1ZilqdyP58U4Ykl0lz4M/f/VmqSSrG9PPckU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFnqqt2WQuepausckJp8l3ZKIhrcugARzZP1ZDNbRhOs0F6Rl51VzRK2VHrQ0nKUdfTyoGfSuu7oig09cPcXCsBfxRDOPomVqGZKEIXWApB//lTwfqgWGf8XSgi+iWzsg7vXkIzPS74c+ECPmnRSqVcxGMb87yABxET+aMnzNlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BeSzxk08; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bccb978bd9so2689095ad.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811516; cv=none;
        d=google.com; s=arc-20240605;
        b=iMhs9g3JXZo0dQyq8Twev2mkXKcSsU/tVFCbXZceiVE5NoelCteEZzVUm6cNMiku+J
         hJTAM1mF+0dqYm1dj5o2W5IUcQJGFXZWaPUsO48JwofiS7Fsn6akSwDFd9rxfHd+KP6w
         mEnPemRNJBDPCM6HOBlwJw8Ai2Vq5RR+PfEkO4DIVhTaGyqXsWBvKiFd2DXXliqBZtQj
         4KdlXRlk+yZDtHnlObu7d19V9I2SWJ7fC5rS4CeozD084+F6AqZtekpH2DXd1bRU+0Dx
         yKCXtkSZnOQvKm3s7K1YL0k4GTM96kjrYMJLSza9bUXwhdcQnAgAbi5dkC6NE2mKnvmj
         238g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        fh=L0/u1wew4wN72NRAb9wUXYcZBabwz1zxySnTkDtDoI4=;
        b=cj2hbD/+OfhNtCq7cEmn+Q6pGf4Ah0gk6vLRZMty96rLYeRBV4nMlHKfceuzuIiAVM
         2nqD8Afla8Mpc9UNX8g//FADSOBKsfNaPSD4P4q7u7Qcb2gZl0UPX6urXJwwVCSyvQ9H
         QuKeYZGeP/Nrc6J0bmBAFy+s13FLnkLbLiylfG9EhpiG+0h/gwY77ys5Y5DeUEZcuMm7
         +Z64esYsYhb+CPLAtw6U6kqR9RKxXePec7f99rFjTSr505i53wVsfWcjSSjK8DyabyLP
         sYp/ZhZghLGYV4jf1KfMmw2MLrYd4hTDrbuwmuihEes1YZuddz5D5hGNXX9zfZyZ3e07
         DX3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778811516; x=1779416316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        b=BeSzxk08I6OIcX5iAxYgjXq7o8x55BHd4YNnY0NS0217WkmNBRoPx0ue9miJrVdgZg
         y7oohCL6jEYgvtp1qavdfTfkhewOz7vvNElgtJKdvoowtPepwnY+QvKySO8U4D1wlpAR
         89Utpntaj6dQv9pu00xPx0Gg7bZ7b1l6WA1kXbEZLqbKKSZo66BJFVNXRYSJt0iSkLLu
         y+jSDP435FCT+PDEpWalNTX8dRx+5In2SIkE6s7TLhIzaWwzzWw54DpQM6FCYLLbGnNa
         CdU09jsTbgqhUa46AMsRXSwv5urvGKkivAlzaw5WqFtj+hzORnPNIIITXqMi36vCSUCj
         9WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778811516; x=1779416316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        b=lyRNtQKC+Dejdto/JOqX3UsaDj/7Xx5ySdjdw/kyA5UGaoBzO14P4kaU1YWbwRp2oW
         0RsUpgX25niiLel9eBxxPeUIiZ1RvqdyOZDCM2UGW2D3yIdVpdqsV2qovlbxyqMIKyNr
         pmvtO0+XA/kd0rlgzfrvoA7BraYrREXI11UYpHsF9mbacvERyxvq/lgW3EhPg2NsLT5s
         DnB4wrDhQZi5NIKNna8VHz6flhO0hULcPevV1yvh0LRZ1e/GvtpI2/a2b3cp82mgWJG6
         7+Yx0malLxL8qgEMHtUsHU1QRHzfASFViobjrDIiKeR2A63RWPYu+Qa1mpf+VirpMwJE
         R3TA==
X-Forwarded-Encrypted: i=1; AFNElJ/U+ehkQseUUATWGYAaF+IzFPJMdFlTdMd6wQiNPrGK7/rl+d8uRtiMfiEX5GBoHFgD+mMTKNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+w1ewxmb6J5ETBO1wZsfNXkXkoRXuYTBKZxzAdjXPODG7q6Ky
	piegp+Bo81pA8mTpoh1aCMdmZDhUVpqMggIzmlU/UIOYsIRrHWEoLFhge9ImEkMNYbFJZXM2wmw
	/Q2rUHWOknpnv08rpDISpY+UaVoq6QG9yH8RtR1jB
X-Gm-Gg: Acq92OFZO5XEf49ND053eap6eHtGvGkPIBp8z7dURwEDFp+OhAgeHhstq7ZUNd4G1RH
	1dzaFeeQLaNZF4OBpbqM1GShzr7mnthZhpytbAGx/QOA8ryfiPBhPj3TxIhedtcWDLwhd+N7L9S
	Fl5nYz3/4/hnJ7sNo4t8Z+nBTdO6ryEY5eKUMgSVyXMFlc/HeDQ+xidtJdEjsmh2IJJTx3vq0S4
	+Fs9qB4BvwJUjn+s7Er3QMYOq+wUyDcBaNlMeOyBbtFPyNpEiQ2ArnZYm5uw3H9s4a3PfZVfsT4
	1n8s6cU=
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2bd7e7f4367mr16519065ad.4.1778811515808; Thu, 14 May 2026
 19:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165139.436961-4-tpluszz77@gmail.com>
In-Reply-To: <20260514165139.436961-4-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 22:18:23 -0400
X-Gm-Features: AVHnY4LQcW6Jta9CPrYmHE8qeHN2b-YfTvmsWi6kwWzlqgcNGjKECLZviQqmFKs
Message-ID: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B01A5548B3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,codeweavers.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:52=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write
> reachable from an unprivileged user namespace can rewrite both bytes
> between parse and the SELinux/Smack peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <=3D skb_tail covers the option and its embedded
> bitmap.
>
> Runtime confirmation (Smack peer-label policy + nft HBH mutation):
> Udp6InDatagrams increments to 1 with the mutated cat_len, showing
> selinux/smack_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path short-circuits
> at the bounds check and the counter stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 3583fa63dd01f..4af8ab76964e0 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1399,11 +1399,20 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>                         return 0;
>                 break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -       case AF_INET6:
> +       case AF_INET6: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_data_len;
> +
>                 ptr =3D calipso_optptr(skb);
> -               if (ptr && calipso_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr || ptr + 2 > tail)
> +                       break;

Is there a reason why you simply break here and drop down into the
unlabeled code?  I would think we would want to return an error here
since we had packet that was munged.

> +               opt_data_len =3D ptr[1];  /* IPv6 option data length */
> +               if (ptr + 2 + opt_data_len > tail)
> +                       break;

Same thing.

> +               if (calipso_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;
>                 break;
> +       }
>  #endif /* IPv6 */
>         }
>
> --
> 2.47.3

--=20
paul-moore.com

