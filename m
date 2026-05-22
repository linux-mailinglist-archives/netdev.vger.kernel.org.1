Return-Path: <netdev+bounces-290851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G8CBrpkEGoKXAYAu9opvQ
	(envelope-from <netdev+bounces-290851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 740985B5F3D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED051319E424
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8140802E;
	Fri, 22 May 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jde46WnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F76407CFF
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457762; cv=pass; b=pI/YCZDpUj3i0gVUSAzfR90CpMET+S9m7gcj+KagTJG3/5kZD/J2GpEz9W95vrc6tB+r5rHAidBK0cqEyCZAKTsnjqYPF/AokcnK8DWYLxitR4beIXOMfl4kDvohnUB+Met4PYYKfG1AzoA6M2V3Ek4KqcLsl/ZmqrmAVrhG8KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457762; c=relaxed/simple;
	bh=wQ0K9SA155nOH71DZHivurStrJvGlHxKN7dbejwbvmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afhraZIQRrI604cyldnN5fIbaNWzhgnvb5V8go4a5XVlsQGrKi75tSPubRa1oSAsWDlDDBvMAuZohxjvWiEzn+aad2m1tsqtBJpedRFYdsM74ycT+UHrU36/oF4ZqK+4OeomNBeCJZXhxckh5PjsdRJ4FMu+K0AgJAK0icTnRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jde46WnI; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso8573475e87.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779457759; cv=none;
        d=google.com; s=arc-20240605;
        b=MMzyZCxprRWylwqI5dkQJVlxyCmBcRanMaSPD9qxFQKUd2puyjM0PSID6li9Ey5+55
         Bzl6elV1F2LurTa05TKk2ykv91c+gqVKxUEcHZRy8zXsdVZYuw7mK4uKHbCOWaZNHNBt
         b/gwa7yRP6UcZteGyuARr+LtGRl2wp5rP0jj5DTFJOQo6WAzN99TQ6EShf/h7jGSAKfY
         rv8b2NjwtGf306eUMxFtNpZ3mY5TiUn9R3XmfjGFd3WnVFJM3fqnNr0P0/AM/DOhmTqu
         P7NwL0+ReD/R77sfAEvXLD871rF6HT5ML60sx/cEOuDRM2663Ua3J+4j+jusnfcXTCno
         wD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ctsTM6QWKLFPgqbheJPQ9gX46bQRRFCsW4gMR6IrenY=;
        fh=dLvrTX8tF+IHY5QawqNIwUzzKGc/0Yaj+sSMg8BY+/A=;
        b=LMabAbx2sFCQ2HU/tGEYiifwsNDVf0ibIRCXUw39db+PHqEToSJE6MHQLa+axPnIry
         Dg7xnL9pQtss2PW2BUEVFkTsa2GHPb99900T0XxuF7nkrp6bgH0fmW/6x8dE2TIEpgMA
         N0vMTU5KPBMY0Q2ABVg/qk9CZiCa/Wuty6JbLub8JIDjqCaSziKNotkZqJTqu7STEHmD
         WDY9E6l2UVJrWXen/x7An5TDKBtocNyucK5jCYnTaBwB41hrSsdSSYy2FyPvYH9mdTJc
         MCygiLapsavAX698XledBquXSKH8dp3d/QCppzUz9vQJhoPLB9wbKQEOggQZHbiKtbjk
         rQRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779457759; x=1780062559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctsTM6QWKLFPgqbheJPQ9gX46bQRRFCsW4gMR6IrenY=;
        b=Jde46WnIsU+McekIChEnfisvGp6fWmlP7MjvuTI2IK6bWJ/wy86EGecbJItfzuDQ6D
         t22g/yyRjFv8CnNv3pEGC4MitemrOU4tedgaX6L7uCvqsqRsv9sw5/Hs/8flMPZL0ziY
         BbH8VdfZl6OjZVQgltD31Rc0ls1Jljf8N4EU7DUu3kKUsrctrXyCxyfnhFEdDuj25iXG
         wUvhay+5OucLPqB5+a06+jo8V7kfkVODNp3shhLb+1qwQFJOviV5H2H9KBKgPxAF8OHd
         NhaxkMhOtChrh/O6fG4dsYmCeJgOw1aCLe27uQouXRMCE2h4kcdkXdLsBh/qlhfzpSv6
         0+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457759; x=1780062559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctsTM6QWKLFPgqbheJPQ9gX46bQRRFCsW4gMR6IrenY=;
        b=NW+wL3BbHtXXIxnPiNxOLyjH1NbzPpIXTQ35C1j2jI0c/LHVs3jIN9op2Twwr/BYFB
         HGI3VSBgoOqRbrrvBLaAjvsTOza4gDlU7N14ZeiilV648nvbH1LvRdziAuiRh6u6Fnax
         JswVBv03N+jeayYf/jt/OpcYO6wd6fCwH6E1JIiRqzDRqO72G9gFAmcKEQQvkUVf1pUm
         d+7TTe0vEfqfZB4u7Y4r4QU8onSRU/GKkyDSQajq5TY3j2zmN+mxm+JF74jaCJb3rwju
         mRRscmJUwVf/OGUEZ3tuLfdc3hlIFHpEn7sKivlkwDHOya2Xc7S5IdLorURTnmrcTRdf
         W9Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+FccFiUt0YcIThhH0UjASA1PM4AeTOqP5l7KQFINb94dYbM4mBL1cx8Yf377Q8r1njE9+X258=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzjLwkpYjnCBhhabEgsFA/afFZDExA5Pcu1pn10Q5abUndk4S
	H1o6T8w0S4fSKZVrtBkf0IqagZ1zs7ok23mYJ7oWy0pBPlTwCB0ReznI+Lm3tojB041/CwJd+Ic
	gt9nuY6c8rghP5+OekjetJ6mTY1mi+EI=
X-Gm-Gg: Acq92OFRK2WbQkOoe+pJZxKJt6hXRN/WThc/PNZ6Qpu77cgoL0q+xJpTpMh6G+436Bk
	JeY/ymATqTCcn3d80pjkRceQvEY9pQp6JndmnCuJck9ucvMRFXNKbZLCcGYoQoh2xCK8BXA2sD4
	d/F/3QVNNq7mXy9F062KOE73F/iXgx0X+BBVNpQSKsC8WYVocn3u85oNOkQ3wyBYiHxkMrJNQts
	HK4JkodkZGBDVtRR1xqpoLpKWBpWWHXhILdqtHb4xxO68ct4NHsGctxIvogek0gak2Z5kRtoVbg
	5Fd+pkwluNhS/ZmcZ/UBCzElDsrOFjKGP5HJg1UAdNgoB7dt7g==
X-Received: by 2002:a05:6512:2304:b0:5a4:13da:fe8 with SMTP id
 2adb3069b0e04-5aa323a4587mr1270834e87.38.1779457758299; Fri, 22 May 2026
 06:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer> <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer> <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
In-Reply-To: <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 May 2026 21:48:39 +0800
X-Gm-Features: AVHnY4L9hHpYEYyljdZekhZ7H3zAqWZ9AMqTcVEAR40CaHxL1HehH1wuQD-KKdw
Message-ID: <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: multipart/mixed; boundary="00000000000093abf30652684be0"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290851-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,tencent.com:email]
X-Rspamd-Queue-Id: 740985B5F3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000093abf30652684be0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, May 21, 2026 at 10:24=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > The series is the product of previous review from sashiko[1].
> > > > > > >
> > > > > > > 1) META
> > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > >
> > > > > > > 2) PUBLISH of CQ
> > > > > > > patch 2: make sure xsk_addr->addrs[] can be published to cq w=
hen
> > > > > > >          overflow occurs.
> > > > > > > patch 3: keep cleaning up the continuation descs (more than 1=
7) and
> > > > > > >          publish its address when overflow occurs.
> > > > > > > patch 4: like patch 3, but only handles the invalid descs cas=
es.
> > > > > > >
> > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerne=
ljasonxing@gmail.com/
> > > > > > >
> > > > > > > ---
> > > > > > > V4
> > > > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kern=
eljasonxing@gmail.com/
> > > > > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > >
> > > > > > > V3
> > > > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kern=
eljasonxing@gmail.com/
> > > > > > > 1. avoid breaking previous usage of sendto, and siliently han=
dle
> > > > > > > overflow case (Stan, sashiko)
> > > > > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > > > > 3. adjust the selftest to make sure it passes in either virut=
al or
> > > > > > > physical machines, which includes add usleep to support physi=
cal machine.
> > > > > > >
> > > > > > > V2
> > > > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kern=
eljasonxing@gmail.com/
> > > > > > > 1. adjust selftests (Jakub)
> > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > >
> > > > > > FWIW I still get test failures (yes with patch 5 applied). PTAL=
.
> > > > >
> > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > >
> > > > > I noticed there are some flaky tests which have nothing to do wit=
h the
> > > > > series. Can you confirm that it's not caused because of the serie=
s?
> > > >
> > > > That explains the different results as i am using i40e/ice which ha=
ve
> > > > multi-buffer support whereas ixgbe does not even support mbuf at XD=
P.
> > > > Broken tests are from mbuf cases.
> > >
> > > That's weird. I never expected the failed tests to be about multi-buf=
fer.
> > >
> > > Are they the same as the output you attached last time? Or something
> > > new? Could you please share it so that I can investigate the root
> > > cause?
> >
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > ---------------------------------------
> > not ok 94 FAIL: ZC TOO_MANY_FRAGS
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
> >
> > # 4 skipped test(s) detected. Consider enabling relevant config options=
 to improve coverage.
> > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > 1..108
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > ---------------------------------------
> > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0=
:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 =
# 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > ---------------------------------------
> > not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> >
> > # 4 skipped test(s) detected. Consider enabling relevant config options=
 to improve coverage.
> > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
> >
> > Summary:
> > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
>
> Sorry, Maciej. I managed to get one server with i40e nic but still
> couldn't reproduce it. Can you try the attachment (that is the
> replacement for v4-0005) instead? I removed those nasty CONT test
> cases...

Ah, I think I eventually figured out a solution. Maciej, could you
please test the 2nd patch instead?

This patch reworks the CONTD test cases. Cross finger.

Thanks,
Jason

>
> Really I don't think I have much time to spend on these tests which
> makes me feel extremely annoyed... It's not easy to analyze the code
> without a reproducer. The good news is that now I highly suspect that
> this kind of CONT test cases pollute the whole cq which affects other
> tests. Before I give up on the 0003/0004 patches, I'd like to hear
> some advice from you. Thank you.
>
> My original intention was to push batch xmit forward but at that time
> sashiko pointed out some unrelated bugs accidentally.
>
> Thanks,
> Jason
>
> >
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Jason Xing (5):
> > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_=
metadata()
> > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buf=
fer Tx
> > > > > > >   xsk: drain continuation descs after overflow in xsk_build_s=
kb()
> > > > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > > > >     __xsk_generic_xmit()
> > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > >
> > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > >  net/xdp/xsk.c                                 | 44 +++++++++=
++++----
> > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++=
++--------
> > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.43.7
> > > > > > >

