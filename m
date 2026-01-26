Return-Path: <netdev+bounces-253622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WABqODr9d2kvnAEAu9opvQ
	(envelope-from <netdev+bounces-253622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6EC8E50A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEC663024440
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967643101AD;
	Mon, 26 Jan 2026 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjQry7wM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B628850C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471287; cv=pass; b=ZbocpYJhC12mgPQUSqbc75tm8IR6S6DXGzj8UQWG0opekCWyz4b1O/04/JwRELQnNwrQsaodtW4hYthmT9h61mP9nKnf0tPiCC1b/pQOEnzB/RNz+qb5tdxE9XwAFqZi6LFDZE/hFUEvvts0YJvLy/bclrhb3ANRKA+tLRzvjjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471287; c=relaxed/simple;
	bh=6P7K47Ygy+L97CBlUR3oUNT4NXx+pgENUXHRpAc7cOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8CWzdlTXeca+Q/x6ufzknfo0YfaCSr6a4HB+XvcGLMQ/rEkIs9iCrYbGkml4bLq6JLM/ORAtmSduiKg9SGMqXWbQ4s7eqvw3QZLybmsHE/WFturX3SHCVpZzHhcxBsMmEq6eOf2Fi5mFmGONam6xb2fJ6gjotOwrdpngsVTBUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjQry7wM; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a097cc08d5so12522405ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769471285; cv=none;
        d=google.com; s=arc-20240605;
        b=bmikljsgCncewc1+FqK8xXP/KdD4jSHSY9leRxfNXrcOE3aGWSN0/WKxR+rlfbgUO0
         BKgIYlye+WSs3nksLobozJ3Zwr8VmtjqgjVg5mwfG59BTm3QoZ6sUnjVqfkJn/musGJN
         iWN1cnfczTLGRn0YTJQrb2sxIEN36nqcmVSUEkyPrP1GKdn89u5pDHXq/kqAWcUagXgq
         szEk2Zx78zlv+kFPl7espkLPSqnztfPZW00xnMRuvW7E+sWqGEXqvLRmPggtpS6vBxmj
         Y8YtvQ1UiEVsoWRGOhB4ALgOqYaVTplP0B5m6dCApLYdL0R4NiPeykKCjf8EkivhPKI/
         q90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GO5kGcOId02q+94y1nKynoWWSsh0iwJBp3duKSsqaD0=;
        fh=CZdKTfxlXuIKIjnRXlG9t/9xZg9yLT/HMzAvp04myPM=;
        b=KvaVg3xQZ3h7sPHG7MKAxS4xrxyP7uietfM5xPoWSB6k63b5ptK4PLfTWTkio+X7Wo
         9tvbVQJiXVZhYTmf7E9lmB1i/Mpo+KKA0smYWdz67R10AH3lWlxB/xv1D+gJ9+qBhgtk
         aWeeu70xTu1vBvFHAx6MXGmaNRLrMBgdBsLpY013XEgVucjH+v6xrp3SPCyq91AKNJmc
         B/ktRvCfHGOisN8VlHohswy32w0QGygv+VdU+mkq7hz92q1JZmPyw0JimAST2TL8yAvh
         QNskmighFLTRkUywxhsNmKAyq7SUqDWpzt8dQiPa0KkpYPfcPF7rAArOQ26ATCxoZIPQ
         CfQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769471285; x=1770076085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO5kGcOId02q+94y1nKynoWWSsh0iwJBp3duKSsqaD0=;
        b=fjQry7wMBp0lVxmMqHtQok+9B54ox6DceDyg65HcZ8fVEnNt9NK47dJLFhK/534s2o
         iO/+GvU39qWFKFGK6WL7OQSnJ9YQG6A4t3rY02ShIBJ87sGlY2AsmcjgWyPSRvsddFRm
         RHOipNh/HX9aSI0NF/XbYLX9umNxjqENg9B+QgvJY7m7IwsYi6CkkPKqNvF4sF5cCs8v
         IHlW/rGfDns9Wps/EadG/AIUUB+ahRqldoCWw61b6BhB8F2Hmi80g72osr2MjiNdrPdH
         N1GO8VlHaXsqVBhyBD4S7LIDV3xosOzfy6QhcMupZ8GxruES0HBWp27EX5z6/pdOgI3a
         jOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471285; x=1770076085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GO5kGcOId02q+94y1nKynoWWSsh0iwJBp3duKSsqaD0=;
        b=pb647OFPlBzUvQzwpYW0UGwUHzPANkEzizeng2+/q5HpF/zkwjkFx6tTS4g1dSOZyS
         oe3VXgYNFf4QNe0XEwfwVtrgNE2SnMhWGeRHUs8/EkRIHkSYynrk94hoPaC7uQ8BUdsm
         0NS+lPL0oGeL23dE8VYYa5ErqcQWaMMZdcvF1BdF8Th1fbLa+BCHQzyrQ6oy4dOkD1kT
         XBgWCfUqwnuGBYKprivP/CrobEwezACbFRah236pJvclstS+BWL6swQ0W0CgHIOkoP2q
         27yfL2b1vy+wW7xGBTKGZMKELesgJFI0IFWSZjEOZhX5bDNOWgQD1AnFE41MEhTKfiua
         bT2g==
X-Forwarded-Encrypted: i=1; AJvYcCVy0nLie7iYmiRe+QEVJePUcBlJ0117Sl0Cu9m0lsllWMz8sv+7epdByctHTPbLCLUUamiLvcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQDRHCWi0/denA1se6MLlKkRJ2huKWFlodpcpR2Ox5DDNZXSA
	tlIXxGwF1gtPeaZA7Mc7Jfqz943GnG+pQhpDD+6HKXhmZNOS+3SgJkOjSa/xPVhJMEVnKO1KEsk
	NFsD9xn+NJp67VkbW9Mt03a26lJkq6dCZ6vBLQaog5g==
X-Gm-Gg: AZuq6aK3uiV8dSOSM12W3mo4+sZ3KjaR4P6y+PDCZ6RUtxLDU9ldFKlmn7MlkwNflGV
	1AYARMi1kfRTbftd2FGWRDPmi2BmsJYsDcS7RJ27XIiPVwcrtOSnfrHxBeWEV91hyeTjtHTNIko
	s9cBJ819qLGxMox5c3V9MvP1wErFLfw9vblM/mOWh3MsrULfXdHeffUH6QlrawEPQnzlQZN683D
	WvVL8wmqNkWtIm/ozaUpROI3knnrp59oWQ5OmjfrImQ28kgRue0u33J5TNucT8ZRaRL8G4sObgt
	q+NNF43fa1firxgjsf4kQWHUT/k=
X-Received: by 2002:a17:90b:588d:b0:352:ebe9:2828 with SMTP id
 98e67ed59e1d1-353c41bb19emr4042574a91.7.1769471285492; Mon, 26 Jan 2026
 15:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
 <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
 <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
 <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
 <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
 <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com>
 <CANn89iL1oB2J6whubYof+2AVWpWRm+gBsp3P8-xRP8Y22Jy6_w@mail.gmail.com> <CAM0EoMnwGW05yc50ZyoKE28F-jZHeEtX+X4H2Xx6+KBQn-v6DQ@mail.gmail.com>
In-Reply-To: <CAM0EoMnwGW05yc50ZyoKE28F-jZHeEtX+X4H2Xx6+KBQn-v6DQ@mail.gmail.com>
From: GangMin Kim <km.kim1503@gmail.com>
Date: Tue, 27 Jan 2026 08:47:54 +0900
X-Gm-Features: AZwV_Qi7wby4giSxNv4BVIuFsKTpj3OPOLRfFGZItfSUC2EsIWXbQWcjbIzvvuo
Message-ID: <CAGfirfcWbnW0wMYSZNs4M5Hj-qPn1edJsDq9Y-4yxuBvOMzdWQ@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: Jamal Hadi Salim <jhs@mojatatu.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, jiri@resnulli.us, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	horms@kernel.org, syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmkim1503@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A6EC8E50A
X-Rspamd-Action: no action

Structured the patch following similar commits to prevent out-of-bounds acc=
ess.

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -111,6 +111,17 @@ static inline unsigned int u32_hash_fold(__be32 key,
  return h;
 }

+static bool offset_valid(struct sk_buff *skb, int offset)
+{
+ if (offset > 0 && offset > skb->len)
+ return false;
+
+ if (offset < 0 && -offset > skb_headroom(skb))
+ return false;
+
+ return true;
+}
+
 TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
     const struct tcf_proto *tp,
     struct tcf_result *res)
