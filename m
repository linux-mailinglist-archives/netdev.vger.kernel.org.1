Return-Path: <netdev+bounces-297565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LPidEtYxKWrVSAMAu9opvQ
	(envelope-from <netdev+bounces-297565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A66B667F39
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pFBAbAG5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297565-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297565-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6066F3330B9F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748D3DD507;
	Wed, 10 Jun 2026 09:35:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA03C4554
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:35:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084112; cv=pass; b=VKJ9xvb5UCslqFFnxUOoHPlJWS5OtoJwKfYrafbY/pi4X+gGu6pW2CosBJZECQSCrT4xbz2iSJuD1LN1nnr15DuSLboMncI0rGvn/Y+MEZwlAJ8ZkNZowtblkGxd9YBrT4iW4+wiKYrtSdE8itk1VKRTf/Ry9DMLzipuRS4U2+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084112; c=relaxed/simple;
	bh=f13hlIkd3qAqESAAe+1Ll7lwWedKyP+tjl+1tINB0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1D/fIWtGWARp3d9U8Ci3WwhbdJkp+TrIMSgE/t8CysRX8/Lz7/x4JNWlXgUYc01VRUH0xvv37IGB3v1oj0a8Ur/+jGPyyfEIptnoqlR6ZflBn+28Kt2gx3+fu92zlh9xrZR3z0P5jYqtsnzYkVqoDVG0BTnhOJbLnrquUaSJU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFBAbAG5; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6603d8697d2so6387176d50.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781084108; cv=none;
        d=google.com; s=arc-20240605;
        b=USaplnES6brFPl+tdyYxRwfu7+/RP6IYK44J10ilfpun4ujr/Ckg+n4or5WwI6fMz/
         eldS2pRHOhe5Pv/SDDmVwN3OCqGm/C6MIVI0+9bODT3Ns25cnVthGxUjGObhXwbhYCNq
         WKX/AwImiW45dMFrnOi9j4xr4NGKrTFebpAQ221t8c9yYQPfD/8Jtqt+1cvAAKpyyGpo
         dnqeK2V/Ug0iUl6OgeHrC4ZTszc5ykjCQ+BG6AT1zi4lbmHxte3qqBCtWmKkFaFcAqx/
         I4K5jhK/ySW4uOfQO4kqbf1Z+adCtYcWj1qHxbqlai475uCaP0v8+NPzoPej9ioyJb6R
         n0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        fh=jbZSRrrguIZBSPdW9V2SIdJFBEdjrWGQcUlq7nGV7Ns=;
        b=L+iGvoOAu5HB+0cItC+yyF/SYJsOwVide1VYbo7cA2sUc67Uwc+G4A92ukKagkf9gE
         vtIM2inweevpWNja8+phZ5ycYFROPvEcLg1NiqAAMExDXpDUyHK/jCCzKF6Iucn6+NaP
         XQNB++vURSEy5+0a7ZcRJC5EqmtxXTPaJLCQ6Bfx6dZbWntcdJgSQ94l3VA8JRV8Hfwa
         umsTtkIXJpPKoY/Dlepp8trQ+ZQEUY7zYgRGmC7CAB7BRBdaVxCFECNDXv2r7SmKFJtx
         LbL4sruynZ032affCyPhuYyJ13sAejujtQ4v6KCDD7JJNBsRTnk4gVj38KMliW34Ryj1
         qPSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084108; x=1781688908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        b=pFBAbAG5e+gryTMupfIlwf2bbh46zpH3f1KvDGQTecrjmGwcJIt8wKotjOyk9G9J/u
         Al3HZgOpQdMi/99K5rrGhmXBsKntezwoK+T2nDL/qjHolICnolTzNaRC/luQaHo1LNLY
         cQoPJXks1D+8oFtH7J4sOfuPES2PxYulzsEFokdsCbgisBJo9VUOX3miy4l7idpJEzOz
         bis1i1szXpfIJgsSxYtbpESq01PXhwycNTL+ZofBCVe6xDHW8WHKWPAFXvUgL1QPML16
         +ML1qrBJE47/zQUMMK0l+dLibE6/2T2Aj62wFoGgEUTY33ZaJ61tGC8jDyEFxIHSBjW8
         BeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084108; x=1781688908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        b=H6SvN7mII+MPedJV+hqcittWfMpN5BfFOubpxqr51PjYefjUR5JCytoXFKSHnBxTZI
         ERroJq5bSf/VR0sfhpsDwOx++N3hSNiz+j8eDQXeyJAox9QqlK2szC3ZRA2pr6W7LByx
         eHXq3BzIPvkxC8dT6XfXgHHAXFhVkLPfRJm4okVCgKiN3yqGM9JIxvg9Hu3JZP6G0N0e
         f2BJBCB6Z3ZP02zDP1X6UiRyQBe5fO2RzA24egvA/d/+F6wE45HU60wlFBiZbY6zRdFX
         UzPIMw30gFvBsl0puH9xvzDg61rk8bZqUn3N4/noWBiJgAUdjafNRg6vO/h1t1+vP1fj
         WfQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8y4Ck7/zNqldLxgSzNGlJsUSQTnkB/9/A9RI8Sk3lBJaKu5Dscqq4kBZmk+/qvDaNfrn240Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dAXfP4CIx0ZRXXldFaCy1TuCPDbT9jzodli7K1lwgpBCfaO7
	Cgblb5HDtdPBxJ4J1KeyFnA5qKaxux7LCwatXV1WkzBQJwCFYtXLgtB+0YJ6oFQ8UNvHkbJ25TC
	uj+4jaY8RocDruRK+q8JNjlg3MeUguU4=
X-Gm-Gg: Acq92OFtwQnSIsrsqXVj/v0cH+TGwLhgvKuIalMCNol7IW1aycZpoMjF0woIrcubyO2
	blpiFswvxKXi5eLc6xWqZwCTf1YS+cRTSjig96kREOYBdeZ1MQWWgATJ1HDM+wsgyf5YqWt8quA
	EmM5FUqUNt4HBkmEJuRrEJ+kTZYXosNKePhHRG4zmywQJp6mJvIvtqAQ75GgxKta2aIef6rsj1n
	dBTCvk9CwhcAMxWidrbOX93vsXf0Hpcb0WBVArBRswzLjVIPCJ3JX5pSrXst1Rin6uqBZPxeE+V
	QQRR9CY6t7d7sVYRMg8bkQwena5z7y8rDfCUMTVo6lOZtNr6y4YJwN1vwah8dQ==
X-Received: by 2002:a05:690e:1902:b0:64a:ef61:188c with SMTP id
 956f58d0204a3-6614f7fa83emr6602296d50.47.1781084108264; Wed, 10 Jun 2026
 02:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev> <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
 <AgOg1pJHQN-gpKhYUz3SMw@linux.dev> <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
 <b35a2395-0e15-4390-ba7a-b48748e7e3f3@linux.dev>
In-Reply-To: <b35a2395-0e15-4390-ba7a-b48748e7e3f3@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 10 Jun 2026 17:34:56 +0800
X-Gm-Features: AVVi8Cd2Q687Tcu63pcXaDbwOQYOqrUxS-NscSvnl80wWepD5q_IKVSOQ-JfzjM
Message-ID: <CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,etsalapatis.com,vger.kernel.org,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,etsalapatis.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A66B667F39

On Wed, Jun 10, 2026 at 1:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/10/26 9:58 AM, sun jian wrote:
> > On Wed, Jun 10, 2026 at 9:21=E2=80=AFAM Menglong Dong <menglong.dong@li=
nux.dev> wrote:
> >> On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> >>> On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> >>>> On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> [...]
> >>>> Hi, Jian.
> >>>>
> >>>> This sounds like a good idea in this case. When I have a look at bpf=
_clone_redirect(),
> >>>> I found that it use skb_clone() too, which means it has the same pro=
blem. The
> >>>> data can be modified by other xdp prog in the destination NIC if we =
use
> >>>> bpf_clone_redirect().
> >>>>
> >>>> So maybe this is the default logic, and I'm not sure if this patch c=
an break the
> >>>> existing users :/
> >>> I think for use cases where we are using bpf_clone_redirect() to use
> >>> one clone for inspection this would add an unnecessary copy. Maybe
> >>> adding *_copy() variants instead of changing the *_clone() would be
> >>> better? That way we wouldn't be changing the behavior for existing
> >>> consumers and the naming would be consistent with the skb_* methods.
> >> Agree. It's not a good idea to change the logic of the existing API. O=
r
> >> maybe we can add a BPF_F_CLONE flag for the existing API.
> >>
> >>> But more importantly, is there an actual use case for the kind of API
> >>> that the modified selftest requires? Nobody until now has considered
> >>> the existing behavior to be a problem.
> >> Agree too. Obviously, this is not a bug. For the use case in the commi=
t
> >> log, it's something that can be fixed by the user themself. If we need
> >> modify the MAC, we'd better attach a BPF program for all the egress
> >> device in the devmap.
> >>
> [...]
> >>>>
> > Thanks for all the comments.
> >
> > I agree this should not be treated as a generic skb_clone() issue, and =
I
> > understand the concern about changing existing clone/shared-data semant=
ics.
> >
> > The case I was trying to address is narrower: generic XDP devmap
> > broadcast/multi redirect with per-devmap-entry egress programs. The use=
 case is
> > not newly introduced by this patch. The existing xdp_veth_egress test a=
lready
> > attaches xdp_devmap_prog to all egress devmap entries, and that program=
 rewrites
> > eth->h_source based on ctx->egress_ifindex. My change only strengthens =
the test
> > from checking that the observed MAC is not equal to a single magic MAC =
to
> > checking that each destination observes the MAC selected for its own eg=
ress
> > ifindex.
> >
> > So attaching an egress program to all devmap entries is already what th=
is test
> > does. The SKB_MODE failure happens because the cloned skbs can still sh=
are the
> > packet data, and a later per-egress rewrite can be observed by another
> > destination.
> >
> > That said, I see the concern that this may need a clearer semantic boun=
dary
> > between clone and copy behavior. I will also check the last_dst path po=
inted out
> > by Sashiko before deciding whether this should be handled as a bug fix,=
 or
> > whether it needs a separate explicit copy/isolated redirect semantic in=
stead.
>
>
> I agree there's a real concern here. For context, native XDP already
> makes a full copy
> of the frame for every broadcast destination:
>
>    dev_map_enqueue_multi -> dev_map_enqueue_clone -> xdpf_clone
>
> so on the native path each destination gets its own independent buffer.
>
> The generic path is the odd one out, because skb_clone() shares the
> underlying data.
> I think this rationale should be spelled out in the commit message.
>
> Regarding performance: generic XDP is already a slow path =E2=80=94 the i=
ngress
> side already
> linearizes / expands the skb (pskb_expand_head() in
> netif_receive_generic_xdp())
> so the extra copy here is not a concern.
>
>
> However, there is one problem with the patch as it stands.
>
> The last destination is transmitted using the original skb directly,
> without unsharing it.
> So with two destinations where the first one has no egress XDP program
> and the second (i.e. the last one) does,
> the egress modification on the second destination will corrupt the
> packet sent to the first.
>
> This could be addressed by doing the skb_unshare() inside
> dev_map_generic_redirect() instead ?
>
> For the non-broadcast (existing) path the skb is not cloned, so
> skb_unshare() simply returns it unchanged.
>
>
>
Hi Jiayuan,

Thanks for the detailed explanation.

I checked the last_dst case and was able to reproduce it locally. In that c=
ase,
earlier destinations without devmap egress programs can still observe the p=
acket
data rewritten by the final destination's egress program.

I also tried your suggestion of handling this in dev_map_generic_redirect()=
,
right before running the devmap egress program. That fixes both the origina=
l
case and the last_dst case.

One detail I changed in the implementation is to use skb_copy() + consume_s=
kb()
instead of skb_unshare(), so that allocation failure does not consume the s=
kb
and the existing caller error paths keep their ownership semantics.

With that version, the following tests pass:

./test_progs -t xdp_veth_egress
./test_progs -t xdp_veth
./test_progs -t xdp

I'll send v2 shortly.

Thanks,
sun jian

