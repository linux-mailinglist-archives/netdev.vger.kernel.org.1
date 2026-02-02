Return-Path: <netdev+bounces-255928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMKPEXLPgGlBBwMAu9opvQ
	(envelope-from <netdev+bounces-255928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2848CEE57
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2682B301395C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4B258EC2;
	Mon,  2 Feb 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ie06huMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB828134C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049353; cv=pass; b=lFBNxeDjHmN+L0ZofO0OaryG77Rx2/qmLSbfHL2kWZ4H5Z7a6RP7hCsmFHvv3rm5+l8ToRCQLOt5Yl9WIIv+aB5iGJN9SNBw2ZxP9cLbK2vrG6K24Obp4OtuZg+F9sg+Z6RLuQoM2TWeApPJ2eQyjPvVyc9rMQxCdlLLePV49CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049353; c=relaxed/simple;
	bh=6ah4Z3CDO5g6siNgLOWXmrdA/chSOgh6Plco+iErYFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6zVY9BP2MKyZzETGTsXknIJom0nodcueuMFqQFafCKNRGjdoIVesL71gvQ5u8z11Xqb0hPB3Ou0yqVwdm+pGu1LBlyK81zxCs/cMuzjZrCK/wok5fX0vRvaH1RX94sEUjekBsyW9JlHaTQCVHNIWInca7ebMS2GXSrzS40VxW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ie06huMQ; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50299648ae9so1188541cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 08:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770049351; cv=none;
        d=google.com; s=arc-20240605;
        b=CPHYplfwMaWcP5175RFsZke49JSqE8TdNyUBaZX6NgB3V4sl5Ds8uf5GVcVJx/NdGm
         CTPtEOliRcLKqOLJkAkHJi5nAaThMqRL0M2lWCZO8EMDQScdGdfpDRh19HrVfYcWc1A4
         4v8d0Ry40ucHXlJ5Ek+nrXDtTSZjBisDIbpeJIaTCGBsida7vWqvIWwHVo8PBT6IKClY
         PLBGUOhXd09/r54z65CkV7X2C/W7D+EcgyfMlARWAuOfWL5wVzmn/htxGNbVKqDNh5IH
         zC5bmMuOmZSdQnnCkDr44D8hHKBKjoaqv6y9Lq5XiNnv8lND1nMUAyrnb9Axp71mf9lx
         cocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P5ZpxxLwNwfYTd74bGbRf8AZ/SXfXUh9ajYHr4N6ov8=;
        fh=J9JV0Xlvj5Dw+RU1/bqbV89Is5UTjRpIgT/21wkhGx8=;
        b=ejvVlTorH2LAV9ci+08TnapiC1HLlstwxwX64oAODAoaxFvgG1tivqFBuRFoCYoEbP
         v8JvXGRNmMzgBVO27pWwRtwLGJY4uAKAgM7GXWjcWDBYENDeC9MTfTV16uohXzhNqlzK
         wsLHXJT27iyatIsRJPHgQq68cLQI/f29+30wB8LDJRDXz62l3uv5SlcsCbOeQ7eGOLoa
         4ehP9V6Lm/YePXFbLRWKQetnbMs2w/0O6JAcLVEhOtY7xLIJT6lBfgr9EnIgL0+GxSAR
         y2XJni5jlUucTqoZ7UIy94oaXRSaCnywvqJAL5M33MZ/P0Pd6m50X9Yh2WnkHqF5nfkJ
         RnsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770049351; x=1770654151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5ZpxxLwNwfYTd74bGbRf8AZ/SXfXUh9ajYHr4N6ov8=;
        b=Ie06huMQn3hj5jHTKOXsXypGGk6y4OUycJmvpCemKWkin4NvB0bxs1DeZYLSrhrOJp
         9F49TuU902QsPwWMyt++2jNzF7K2ALhSF2tPgUos0WYiGzVnDQoW+bj6bwKPKhuRtJ27
         mgQHwpONcC0dNcAkWSYRZ/CnzwhDy5Fj29h/vBk0uLHDNHWpLirqqwLeKoVKXnN+JnTE
         l3SgltXfJ5U5lHEL3DKiQaxAL823vyv4CxrHBFozF+8uSEcuPjrbkLkK4eDnLBSoD36f
         ax/MCMwhGsvhvzZ/oKiFQfB61c3rczIAxUfeMBxv1dNXGeQv0ZCg/zl1PbmXrVs4sBNX
         P10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049351; x=1770654151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5ZpxxLwNwfYTd74bGbRf8AZ/SXfXUh9ajYHr4N6ov8=;
        b=pHaCfqnkmHWKdr6NJW9zPvYs1+0r73LOSwy4f/21lmoNyyC86vAy3N4169Rpk1FZp6
         oYAS/vj789EnG8pCkGAgNe7r8Q9WZBeBJJKEIgpvilcMaAbxE3t5UaiYjDt0JSsIYj/r
         BOEoOW3+4jT1FHGsTinmZa2Z006gs8IM/auxy8z7KNhCvWGJFpjuMAuh+T9bMMQl4fJd
         W6LlHgtVJizdHRgFWT7mtZbDqBknZHcr5AS2G/HlVW+eGg8giP8x3YDcvBApx4y3aVXu
         xUzDb3Zhq4ucVmckYowpSDhYVRJ0hn61nAIVdH6y8UX13+zmaNEU6y49UVLpA6XRGnfI
         CKrw==
X-Forwarded-Encrypted: i=1; AJvYcCWxjj6+PRojzJme+q8lQDY8xf0M6v7KsmUy1KdGjbkgFkNgJM1IrNSNYlmoIg3al5JxTZLwNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrk0yJhajCDjTJ88TM1A8+SLUieQ7EkE3wQB97avP6u9uwoyx
	b8Pk7gqUMfxXK+E0s+YB/nc/0knHJvISUa+XoIuRwZzsHXgqV5KYyj8LslVVU5TqddU4qj/rBF6
	x65O22A50VD0112uyLWnnE7sDAgkbK2TAIFcpc9bjThVYV9RRF7TdWEVE/bc=
X-Gm-Gg: AZuq6aIrRmfDSqZdHsa8pv5mlAtobXBVWRN0Mg/nrXb8jE0Q2aZXy+4aEbL8oCDXm7V
	2/63b66g+54n4/LgK7oD/84cj9F6SLsmxSxTa4q57MOvGG98TWLuWE6yht9AVS362kKSmO6Dej+
	mMB8/uxREuunSOtO8PkWwspZ78FQx7KkCm/4Gtv+ReukLuHoCRXwMXMVQuUWNB6541Xs8Va+Itm
	DutF7kImuXCbueMpzT8H5hd8Fd/3bbYFyiqn1uSz8E4RCWO3YpQYY/2njirNDtlcPd744gP05o4
	N9oDVPidQqGCFtzpaBN8AtNxP6tqO2230u8PzDE81/htQOoG8otrN/g1v0Gs
X-Received: by 2002:a05:622a:7285:b0:505:e719:3b49 with SMTP id
 d75a77b69052e-505ec789598mr73621cf.11.1770049350883; Mon, 02 Feb 2026
 08:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
In-Reply-To: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 2 Feb 2026 11:22:13 -0500
X-Gm-Features: AZwV_Qg8LreteaQW_NXtiYFsEboooHxNLYGwftjs0hadBtkWjm0_1VYeeNKM3qU
Message-ID: <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp_bbr: use high pacing gain when the
 sender fails to put enough data inflight
To: kelmenhorst <kelmenhorst@uni-osnabrueck.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ieee.org:url]
X-Rspamd-Queue-Id: D2848CEE57
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 5:15=E2=80=AFAM kelmenhorst
<kelmenhorst@uni-osnabrueck.de> wrote:
>
> This patch addresses a robustness issue of TCP BBR when run in Virtual Ma=
chines
> - a common use case considering modern web hosting.
> Prior experiments in AWS VMs (https://ieeexplore.ieee.org/abstract/docume=
nt/9546441),
> and our recent measurements in a controlled setup show that VM-based BBR =
senders
> heavily underestimate the available bandwidth during periods of CPU conte=
ntion.
> In our configuration with 10ms periodic timeslices, BBR already degrades =
in VMs
> with less than 70% CPU time share, and the throughput continuously drops =
with
> decreasing CPU shares until it is bandwidth-independently capped at 10 Mb=
ps for
> CPU time shares at 35% and lower.
> Considering the common use case of BBR in (resource-limited) Linux VMs, t=
his
> issue could potentially compromise the robustness of the Internet's trans=
port
> layer.
>
> In contrast to Cubic, BBR is very sensitive to off-CPU times. This is bec=
ause
> pacing evenly spreads the target inflight over the RTT, essentially assum=
ing
> that the CPU is available during the whole RTT. If this assumption is not=
 met,