@@ -214,6 +225,8 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
  if (ht->divisor) {
  __be32 *data, hdata;

+ if (!offset_valid(skb, off + n->sel.hoff))
+ goto out;
  data =3D skb_header_pointer(skb, off + n->sel.hoff, 4,
    &hdata);
  if (!data)
@@ -229,6 +242,8 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
  if (n->sel.flags & TC_U32_VAROFFSET) {
  __be16 *data, hdata;

+ if (!offset_valid(skb, off + n->sel.offoff))
+ goto out;
  data =3D skb_header_pointer(skb,
    off + n->sel.offoff,
    2, &hdata);

2026=EB=85=84 1=EC=9B=94 27=EC=9D=BC (=ED=99=94) AM 12:24, Jamal Hadi Salim=
 <jhs@mojatatu.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jan 26, 2026 at 9:11=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jan 26, 2026 at 2:51=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 7:26=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Jan 26, 2026 at 1:11=E2=80=AFPM =EA=B9=80=EA=B0=95=EB=AF=BC=
 <km.kim1503@gmail.com> wrote:
> > > > >
> > > > > I propose the following patch and would appreciate your review.
> > > > >
> > > > > hoff is used as an offset argument to skb_header_pointer() in
> > > > > u32_classify(), and negative values can cause out-of-bounds read.=
 As
> > > > > shown in the code below, offoff follows the same pattern and requ=
ires
> > > > > the same validation.
> > > > > ```
> > > > > TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
> > > > >    const struct tcf_proto *tp,
> > > > >    struct tcf_result *res)
> > > > > {
> > > > > ...
> > > > > if (n) {
> > > > > ...
> > > > > if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
> > > > > off2 =3D n->sel.off + 3;
> > > > > if (n->sel.flags & TC_U32_VAROFFSET) {
> > > > > __be16 *data, hdata;
> > > > >
> > > > > data =3D skb_header_pointer(skb,
> > > > >   off + n->sel.offoff,
> > > > >   2, &hdata);
> > > > > if (!data)
> > > > > goto out;
> > > > > off2 +=3D ntohs(n->sel.offmask & *data) >>
> > > > > n->sel.offshift;
> > > > > }
> > > > > off2 &=3D ~3;
> > > > > }
> > > > > ...
> > > > > }
> > > > > ...
> > > > > }
> > > > > ```
> > > > > Therefore, I propose a patch that rejects negative hoff and offof=
f
> > > > > values during u32 classifier configuration.
> > > > >
> > > > > --- a/net/sched/cls_u32.c
> > > > > +++ b/net/sched/cls_u32.c
> > > > > @@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, str=
uct
> > > > > sk_buff *in_skb,
> > > > >   err =3D -EINVAL;
> > > > >   goto erridr;
> > > > >   }
> > > > > +
> > > > > + if (s->hoff < 0 || s->offoff < 0) {
> > > > > + err =3D -EINVAL;
> > > > > + goto erridr;
> > > > > + }
> > > > >
> > > >
> > > > Negative values are valid, it is ok to access data between skb->hea=
d
> > > > and skb->data.
> > >
> > > Right. We have to do this at runtime in classify().
> > > Can you test with your POC with Eric's suggested fix?
> > >
> > > Eric, can we do something like pedit? See: offset_valid() usage
> >
> >
> > Yes, it seems net/sched/act_pedit.c had a similar issue in the past :)
> >  Amir fixed it with
> >
> > commit 95c2027bfeda21a28eb245121e6a249f38d0788e
> > Author: Amir Vadai <amir@vadai.me>
> > Date:   Mon Nov 28 12:56:40 2016 +0200
> >
> >     net/sched: pedit: make sure that offset is valid
> >
> >     Add a validation function to make sure offset is valid:
> >     1. Not below skb head (could happen when offset is negative).
> >     2. Validate both 'offset' and 'at'.
> >
> >     Signed-off-by: Amir Vadai <amir@vadai.me>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> =EA=B9=80=EA=B0=95=EB=AF=BC,
> Are you able to send a similar patch? Otherwise one of us will.
>
> cheers,
> jamal

