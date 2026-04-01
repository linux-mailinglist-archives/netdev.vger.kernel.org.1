Return-Path: <netdev+bounces-274132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NuvEgUuzWn7aQYAu9opvQ
	(envelope-from <netdev+bounces-274132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29FC37C45A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A46E3076362
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C92C0296;
	Wed,  1 Apr 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpJyQIz8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4A1624D5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053470; cv=pass; b=HQaCEO8o0Xg3hHHQwVTdUBPKAejnc4n2ph0xDSrJt1Y94N+22ErOL/hokgwlpqdmpe43oewefnQOuCTjhTMYOLTB2muVcM/EtDqGVixhUEcwPPnTZ/kZOZOEicmPHHVKf0DgLjL5B+CQ9W7PzkY2vfGCx/q3MwPhRiDwOsGFMeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053470; c=relaxed/simple;
	bh=lr3LH2KvneQISHs716o9qadtZntZyF+Lc8Dto5BbVuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuYo4mW6Elj/1PogLJnzJu9U2VUTV6O3uxy/Zygzj219u6PZ2dbN/SO1pmT0QFdLFhdcnJafghZwKgppJT40pccfApbcAKO+M9VaD4zL+rczKWb2BI7Ao/wCqbIwNFeqNieOtlCCA57LibxD+0S6LNWo4RuJnLKzE8Ai3T6Iix4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpJyQIz8; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50b2b2aa276so59407501cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053468; cv=none;
        d=google.com; s=arc-20240605;
        b=TfbJyFoVvJF2+Kx0IkW1qPB7CMNtzMRKwciXLkTeSuBlPnB9nibDe1zRKyCd3N5Po2
         pIZvjXz1dGPbVvgpeOpm4kDiHMgHVFt3oywX/bucKhZsxIwNMqWDiD4RE10JxkNCxypM
         Tu/D3JVjz/FcfaOfJveqslsR7O5GVmEVorMlOWdTzlBOJvp7hJrPSDLFTBuvbJ21B8Ea
         wQXzLDRdh0oinBxx1rxBV3+tei0MJLXbFkbOF1nW7s3KDMeKctz2RcGxSJ3japUhTvsI
         vFio3IubwPDCQuU+QarNiyTAshCC5PEJrwOku7OtOVHHpQXoiWqDvbci7qNYSqWapg7t
         fOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XdSJHcbKHRZ7yYl2umNE3/G5RhGZ5S6K1GdSSRkmq4o=;
        fh=9xUhquHCdjGk8oaHOASGywJbku4OvwdUFASnX72/hSw=;
        b=fWb0y4duxs2rjeHl35N3etsoIPkm5QSWju/urHZf5k0nnstBpgVsLkBR/PmlmFRPDu
         xzDpi4Z6ux+NXpqOCsaDQ5e5av2Lz/1aKSMmIWH8RhSuAyqy2nlGy8prWNcUalS9V1ww
         uzLeu3Bj4Q1AhcoyHSNR+kfDWxvrghySyL3O21VfORZ9mlmjEvUYTGPg2uBzkFyyoiJb
         lm6N2q3qfw52QJR3zmTnlbJ3JOPukA/1fGBtV1uLVb7iU+R+qRkPK6t0qH7/1P91hAAg
         tsg+nwV8DL9/3WuvKZ/ia3n7mbHUm7v7qrgK/ORN+JzLovopqk5IBkPiKctnUelRYohL
         kg2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775053468; x=1775658268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdSJHcbKHRZ7yYl2umNE3/G5RhGZ5S6K1GdSSRkmq4o=;
        b=IpJyQIz8vAwN/4U+3/gH49LWF+h26S63YM8njuIODcxMNVaNQfx1bGWhCm0PS1oQCG
         8KbpaNNwfXbkWXzCMny13AJmpHj9+0s33NhZbi/DqYP48qaBMHjVAxCgyhicRErhO8gs
         OEgpAThJAPYMN6xUHINUprQCEzIc9z/F6KKALORR1StVTMMszUuxvpd0ST7kZjQu3G+d
         aftUVMAJoB6EvuFvLYg9EAzsnH+szKCYD7oh/aogtkeJzS2bAMBKc0hx95YV7R2Kp2B5
         PrW5qhK05UedZ+JfQVRIG6ZhDxY6QywZkrh/rFPGqEvYVuqkWI/H3AkLZ/g3e8GXqg58
         oW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053468; x=1775658268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdSJHcbKHRZ7yYl2umNE3/G5RhGZ5S6K1GdSSRkmq4o=;
        b=dOssDOBpj7MgxuF9YpqE4Vmm5D+dkfSRH0v9Aks9IX5sbjX8HcxApYT7kTi4JFGBq5
         i7/7mz6w7uLA07ir8yl5xpcIqcGY+/51zpbl6WyOhd14qvaB2R35LCsYpV/GM3FnePLL
         OhltGVU7sE+pdhHikb3768Qv+QyrRD0M5V7WPD2BPoRNQroJvcv+NwhBZhT6N5lF72Ce
         JXiAZdr9Vqd+6aW8G4SZOvd+i7GWSVcNZBHkiNfBSOLiFmqIiQaOkVIBahn05D5OciSj
         DV7JI6ILKNoOCTPZLRlEVt1SJD1LKpOBcmIs2gcnY7mxA4ABIkNNybp2Gg37xrSKkZzO
         B+SA==
X-Forwarded-Encrypted: i=1; AJvYcCX/BuAldaj0pJOujSUVivOX4f6cKhtuywkvLEOkqd1ob0ZF5wMF16slXHLOFYFhP44l1Ffqh7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMEdqeJqkEJeXXX3bdsN+h9qdIvkJpCPpDKiwqw+sooexXAps
	P3zbArOUJjUwvjcloQDhnqeJ3c+rI+EQqS1M+oAhCFTuFXgUDWqfXGruAiL4bzoflCeMF10td6W
	B2s0I6TDtu9wH8Fq8+E7VB1tdYlaom1bLWjCIt99V4UB+cAujn8WMdYvnrNY=
X-Gm-Gg: ATEYQzw+dED0ETmJkQnqaPvOmcoJ3iZwPE15+rSZxYfORJ5etV+Hzdq93YpQOzGc/kc
	CkzjfiXUV+rJtPPozv51jAdZ9ACoZUWdbaVrb3BVMcciGig0xY9mYUohY/PvoPaD/jlpkHvrz3F
	0N8wwXfPPJq6e8qz8bvgBdYbpq4ZLcStTcUPznIFMxKOPx16Qj+sKYogWrL9/oCZE/YqkejL2iH
	uR2eUt1CzjqbNPHBSvv1RpEA4qNiucHNkUXHKZwoCnQ6zPid+hyTP9cpnD04W+/4TTa29udM/AM
	z5ah/Y+2U+aKVzp8O9w=
X-Received: by 2002:a05:622a:8f:b0:50b:37a1:a013 with SMTP id
 d75a77b69052e-50d3bcd3760mr52765381cf.40.1775053467332; Wed, 01 Apr 2026
 07:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
 <CANn89iK57oiF0T0Z=t7okBuZbCpn+Bt746nxL2+iaQgXPyBb7Q@mail.gmail.com>
In-Reply-To: <CANn89iK57oiF0T0Z=t7okBuZbCpn+Bt746nxL2+iaQgXPyBb7Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 07:24:16 -0700
X-Gm-Features: AQROBzDt5nifhm6bAaUJG1tfa9e5AirfigTiD_4bS8c-URnsS59wLWyZxTJXVfI
Message-ID: <CANn89iLh-xJFSUAa_xtVuos0nbgaQAC+LjwEnh2y0NmDu4LY-Q@mail.gmail.com>
Subject: Re: [BUG][SECURITY?] ipv6: opt_flen wrap via repeated IPV6_DSTOPTS
 cmsgs triggers skb_under_panic (local DoS)
To: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274132-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B29FC37C45A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 7:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Apr 1, 2026 at 6:19=E2=80=AFAM =E9=92=B1=E4=B8=80=E9=93=AD <yimin=
gqian591@gmail.com> wrote:
> >
> > Hi,
> >
> > I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
> > ancillary-data path that can panic the kernel via `skb_under_panic()`
> > (local DoS).
> >
> > The core issue is a mismatch between:
> >
> > - a 16-bit length accumulator (`struct ipv6_txoptions::opt_flen`, type
> > `__u16`) and
> > - a pointer to the *last* provided destination-options header (`opt->ds=
t1opt`)
> >
> > when multiple `IPV6_DSTOPTS` control messages (cmsgs) are provided.
> >
> > ## Affected Area
> >
> > - `include/net/ipv6.h`:
> >   - `struct ipv6_txoptions::opt_flen` is `__u16` (wrap possible).
> > (lines 291-307, especially 298)
> > - `net/ipv6/datagram.c:ip6_datagram_send_ctl()`:
> >   - Accepts repeated `IPV6_DSTOPTS` and accumulates into `opt_flen`
> > without rejecting duplicates. (lines 909-933)
> > - `net/ipv6/ip6_output.c:__ip6_append_data()`:
> >   - Uses `opt->opt_flen + opt->opt_nflen` to compute header
> > sizes/headroom decisions. (lines 1448-1466, especially 1463-1465)
> > - `net/ipv6/ip6_output.c:__ip6_make_skb()`:
> >   - Calls `ipv6_push_frag_opts()` if `opt->opt_flen` is non-zero.
> > (lines 1930-1934)
> > - `net/ipv6/exthdrs.c:ipv6_push_frag_opts()` / `ipv6_push_exthdr()`:
> >   - Push size comes from `ipv6_optlen(opt->dst1opt)` (based on the
> > pointed-to header). (lines 1179-1185 and 1206-1211)
> >
> > ## Root Cause (Detailed)
> >
> > 1. `opt_flen` is a 16-bit accumulator:
> >
> > - `include/net/ipv6.h:298` defines `__u16 opt_flen; /* after fragment h=
dr */`.
> >
> > 2. `ip6_datagram_send_ctl()` accepts *repeated* `IPV6_DSTOPTS` cmsgs
> > and increments `opt_flen` each time:
> >
> > - In `net/ipv6/datagram.c:909-933`, for `IPV6_DSTOPTS`:
> >   - It computes `len =3D ((hdr->hdrlen + 1) << 3);`
> >   - It checks `CAP_NET_RAW` using `ns_capable(net->user_ns,
> > CAP_NET_RAW)`. (line 922)
> >   - Then it does:
> >     - `opt->opt_flen +=3D len;` (line 927)
> >     - `opt->dst1opt =3D hdr;` (line 928)
> >
> > There is no duplicate rejection here (unlike the legacy
> > `IPV6_2292DSTOPTS` path which rejects duplicates at
> > `net/ipv6/datagram.c:901-904`).
> >
> > If enough large `IPV6_DSTOPTS` cmsgs are provided, `opt_flen` wraps
> > while `dst1opt` still points to a large (2048-byte)
> > destination-options header.
> >
> > In the attached PoC (`poc.c`):
> >
> > - 32 cmsgs with `hdrlen=3D255` =3D> `len =3D (255+1)*8 =3D 2048`
> > - 1 cmsg with `hdrlen=3D0` =3D> `len =3D 8`
> > - Total increment: `32*2048 + 8 =3D 65544`, so `(__u16)opt_flen =3D=3D =
8`
> > - The last cmsg is 2048 bytes, so `dst1opt` points to a 2048-byte heade=
r.
> >
> > 3. The transmit path sizes headers using the wrapped `opt_flen`:
> >
> > - In `net/ipv6/ip6_output.c:1463-1465`:
> >   - `headersize =3D sizeof(struct ipv6hdr) + (opt ? opt->opt_flen +
> > opt->opt_nflen : 0) + ...;`
> >
> > With wrapped `opt_flen`, `headersize`/headroom decisions underestimate
> > what will be pushed later.
> >
> > 4. When building the final skb, the actual push length comes from
> > `dst1opt` and is not limited by wrapped `opt_flen`:
> >
> > - In `net/ipv6/ip6_output.c:1930-1934`:
> >   - `if (opt->opt_flen) proto =3D ipv6_push_frag_opts(skb, opt, proto);=
`
> > - In `net/ipv6/exthdrs.c:1206-1211`, `ipv6_push_frag_opts()` pushes
> > `dst1opt` via `ipv6_push_exthdr()`.
> > - In `net/ipv6/exthdrs.c:1179-1184`, `ipv6_push_exthdr()` does:
> >   - `skb_push(skb, ipv6_optlen(opt));`
> >   - `memcpy(h, opt, ipv6_optlen(opt));`
> >
> > With insufficient headroom, `skb_push()` underflows and triggers
> > `skb_under_panic()` -> `BUG()`:
> >
> > - `net/core/skbuff.c:2669-2675` (`skb_push()` calls `skb_under_panic()`=
)
> > - `net/core/skbuff.c:207-214` (`skb_panic()` ends in `BUG()`)
> >
> > ## Trigger Conditions / Privileges
> >
> > - The `IPV6_DSTOPTS` cmsg path requires `CAP_NET_RAW` in the target
> > netns user namespace (`ns_capable(net->user_ns, CAP_NET_RAW)`).
> > - Root (or any task with `CAP_NET_RAW`) can trigger this without user
> > namespaces.
> > - An unprivileged `uid=3D1000` user can trigger this if unprivileged
> > user namespaces are enabled and it can create a userns+netns to obtain
> > namespaced `CAP_NET_RAW` (the attached PoC does this).
> >
> > ## Impact
> >
> > - Local denial of service: kernel BUG/panic (system crash).
> > - Reproducible with a small userspace PoC.
> >
> > ## Crash Proof (KASAN Kernel Log Excerpt)
> >
> > This excerpt is from the attached QEMU console log
> > (`qemu_upstream_20260401.log`) captured on a KASAN-enabled kernel (see
> > `kernel.config`, boot args in `kasan_env.txt`):
> >
> > ```text
> > [+] sending IPv6 UDP sendmsg with 33 IPV6_DSTOPTS cmsgs (len=3D2048 x32=
, len=3D8 x1)
> > [*] expect a kernel panic (skb_under_panic) on a vulnerable kernel
> > [   51.243668] skbuff: skb_under_panic: ... put:2048 ...
> > [   51.245216] kernel BUG at net/core/skbuff.c:214!
> > [   51.247204] CPU: 0 UID: 1000 PID: 106 Comm: test ... 7.0.0-rc6+ #1 P=
REEMPT
> > [   51.252080]  ipv6_push_frag_opts+0x84/0x130
> > [   51.252349]  __ip6_make_skb+0x1773/0x2300
> > [   51.253728]  udpv6_sendmsg+0x1a36/0x2760
> > ...
> > [   51.267528] Kernel panic - not syncing: Fatal exception
> > ```
> >
> > ## Affected Kernel / Reproduction
> >
> > I reproduced this on Linux upstream commit:
> >
> > - `9147566d801602c9e7fc7f85e989735735bf38ba` (reports as `7.0.0-rc6+`
> > in my build)
> >
> > Reproduction steps (VM recommended; this PoC panics the kernel):
> >
> > 1. Build a kernel with KASAN enabled using the attached `kernel.config`=
.
> > 2. Boot with the command line in `kasan_env.txt`.
> > 3. Compile and run `poc.c` inside the guest:
> >
> > ```sh
> > gcc -O0 -g -static -fno-stack-protector -o poc poc.c
> > ./poc
> > ```
> >
> > ## Fix Suggestions
> >
> > I think at least one of these should be done; doing (1) and (2)
> > together is most robust:
> >
> > 1. Reject duplicate `IPV6_DSTOPTS` cmsgs, similar to how
> > `IPV6_2292DSTOPTS` rejects duplicates:
> >    - If `opt->dst1opt` already set and `cmsg_type =3D=3D IPV6_DSTOPTS`,
> > return `-EINVAL`.
> >
> > 2. Prevent 16-bit wrap:
> >    - Use a wider temporary and reject additions that would
> > overflow/wrap `opt_flen` (e.g., `if (opt->opt_flen > U16_MAX - len)
> > return -EINVAL;` or `check_add_overflow()` with a wide type).
> >
> > 3. Consider widening `opt_flen` / `opt_nflen` to `u32` and validate
> > against sane upper bounds before use.
>
> widening opt_flen would trigger other issues I think because sk_buff
> use u16 offsets.
>
> I will test :

Or smething simpler :

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index c564b68a056268c7cbc81b5f29f60289ea9e09eb..2ace04b318f34bf4a5cd890f347=
d03193f3af7d1
100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -924,9 +924,13 @@ int ip6_datagram_send_ctl(struct net *net, struct sock=
 *sk,
                                goto exit_f;
                        }
                        if (cmsg->cmsg_type =3D=3D IPV6_DSTOPTS) {
+                               if (opt->dst1opt)
+                                       opt->opt_flen -=3D
ipv6_optlen(opt->dst1opt);
                                opt->opt_flen +=3D len;
                                opt->dst1opt =3D hdr;
                        } else {
+                               if (opt->dst0opt)
+                                       opt->opt_nflen -=3D
ipv6_optlen(opt->dst0opt);
                                opt->opt_nflen +=3D len;
                                opt->dst0opt =3D hdr;
                        }

