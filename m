Return-Path: <netdev+bounces-279063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID+xFzrp4Gl/nQAAu9opvQ
	(envelope-from <netdev+bounces-279063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:50:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717740F317
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 747E1302B592
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BF3BED7A;
	Thu, 16 Apr 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzcjVm97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AA39DBCB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347225; cv=pass; b=XRZoPFAz9+hkFvIb2mQTT1kybAxiYKLUVwPs4rTWDfaLUu67jddPdhhCMk4v6fepJYAnSCjzP/B4R9/J9qr8U8D0wIZVbczzvEJ8dQnF+yO0yJIyT+Njdbgr6eCp1Kgg7IKhXYP3yCj/G+cxAce+1swhQjVIBQGuZh8tf3MGZ1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347225; c=relaxed/simple;
	bh=uwqwZWO4cytEM0TWMFqBfKh8P6MuYsz1R5OR8hxVdb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPmQIw0emua4RLu8nKfNtoG5+XKwp4IWDcenYrsz/hCqVHPBnyRm1M+hAeuGpbQ3dEnwtnRaNDGRb1I8Ot2KrAqXrpLXrvceC0EQVC39arjVUZEE4u8Ew3hW1LD6w0R335+7q6rKgsY41zDXpBwb9MX1gZixzbDeOG/MsupfQs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzcjVm97; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8296dabef74so7100572b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 06:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347223; cv=none;
        d=google.com; s=arc-20240605;
        b=DfrU5jnkZTQ+jI8JYbiOJbERzBrHBcdCn+rnjfFrFkEqqeqlUfAA0Ft5QiaxNjXUpN
         ynJKibWjSPlvoFHx5TGmX7pUQME+NrMz/ey1MSlZoT/uZKcHw5FK5MSPg9+AHVV2YFKE
         aIWFd0QnzfP3hqPJPFsORHsCjhTKyZtbyvn3JvfuH4laBV7VXmW0lgSEoEh3l8vhB4ew
         gQDKHha7juII24/7QOXKoJ5sr4v0mlwNpAm1eOnAN1j6p6gH9x9ovXurPWvM/N/j8oT2
         3S4j+Hc8sjwSRRWNoUYBqog3B5fip6zIVNnDUuim5CU0LQHkGhxTQFzgdxJgutZn5Zw9
         D/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        fh=AswJaQEfTKbdt6ZbePsOakTCUzIqXqzPnofBuVHML4I=;
        b=LGD32NVm0wNJ77lgcFY5Yt0ABvY52gYZMKWFbNVeiFU8DdadBhJ6jcdBNyEmjjCTKx
         tvBc6QY7afyu6MblyXNmgfphSAlAcvvqh47/monmKT4y0eIEPM7ftb3cBMNl4xN6pmoz
         5u/+s6+y1nHdaTOlmFTbF5KpD+QnGQcirsAWQv/GOS0Jt1+WI9tmTpauWlZX1KjwKOG9
         IVxkr3cWBoNJ8PFmYFuw3edSbrHoD3khFr/g9tq0PbENHDBiDbQQvJjKWHoi62zICnXi
         3NjNOBCQH+iiA4GfBlNod2BkFVZrJNpPEKVuVVqssCbMnNMhVomLHvDIHPN3JY/tYnEl
         4mSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347223; x=1776952023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=FzcjVm970lX5qxpetuut7rZiMR7msZ+WXtf722TG66J108ewgaOmFkbma8556ma62C
         2Ti1HAj0GqJ1oDXOCflTosqvz4lFvqkkOZjDmzXoV9832LeC8YZl49DR0gq77QvAU93S
         BrMlwFOCg31yz68c0xq05Thi/c11EXbDnuP8ybn2YIIoC25C3ewzIk6aMO3qemC/UKji
         PY/D7IbwEA7kI3zS6Vfq8m/YIzZK4ZL+7NRj9/OFyfbMAROlMLQP+/Y1VtSXm6XgYfib
         abCd8tpP7qMHvJ1GtcsAAsY/4qS7svLNV2LAucN3bET4jZQbAxySS189PzjjdnKh+VfU
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347223; x=1776952023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=hpozoO2aXpoTSHtfxtrqQYcYVgyMaPOLNd3LsHi2qWcs0uvsJW/n2V6IYHTHTekf6q
         aW8WI24wf4z1xPMAcpvWKyjtHkxSwpDBF8lXsGuuCoE3DHiJOXvMsZCbut7D9xubsdxD
         nbZhYzjeiSPjf3s4NAJZ6oSgLZRw7W1W9xbdXNg81haYKeOThS/sAV9ctn/JRWk8GGNk
         jSXGqmSc46Eb4P7sBdI2rfX0bXpbpwCUeuo5bph7CnSEzO9BOpf/aJ5HnQvq+T8kFq+T
         NU8/LgzDXoPA1Eskw/SfofSVwlG6sRlMwBx9hmY5o7+ip4rTIdv1EXu6h/R7e7OpOCZ5
         TnAA==
X-Forwarded-Encrypted: i=1; AFNElJ+Yzeagy/0E1iKr92hfQ277s91pZ+WWwb/87kz31xTiItg2Kox5lD2bh7Ngc4g3LvoiZMaIyTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWqLj2oR+5N3p5Hc8yRA4t3iY0AcPyMOa5rufZdNKmfC+lMYQ
	UloyZyoPbcXWUTkDsLTCOgrG4czZUjiTR/cBJg/G5SYcj7AzpcbzEj8WQ5iNSumaLvIHx0tIhod
	EWyMk1SJI7tHs0Jawe1nZoMQq0PYmYD8=
X-Gm-Gg: AeBDietCmLLAIMqAWaEgDdpg89FIWsyifYcAOhL4Q9QMzMoqoBsRJZ5eY2Pi7mZpQqs
	m/8fJzsQxnM44r2bqujK1h0UuJhDFLWFYO6WwbqfCEMolI7ZupwVizd5ZKab+jZgfSlY243hBk0
	zBfYsZMnqItl4KppZ1ma4HIbgaHa/jsgHxuOyEYWms4GugEgVLpzY3vxUBnqoN7t4ySznFYmmxf
	nWKPVTfyz9k2FqoTsMa9PRKyQ5Y1d71Z3pvX+hYNhHFyRCV8jfEqfwG3rP7i202p/jwZ13I5/Qh
	3qzNgbDnxZvW34h5QHbi5lGwQXKw5Q1xw2vcTF72/hfRIgzwYeJ9AVL10GkMhucfjAcGpnJGmeV
	hQzaSkENVN/iyUHHbh7On1LG5m/pYH96GIkxB1KAuPEBwdyemFik=
X-Received: by 2002:a05:6a00:2392:b0:82f:250b:9f16 with SMTP id
 d2e1a72fcca58-82f250ba2a1mr20854005b3a.28.1776347223559; Thu, 16 Apr 2026
 06:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416031903.1447072-1-michael.bommarito@gmail.com>
In-Reply-To: <20260416031903.1447072-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 16 Apr 2026 09:46:51 -0400
X-Gm-Features: AQROBzBXABVaL19OQLFi-BeVpvoNvRQFkcBHonub7TDUeEKdTffXEx0BwEBOtCs
Message-ID: <CADvbK_d_T++kjJ1U3g8RZRM8AUTHsrqD47Y3EuB3wZQTxeZ6Fg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279063-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7717740F317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:19=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
> buffer is large enough for the peer AUTH chunk list with
>
>     if (len < num_chunks)
>             return -EINVAL;
>
> but then writes num_chunks bytes to p->gauth_chunks, which lives
> at offset offsetof(struct sctp_authchunks, gauth_chunks) =3D=3D 8
> inside optval.  The check is missing the sizeof(struct
> sctp_authchunks) =3D 8-byte header.  When the caller supplies
> len =3D=3D num_chunks (for any num_chunks > 0) the test passes but
> copy_to_user() writes sizeof(struct sctp_authchunks) =3D 8 bytes
> past the declared buffer.
>
> The sibling function sctp_getsockopt_local_auth_chunks() at the
> next line already has the correct check:
>
>     if (len < sizeof(struct sctp_authchunks) + num_chunks)
>             return -EINVAL;
>
> Align the peer variant with its sibling.
>
> Reproducer confirms on v7.0-13-generic: an unprivileged userspace
> caller that opens a loopback SCTP association with AUTH enabled,
> queries num_chunks with a short optval, then issues the real
> getsockopt with len =3D=3D num_chunks and sentinel bytes painted past
> the buffer observes those sentinel bytes overwritten with the
> peer's AUTH chunk type.  The bytes written are under the peer's
> control but land in the caller's own userspace; this is not a
> kernel memory corruption, but it is a kernel-side contract
> violation that can silently corrupt adjacent userspace data.
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 05fb00c9c335..f5d442753dc9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct =
sock *sk, int len,
>
>         /* See if the user provided enough room for all the data */
>         num_chunks =3D ntohs(ch->param_hdr.length) - sizeof(struct sctp_p=
aramhdr);
> -       if (len < num_chunks)
> +       if (len < sizeof(struct sctp_authchunks) + num_chunks)
>                 return -EINVAL;
>
>         if (copy_to_user(to, ch->chunks, num_chunks))
> --
> 2.53.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

