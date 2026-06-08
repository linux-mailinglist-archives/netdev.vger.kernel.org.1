Return-Path: <netdev+bounces-296605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cpOWDoLXJmo1lgIAu9opvQ
	(envelope-from <netdev+bounces-296605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705565792F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=sfD6fJgu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296605-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296605-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B35C3303564A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB43BE647;
	Mon,  8 Jun 2026 14:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3E3B774F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:41:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929671; cv=pass; b=oc+RHZdsGNNc3FkuLjhIAKoiMM82E1mHBCsU/Y84UNGcCEod0y2o9JGtN3RcLN+hmxVfIk1Z592NIdVhgggUUBBvkcAN/uRsF3USoyZo/+eq+AaO5YVrNTJjZfrAJMmmpglMV2OVmBuhD4sSr429N6eUooXWqFYJWGRv9faUe2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929671; c=relaxed/simple;
	bh=FPzZlrb4Mj6ZiWVag2Qgs1oU915fKeGk/KKkTU/Ayt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7Veo2tsI2Skg+GuJ7xod3GJ05aWZW0X5UNzvD5cvQiL2R6qMW2FAwUIzHJOA9d2o/2NLEWMYJgPDXBLmLauLzh98MQqcf56wm8u5p6OZlURhw1ctplWG5I9KMQR2B6wSipNVE0WuPXKyMv6bZWFSduJCUyEKGj3z7lZDD7tr2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sfD6fJgu; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7efd2dc350cso9430197b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 07:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780929668; cv=none;
        d=google.com; s=arc-20240605;
        b=LB+ETDZwMhle3OxDEg+dK3ippnSNSutxgDetnK5aKPkK47ZzClAbNY4/iHlTPFK4uh
         Bc7CHeY758fbVu0e8CpHRTBjRuqYrO2v3MIlfFE31fKEfASyWtcHrOX5jhY6MvDf/BRM
         OfkxZRNzlZCpygJnFV8D74gjVJhQ9YhJabzIXD17ZIKQfSn4HbF6wRvCr7N/mFF3F1cQ
         YbdEi+glD1Ep7F09/OjjlEeVbKaOd3Epkbh6uUq6aXpP13v0czUElBPBLXBwX2VI7SiA
         HtqynG0WYCa9rdMwoHCfJ6bOaf2iJTZmJNzgDEEbdiJFOqkslZDlAFGXzuR4Xfupd4XH
         V9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OuE8zcDs7E2cjxOPD7sJqyiID29lOnQ/2Ea9PmDU1zA=;
        fh=YMH1xAQixyusk8Si/DxNesghVTXEFgTdWrntkytlYlk=;
        b=ie0vHYFc76jcaeVCQ0I5THinBRt4nG9Q3WjGqY9C+5hxTk9r+Gw+UFDfVY00WVHMV8
         f+rkUtbw2w210UQdDnPkahJryk89fhk/73N84PVz0Dv/vrRx3Z9w+SyEjUvVZr5Lstip
         c+M1XCvxjQbR6kxfTd06VHwNM3vvo/nuW/7piH6gOZ2vCmPBrTc5o9lormiPwWQ4K/OX
         kWBxt0CtzmxmdXkdjcmS/f/12ykDibp/k4DJX8mIwYddvufk03KslYdR2wX80VbSJjnU
         8OziEG2FuHvc0UZSjhj8suQY2AkU33myP2FahRfkjzgh1ufH8dFp6woSrj3k31nHNqUW
         PeOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780929668; x=1781534468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuE8zcDs7E2cjxOPD7sJqyiID29lOnQ/2Ea9PmDU1zA=;
        b=sfD6fJguH4nsaDeaBxWqAuDeAmoZO1ouh6+i7bx29S5C3XNChwUQqaEvqyVg4hzc+F
         D1Oswlap1GpRbwWo00JyYBBZqbh+C2mNU9wc5RJ8IC1t4cTGGjMNoK8wMC2HcHtTiCWG
         Z0HaEHkDwbHyTVqOVH5CnAdilW8Y/Tu3nnrbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929668; x=1781534468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuE8zcDs7E2cjxOPD7sJqyiID29lOnQ/2Ea9PmDU1zA=;
        b=NABKU/NizemiyUvoNRm8GvnWHbjFJBgfUJMhkMg/4IoXYb/2OKUGdS5H9Z5PxrPuYK
         +MuwR4vKzj9MYYyBnpuPb1IRUYlJPMhglY3VxGlLHE/O2LPbQg7ieRfFOYD+bOT3nfxU
         bSN86xI8t7h+m6Gip2mER+7CwdRxJKV6msSG8VVXC00mii6GF6y3GCiLq1aSXn/35Fc6
         d68eHySEhymflzk3Mx85/X2g+C/uLl3dBCdsVRxObQ6U+S2TCoJiLkXLwDmiCT+Vn5XL
         WAcDKgo/jzgH6IOlp07DdR5hwBLv4Pp3HOa9XZ+7LVN8nJf0wRgoQt/LAt6Pl7yzlCJ7
         ZfBw==
X-Forwarded-Encrypted: i=1; AFNElJ+yFJi29K6z6rdWLXGh/FVpUKL9ab1+2+Oz+oaE/EuJ8IfETg98PYVb8xreOXkWZBrl4DR7Ckk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpXuU6000pG0Rti89LgHgLejiuUZuFQnSAbX9dtCj1gKKJnaA
	tQM9W8/WWuuZyNmj/yzl52iTxhnjb32IDd4hzqV4tbSlxVmbsGztjolit2T6cCVi3es8Rf1bUBF
	hvi5E/jbiEHk4tvDSzHW/2g1drusrQ6TFzFmklWs8
X-Gm-Gg: Acq92OF6NPNmPAptCQWvqazuHiAbL+8JguxU8ssjItWfOo4fZGDeLmAk14pNYIi7SHf
	pLWfzEh1uuP30bxxZh13p8WnOC3W2dd7DnV59ilb0ifHUkiZo36SB/W4Bdkkl7QOb8X5hs3tBdK
	YxzhwlLxHAbxO7k7HtjEqV6/MCiaI+oSy/AYu+Oz7+a+SyiFkn15h/2ZCdIXZ9sQj192ln+7DI/
	Z6u4+wXgWEMB5nH/0sQwk80ME3lu2YGKD7H3WcKLtD0Ez4PW7DrYWgsGU4jKJ3+MTUqsbPn2e6n
	pKpZT0yWUE2SXTd23UYiqSbynhT4o19IuATRU6AvnROcYmRh0xEcFhCN5RM=
X-Received: by 2002:a05:690c:6c83:b0:79e:8299:7505 with SMTP id
 00721157ae682-7ed0a5ef467mr143680647b3.6.1780929668500; Mon, 08 Jun 2026
 07:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
 <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
 <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com> <CAM0EoMmPb0jZGWeadX4KqsyQTx4Oo2gLg-3h+u=Ec=9rqzzjdQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmPb0jZGWeadX4KqsyQTx4Oo2gLg-3h+u=Ec=9rqzzjdQ@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 8 Jun 2026 11:40:57 -0300
X-Gm-Features: AVVi8CfKQXgAwwqZEw7R--kojkPEyX2nf49kzjGoJyQCrGUleQLCcSKgl2ERV2c
Message-ID: <CA+NMeC_3bzJzn_NjztcnM=C1M0Xrf7Xo26DiQNRy_o_iZPAnMg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000433d870653bf0078"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296605-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trailofbits.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4705565792F

--000000000000433d870653bf0078
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:46=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sun, Jun 7, 2026 at 10:33=E2=80=AFAM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > On Sat, Jun 6, 2026 at 5:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
> > > <sam.moelius@trailofbits.com> wrote:
> > > >
> > > > The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> > > > header fields without confirming that the IPv4 protocol field match=
es
> > > > the selected transport header.
> > > >
> > > > That lets a rule written for TCP or UDP modify unrelated payload by=
tes
> > > > in a packet carrying a different protocol.
> > > >
> > > > Verify the IPv4 protocol before applying TCP or UDP extended header
> > > > edits.
> > > >
> > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > > ---
> > > >  net/sched/act_pedit.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > index bc20f08a2789..9a4590451f7e 100644
> > > > --- a/net/sched/act_pedit.c
> > > > +++ b/net/sched/act_pedit.c
> > > > @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff *=
skb, int *hoffset, const int head
> > > >
> > > >                 if (!iph)
> > > >                         goto out;
> > > > +               if (iph->ihl < 5 || iph->protocol !=3D header_type)
> > > > +                       goto out;
> > >
> > > From inspection the fix looks reasonable.
> > > At first glance it seems that the only fix that resolves the issue yo=
u
> > > are describing is to check the protocol header.
> > > header length seems to be an extra thing. But let's do what the v6
> > > side seems to and skip frags as well? Something maybe along the lines
> > > of:
> > >
> > > if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_off =
&
> > > htons(IP_OFFSET)))
> > >         goto out;
> >
> > I will submit an updated patch.
> >
> > > Are you able to describe how someone would configure a tc rule that
> > > will allow this to happen?
> > > IOW, how did you verify the problem and then validate that your fix w=
orks?
> >
> > The bug was validated using a custom init script in QEMU. The specific
> > line used was:
> >
> > /usr/sbin/tc filter add dev veth0 egress protocol ip pref 1 matchall
> > action pedit ex munge udp dport set 18053
> >
> > An IPv4 TCP packet with destination port 2222 was sent through that
> > path. With the unpatched kernel, the packet was received with TCP
> > destination port 18053. With the patched kernel, the same packet was
> > received unchanged.
> >
> > I can provide more details or artifacts if you would like.
>
> A tdc test case is better. Victor or I can create one for you if you
> dont know how.

