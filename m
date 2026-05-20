Return-Path: <netdev+bounces-289728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLTkDMAjDWrctgUAu9opvQ
	(envelope-from <netdev+bounces-289728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:00:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B158703B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B433019810
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF7248861;
	Wed, 20 May 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+DJeDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAF31077A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245986; cv=pass; b=ZqhRIoskBxjj7VYK2wZUUmRjxcOZKsQNCNDIgxwKHXNVpUobUOptEAhwGuuzEyqh/yXNAl3QpDGPFdtpJnBgBS7q3gg0B931rvFdjVgAlx5EUbWh7iCzPtegCvCzUCDUxLDiM6lNvjorsPIHMV64lppjqCbWfeIIPqK6IK9thN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245986; c=relaxed/simple;
	bh=gkg5apv26kveK8ieeIvoayv5d9V0BHoYpJWe0U0l4RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmAvcxqkcbWXgrOK9DD44F+DOXoKhLY3yYmBLsvgXRhLgX40CYyLIZDhE2OP2kDfoo5U6V2Uz7yx7BKJApb3Mk4dXaPMTiWOVDWuVM6EiFL7hoRk+2RHen9bTRBUdlEOmIt3tuaPd/C6IwL94y14lrnFBz1NVqG/H6alZTPv2aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+DJeDP; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd2e8931915so1076697966b.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779245984; cv=none;
        d=google.com; s=arc-20240605;
        b=gQvFmC+MAYbLzK0fNoJp5YzZRc49LjRf62wMz71wJJ4Mb382o7VtWkcFpyS0MZc0w5
         QpP/FpSg6JZSP/9R3nmFFIc8DtwX+u4mkOJGWwZ9GkJijFZLTKTQEkhDXMeI0fE6Vr2G
         lUPv+66oCcXDR5mziZzvi7353WKE0caaXNT4pmMmUiIIfRvR1b3VuJJB9KB2K6u3z+Gb
         hnGkqwwBBJfUqj+4FrfZj3g+k8U6FF6+IY6RycbwmpZT7HPBrWPa2CAgmxLk07AdUYoa
         7hFCJMj3qNAm51qNLoZpidAZX5U+9LQzdngwAAGetzmcDIgHiGr82MHHdft3kbMXMnXA
         1h4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        fh=Eb0Flsu/vGaGIUZoajXksB4TCF93eajMZuh1sjzqRqk=;
        b=BdZUB+TPdWJIeBEmls3aaW7+HA7uzaBi2QNurAC+C8oCM1g3d+70uOM5TlGQ9mUYgW
         TjqiriKnuUQ0dJy+529S61EDSMJ8ULBJyZyclw2ou2cDdKUNbhl/JU6RjViH9MkEb4MN
         450CkwUQ8oEKqgPE9I8w3xeoUnr9Nw4YDKFwPGRS7xyCpYsnnayquHdROxvScjrQZb+J
         udkl0b9P8XSQEsbZUc1iadagsmAI+JCJL7CeygvFyEPU8yGcJlOrwbaNY3ZQUrM1teDU
         eQ4P49XCzhxYjH9TUinkRhZC/1/LqcsNHWz+euyE/88X0vMK38KhvjR/jDC/A/hbAk7f
         zE+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779245984; x=1779850784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        b=bG+DJeDPHUAtln89XPmWFux+qUOjHG2jb6p3SQWVLQcJ7JFQOn+myOY+Cwzr7SBw/q
         vFUcLbMSwNnMNEIQtGln0ID1Gpkgi9WjA/ntz7I429mnfmh9BWHz+vFElrtNTAQh6zzv
         xR5s7ht0vIPksaDdizyv6UddhDNbShPpZ1EFVPEqmeXRVUhdJ5r721tNwsYSNW+xJVYs
         Opi+2U8+zgC/okP0JUOd78nog6plA5FnhNGNEviZgBRihg4VIhcxYpshiuCsh0N71evz
         vgyDB1hbScWgRhx6bIYTJuJ2tbdJTyebTvSretx4BEG7lnrFrCDJ6m65L1IuXZ/G/PW4
         CYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779245984; x=1779850784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        b=YYNBDtVuziNgWkh/xzEqT29BdL5xNXTt7L2X9nadcmVNRVjOfYCOluUHy/crh8D4y7
         dHlHH9Iewv10jNnkJFCd5PRy7JAacwOUL8UB4QvRkJcoc5iKCJWQrOSRgE9uqSGsNgRh
         p03Un34LU1R5m5wdz8ljMkdOn3wg1o3MmCsYswf8t35W1FHYD8h7qq5U3LTOUzFdsyaa
         r0Kwk92Wl+n6suXZc4a+7dk2Wj95e5f02k6a8IEmN8mu9nMqa4p+Shl6xjwgkFpDfBe8
         humPfHY/2KZzmEyFjjAqJ8vkYuQDOA49bWy1pITp4PwMXq9GlNo4nmxLFgyvsvGzJILY
         ybXg==
X-Forwarded-Encrypted: i=1; AFNElJ8Hc0ogmvts00pEneIgz2tDxRK0SSeAUTFgBUSPJDXzPTrWmEMnbZUuOUEKywskpcwXaJpreb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDxFUID7grf5PpmUATPMJEUEgkvU7Z21XgnQZFePIeHwu5Vv3
	tCDbkSV86AjbMdqFQKxMTN+oKAAdNdwNKzMoLxE5CNC36PpP51xbfeYUlbGr0QCvk5Fhn82sa76
	RbS42HyNGea/qy//O6p/IjwayeLCB1M8=
X-Gm-Gg: Acq92OGVeFCjvIo/+TmYBh+FSBWHovzchbQqarfxQHMxpLkttBk9SgHN3bXj1mDELmN
	2121wfEyk9PzJXh/LEiHL+drd5klAhonds0yYXVnF2if1a4HUozjGd4wCB7Bn/dD1CowP/SFgoP
	eo6d2aLGDskvGFBBAT4ZdTj0VY+9A3DJOaCN7h8zwFr4dSxcdahrGdlxMTff/k6Ok+U9pOgl+/3
	9d3xt5Hh+a2N5c+yB2JMqMxXk1fQFeF2DvNOhDjujCR1uCaJ52zD1UPsg7gEx+LUD0um49tIaIG
	ygxuh3nJhsoy4f12BsQm/vP0JidZmV6FJN7k0UPL1avHN5qlaJxPeYrhwDg=
X-Received: by 2002:a17:907:9611:b0:bd9:e001:fbc2 with SMTP id
 a640c23a62f3a-bd9e0020955mr188644066b.30.1779245983230; Tue, 19 May 2026
 19:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com> <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 May 2026 12:59:16 +1000
X-Gm-Features: AVHnY4LterXSqMooW_fn189c4rCYxZ0LkAk9IW_2wIKW6Yl8XwJEA0sFFAXx2F0
Message-ID: <CAKmqyKOvK+MVuVy=tMgyVEPoM6gyQGzc2XCxxgRBK8aqRXM=3A@mail.gmail.com>
Subject: Re: [PATCH net 2/7] nvme-tcp: store negative errno in queue->tls_err
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289728-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A80B158703B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 4:29=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
> ENOKEY lookup failure and the EOPNOTSUPP initializer both store
> negative errnos.  The third branch, reached when the handshake
> layer reports a non-zero status, stores -status.
>
> The handshake layer delivers status to the consumer callback as a
> negative errno; the other in-tree consumers --
> xs_tls_handshake_done() and the nvmet target callback -- treat
> their status argument that way.  The extra negation in
> nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
> value (for instance, +EIO), which nvme_tcp_start_tls() then
> returns to its caller.
>
> Drop the extra negation so queue->tls_err uniformly carries a
> negative errno on failure.
>
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 15d36d6a728e..68a1d7640494 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int statu=
s, key_serial_t pskid)
>                 qid, pskid, status);
>
>         if (status) {
> -               queue->tls_err =3D -status;
> +               queue->tls_err =3D status;
>                 goto out_complete;
>         }
>
>
> --
> 2.54.0
>
>

