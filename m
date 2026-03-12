Return-Path: <netdev+bounces-267209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACKUF68ks2nMSgAAu9opvQ
	(envelope-from <netdev+bounces-267209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B234D27969B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C14E300D698
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1577375F98;
	Thu, 12 Mar 2026 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MehwFv4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072C3382F1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347821; cv=pass; b=l/dT2PicMg7nVv+XHOoauincNzSCnczNDWir52+qo/eMO5NstkhHN4eJsBJjkug4I1JQsGjriLlpZOljcFdfzBYNenM9ZjuV2TM3I8AWPhSn+17+03OWBn3womFK39oOzQHIcHuLoY3GpWyFamTzpA95zsoVRchJ0C5sPLqu1Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347821; c=relaxed/simple;
	bh=OOvBZJ6WX5nPenvrSxxAaujAzbyOQcEkpqZQk83nV94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwbI0dwHNKnA/f62a+8daQV7dJBBXk2CW//h7JHH4z39taLbywgFjM7fTUJNWsjSVa/zFeyPyX4RyXusw1AV//8/9LkX2Z6AKgkpcPqQ/RRHvWeS9H4bSjuY+Fe2Rv8lv5TsIfSQ15oL+X1Ujo4+ci5DIwOqQObmr7ECgwGnOEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MehwFv4R; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so1235436b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773347819; cv=none;
        d=google.com; s=arc-20240605;
        b=O+irXhLdSw3x/FgUIppef78/M61D3HHgGuxygBm/OtAQaMdS9FXHCErgMEoJVtzWZH
         S0GTeMG5Va0uf4zd8hxY2y7jstG89Y57C+q7uO2TaL6PPT+LWWhYvHgWusJG6JbQLA10
         MR3j9QregvHWMVUWP1uKbjwaVibwXt3JirVadZWNKOF9M5mXQTxMa63tR/pEL3Fn/tuB
         JnQghMHu17Dc5qgOroJq+cQbuvKaU0PgBaead8tlKkEmXOsWLTzFrCrIOooeS2nMD5Wf
         rVXSUHPszYjoTdGONA1Tk4IUB0Ynw+qP/iZYB07PRNJgGqnPhVuK/oZd88phcZ2gW4rE
         Rxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=WD2U6SzishxvWRX7bRUVdYiJ9QLKZuCIeceOiHKCTjkHu06HU25EzkH5a8uftPSLsm
         Nft03mBS9Z42itCHJzAAbjckDs/1ZfWZy7M3oSRc14NXhinXQdZByxaOdmFZqIXyx+U8
         kOaIxPJ90C7VijZancGx+AqKdtdyTFjU/sde3aySsOUjGpDa3QH/1WAQzubZqq20WbLL
         Dh2rhRGp2pCkCFmQBHPLh5SyyQx8DczvZv7rph4TztAvud05ChthM7fezaKEgssooknM
         lkUoejKxVmX3WapdN8cWQohd30f4h8KQms79/UTLR/iMlRv5et3NZqWQmdQW0YpuXaMD
         vbag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773347819; x=1773952619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        b=MehwFv4RidVHs10UnIxGQZjNQnUSX6Yb0SJ0w4+ilb4JZ+/hrq87cw8M9U5IiU67CA
         CUY3++bnzr3qv3oUB53BXT604Rgb8DFcW7lFKohc24lFcfWDosdU6+mYSABzdPhSGqwU
         bTX2vDS5wgFtDOiegOZzwY3QarSieNaye17Vdu6l4/0E4+E3IAefSTi8wAr35Z2ZCZ/D
         2w55U92CbROS6dWIMR3ySwvdnO3yanT61HixevPrmx/NKndU7ybI12UpcltdqOdNKARW
         5OXZqn2JsIMnRin8nhnpPME84GFyQZCYp9kaB45lwm8NQ2f0YTHmv80nJWVBuhE22A+k
         3+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347819; x=1773952619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        b=UUQJQe9IBwCQhhAqPlckfz24cyvBdTr1wtnNLoYvchlldBTiZSqnMhhwLwtcXAFWyf
         R4LLt5b1rqcQFYO+q34p/H04P3fjT/JxCpx9Ina3NVzhFVwS/FibwmSY0rr4Ei+2hHWj
         6Y0mzYrVxwBlVG6TENAwPVX72a/ouyqP6zCbopq76s90stLxdgwc7wvJlwSkvm+lDAqC
         0xnz7YUG71ti9FKGRbKpyhaXrVX45RLJgwHPafd3GzDvfRMGSV1peJ42fT1Ov6QPRLzo
         bFxxkgg4pA5TzJx4Z8Q3jMSNCGCFyrfR3GXaLe/ZkMJxBHAeXUogoGm80AYf8kqxZKbK
         Hyaw==
X-Gm-Message-State: AOJu0YzMP+nfGz8Nx2OTmRY7PQB4IVj8JROY989vUMsrhRlm6lqeWYnZ
	FpDBxu7x3kW95YFQtp4wgsGgczodmvQhDgJOlQBZ6wKuL9+7Xq5W5LfJJqy/eBR+sk2CUmtw1V6
	AEIbk4cQ1cspKKu8SVPrL2xYluudHsGoLv0Uz0Jg9
X-Gm-Gg: ATEYQzzUBb8hOBtuAM4O7b/qvBr1lk6Nu5wYV2F1G9t1g1bnqoaCLi6kFSpk/MiY1Z5
	yJRvzGMnrn+RCdB1+yYk591yiNgfGemTRGE0Rgujr5nhzSIDyjoUu+uWKtBbIDMdx/2r8j47+ec
	fezeLlJMLSu1V/i1/IFoJkeD+K+ROeB7BIl8BddHHfWYMc3tKBZJf5o1u+HjoWAeNsKWYet+Hk1
	s0iq5CjpPgIDvSk0TCQ6HgKeNpweMOj+xfbYRf775oev64tBLyTuUuctpbalW+I6guQgLfw2Jk+
	9HrizXpeMJGV4+U=
X-Received: by 2002:a05:6a00:4009:b0:82a:108b:80e3 with SMTP id
 d2e1a72fcca58-82a198d7123mr646639b3a.38.1773347819667; Thu, 12 Mar 2026
 13:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com> <20260311175249.54abe1b6@kernel.org>
In-Reply-To: <20260311175249.54abe1b6@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Mar 2026 16:36:48 -0400
X-Gm-Features: AaiRm52Ay9btUcm8fjz-2e-6mv1j1MJyR1DhU8dho1U74A4Ifx5laPKTFvbVSqo
Message-ID: <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="000000000000dae71f064cd9b6e6"
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-267209-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B234D27969B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000dae71f064cd9b6e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 12:22:41 -0400 Jamal Hadi Salim wrote:
> > > On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:
> > > > Note: We tried a couple of different approaches that had smaller co=
de
> > > > footprint but were a bit fugly. The first approach was to use recur=
sion
> > > > on the qdisc hash table to iterate the descendants of the qdisc; ho=
wever,
> > > > the challenge here is if the graph depth is "high" - we may overflo=
w the
> > > > stack. The second approach was to use a breadth first search to ach=
ieve
> > > > the same goal; the challenge here was it was a quadratic algorithm.
> > >
> > > Lots of complexity when realistically only ingress/clsact support
> > > the unlocked operations. Can we not just take rtnl before the
> > > references and not bother all the real qdiscs with this @#%$ ?
> > > (diff just to illustrate the point not even compiled)
> >
> > Two of the several (I think 4!) patches we had took a similar path. I
> > am trying to remember at least one variant was bad for performance and
> > the other was unstable. Let's see if we can revive it and take a
> > closer look. BTW - none were pretty, it was maybe half the lines of
> > code but touched many things.
>
> FWIW / of course, we have to apply similar change to all(?) callers of
> __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty long.
> And it's not going to help the already spaghetti-looking locking. But
> even if it's more LoC I quite like the idea of containing the poopy
> code to where problems originate which is the lockless filter handling.
> Fingers crossed..

Something like attached.
Unfortunately after running it for a few hours it reproduced.
The action code path (entered by virtue of filter code path execution)
releases the rtnl when attempting to load an action module. A parallel
qdisc operation waiting for the lock then grabs it and we hit the same
issue...

So now we have to be more invasive and start coordinating the action
code etc, which is not appealing. Thoughts?

cheers,
jamal

--000000000000dae71f064cd9b6e6
Content-Type: text/x-patch; charset="US-ASCII"; name="acquire_rtnl_before_qdisc_find.patch"
Content-Disposition: attachment; 
	filename="acquire_rtnl_before_qdisc_find.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mmnx66v11>
X-Attachment-Id: f_mmnx66v11

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9jbHNfYXBpLmMgYi9uZXQvc2NoZWQvY2xzX2FwaS5jCmlu
ZGV4IDQ4MjljMjc0NDZlMy4uZWU1ZjZmZmY1N2NiIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvY2xz
X2FwaS5jCisrKyBiL25ldC9zY2hlZC9jbHNfYXBpLmMKQEAgLTM0OSw3ICszNDksNyBAQCBzdGF0
aWMgYm9vbCB0Y2ZfcHJvdG9fY2hlY2tfa2luZChzdHJ1Y3QgbmxhdHRyICpraW5kLCBjaGFyICpu
YW1lKQogCXJldHVybiBmYWxzZTsKIH0KIAotc3RhdGljIGJvb2wgdGNmX3Byb3RvX2lzX3VubG9j
a2VkKGNvbnN0IGNoYXIgKmtpbmQpCitzdGF0aWMgYm9vbCB0Y2ZfcHJvdG9faXNfdW5sb2NrZWQo
Y29uc3QgY2hhciAqa2luZCwgYm9vbCBydG5sX2hlbGQpCiB7CiAJY29uc3Qgc3RydWN0IHRjZl9w
cm90b19vcHMgKm9wczsKIAlib29sIHJldDsKQEAgLTM1Nyw3ICszNTcsNyBAQCBzdGF0aWMgYm9v
bCB0Y2ZfcHJvdG9faXNfdW5sb2NrZWQoY29uc3QgY2hhciAqa2luZCkKIAlpZiAoc3RybGVuKGtp
bmQpID09IDApCiAJCXJldHVybiBmYWxzZTsKIAotCW9wcyA9IHRjZl9wcm90b19sb29rdXBfb3Bz
KGtpbmQsIGZhbHNlLCBOVUxMKTsKKwlvcHMgPSB0Y2ZfcHJvdG9fbG9va3VwX29wcyhraW5kLCBy
dG5sX2hlbGQsIE5VTEwpOwogCS8qIE9uIGVycm9yIHJldHVybiBmYWxzZSB0byB0YWtlIHJ0bmwg
bG9jay4gUHJvdG8gbG9va3VwL2NyZWF0ZQogCSAqIGZ1bmN0aW9ucyB3aWxsIHBlcmZvcm0gbG9v
a3VwIGFnYWluIGFuZCBwcm9wZXJseSBoYW5kbGUgZXJyb3JzLgogCSAqLwpAQCAtMjIyOCw2ICsy
MjI4LDEyIEBAIHN0YXRpYyBib29sIGlzX3FkaXNjX2luZ3Jlc3MoX191MzIgY2xhc3NpZCkKIAly
ZXR1cm4gKFRDX0hfTUlOKGNsYXNzaWQpID09IFRDX0hfTUlOKFRDX0hfTUlOX0lOR1JFU1MpKTsK
IH0KIAorc3RhdGljIGJvb2wgcGFyZW50X2lzX2luZ3Jlc3Nfb3JfZWdyZXNzKF9fdTMyIHBhcmVu
dGlkKQoreworCXJldHVybiAoVENfSF9NQUtFKFRDX0hfQ0xTQUNULCBUQ19IX01JTl9JTkdSRVNT
KSA9PSBwYXJlbnRpZCkgfHwKKwkJKFRDX0hfTUFLRShUQ19IX0NMU0FDVCwgVENfSF9NSU5fRUdS
RVNTKSA9PSBwYXJlbnRpZCk7Cit9CisKIHN0YXRpYyBib29sIGlzX2luZ3Jlc3Nfb3JfY2xzYWN0
KHN0cnVjdCB0Y2ZfYmxvY2sgKmJsb2NrLCBzdHJ1Y3QgUWRpc2MgKnEpCiB7CiAJcmV0dXJuIHRj
Zl9ibG9ja19zaGFyZWQoYmxvY2spIHx8IChxICYmICEhKHEtPmZsYWdzICYgVENRX0ZfSU5HUkVT
UykpOwpAQCAtMjI1NSw2ICsyMjYxLDcgQEAgc3RhdGljIGludCB0Y19uZXdfdGZpbHRlcihzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJaW50IGVycjsKIAlpbnQgdHBf
Y3JlYXRlZDsKIAlib29sIHJ0bmxfaGVsZCA9IGZhbHNlOworCWJvb2wgcHJvdG9faXNfdW5sb2Nr
ZWQ7CiAJdTMyIGZsYWdzOwogCiByZXBsYXk6CkBAIC0yMjg2LDI5ICsyMjkzLDM4IEBAIHN0YXRp
YyBpbnQgdGNfbmV3X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRy
ICpuLAogCQkJcHJpb19hbGxvY2F0ZSA9IHRydWU7CiAJCX0gZWxzZSB7CiAJCQlOTF9TRVRfRVJS
X01TRyhleHRhY2ssICJJbnZhbGlkIGZpbHRlciBjb21tYW5kIHdpdGggcHJpb3JpdHkgb2YgemVy
byIpOworCQkJaWYgKHJ0bmxfaGVsZCkKKwkJCQlydG5sX3VubG9jaygpOwogCQkJcmV0dXJuIC1F
Tk9FTlQ7CiAJCX0KIAl9CiAKLQkvKiBGaW5kIGhlYWQgb2YgZmlsdGVyIGNoYWluLiAqLwotCi0J
ZXJyID0gX190Y2ZfcWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwg
ZmFsc2UsIGV4dGFjayk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKLQogCWlmICh0Y2ZfcHJv
dG9fY2hlY2tfa2luZCh0Y2FbVENBX0tJTkRdLCBuYW1lKSkgewogCQlOTF9TRVRfRVJSX01TRyhl
eHRhY2ssICJTcGVjaWZpZWQgVEMgZmlsdGVyIG5hbWUgdG9vIGxvbmciKTsKLQkJZXJyID0gLUVJ
TlZBTDsKLQkJZ290byBlcnJvdXQ7CisJCWlmIChydG5sX2hlbGQpCisJCQlydG5sX3VubG9jaygp
OworCQlyZXR1cm4gLUVJTlZBTDsKIAl9CisJcHJvdG9faXNfdW5sb2NrZWQgPSB0Y2ZfcHJvdG9f
aXNfdW5sb2NrZWQobmFtZSwgcnRubF9oZWxkKTsKIAotCS8qIFRha2UgcnRubCBtdXRleCBpZiBy
dG5sX2hlbGQgd2FzIHNldCB0byB0cnVlIG9uIHByZXZpb3VzIGl0ZXJhdGlvbiwKLQkgKiBibG9j
ayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90IHVubG9ja2VkLCBjbGFz
c2lmaWVyCi0JICogdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lmaWVyIGlzIG5vdCB1bmxv
Y2tlZC4KLQkgKi8KLQlpZiAocnRubF9oZWxkIHx8Ci0JICAgIChxICYmICEocS0+b3BzLT5jbF9v
cHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRfVU5MT0NLRUQpKSB8fAotCSAgICAhdGNm
X3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYgKCFydG5sX2hlbGQgJiYgIXBhcmVudF9p
c19pbmdyZXNzX29yX2VncmVzcyhwYXJlbnQpKSB7CisJCXJ0bmxfaGVsZCA9IHRydWU7CisJCXJ0
bmxfbG9jaygpOworCX0KKworCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCisJZXJy
ID0gX190Y2ZfcWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwgcnRu
bF9oZWxkLAorCQkJICAgICAgIGV4dGFjayk7CisJaWYgKGVycikgeworCQlpZiAocnRubF9oZWxk
KQorCQkJcnRubF91bmxvY2soKTsKKwkJcmV0dXJuIGVycjsKKwl9CisKKyAgICAgICAvKiBUYWtl
IHJ0bmwgbXV0ZXggaWYgY2xhc3NpZmllciB0eXBlIGlzIG5vdCBzcGVjaWZpZWQsIG9yIGNsYXNz
aWZpZXIKKwkqIGlzIG5vdCB1bmxvY2tlZC4KKwkqLworCWlmICghcnRubF9oZWxkICYmICFwcm90
b19pc191bmxvY2tlZCkgewogCQlydG5sX2hlbGQgPSB0cnVlOwogCQlydG5sX2xvY2soKTsKIAl9
CkBAIC0yNDUxLDE3ICsyNDY3LDIwIEBAIHN0YXRpYyBpbnQgdGNfbmV3X3RmaWx0ZXIoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCX0KIAl0Y2ZfYmxvY2tfcmVsZWFz
ZShxLCBibG9jaywgcnRubF9oZWxkKTsKIAotCWlmIChydG5sX2hlbGQpCi0JCXJ0bmxfdW5sb2Nr
KCk7Ci0KIAlpZiAoZXJyID09IC1FQUdBSU4pIHsKIAkJLyogVGFrZSBydG5sIGxvY2sgaW4gY2Fz
ZSBFQUdBSU4gaXMgY2F1c2VkIGJ5IGNvbmN1cnJlbnQgZmx1c2gKIAkJICogb2YgdGFyZ2V0IGNo
YWluLgogCQkgKi8KKwkJaWYgKCFydG5sX2hlbGQpCisJCQlydG5sX2xvY2soKTsKIAkJcnRubF9o
ZWxkID0gdHJ1ZTsKIAkJLyogUmVwbGF5IHRoZSByZXF1ZXN0LiAqLwogCQlnb3RvIHJlcGxheTsK
IAl9CisKKwlpZiAocnRubF9oZWxkKQorCQlydG5sX3VubG9jaygpOworCiAJcmV0dXJuIGVycjsK
IAogZXJyb3V0X2xvY2tlZDoKQEAgLTI0ODgsNiArMjUwNyw3IEBAIHN0YXRpYyBpbnQgdGNfZGVs
X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCXVuc2ln
bmVkIGxvbmcgY2wgPSAwOwogCXZvaWQgKmZoID0gTlVMTDsKIAlpbnQgZXJyOworCWJvb2wgcHJv
dG9faXNfdW5sb2NrZWQgPSB0cnVlOwogCWJvb2wgcnRubF9oZWxkID0gZmFsc2U7CiAKIAllcnIg
PSBubG1zZ19wYXJzZV9kZXByZWNhdGVkKG4sIHNpemVvZigqdCksIHRjYSwgVENBX01BWCwKQEAg
LTI1MDUsMjQgKzI1MjUsMjkgQEAgc3RhdGljIGludCB0Y19kZWxfdGZpbHRlcihzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVybiAtRU5PRU5UOwogCX0KIAot
CS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQllcnIgPSBfX3RjZl9xZGlzY19m
aW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBmYWxzZSwgZXh0YWNrKTsKLQlp
ZiAoZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90b19jaGVja19raW5kKHRjYVtU
Q0FfS0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIlNwZWNpZmllZCBU
QyBmaWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlOVkFMOwotCQlnb3RvIGVycm91
dDsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCXByb3RvX2lzX3VubG9ja2VkID0gdGNmX3Byb3Rv
X2lzX3VubG9ja2VkKG5hbWUsIHJ0bmxfaGVsZCk7CisKKwlpZiAoIXBhcmVudF9pc19pbmdyZXNz
X29yX2VncmVzcyhwYXJlbnQpKSB7CisJCXJ0bmxfaGVsZCA9IHRydWU7CisJCXJ0bmxfbG9jaygp
OworCX0KKworCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCisJZXJyID0gX190Y2Zf
cWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwgcnRubF9oZWxkLAor
CQkJICAgICAgIGV4dGFjayk7CisJaWYgKGVycikgeworCQlpZiAocnRubF9oZWxkKQorCQkJcnRu
bF91bmxvY2soKTsKKwkJcmV0dXJuIGVycjsKIAl9Ci0JLyogVGFrZSBydG5sIG11dGV4IGlmIGZs
dXNoaW5nIHdob2xlIGNoYWluLCBibG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjCi0JICogZm91bmQp
LCBxZGlzYyBpcyBub3QgdW5sb2NrZWQsIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVk
LAotCSAqIGNsYXNzaWZpZXIgaXMgbm90IHVubG9ja2VkLgorCS8qIFRha2UgcnRubCBtdXRleCBp
ZiBmbHVzaGluZyB3aG9sZSBjaGFpbiwgY2xhc3NpZmllciB0eXBlIGlzIG5vdAorCSAqIHNwZWNp
ZmllZCwgY2xhc3NpZmllciBpcyBub3QgdW5sb2NrZWQuCiAJICovCi0JaWYgKCFwcmlvIHx8Ci0J
ICAgIChxICYmICEocS0+b3BzLT5jbF9vcHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRf
VU5MT0NLRUQpKSB8fAotCSAgICAhdGNmX3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYg
KCFydG5sX2hlbGQgJiYgKCFwcmlvIHx8ICFwcm90b19pc191bmxvY2tlZCkpIHsKIAkJcnRubF9o
ZWxkID0gdHJ1ZTsKIAkJcnRubF9sb2NrKCk7CiAJfQpAQCAtMjY0OCw2ICsyNjczLDcgQEAgc3Rh
dGljIGludCB0Y19nZXRfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2do
ZHIgKm4sCiAJdm9pZCAqZmggPSBOVUxMOwogCWludCBlcnI7CiAJYm9vbCBydG5sX2hlbGQgPSBm
YWxzZTsKKwlib29sIHByb3RvX2lzX3VubG9ja2VkOwogCiAJZXJyID0gbmxtc2dfcGFyc2VfZGVw
cmVjYXRlZChuLCBzaXplb2YoKnQpLCB0Y2EsIFRDQV9NQVgsCiAJCQkJICAgICBydG1fdGNhX3Bv
bGljeSwgZXh0YWNrKTsKQEAgLTI2NjQsMjMgKzI2OTAsMjkgQEAgc3RhdGljIGludCB0Y19nZXRf
dGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVy
biAtRU5PRU5UOwogCX0KIAotCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQll
cnIgPSBfX3RjZl9xZGlzY19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBm
YWxzZSwgZXh0YWNrKTsKLQlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90
b19jaGVja19raW5kKHRjYVtUQ0FfS0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4
dGFjaywgIlNwZWNpZmllZCBUQyBmaWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlO
VkFMOwotCQlnb3RvIGVycm91dDsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCS8qIFRha2UgcnRu
bCBtdXRleCBpZiBibG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90
Ci0JICogdW5sb2NrZWQsIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lm
aWVyIGlzIG5vdAotCSAqIHVubG9ja2VkLgotCSAqLwotCWlmICgocSAmJiAhKHEtPm9wcy0+Y2xf
b3BzLT5mbGFncyAmIFFESVNDX0NMQVNTX09QU19ET0lUX1VOTE9DS0VEKSkgfHwKLQkgICAgIXRj
Zl9wcm90b19pc191bmxvY2tlZChuYW1lKSkgeworCXByb3RvX2lzX3VubG9ja2VkID0gdGNmX3By
b3RvX2lzX3VubG9ja2VkKG5hbWUsIGZhbHNlKTsKKworCWlmICghcGFyZW50X2lzX2luZ3Jlc3Nf
b3JfZWdyZXNzKHBhcmVudCkpIHsKKwkJcnRubF9oZWxkID0gdHJ1ZTsKKwkJcnRubF9sb2NrKCk7
CisJfQorCisJLyogRmluZCBoZWFkIG9mIGZpbHRlciBjaGFpbi4gKi8KKwllcnIgPSBfX3RjZl9x
ZGlzY19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBydG5sX2hlbGQsCisJ
CQkgICAgICAgZXh0YWNrKTsKKwlpZiAoZXJyKSB7CisJCWlmIChydG5sX2hlbGQpCisJCQlydG5s
X3VubG9jaygpOworCQlyZXR1cm4gZXJyOworCX0KKyAgICAgICAvKiBUYWtlIHJ0bmwgbXV0ZXgg
aWYgY2xhc3NpZmllciB0eXBlIGlzIG5vdCBzcGVjaWZpZWQsIG9yIGNsYXNzaWZpZXIgaXMKKwkq
IG5vdCB1bmxvY2tlZC4KKwkqLworCWlmICghcnRubF9oZWxkICYmICFwcm90b19pc191bmxvY2tl
ZCkgewogCQlydG5sX2hlbGQgPSB0cnVlOwogCQlydG5sX2xvY2soKTsKIAl9Cg==
--000000000000dae71f064cd9b6e6--

