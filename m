Return-Path: <netdev+bounces-32498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73456798057
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004FD1C20C48
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB89EBB;
	Fri,  8 Sep 2023 01:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B09EA0
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 01:45:43 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436111BDD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:45:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso195177766b.3
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 18:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694137540; x=1694742340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UW7+a7tXpeEAZxVIZ+dmlSSTRPuRpH8sTuYBLqEcEUo=;
        b=dlu1ur3sIf8BDnnD8Oldpa/aQ/UD0stXQcq7JchHSHHnzEmFgwtB91wemnyQGRkFe6
         /JQqstiNDnNDMX6omMY5My+z1WcWxlRe1kGlY1wm8+U5HeRWXUF7uIIaZwT+Jaek7wRn
         haObU7ofQFIjoqDP1Nx5vw6j0rLqUn1A6btCXGZxk3n7sj84NFcWv8Zo5ySf1WzNxQxw
         CvEYuNaPHb0Hd3tTrTEhBKIvCOFvCuHuQlUh52/8JGWKQnD3JHt8OMjvWP223nOt0UGO
         J3Mp5p3a0QR1ghQPyounmR0SBcja2r9f8hOTDRqmZzmubo7hIqWJom6v2Cu70l++OFKT
         Jc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694137540; x=1694742340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW7+a7tXpeEAZxVIZ+dmlSSTRPuRpH8sTuYBLqEcEUo=;
        b=VONClldosiZI7PRJ3rpdYvVjp+MHAhXM7Er0nd5C6DF5YvOYTD1oxHGFyvOF1db9dY
         xnDy8DhpWxDMUMd9KziZIBRxTiV545NWQ5ryzBDpRJZOqIU/iP+qh/blubG5A9DpKZpQ
         ZFKMJLkAnyoht17O7WUfp5hzTj0ypf289cPaRcZkOnXtbyjzspWUT/qX5UYlL4+r/x4H
         fxNWt6hXdi+lZ7JG5foMP0+QKDUXt4Odv0n19Y13G9d/3s5DkKqSBze31uVyj4WRADwo
         2qmEaQEVyhWDvrEFmZLmqqxFFFt7QxoaD1C+m6hw7ozEsx3zM5awGASsW0Jt3bgV7dq0
         KvtQ==
X-Gm-Message-State: AOJu0YwML9FxyJrDPFW9upzfJIWyOdcm25pDEz/jxWnjVGjrj7ywfOfE
	Aq1B20wFd7ucmvo04Az4DCX/RlnTj9SM/IrrceTq9RkpmbMcFpce
X-Google-Smtp-Source: AGHT+IHCXgYfZOgF5wzfNTwCoXBHB3evIzLE0UW/qqhmYiJna/qOxbKhiS66SjkN7gmJdmUpqNvVnJ59GXpvrL/UI6o=
X-Received: by 2002:a17:906:cc5c:b0:9a6:426f:7dfd with SMTP id
 mm28-20020a170906cc5c00b009a6426f7dfdmr627297ejb.66.1694137539376; Thu, 07
 Sep 2023 18:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZPk41vtxHK/YnFUs@westworld> <ecde5e34c6f3a8182f588b3c1352bf78b69ff206.camel@redhat.com>
 <ZPpUfm/HhFet3ejH@westworld>
In-Reply-To: <ZPpUfm/HhFet3ejH@westworld>
From: Kyle Zeng <zengyhkyle@gmail.com>
Date: Thu, 7 Sep 2023 18:45:03 -0700
Message-ID: <CADW8OBuq2y8txXKXkVJSbKFFs5B3LDX667OAJHn-p0BeOZDy5Q@mail.gmail.com>
Subject: Re: [PATCH] don't assume the existence of skb->dev when trying to
 reset ip_options in ipv4_send_dest_unreach
To: Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003c5fa80604cf220c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000003c5fa80604cf220c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 3:53=E2=80=AFPM Kyle Zeng <zengyhkyle@gmail.com> wro=
te:
>
> On Thu, Sep 07, 2023 at 01:03:52PM +0200, Paolo Abeni wrote:
> > On Wed, 2023-09-06 at 19:43 -0700, Kyle Zeng wrote:
> > > Currently, we assume the skb is associated with a device before calli=
ng __ip_options_compile, which is not always the case if it is re-routed by=
 ipvs.
> > > When skb->dev is NULL, dev_net(skb->dev) will become null-dereference=
.
> > > Since we know that all the options will be set to IPOPT_END, which do=
es
> > > not depend on struct net, we pass NULL to it.
> >
> > It's not clear to me why we can infer the above. Possibly would be more
> > safe to skip entirely the __ip_options_compile() call?!?
> >
> > Please at least clarify the changelog and trim it to 72 chars.
> >
> > Additionally trim the subj to the same len and include the target tree
> > (net) into the subj prefix.
> >
> > Thanks!
> >
> > Paolo
> >
>
> Hi Paolo,
>
> > It's not clear to me why we can infer the above. Possibly would be more
> > safe to skip entirely the __ip_options_compile() call?!?
> Sorry, after you pointed it out, I realized that I misunderstood the
> code. Initially I thought `memset(&opt, 0, sizeof(opt));` would reset all
> the option to OPOPT_END. But after carefully reading the code, it seems
> that it only resets the io_options struct and the `optptr` is still the
> original one.
>
> Do you think it is better to do:
> `struct net =3D skb->dev ? dev_net(skb->dev) : NULL` ?
>
> > Please at least clarify the changelog and trim it to 72 chars.
> >
> > Additionally trim the subj to the same len and include the target tree
> > (net) into the subj prefix.
> Sorry for that. I'm new to the Linux kernel community and I wonder whethe=
r
> I should initiate a different patch or send another patch in this thread
> in this case.
>
> Hi David,
>
> > ipv4_send_dest_unreach is called from ipv4_link_failure which might hav=
e
> > an rtable (dst_entry) which has a device which is in a net namespace.
> > That is better than blindly ignoring the namepsace.
> Following your suggestion, I drafted another patch which is attached to
> this email. I verified that the crash does not happen anymore. Can you
> please advise whether it is a correct patch?
>
> Thanks,
> Kyle Zeng