> the BBR sender cannot achieve the target pacing rate and concludes that t=
he full
> bandwidth has been reached, even though the throughput is far below the a=
ctual
> bandwidth limit.

Thanks, I agree this is an issue worth working on. And I appreciate
your contributions in this area, as well as the work of others who
have worked on the challenges of BBR throughput in VM guests.

> This commit detects the problematic condition in bbr_update_gains() by
> comparing BBR's current target inflight (bbr_inflight() * tp->mss_cache) =
with
> the actual number of bytes inflight (tp->bytes_sent - tp->bytes_acked), a=
nd
> applies high pacing gain (bbr_high_gain), until the inflight deficit reco=
vers.
> With a higher pacing gain, BBR can send faster when the VM does have the =
CPU,
> so that the target inflight volume can be achieved despite off-CPU times.
> Re-using the constant STARTUP gain can only solve the issue up to a certa=
in
> point, but avoids complex algorithm changes.
> Effectively, the patch solves the degradation problem for most critical c=
ases:
> with 10ms periodic timeslices, BBRv1 is robust for CPU time shares of 35%=
 and
> higher -  instead of 70% and higher when using the original code.

AFAICT this patch does not look like a safe solution, because there
are many reasons that the actual number of bytes in flight can be less
than the target inflight. Notably, it is very common for applications
to be application-limited, i.e., they don't have enough data to send
to fully utilize the BDP of the network path. This is very common for
the most common kinds of TCP workloads: web, streaming video, RPC,
SSH, etc. It does not seem safe to increase the pacing gain to
bbr_high_gain in these common application-limited scenarios, because
this can cause bursts of data to arrive at the bottleneck link at more
than twice the available bandwidth, which can cause very high queuing
and packet loss.