--00000000000093abf30652684be0
Content-Type: application/octet-stream; 
	name="0001-selftests-xsk-rework-CONTD-testcases.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-xsk-rework-CONTD-testcases.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpgz5o6v0>
X-Attachment-Id: f_mpgz5o6v0

RnJvbSA2ZGI4ZDljMWZhZTRiNzk4MDUwYzk1MDI0OTVkOTU3NjI3YTAzYzQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBYaW5nIDxrZXJuZWx4aW5nQHRlbmNlbnQuY29tPgpE
YXRlOiBGcmksIDIyIE1heSAyMDI2IDIyOjAwOjAwICswMzAwClN1YmplY3Q6IFtQQVRDSF0gc2Vs
ZnRlc3RzL3hzazogcmV3b3JrIENPTlREIHRlc3RjYXNlcwoKVGhlIGV4aXN0aW5nICpJTlZfREVT
Q19NVUxUSV9CVUZGIGFuZCBUT09fTUFOWV9GUkFHUyB0ZXN0cyBlbWJlZAptaWQtY2hhaW4gaW52
YWxpZCBkZXNjcmlwdG9ycywgd2hpY2ggY29sbGlkZSB3aXRoIGJvdGggdGhlIG5ldyBDUQphY2Nv
dW50aW5nLiBUaGUgcHJldmlvdXMgYXJjaCB3YXMgbm90IGRlc2lnbmVkIGZvciB0aGlzIGJlaGF2
aW9yOgoxKSBpdCdzIHVubmVlZGVkIHRvIHRlc3QgdGhlIHNlcmllcyBpbiB6YyBtb2RlLgoyKSBv
dXRzdGFuZGluZ190eCBkb2Vzbid0IHdvcmsgd2l0aG91dCBuZXdseSBhZGRlZCBuYl9leHRyYV9j
cS4KSW4gYSB3b3JkLCBpdCdzIHVubGlrZWx5IHRvIHN1cHBvcnQgdGhlIENPTlREIHRlc3QgaW4g
Ym90aCBub24temMKYW5kIHpjIGluIHRoZSB1bmlmaWVkIGZ1bmN0aW9ucy4KClNvIHRoaXMgcGF0
Y2ggZG9lcyB0d28gdGhpbmdzOiBzdHJpcCB0aGUgcHJldmlvdXMgQ09OVEQgdGVzdHMsCmFuZCB0
aGVuIGdyb3VwIHRoZW0gdG9nZXRoZXIgaW50byB0d28gdGVzdGNhc2VzLgoKQWRkIHR3byBTS0Iv
RFJWLW9ubHkgdGVzdHMgdG8gY292ZXIgdGhlIHNlcmllcyBpbiBpc29sYXRpb246CkRSQUlOX0NP
TlQgYW5kIEVPVkVSRkxPV19EUkFJTl9DT05ULiBCb3RoIGRlY2xhcmUgdGhlIGtlcm5lbC1pbnRl
cm5hbApleHRyYSBDUSBlbnRyaWVzIHZpYSBuYl9leHRyYV9jcSBzbyBfX3NlbmRfcGt0cygpIGtl
ZXBzIHN0cmljdAphY2NvdW50aW5nLCBhbmQgYm90aCBhcmUgc2tpcHBlZCB1bmRlciBaQyBzaW5j
ZSBkcmFpbl9jb250IG9ubHkgZXhpc3RzCm9uIHRoZSBTS0IvRFJWIHBhdGguCgpTaWduZWQtb2Zm
LWJ5OiBKYXNvbiBYaW5nIDxrZXJuZWx4aW5nQHRlbmNlbnQuY29tPgotLS0KIC4uLi9zZWxmdGVz
dHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2suYyAgICAgICB8IDEzNSArKysrKysrKysrKysrKy0t
LS0KIC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2suaCAgICAgICB8ICAgNSAr
CiAyIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90ZXN0X3hz
ay5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2suYwpp
bmRleCA3OTUwYzUwNGVkMjguLjFjMTcxMjNmOTkzYyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2suYworKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90ZXN0X3hzay5jCkBAIC0xMjQ3LDcgKzEyNDcsOCBA
QCBzdGF0aWMgaW50IF9fc2VuZF9wa3RzKHN0cnVjdCBpZm9iamVjdCAqaWZvYmplY3QsIHN0cnVj
dCB4c2tfc29ja2V0X2luZm8gKnhzaywgYgogCXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZwYWNpbmdf
bXV0ZXgpOwogCiAJeHNrX3JpbmdfcHJvZF9fc3VibWl0KCZ4c2stPnR4LCBpKTsKLQl4c2stPm91
dHN0YW5kaW5nX3R4ICs9IHZhbGlkX2ZyYWdzOworCXhzay0+b3V0c3RhbmRpbmdfdHggKz0gdmFs
aWRfZnJhZ3MgKyB4c2stPm5iX2V4dHJhX2NxOworCXhzay0+bmJfZXh0cmFfY3EgPSAwOwogCiAJ
aWYgKHVzZV9wb2xsKSB7CiAJCXJldCA9IHBvbGwoJmZkcywgMSwgUE9MTF9UTU9VVCk7CkBAIC0y
MDcwLDMxICsyMDcxLDI1IEBAIGludCB0ZXN0YXBwX2ludmFsaWRfZGVzY19tYihzdHJ1Y3QgdGVz
dF9zcGVjICp0ZXN0KQogCQkvKiBWYWxpZCBwYWNrZXQgZm9yIHN5bmNoIHRvIHN0YXJ0IHdpdGgg
Ki8KIAkJezAsIE1JTl9QS1RfU0laRSwgMCwgdHJ1ZSwgMH0sCiAJCS8qIFplcm8gZnJhbWUgbGVu
IGlzIG5vdCBsZWdhbCAqLwotCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZh
bHNlLCBYRFBfUEtUX0NPTlREfSwKLQkJezAsIFhTS19VTUVNX19MQVJHRV9GUkFNRV9TSVpFLCAw
LCBmYWxzZSwgWERQX1BLVF9DT05URH0sCiAJCXswLCAwLCAwLCBmYWxzZSwgMH0sCi0JCS8qIElu
dmFsaWQgYWRkcmVzcyBpbiB0aGUgc2Vjb25kIGZyYW1lICovCi0JCXswLCBYU0tfVU1FTV9fTEFS
R0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1RfQ09OVER9LAotCQl7dW1lbV9zaXplLCBY
U0tfVU1FTV9fTEFSR0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1RfQ09OVER9LAotCQkv
KiBJbnZhbGlkIGxlbiBpbiB0aGUgbWlkZGxlICovCi0JCXswLCBYU0tfVU1FTV9fTEFSR0VfRlJB
TUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1RfQ09OVER9LAotCQl7MCwgWFNLX1VNRU1fX0lOVkFM
SURfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1RfQ09OVER9LAotCQkvKiBJbnZhbGlkIG9w
dGlvbnMgaW4gdGhlIG1pZGRsZSAqLwotCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUs
IDAsIGZhbHNlLCBYRFBfUEtUX0NPTlREfSwKLQkJezAsIFhTS19VTUVNX19MQVJHRV9GUkFNRV9T
SVpFLCAwLCBmYWxzZSwgWFNLX0RFU0NfX0lOVkFMSURfT1BUSU9OfSwKKwkJLyogSW52YWxpZCBh
ZGRyZXNzICovCisJCXt1bWVtX3NpemUsIFhTS19VTUVNX19MQVJHRV9GUkFNRV9TSVpFLCAwLCBm
YWxzZSwgMH0sCisJCS8qIEludmFsaWQgbGVuICovCisJCXswLCBYU0tfVU1FTV9fSU5WQUxJRF9G
UkFNRV9TSVpFLCAwLCBmYWxzZSwgMH0sCisJCS8qIEludmFsaWQgb3B0aW9ucyAqLworCQl7MCwg
WFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNlLAorCQkgWFNLX0RFU0NfX0lOVkFM
SURfT1BUSU9OICYgflhEUF9QS1RfQ09OVER9LAogCQkvKiBUcmFuc21pdCAyIGZyYWdzLCByZWNl
aXZlIDMgKi8KIAkJezAsIFhTS19VTUVNX19NQVhfRlJBTUVfU0laRSwgMCwgdHJ1ZSwgWERQX1BL
VF9DT05URH0sCiAJCXswLCBYU0tfVU1FTV9fTUFYX0ZSQU1FX1NJWkUsIDAsIHRydWUsIDB9LAot
CQkvKiBNaWRkbGUgZnJhbWUgY3Jvc3NlcyBjaHVuayBib3VuZGFyeSB3aXRoIHNtYWxsIGxlbmd0
aCAqLwotCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNlLCBYRFBfUEtU
X0NPTlREfSwKKwkJLyogU2luZ2xlIGZyYW1lIGNyb3NzZXMgY2h1bmsgYm91bmRhcnkgd2l0aCBz
bWFsbCBsZW5ndGggKi8KIAkJey1NSU5fUEtUX1NJWkUgLyAyLCBNSU5fUEtUX1NJWkUsIDAsIGZh
bHNlLCAwfSwKIAkJLyogVmFsaWQgcGFja2V0IGZvciBzeW5jaCBzbyB0aGF0IHNvbWV0aGluZyBp
cyByZWNlaXZlZCAqLwogCQl7MCwgTUlOX1BLVF9TSVpFLCAwLCB0cnVlLCAwfX07CiAKIAlpZiAo
dW1lbS0+dW5hbGlnbmVkX21vZGUpIHsKIAkJLyogQ3Jvc3NpbmcgYSBjaHVuayBib3VuZGFyeSBh
bGxvd2VkICovCi0JCXBrdHNbMTJdLnZhbGlkID0gdHJ1ZTsKLQkJcGt0c1sxM10udmFsaWQgPSB0
cnVlOworCQlwa3RzWzddLnZhbGlkID0gdHJ1ZTsKIAl9CiAKIAl0ZXN0LT5tdHUgPSBNQVhfRVRI
X0pVTUJPX1NJWkU7CkBAIC0yMjI5LDcgKzIyMjQsNyBAQCBpbnQgdGVzdGFwcF90b29fbWFueV9m
cmFncyhzdHJ1Y3QgdGVzdF9zcGVjICp0ZXN0KQogCQltYXhfZnJhZ3MgKz0gMTsKIAl9CiAKLQlw
a3RzID0gY2FsbG9jKDIgKiBtYXhfZnJhZ3MgKyAyLCBzaXplb2Yoc3RydWN0IHBrdCkpOworCXBr
dHMgPSBjYWxsb2MobWF4X2ZyYWdzICsgMiwgc2l6ZW9mKHN0cnVjdCBwa3QpKTsKIAlpZiAoIXBr
dHMpCiAJCXJldHVybiBURVNUX0ZBSUxVUkU7CiAKQEAgLTIyNDcsMjQgKzIyNDIsMTE2IEBAIGlu
dCB0ZXN0YXBwX3Rvb19tYW55X2ZyYWdzKHN0cnVjdCB0ZXN0X3NwZWMgKnRlc3QpCiAJfQogCXBr
dHNbbWF4X2ZyYWdzXS5vcHRpb25zID0gMDsKIAotCS8qIEFuIGludmFsaWQgcGFja2V0IHdpdGgg
dGhlIG1heCBhbW91bnQgb2YgZnJhZ3MgYnV0IHNpZ25hbHMgcGFja2V0Ci0JICogY29udGludWVz
IG9uIHRoZSBsYXN0IGZyYWcKKwkvKiBWYWxpZCBwYWNrZXQgZm9yIHN5bmNoICovCisJcGt0c1tt
YXhfZnJhZ3MgKyAxXS5sZW4gPSBNSU5fUEtUX1NJWkU7CisJcGt0c1ttYXhfZnJhZ3MgKyAxXS52
YWxpZCA9IHRydWU7CisKKwlpZiAocGt0X3N0cmVhbV9nZW5lcmF0ZV9jdXN0b20odGVzdCwgcGt0
cywgbWF4X2ZyYWdzICsgMikpIHsKKwkJZnJlZShwa3RzKTsKKwkJcmV0dXJuIFRFU1RfRkFJTFVS
RTsKKwl9CisKKwlyZXQgPSB0ZXN0YXBwX3ZhbGlkYXRlX3RyYWZmaWModGVzdCk7CisJZnJlZShw
a3RzKTsKKwlyZXR1cm4gcmV0OworfQorCitpbnQgdGVzdGFwcF9kcmFpbl9jb250KHN0cnVjdCB0
ZXN0X3NwZWMgKnRlc3QpCit7CisJc3RydWN0IHBrdCBwa3RzW10gPSB7CisJCS8qIFZhbGlkIHBh
Y2tldCBmb3Igc3luYyAqLworCQl7MCwgTUlOX1BLVF9TSVpFLCAwLCB0cnVlLCAwfSwKKwkJLyog
S2VybmVsLXZhbGlkIGZpcnN0IGZyYWc6IGJ1aWxkcyBwYXJ0aWFsIFNLQiAqLworCQl7MCwgWFNL
X1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNlLCBYRFBfUEtUX0NPTlREfSwKKwkJLyog
S2VybmVsLWludmFsaWQgKGxlbj0wKSB3aXRoIENPTlREOiBhcm1zIGRyYWluX2NvbnQgKi8KKwkJ
ezAsIDAsIDAsIGZhbHNlLCBYRFBfUEtUX0NPTlREfSwKKwkJLyogRHJhaW5lZCBieSBkcmFpbl9j
b250LCBDT05URCBrZWVwcyBkcmFpbmluZyAqLworCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1F
X1NJWkUsIDAsIGZhbHNlLCBYRFBfUEtUX0NPTlREfSwKKwkJLyogRHJhaW5lZCBieSBkcmFpbl9j
b250LCBubyBDT05URCBlbmRzIGRyYWluaW5nICovCisJCXswLCBYU0tfVU1FTV9fTEFSR0VfRlJB
TUVfU0laRSwgMCwgZmFsc2UsIDB9LAorCQkvKiBWYWxpZCBwYWNrZXQgZm9yIHN5bmMgKi8KKwkJ
ezAsIE1JTl9QS1RfU0laRSwgMCwgdHJ1ZSwgMH0sCisJfTsKKworCWlmICh0ZXN0LT5tb2RlID09
IFRFU1RfTU9ERV9aQykgeworCQlrc2Z0X3ByaW50X21zZygiQ2FuIG5vdCBydW4gRFJBSU5fQ09O
VCB0ZXN0IGZvciBaQyBtb2RlXG4iKTsKKwkJcmV0dXJuIFRFU1RfU0tJUDsKKwl9CisKKwl0ZXN0
LT5tdHUgPSBNQVhfRVRIX0pVTUJPX1NJWkU7CisJaWYgKHBrdF9zdHJlYW1fZ2VuZXJhdGVfY3Vz
dG9tKHRlc3QsIHBrdHMsIEFSUkFZX1NJWkUocGt0cykpKQorCQlyZXR1cm4gVEVTVF9GQUlMVVJF
OworCisJLyogMSBDUSBmcm9tIHhza19kcm9wX3NrYiAocGFydGlhbCBTS0IpICsgMiBDUSBmcm9t
IGRyYWluX2NvbnQgKi8KKwl0ZXN0LT5pZm9ial90eC0+eHNrLT5uYl9leHRyYV9jcSA9IDM7CisK
KwlyZXR1cm4gdGVzdGFwcF92YWxpZGF0ZV90cmFmZmljKHRlc3QpOworfQorCitpbnQgdGVzdGFw
cF9lb3ZlcmZsb3dfZHJhaW5fY29udChzdHJ1Y3QgdGVzdF9zcGVjICp0ZXN0KQoreworCXN0cnVj
dCBpZm9iamVjdCAqaWZvYmpfdHggPSB0ZXN0LT5pZm9ial90eDsKKwl1MzIgbWF4X3NrYl9mcmFn
czsKKwlzdHJ1Y3QgcGt0ICpwa3RzOworCXUzMiBuYl9wa3RzLCBpOworCWludCByZXQ7CisKKwlp
ZiAodGVzdC0+bW9kZSA9PSBURVNUX01PREVfWkMpIHsKKwkJa3NmdF9wcmludF9tc2coIkNhbiBu
b3QgcnVuIEVPVkVSRkxPV19EUkFJTl9DT05UIHRlc3QgZm9yIFpDIG1vZGVcbiIpOworCQlyZXR1
cm4gVEVTVF9TS0lQOworCX0KKworCW1heF9za2JfZnJhZ3MgPSBpZm9ial90eC0+bWF4X3NrYl9m
cmFnczsKKworCS8qCisJICogTGF5b3V0IChsZXQgTiA9IG1heF9za2JfZnJhZ3MsIDE3IGFzIGRl
ZmF1bHQpOgorCSAqCisJICogICBwa3RzWzBdICAgICAgICAgICAgOiB2YWxpZCBzeW5jIHBhY2tl
dC4KKwkgKiAgIHBrdHNbMS4uTisxXSAgICAgICA6IE4rMSBDT05URCBmcmFncyBmb3JtaW5nIGEg
bXVsdGktYnVmZmVyCisJICogICAgICAgICAgICAgICAgICAgICAgICBjaGFpbiB0aGF0IG92ZXJy
dW5zIE1BWF9TS0JfRlJBR1MuIFRoZQorCSAqICAgICAgICAgICAgICAgICAgICAgICAgbGFzdCBm
cmFnIHRyaWdnZXJzIC1FT1ZFUkZMT1cgaW4KKwkgKiAgICAgICAgICAgICAgICAgICAgICAgIHhz
a19idWlsZF9za2IoKTsgeHNrX2Ryb3Bfc2tiKCkgdGhlbgorCSAqICAgICAgICAgICAgICAgICAg
ICAgICAgcHVibGlzaGVzIE4rMSBhY2N1bXVsYXRlZCBVTUVNCisJICogICAgICAgICAgICAgICAg
ICAgICAgICBhZGRyZXNzZXMgdG8gdGhlIENRIHZpYSB0aGUgU0tCCisJICogICAgICAgICAgICAg
ICAgICAgICAgICBkZXN0cnVjdG9yIGFuZCBhcm1zIGRyYWluX2NvbnQuCisJICogICBwa3RzW04r
Mi4uTiszXSAgICAgOiAyIENPTlREIGZyYWdzIGNvbnN1bWVkIGJ5IGRyYWluX2NvbnQncworCSAq
ICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGUtdG8tQ1EgYnJhbmNoIG9uIHRoZSBuZXh0IHNl
bmR0bygpLgorCSAqICAgcGt0c1tOKzRdICAgICAgICAgIDogIUNPTlREIGZyYWcgdGhhdCBjbG9z
ZXMgZHJhaW5fY29udAorCSAqICAgICAgICAgICAgICAgICAgICAgICAgKHhwX21iX2Rlc2MoJmRl
c2MpIGJlY29tZXMgZmFsc2UpLgorCSAqICAgcGt0c1tOKzVdICAgICAgICAgIDogdmFsaWQgc3lu
YyBwYWNrZXQsIHNlbnQgbm9ybWFsbHkgdG8KKwkgKiAgICAgICAgICAgICAgICAgICAgICAgIGNv
bmZpcm0gdGhhdCB0aGUgc29ja2V0IHJlY292ZXJlZCBhbmQKKwkgKiAgICAgICAgICAgICAgICAg
ICAgICAgIGRyYWluX2NvbnQgaXMgbm8gbG9uZ2VyIGFjdGl2ZS4KIAkgKi8KLQlmb3IgKGkgPSBt
YXhfZnJhZ3MgKyAxOyBpIDwgMiAqIG1heF9mcmFncyArIDE7IGkrKykgeworCW5iX3BrdHMgPSBt
YXhfc2tiX2ZyYWdzICsgNjsKKwlwa3RzID0gY2FsbG9jKG5iX3BrdHMsIHNpemVvZihzdHJ1Y3Qg
cGt0KSk7CisJaWYgKCFwa3RzKQorCQlyZXR1cm4gVEVTVF9GQUlMVVJFOworCisJdGVzdC0+bXR1
ID0gTUFYX0VUSF9KVU1CT19TSVpFOworCisJcGt0c1swXS5sZW4gPSBNSU5fUEtUX1NJWkU7CisJ
cGt0c1swXS52YWxpZCA9IHRydWU7CisKKwlmb3IgKGkgPSAxOyBpIDw9IG1heF9za2JfZnJhZ3Mg
KyA0OyBpKyspIHsKIAkJcGt0c1tpXS5sZW4gPSBNSU5fUEtUX1NJWkU7CiAJCXBrdHNbaV0ub3B0
aW9ucyA9IFhEUF9QS1RfQ09OVEQ7CiAJCXBrdHNbaV0udmFsaWQgPSBmYWxzZTsKIAl9CisJcGt0
c1ttYXhfc2tiX2ZyYWdzICsgNF0ub3B0aW9ucyA9IDA7CiAKLQkvKiBWYWxpZCBwYWNrZXQgZm9y
IHN5bmNoICovCi0JcGt0c1syICogbWF4X2ZyYWdzICsgMV0ubGVuID0gTUlOX1BLVF9TSVpFOwot
CXBrdHNbMiAqIG1heF9mcmFncyArIDFdLnZhbGlkID0gdHJ1ZTsKKwlwa3RzW21heF9za2JfZnJh
Z3MgKyA1XS5sZW4gPSBNSU5fUEtUX1NJWkU7CisJcGt0c1ttYXhfc2tiX2ZyYWdzICsgNV0udmFs
aWQgPSB0cnVlOwogCi0JaWYgKHBrdF9zdHJlYW1fZ2VuZXJhdGVfY3VzdG9tKHRlc3QsIHBrdHMs
IDIgKiBtYXhfZnJhZ3MgKyAyKSkgeworCWlmIChwa3Rfc3RyZWFtX2dlbmVyYXRlX2N1c3RvbSh0
ZXN0LCBwa3RzLCBuYl9wa3RzKSkgewogCQlmcmVlKHBrdHMpOwogCQlyZXR1cm4gVEVTVF9GQUlM
VVJFOwogCX0KIAorCS8qIChtYXhfc2tiX2ZyYWdzICsgMSkgQ1EgZnJvbSB4c2tfZHJvcF9za2Ig
b24gRU9WRVJGTE9XIGFuZAorCSAqIDMgZnJvbSBkcmFpbl9jb250LgorCSAqLworCWlmb2JqX3R4
LT54c2stPm5iX2V4dHJhX2NxID0gbWF4X3NrYl9mcmFncyArIDQ7CisKIAlyZXQgPSB0ZXN0YXBw
X3ZhbGlkYXRlX3RyYWZmaWModGVzdCk7CiAJZnJlZShwa3RzKTsKIAlyZXR1cm4gcmV0OwpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2su
aCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfeHNrLmgKaW5k
ZXggMWFiOGFlZTRjZTU2Li4yZTY0ODhlMDQ1MmIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfeHNrLmgKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF94c2suaApAQCAtODcsNiArODcsNyBAQCBzdHJ1
Y3QgeHNrX3NvY2tldF9pbmZvIHsKIAlzdHJ1Y3QgeHNrX3NvY2tldCAqeHNrOwogCXN0cnVjdCBw
a3Rfc3RyZWFtICpwa3Rfc3RyZWFtOwogCXUzMiBvdXRzdGFuZGluZ190eDsKKwl1MzIgbmJfZXh0
cmFfY3E7CiAJdTMyIHJ4cXNpemU7CiAJdTMyIGJhdGNoX3NpemU7CiAJdTggZHN0X21hY1tFVEhf
QUxFTl07CkBAIC0yMzcsNiArMjM4LDggQEAgaW50IHRlc3RhcHBfYWxpZ25lZF9pbnZfZGVzYyhz
dHJ1Y3QgdGVzdF9zcGVjICp0ZXN0KTsKIGludCB0ZXN0YXBwX2FsaWduZWRfaW52X2Rlc2NfMmtf
ZnJhbWUoc3RydWN0IHRlc3Rfc3BlYyAqdGVzdCk7CiBpbnQgdGVzdGFwcF9hbGlnbmVkX2ludl9k
ZXNjX21iKHN0cnVjdCB0ZXN0X3NwZWMgKnRlc3QpOwogaW50IHRlc3RhcHBfYmlkaXJlY3Rpb25h
bChzdHJ1Y3QgdGVzdF9zcGVjICp0ZXN0KTsKK2ludCB0ZXN0YXBwX2RyYWluX2NvbnQoc3RydWN0
IHRlc3Rfc3BlYyAqdGVzdCk7CitpbnQgdGVzdGFwcF9lb3ZlcmZsb3dfZHJhaW5fY29udChzdHJ1
Y3QgdGVzdF9zcGVjICp0ZXN0KTsKIGludCB0ZXN0YXBwX2hlYWRyb29tKHN0cnVjdCB0ZXN0X3Nw
ZWMgKnRlc3QpOwogaW50IHRlc3RhcHBfaHdfc3dfbWF4X3Jpbmdfc2l6ZShzdHJ1Y3QgdGVzdF9z
cGVjICp0ZXN0KTsKIGludCB0ZXN0YXBwX2h3X3N3X21pbl9yaW5nX3NpemUoc3RydWN0IHRlc3Rf
c3BlYyAqdGVzdCk7CkBAIC0yOTIsNiArMjk1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZXN0
X3NwZWMgdGVzdHNbXSA9IHsKIAl7Lm5hbWUgPSAiWERQX01FVEFEQVRBX0NPUFlfTVVMVElfQlVG
RiIsIC50ZXN0X2Z1bmMgPSB0ZXN0YXBwX3hkcF9tZXRhZGF0YV9tYn0sCiAJey5uYW1lID0gIkFM
SUdORURfSU5WX0RFU0NfTVVMVElfQlVGRiIsIC50ZXN0X2Z1bmMgPSB0ZXN0YXBwX2FsaWduZWRf
aW52X2Rlc2NfbWJ9LAogCXsubmFtZSA9ICJUT09fTUFOWV9GUkFHUyIsIC50ZXN0X2Z1bmMgPSB0
ZXN0YXBwX3Rvb19tYW55X2ZyYWdzfSwKKwl7Lm5hbWUgPSAiRFJBSU5fQ09OVCIsIC50ZXN0X2Z1
bmMgPSB0ZXN0YXBwX2RyYWluX2NvbnR9LAorCXsubmFtZSA9ICJFT1ZFUkZMT1dfRFJBSU5fQ09O
VCIsIC50ZXN0X2Z1bmMgPSB0ZXN0YXBwX2VvdmVyZmxvd19kcmFpbl9jb250fSwKIAl7Lm5hbWUg
PSAiWERQX0FESlVTVF9UQUlMX1NIUklOSyIsIC50ZXN0X2Z1bmMgPSB0ZXN0YXBwX2FkanVzdF90
YWlsX3Nocmlua30sCiAJey5uYW1lID0gIlRYX1FVRVVFX0NPTlNVTUVSIiwgLnRlc3RfZnVuYyA9
IHRlc3RhcHBfdHhfcXVldWVfY29uc3VtZXJ9LAogCX07Ci0tIAoyLjQzLjcKCg==
--00000000000093abf30652684be0--