Sorry for the typo in the previous patch. I fixed it and tested it.
My proof-of-concept code can no longer trigger the crash.
The patch is attached to this email.

Thanks,
Kyle Zeng

--0000000000003c5fa80604cf220c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fix-null-deref-in-ipv4_link_failure.patch"
Content-Disposition: attachment; 
	filename="0001-fix-null-deref-in-ipv4_link_failure.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lm9xq4so0>
X-Attachment-Id: f_lm9xq4so0

RnJvbSBkNGFlODljNjc2MzczYmVjOWU5MjJlYjNhZGUwNDEyODYyNDYxNWUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLeWxlIFplbmcgPHplbmd5aGt5bGVAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDcgU2VwIDIwMjMgMTg6MTk6MDAgLTA3MDAKU3ViamVjdDogW1BBVENIXSBmaXggbnVs
bC1kZXJlZiBpbiBpcHY0X2xpbmtfZmFpbHVyZQoKQ3VycmVudGx5LCB3ZSBhc3N1bWUgdGhlIHNr
YiBpcyBhc3NvY2lhdGVkIHdpdGggYSBkZXZpY2UgYmVmb3JlIGNhbGxpbmcKX19pcF9vcHRpb25z
X2NvbXBpbGUsIHdoaWNoIGlzIG5vdCBhbHdheXMgdGhlIGNhc2UgaWYgaXQgaXMgcmUtcm91dGVk
IGJ5CmlwdnMuCldoZW4gc2tiLT5kZXYgaXMgTlVMTCwgZGV2X25ldChza2ItPmRldikgd2lsbCBi
ZWNvbWUgbnVsbC1kZXJlZmVyZW5jZS4KVGhpcyBwYXRjaCBhZGRzIGEgY2hlY2sgZm9yIHRoZSBl
ZGdlIGNhc2UgYW5kIHN3aXRjaCB0byB1c2UgdGhlIG5ldF9kZXZpY2UKZnJvbSB0aGUgcnRhYmxl
IHdoZW4gc2tiLT5kZXYgaXMgTlVMTC4KClN1Z2dlc3RlZC1ieTogUGFvbG8gQWJlbmk8cGFiZW5p
QHJlZGhhdC5jb20+ClN1Z2dlc3RlZC1ieTogRGF2aWQgQWhlcm4gPGRzYWhlcm5Aa2VybmVsLm9y
Zz4KU2lnbmVkLW9mZi1ieTogS3lsZSBaZW5nIDx6ZW5neWhreWxlQGdtYWlsLmNvbT4KQ2M6IFN0
ZXBoZW4gU3VyeWFwdXRyYSA8c3N1cnlhZXh0ckBnbWFpbC5jb20+Ci0tLQogbmV0L2lwdjQvcm91
dGUuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL25ldC9pcHY0L3JvdXRlLmMgYi9uZXQvaXB2NC9yb3V0ZS5jCmlu
ZGV4IGQ4Yzk5YmRjNjE3Li4xYmUzNGU1ZWVhMSAxMDA2NDQKLS0tIGEvbmV0L2lwdjQvcm91dGUu
YworKysgYi9uZXQvaXB2NC9yb3V0ZS5jCkBAIC0xMjE0LDYgKzEyMTQsNyBAQCBFWFBPUlRfSU5E
SVJFQ1RfQ0FMTEFCTEUoaXB2NF9kc3RfY2hlY2spOwogc3RhdGljIHZvaWQgaXB2NF9zZW5kX2Rl
c3RfdW5yZWFjaChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogewogCXN0cnVjdCBpcF9vcHRpb25zIG9w
dDsKKwlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2OwogCWludCByZXM7CiAKIAkvKiBSZWNvbXBpbGUg
aXAgb3B0aW9ucyBzaW5jZSBJUENCIG1heSBub3QgYmUgdmFsaWQgYW55bW9yZS4KQEAgLTEyMzAs
NyArMTIzMSw4IEBAIHN0YXRpYyB2b2lkIGlwdjRfc2VuZF9kZXN0X3VucmVhY2goc3RydWN0IHNr
X2J1ZmYgKnNrYikKIAkJb3B0Lm9wdGxlbiA9IGlwX2hkcihza2IpLT5paGwgKiA0IC0gc2l6ZW9m
KHN0cnVjdCBpcGhkcik7CiAKIAkJcmN1X3JlYWRfbG9jaygpOwotCQlyZXMgPSBfX2lwX29wdGlv
bnNfY29tcGlsZShkZXZfbmV0KHNrYi0+ZGV2KSwgJm9wdCwgc2tiLCBOVUxMKTsKKwkJZGV2ID0g
c2tiLT5kZXYgPyBza2ItPmRldiA6IHNrYl9ydGFibGUoc2tiKS0+ZHN0LmRldjsKKwkJcmVzID0g
X19pcF9vcHRpb25zX2NvbXBpbGUoZGV2X25ldChkZXYpLCAmb3B0LCBza2IsIE5VTEwpOwogCQly
Y3VfcmVhZF91bmxvY2soKTsKIAogCQlpZiAocmVzKQotLSAKMi4zNC4xCgo=
--0000000000003c5fa80604cf220c--