It seems like v2 isn't applying so you'll have to send a new version.
When you do, after waiting for the 24h period, can you resend with
the attached patch (containing the tdc test)? Since this is a
fix, in the new version, remember to target net and add a proper fixes
tag.

cheers,
Victor

--000000000000433d870653bf0078
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-selftests-tc-testing-Verify-pedit-does-not-mangle-mi.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-tc-testing-Verify-pedit-does-not-mangle-mi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mq5b7q7o0>
X-Attachment-Id: f_mq5b7q7o0

RnJvbSA5ZmMwMzk1NjRhZGRhYzAzMTJjZWI5YzkyMTBjYjkzZWE0NGU4YTlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0dS5jb20+
CkRhdGU6IE1vbiwgOCBKdW4gMjAyNiAxMToxMDowNSAtMDMwMApTdWJqZWN0OiBbUEFUQ0ggbmV0
IHYzXSBzZWxmdGVzdHMvdGMtdGVzdGluZzogVmVyaWZ5IHBlZGl0IGRvZXMgbm90IG1hbmdsZQog
bWlzbWF0Y2hlZCBMNCBwcm90b2NvbAoKQWRkIGEgdGRjIHRlc3QgdGhhdCBjaGVja3MgdGhlIGFj
dF9wZWRpdCBleHRlbmRlZCBMNCBoZWFkZXIgbW9kZSBkb2VzIG5vdAplZGl0IGEgcGFja2V0IHdo
b3NlIElQdjQgcHJvdG9jb2wgZG9lcyBub3QgbWF0Y2ggdGhlIHNlbGVjdGVkIHRyYW5zcG9ydApo
ZWFkZXIuCgpUaGUgdGVzdCBpbnN0YWxscyBhbiBpbmdyZXNzIHBlZGl0IHJ1bGUgdGhhdCBzZXRz
IHRoZSBVRFAgZGVzdGluYXRpb24KcG9ydCwgdGhlbiBpbmplY3RzIGEgVENQIHBhY2tldCB3aXRo
IGRwb3J0IDIyMjIuIFRoZSBVRFAgYW5kIFRDUApkZXN0aW5hdGlvbiBwb3J0cyBzaXQgYXQgdGhl
IHNhbWUgTDQgb2Zmc2V0LCBzbyBhIGJ1Z2d5IGtlcm5lbCByZXdyaXRlcwp0aGUgVENQIGRwb3J0
LiBBIHNlY29uZCBmbG93ZXIgZmlsdGVyIG1hdGNoZXMgVENQIGRwb3J0IDIyMjIgYW5kIGRyb3Bz
CnRoZSBwYWNrZXQgdGhyb3VnaCBhbiBpbmRleGVkIGdhY3QgYWN0aW9uOyB0aGUgdGVzdCB0aGVu
IHZlcmlmaWVzIHZpYQpKU09OIHRoYXQgdGhpcyBhY3Rpb24gc2F3IGV4YWN0bHkgb25lIHBhY2tl
dCwgaS5lLiB0aGUgZHBvcnQgd2FzIGxlZnQKdW50b3VjaGVkIGFuZCBzdGlsbCBtYXRjaGVkIDIy
MjIuCgpTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0dS5jb20+
Ci0tLQogLi4uL3RjLXRlc3RpbmcvdGMtdGVzdHMvYWN0aW9ucy9wZWRpdC5qc29uICAgIHwgNDkg
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3RjLXRlc3RzL2Fj
dGlvbnMvcGVkaXQuanNvbiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMt
dGVzdHMvYWN0aW9ucy9wZWRpdC5qc29uCmluZGV4IDM3YzQxMDMzMjE3NDkuLmQ4YjY4NWNmYzYy
ZGUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMtdGVz
dHMvYWN0aW9ucy9wZWRpdC5qc29uCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRl
c3RpbmcvdGMtdGVzdHMvYWN0aW9ucy9wZWRpdC5qc29uCkBAIC0xOTIwLDUgKzE5MjAsNTQgQEAK
ICAgICAgICAgInRlYXJkb3duIjogWwogICAgICAgICAgICAgIiRUQyBhY3Rpb25zIGZsdXNoIGFj
dGlvbiBwZWRpdCIKICAgICAgICAgXQorICAgIH0sCisgICAgeworICAgICAgICAiaWQiOiAiMWE0
ZiIsCisgICAgICAgICJuYW1lIjogIlBlZGl0IHVkcCBkcG9ydCBzaG91bGQgbm90IG1hbmdsZSBU
Q1AgcGFja2V0IGRwb3J0IiwKKyAgICAgICAgImNhdGVnb3J5IjogWworICAgICAgICAgICAgImFj
dGlvbnMiLAorICAgICAgICAgICAgInBlZGl0IgorICAgICAgICBdLAorICAgICAgICAicGx1Z2lu
cyI6IHsKKyAgICAgICAgICAgICJyZXF1aXJlcyI6IFsKKyAgICAgICAgICAgICAgICAibnNQbHVn
aW4iLAorICAgICAgICAgICAgICAgICJzY2FweVBsdWdpbiIKKyAgICAgICAgICAgIF0KKyAgICAg
ICAgfSwKKyAgICAgICAgInNldHVwIjogWworICAgICAgICAgICAgIiRUQyBxZGlzYyBhZGQgZGV2
ICRERVYxIGNsc2FjdCIsCisgICAgICAgICAgICAiJFRDIGZpbHRlciBhZGQgZGV2ICRERVYxIGlu
Z3Jlc3MgcHJvdG9jb2wgaXAgcHJlZiAxIG1hdGNoYWxsIGFjdGlvbiBwZWRpdCBleCBtdW5nZSB1
ZHAgZHBvcnQgc2V0IDE4MDUzIGNvbnRpbnVlIgorICAgICAgICBdLAorICAgICAgICAiY21kVW5k
ZXJUZXN0IjogIiRUQyBmaWx0ZXIgYWRkIGRldiAkREVWMSBpbmdyZXNzIHByb3RvY29sIGlwIHBy
ZWYgMiBmbG93ZXIgaXBfcHJvdG8gdGNwIGRzdF9wb3J0IDIyMjIgYWN0aW9uIGRyb3AgaW5kZXgg
MSIsCisgICAgICAgICJzY2FweSI6IHsKKyAgICAgICAgICAgICJpZmFjZSI6ICIkREVWMCIsCisg
ICAgICAgICAgICAiY291bnQiOiAxLAorICAgICAgICAgICAgInBhY2tldCI6ICJFdGhlcigpL0lQ
KGRzdD0nMTAuMTAuMTAuMScpL1RDUChkcG9ydD0yMjIyKSIKKyAgICAgICAgfSwKKyAgICAgICAg
ImV4cEV4aXRDb2RlIjogIjAiLAorICAgICAgICAidmVyaWZ5Q21kIjogIiRUQyAtaiAtcyBhY3Rp
b25zIGdldCBhY3Rpb24gZ2FjdCBpbmRleCAxIiwKKyAgICAgICAgIm1hdGNoSlNPTiI6IFsKKyAg
ICAgICAgICAgIHsKKyAgICAgICAgICAgICAgICAidG90YWwgYWN0cyI6IDAKKyAgICAgICAgICAg
IH0sCisgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAgImFjdGlvbnMiOiBbCisgICAgICAg
ICAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICJvcmRlciI6IDEsCisgICAg
ICAgICAgICAgICAgICAgICAgICAia2luZCI6ICJnYWN0IiwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICJjb250cm9sX2FjdGlvbiI6IHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHlw
ZSI6ICJkcm9wIgorICAgICAgICAgICAgICAgICAgICAgICAgfSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICJpbmRleCI6IDEsCisgICAgICAgICAgICAgICAgICAgICAgICAic3RhdHMiOiB7Cisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgInBhY2tldHMiOiAxCisgICAgICAgICAgICAgICAg
ICAgICAgICB9CisgICAgICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAgICBdCisgICAg
ICAgICAgICB9CisgICAgICAgIF0sCisgICAgICAgICJ0ZWFyZG93biI6IFsKKyAgICAgICAgICAg
ICIkVEMgcWRpc2MgZGVsIGRldiAkREVWMSBjbHNhY3QiCisgICAgICAgIF0KICAgICB9CiBdCi0t
IAoyLjU0LjAKCg==
--000000000000433d870653bf0078--

