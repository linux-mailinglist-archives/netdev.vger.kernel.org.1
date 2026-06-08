Return-Path: <netdev+bounces-296685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MI/JCPcHJ2r2qQIAu9opvQ
	(envelope-from <netdev+bounces-296685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F054659A6F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=MT2IXrof;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B753165505
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEB367B6A;
	Mon,  8 Jun 2026 17:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05F33F5AB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:52:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941181; cv=pass; b=j17NCT3qOwyXXfQj+HaCp5l1Y3J55Lb+3VMLQrozE7xJHUiX2lbX4KI6Kctkjo574dCvR+ZKR2Gb9GypcQIotFMsBnfIQJ6d8+lJ1PTu8l+J3KNHUluIxv/9D1ivuDXJ1DkkMNtXzBcGlNS4Z0v/txnzyPNRv8j0ndSoV3VZZrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941181; c=relaxed/simple;
	bh=e1x2rzWQoDLBoY2czZnuTyau9spcgORZUPIxFpavLfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvSkgD6Yx6hOeXaClrX33H45hWlfgBvz6mI8t6Qo25ZRklnudFMVAwlW/cirEi/7L/rQkuRvcPUeP93jgv6v9yOeHeV3tQqSbfo4brWWoF5N1VU8IGgh+m6F6mMR3XTRmXTkCU1U3H5Ly++YBD5/v/GAWghbbxeSu9VEBFD9Csk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MT2IXrof; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc2b658544so41698437b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941179; cv=none;
        d=google.com; s=arc-20240605;
        b=HLbrTMrAqhuDKafdtxNNlrjo/rvCsVzYjEZuSY07hJTIcpwlNtgyjoJSZ1LrrsBnUK
         J4olsNGg25PiafHx+7PIX8IAayjAwp00X5SXa/gkEocBWxSOvpNvP9ERyX/Yk1nEERxF
         5ClPGUoR41Cq0JrV4eSQRG9u7HsWkEQjUVjejKp8a/jpsDChM8nLryYeU6WPzL3l+MGE
         DDaaCr6eM4GGgWpDsBlE4GxnoAxe8OXrJLrGAfot0fFXL2wL7cs6d9CteC94b+Vrk+st
         IgXJSQw6qo3k9Tm+SeIHXzrEwcDB4qR/hJhJpZ7DGtDRsjq8+BD1Eyb6LWi1tQ5pt3EA
         fz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yC1T7yi5n/99OyfejeH/fN+8kp2R5jxAOLKuBdhZnis=;
        fh=tDhAx9JphyS5aWwvqEPSd2dXc7Gb/Fe//cIgvydhlFE=;
        b=do/fVOx5J6F0kNi3jChU3pxWfZTkXtD1wmvc2JZbs37T/UyrXYaXJp1QkdB3eHK07e
         z0L4qL11kF/1+cu4UZpr5o6f4f5RVPitsZgLs2kpd4jbTQV8o9DrQvsYV5F6FJ5w1Wbz
         utWwZ+Hu/Y2THie5St8FU81qmYyUL1z6mgqCwessAeSQU6ee20oHhZz81tryjxkHYVvt
         iJX/bzxSCU0ISVy/c2+KiIpbqA28WL0SEg6Z381R4LKfFQiJv5tjEk9rs0o57fSmirJr
         /6z3pdkkDq2GfFAmdqT2lkGWcO7TlhxX7qWq6r/E04ikOT6XCEw/d0bNurpV/YulC5bD
         c5Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780941179; x=1781545979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yC1T7yi5n/99OyfejeH/fN+8kp2R5jxAOLKuBdhZnis=;
        b=MT2IXrofn3GyQVk6rT+2WtT5D2mZI7nUrY+zen/mtO9T1gyCYr0pWTkS+DaNcB7NQb
         ehhKgiQPZDiIWvX+KZJctc/wt+5jNf0peaA0utEvvmeOShwvWoEzqedRtvNeNfjKo4gD
         +S44Dt2UMREo0lkpCSj3onSlZp91w1qQs+05A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941179; x=1781545979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC1T7yi5n/99OyfejeH/fN+8kp2R5jxAOLKuBdhZnis=;
        b=mCpYnwz+atD7MxxwlrIBdJG+VKxlUvy/I86/KN7/6c4k6GW6zkBgnPDdjeGczbemQf
         0s+sQUQ3wwqnclznRUQr17WNCQfLDaNS1e42qKFNBoVtm5qQrpHJEW860t3W5bNEHxGS
         C+B75ubf0gP0ZqbMNQGMl2z6H2ls6MKaFH381YR5uPwuUlg7YBfQX9GyT3tZ5oc7yxz3
         CpG3OOoTSYMk3yT3VzbvbMiJ90QWF5ru+GbEPFUoNsFmazEfdBJOCxlo9mvs4Yxjytpk
         x7UaHoqT5TBcRl87ZMgsYTKHH7VGtViKF183KsUmcwKJfH2H+QfNyyorvfDUZinZYyWi
         5nPw==
X-Forwarded-Encrypted: i=1; AFNElJ9kNZDGTXb2HRaIX4jQaK+X+FZ3TEqFTZZRh7aeOho+aWm0GtQ2WeIA/Fr8E8yGcZnJ+swY1HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzh7NlCL+4v8TdpPv4gNdUhaIl1Zmsfx8HbtHyJpV25ITHZIuX
	FOHn8WwBH5hsgcPGQhQJH1VCbA8ymQ4ZNi+Gf+XiYHNjxWbqTMHzAI1X3h5lMDZgbklPZ5B/KiD
	CTs81T1CSjpvLFlH8hpaEcl2t3llf+0eSmK99d/5F
X-Gm-Gg: Acq92OHp5IZh88NyAfB1MhXsi8kgIsjXJcpfbFTZPlDIg1SJRdgv4Gs+Lt63PaRQWua
	IASYqkEmUqJjfBzB2AxR3Z5MQO0TKqEMdJlPYeM5oQ5Ui5jeqnYQ2CLtvcy0MNiMoYyJn/Qu/Kk
	w6yqzky1Q3fJZ/4/JiC2CRmRqwwHUwPsPpoBJcJxqX3k65LLfQHVzAWgBCnRf+0lglTEuGXPa7f
	onRcvi96W2bvMVXOOt0GBJUGsWwBeR73x0m9cvTuZr3+UMioJ787UES2P0fyeOqplsnGe/BhPge
	g8ikGwNmyCdpYwFMXr8mvCzdo5CNmbsLUvQoKiBeyhiursmT
X-Received: by 2002:a05:690c:c155:b0:7ef:afa9:7d1d with SMTP id
 00721157ae682-7efafa990b6mr77870257b3.11.1780941178795; Mon, 08 Jun 2026
 10:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780809474.git.edragain@163.com> <6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com>
 <CAM0EoMm5YH+BKEUbtAy7iaxrF73Wti==9n1gbMOHwK+vaFALdQ@mail.gmail.com>
In-Reply-To: <CAM0EoMm5YH+BKEUbtAy7iaxrF73Wti==9n1gbMOHwK+vaFALdQ@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 8 Jun 2026 14:52:47 -0300
X-Gm-Features: AVVi8CeVzkM2praeWthEj7aOXHrYSWa9uIyTl63lXIKfdX7CCl4kayWFCyK8Pcs
Message-ID: <CA+NMeC_z8_qZ6jZ+gjMLZ-QS5MbwUPEbreV=fHJvMCoGza+yQA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: act_ife: ensure ETH_HLEN is pullable
 after decap
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, xiyou.wangcong@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, edragain@163.com
Content-Type: multipart/mixed; boundary="0000000000005460b30653c1aeff"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TAGGED_FROM(0.00)[bounces-296685-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,resnulli.us,davemloft.net,gmail.com,163.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:email,mail.gmail.com:mid,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F054659A6F

--0000000000005460b30653c1aeff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 7:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sun, Jun 7, 2026 at 5:14=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Yong Wang <edragain@163.com>
> >
> > tcf_ife_decode() calls eth_type_trans() after ife_decode() removes the
> > outer IFE header and metadata. However, ife_decode() only makes the out=
er
> > IFE header area pullable before advancing skb->data.
> >
> > As a result, the decapsulated inner Ethernet header may still be shorte=
r
> > than ETH_HLEN in the linear data area, or entirely reside in frags.
> > eth_type_trans() then operates on an skb that does not satisfy its
> > expected Ethernet header access requirements, which can trigger a BUG i=
n
> > the pull path.
> >
> [...]
> From inspection this looks legit. I did not run your poc.
> Could you create a tdc test instead? You should be able to craft a
> scapy ethernet frame using nsplugin. Something like this:
> Ether(type=3D0xED3E) / Raw(b'\\x00\\x02\\xaa') would suffice.
> That would be more helpful for future reference as well.

Can you try to run this tdc test?

cheers,
Victor

--0000000000005460b30653c1aeff
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-selftests-tc-testing-Verify-IFE-can-handle-truncated.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-tc-testing-Verify-IFE-can-handle-truncated.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mq5i3wnu0>
X-Attachment-Id: f_mq5i3wnu0

RnJvbSA2YjdiYTNkNTUzZGZhOGU3NmJkYWQ4NDM4Zjk1ODVmZGEyYjJmYzM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0dS5jb20+
CkRhdGU6IE1vbiwgOCBKdW4gMjAyNiAxMDowMzo0OCAtMDMwMApTdWJqZWN0OiBbUEFUQ0ggbmV0
XSBzZWxmdGVzdHMvdGMtdGVzdGluZzogVmVyaWZ5IElGRSBjYW4gaGFuZGxlIHRydW5jYXRlZAog
aW5uZXIgRXRoZXJuZXQgaGVhZGVyCgpBZGQgYSB0ZGMgdGVzdCB0aGF0IGV4ZXJjaXNlcyB0aGUg
YWN0X2lmZSBkZWNvZGUgcGF0aCB3aXRoIGEgbWFsZm9ybWVkCklGRSBwYWNrZXQgd2hvc2UgZW5j
YXBzdWxhdGVkIGlubmVyIEV0aGVybmV0IGhlYWRlciBpcyB0cnVuY2F0ZWQuCgpUaGUgaW5qZWN0
ZWQgZnJhbWUgaGFzIGEgdmFsaWQgb3V0ZXIgRXRoZXJuZXQgaGVhZGVyIChldGhlcnR5cGUgMHhF
RDNFKQphbmQgYSBtaW5pbWFsIElGRSBoZWFkZXIgKG1ldGFsZW4gMiwgaS5lLiBubyBtZXRhZGF0
YSBUTFZzKSwgYnV0IHRoZQpwYXlsb2FkIHRoYXQgc2hvdWxkIGhvbGQgdGhlIG9yaWdpbmFsIGZy
YW1lIGlzIGEgc2luZ2xlIGJ5dGUgaW5zdGVhZCBvZgphIGZ1bGwgRXRoZXJuZXQgaGVhZGVyLiBP
bmNlIGlmZV9kZWNvZGUoKSBzdHJpcHMgdGhlIG91dGVyIGhlYWRlciBhbmQKdGhlIElGRSBtZXRh
ZGF0YSwgZmV3ZXIgdGhhbiBFVEhfSExFTiBieXRlcyBhcmUgbGVmdCwgd2hpY2ggcHJldmlvdXNs
eQpsZXQgZXRoX3R5cGVfdHJhbnMoKSByZWFkIHBhc3QgdGhlIGVuZCBvZiB0aGUgbGluZWFyIGRh
dGEuCgpTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0dS5jb20+
Ci0tLQogLi4uL3RjLXRlc3RpbmcvdGMtdGVzdHMvYWN0aW9ucy9pZmUuanNvbiAgICAgIHwgNTUg
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3RjLXRlc3RzL2Fj
dGlvbnMvaWZlLmpzb24gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3RjLXRl
c3RzL2FjdGlvbnMvaWZlLmpzb24KaW5kZXggODA4YWVmNGFmZTIyLi5lY2U3ZWM0MWJmOTkgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMtdGVzdHMvYWN0
aW9ucy9pZmUuanNvbgorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3Rj
LXRlc3RzL2FjdGlvbnMvaWZlLmpzb24KQEAgLTEzNzgsNSArMTM3OCw2MCBAQAogICAgICAgICAi
dGVhcmRvd24iOiBbCiAgICAgICAgICAgICAiJFRDIGFjdGlvbnMgZmx1c2ggYWN0aW9uIGlmZSIK
ICAgICAgICAgXQorICAgIH0sCisgICAgeworICAgICAgICAiaWQiOiAiNGU2YiIsCisgICAgICAg
ICJuYW1lIjogIkRlY29kZSBJRkUgcGFja2V0IHdpdGggdHJ1bmNhdGVkIGlubmVyIEV0aGVybmV0
IGhlYWRlciIsCisgICAgICAgICJjYXRlZ29yeSI6IFsKKyAgICAgICAgICAgICJhY3Rpb25zIiwK
KyAgICAgICAgICAgICJpZmUiCisgICAgICAgIF0sCisgICAgICAgICJwbHVnaW5zIjogeworICAg
ICAgICAgICAgInJlcXVpcmVzIjogWworICAgICAgICAgICAgICAgICJuc1BsdWdpbiIsCisgICAg
ICAgICAgICAgICAgInNjYXB5UGx1Z2luIgorICAgICAgICAgICAgXQorICAgICAgICB9LAorICAg
ICAgICAic2V0dXAiOiBbCisgICAgICAgICAgICBbCisgICAgICAgICAgICAgICAgIiRUQyBhY3Rp
b25zIGZsdXNoIGFjdGlvbiBpZmUiLAorICAgICAgICAgICAgICAgIDAsCisgICAgICAgICAgICAg
ICAgMSwKKyAgICAgICAgICAgICAgICAyNTUKKyAgICAgICAgICAgIF0sCisgICAgICAgICAgICAi
JFRDIHFkaXNjIGFkZCBkZXYgJERFVjEgY2xzYWN0IgorICAgICAgICBdLAorICAgICAgICAic2Nh
cHkiOiBbCisgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAgImlmYWNlIjogIiRERVYwIiwK
KyAgICAgICAgICAgICAgICAiY291bnQiOiAxLAorICAgICAgICAgICAgICAgICJwYWNrZXQiOiAi
RXRoZXIodHlwZT0weEVEM0UpIC8gUmF3KGInXFx4MDBcXHgwMlxceGFhJykiCisgICAgICAgICAg
ICB9CisgICAgICAgIF0sCisgICAgICAgICJjbWRVbmRlclRlc3QiOiAiJFRDIGZpbHRlciBhZGQg
ZGV2ICRERVYxIGluZ3Jlc3MgcHJvdG9jb2wgYWxsIG1hdGNoYWxsIGFjdGlvbiBpZmUgZGVjb2Rl
IHBpcGUgaW5kZXggMTAiLAorICAgICAgICAiZXhwRXhpdENvZGUiOiAiMCIsCisgICAgICAgICJ2
ZXJpZnlDbWQiOiAiJFRDIC1zIC1qIGFjdGlvbnMgZ2V0IGFjdGlvbiBpZmUgaW5kZXggMTAiLAor
ICAgICAgICAibWF0Y2hKU09OIjogWworICAgICAgICAgICAgeworICAgICAgICAgICAgICAidG90
YWwgYWN0cyI6IDAKKyAgICAgICAgICAgIH0sCisgICAgICAgICAgICB7CisgICAgICAgICAgICAg
ICJhY3Rpb25zIjogWworICAgICAgICAgICAgICAgICAgeworICAgICAgICAgICAgICAgICAgICAg
ICJraW5kIjogImlmZSIsCisgICAgICAgICAgICAgICAgICAgICAgIm1vZGUiOiAiZGVjb2RlIiwK
KyAgICAgICAgICAgICAgICAgICAgICAiaW5kZXgiOiAxMCwKKyAgICAgICAgICAgICAgICAgICAg
ICAic3RhdHMiOiB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICJieXRlcyI6IDMsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICJwYWNrZXRzIjogMSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgImRyb3BzIjogMQorICAgICAgICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAg
ICAgIH0KKyAgICAgICAgICAgICAgXQorICAgICAgICAgICAgfQorICAgICAgICBdLAorICAgICAg
ICAidGVhcmRvd24iOiBbCisgICAgICAgICAgICAiJFRDIHFkaXNjIGRlbCBkZXYgJERFVjEgY2xz
YWN0IgorICAgICAgICBdCiAgICAgfQogXQotLSAKMi41NC4wCgo=
--0000000000005460b30653c1aeff--