On a broader note, before making such a significant change to a CC
algorithm, we would need to see a broad array of test results showing
that the change is safe and performant in a representative set of
scenarios: multiple BBR flows, shallow buffers, deep buffers,
policers, application-limited traffic, BBR coexistence with CUBIC,
performance on wifi paths, etc.

> We can share further results of our measurement study upon individual req=
uest.

Yes, if you could please share further results, I would appreciate it.
I'm aware of your work here:

  POSTER: Clouded Comparisons - On the Impact of VirtualMachines on
TCP-BBR Performance
  https://dl.acm.org/doi/epdf/10.1145/3744969.3748455

But if you have further results that you can share, I'd appreciate it.

> Signed-off-by: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
> ---
>  net/ipv4/tcp_bbr.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 760941e55153..ca6361931491 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -1011,6 +1011,13 @@ static void bbr_update_gains(struct sock *sk)
>                 WARN_ONCE(1, "BBR bad mode: %u\n", bbr->mode);
>                 break;
>         }
> +        // overwrite pacing gain in case the sender fails to put enough =
data inflight
> +        struct tcp_sock *tp =3D tcp_sk(sk);
> +        u64 real_inflight =3D tp->bytes_sent - tp->bytes_acked;
> +        u32 target_inflight =3D bbr_inflight(sk, bbr_bw(sk), BBR_UNIT) *=
 tp->mss_cache;
> +        if (real_inflight < target_inflight) {
> +                bbr->pacing_gain =3D bbr_high_gain;
> +        }
>  }

Just a note on style: before your next patch submission to the Linux
netdev mailing list:

(1) please read the netdev FAQ at:
  https://www.kernel.org/doc/html/v6.18/process/maintainer-netdev.html#netd=
ev-faq

(2) please run ./scripts/checkpatch.pl on the patch to catch and fix
style issues (./scripts/checkpatch.pl shows: "total: 7 errors, 10
warnings, 0 checks, 13 lines checked")

Thanks!

best regards,
neal

