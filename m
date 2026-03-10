Return-Path: <netdev+bounces-266106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM6rNTYVsGnRfAIAu9opvQ
	(envelope-from <netdev+bounces-266106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:57:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1E24F346
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A281A3512145
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4C38B121;
	Tue, 10 Mar 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/XGqYvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5438AC85
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144449; cv=pass; b=JjKge2X91mEM1EUoWb1xOhSrE0nPSK7cXvn5uxcEfEvwesaka/eNDOD5PbbzwDGtrw4VruCFs7+iAMXlGbH+rPzohUP4rRn7FujXOF1uooOQTzQi6LUrRK+CvjNBIGFlQrp7zkLO8S3nFCdlbpneQ6yPPIOPEtrPb8c3UNoJYC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144449; c=relaxed/simple;
	bh=u4ggnB30E8m47pn9MW6ki0gYz6mdnItwTDOiGvmjL+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbK0ayJfYKW9k8+B8Xcf6Vogi/Ffrn3cTFmg+nB8IRDz/1/eutkiWai2ZuJWxDc0wXwQr/LRj7x94eWd5WbFN22+0iPhIU7/z1cfYslUJH5fZdvJEoBDBMsubdRaUkwjSK8686AqnyluD2h0rtZBG1KaYtsP4QOF4AJlWPjgiXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/XGqYvo; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd81963e73so254623485a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144447; cv=none;
        d=google.com; s=arc-20240605;
        b=fmj9RltknMutXKl5CBnaBQzvoUHBS1JSpBLjX4ijI8yXUWcNIgB3o1fy22mqIFdPZN
         PQvxMq8imh8B5Jx0Y60+mx/nrJ+lqwLtv3IlojhUP+yhlDwpsuv5wwUr1FLj1g1A4jWw
         PCXuvMSLnZnnhlxeITsODvGi9UzOkAuiHrnn9M/yZ3HPEX99NX4YYrmcBi2RODDhS0nV
         ZbGdSgRG2+7vdub/PHw/vUUwLBWCDB6A4j8QP6wf9K03XZPyZtdey3Hs3xCAOW3RXBY0
         6rci66rvxSTySgdyf0uaI9XW77Cfcq/CQAl7Wy/5/47C1q5nRY3tuqCY/Mh9nOGDbLn4
         NM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        fh=M7WJc16gG6BfqzXzlyKSPCwjGVtuHUp6zl70cJVCCek=;
        b=Tf7qn90YxHHx2jJzSYFVijowRC50fcXe8O8TSnOWL/oDA0Wxfsf4DqktvsBOfEvmLY
         LxzgVARF13pmaN4IsElX1xSBnBOV9/F5TJ6VWTDf5UWcjRXXjOU6AuWEFM/IV53L8/b+
         6VdrR/rjdGfM01lzUeUJ1QjL5kHgua0k8RlD4CkOGFW5qUV1zWRbyJQqvKuvMgG2r3kx
         IzUhhr83CmGJoTWUuOqBW1Ac8JFKMsdDWuN2jasw+SA3Pk9N9HBnk0iRPlmVeIzqnnNk
         bBe3jRwYrXwYu46Si2y2s/B8SsdcFJoEV4E35V8Lg4wCl2PUvUlN+/oDetpom3xHkPzA
         R+og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144447; x=1773749247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=r/XGqYvoXIEViqUB4FEx6KRzS3P4ToiYqPYoLeein27DTdBwQzGrF62wHYjwTHG/WY
         7vS2DeNOA0aZnrMIwsInalrXS6/GAct271oPH80Ht7oYLGESH1SImfgQCFDlbs2imujD
         8Vavr+Pj9up0Vv1Yg6nTaAVh/Ub2IfMswu5nzjGX3DTeqPyun5ydH6XMpOjgdHQe+OWJ
         C1Gqbr/HT1VtKAUmLAjHGOLKbAo8qT6oAlyXY1MhL2nAG1qn5keQMWs2qSBpTUbUuOZL
         Tqse109HWKddniYA9ZJWlyHU+e6i9mxSD+17GLpe2kUkfVDwqJaXXoQph5Fxyti19L7K
         oMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144447; x=1773749247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=AmZZsf59ihopTo2jgSrTanT+afQr7DU+Cd8hFt8j1lcYa6qzK9+ZdNN8hobigdc71j
         dqOzH/YtV9GLtzdsJey7j89hCxvhnpRmHuAGl896H3H3t3u2Pprwres5j89M4frHKV4F
         fjo1b5FtPRDuLGZ9zM2lnh29dSzFHzd8WJaPH9BA1LNS8ekvOTBFMb8+xKc1jKlsKrAN
         XWh9Rlsn8AEtTKfwtDpPvmGE8uTpAH+VsByOaaFveU6Ye0vEEmuJokh7WYCwV0zJZici
         H7Q+UdUMW0LNbJQbGVRD0GnG01AMlWGDrXvrow+xAudBHrFjz3YZAjj0L3YP4cgN8Szr
         aI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUnwGH0tDs34BkqiabYtyf/qYDGnLGLQ1KNG0QhEDXRAud6AaN2pggafxDVCbvJJ3/s5w/YHxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1V1K/92/I/a2TERDg6D7wAJ7xPyMad0TsBKT92AusgU+OgY9
	X7u/N8iN+JqCUi4tIbTBeWxAnAraApTojv19vsgpsCNh6iV2/WS/cZiwnPzi1xAqkMcysGn2ZtI
	ShYhTyEGFuBcbQKEOYAbgZgM7xqTcYnMQ3Fjt80JF
X-Gm-Gg: ATEYQzxVwMBoneVzg2Q8wm+Q7vjeM/T/KMYTCKsYbVxvMvbHvuQvghqEnEG/ytPppkr
	x3/aJyNGc8STQGpg0LzzgkI4zdchNeZuQqD5FAgleIIuFYTUf9dS1SMfBZ2cCwAu5bNOOfRMgQ8
	vC9qX4PdbWK2OJ9DP1DGO5qFdNSifsPsoSAf+KsXd/XhLSTKeMUOjpenbEdJCE9hRX68vsA+8az
	gFO4t4PZJTygcgabtFACKBHXpD/LFKfoCG6c5AUF7JYSr4zzPCWZWqs/BnEEJpq4HcPmJu4wf6/
	IGGw6x8=
X-Received: by 2002:a05:620a:4694:b0:8cd:8635:c04f with SMTP id
 af79cd13be357-8cd8635c58emr871773185a.78.1773144446171; Tue, 10 Mar 2026
 05:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin> <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
In-Reply-To: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:07:15 +0100
X-Gm-Features: AaiRm52YArIdW70Cdt1Zn-0xdLt1wQ__GHo4CYwly7pfLRtB5zsOkc7ncB8Yknc
Message-ID: <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, jiayuan.chen@shopee.com, 
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 36F1E24F346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266106-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 1:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
> <razor@blackwall.org> wrote:
> >
> > On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >
> > > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NUL=
L
> > > check. rr_tx_counter is a per-CPU counter only allocated in bond_open=
()
> > > when the bond mode is round-robin. If the bond device was never broug=
ht
> > > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > >
> > > The XDP redirect path can reach this code even when the bond is not u=
p:
> > > bpf_master_redirect_enabled_key is a global static key, so when any b=
ond
> > > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > interception is enabled for all bond slaves system-wide. This allows =
the
> > > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > reached on a bond that was never opened.
> > >
> > > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_=
id()
> > > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond =
was
> > > never opened), fall back to get_random_u32() for slave selection. The
> > > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > > publish the pointer to the XDP read side. A plain read suffices for t=
he
> > > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > > under RTNL lock and is the only writer of rr_tx_counter.
> > >
> > > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to s=
lave device")
> > > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE=
@google.com/T/
> > > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> >
> > This is Jay's patch + the unlikely change, looks good to me.
> > Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>
> Orthogonal to this patch  :
>
>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> if this makes sense
> for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
> randomness in the first place.
>
> Perhaps we could use a
>
> static DEFINE_PER_CPU(u32, rr_tx_counter)
>
> And :
>  slave_id =3D this_cpu_inc_return(rr_tx_counter);

I also have mixed feelings about this patch.

We probably should detect that the device is not ready before hitting
something deeper in the stack.

Sure, a NULL deref is avoided, bu what happens next ?

We send a packet while the device is not UP, I am pretty sure this
violates at least some RCU rules in device dismantling.

